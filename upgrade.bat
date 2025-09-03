@echo off
echo ========================================
echo Moodle 5.0 Upgrade Process
echo ========================================
echo.

echo Step 1: Stopping current containers...
docker-compose down

echo.
echo Step 2: Backing up database...
echo Creating database backup before upgrade...
docker run --rm --network proxy -v postgres_data:/var/lib/postgresql/data -v %cd%:/backup postgres:17-alpine pg_dumpall -h postgres -U moodle > backup_before_upgrade.sql

echo.
echo Step 3: Building new Moodle 5.0 image with PHP 8.3...
docker-compose build --no-cache

echo.
echo Step 4: Starting services with PostgreSQL 17...
docker-compose up --build

echo.
echo Step 5: Waiting for services to be ready...
timeout /t 30

echo.
echo ========================================
echo Upgrade completed!
echo ========================================
echo.
echo Please check the following:
echo 1. Visit your Moodle site to complete the database upgrade
echo 2. Check that all plugins are compatible with Moodle 5.0
echo 3. Verify that your data is intact
echo.
echo If you encounter issues, you can restore from backup:
echo - Database backup: backup_before_upgrade.sql
echo - Moodledata volume: moodledata (preserved)
echo.
pause
