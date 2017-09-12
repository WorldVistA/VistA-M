LR291 ;DAL/WTY - LR*5.2*291 PATCH ENVIRONMENT CHECK ROUTINE ;8/10/04
 ;;5.2;LAB SERVICE;**291**;Sep 27, 1994
EN ; Does not prevent loading of the transport global.
 ; Environment check is done only during the install.
 ;
 I '$G(XPDENV) D  Q
 .N XQA,XQAMSG
 .S XQAMSG="Transport global for patch "_$G(XPDNM,"Unknown patch")
 .S XQAMSG=XQAMSG_" loaded on "_$$HTE^XLFDT($H)
 .S XQA("G.LMI")=""
 .D SETUP^XQALERT
 .S MSG="Sending transport global loaded alert to mail group G.LMI"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 D P68
 D CHECK
 D EXIT
 Q
 ;
CHECK ; Perform environment check
 ;
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D  Q
 .D BMES^XPDUTL($$CJ^XLFSTR("Terminal Device is not defined",80))
 .S XPDQUIT=2
 ;
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  Q
 .S MSG="Please log in to set local DUZ... variables"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 .S XPDQUIT=2
 ;
 I '$D(^VA(200,$G(DUZ),0))#2 D  Q
 .S MSG="You are not a valid user on this system"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 .S XPDQUIT=2
 ;
 S XPDDIQ("XPZ1")=0
 ;
 Q
 ;
EXIT ;
 I $G(XPDQUIT) D
 .S MSG="--- Install Environment Check FAILED ---"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 I '$G(XPDQUIT) D
 .D BMES^XPDUTL($$CJ^XLFSTR("--- Environment Check is Ok ---",80))
 Q
 ;
PRE ; KIDS Pre install for LR*5.2*291
 ;
 N XQA,XQAMSG
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")
 S XQAMSG=XQAMSG_" started on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 S MSG="Sending install started alert to mail group G.LMI"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install started ***",80))
 ;
 S Y=$$OPTDE^XPDUTL("LRMENU",2)
 S MSG="Disabling Laboratory DHCP Menu [LRMENU] option"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install completed ***",80))
 ;
 Q
 ;
POST ; KIDS Post install for LR*5.2*291
 ;
 N XQA,XQAMSG
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install started ***",80))
 ;
 K MSG
 S MSG(1)=" "
 S MSG(2)=" ************************ IMPORTANT ************************"
 S MSG(3)=" * Please run option LAB TESTS AND PANELS REPORT           *"
 S MSG(4)=" * [LRBE PANEL REPORT] to generate a listing of all tests  *"
 S MSG(5)=" * in the LABORATORY TEST (#60) file and the associated    *"
 S MSG(6)=" * CPT codes that will be sent to PCE for billing.  The    *"
 S MSG(7)=" * report should be used by the coders to enter the proper *"
 S MSG(8)=" * CPT codes in the LABORATORY TEST (#60) file. This option*"
 S MSG(9)=" * is located in the Lab liaison [LRLIAISON] menu.         *"
 S MSG(10)=" ***********************************************************"
 D BMES^XPDUTL(.MSG) K MSG
 ;
 S Y=$$OPTDE^XPDUTL("LRMENU",1)
 S MSG="Enabling Laboratory DHCP Menu [LRMENU] option"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install completed ***",80))
 ;
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")
 S XQAMSG=XQAMSG_" completed on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 S MSG="Sending install completion alert to mail group G.LMI"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 Q
P68 ; Modify the RESPONIBLE OFFICAL in #68
 N A,B,DIC,ENT,HD,QT,Y,USR
 S QT=0
 S A="" F  S A=$O(^LRO(68,"B",A)) Q:A=""!(QT)  D
 .S B="" F  S B=$O(^LRO(68,"B",A,B)) Q:B=""!(QT)  D
 ..I $P(^LRO(68,"B",A,B),"^",1)=1!('$D(^LRO(68,B))) Q
 ..S HD="ACCESSION AREA: "_A D EN^DDIOL(HD,"","!")
 ..S X=$$GET1^DIQ(68,B_",",".1","I")
 ..S USR=$S($D(^VA(200,+X,0)):$P(^(0),"^"),1:X)
 ..S ENT="  Old RESPONSIBLE OFFICIAL: "_USR D EN^DDIOL(ENT,"","!")
 ..S DIC="^VA(200,",DIC("A")="  New RESPONSIBLE OFFICIAL: "
 ..S DIC="^VA(200,",DIC("B")=USR,DIC(0)="AMEQZ" D ^DIC
 ..I $D(DTOUT)!($D(DUOUT))!(+Y=-1) S QT=1 K DIC Q:QT
 ..D SET(B,+Y)
 Q
SET(TIEN,RO) ; Set #68
 N LRFDA,FIL,IEN
 S FIL=68,IEN=TIEN_","
 S LRFDA(99,FIL,IEN,.1)=RO
 D UPDATE^DIE("","LRFDA(99)","","LRERR")
 Q
