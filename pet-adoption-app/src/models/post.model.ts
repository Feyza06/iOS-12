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
    type: 'string',
    required: true,
  })
  gender: string;

  @property({
    type: 'boolean',
    required: true,
    default: false,
  })
  hasPhoto: boolean;

  @property({
    type: 'string',
    required: false,
    default: null
  })
  photo?: string | null;;

  @property({
    type: 'string',
    required: true,
  })
  description: string;

  @property({
    type: 'string',
    required: true,
  })
  location: string;


  @property({
    type: 'string',
    required: false,
    default: 'active',
  })
  status: string;

  @property({
    type: 'date',
    required: false,

  })
  createdAt: string;

  @property({
    type: 'string',
    required: true,
  })
  birthday: string;

  @property({
    type: 'number',
    required: true, // Assuming fee is required for the post
  })
  fee: number;

  

  


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
