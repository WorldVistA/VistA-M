ORY203 ;SLC/PKS -- postinit rtn for OR*3*203;7/2/2003  06:25 [9/11/03 10:56am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**203**;Dec 17, 1997
 ;
 Q
 ;
PRE ; -- preinit
 ;
 Q
 ;
POST ; -- postinit
 ;
 N VER
 ;
 S VER=$P($T(VERSION^ORY187),";",3)
 D MAIL
 ;
 Q
 ;
MAIL ; send bulletin of installation time
 N COUNT,DIFROM,I,START,TEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S COUNT=0
 S XMSUB="Version "_$P($T(VERSION),";;",2)_" Installed"
 S XMDUZ="CPRS PACKAGE"
 F I="G.CPRS GUI INSTALL@ISC-SLC.VA.GOV",DUZ S XMY(I)=""
 S XMTEXT="TEXT("
 ;
 S X=$P($T(VERSION),";;",2)
 D LINE("Version "_X_" has been installed.")
 D LINE(" ")
 D LINE("Install complete:  "_$$FMTE^XLFDT($$NOW^XLFDT()))
 ;
 D ^XMD
 Q
 ;
LINE(DATA)      ; set text into array
 S COUNT=COUNT+1
 S TEXT(COUNT)=DATA
 Q
 ;
VERSION ;;22.12
