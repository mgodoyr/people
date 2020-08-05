import {Client, expect} from '@loopback/testlab';
import {ApiApplication} from '../..';
import {setupApplication} from './test-helper';

describe('PeopleController', () => {
  let app: ApiApplication;
  let client: Client;

  before('setupApplication', async () => {
    ({app, client} = await setupApplication());
  });

  after(async () => {
    await app.stop();
  });

  it('invokes GET /people', async () => {
    const res = await client.get('/people').expect(200);
    expect(res.body).equal(typeof res.body === (Array).toString());
  });
});
