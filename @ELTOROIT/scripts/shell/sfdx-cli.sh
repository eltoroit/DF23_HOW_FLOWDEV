echo "--- Creating org"
sfdx force:org:create -f config/project-scratch-def.json --setdefaultusername --setalias soDEMO -d 1

echo "--- Opening org"
sfdx force:org:open --path=/lightning/setup/DeployStatus/home

echo "--- Displaying user"
sfdx org:display:user --json

echo "--- Deploying metadata"
sfdx force:source:push --forceoverwrite --json

echo "--- Assign permission set"
sfdx force:user:permset:assign --perm-set-name HOW --json

echo "--- Initializing user"
sfdx force:apex:execute -f ./@ELTOROIT/scripts/shell/../apex/SetUserRecord.apex --json >> etLogs/apexAfterPush.json

echo "--- Deploying admin user"
mv .forceignore etLogs/.forceignore
sfdx force:source:deploy -p force-apps/doNotDeploy/main/default/profiles/Admin.profile-meta.xml
mv etLogs/.forceignore .forceignore

echo "--- Importing data"
sfdx ETCopyData:import -c ./@ELTOROIT/data --loglevel info --json --orgsource=soDEMO --orgdestination=soDEMO

echo "--- Generating password"
sfdx force:user:password:generate --json

echo "--- Displaying user"
sfdx org:display:user --json

echo "Scratch org created succesfuly"
