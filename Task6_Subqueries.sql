USE threatsense_db;

SELECT
    incident_id,
    incident_title,
    severity,
    (SELECT COUNT(*) FROM incidents) AS total_incidents
FROM incidents;

SELECT
    incident_id,
    incident_title,
    severity
FROM incidents
WHERE severity IN (
    SELECT severity
    FROM incidents
    GROUP BY severity
    HAVING COUNT(*) >= 2
);

SELECT
    severity,
    incident_count
FROM (
    SELECT
        severity,
        COUNT(*) AS incident_count
    FROM incidents
    GROUP BY severity
) AS severity_summary;

SELECT
    incident_id,
    incident_title,
    severity
FROM incidents i
WHERE EXISTS (
    SELECT 1
    FROM alerts a
    WHERE a.alert_id = i.alert_id
);