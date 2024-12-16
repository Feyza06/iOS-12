import * as jwt from 'jsonwebtoken';
import {AuthenticationStrategy} from '@loopback/authentication';
import {inject} from '@loopback/core';
import {Request, HttpErrors} from '@loopback/rest';
import {UserProfile, securityId} from '@loopback/security';

interface MyUserProfile extends jwt.JwtPayload {
    id: number;
    email: string;
    username: string;
}

export class JWTAuthenticationStrategy implements AuthenticationStrategy {
    name = 'jwt';

    constructor(
        @inject('authentication.jwt.secret')
        private jwtSecret: string,
    ) {}

    async authenticate(request: Request): Promise<UserProfile | undefined> {
        const token: string = this.extractCredentials(request);

        try {
            const decodedToken = jwt.verify(token, this.jwtSecret) as MyUserProfile;

            // Ensure decodedToken is an object with your expected properties
            if (typeof decodedToken !== 'object' || !decodedToken.id) {
                throw new HttpErrors.Unauthorized('Invalid token payload');
            }

            const userProfile: UserProfile = Object.assign(
                {[securityId]: decodedToken.id.toString()},
                {
                    id: decodedToken.id,
                    email: decodedToken.email,
                    username: decodedToken.username,
                },
            );
            return userProfile;
        } catch (err) {
            throw new HttpErrors.Unauthorized('Invalid token');
        }
    }

    extractCredentials(request: Request): string {
        if (!request.headers.authorization) {
            throw new HttpErrors.Unauthorized('Authorization header missing');
        }

        const authHeader = request.headers.authorization;
        const parts = authHeader.split(' ');
        if (parts.length !== 2 || parts[0] !== 'Bearer') {
            throw new HttpErrors.Unauthorized(
                'Authorization header is not in the correct format',
            );
        }

        return parts[1];
    }
}