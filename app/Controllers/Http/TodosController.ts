import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Todo from 'App/Models/Todo'

export default class TodosController {
  public async store({ request, response }: HttpContextContract) {
    const input = request.only(['name', 'status'])
    try {
      const todos = await Todo.create(input)

      return response.created({ data: todos })
    } catch (err) {
      return response.badRequest({ message: err.message })
    }
  }

  public async index({ response }: HttpContextContract) {
    const todos = await Todo.all()

    return response.ok({ data: todos })
  }

  public async show({ params, response }: HttpContextContract) {
    try {
      const todos = await Todo.findByOrFail('id', params.id)

      return response.ok({ data: todos })
    } catch (err) {
      return response.notFound({ message: err.message })
    }
  }

  public async update({ params, request, response }: HttpContextContract) {
    const input = request.only(['name', 'status'])
    try {
      const todo = await Todo.findByOrFail('id', params.id)
      todo?.merge(input)

      await todo?.save()

      return response.accepted({ data: todo })
    } catch (err) {
      return response.badRequest({ message: err.message })
    }
  }

  public async destroy({ params, response }: HttpContextContract) {
    try {
      const todos = await Todo.findByOrFail('id', params.id)
      await todos?.delete()

      return response.accepted({ data: todos })
    } catch (err) {
      return response.badRequest({ message: err.message })
    }
  }
}
