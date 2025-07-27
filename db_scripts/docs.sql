-- extensions and types
comment on extension uuid-ossp is 'Generates UUIDs for primary keys';
comment on extesion pgcrypto is 'Provides cryptographic function used here for password hashing.';
comment on type enum is 'Defines user permission hierarchy for our use case';

-- tables constraints, and columns
-- 1. issues
comment on table public.issues is 'Tracks all issues in the system';
       comment on column issues.id is 'Auto-incrementing issue ID';
       comment on column issues.title is 'Short issue description';
       comment on column issues.details is 'Long issue description';
       comment on column issues.issue_code is 'Just like a JIRA work item ID';
       comment on column issues.start_date is 'When work began';
       comment on column issues.due_date is 'Deadline for issue resolution';
       comment on column issues.created_by_id is 'Member who created the issue. NOTE: Any member can create an ' ||
               'issue despite permission level';
       comment on column issues.modified_by_id is 'Last modifier. NOTE: Only the creator of the issue, ' ||
               'or member who owns project or any admin/super-admin can modify the issue.';
       comment on column issues.assignee_id is 'Responsible person/member.';
       comment on column issues.team_id is 'Assigned team';
       comment on column issues.status_id is 'Current state such as to-do or in-progress';
       comment on column issues.project_id is 'The project for which the issue belongs.';
       comment on column issues.is_active is 'Soft delete flag.';
       comment on column issues.created_at is 'Creation timestamp';
       comment on column issues.updated_at is 'Last modified timestamp';
       comment on column issues.deleted_at is 'Deactivation/Deletion timestamp';
       comment on column issues.deleted_by_id is 'Who deactivated. NOTE: Same rule applies as in modified_by_id.';
               comment on constraint issues_title_details_key is 'Composite uniqueness constraint for issues (title and' ||
                       'content fingerprints.';

-- 2. members
comment on table public.members is 'System user accounts.';
        comment on column members.id is 'Unique user identifier';
        comment on column members.first_name is 'First name';
        comment on column members.last_name is 'Last name';
        comment on column members.email is 'User email. NOTE: Used for login';
        comment on column members.role is 'Job title/Position';
        comment on column members.permission is 'Access rights. NOTE: Reference permission_level enum.'
        comment on column members.password_hash is 'Hashed password';
        comment on column members.verification_code is 'Email validation code.';
        comment on column members.has_verified is 'Account verification status.'
        comment on column members.is_active is 'Soft delete flag';
        comment on column members.invited_by_id is 'Who invited user. NOTE: can only be invited by admin or super-admin.';
        comment on column members.modified_by_id is 'Last modifier. NOTE: can only be done by admin or super-admin';
        comment on column members.created_at is 'Account creation time';
        comment on column members.updated_at is 'Last profile update';
        comment on column members.deleted_at is 'Deactivation/Deletion timestamp';

-- 3. teams
comment on table public.teams is 'Organizational groups.';
        comment on column teams.id is 'Unique team identifier';
        comment on column teams.name is 'Team name';
        comment on column teams.owner_id is 'Who created the team. NOTE: can only be created by admin or super-admin';
        comment on column teams.is_active is 'Soft-delete flag';
        comment on column teams.modified_by_id is 'Last modifier';
        comment on column teams.created_at is 'Creation timestamp';
        comment on column teams.updated_at is 'Last updated timestamp';
        comment on column teams.deleted_at is 'Deletion timestamp';

-- 4. issue types
comment on table public.issue_types is 'Issue types e.g. bugs, tasks etc.';
        comment on column issue_types.id is 'Issue type unique identifier';
        comment on column issue_types.type is 'Issue type name such as <epic>';
        comment on column issue_types.description is 'Description of the issue type.'
        comment on column issue_types.is_active is 'Soft-deletion flag';
        comment on column issue_types.created_by_id is 'Who created the issue type. NOTE: Can be created by admins and super' ||
                'admins only.';
        comment on column issue_types.modified_by_id is 'Who last modified the issue type. NOTE: Same rules applies as in' ||
                'who created the issue type';
        comment on column issue_types.created_at is 'Creation timestamp';
        comment on column issue_types.updated_at is 'Last updated timestamp';
        comment on column issue_types.deleted_at is 'Deletion timestamp';

-- 5. statuses
comment on table public.statues is 'Statuses e.g. to-do, in-progress etc.';
        comment on column statuses.id is 'Status ID';
        comment on column statuses.name is 'Status name such as in-progress or in-review';
        comment on column statuses.description is 'Description of status'
        comment on column statuses.is_active is 'Soft-deletion flag';
        comment on column statuses.created_by_id is 'Who created the status. NOTE: can only be done by admin or super-admin';
        comment on column statuses.modified_by_id is 'Who last modified the issue. NOTE: same rule applies as in creation';
        comment on column statuses.created_at is 'Creation timestamp';
        comment on column statuses.updated_at is 'Last updated timestamp';
        comment on column statuses.deleted_at is 'Deletion timestamp';

