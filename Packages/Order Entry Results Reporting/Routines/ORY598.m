ORY598 ;SLCOIFO/JLC - Post-init for patch OR*3*598 ;Dec 20, 2022@12:07:20
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**598**;Dec 17, 1997;Build 5
 ;
 ; Reference to updating MENU TEXT in OPTION file in ICR #7397
POST ; initiate post-init processes
 ;
 D BMES^XPDUTL("Updating CPRS Chart version number...")
 N DA,DIE,VERSNUM,DR
 S DA=$O(^DIC(19,"B","OR CPRS GUI CHART","")) Q:DA'>0
 ;Change to versnum to store the new version number
 S VERSNUM="CPRSChart version 1.32.221.1"
 S DIE="^DIC(19,",DR="1////^S X=VERSNUM" D ^DIE
 D BMES^XPDUTL("Version number set to 1.32.221.1")
 Q
