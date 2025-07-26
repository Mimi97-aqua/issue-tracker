-- Members table
create index idx_members_is_active on members(is_active) where is_active = true;
create index idx_members_has_verified on members(has_verified) where is_active = true;

-- Issues table
create index idx_issues_project_status on issues(project_id, status_id);
create index idx_issues_assignee_status on issues(assignee_id, status_id);
create index idx_issues_due_date on issues(due_date) where due_date is not null;
create index idx_issues_created_at on issues(created_at);
create index idx_issues_title on issues(title);
create index idx_issues_status_created on issues(status_id, created_at) where is_active = true;
create index idx_issues_created_by on issues(created_by_id);
create index idx_issues_modified_by on issues(modified_by_id);
create index idx_issue_types_creator on issue_types(created_by_id);
create index idx_statuses_creator on statuses(created_by_id);

-- Projects | Teams
create index idx_projects_is_active on projects(is_active);
create index idx_teams_owner_id on teams(owner_id);
