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
  Request,
  requestBody,
  response,
  Response,
  RestBindings
} from '@loopback/rest';
import fs from 'fs/promises';
import {promisify} from 'util';
import {Post} from '../models';
import {PostRepository} from '../repositories';
//import {PostService} from '../services/post-service';
import {processSingleFileUpload} from '../utils/file-upload.helper';


const writeFile = promisify(fs.writeFile);


export class PostControllerController {
  constructor(
    @repository(PostRepository)
    public postRepository : PostRepository,
    // @inject('services.PostService') //
    // private postService: PostService,
  ) {}

  // file uplaod and post creation
  @post('/posts')
  @response(200, {
    description: 'Post model instance with image',
    content: {'application/json': {schema: getModelSchemaRef(Post)}},
  })
  async create(
    @requestBody({
      content: {
        'multipart/form-data': {
          'x-parser': 'stream',
         schema: {
          type: 'object',
          properties: {
            petName: {type:'string'},
            fee: {type: 'number'},
            gender: {type: 'string'},
            petType: {type: 'string'},
            petBreed: {type: 'string'},
            birthday: {type: 'string', format: 'date'},
            description: {type: 'string'},
            location: {type: 'string'},
            hasPhoto: {type: 'boolean'},
            photo: {type: 'string', format: 'binary'},
            userId: {type: 'string'}
          }
         }
        },
      },
    })
    request: Request,
    @inject(RestBindings.Http.RESPONSE) response: Response,
   // @inject(RestBindings.Http.REQUEST) httpRequest: Request
  ): Promise<Post> {

    //const userId = httpRequest.user.id;

try{
       // Process file upload (if any)
       const photoUrl = await processSingleFileUpload(request, response, {
        fieldName: 'photo',
        uploadFolder: '../../uploads',
        filenamePrefix: 'postphoto',
      });

      console.log('Uploaded photo URL:', photoUrl);

      const { petName, fee, gender, petType, petBreed, birthday, description, location, hasPhoto, userId } = request.body;

      // Validate required fields
      if (!petName || !fee || !gender || !petType || !petBreed || !birthday || !description || !location) {
        throw new Error('Missing required fields');
      }

      const finalPhotoUrl = photoUrl || '';
      console.log('Final photo URL:', finalPhotoUrl);

// Now use PostService to create the post and save the photo URL
  // Create the post using PostRepository directly
  const newPost = await this.postRepository.create({
    petName,
    fee,
    gender,
    petType,
    petBreed,
    birthday,
    description,
    location,
    hasPhoto: hasPhoto === 'true', // Ensure boolean conversion
    photo: finalPhotoUrl, // Pass the photo URL here
    status: 'active', // Default status
    createdAt: new Date().toISOString(),
    userId // Automatically set createdAt to current date
  });




      return newPost;
    } catch (error) {
      // Handle errors as appropriate
      throw error;
    }
  }


  @get('/posts/count')
  @response(200, {
    description: 'Post model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(Post) where?: Where<Post>,
  ): Promise<Count> {
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
