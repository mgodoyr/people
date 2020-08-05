import {
  Filter,
  repository,
  Where,
} from '@loopback/repository';
import {
  post,
  param,
  get,
  getModelSchemaRef,
  put,
  del,
  requestBody,
  Response,
  RestBindings
} from '@loopback/rest';
import {People} from '../models';
import {PeopleRepository} from '../repositories';
import {inject} from '@loopback/core';

export class PeopleController {
  constructor(
    @repository(PeopleRepository)
    public peopleRepository : PeopleRepository,
  ) {}

  @post('/people', {
    responses: {
      '200': {
        description: 'People model instance',
        content: {'application/json': {schema: getModelSchemaRef(People)}},
      },
    },
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(People, {
            title: 'NewPeople',
            
          }),
        },
      },
    })
    people: People,
  ): Promise<People> {
    return this.peopleRepository.create(people);
  }


  @get('/people', {
    responses: {
      '200': {
        description: 'Array of People model instances',
        content: {
          'application/json': {
            schema: {
              type: 'array',
              items: getModelSchemaRef(People),
            },
          },
        },
      },
    },
  })
  async find(
    @param.filter(People) filter?: Filter<People>,
    // @ts-ignore
    @inject(RestBindings.Http.RESPONSE) response: Response,
  ) {
    const data = await this.peopleRepository.find(filter);
    if (data.length > 0) {
      return data;
    } else {
      response.sendStatus(404);
      response.end();
    }
  }


  @get('/people/{nationalId}', {
    responses: {
      '200': {
        description: 'People model instance',
        content: {
          'application/json': {
            schema: getModelSchemaRef(People, {includeRelations: true}),
          },
        },
      }
    },
  })
  async findById(
    @param.path.string('nationalId') nationalId: string,
    @inject(RestBindings.Http.RESPONSE)
    response: Response,
  ) {
      const data = await this.peopleRepository.find({where: {nationalId: nationalId}});
      if (data.length > 0) {
        return data;
      } else {
        response.sendStatus(404);
        response.end();
      }
  }


  @put('/people/{nationalId}', {
    responses: {
      '204': {
        description: 'People PUT success',
      },
    },
  })
  async replaceById(
    @param.path.string('nationalId') nationalId: string,
    @requestBody() people: People,
    where: Where<People>,
    @inject(RestBindings.Http.RESPONSE)
    response: Response,
  ): Promise<void> {
    where = {nationalId: nationalId};
    const data = await this.peopleRepository.updateAll(people, where);
    if (data.count == 0) {
      response.sendStatus(404);
      response.end();
    }
  }

  @del('/people/{nationalId}', {
    responses: {
      '204': {
        description: 'People DELETE success',
      },
    },
  })
  async deleteById(@param.path.string('nationalId') nationalId: string, people: People): Promise<void> {
    await this.peopleRepository.delete(people, {where: {nationalId: nationalId}});
  }
}
