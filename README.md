# issue-tracker
A Mini JIRA

## Setup
### Requirements
- PostgreSQL 17
- Python 3.12

### Project Setup
- Clone repo: `git clone git@github.com:Mimi97-aqua/issue-tracker.git`
- cd to project: `cd issue-tracker`

### Database Setup
```shell

# Create db
psql -U your_user -c "create database issue_tracker;"

# Load schema
psql -U your_user -d issue_tracker -f db_scripts/schema/tables.sql

# Add triggers, indexes, and docs (optional)
psql -U your_user -d issue_tracker -f db_scripts/schema/create_triggers.sql
psql -U your_user -d issue_tracker -f db_scripts/schema/apply_triggers.sql
psql -U your_user -d issue_tracker -f db_scripts/schema/indexes.sql
psql -U your_user -d issue_tracker -f db_scripts/docs.sql

# Seed db (optional)
psql -U your_user -d issue_tracker -f db_scripts/seeds/data.sql
```