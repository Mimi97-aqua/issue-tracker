# issue-tracker
A Mini JIRA

## Setup
#### Requirements
- PostgreSQL 17
- Python 3.12
- Flask 3.1.1

### 1. First Steps
- Clone repo: `git clone git@github.com:Mimi97-aqua/issue-tracker.git`
- cd to project: `cd issue-tracker`

### 2.a. Manual Setup
- Create and activate virtual environment:
```shell
python3 -m venv .venv
source .venv/bin/activate
```
- Install requirments: `pip install -r requirements.txt`
- Run app:
```shell
# Use 
python3 main.py
# Or
flask --app main.py run
```

### 2.b. Setting Up with Docker

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
