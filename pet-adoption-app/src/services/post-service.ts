
import {injectable, /* inject other things as needed */} from '@loopback/core';
import {repository} from '@loopback/repository';
import {PostRepository} from '../repositories';

@injectable()
export class PostService {
  constructor(
    @repository(PostRepository)
    public postRepository: PostRepository,
  ) {}





}
