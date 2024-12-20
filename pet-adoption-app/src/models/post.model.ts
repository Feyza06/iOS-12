import {belongsTo, Entity, model, property} from '@loopback/repository';
import {User} from './user.model';

@model({settings: {strict: true}})
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
    required: true,
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
  birthday: Date;

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
    type: 'boolean',
    required: true,
  })
  photo: boolean;

  @property({
    type: 'string',
    required: true,
    default: 'available'
  })
  status: string;

  @property({
    type: 'date',
    default: () => new Date(),
    required: false
  })
  createdAt: Date;

  @belongsTo(() => User) // This indicates that each Post belongs to a User
  userId: string;

  // Define well-known properties here


  constructor(data?: Partial<Post>) {
    super(data);
  }
}

export interface PostRelations {
  // describe navigational properties here
}

export type PostWithRelations = Post & PostRelations;
