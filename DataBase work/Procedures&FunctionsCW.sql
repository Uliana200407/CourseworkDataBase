# 1st procedure
DELIMITER //

CREATE PROCEDURE AddNewRecipe(IN recipeName VARCHAR(255), IN dishTypeID INT, IN calories INT)
BEGIN
    INSERT INTO recipes (recipe_name, dish_type_id, calories) VALUES (recipeName, dishTypeID, calories);
END;

//
DELIMITER ;
CALL AddNewRecipe('Chocolate Cake', 1, 500);
SELECT DISTINCT * FROM recipes WHERE recipe_name = 'Chocolate Cake';

# 2nd function
DELIMITER //

CREATE FUNCTION CalculateAverageCalories(dishTypeID INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE avgCalories DECIMAL(10,2);
    SELECT AVG(calories) INTO avgCalories FROM recipes WHERE dish_type_id = dishTypeID;
    RETURN avgCalories;
END;

//
DELIMITER ;

SET GLOBAL log_bin_trust_function_creators = 1;

SELECT CalculateAverageCalories(1);

#3rd procedure
DELIMITER //

CREATE PROCEDURE UpdateRecipeCalories(IN recipeID INT, IN newCalories INT)
BEGIN
    UPDATE recipes SET calories = newCalories WHERE recipe_id = recipeID;
END;

//
DELIMITER ;
INSERT INTO recipes (recipe_name, dish_type_id, calories) VALUES ('Test Recipe', 1, 300);
CALL UpdateRecipeCalories(1, 400);
SELECT recipe_id, recipe_name, calories FROM recipes WHERE recipe_id = 1;

#4th procedure
DELIMITER //

CREATE PROCEDURE DeleteRecipe(IN recipeID INT)
BEGIN
    DELETE FROM recipes WHERE recipe_id = recipeID;
END;

//
DELIMITER ;
INSERT INTO recipes (recipe_name, dish_type_id, calories) VALUES ('Sample Recipe', 1, 200);
SELECT recipe_id, recipe_name FROM recipes;
CALL DeleteRecipe(101);
SELECT * FROM recipes WHERE recipe_id = 101;

#5th procedure
DELIMITER //

CREATE PROCEDURE AddIngredientToRecipe(IN recipeID INT, IN ingredientID INT, IN quantity VARCHAR(50))
BEGIN
    INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity) VALUES (recipeID, ingredientID, quantity);
END;

//
DELIMITER ;
INSERT INTO recipes (recipe_name, dish_type_id, calories) VALUES ('Test Recipe', 1, 200);
INSERT INTO ingredients (ingredient_name) VALUES ('Sugar'), ('Salt');
CALL AddIngredientToRecipe(1, 1, '2 cups');
SELECT DISTINCT * FROM recipe_ingredients WHERE recipe_id = 1 AND ingredient_id = 1;


#6th function
DELIMITER //

CREATE FUNCTION GetTotalRecipesByDishType(dishTypeID INT) RETURNS INT
BEGIN
    DECLARE totalRecipes INT;
    SELECT COUNT(*) INTO totalRecipes FROM recipes WHERE dish_type_id = dishTypeID;
    RETURN totalRecipes;
END;

//
DELIMITER ;

INSERT INTO dish_types (dish_type_name) VALUES ('Dessert'), ('Main Course');
INSERT INTO recipes (recipe_name, dish_type_id, calories) VALUES ('Chocolate Cake', 1, 500), ('Pasta', 2, 700);
SELECT GetTotalRecipesByDishType(1) AS TotalRecipes;
#7th procedure
DELIMITER //

CREATE PROCEDURE RateRecipe(IN userID INT, IN recipeID INT, IN rating INT)
BEGIN
    INSERT INTO user_ratings (user_id, recipe_id, rating) VALUES (userID, recipeID, rating);
END;

//
DELIMITER ;
INSERT INTO users (username, password) VALUES ('user1', 'password1'), ('user2', 'password2');
INSERT INTO recipes (recipe_name) VALUES ('Recipe A'), ('Recipe B');
CALL RateRecipe(7, 7, 7);

SELECT * FROM user_ratings;

#8th procedure
DELIMITER //

CREATE PROCEDURE AddNewUser(IN username VARCHAR(50), IN password VARCHAR(255))
BEGIN
    INSERT INTO users (username, password) VALUES (username, password);
END;

//
DELIMITER ;
CALL AddNewUser('newuser', 'newpassword');
SELECT * FROM users WHERE username = 'newuser';

#9th  function
DELIMITER //

CREATE FUNCTION CheckIngredientUsage(ingredientID INT) RETURNS INT
BEGIN
    DECLARE usageCount INT;
    SELECT COUNT(*) INTO usageCount FROM recipe_ingredients WHERE ingredient_id = ingredientID;
    RETURN usageCount;
END;

//
DELIMITER ;
SELECT CheckIngredientUsage(1);

#10th procedure
DELIMITER //

CREATE PROCEDURE UpdateUserProfile(IN userID INT, IN fullName VARCHAR(100), IN email VARCHAR(100), IN profilePicURL VARCHAR(255), IN bio TEXT)
BEGIN
    UPDATE user_profiles SET full_name = fullName, email = email, profile_picture_url = profilePicURL, bio = bio WHERE user_id = userID;
END;

//
DELIMITER ;
CALL UpdateUserProfile(1, 'John Doe', 'john@example.com', 'profile.jpg', 'A bio for John Doe.');
SELECT * FROM user_profiles WHERE user_id = 1;
