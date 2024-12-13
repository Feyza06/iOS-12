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
  put, Request,
  requestBody, Response,
  response, RestBindings,
} from '@loopback/rest';
import {User} from '../models';
import {UserRepository} from '../repositories';
import {UserServiceService} from '../services'; // Import UserServiceService
import {inject} from '@loopback/core';
import {authenticate} from "@loopback/authentication";
import {promisify} from 'util';
import * as fs from 'fs';
import * as path from 'path';
import multer from 'multer';
import {processSingleFileUpload} from '../utils/file-upload.helper';

const writeFile = promisify(fs.writeFile);

export class UserControllerController {
  constructor(
      @repository(UserRepository)
      public userRepository: UserRepository,
      @inject('services.UserServiceService') // Inject UserServiceService
      private userService: UserServiceService,
  ) {}

  @post('/users')
  @response(200, {
    description: 'User model instance',
    content: {'application/json': {schema: getModelSchemaRef(User)}},
  })
  async create(
      @requestBody({
        description: 'User registration',
        required: true,
        content: {
          'multipart/form-data': {
            'x-parser': 'stream',
            schema: {
              type: 'object',
              properties: {
                firstName: {type: 'string'},
                lastName: {type: 'string'},
                username: {type: 'string'},
                email: {type: 'string'},
                password: {type: 'string'},
                photo: {type: 'string', format: 'binary'},
              },
            },
          },
        },
      }) request: Request,
      @inject(RestBindings.Http.RESPONSE) response: Response,
  ): Promise<User> {
    try {
      // Process file upload (if any)
      const photoUrl = await processSingleFileUpload(request, response, {
        fieldName: 'photo',
        uploadFolder: '../../uploads',
        filenamePrefix: 'userphoto',
      });

      const { firstName, lastName, username, email, password } = request.body;

      // Validate required fields
      if (!firstName || !lastName || !username || !email || !password) {
        throw new Error('Missing required fields');
      }

      // Now register the user with the optional photoUrl
      const newUser = await this.userService.register({
        firstName,
        lastName,
        username,
        email,
        password,
        photo: photoUrl,
      });

      return newUser;
    } catch (error) {
      // Handle errors as appropriate
      throw error;
    }
  }

  @post('/login')
  @response(200, {
    description: 'User login',
    content: {
      'application/json': {
        schema: {
          type: 'object',
          properties: {
            token: {type: 'string'},
            user: getModelSchemaRef(User),
          },
        },
      },
    },
  })
  async login(
      @requestBody({
        content: {
          'application/json': {
            schema: {
              type: 'object',
              properties: {
                email: {type: 'string'},
                password: {type: 'string'},
              },
              required: ['email', 'password'],
            },
          },
        },
      })
          credentials: {email: string; password: string},
  ): Promise<{ token: string; user: User }> {
    return this.userService.login(credentials.email, credentials.password);
  }

  @get('/users/count')
  @response(200, {
    description: 'User model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(User) where?: Where<User>,
  ): Promise<Count> {
    return this.userRepository.count(where);
  }

  @get('/users')
  @response(200, {
    description: 'Array of User model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(User, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(User) filter?: Filter<User>,
  ): Promise<User[]> {
    return this.userRepository.find(filter);
  }

  @patch('/users')
  @response(200, {
    description: 'User PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(User, {partial: true}),
        },
      },
    })
    user: User,
    @param.where(User) where?: Where<User>,
  ): Promise<Count> {
    return this.userRepository.updateAll(user, where);
  }

  @authenticate('jwt')
  @get('/users/{id}')
  @response(200, {
    description: 'User model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(User, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(User, {exclude: 'where'}) filter?: FilterExcludingWhere<User>
  ): Promise<User> {
    return this.userRepository.findById(id, filter);
  }

  @patch('/users/{id}')
  @response(204, {
    description: 'User PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(User, {partial: true}),
        },
      },
    })
    user: User,
  ): Promise<void> {
    await this.userRepository.updateById(id, user);
  }

  @put('/users/{id}')
  @response(204, {
    description: 'User PUT success',
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() user: User,
  ): Promise<void> {
    await this.userRepository.replaceById(id, user);
  }

  @del('/users/{id}')
  @response(204, {
    description: 'User DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.userRepository.deleteById(id);
  }
}