-- 6. projects
comment on table public.projects is 'All issues exist under projects. Contains info on all existing projects';
        comment on column projects.id is 'Project ID. Auto-increments from 1000.'
        comment on column projects.title is 'Short project description';
        comment on column projects.description is 'Long project description';
        comment on column projects.project_code is 'Code that uniquely identifies the project. Used for generating' ||
                'issue codes for issues that fall under the given project.';
        comment on column projects.is_active is 'Soft delete flag';
        comment on column projects.created_by_id is 'Who created the project. NOTE: only admin and super admin.';
        comment on column projects.modified_by_id is 'Who last updated the project. NOTE: same rule applies as for creation';
        comment on column projects.created_at is 'Creation timestamp';
        comment on column projects.updated_at is 'Last updated timestamp';
        comment on column projects.deleted_at is 'Deletion timestamp';

-- trigger functions
-- 1. issues triggers
comment on function update_issues_table() is 'validates active status and updates timestamp when issue fields change';
comment on function delete_issues_table() is 'handles soft-delete by setting timestamps when is_active changes to false';

-- 2. members triggers
comment on function update_members_table() is 'updates timestamp when any member profile field is modified';
comment on function delete_members_table() is 'converts hard deletes to soft-deletes by setting is_active flag';

-- 3. teams triggers
comment on function update_teams_table() is 'updates timestamp when team name or owner changes for active teams';
comment on function delete_teams_table() is 'sets deactivation timestamps when team is marked inactive';

-- 4. issue types triggers
comment on function update_issue_types_table() is 'validates active status and updates timestamp when type/description changes';
comment on function delete_issue_types_table() is 'manages issue type deactivation with proper timestamps';

-- 5. statuses triggers
comment on function update_statuses_table() is 'updates timestamp for status changes if record is active';
comment on function delete_statuses_table() is 'handles status deactivation by setting deletion timestamps';

-- 6. projects triggers
comment on function update_projects_table() is 'updates project timestamp when title/description changes if active';
comment on function delete_projects_table() is 'manages project deactivation by setting deletion timestamps';

-- triggers
-- 1. issues
comment on trigger tr_issues_update on issues is 'updates timestamp when issue fields change';
comment on trigger tr_issues_delete on issues is 'handles soft-delete by setting timestamps';

-- 2. members
comment on trigger tr_members_update on members is 'updates timestamp when profile fields change';
comment on trigger tr_members_delete on members is 'converts hard deletes to soft-deletes';

-- 3. teams
comment on trigger tr_teams_update on teams is 'updates timestamp when team details change';
comment on trigger tr_teams_delete on teams is 'handles team deactivation';

-- 4. issue_types
comment on trigger tr_issue_types_update on issue_types is 'updates timestamp when type details change';
comment on trigger tr_issue_types_delete on issue_types is 'manages type deactivation';

-- 5. statuses
comment on trigger tr_statuses_update on statuses is 'updates timestamp when status changes';
comment on trigger tr_statuses_delete on statuses is 'handles status deactivation';

-- 6. projects
comment on trigger tr_projects_update on projects is 'updates timestamp when project changes';
comment on trigger tr_projects_delete on projects is 'manages project deactivation';

-- indexes
-- 1. members indexes
comment on index idx_members_is_active is 'speeds up queries filtering active members';
comment on index idx_members_has_verified is 'optimizes lookups of verified active members';

-- 2. issues indexes
comment on index idx_issues_project_status is 'speeds up filtering issues by project and status';
comment on index idx_issues_assignee_status is 'optimizes queries for assignee workload by status';
comment on index idx_issues_due_date is 'improves performance for due date queries on active issues';
comment on index idx_issues_created_at is 'accelerates sorting/filtering by creation date';
comment on index idx_issues_title is 'optimizes title-based searches';
comment on index idx_issues_status_created is 'speeds up status history queries for active issues';
comment on index idx_issues_created_by is 'improves performance for creator-based lookups';
comment on index idx_issues_modified_by is 'optimizes queries filtering by last modifier';

-- 3. issue_types and statuses indexes
comment on index idx_issue_types_creator is 'speeds up lookups by issue type creator';
comment on index idx_statuses_creator is 'optimizes queries filtering by status creator';

-- 4. projects and teams indexes
comment on index idx_projects_is_active is 'improves performance for active projects filter';
comment on index idx_teams_owner_id is 'optimizes team owner lookups';