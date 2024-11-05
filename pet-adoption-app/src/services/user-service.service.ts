import { /* inject, */ BindingScope, injectable} from '@loopback/core';
import {repository} from '@loopback/repository';
import {HttpErrors} from '@loopback/rest';
import * as bcrypt from 'bcrypt';
import {User} from '../models';
import {UserRepository} from '../repositories';

@injectable({scope: BindingScope.TRANSIENT})
export class UserServiceService {
  constructor(/* Add @inject to inject parameters */
    @repository(UserRepository) public userRepository: UserRepository,
    ) {}

  /*
   * Add service methods here
   */

  async register(userData: {username: string, email: string, password: string, firstName: string, lastName: string}) : Promise<User> {

    const existingUser = await this.userRepository.findOne({where: {email: userData.email}});
    if(existingUser) {
      throw new HttpErrors.BadRequest('Email already registered.');
    }

    const hashedPassword = await bcrypt.hash(userData.password, 10);
    const savedUser = await this.userRepository.create({
      ...userData,
      password: hashedPassword,
    });
    return savedUser;



  }
}
