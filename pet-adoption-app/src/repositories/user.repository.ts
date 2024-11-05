import {inject} from '@loopback/core';
import {DefaultCrudRepository, HasManyRepositoryFactory, repository} from '@loopback/repository';
import {DbDataSource} from '../datasources';
import {User, UserRelations} from '../models';

import {Getter} from '@loopback/core'; // type used for creating getteres for dependencies that are also injected
import {Post} from '../models';


import {PostRepository} from './post.repository';


export class UserRepository extends DefaultCrudRepository<
  User,
  typeof User.prototype.id,
  UserRelations
> {

  // Properties that define HasMany relationships for each of the models
  public readonly posts: HasManyRepositoryFactory<Post, typeof User.prototype.id>
  //public readonly likes: HasManyRepositoryFactory<Like, typeof User.prototype.id>;
  //public readonly notifications: HasManyRepositoryFactory<Notification, typeof User.prototype.id>;
  //public readonly messages: HasManyRepositoryFactory<Message, typeof User.prototype.id>;


  constructor(
    // datasource, injected , allowing the repository to connect to the database
    @inject('datasources.db') dataSource: DbDataSource,
    @repository.getter('PostRepository') protected postRepositoryGetter: Getter<PostRepository>,
   // @repository.getter('LikeRepository') protected likeRepositoryGetter: Getter<LikeRepository>,
    //@repository.getter('NotificationRepository') protected notificationRepositoryGetter: Getter<NotificationRepository>,
    //@repository.getter('MessageRepository') protected messageRepositoryGetter: Getter<MessageRepository>,
  ) {
    super(User, dataSource);
    this.posts = this.createHasManyRepositoryFactoryFor('post', postRepositoryGetter);
   // this.likes = this.createHasManyRepositoryFactoryFor('likes', likeRepositoryGetter);
    //this.notifications = this.createHasManyRepositoryFactoryFor('notifications', notificationRepositoryGetter);
   // this.messages = this.createHasManyRepositoryFactoryFor('messages', messageRepositoryGetter);

    this.registerInclusionResolver('posts', this.posts.inclusionResolver);
   //this.registerInclusionResolver('likes', this.likes.inclusionResolver);
    //this.registerInclusionResolver('notifications', this.notifications.inclusionResolver);
   // this.registerInclusionResolver('messages', this.messages.inclusionResolver);


  }
}
