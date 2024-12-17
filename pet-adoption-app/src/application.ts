import {BootMixin} from '@loopback/boot';
import {ApplicationConfig} from '@loopback/core';
import {
  RestExplorerBindings,
  RestExplorerComponent,
} from '@loopback/rest-explorer';
import {RepositoryMixin} from '@loopback/repository';
import {RestApplication} from '@loopback/rest';
import {ServiceMixin} from '@loopback/service-proxy';
import path from 'path';
import {MySequence} from './sequence';
import {AuthenticationComponent, registerAuthenticationStrategy} from '@loopback/authentication';
import {JWTAuthenticationStrategy} from './authentication-strategies/jwt-strategy';
import * as dotenv from 'dotenv';
dotenv.config();

export {ApplicationConfig};

export class PetAdoptionAppApplication extends BootMixin(
    ServiceMixin(RepositoryMixin(RestApplication)),
) {
  constructor(options: ApplicationConfig = {}) {
    super(options);

    // Set up the custom sequence
    this.sequence(MySequence);

    // Set up default home page
    this.static('/', path.join(__dirname, '../public'));

    // Serve the 'uploads' directory at the '/uploads' path
    // Files placed in '../uploads' will be accessible at 'http://localhost:3000/uploads/...'
    this.static('/uploads', path.join(__dirname, '../uploads'));

    // Configure the REST Explorer
    this.configure(RestExplorerBindings.COMPONENT).to({
      path: '/explorer',
    });
    this.component(RestExplorerComponent);

    // Bind authentication component
    this.component(AuthenticationComponent);

    // Register JWT authentication strategy
    registerAuthenticationStrategy(this, JWTAuthenticationStrategy);

    // Bind JWT secret key
    this.bind('authentication.jwt.secret').to(process.env.JWT_SECRET || 'best_pet_adoption_app_secret');

    this.projectRoot = __dirname;
    // Customize @loopback/boot Booter Conventions here
    this.bootOptions = {
      controllers: {
        // Customize ControllerBooter Conventions here
        dirs: ['controllers'],
        extensions: ['.controller.js'],
        nested: true,
      },
    };
  }
}