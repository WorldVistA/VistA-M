ORY296 ;SLCOIFO - Pre and Post-init for patch OR*3*296 ; 6/30/08 5:58am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**296**;Dec 17, 1997;Build 19
 ;
PRE ; initiate pre-init processes
 Q
 ;
POST ; initiate post-init processes
 ;
 D MAIL
 Q
 ;
MAIL ; send bulletin of installation time
 N COUNT,DIFROM,I,START,TEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S COUNT=0,XMDUZ="CPRS PACKAGE",XMTEXT="TEXT("
 S XMSUB="Version "_$P($T(VERSION),";;",2)_" Installed"
 F I="G.CPRS GUI INSTALL@ISC-SLC.VA.GOV",DUZ S XMY(I)=""
 S X=$P($T(VERSION),";;",2)
 D LINE("Version "_X_" has been installed.")
 D LINE(" ")
 D LINE("Install complete:  "_$$FMTE^XLFDT($$NOW^XLFDT()))
 D ^XMD
 Q
 ;
LINE(DATA) ; set text into array
 S COUNT=COUNT+1
 S TEXT(COUNT)=DATA
 Q
 ;
VERSION ;;27.90
 ;
