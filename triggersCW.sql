# 1st trigger
DROP TRIGGER IF EXISTS BeforeInsertRecipe;
DELIMITER //

CREATE TRIGGER BeforeInsertRecipe
BEFORE INSERT ON recipes
FOR EACH ROW
BEGIN
    DECLARE dishTypeExists INT;

    SELECT COUNT(*)
    INTO dishTypeExists
    FROM dish_types
    WHERE dish_type_id = NEW.dish_type_id;

    IF dishTypeExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Dish type does not exist.';
    END IF;
END;

//
DELIMITER ;
SELECT dish_type_id FROM dish_types WHERE dish_type_name = 'Italian Pasta';
INSERT INTO recipes (recipe_name, dish_type_id, calories) VALUES ('Test Recipe', 1, 100);
INSERT INTO recipes (recipe_name, dish_type_id, calories)
VALUES ('Test Recipe', 120, 100);

# 2nd trigger
DROP TRIGGER IF EXISTS UpdateAverageRating;
ALTER TABLE recipes
ADD COLUMN avg_rating DECIMAL(3,2);

DELIMITER //

CREATE TRIGGER UpdateAverageRating
AFTER INSERT ON user_ratings
FOR EACH ROW
BEGIN
    DECLARE totalRating DECIMAL(5,2);
    DECLARE numberOfRatings INT;

    SELECT SUM(rating), COUNT(*)
    INTO totalRating, numberOfRatings
    FROM user_ratings
    WHERE recipe_id = NEW.recipe_id;

    UPDATE recipes
    SET avg_rating = totalRating / numberOfRatings
    WHERE recipe_id = NEW.recipe_id;
END;

//
DELIMITER ;
# checking
SELECT recipe_id, avg_rating FROM recipes WHERE recipe_id = 3;
INSERT INTO user_ratings (user_id, recipe_id, rating) VALUES (1, 2, 5);
INSERT INTO user_ratings (user_id, recipe_id, rating) VALUES (2, 3, 4);
SELECT recipe_id, avg_rating FROM recipes WHERE recipe_id = 3;
INSERT INTO user_ratings (user_id, recipe_id, rating) VALUES (3, 3, 3);
INSERT INTO user_ratings (user_id, recipe_id, rating) VALUES (4, 2, 5);

DELIMITER //

# 3rd trigger
DROP TRIGGER IF EXISTS PreventDeleteRatedRecipe;
CREATE TRIGGER PreventDeleteRatedRecipe
BEFORE DELETE ON recipes
FOR EACH ROW
BEGIN
    DECLARE ratingCount INT;

    SELECT COUNT(*)
    INTO ratingCount
    FROM user_ratings
    WHERE recipe_id = OLD.recipe_id;

    IF ratingCount > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete recipe with existing user ratings.';
    END IF;
END;

//
DELIMITER ;
# checking
DELETE FROM recipes WHERE recipe_id = 1;

# 4th trigger
DROP TRIGGER IF EXISTS PreventUpdateDishTypeForFavorites;
DELIMITER //

CREATE TRIGGER PreventUpdateDishTypeForFavorites
BEFORE UPDATE ON recipes
FOR EACH ROW
BEGIN
    DECLARE favoriteCount INT;

    SELECT COUNT(*)
    INTO favoriteCount
    FROM user_favorites
    WHERE recipe_id = OLD.recipe_id;

    IF favoriteCount > 0 AND OLD.dish_type_id != NEW.dish_type_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot update dish type for a recipe that has user favorites.';
    END IF;
END;

//
DELIMITER ;
INSERT INTO user_favorites (user_id, recipe_id) VALUES (1, 71);
UPDATE recipes SET dish_type_id = 2 WHERE recipe_id = 71;

# 5th trigger
DROP TRIGGER IF EXISTS UpdateCommentCount;
ALTER TABLE recipes ADD COLUMN comment_count INT DEFAULT 0;
DELIMITER //

CREATE TRIGGER UpdateCommentCount
AFTER INSERT ON recipe_comments
FOR EACH ROW
BEGIN
    UPDATE recipes
    SET comment_count = comment_count + 1
    WHERE recipe_id = NEW.recipe_id;
END;

//
DELIMITER ;

# checking
SELECT recipe_id, comment_count FROM recipes WHERE recipe_id = 1;
INSERT INTO recipe_comments (recipe_id, user_id, comment_text) VALUES (1, 22, 'Test comment');
SELECT recipe_id, comment_count FROM recipes WHERE recipe_id = 1;

#  6th trigger
DROP TRIGGER IF EXISTS EnsureUserExistsBeforeComment;

DELIMITER //

CREATE TRIGGER EnsureUserExistsBeforeComment
BEFORE INSERT ON recipe_comments
FOR EACH ROW
BEGIN
    DECLARE userExists INT;

    SELECT COUNT(*)
    INTO userExists
    FROM users
    WHERE user_id = NEW.user_id;

    IF userExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot add comment: User does not exist.';
    END IF;
END;

//
DELIMITER ;
INSERT INTO recipe_comments (recipe_id, user_id, comment_text) VALUES (3, 120, 'Sample comment');
INSERT INTO recipe_comments (recipe_id, user_id, comment_text) VALUES (4, 100, 'Sample comment');

#7th trigger
DROP TRIGGER IF EXISTS CheckIngredientValidity;

DELIMITER //

CREATE TRIGGER CheckIngredientValidity
BEFORE INSERT ON recipe_ingredients
FOR EACH ROW
BEGIN
    DECLARE ingredientExists INT;

    SELECT COUNT(*)
    INTO ingredientExists
    FROM ingredients
    WHERE ingredient_id = NEW.ingredient_id;

    IF ingredientExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ingredient does not exist.';
    END IF;
END;

//
DELIMITER ;

# checking
SELECT 3 FROM ingredients;  -- To find an existing ID.
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity) VALUES (1, 1, '1 cup');
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity) VALUES (1, 456, '1 cup');

# 8th trigger
DROP TRIGGER IF EXISTS PreventDeletionOfIngredientInUse;

DELIMITER //

CREATE TRIGGER PreventDeletionOfIngredientInUse
BEFORE DELETE ON ingredients
FOR EACH ROW
BEGIN
    DECLARE inUseCount INT;

    SELECT COUNT(*)
    INTO inUseCount
    FROM recipe_ingredients
    WHERE ingredient_id = OLD.ingredient_id;

    IF inUseCount > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete ingredient: It is used in recipes.';
    END IF;
END;

//
DELIMITER ;
SELECT ingredient_id
FROM ingredients
WHERE ingredient_id NOT IN (SELECT 1 FROM recipe_ingredients);



SELECT ingredient_id FROM recipe_ingredients LIMIT 1;
DELETE FROM ingredients WHERE ingredient_id = 1;
