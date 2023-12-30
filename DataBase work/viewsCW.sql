# 1st view
DROP VIEW IF EXISTS RecipeDetails;
CREATE VIEW RecipeDetails AS
SELECT
    r.recipe_id,
    r.recipe_name,
    dt.dish_type_name,
    r.calories,
    GROUP_CONCAT(i.ingredient_name ORDER BY i.ingredient_name ASC SEPARATOR ', ') AS ingredients
FROM
    recipes r
JOIN
    dish_types dt ON r.dish_type_id = dt.dish_type_id
JOIN
    recipe_ingredients ri ON r.recipe_id = ri.recipe_id
JOIN
    ingredients i ON ri.ingredient_id = i.ingredient_id
GROUP BY
    r.recipe_id, r.recipe_name, dt.dish_type_name, r.calories;

SELECT * FROM RecipeDetails;

# 2nd view
DROP VIEW IF EXISTS UserFavoriteRecipes;

CREATE VIEW UserFavoriteRecipes AS
SELECT
    u.user_id,
    u.username,
    r.recipe_name
FROM
    users u
JOIN
    user_favorites uf ON u.user_id = uf.user_id
JOIN
    recipes r ON uf.recipe_id = r.recipe_id;
SELECT * FROM UserFavoriteRecipes;

# 3rd view
DROP VIEW IF EXISTS RecipeRatingsAndComments;
CREATE VIEW RecipeRatingsAndComments AS
SELECT
    r.recipe_id,
    r.recipe_name,
    AVG(ur.rating) AS average_rating,
    COUNT(DISTINCT rc.comment_id) AS comment_count
FROM
    recipes r
LEFT JOIN
    user_ratings ur ON r.recipe_id = ur.recipe_id
LEFT JOIN
    recipe_comments rc ON r.recipe_id = rc.recipe_id
GROUP BY
    r.recipe_id, r.recipe_name;

SELECT * FROM RecipeRatingsAndComments;

#4th view
DROP VIEW IF EXISTS DetailedRecipeInstructions;

CREATE VIEW DetailedRecipeInstructions AS
SELECT
    r.recipe_id,
    r.recipe_name,
    ins.step_number,
    ins.instruction_text
FROM
    recipes r
JOIN
    instructions ins ON r.recipe_id = ins.recipe_id
ORDER BY
    r.recipe_id, ins.step_number;

SELECT * FROM DetailedRecipeInstructions;

#5th view
DROP VIEW IF EXISTS RecipeNutritionalInformation;
CREATE VIEW RecipeNutritionalInformation AS
SELECT
    r.recipe_id,
    r.recipe_name,
    r.calories,
    rs.servings,
    rs.serving_size
FROM
    recipes r
LEFT JOIN
    recipe_servings rs ON r.recipe_id = rs.recipe_id;

SELECT * FROM RecipeNutritionalInformation;
