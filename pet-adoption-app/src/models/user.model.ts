import {Entity, hasMany, model, property} from '@loopback/repository';
import {Post} from './post.model';

@model({settings: {strict: false}})
export class User extends Entity {
  @property({
    type: 'number',
    id: true,
    generated: true,
  })
  id: number;

  @property({
    type: 'string',
    required: true,
  })
  username: string;

  @property({
    type: 'string',
    required: true,
  })
  email: string;

  @property({
    type: 'string',
    required: true,
  })
  password: string;

  @property({
    type: 'string',
    required: true,
  })
  firstName: string;

  @property({
    type: 'string',
  })
  lastName: string;

  @property({
    type: 'string',
    required: false,
  })
  photo: string;

  @hasMany(() => Post, {keyTo: 'userId'})
  post: Post[];

  // @hasMany(() => Like)
  // likes: Like[];

  // @hasMany(() => Notification)
  // notifications: Notification[];

  // @hasMany(() => Message)
  // messages: Message[];

  // Define well-known properties here

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  [prop: string]: any;

  constructor(data?: Partial<User>) {
    super(data);
  }
}

export interface UserRelations {
  // describe navigational properties here
}

export type UserWithRelations = User & UserRelations;
