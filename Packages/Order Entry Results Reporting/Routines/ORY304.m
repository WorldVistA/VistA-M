ORY304 ;SLCOIFO - Post-init for patch OR*3*304 ;11/03/08 16:07
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**304**;Dec 17, 1997;Build 6
 ;
PRE ; initiate pre-init processes
 ;
 Q
 ;
POST ; initiate post-init processes
 ;
 D MAIL
 Q
 ;
MAIL ; send bulletin of installation time
 N DA,DIE,DR,VERSNUM,NAME,OPTIEN
 S DA=$O(^DIC(19,"B","OR CPRS GUI CHART","")) Q:DA'>0
 ;Change to versnum to store the new version number
 S VERSNUM="CPRSChart version 1.0.27.83"
 S DIE="^DIC(19,",DR="1////^S X=VERSNUM" D ^DIE
 ;
 N COUNT,DIFROM,I,START,TEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S COUNT=0,XMDUZ="CPRS PACKAGE",XMTEXT="TEXT("
 S XMSUB="Version "_$P($T(VERSION),";;",2)_" Installed"
 S XMY(DUZ)=""
 ;
 S X=$P($T(VERSION),";;",2)
 D LINE("Version "_X_" has been installed.")
 D LINE(" ")
 D LINE("Install complete:  "_$$FMTE^XLFDT($$NOW^XLFDT()))
 ;
 D ^XMD
 Q
 ;
LINE(DATA) ; set text into array
 S COUNT=COUNT+1
 S TEXT(COUNT)=DATA
 Q
 ;
VERSION ;;27.83
