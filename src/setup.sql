CREATE TABLE
    organization (
        organization_id SERIAL PRIMARY KEY,
        name VARCHAR(150) NOT NULL,
        description TEXT NOT NULL,
        contact_email VARCHAR(255) NOT NULL,
        logo_filename VARCHAR(255) NOT NULL
    );

INSERT INTO
    organization (name, description, contact_email, logo_filename)
VALUES
    (
        'BrightFuture Builders',
        'A nonprofit focused on improving community infrastructure through sustainable construction projects.',
        'info@brightfuturebuilders.org',
        'brightfuture-logo.png'
    ),
    (
        'GreenHarvest Growers',
        'An urban farming collective promoting food sustainability and education in local neighborhoods.',
        'contact@greenharvest.org',
        'greenharvest-logo.png'
    ),
    (
        'UnityServe Volunteers',
        'A volunteer coordination group supporting local charities and service initiatives.',
        'hello@unityserve.org',
        'unityserve-logo.png'
    );

CREATE TABLE
    project (
        project_id SERIAL PRIMARY KEY,
        organization_id INTEGER NOT NULL,
        title VARCHAR(150) NOT NULL,
        description TEXT NOT NULL,
        location VARCHAR(255) NOT NULL,
        date DATE NOT NULL,
        CONSTRAINT fk_project_organization FOREIGN KEY (organization_id) REFERENCES organization (organization_id)
    );

INSERT INTO
    project (
        organization_id,
        title,
        description,
        location,
        date
    )
VALUES
    -- BrightFuture Builders (ID: 1)
    (
        1,
        'Community School Renovation',
        'Renovating classrooms and improving learning facilities.',
        'Kubwa, Abuja',
        '2026-11-15'
    ),
    (
        1,
        'Community Road Improvement',
        'Repairing damaged roads within the community.',
        'Gwarinpa, Abuja',
        '2026-11-22'
    ),
    (
        1,
        'Affordable Housing Support',
        'Supporting low-income families with housing improvements.',
        'Bwari, Abuja',
        '2026-12-05'
    ),
    (
        1,
        'Public Water Project',
        'Improving access to clean drinking water.',
        'Dutse, Abuja',
        '2026-12-12'
    ),
    (
        1,
        'Community Health Centre Upgrade',
        'Improving facilities at a local health centre.',
        'Kubwa, Abuja',
        '2026-12-19'
    ),
    -- GreenHarvest Growers (ID: 2)
    (
        2,
        'Urban Garden Development',
        'Creating community gardens for local food production.',
        'Kubwa, Abuja',
        '2026-11-16'
    ),
    (
        2,
        'Tree Planting Campaign',
        'Planting trees to improve the local environment.',
        'Gwarinpa, Abuja',
        '2026-11-23'
    ),
    (
        2,
        'Sustainable Farming Workshop',
        'Teaching residents sustainable farming techniques.',
        'Bwari, Abuja',
        '2026-12-06'
    ),
    (
        2,
        'Community Composting Project',
        'Encouraging recycling of organic waste into compost.',
        'Dutse, Abuja',
        '2026-12-13'
    ),
    (
        2,
        'School Vegetable Garden',
        'Establishing vegetable gardens in local schools.',
        'Kubwa, Abuja',
        '2026-12-20'
    ),
    -- UnityServe Volunteers (ID: 3)
    (
        3,
        'Community Food Distribution',
        'Distributing food supplies to families in need.',
        'Kubwa, Abuja',
        '2026-11-17'
    ),
    (
        3,
        'Elderly Care Outreach',
        'Providing assistance and companionship to elderly residents.',
        'Gwarinpa, Abuja',
        '2026-11-24'
    ),
    (
        3,
        'Youth Mentorship Programme',
        'Helping young people develop useful life skills.',
        'Bwari, Abuja',
        '2026-12-07'
    ),
    (
        3,
        'Community Clean-up',
        'Organizing volunteers to clean public spaces.',
        'Dutse, Abuja',
        '2026-12-14'
    ),
    (
        3,
        'School Supplies Donation',
        'Providing educational materials to children.',
        'Kubwa, Abuja',
        '2026-12-21'
    );

-- Create categories table
CREATE TABLE
    category (
        category_id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL UNIQUE
    );

-- Create project_category junction table
CREATE TABLE
    project_category (
        project_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        PRIMARY KEY (project_id, category_id),
        CONSTRAINT fk_project_category_project FOREIGN KEY (project_id) REFERENCES project (project_id) ON DELETE CASCADE,
        CONSTRAINT fk_project_category_category FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE CASCADE
    );

-- Insert categories
INSERT INTO
    category (name)
VALUES
    ('Community Development'),
    ('Environment'),
    ('Education'),
    ('Health and Welfare');

-- Associate projects with categories
INSERT INTO
    project_category (project_id, category_id)
VALUES
    (1, 3),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 4),
    (6, 2),
    (7, 2),
    (8, 3),
    (9, 2),
    (10, 2),
    (11, 4),
    (12, 4),
    (13, 3),
    (14, 2),
    (15, 3);