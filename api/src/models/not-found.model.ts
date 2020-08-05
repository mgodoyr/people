import {Model, model, property} from '@loopback/repository';

@model()
export class NotFound extends Model {

  @property({
    type: 'string'
  })
  errorMessage?: string;


  constructor(data?: Partial<NotFound>) {
    super(data);
  }
}

export interface NotFoundRelations {
  // describe navigational properties here
}

export type NotFoundWithRelations = NotFound & NotFoundRelations;
