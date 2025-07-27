-- extensions
create extension if not exists "uuid-ossp";

-- issues table
drop table if exists issues;
create table issues (
    id serial primary key not null,
    title varchar(255) not null,
    details text,
    issue_code varchar(100) unique not null,
    start_date timestamp with time zone,
    due_date timestamp with time zone,
    created_by_id uuid references members(id),
    modified_by_id uuid references members(id),
    assignee_id uuid references members(id),
    team_id integer references teams(id),
    type_id varchar not null references issue_types(id),
    status_id integer not null references statuses(id),
    project_id integer not null references projects(id),
    is_active boolean default true,
    created_at timestamp with time zone not null default current_timestamp,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    deleted_by_id uuid references members(id)

    unique (title, md5(details))
);

-- members table
drop table if exists members;
drop type if exists permission_level;

create type permission_level as enum (
    'user', 'admin', 'super-admin'
);
create table members (
    id uuid primary key not null default uuid_generate_v4(),
    first_name varchar(255) not null,
    last_name varchar(255) not null,
    email varchar(255) unique not null,
    role text not null,
    permission permission_level not null default 'user',
    password_hash varchar(255) not null,
    verification_code integer,
    has_verified boolean default false,
    is_active boolean not null default true,
    invited_by_id uuid references members(id),
    modified_by_id uuid references members(id),
    created_at timestamp with time zone not null default current_timestamp,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);

-- teams table
drop table if exists teams;
create table teams (
    id serial primary key,
    name varchar(255) unique not null,
    owner_id uuid not null references members(id),
    is_active boolean not null default true,
    modified_by_id uuid references members(id),
    created_at timestamp with time zone not null default current_timestamp,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);

-- issue types table
drop table if exists issue_types;
create table issue_types (
    id serial primary key,
    type varchar(255) unique not null,
    description varchar(255) unique not null,
    is_active boolean not null default true,
    created_by_id uuid references members(id),
    modified_by_id uuid references members(id),
    created_at timestamp with time zone not null default current_timestamp,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);

-- status table
drop table if exists statuses;
create table statuses (
    id serial primary key,
    name varchar(255) unique not null,
    description text,
    is_active boolean not null default true,
    created_by_id uuid references members(id),
    modified_by_id uuid references members(id),
    created_at timestamp with time zone not null default current_timestamp,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);

-- projects table
drop table if exists projects;
create table projects (
    id serial primary key,
    title varchar(255) unique not null,
    description text,
    project_code varchar(100) unique not null,
    is_active boolean not null default true,
    created_by_id uuid references members(id),
    modified_by_id uuid references members(id),
    created_at timestamp with time zone not null default current_timestamp,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);
alter sequence projects_id_seq restart with 1000;
