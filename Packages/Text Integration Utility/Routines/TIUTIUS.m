TIUTIUS ; MILW/JMC - Functions to search TIU documents; May 24, 2006 ; 2/16/16 1:49pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**296**;JUN 20, 1997;Build 25;Build 13
 ;
 ;
TASK(AUMTDA) ; Task searching of document for specified text
 N AUMTADD,I,ZTDESC,ZTDTH,ZTRTN,ZTIO,ZTSAVE,X
 I $G(AUMTDA)<1 Q
 ;
 ; Check if document is an addendum
 S AUMTADD=+$$ISADDNDM^TIULC1(AUMTDA)
 ;
 ; If original don't check if cosigned and signer different than cosigner - was checked when signed.
 F I=0,15 S X(I)=$G(^TIU(8925,AUMTDA,I))
 I 'AUMTADD,$P(X(15),"^",8),$P(X(15),"^",2),$P(X(15),"^",8)'=$P(X(15),"^",2) Q
 ; If addendum and not complete then don't check.
 I AUMTADD,$P(X(0),"^",5)'=7 Q
 ;
 S ZTDTH=$H,ZTIO="",ZTSAVE("AUMTDA")=""
 S ZTRTN="DQ^TIUTIUS",ZTDESC="Search TIU document for specified text"
 D ^%ZTLOAD
 Q
 ;
 ;
