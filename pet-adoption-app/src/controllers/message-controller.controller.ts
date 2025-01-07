import {
  repository,
  Count,
  CountSchema,
  Filter,
  Where,
  FilterExcludingWhere,
} from '@loopback/repository';
import {
  post,
  param,
  get,
  patch,
  put,
  del,
  requestBody,
  response,
} from '@loopback/rest';
import {Message} from '../models';
import {MessageRepository} from '../repositories';
import {getModelSchemaRef} from '@loopback/rest';
import {UserRepository} from '../repositories'; // We need to fetch "other user" info
import {User} from '../models';


export class MessageControllerController {
  constructor(
    @repository(MessageRepository)
    public messageRepository: MessageRepository,

    @repository(UserRepository)
    public userRepository: UserRepository,
  ) {}

  // ---------------------------------------
// Get a list of unique conversation partners
// for the given user, along with the last message
// ---------------------------------------
  @get('/messages/conversations/{userId}')
  @response(200, {
    description: 'Unique conversation partners for the specified user, plus last message',
    content: {'application/json': {schema: {type: 'array'}}},
  })
  async getConversations(
      @param.path.number('userId') userId: number
  ): Promise<Array<{
    userId: number;
    username: string;
    lastMessage: string;
    createdAt: string;
    photo: string | null;
    postId: string | number | undefined;
  }>> {
    // 1) Fetch all messages where this user is either sender or recipient
    const messages = await this.messageRepository.find({
      where: {
        or: [{senderId: userId}, {recipientId: userId}],
      },
      order: ['createdAt DESC'], // Most recent messages first
    });

    // 2) Group them by "other user" (the person we chatted with)
    //    - If current user is the sender, then "other user" = recipientId
    //    - If current user is the recipient, then "other user" = senderId
    const conversationMap = new Map<number, Message>();
    for (const msg of messages) {
      // The other person's ID:
      const otherId =
          msg.senderId === String(userId)
              ? parseInt(msg.recipientId, 10)
              : parseInt(msg.senderId, 10);

      // We only store the first message we see (which is the latest, due to sorting)
      // so it becomes the "last message" in the conversation
      if (!conversationMap.has(otherId)) {
        conversationMap.set(otherId, msg);
      }
    }

    // 3) Now conversationMap has unique user -> last message
    //    Let's assemble an array with user details
    const results = [];
    for (const [otherUserId, lastMessage] of conversationMap.entries()) {
      try {
        // Attempt to find the "other user" in the user repository
        const otherUser = await this.userRepository.findById(otherUserId);

        results.push({
          userId: otherUserId,
          username: otherUser.username,
          lastMessage: lastMessage.content,
          createdAt: lastMessage.createdAt,
          photo: otherUser.photo,
          postId: lastMessage.postId,
        });
      } catch (error) {
        // If the user can't be found, skip or handle accordingly
        // Here we skip that conversation
        console.error(
            `Could not find user with ID ${otherUserId} in conversation: ${error}`
        );
      }
    }

    return results;
  }

  // Create a new message
  @post('/messages')
  @response(200, {
    description: 'Message model instance',
    content: {'application/json': {schema: getModelSchemaRef(Message)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Message, {
            title: 'NewMessage',
            exclude: ['id'], // Exclude 'id' since it is auto-generated
          }),
        },
      },
    })
    message: Omit<Message, 'id'>,
  ): Promise<Message> {
    message.createdAt = new Date().toISOString(); // Automatically set the timestamp
    return this.messageRepository.create(message);
  }

  // Get the count of all messages
  @get('/messages/count')
  @response(200, {
    description: 'Message model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(Message) where?: Where<Message>,
  ): Promise<Count> {
    return this.messageRepository.count(where);
  }

  // Fetch all messages
  @get('/messages')
  @response(200, {
    description: 'Array of Message model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Message, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(Message) filter?: Filter<Message>,
  ): Promise<Message[]> {
    return this.messageRepository.find(filter);
  }

  // Fetch messages between two users (dynamic user ID handling)
  @get('/messages/between')
  async findMessagesBetween(
      @param.query.string('senderId') senderId: string,
      @param.query.string('recipientId') recipientId: string,
      @param.query.string('postId') postId: string, // new param
  ): Promise<Message[]> {
    return this.messageRepository.find({
      where: {
        and: [
          {postId: postId},
          {
            or: [
              {and: [{senderId: senderId}, {recipientId: recipientId}]},
              {and: [{senderId: recipientId}, {recipientId: senderId}]}
            ]
          }
        ]
      },
      order: ['createdAt ASC'], // Show oldest to newest
    });
  }

  // Update all messages (bulk update)
  @patch('/messages')
  @response(200, {
    description: 'Message PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Message, {partial: true}),
        },
      },
    })
    message: Message,
    @param.where(Message) where?: Where<Message>,
  ): Promise<Count> {
    return this.messageRepository.updateAll(message, where);
  }

  // Fetch a message by ID
  @get('/messages/{id}')
  @response(200, {
    description: 'Message model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Message, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(Message, {exclude: 'where'}) filter?: FilterExcludingWhere<Message>,
  ): Promise<Message> {
    return this.messageRepository.findById(id, filter);
  }

  // Update a specific message by ID
  @patch('/messages/{id}')
  @response(204, {
    description: 'Message PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Message, {partial: true}),
        },
      },
    })
    message: Message,
  ): Promise<void> {
    await this.messageRepository.updateById(id, message);
  }

  // Replace a specific message by ID
  @put('/messages/{id}')
  @response(204, {
    description: 'Message PUT success',
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() message: Message,
  ): Promise<void> {
    await this.messageRepository.replaceById(id, message);
  }

  // Delete a specific message by ID
  @del('/messages/{id}')
  @response(204, {
    description: 'Message DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.messageRepository.deleteById(id);
  }
}
