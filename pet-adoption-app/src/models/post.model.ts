import {belongsTo, Entity, model, property} from '@loopback/repository';
import {User} from './user.model';

@model({settings: {strict: false}})
export class Post extends Entity {
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
  petName: string;

  @property({
    type: 'number',
    required: true
  })
  fee: number;

  @property({
    type: 'string',
    required: true,
  })
  gender: string;

  @property({
    type: 'string',
    required: true,
  })
  petType: string;

  @property({
    type: 'string',
    required: true,
  })
  petBreed: string;

  @property({
    type: 'date',
    required: true,
  })
  birthday: string;

  @property({
    type: 'string',
    required: true,
  })
  size: string;


  @property({
    type: 'string',
    required: true,
  })
  description: string;

  @property({
    type: 'string',
    required: true,
  })
  preferredHome: string;

  @property({
    type: 'date',
    required: true,
  })
  location: string;

  @property({
    type: 'boolean',
    required: true,
  })
  photo: string;

  @property({
    type: 'string',
    required: true,
  })
  status: string;

  @property({
    type: 'date',
    required: true,
  })
  createdAt: string;

  @belongsTo(() => User) // This indicates that each Post belongs to a User
  userId: string;

  // Define well-known properties here

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  [prop: string]: any;

  constructor(data?: Partial<Post>) {
    super(data);
  }
}

export interface PostRelations {
  // describe navigational properties here
}

export type PostWithRelations = Post & PostRelations;
