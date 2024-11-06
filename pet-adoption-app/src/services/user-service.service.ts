import { /* inject, */ BindingScope, injectable } from '@loopback/core';
import { repository } from '@loopback/repository';
import { HttpErrors } from '@loopback/rest';
import * as bcrypt from 'bcrypt';
import { User } from '../models';
import { UserRepository } from '../repositories';

// Optional: Basic email and password validation
const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const MIN_PASSWORD_LENGTH = 8;

@injectable({scope: BindingScope.TRANSIENT})
export class UserServiceService {
  constructor(
      @repository(UserRepository) public userRepository: UserRepository,
  ) {}

  // Utility function to validate email format and password strength
  validateUserData(email: string, password: string): void {
    if (!EMAIL_REGEX.test(email)) {
      throw new HttpErrors.UnprocessableEntity('Invalid email format.');
    }
    if (password.length < MIN_PASSWORD_LENGTH) {
      throw new HttpErrors.UnprocessableEntity(
          `Password must be at least ${MIN_PASSWORD_LENGTH} characters.`,
      );
    }
  }

  async register(userData: {username: string, email: string, password: string, firstName: string, lastName: string}): Promise<User> {
    // Normalize email to lowercase
    const normalizedEmail = userData.email.toLowerCase();

    // Validate email format and password strength
    this.validateUserData(normalizedEmail, userData.password);

    // Check if the user with this email already exists
    const existingUser = await this.userRepository.findOne({where: {email: normalizedEmail}});
    if (existingUser) {
      throw new HttpErrors.BadRequest('Email already registered.');
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(userData.password, 10);

    // Create user with hashed password and normalized email
    const savedUser = await this.userRepository.create({
      ...userData,
      email: normalizedEmail,
      password: hashedPassword,
    });

    // Remove password from the saved user object before returning
    const {password, ...userWithoutPassword} = savedUser;
    return userWithoutPassword as User;
  }

  async login(email: string, password: string): Promise<User> {
    // Normalize email to lowercase
    const normalizedEmail = email.toLowerCase();

    // Validate email format and password strength
    this.validateUserData(normalizedEmail, password);

    // Find user by normalized email
    const user = await this.userRepository.findOne({where: {email: normalizedEmail}});
    if (!user) {
      throw new HttpErrors.Unauthorized('Invalid credentials.');
    }

    // Check if the provided password matches the stored hashed password
    const passwordMatched = await bcrypt.compare(password, user.password);
    if (!passwordMatched) {
      throw new HttpErrors.Unauthorized('Invalid credentials.');
    }

    // Remove password from user object before returning
    const {password: _, ...userWithoutPassword} = user;
    return userWithoutPassword as User;
  }
}