-- issues

-- when an issue is updated
create or replace function update_issues_table()
returns trigger as $$
begin
    if not old.is_active then
       raise exception 'INACTIVE: Unable to update!';
    end if;

    if new.title is distinct from old.title
       or new.details is distinct from old.details
       or new.start_date is distinct from old.start_date
       or new.due_date is distinct from old.due_date
       or new.team_id is distinct from old.team_id
       or new.type_id is distinct from old.type_id
       or new.status_id is distinct from old.status_id
       or new.project_id is distinct from old.project_id
       or new.assignee_id is distinct from old.assignee_id
       then new.updated_at = now();
   end if;
   return new;
end;
$$ language plpgsql;

-- when an issue is deleted
create or replace function delete_issues_table()
returns trigger as $$
begin
    if (new.is_active is distinct from old.is_active) and not new.is_active
       then
            new.deleted_at = now();
            new.updated_at = now();
    return new;
    end if;
end;
$$ language plpgsql;

-- members

-- when member details are updated
create or replace function update_members_table()
returns trigger as $$
begin
    if new.first_name is distinct from old.first_name
       or new.last_name is distinct from old.last_name
       or new.email is distinct from old.email
       or new.role is distinct from old.role
       or new.permission is distinct from old.permission
       or new.password_hash is distinct from old.password_hash
       or new.verification_code is distinct from old.verification_code
       or new.has_verified is distinct from old.has_verified
       then new.updated_at = now();
    end if;
    return new;
end;
$$ language plpgsql;

-- when a member is deleted (deactivated | removed)
create or replace function delete_members_table()
returns trigger as $$
begin
    if new.is_active is distinct from old.is_active then
       raise exception 'Direct is_active modification not allowed. Use dedicated delete procedure.';
       return new;
    end if;

    if tg_op = 'delete' then
       new := old;
       new.is_active := false;
       new.updated_at := now();
       new.deleted_at := now();
       return new;
    end if;
end;
$$ language plpgsql;

-- teams

-- when a team is modified
create or replace function update_teams_table()
returns trigger as $$
begin
    if (new.name is distinct from old.name
       or new.owner_id is distinct from old.owner_id) and not new.is_active
       then new.updated_at = now();
    end if;
    return new;
end;
$$ language plpgsql;

-- when a team is deleted
create or replace function delete_teams_table()
returns trigger as $$
begin
    if (new.is_active is distinct from old.is_active) and not new.is_active
       then
            new.deleted_at = now();
            new.updated_at = now();
    end if;
    return new;
end;
$$ language plpgsql;

-- issue types

-- when an issue type is updated
create or replace function update_issue_types_table()
returns trigger as $$
begin
    if not old.is_active then
       raise exception 'INACTIVE: Unable to update!';
    end if;

    if new.type is distinct from old.type
       or new.description is distinct from old.description
       then new.updated_at = now();
    end if;
    return new;
end;
$$ language plpgsql;

-- when an issue type is deleted
create or replace function delete_issue_types_table()
returns trigger as $$
begin
    if (new.is_active is distinct from old.is_active) and not new.is_active
       then
            new.deleted_at = now();
            new.updated_at = now();
    end if;
    return new;
end;
$$ language plpgsql;

-- statuses

-- when a status is updated
create or replace function update_statuses_table()
returns trigger as $$
begin
    if not old.is_active then
       raise exception 'INACTIVE: Unable to update!';
    end if;

    if new.name is distinct from old.name
       or new.description is distinct from old.description
       then new.updated_at = now();
    end if;
    return new;
end;
$$ language plpgsql;

-- when a status is deleted
create or replace function delete_statuses_table()
returns trigger as $$
begin
    if (new.is_active is distinct from old.is_active) and not new.is_active
       then
            new.deleted_at = now();
            new.updated_at = now();
    end if;
    return new;
end;
$$ language plpgsql;

-- projects

-- when a project is updated
create or replace function update_projects_table()
returns trigger as $$
begin
    if not old.is_active then
       raise exception 'INACTIVE: Unable to update!';
    end if;

    if new.title is distinct from old.title
       or new.project_code is distinct from old.project_code
       or new.description is distinct from old.description
       then new.updated_at = now();
    end if;
    return new;
end;
$$ language plpgsql;

-- when a project is deleted
create or replace function delete_projects_table()
returns trigger as $$
begin
    if (new.is_active is distinct from old.is_active) and not new.is_active
       then
            new.deleted_at = now();
            new.updated_at = now();
    end if;
    return new;
end;
$$ language plpgsql;
