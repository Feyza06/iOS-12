
import {injectable, /* inject other things as needed */} from '@loopback/core';
import {repository} from '@loopback/repository';
import {PostRepository} from '../repositories';

@injectable()
export class PostService {
  constructor(
    @repository(PostRepository)
    public postRepository: PostRepository,
  ) {}


// // This method will create a new post
// async savePost(postData: {
//   petName: string;
//   fee: number;
//   gender: string;
//   petType: string;
//   petBreed: string;
//   birthday: string;
//   description: string;
//   location: string;
//   hasPhoto: boolean;
//   photo: string; // photoUrl will be passed from the controller
// }): Promise<Post> {
//   const { petName, fee, gender, petType, petBreed, birthday, description, location, hasPhoto, photo } = postData;

//   // Create the post using the postRepository
//   const newPost = await this.postRepository.create({
//     ...postData,
//     status: 'active', // Default status
//     createdAt: new Date().toISOString(), // Automatically set createdAt to current date
//   });

//   return newPost;
// }


}
