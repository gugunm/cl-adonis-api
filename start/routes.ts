import HealthCheck from '@ioc:Adonis/Core/HealthCheck'
import Route from '@ioc:Adonis/Core/Route'

Route.group(() => {
  Route.group(() => {
    Route.resource('/todos', 'TodosController').apiOnly()
  }).middleware('auth')

  Route.group(() => {
    Route.post('register', 'AuthController.register') // .as('register')
    Route.post('login', 'AuthController.login') // .as('login')
    Route.post('logout', 'AuthController.logout') // .as('logout')
  }).prefix('auth')

  Route.group(() => {
    Route.post('register', 'AuthOwnersController.register') // .as('register')
    Route.post('login', 'AuthOwnersController.login') // .as('login')
    Route.post('logout', 'AuthOwnersController.logout') // .as('logout')
  }).prefix('auth/owner')

  // check db connection
  Route.get('health', async ({ response }) => {
    const report = await HealthCheck.getReport()
    return report.healthy ? response.ok(report) : response.badRequest(report)
  })
}).prefix('api/v1')
