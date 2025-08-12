SELECT d.name, p.name, s.name, a.name
FROM (
    SELECT name, ROW_NUMBER() OVER (ORDER BY name ASC) as id
    FROM occupations
    WHERE occupation = 'Doctor'
) AS d
RIGHT JOIN (
    SELECT name, ROW_NUMBER() OVER (ORDER BY name ASC) as id
    FROM occupations
    WHERE occupation = 'Professor'
) AS p ON d.id = p.id
LEFT JOIN (
    SELECT name, ROW_NUMBER() OVER (ORDER BY name ASC) as id
    FROM occupations
    WHERE occupation = 'Singer'
) AS s ON p.id = s.id
LEFT JOIN (
    SELECT name, ROW_NUMBER() OVER (ORDER BY name ASC) as id
    FROM occupations
    WHERE occupation = 'Actor'
) AS a ON p.id = a.id;