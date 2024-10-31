-- Create ENUM types
CREATE TYPE user_type_enum AS ENUM ('Owner', 'Adopter');
CREATE TYPE post_status_enum AS ENUM ('Available', 'Not Available');
CREATE TYPE visibility_enum AS ENUM ('Visible', 'Hidden');
CREATE TYPE notification_type_enum AS ENUM ('Like', 'Message', 'Favourite');

-- Create User table
CREATE TABLE "User" (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash BYTEA NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    userType user_type_enum NOT NULL,
    bio TEXT,
    location VARCHAR(100),
    createdAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Post table
CREATE TABLE "Post" (
    post_id SERIAL PRIMARY KEY,
    petName VARCHAR(100) NOT NULL,
    petDescription TEXT NOT NULL,
    petType VARCHAR(50) NOT NULL,
    breed VARCHAR(50),
    age INTEGER,
    gender VARCHAR(10),
    homeRequirements TEXT,
    location VARCHAR(100) NOT NULL,
    status post_status_enum NOT NULL,
    visibility visibility_enum NOT NULL,
    createdAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    userID INTEGER NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE
);

-- Create Like table
CREATE TABLE "Like" (
    userID INTEGER NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    postID INTEGER NOT NULL REFERENCES "Post"(post_id) ON DELETE CASCADE,
    createdAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (userID, postID)
);

-- Create Favourite table
CREATE TABLE "Favourite" (
    userID INTEGER NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    postID INTEGER NOT NULL REFERENCES "Post"(post_id) ON DELETE CASCADE,
    createdAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (userID, postID)
);

-- Create Message table
CREATE TABLE "Message" (
    message_id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    createdAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    senderID INTEGER NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    receiverID INTEGER NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    postID INTEGER REFERENCES "Post"(post_id)
);

-- Create Notification table
CREATE TABLE "Notification" (
    notif_id SERIAL PRIMARY KEY,
    type notification_type_enum NOT NULL,
    message TEXT NOT NULL,
    isRead BOOLEAN NOT NULL DEFAULT FALSE,
    createdAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    userID INTEGER NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    referenceType notification_type_enum,
    referenceID INTEGER
);

-- Indexes for foreign keys to improve performance
CREATE INDEX idx_post_userID ON "Post"(userID);
CREATE INDEX idx_like_userID ON "Like"(userID);
CREATE INDEX idx_like_postID ON "Like"(postID);
CREATE INDEX idx_favourite_userID ON "Favourite"(userID);
CREATE INDEX idx_favourite_postID ON "Favourite"(postID);
CREATE INDEX idx_message_senderID ON "Message"(senderID);
CREATE INDEX idx_message_receiverID ON "Message"(receiverID);
CREATE INDEX idx_notification_userID ON "Notification"(userID);