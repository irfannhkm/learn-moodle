# Moodle 5.0 Upgrade Instructions

This document outlines the upgrade process from the previous Moodle version to Moodle 5.0 with PHP 8.3 and PostgreSQL 17.

## What's Updated

- **Moodle**: Updated to version 5.0 (MOODLE_500_STABLE branch)
- **PHP**: Updated from 7.4 to 8.3
- **PostgreSQL**: Updated from 15 to 17

## Important Notes

- **Moodledata is preserved**: Your user data, courses, and files will remain intact
- **Database volume is preserved**: All your database data will be maintained
- **Backup is recommended**: Always backup before major upgrades

## Upgrade Process

### Option 1: Automated Upgrade (Recommended)

Run the automated upgrade script:

```cmd
upgrade.bat
```

This script will:
1. Stop current containers
2. Create a database backup
3. Build new images with updated versions
4. Start services
5. Wait for services to be ready

### Option 2: Manual Upgrade

1. **Stop the current containers:**
   ```cmd
   docker-compose down
   ```

2. **Create a backup (optional but recommended):**
   ```cmd
   docker run --rm --network proxy -v postgres_data:/var/lib/postgresql/data -v %cd%:/backup postgres:17-alpine pg_dumpall -h postgres -U moodle > backup.sql
   ```

3. **Build the new images:**
   ```cmd
   docker-compose build --no-cache
   ```

4. **Start the services:**
   ```cmd
   docker-compose up -d
   ```

## Post-Upgrade Steps

1. **Access Moodle**: Navigate to your Moodle URL (default: http://localhost:2080)
2. **Complete Database Upgrade**: Moodle will automatically detect the upgrade and guide you through the database update process
3. **Check Plugins**: Verify that all plugins are compatible with Moodle 5.0
4. **Test Functionality**: Test critical features to ensure everything works correctly

## Rollback Process

If you encounter issues, you can rollback using:

```cmd
rollback.bat
```

Or manually:
1. Restore the previous Dockerfile
2. Rebuild containers: `docker-compose build --no-cache`
3. Start services: `docker-compose up -d`

## Troubleshooting

### Common Issues

1. **Plugin Compatibility**: Some plugins may not be compatible with Moodle 5.0
   - Check the plugins directory in Moodle admin
   - Update or disable incompatible plugins

2. **Memory Issues**: If you encounter memory errors
   - The php.ini is configured with 1024M memory limit
   - You can increase this if needed

3. **Database Connection Issues**: 
   - Ensure PostgreSQL 17 is running properly
   - Check container logs: `docker-compose logs postgres`

### Logs

Check container logs if you encounter issues:

```cmd
docker-compose logs moodleapp
docker-compose logs postgres
docker-compose logs pgadmin
```

## Files Modified

- `Moodle` (Dockerfile): Updated PHP version and Moodle branch
- `docker-compose.yml`: Updated PostgreSQL version
- `docker-compose-dev.yml`: Updated PostgreSQL version
- `php.ini`: Enhanced configuration for Moodle 5.0

## Backup Files Created

- `backup_before_upgrade.sql`: Database backup before upgrade
- `upgrade.bat`: Automated upgrade script
- `rollback.bat`: Rollback script
- `UPGRADE_README.md`: This documentation

## Support

- **Moodle 5.0 Documentation**: https://docs.moodle.org/50/
- **PHP 8.3 Compatibility**: https://www.php.net/releases/8.3/
- **PostgreSQL 17 Documentation**: https://www.postgresql.org/docs/17/
