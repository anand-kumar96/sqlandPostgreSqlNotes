const request = require('supertest');
const buildApp = require('../../app');
const UserRepo = require('../../reopository/userRepository');
const Context = require('../context');

let context;
beforeAll( async () => {
  context = await Context.build();
});

beforeEach( async() => {
    await context.reset();
})

// Naturally exist
afterAll(()=>{
    return context.close();
});

/// automation test to check user
it('create a user', async() => {
    const startingCount = await UserRepo.count();

    await request(buildApp())
        .post('/users')
        .send({username:'testuser', bio:'test bio'})
        .expect(200);
    
    const finishCount = await UserRepo.count();
    expect(finishCount - startingCount).toEqual(1);
})