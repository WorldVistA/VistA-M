ORY120 ;slc/dcm - Patch 120 Post/Pre-init ;08/27/01  10:09
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**120**;Dec 17, 1997
PRE ;Pre-init
 Q
POST ;Post-init
 N X
 S X=$O(^ORD(101.24,"B","ORRP BCMA MAH",0))
 I X S $P(^ORD(101.24,X,4),"^",2)=7
 D SETVAL
 D MAIL
 Q
SENDPAR(ANAME)  ; Return true if the current parameter should be sent
 I ANAME="ORWRP TIME/OCC LIMITS INDV" Q 1
 Q 0
SETVAL ;Set Package level parameter values
 N ORP,ORT,ORI,X0
 S ORP="ORWRP TIME/OCC LIMITS INDV",ORT="T-7;T;10"
 D PUT^XPAR("PKG",ORP,1,ORT)
 Q
MAIL ; send bulletin of installation time
 N COUNT,DIFROM,I,START,TEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S COUNT=0
 S XMSUB="Version "_$P($T(VERSION),";;",2)_" Installed"
 S XMDUZ="PATCH OR*3*120"
 F I="G.CPRS GUI INSTALL@ISC-SLC.DOMAIN.EXT",DUZ S XMY(I)=""
 S XMTEXT="TEXT("
 ;
 S X=$P($T(VERSION),";;",2)
 D LINE("Version "_X_" has been installed.")
 D LINE(" ")
 D LINE("Install complete:  "_$$FMTE^XLFDT($$NOW^XLFDT()))
 ;
 D ^XMD
 Q
LINE(DATA)      ; set text into array
 S COUNT=COUNT+1
 S TEXT(COUNT)=DATA
 Q
VERSION ;;120v3
