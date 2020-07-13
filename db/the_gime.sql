DROP TABLE enrollments;
DROP TABLE gym_classes;
DROP TABLE members;

CREATE TABLE members (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);

CREATE TABLE gym_classes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE enrollments (
    id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(id),
    gym_class_id INT REFERENCES gym_classes(id)
);