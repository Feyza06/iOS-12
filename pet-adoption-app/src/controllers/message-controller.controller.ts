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


export class MessageControllerController {
  constructor(
    @repository(MessageRepository)
    public messageRepository: MessageRepository,
  ) {}

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
  @response(200, {
    description: 'Array of messages exchanged between two users',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Message),
        },
      },
    },
  })
  async findMessagesBetweenUsers(
    @param.query.string('senderId') senderId: string,
    @param.query.string('recipientId') recipientId: string,
  ): Promise<Message[]> {
    return this.messageRepository.find({
      where: {
        or: [
          {and: [{senderId: senderId}, {recipientId: recipientId}]},
          {and: [{senderId: recipientId}, {recipientId: senderId}]},
        ],
      },
      order: ['createdAt ASC'], // Sort messages by timestamp
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
