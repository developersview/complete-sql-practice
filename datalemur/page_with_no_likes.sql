-- method 1

SELECT 
    pg.page_id
FROM
    pages pg
        LEFT JOIN
    page_likes pgl ON pg.page_id = pgl.page_id
WHERE
    pgl.page_id IS NULL;


-- method 2
SELECT 
    page_id
FROM
    pages
WHERE
    page_id NOT IN (SELECT 
            page_id
        FROM
            page_likes
        WHERE
            page_id IS NOT NULL);


-- method 3
SELECT 
    page_id
FROM
    pages
WHERE
    NOT EXISTS( SELECT 
            page_id
        FROM
            page_likes AS likes
        WHERE
            likes.page_id = pages.page_id);