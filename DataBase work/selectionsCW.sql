SELECT * FROM recipes WHERE recipe_name LIKE 'German Schnitzel';

SELECT * FROM recipes WHERE recipe_id = 3;

SELECT * FROM recipes WHERE dish_type_id = 6;

SELECT ingredient_name, quantity FROM ingredients
JOIN recipe_ingredients ON ingredients.ingredient_id = recipe_ingredients.ingredient_id
WHERE recipe_ingredients.recipe_id = 57;


SELECT step_number, instruction_text FROM instructions
WHERE recipe_id = 24
ORDER BY step_number;

SELECT  * FROM recipes WHERE calories BETWEEN 100 AND 220;

SELECT DISTINCT recipes.recipe_name FROM recipes
JOIN recipe_ingredients ON recipes.recipe_id = recipe_ingredients.recipe_id
JOIN ingredients ON recipe_ingredients.ingredient_id = ingredients.ingredient_id
WHERE ingredients.ingredient_name = 'Chocolate';

SELECT recipes.recipe_name, AVG(user_ratings.rating) AS average_rating
FROM recipes
LEFT JOIN user_ratings ON recipes.recipe_id = user_ratings.recipe_id
GROUP BY recipes.recipe_id
ORDER BY average_rating DESC
LIMIT 10;

SELECT recipes.recipe_name, dish_types.dish_type_name
FROM recipes
JOIN dish_types ON recipes.dish_type_id = dish_types.dish_type_id
WHERE dish_types.dish_type_name = 'Mexican Taco';


SELECT recipes.recipe_name, COUNT(user_favorites.recipe_id) AS favorites_count
FROM recipes
LEFT JOIN user_favorites ON recipes.recipe_id = user_favorites.recipe_id
GROUP BY recipes.recipe_id
ORDER BY favorites_count DESC
LIMIT 10;





SELECT recipe_name, calories
FROM recipes;

SELECT recipe_name, dish_type_name
FROM recipes
JOIN dish_types ON recipes.dish_type_id = dish_types.dish_type_id
WHERE dish_types.dish_type_name = 'Italian Pasta';

SELECT recipe_name, calories
FROM recipes
WHERE calories > 500;

SELECT DISTINCT recipes.recipe_name
FROM recipes
JOIN recipe_ingredients ON recipes.recipe_id = recipe_ingredients.recipe_id
JOIN ingredients ON recipe_ingredients.ingredient_id = ingredients.ingredient_id
WHERE ingredients.ingredient_name = 'salmon';


SELECT recipes.recipe_name, recipe_videos.video_url
FROM recipes
JOIN recipe_videos ON recipes.recipe_id = recipe_videos.recipe_id;


SELECT recipes.recipe_name, GROUP_CONCAT(recipe_tags.tag_name SEPARATOR ', ') AS tags
FROM recipes
LEFT JOIN recipe_tags ON recipes.recipe_id = recipe_tags.recipe_id
GROUP BY recipes.recipe_name;

SELECT recipes.recipe_name, AVG(user_ratings.rating) AS average_rating
FROM recipes
LEFT JOIN user_ratings ON recipes.recipe_id = user_ratings.recipe_id
GROUP BY recipes.recipe_name
ORDER BY average_rating DESC
LIMIT 10;

SELECT recipes.recipe_name, GROUP_CONCAT(recipe_dietary_labels.dietary_label SEPARATOR ', ') AS dietary_labels
FROM recipes
LEFT JOIN recipe_dietary_labels ON recipes.recipe_id = recipe_dietary_labels.recipe_id
GROUP BY recipes.recipe_name;

SELECT recipes.recipe_name, recipe_comments.comment_text, recipe_comments.comment_date
FROM recipes
JOIN recipe_comments ON recipes.recipe_id = recipe_comments.recipe_id;

SELECT recipe_name, calories
FROM recipes
WHERE calories < 300;

SELECT r.recipe_name, GROUP_CONCAT(rd.dietary_label SEPARATOR ', ') AS dietary_labels
FROM recipes AS r
LEFT JOIN recipe_dietary_labels AS rd ON r.recipe_id = rd.recipe_id
WHERE rd.dietary_label LIKE '%Low Carb%'
GROUP BY r.recipe_name;

SELECT recipe_name, GROUP_CONCAT(ingredient_name SEPARATOR ', ') AS ingredients
FROM recipes
LEFT JOIN recipe_ingredients ON recipes.recipe_id = recipe_ingredients.recipe_id
LEFT JOIN ingredients ON recipe_ingredients.ingredient_id = ingredients.ingredient_id
WHERE ingredients.ingredient_name IN ('Chicken', 'Broccoli', 'Quinoa')
GROUP BY recipe_name;

SELECT r.recipe_name, rt.prep_time
FROM recipes AS r
LEFT JOIN recipe_prep_times AS rt ON r.recipe_id = rt.recipe_id
WHERE rt.prep_time <= 30;


SELECT r.recipe_name, r.calories, rl.dietary_label
FROM recipes AS r
LEFT JOIN recipe_dietary_labels AS rl ON r.recipe_id = rl.recipe_id
WHERE rl.dietary_label IN ('Low Carb', 'Vegetarian');

SELECT recipe_name
FROM recipes
WHERE recipe_id = (
    SELECT recipe_id
    FROM user_ratings
    GROUP BY recipe_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

SELECT DISTINCT u.username
FROM users AS u
JOIN user_ratings AS ur ON u.user_id = ur.user_id
WHERE ur.recipe_id = (
    SELECT recipe_id
    FROM user_ratings
    GROUP BY recipe_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

SELECT recipe_name
FROM recipes
WHERE recipe_id IN (
    SELECT DISTINCT ri.recipe_id
    FROM recipe_ingredients AS ri
    JOIN ingredients AS i ON ri.ingredient_id = i.ingredient_id
    WHERE i.ingredient_name LIKE '%tomato%'
);

SELECT COALESCE(AVG(calories), 0) AS average_calories
FROM recipes
WHERE dish_type_id = (
    SELECT dish_type_id
    FROM dish_types
    WHERE dish_type_name = 'Vietnamese Pho'
);
