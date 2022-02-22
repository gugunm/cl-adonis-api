import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import UserOwner from 'App/Models/UserOwner'
import { rules, schema } from '@ioc:Adonis/Core/Validator'
import qs from 'qs'
import axios from 'axios'

export default class AuthOwnersController {
  public async register({ request, response }: HttpContextContract) {
    // validate email
    const validations = await schema.create({
      email: schema.string({}, [
        rules.email(),
        rules.unique({ table: 'user_owners', column: 'email' }),
      ]),
      username: schema.string({}, [rules.unique({ table: 'user_owners', column: 'username' })]),
      password: schema.string({}, [rules.confirmed()]),
    })
    const data = await request.validate({ schema: validations })
    const user = await UserOwner.create(data)
    return response.created(user)
  }

  //   login function
  public async login({ request, response, auth }: HttpContextContract) {
    const password = await request.input('password')
    const email = await request.input('email')

    try {
      const user = await UserOwner.findByOrFail('email', email)
      const token = await auth.use('api_owner').attempt(email, password, {
        expiresIn: '24hours',
      })
      return response.ok({ data: { ...token.toJSON(), user } })
    } catch (err) {
      return response.badRequest({ message: err }) // 'User with provided credentials could not be found' })
    }
  }

  //   logout function
  public async logout({ auth, response }: HttpContextContract) {
    await auth.logout()
    return response.ok({ message: 'Logged out successfully' })
  }
}
