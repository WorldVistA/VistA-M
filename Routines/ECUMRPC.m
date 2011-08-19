ECUMRPC ;ALB/JAM;Event Capture Management Broker Utilities ; 10/4/00 4:58pm
 ;;2.0; EVENT CAPTURE ;**25,32,33**;8 May 96
ECUSR(RESULTS,ECARY) ;
 ;
 ;This broker entry point returns an array of users with access to a 
 ;DSS unit in file 200.
 ;        RPC: EC GETDSSUNITUSRS
 ;INPUTS         ECARY - Contains the following subscripted elements
 ;               UNT   - DSS unit IEN
 ;
 ;OUTPUTS        RESULTS - The array of users. Data pieces as follows:-
 ;               PIECE - Description
 ;                 1     NAME of user
 ;                 2     DUZ or IEN of file 200
 ;
 N UNT,EDUZ,CNT
 D SETENV
 S UNT=$P(ECARY,U) Q:UNT=""
 K ^TMP($J,"ECUSR") S (EDUZ,CNT)=0
 F  S EDUZ=$O(^VA(200,EDUZ)) Q:'EDUZ  I $D(^VA(200,EDUZ,"EC",UNT,0)) D
 . S CNT=CNT+1,^TMP($J,"ECUSR",CNT)=$P(^VA(200,EDUZ,0),U)_U_EDUZ
 S RESULTS=$NA(^TMP($J,"ECUSR"))
 Q
 ;
ECLOC(RESULTS) ;
 ;
 ;This broker entry point returns all active Event Capture locations
 ;        RPC: EC GETECLOC
 ;
 ;OUTPUTS        RESULTS - The array of active Event Capture locations.
 ;               PIECE - Description
 ;                 1     Location description
 ;                 2     LOC IEN
 N LOC
 D SETENV
 K ^TMP($J,"ECLOC")
 D GETLOC^ECL(.LOC) M ^TMP($J,"ECLOC")=LOC
 S RESULTS=$NA(^TMP($J,"ECLOC"))
 Q
