-- extensions
create extension if not exists "pgcrypto";

-- members
insert into members (first_name, last_name, email, role, permission, password_hash) values
('mbango', 'likenye', 'mbango@tech.cm', 'senior developer', 'admin', crypt('password123', gen_salt('bf', 12))),
('njoke', 'mokube', 'njoke@tech.cm', 'project manager', 'super-admin', crypt('password123', gen_salt('bf', 12))),
('liombe', 'ekane', 'liombe@tech.cm', 'qa engineer', 'user', crypt('password123', gen_salt('bf', 12)));

-- projects
insert into projects (title, description, created_by_id) values
('e-commerce platform', 'online shopping system for local businesses', (select id from members where email = 'mbango@tech.cm')),
('school management system', 'digital platform for secondary schools', (select id from members where email = 'njoke@tech.cm')),
('health records app', 'electronic medical records for clinics', (select id from members where email = 'liombe@tech.cm'));

-- teams
insert into teams (name, owner_id) values
('backend team', (select id from members where email = 'mbango@tech.cm')),
('frontend team', (select id from members where email = 'njoke@tech.cm')),
('devops team', (select id from members where email = 'liombe@tech.cm'));

-- issue_types
insert into issue_types (type, description, created_by_id) values
('bug', 'unexpected behavior or defect', (select id from members where email = 'mbango@tech.cm')),
('feature', 'new functionality request', (select id from members where email = 'njoke@tech.cm')),
('task', 'general development work item', (select id from members where email = 'liombe@tech.cm'));

-- statuses
insert into statuses (name, description, created_by_id) values
('to do', 'awaiting work to begin', (select id from members where email = 'mbango@tech.cm')),
('in progress', 'currently being worked on', (select id from members where email = 'njoke@tech.cm')),
('done', 'completed work item', (select id from members where email = 'liombe@tech.cm'));

-- issues
insert into issues (title, details, issue_code, project_id, type_id, status_id, assignee_id, team_id, created_by_id) values
('login fails', 'users cant login with correct credentials', 'iss-001', 1, 1, 1, (select id from members where email = 'mbango@tech.cm'), 1, (select id from members where email = 'njoke@tech.cm')),
('add dark mode', 'client requests dark theme option', 'iss-002', 2, 2, 2, (select id from members where email = 'njoke@tech.cm'), 2, (select id from members where email = 'liombe@tech.cm')),
('deployment script', 'update deployment pipeline for staging', 'iss-003', 3, 3, 3, (select id from members where email = 'liombe@tech.cm'), 3, (select id from members where email = 'mbango@tech.cm'));
