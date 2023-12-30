CREATE INDEX idx_recipe_name ON recipes (recipe_name);
SELECT * FROM recipes WHERE recipe_name = 'German Schnitzel';

CREATE INDEX idx_recipe_id ON recipe_ingredients (recipe_id);
SELECT ingredient_name, quantity
FROM ingredients
INNER JOIN recipe_ingredients ON ingredients.ingredient_id = recipe_ingredients.ingredient_id
WHERE recipe_ingredients.recipe_id = 57;

CREATE INDEX idx_ingredient_name ON ingredients (ingredient_name);
SELECT DISTINCT recipes.recipe_name
FROM recipes
INNER JOIN recipe_ingredients ON recipes.recipe_id = recipe_ingredients.recipe_id
INNER JOIN ingredients ON recipe_ingredients.ingredient_id = ingredients.ingredient_id
WHERE ingredients.ingredient_name = 'Chocolate';

CREATE INDEX idx_recipe_id ON user_ratings (recipe_id);
SELECT r.recipe_name, subquery.average_rating
FROM recipes AS r
JOIN (
    SELECT recipe_id, AVG(rating) AS average_rating
    FROM user_ratings
    GROUP BY recipe_id
    ORDER BY average_rating DESC
    LIMIT 10
) AS subquery ON r.recipe_id = subquery.recipe_id;

CREATE INDEX idx_recipe_id ON recipe_comments (recipe_id);
SELECT r.recipe_name, rc.comment_text, rc.comment_date
FROM recipes AS r
JOIN recipe_comments AS rc ON r.recipe_id = rc.recipe_id;

CREATE INDEX idx_calories ON recipes (calories);
SELECT recipe_name, calories
FROM recipes
WHERE calories > 500;

CREATE INDEX idx_recipe_id_recipes ON recipes (recipe_id);
CREATE INDEX idx_recipe_id_recipe_videos ON recipe_videos (recipe_id);
SELECT recipes.recipe_name, recipe_videos.video_url
FROM recipes
JOIN recipe_videos ON recipes.recipe_id = recipe_videos.recipe_id;