DQ ; Tasked entry point to search TIU document for specified text 
 ; that should generate an alert to appropriate CPRS team.
 ;
 N AUMTI,AUMTJ,AUMTK,AUMTMSPT,AUMTXT,AUMTVL,AUMTVLS,AUMTXQA,X,X0,X1,Y
 ;
 I '$D(^TIU(8925,AUMTDA,0)) Q
 ;
 ; Get visit location
 S AUMTVL=+$P($G(^TIU(8925,AUMTDA,12)),"^",11)
 S AUMTVL(0)=$$GET1^DIQ(44,AUMTVL_",",.01)
 ;
 ; Setup array of text events to search in the document.
 S AUMTI=0
 F  S AUMTI=$O(^TIU(8925.71,AUMTI)) Q:'AUMTI  D
 . I '$P(^TIU(8925.71,AUMTI,0),"^",2) Q
 . S X=$G(^TIU(8925.71,AUMTI,3))
 . I X="" Q
 . S AUMTXT(AUMTI)=$P(^TIU(8925.71,AUMTI,0),"^",3,4)
 . S AUMTVLS=$P(^TIU(8925.71,AUMTI,0),"^",5)
 . S X=$$LOW^XLFSTR(X) S AUMTXT(AUMTI,"T")=X
 . I $O(^TIU(8925.71,AUMTI,5,0))!(AUMTVLS'="") D
 . . I $D(^TIU(8925.71,AUMTI,5,"B",AUMTVL)) S AUMTXT(AUMTI,"VL")="" Q
 . . I AUMTVLS'="",AUMTVL(0)[AUMTVLS S AUMTXT(AUMTI,"VL")="" Q
 . . K AUMTXT(AUMTI)
 ;
 ; Check if same alert text is for two or more events and one of the
 ; events is for this document's visit location then check for specific
 ; location event text and suppress the general event.
 S AUMTI=0
 F  S AUMTI=$O(AUMTXT(AUMTI)) Q:'AUMTI  D
 . I '$D(AUMTXT(AUMTI,"VL")) Q
 . S AUMTK=0
 . F  S AUMTK=$O(AUMTXT(AUMTK)) Q:'AUMTK  D
 . . I AUMTK=AUMTI!($D(AUMTXT(AUMTK,"VL"))) Q
 . . I AUMTXT(AUMTK,"T")=AUMTXT(AUMTI,"T") K AUMTXT(AUMTK)
 ;
 ; If no active text events then quit
 I '$D(AUMTXT) Q
 ;
 ; Search the current and preceeding line for matching text, deal with
 ; text that spans two lines.
 ; Skip the event if we've already found a match on a given text event.
 S AUMTI=0,X1=""
 F  S AUMTI=$O(^TIU(8925,AUMTDA,"TEXT",AUMTI)) Q:'AUMTI  D
 . S X0=X1,X1=^TIU(8925,AUMTDA,"TEXT",AUMTI,0)
 . S X=X0_X1
 . S AUMTJ=0
 . F  S AUMTJ=$O(AUMTXT(AUMTJ)) Q:AUMTJ=""  I '$D(AUMTXQA(AUMTJ)) D
 . . S Y=X
 . . S Y=$$LOW^XLFSTR(Y)
 . . I '$P(AUMTXT(AUMTJ),"^",2) S Y=$TR(Y," ","")
 . . S AUMTZ=0 F  S AUMTZ=$O(AUMTXT(AUMTZ)) Q:AUMTZ=""  S AUMTJ=AUMTZ D
 ...I $G(Y)'="" S:Y[AUMTXT(AUMTJ,"T") AUMTXQA(AUMTJ)=AUMTJ
 ;
 ; Send any alerts
 S AUMTZ=0 S AUMTZ=$O(AUMTXQA(AUMTZ)) D:AUMTZ'="" SENDXQA
 ;
 K AUMTDA
 Q
 ;
 ;
SENDXQA ; Send Kernel alert to appropriate team or team device 
 ;
 N AUMTHL,AUMTSKIP,AUMTEAM,AUMTI,AUMTJ,AUMTK,AUMTSA
 N DFN,TIU0,TIUPNM,TIUSSN,VA,XQA,XQADATA,XQAID,XQAMSG,XQAROU,XQATEXT
 ;
 S TIU0=$G(^TIU(8925,AUMTDA,0)),DFN=+$P(TIU0,U,2)
 S TIUPNM=$E($$PTNAME^TIULC1(DFN),1,9)
 D PID^VADPT6
 S TIUSSN=$E(TIUPNM,1)_VA("BID")
 ;
 ; Get hospital location for alert message text
 S AUMTHL=+$P($G(^TIU(8925,AUMTDA,12)),"^",5)
 S AUMTHL(0)=$$GET1^DIQ(44,AUMTHL_",",1)
 ;
 ; Send alert to each team's members and other additional recipients.
 S AUMTI=0
 F  S AUMTI=$O(AUMTXQA(AUMTI)) Q:AUMTI=""  D
 . K XQA,XQADATA,XQADFN,XQAID,XQAMSG,XQAROU,XQATEXT
 . S XQAID="TIUADD"_AUMTDA,XQADATA=AUMTDA_"^",XQAROU="ACTADD^TIUALRT"
 . S XQAMSG=TIUPNM_" ("_TIUSSN_"): ("_AUMTHL(0)_") "_$P($G(^TIU(8925.71,AUMTI,2)),"^")
 . S AUMTK=0
 . F  S AUMTK=$O(^TIU(8925.71,AUMTI,4,AUMTK)) Q:'AUMTK  D
 . . K AUMTEAM
 . . S AUMTEAM=+^TIU(8925.71,AUMTI,4,AUMTK,0)
 . . I AUMTEAM>0 D ADDTEAM(AUMTEAM)
 . D ADDRECP
 . I $D(XQA) D SETUP^XQALERT
 ;
 ; Send alert to signer that teams have been notified.
 I $D(AUMTSA) D SENDSA
 Q
 ;
 ;
SENDSA ; Build and sent alerts to signer
 ;
 N AUMTCNT,AUMTDUZ,AUMTI,AUMTMSG
 N XQA,XQADATA,XQADFN,XQAID,XQAMSG,XQAROU,XQATEXT
 ;
 S AUMTDUZ=+$P($G(^TIU(8925,AUMTDA,15)),"^",2)
 I 'AUMTDUZ Q
 S AUMTI=0,AUMTMSG="Alert(s) Sent: "
 F  S AUMTI=$O(AUMTSA(AUMTI)) Q:'AUMTI  S AUMTMSG=AUMTMSG_$P($G(^TIU(8925.71,AUMTI,2)),"^",2)_"," D
 . S XQAID="AUMTIU,"_AUMTDA
 . S XQAMSG=TIUPNM_" ("_TIUSSN_"): "_AUMTMSG
 . S XQA(AUMTDUZ)=""
 . D SETUP^XQALERT
 Q
 ;
 ;
SKIP() ; Check if we should skip alerting this team if they already have been sent an alert.
 ;
 N AUMTJ,AUMTSKIP
 S (AUMTJ,AUMTSKIP)=0
 F  S AUMTJ=$O(AUMTSA(AUMTJ)) Q:'AUMTJ!(AUMTJ>AUMTI)  D
 . I AUMTI'=AUMTJ,$D(AUMTSA(AUMTJ,AUMTEAM)) S AUMTSKIP=1 Q
 Q AUMTSKIP
 ;
 ;
ADDRECP ; Send to additional notification recipients.
 ; If no associate PC provider(3) then check and send to PC provider (1).
 ; If team (6) then check if patient is member of team.
 ; If PCP (7-19) checks for associated PCP in PATIENT file (#2) , fields 695021-695033
 ;
 N AUMTJ,AUMTK,AUMTL,AUMTX
 S (AUMTJ,AUMTK,AUMTL)=0
 F  S AUMTL=$O(^TIU(8925.71,AUMTI,4.5,AUMTL)) Q:'AUMTL  D
 . S AUMTL(0)=^TIU(8925.71,AUMTI,4.5,AUMTL,0)
 . S AUMTK=$P(AUMTL(0),"^")
 . I AUMTK<4 D  Q
 . . S AUMTJ=$$NMPCPR^SCAPMCU2(DFN,DT,AUMTK)
 . . I AUMTK=3,AUMTJ<1 S AUMTJ=$$NMPCPR^SCAPMCU2(DFN,DT,1)
 . . S:AUMTJ>0 XQA($P(AUMTJ,"^"))=""
 . I AUMTK>3,AUMTK<6 D  Q
 . . D ATTPRIM^ORQPTQ3(.AUMTX,DFN)
 . . I $P(AUMTX,";",AUMTK-3) S XQA($P($P(AUMTX,";",AUMTK-3),"^"))=""
 . I AUMTK=6 D CHKTEAM($P(AUMTL(0),"^",2)) Q
 . I AUMTK>6,AUMTK<20 D  Q
 . . S AUMTX=$G(^DPT(DFN,695002))
 . . I $P(AUMTX,"^",AUMTK-6) S XQA($P(AUMTX,"^",AUMTK-6))=""
 Q
 ;
 ;
CHKTEAM(AUMTEAM) ; Check if this patient is linked to this team
 ;
 ; Call with AUMTEAM = ien of team in file 100.21
 ;
 N I
 I '$D(AUMTMSPT) D TMSPT^ORQPTQ1(.AUMTMSPT,DFN)
 S I=0
 F  S I=$O(AUMTMSPT(I)) Q:'I  I $P(AUMTMSPT(I),"^")=AUMTEAM D ADDTEAM(AUMTEAM)
 Q
 ;
 ;
ADDTEAM(AUMTEAM) ; Add members of team to list of recipients
 ;
 ; Call with AUMTEAM = ien of team in file 100.21
 ;
 N AUMTD,AUMTDEV,AUMTJ
 ;I $$SKIP Q
 S AUMTD=$P($$TMDEV^ORB31(AUMTEAM),"^",2)
 I AUMTD'="" S AUMTDEV(AUMTD)="" D REGDEV^ORB31(.AUMTDEV)
 D TEAMPROV^ORQPTQ1(.AUMTEAM,AUMTEAM)
 I '$G(AUMTEAM(1)) Q
 S AUMTSA(AUMTI,AUMTEAM)=""
 S AUMTJ=0
 F  S AUMTJ=$O(AUMTEAM(AUMTJ)) Q:'AUMTJ  S XQA(+AUMTEAM(AUMTJ))=""
 Q
