-- 1. Instanz-Name max. 42 Zeichen alphanumerisch
ALTER TABLE f_instances
CHANGE COLUMN instanceName instanceName VARCHAR(42);

-- 2. StorageNames max. 30 Zeichen alphanumerisch
ALTER TABLE f_files
CHANGE COLUMN storageName storageName VARCHAR(30);

-- 3. Löschen des Eintrags "Casestudy1"
DELETE FROM f_entries
WHERE headline = 'Casestudy1';

-- 4. Löschaktionen aus dem log selektieren
SELECT *
FROM f_log
WHERE scope = 'file deletion';

-- 5. numOfPics aus f_files entfernen
ALTER TABLE f_files
DROP COLUMN numOfPics;

-- 6. Sinnvoll Verknüpfung von f_files mit f_users (Anm. Mir erschienen nur jene User sinnvoll, die upgedoadet haben.)
SELECT *
FROM f_users
INNER JOIN f_files
ON f_users.id = f_files.uploadedBy;

-- 7. User, die Berechtigung für World #2 haben
SELECT username, CONCAT (prename, ' ', surname) AS Name, instanceName
FROM f_users, f_instances
WHERE f_instances.instanceName = 'World #2';

-- 8. Welche Datei liegt auf welcher Instanz? Anm. Pfuh, da durchschau ich die Tabellen nicht. :-(
SELECT storageName, instanceName
FROM f_files, f_instances;

-- 9. Wie viele unterschiedliche Messages gibt es im Log? "379 rows" werden auch ohne "Count" angezeigt.
SELECT DISTINCT message
FROM f_log;

-- 10. Maximal 3 Einlog-Versuche
UPDATE f_options
SET value = 3
WHERE id = max-login-attempts;
-- Die Fehlermeldung versteh ich leider nicht. Man könnte es elegant umgehen, indem man die Zeilennummer als "Where"
-- nimmt, aber dann ist was Neues einfügen eher blöd.