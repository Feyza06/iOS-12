import {authenticate} from '@loopback/authentication';
import {inject} from '@loopback/core';
import {
  Count,
  CountSchema,
  Filter,
  FilterExcludingWhere,
  repository,
  Where,
} from '@loopback/repository';
import {
  del,
  get,
  getModelSchemaRef,
  param,
  patch,
  post,
  put,
  requestBody,
  response,
} from '@loopback/rest';
import {SecurityBindings, UserProfile} from '@loopback/security';
import {Post} from '../models';
import {PostRepository} from '../repositories';



export class PostControllerController {
  constructor(
    @repository(PostRepository)
    public postRepository : PostRepository,
    @inject(SecurityBindings.USER)
    private currentUser: UserProfile
  ) {}

  @authenticate('jwt')
  @post('/posts')
  @response(200, {
    description: 'Post model instance',
    content: {'application/json': {schema: {'x-ts-type': Post}}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: {
            type: 'object',
            properties: {
              petName: {type: 'string'},
              fee: {type: 'number'},
              gender: {type: 'string'},
              petType: {type: 'string'},
              petBreed: {type: 'string'},
              birthday: {type: 'string', format: 'date'},
              description: {type: 'string'},
              location: {type: 'string'},
              photo: {type: 'boolean'},
            },
            required: ['petName', 'fee', 'gender', 'petType', 'petBreed', 'birthday', 'description', 'location', 'photo'],
          },
        },
      },
    })
    post: Omit<Post, 'id' | 'userId' | 'createdAt' | 'status'>,
  ): Promise<Post> {
    // automatically assign fields
    const userId = this.currentUser.id;
    const createdAt = new Date();
    const status = 'available';

    const newPost = new Post({
      ...post,
      userId,
      createdAt,
      status,
    }

    )
    return this.postRepository.create(newPost);
  }



  @get('/posts/count')
  @response(200, {
    description: 'Post model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(Post) where?: Where<Post>,
  ): Promise<Count> {
    // Populate excluded fields
  const populatedPost = {
    ...post,
    userId: this.currentUser.id, // Example function to fetch the logged-in user
    createdAt: new Date().toISOString(),
    status: 'pending', // Default status
  };
    return this.postRepository.count(where);
  }

  @get('/posts')
  @response(200, {
    description: 'Array of Post model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Post, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(Post) filter?: Filter<Post>,
  ): Promise<Post[]> {
    return this.postRepository.find(filter);
  }

  @patch('/posts')
  @response(200, {
    description: 'Post PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Post, {partial: true}),
        },
      },
    })
    post: Post,
    @param.where(Post) where?: Where<Post>,
  ): Promise<Count> {
    return this.postRepository.updateAll(post, where);
  }

  @get('/posts/{id}')
  @response(200, {
    description: 'Post model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Post, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(Post, {exclude: 'where'}) filter?: FilterExcludingWhere<Post>
  ): Promise<Post> {
    return this.postRepository.findById(id, filter);
  }

  @patch('/posts/{id}')
  @response(204, {
    description: 'Post PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Post, {partial: true}),
        },
      },
    })
    post: Post,
  ): Promise<void> {
    await this.postRepository.updateById(id, post);
  }

  @put('/posts/{id}')
  @response(204, {
    description: 'Post PUT success',
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() post: Post,
  ): Promise<void> {
    await this.postRepository.replaceById(id, post);
  }

  @del('/posts/{id}')
  @response(204, {
    description: 'Post DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.postRepository.deleteById(id);
  }
}