ECSCN(RESULTS,ECARY) ;
 ;
 ;Broker call returns the entries from EC EVENT CODE SCREENS FILE #720.3
 ;        RPC: GETECSCREEN
 ;INPUTS   ECARY   - Contains the following subscripted elements
 ;          STAT   - Active or inactive Event Code Screens
 ;                   A-ctive (default), I-nactive, B-oth
 ;          LOCIEN - Location IEN (optional)
 ;          DSSIEN - DSS IEN (optional)
 ;
 ;OUTPUTS  RESULTS - Array of EC screens, contains
 ;          720.3 ien^location description^DSS Unit description^Category
 ;          desription^Procedure 5 digit code and description
 ;
 N STAT,IEN,CNT,ACT,FL,V,EI,ECSCR,CLN,LOC,UNT,CAT,PX,NODE,LOCIEN,DSSIEN
 D SETENV K ^TMP($J,"ECSCN")
 S STAT=$P($G(ECARY,"A"),U),LOCIEN=$P($G(ECARY),U,2),FL="4,724,726"
 S V="LOC,UNT,CAT",(IEN,CNT)=0,DSSIEN=$P(ECARY,U,3)
 F  S IEN=$O(^ECJ(IEN)) Q:'IEN  S NODE=$G(^ECJ(IEN,0)) I NODE'="" D
 .S ACT=$P(NODE,U,2),ECSCR=$TR($P(NODE,U),"-;,","^^")
 .I $S(STAT="A"&(ACT'=""):1,STAT="I"&(ACT=""):1,1:0) Q
 .I LOCIEN'="",LOCIEN'=$P(ECSCR,U) Q
 .I DSSIEN'="",DSSIEN'=$P(ECSCR,U,2) Q
 .F EI=1:1:3 D
 ..S @$P(V,",",EI)=$$GET1^DIQ($P(FL,",",EI),$P(ECSCR,U,EI),.01,"E"),PX=""
 .I $P(ECSCR,U,5)["EC" D
 ..S PRO=$G(^EC(725,$P(ECSCR,U,4),0)),PX=$P(PRO,U,2)_" "_$P(PRO,U)
 .E  S PRO=$$CPT^ICPTCOD($P(ECSCR,U,4)) S PX=$P(PRO,U,2)_" "_$P(PRO,U,3)
 .S CNT=CNT+1,^TMP($J,"ECSCN",CNT)=IEN_U_LOC_U_UNT_U_CAT_U_PX
 S RESULTS=$NA(^TMP($J,"ECSCN"))
 Q
ECSDTLS(RESULTS,ECARY) ;
 ;
 ;Broker call returns details on an Event Code Screen from EC EVENT 
 ;CODE SCREENS FILE #720.3
 ;        RPC: GETECSDETAIL
 ;INPUTS   ECARY  - Contains the following data
 ;                   Event code screen IEN
 ;
 ;OUTPUTS  RESULTS - Details of EC screen, contains
 ;          720.3 ien^event code screen key^synonym^volume^associated 
 ;          clinic^Procedure reason indicator^event code screen status
 ;          flag (y-active,n-inactive)^Send To PCE
 ;
 N NODE,PRO,CLN,STAT,STR,SPCE
 Q:$G(ECARY)=""  Q:'$D(^ECJ(ECARY,0))
 D SETENV
 S NODE=^ECJ(ECARY,0),PRO=$G(^ECJ(ECARY,"PRO")),SPCE=$P(NODE,"-",2)
 S SPCE=$P($G(^ECD(SPCE,0)),U,14),SPCE=$S(SPCE="O":1,SPCE="A":1,1:0)
 S STAT=$S($P(NODE,U,2)="":"Y",1:"N")
 S:$P(PRO,U,4)'="" CLN=$$GET1^DIQ(44,$P(PRO,U,4),.01,"E")
 S STR=ECARY_U_$P(NODE,U)_U_$P(PRO,U,2,3)_U_$G(CLN)_U_$P(PRO,U,5)_U_STAT
 S RESULTS=STR_U_SPCE
 Q
 ;
DSSECS(RESULTS,ECARY) ;
 ;
 ;Broker call returns a list of Event Code Screen from EC EVENT CODE
 ;SCREENS FILE #720.3 based on a DSS Unit
 ;        RPC: EC GETDSSECS
 ;INPUTS   ECARY  - Contains the following data
 ;          ECD   - DSS Unit IEN
 ;          ECL   - Location
 ;
 ;OUTPUTS  RESULTS - Data on EC screen, contains
 ;          720.3 ien^Procedure 5 digit code and description^Location^
 ;          status(Y-active, N-inactive)^Category description^synonym
 ;
 N NODE,PRO,STAT,CNT,ECD,LOC,CAT,IEN,PX,PN,CATD,LOCDS,ECL,ECSYN
 S ECD=$P(ECARY,U),ECL=$P(ECARY,U,2) I ECD="",ECL="" Q
 D SETENV K ^TMP($J,"ECDSSECS")
 S (CNT,LOC)=0 I ECL'="" S LOC=ECL-1
 F  S LOC=$O(^ECJ("AP",LOC)) Q:'LOC  S CAT=""  Q:ECL&(ECL'=LOC)  D
 .I ECD'="" D:$D(^ECJ("AP",LOC,ECD)) GETSCN Q 
 .S ECD=0 F  S ECD=$O(^ECJ("AP",LOC,ECD)) Q:'ECD  D GETSCN
 S RESULTS=$NA(^TMP($J,"ECDSSECS"))
 Q
GETSCN F  S CAT=$O(^ECJ("AP",LOC,ECD,CAT)) Q:CAT=""  S PX="" D
 .F  S PX=$O(^ECJ("AP",LOC,ECD,CAT,PX)) Q:PX=""  S IEN=0 D
 ..F  S IEN=$O(^ECJ("AP",LOC,ECD,CAT,PX,IEN)) Q:'IEN  D
 ...S NODE=$G(^ECJ(IEN,0)) I NODE="" Q
 ...S PRO=$G(^ECJ(IEN,"PRO")),ECSYN=$P(PRO,U,2),PN=$P($P(PRO,U),";")
 ...I PN="" Q
 ...I $P(PRO,U)["EC" S PN=$G(^EC(725,PN,0)),PRO=$P(PN,U,2)_" "_$P(PN,U)
 ...E  S PN=$$CPT^ICPTCOD(PN) S PRO=$P(PN,U,2)_" "_$P(PN,U,3)
 ...S STAT=$S($P(NODE,U,2)'="":"No",1:"Yes")
 ...S CATD=$S('CAT:"None",1:$P($G(^EC(726,CAT,0)),U))
 ...S LOCDS=$$GET1^DIQ(4,LOC,.01,"I"),CNT=CNT+1
 ...S ^TMP($J,"ECDSSECS",CNT)=IEN_U_PRO_U_LOCDS_U_STAT_U_CATD_U_ECSYN
 Q
 ;
ECPXRS(RESULTS,ECARY) ;
 ;
 ;Broker call returns entries for Procedure reasons linked to EC screen.
 ;        RPC: EC GETPXREASON
 ;INPUTS   ECARY  - Contains the following subscripted elements
 ;          ECSCR - Event code screen ien (file #720.3)
 ;
 ;OUTPUTS  RESULTS - Array of procedure reasons for EC screen
 ;          Procedure reason^procedure reason ien #720.4^Event Code 
 ;          screens/procedure reason link ien #720.5
 ;
 N RSN,IEN,CNT,RIEN
 S ECSCR=$G(ECARY,"") I ECSCR="" Q
 D SETENV
 K ^TMP($J,"ECPXREAS") S (IEN,CNT)=0
 F  S IEN=$O(^ECL("AD",ECSCR,IEN)) Q:'IEN  D
 . S RSN=$G(^ECR(IEN,0)),RIEN=$O(^ECL("AD",ECSCR,IEN,0)) Q:'$P(RSN,U,2)
 . S CNT=CNT+1,^TMP($J,"ECPXREAS",CNT)=$P(RSN,U)_U_IEN_U_RIEN
 S RESULTS=$NA(^TMP($J,"ECPXREAS"))
 Q
 ;
ECNATPX(RESULTS,ECARY) ;
 ;
 ;Broker call returns EC national & local  Procedures from file #725.
 ;        RPC: EC GETNATPX
 ;INPUTS   ECARY  - Contains the following subscripted elements
 ;          ECPX - Procedures to output, L- local, N- National, B- Both
 ;          STAT - Active or inactive EC Nat Codes
 ;                 A-ctive (default), I-nactive, B-oth
 ;
 ;OUTPUTS  RESULTS - Array of EC local procedures
 ;          ien #725^Procedure name^national number^inactive date^
 ;          synonym^CPT ien^CPT code^CPT Short Name
 ;
 N STAT,IEN,STR,CNT,ACT,CPT,CPTDAT,ECPX
 D SETENV
 S ECPX=$P(ECARY,U),STAT=$P(ECARY,U,2)
 S:ECPX="" ECPX="L" S:STAT="" STAT="A"
 K ^TMP($J,"ECLOCPX")
 S IEN=$S(ECPX="L":90000,1:0),CNT=0
 F  S IEN=$O(^EC(725,IEN)) Q:'IEN!((ECPX="N")&(IEN>90000))  D
 . S STR=$G(^EC(725,IEN,0)) I STR="" Q
 . S ACT=$P(STR,U,3),CPT=$P(STR,U,5)
 . I $S(STAT="A"&(ACT'=""):1,STAT="I"&(ACT=""):1,1:0) Q
 . S CPTDAT=$S(CPT="":"",1:$$CPT^ICPTCOD(CPT))
 . S CNT=CNT+1,^TMP($J,"ECLOCPX",CNT)=IEN_U_STR_U_$P(CPTDAT,U,2,3)
 S RESULTS=$NA(^TMP($J,"ECLOCPX"))
 Q
SETENV ;set environment variables for RPC broker
 I '$G(DUZ) D
 . S DUZ=.5,DUZ(0)="@",U="^",DTIME=300
 . D NOW^%DTC S DT=X
 Q
