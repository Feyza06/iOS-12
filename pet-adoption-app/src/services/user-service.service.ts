import { /* inject, */ BindingScope, injectable } from '@loopback/core';
import { repository } from '@loopback/repository';
import { HttpErrors } from '@loopback/rest';
import * as bcrypt from 'bcrypt';
import { User } from '../models';
import { UserRepository } from '../repositories';
import * as jwt from 'jsonwebtoken';
import * as dotenv from 'dotenv';
dotenv.config();

const JWT_SECRET = process.env.JWT_SECRET || 'best_pet_adoption_app_secret';
if (!JWT_SECRET) {
  throw new Error('JWT_SECRET is not defined in environment variables.');
}
const JWT_EXPIRES_IN = '7d'; // Token expires in 7 days

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

  async register(userData: Partial<User>): Promise<User> {
    // Ensure required fields are present
    const { username, email, password, firstName, lastName, photo } = userData;

    if (!username || !email || !password || !firstName || !lastName) {
      throw new HttpErrors.BadRequest('Missing required user fields');
    }

    if (photo && typeof photo !== 'string') {
      throw new HttpErrors.BadRequest('Invalid photo URL.');
    }

    // Normalize email to lowercase
    const normalizedEmail = email.toLowerCase();

    // Validate email format and password strength
    this.validateUserData(normalizedEmail, password);

    // Check if the user with this email already exists
    const existingUser = await this.userRepository.findOne({
      where: { email: normalizedEmail },
    });
    if (existingUser) {
      throw new HttpErrors.BadRequest('Email already registered.');
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create user with hashed password and normalized email
    const savedUser = await this.userRepository.create({
      ...userData,
      email: normalizedEmail,
      password: hashedPassword,
    });

    // Remove password from the saved user object before returning
    const { password: _, ...userWithoutPassword } = savedUser;
    return userWithoutPassword as User;
  }

  async login(email: string, password: string): Promise<{ token: string; user: User }> {    // Normalize email to lowercase
    const normalizedEmail = email.toLowerCase();

    // Validate email format
    if (!EMAIL_REGEX.test(normalizedEmail)) {
      throw new HttpErrors.UnprocessableEntity('Invalid email format.');
    }

    // Find user by normalized email
    const user = await this.userRepository.findOne({
      where: {email: normalizedEmail},
    });
    if (!user) {
      throw new HttpErrors.Unauthorized('Invalid email or password.');
    }

    // Check if the provided password matches the stored hashed password
    const passwordMatched = await bcrypt.compare(password, user.password);
    if (!passwordMatched) {
      throw new HttpErrors.Unauthorized('Invalid email or password.');
    }

// Generate JWT token
    const token = jwt.sign(
        {
          id: user.id,
          email: user.email,
          username: user.username,
          // Include other necessary user info
        },
        JWT_SECRET,
        {
          expiresIn: JWT_EXPIRES_IN,
        }
    );

// Remove password from user object before returning
    const { password: _password, ...userWithoutPassword } = user;
    return { token, user: userWithoutPassword as User };
  }
}