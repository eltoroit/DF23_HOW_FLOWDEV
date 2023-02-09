echo "--- Creating org"
call sfdx force:org:create -f config/project-scratch-def.json --setdefaultusername --setalias soDEMO -d 1

echo "--- Opening org"
call sfdx force:org:open --path=/lightning/setup/DeployStatus/home

echo "--- Displaying user"
call sfdx org:display:user --json

echo "--- Deploying metadata"
call sfdx force:source:push --forceoverwrite --json

echo "--- Assign permission set"
call sfdx force:user:permset:assign --perm-set-name HOW --json

echo "--- Initializing user"
call sfdx force:apex:execute -f ./@ELTOROIT/scripts/shell/../apex/SetUserRecord.apex --json >> etLogs/apexAfterPush.json

echo "--- Deploying admin user"
move .forceignore etLogs/.forceignore
call sfdx force:source:deploy -p force-apps/doNotDeploy/main/default/profiles/Admin.profile-meta.xml
move etLogs/.forceignore .forceignore

echo "--- Importing data"
call sfdx ETCopyData:import -c ./@ELTOROIT/data --loglevel info --json --orgsource=soDEMO --orgdestination=soDEMO

echo "--- Generating password"
call sfdx force:user:password:generate --json

echo "--- Displaying user"
call sfdx org:display:user --json

echo "Scratch org created succesfuly"

