NVSPOST ;JLS/OIOFO  NVSMENU KIDS POST-INSTALL                 1/21/06  NOON
 ;;1.8
 ;
POST ; -- send email on package installation --
 Q:$G(DUZ)=""
 D MAIL
 K DIFROM,X
 Q
 ;
MAIL ; -- send bulletin on install --
 N DIFROM,COUNT,TEXT,XMSUB,XMDUZ,XMTEXT,XMY
 S COUNT=0
 S XMSUB="NVSMENU Version "_$P($T(VERSION),";;",2)_" installed."
 S XMDUZ="NVS KIDS INSTALL"
 S XMY("661@DANVILLE.MED.VA.GOV")=""
 ;S XMY(DUZ)=""
 S XMTEXT="TEXT("
 ;
 S X=$P($T(VERSION),";;",2)
 D LINE("Version "_X_" has been installed at "_$G(^XMB("NAME")))
 D LINE(" ")
 D LINE("Install complete: "_$$FMTE^XLFDT($$NOW^XLFDT()))
 D ^XMD
 ;
BMES D BMES^XPDUTL("Install message sent to HSITES support group.")
 Q
 ;
LINE(DATA) ; -- set text --
 S COUNT=COUNT+1
 S TEXT(COUNT)=DATA
 Q
 ;
VERSION ;;1.8
