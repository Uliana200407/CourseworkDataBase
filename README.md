# Coursework Database: a collection of culinary recipes👩🏻‍🍳
## List
* Overview
* ER Model
* Data Base creation script
  * Relational database schema
* Item 3

### Overview🔖
The "Culinary Recipes Database" is a comprehensive and meticulously curated digital repository designed for gastronomy enthusiasts, culinary students, professional chefs, and anyone with a passion for cooking. This database serves as a treasure trove of recipes, featuring a vast array of cuisines from around the world. Each recipe is detailed with step-by-step instructions, ingredient lists, nutritional information, and serving suggestions.
## ER model
![ER model_page-0001](https://github.com/Uliana200407/CourseworkDataBase/assets/114984015/418a0e19-9c38-4697-aa6c-12698ad0bd9a)

## DataBase creation script

```sql
CREATE DATABASE culinary_recipe;
USE culinary_recipe;
CREATE TABLE dish_types (
    dish_type_id INT AUTO_INCREMENT PRIMARY KEY,
    dish_type_name VARCHAR(255) NOT NULL
);

CREATE TABLE ingredients (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_name VARCHAR(255) NOT NULL
);

CREATE TABLE recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_name VARCHAR(255) NOT NULL,
    dish_type_id INT,
    calories INT,
    FOREIGN KEY (dish_type_id) REFERENCES dish_types(dish_type_id)
);

CREATE TABLE recipe_ingredients (
    recipe_id INT,
    ingredient_id INT,
    quantity VARCHAR(50) NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id)
);

CREATE TABLE instructions (
    instruction_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT,
    step_number INT NOT NULL,
    instruction_text TEXT NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE user_favorites (
    user_id INT,
    recipe_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

CREATE TABLE user_ratings (
    user_id INT,
    recipe_id INT,
    rating INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

CREATE TABLE recipe_prep_times (
    recipe_id INT,
    prep_time INT, -- in minutes
    cook_time INT, -- in minutes
    total_time INT, -- in minutes
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

-- Table to store recipe serving information
CREATE TABLE recipe_servings (
    recipe_id INT,
    servings INT,
    serving_size VARCHAR(50),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

-- Table to store recipe dietary restrictions or labels
CREATE TABLE recipe_dietary_labels (
    recipe_id INT,
    dietary_label VARCHAR(50),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

-- Table to store recipe video URLs or links
CREATE TABLE recipe_videos (
    recipe_id INT,
    video_url VARCHAR(255),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

-- Table to store recipe source or author information
CREATE TABLE recipe_sources (
    recipe_id INT,
    source_name VARCHAR(255),
    source_url VARCHAR(255),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

-- Table to store recipe comments or notes
CREATE TABLE recipe_notes (
    recipe_id INT,
    note_id INT AUTO_INCREMENT PRIMARY KEY,
    note_text TEXT,
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

-- Table to store user dietary preferences or restrictions
CREATE TABLE user_dietary_preferences (
    user_id INT,
    dietary_preference VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table to store user profile information
CREATE TABLE user_profiles (
    user_id INT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    profile_picture_url VARCHAR(255),
    bio TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table to store recipe comments or notes
CREATE TABLE recipe_comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT,
    user_id INT,
    comment_text TEXT,
    comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table to store recipe tags or labels
CREATE TABLE recipe_tags (
    recipe_id INT,
    tag_name VARCHAR(50),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);
```
## Relational database schema
![culinary_recipe](https://github.com/Uliana200407/CourseworkDataBase/assets/114984015/41af2c09-bfb8-4d2b-8be9-7b1a6a9c50b9)

