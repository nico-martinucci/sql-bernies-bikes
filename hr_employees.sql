CREATE TABLE employees(
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    department TEXT NOT NULL
        CHECK (status IN ('Legal', 'Finance', 'Exec')),
    manager TEXT,
        -- constraint to make sure value is a current employee
    months_at_job INT NOT NULL,
    status TEXT NOT NULL
        CHECK (status IN ('full time', 'part time'))
);

CREATE TABLE employee_details(
    id INT PRIMARY KEY REFERENCES employees, -- does this work?
    full_name TEXT NOT NULL,
    position TEXT NOT NULL,
    salary Numeric(10,2) NOT NULL,
    home_address TEXT NOT NULL,
    phone_number INT NOT NULL,
    healthcare_id INT REFERENCES healthcare_plans,
);

CREATE TABLE healthcare_plans(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    deductible Numeric(10,2) NOT NULL,
    premium Numeric(10,2) NOT NULL
);

CREATE TABLE performance (
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employee_details,
    performance_period TEXT NOT NULL,
    grade TEXT NOT NULL
);





INSERT INTO employees(name, department, manager, months_at_job, status) VALUES
('Nick Styles', 'Legal', 'Genna Sussman', 32, 'full time'),
('Aliya Mantas', 'Legal', 'Genna Sussman', 12, 'full time'),
('Eric Schmidt', 'Legal', 'Aliya Mantas', 6, 'part time'),
('Jesus Allende', 'Legal', 'Genna Sussman', 8, 'part time'),
('Genna Sussman', 'Exec', NULL, 15, 'full time'),
('Leslie Costas', 'Finance', 'Roger Clark', 18, 'full time'),
('Janet Nopales', 'Finance', 'Roger Clark', 16, 'full time'),
('Roger Clark', 'Finance', 'Genna Sussman', 43, 'full time');

SELECT name, manager, id 
    FROM employees;

SELECT manager
    FROM employees
    WHERE manager IS NOT NULL
    GROUP BY manager;