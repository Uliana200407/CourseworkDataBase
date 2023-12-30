CREATE USER 'amateur_cook'@'localhost' IDENTIFIED BY 'Basic';
GRANT SELECT, INSERT, UPDATE, DELETE ON culinary_recipe.recipes TO 'amateur_cook'@'localhost';
GRANT SELECT ON culinary_recipe.dish_types TO 'amateur_cook'@'localhost';

CREATE USER 'professional_chef'@'localhost' IDENTIFIED BY 'Advanced';
GRANT ALL PRIVILEGES ON culinary_recipe.* TO 'professional_chef'@'localhost';

CREATE USER 'dietary_consultant'@'localhost' IDENTIFIED BY 'Diet';
GRANT SELECT ON culinary_recipe.recipes TO 'dietary_consultant'@'localhost';

CREATE USER 'food_blogger'@'localhost' IDENTIFIED BY 'Blogger';

GRANT ALL PRIVILEGES ON culinary_recipe.* TO 'food_blogger'@'localhost';
CREATE USER 'user'@'localhost' IDENTIFIED BY 'User';

CREATE ROLE professional_cooks;

GRANT SELECT, INSERT, UPDATE, DELETE ON culinary_recipe.recipes TO professional_cooks;
GRANT SELECT ON culinary_recipe.dish_types TO professional_cooks;

GRANT professional_cooks TO 'user'@'localhost';
