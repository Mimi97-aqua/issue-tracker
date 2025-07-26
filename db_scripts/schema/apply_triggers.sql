do $$
begin

    -- issues
    create trigger tr_issues_update
    before update on issues
    for each row execute function update_issues_table();

    create trigger tr_issues_delete
    before update on issues
    for each row execute function delete_issues_table();

    -- members
    create trigger tr_members_update
    before update on members
    for each row execute function update_members_table();

    create trigger tr_members_delete
    before delete on members
    for each row execute function delete_members_table();

    -- teams
    create trigger tr_teams_update
    before update on teams
    for each row execute function update_teams_table();

    create trigger tr_teams_delete
    before update on teams
    for each row execute function delete_teams_table();

    -- issue types
    create trigger tr_issue_types_update
    before update on issue_types
    for each row execute function update_issue_types_table();

    create trigger tr_issue_types_delete
    before update on issue_types
    for each row execute function delete_issue_types_table();

    -- statuses
    create trigger tr_statuses_update
    before update on statuses
    for each row execute function update_statuses_table();

    create trigger tr_statuses_delete
    before update on statuses
    for each row execute function delete_statuses_table();

    -- projects
    create trigger tr_projects_update
    before update on projects
    for each row execute function update_projects_table();

    create trigger tr_projects_delete
    before update on projects
    for each row execute function delete_projects_table();

exception when others then
    raise exception 'Trigger creation failed: %', sqlerrm;
    rollback;
    return;
end;
$$;
