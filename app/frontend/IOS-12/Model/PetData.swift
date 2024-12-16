//
//  PetData.swift
//  IOS-12
//
//  Created by Kevin Bernowsky on 29.11.24.
//

import Foundation

struct PetData {
    // Define the breeds with detailed descriptions
    static let breeds: [Breed] = [
        // Dog Breeds
        Breed(
            name: "Golden Retriever",
            species: .dog,
            description: "Golden Retrievers are friendly, intelligent, and devoted. They make excellent family pets and are great with children."
        ),
        Breed(
            name: "Samoyed",
            species: .dog,
            description: "Samoyeds are bright, alert, and friendly. Known for their gentle and playful nature, they thrive on human companionship."
        ),
        Breed(
            name: "Shiba Inu",
            species: .dog,
            description: "Shiba Inus are active and independent. They have a spirited personality and are known for their agility and alertness."
        ),
        Breed(
            name: "Siberian Husky",
            species: .dog,
            description: "Siberian Huskies are friendly and outgoing. They are energetic dogs that require regular exercise and enjoy outdoor activities."
        ),
        Breed(
            name: "Corgi",
            species: .dog,
            description: "Corgis are bold and friendly. Intelligent and active, they make great companions and are known for their short legs and long bodies."
        ),
        Breed(
            name: "Alaskan Malamute",
            species: .dog,
            description: "Alaskan Malamutes are affectionate and playful. They are strong working dogs with high endurance."
        ),
        // Cat Breeds
        Breed(
            name: "Ragdoll",
            species: .cat,
            description: "Ragdolls are gentle and affectionate. They are known for their blue eyes and colorpoint coat, and they enjoy cuddling."
        ),
        Breed(
            name: "Birman",
            species: .cat,
            description: "Birman cats are friendly and curious. They have a silky coat and deep blue eyes, and they love to explore."
        ),
        Breed(
            name: "British Shorthair",
            species: .cat,
            description: "British Shorthairs are calm and easygoing. With a dense coat and round face, they are known for their Cheshire Cat smile."
        ),
        Breed(
            name: "Scottish Fold",
            species: .cat,
            description: "Scottish Folds are sweet and affectionate. Their distinctive folded ears give them an owl-like appearance."
        ),
        Breed(
            name: "Siamese",
            species: .cat,
            description: "Siamese cats are intelligent and playful. They are social and enjoy companionship, known for their vocal nature."
        ),
        Breed(
            name: "Persian",
            species: .cat,
            description: "Persian cats are quiet and sweet. They have a long, flowing coat and expressive eyes, requiring regular grooming."
        )
    ]

    // Define all the pets
    static let pets: [Pet] = [
        // Dogs
        Pet(
            name: "Bruno",
            age: 7,
            species: .dog,
            gender: .male,
            images: ["golden", "golden.1", "golden.2"],
            breed: breeds.first { $0.name == "Golden Retriever" }!,
            weight: 30,
            description: "Bruno is a bright, sensitive dog who enjoys play with his human family and responds well to training."
        ),
        Pet(
            name: "Maya",
            age: 16,
            species: .dog,
            gender: .female,
            images: ["maya", "maya.1", "maya.2"],
            breed: breeds.first { $0.name == "Samoyed" }!,
            weight: 25,
            description: "Maya is friendly and outgoing. She loves outdoor activities and playing in the snow."
        ),
        Pet(
            name: "Indra",
            age: 14,
            species: .dog,
            gender: .female,
            images: ["shiba", "shiba.1", "shiba.2"],
            breed: breeds.first { $0.name == "Shiba Inu" }!,
            weight: 10,
            description: "Indra is alert and active. She enjoys exploring and has a spirited personality."
        ),
        Pet(
            name: "Mao",
            age: 22,
            species: .dog,
            gender: .male,
            images: ["husky", "husky.1", "husky.2"],
            breed: breeds.first { $0.name == "Siberian Husky" }!,
            weight: 20,
            description: "Mao is friendly and outgoing. He enjoys running and requires regular exercise."
        ),
        Pet(
            name: "Nora",
            age: 7,
            species: .dog,
            gender: .male,
            images: ["corgi.cover"],
            breed: breeds.first { $0.name == "Corgi" }!,
            weight: 12,
            description: "Nora is bold and friendly. He is intelligent and active, making him a great companion."
        ),
        Pet(
            name: "Dora",
            age: 3,
            species: .dog,
            gender: .female,
            images: ["malamute", "malamute.1"],
            breed: breeds.first { $0.name == "Alaskan Malamute" }!,
            weight: 35,
            description: "Dora is affectionate and playful. She is strong and enjoys outdoor activities."
        ),
        // Cats
        Pet(
            name: "Tou",
            age: 3,
            species: .cat,
            gender: .male,
            images: ["ragdoll"],
            breed: breeds.first { $0.name == "Ragdoll" }!,
            weight: 5,
            description: "Tou is gentle and affectionate. He enjoys cuddling and has a calm demeanor."
        ),
        Pet(
            name: "Toy",
            age: 12,
            species: .cat,
            gender: .female,
            images: ["birman", "birman.1"],
            breed: breeds.first { $0.name == "Birman" }!,
            weight: 4,
            description: "Toy is friendly and curious. She loves to explore and has a playful nature."
        ),
        Pet(
            name: "Reach",
            age: 24,
            species: .cat,
            gender: .male,
            images: ["bth"],
            breed: breeds.first { $0.name == "British Shorthair" }!,
            weight: 6,
            description: "Reach is calm and easygoing. He enjoys lounging and is known for his Cheshire Cat smile."
        ),
        Pet(
            name: "Haru",
            age: 7,
            species: .cat,
            gender: .female,
            images: ["scottish-fold"],
            breed: breeds.first { $0.name == "Scottish Fold" }!,
            weight: 4.5,
            description: "Haru is sweet and affectionate. She has distinctive folded ears and loves attention."
        ),
        Pet(
            name: "Pok",
            age: 18,
            species: .cat,
            gender: .female,
            images: ["sc"],
            breed: breeds.first { $0.name == "Siamese" }!,
            weight: 3.5,
            description: "Pok is intelligent and playful. She is social and enjoys spending time with people."
        ),
        Pet(
            name: "King",
            age: 22,
            species: .cat,
            gender: .male,
            images: ["pc"],
            breed: breeds.first { $0.name == "Persian" }!,
            weight: 5,
            description: "King is quiet and sweet. He has a long, flowing coat and expressive eyes."
        )
    ]

    // Computed properties to filter pets by species
    static var dogs: [Pet] {
        pets.filter { $0.species == .dog }
    }

    static var cats: [Pet] {
        pets.filter { $0.species == .cat }
    }

    // If you have other species, you can add similar computed properties
}
