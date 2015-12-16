ECXSCLD ;BIR/DMA,CML-Enter, Print and Edit Entries in 728.44 ;5/20/15  13:29
 ;;3.0;DSS EXTRACTS;**2,8,24,30,71,80,105,112,120,126,132,136,142,144,149,154**;Dec 22, 1997;Build 13
EN ;entry point from option
 ;load entries
 N DIR,X,Y,DIRUT,DTOUT,DUOUT ;144
 W !!,"This option creates local entries in the DSS CLINIC AND STOP CODES"
 W !,"file (#728.44).",! ;144
 I '$D(^ECX(728.44)) W !,"DSS Clinic stop code file does not exist",!! R X:5 K X Q
 ;W !!,"It also compares file #728.44 to the HOSPITAL LOCATION file (#44) to see" ;144
 ;W !,"if there are any differences since the last time the file was reviewed." ;144
 ;W !!,"Any differences or new entries will cause an UNREVIEWED CLINICS report" ;144
 ;W !,"to automatically print.",! ;144
 ;D SELECT^ECXSCLD ;144
 ;144 does user hold key?
 I '$$KCHK^XUSRB("ECXMGR",$G(DUZ)) D  G ENDX ;144
 .W !!,?5,"You do not have approved access to this option.",!,"Exiting...",!! ;144
 .D PAUSE ;144
 W !,"The CREATE option last ran on ",$S($D(^ECX(728.44,"C")):$$FMTE^XLFDT($O(^ECX(728.44,"C"," "),-1),2),1:"- No date on file"),".",! ;144
 S DIR(0)="Y",DIR("A")="Do you want to run the CREATE option",DIR("B")="N" D ^DIR Q:Y'=1  ;144
 W !,"Running CREATE..." ;144
 D START ;144
 W !!,"The CREATE option has completed on ",$$FMTE^XLFDT($$NOW^XLFDT),".",! ;144
 S DIR(0)="Y",DIR("A")="Proceed to DSS Clinic and Stop Code Print menu",DIR("B")="NO" D ^DIR ;144
 D:Y PRINT ;144
 Q
START ; entry point
 N ZTREQ
 S EC=0 F  S EC=$O(^SC(EC)) Q:'EC  D FIX(EC)
 K DIK S DIK="^ECX(728.44,",DIK(1)=".01^B" D ENALL^DIK
 S ZTREQ="@"
 Q
 ;
FIX(EC) ;
 ; synchronize files #44 and #728.44.
 N DIE,DA,DR ;144
 ; differences are placed in ^XTMP("ECX UNREVIEWED CLINICS")
 S EC=$G(EC)
 I '$D(^SC(EC,0)) Q
 N ECD,DAT
 S ECD=^SC(EC,0),DAT=$G(^SC(EC,"I"))
 I $P(ECD,U,3)'="C" I '$D(^ECX(728.44,EC,0)) Q  ;144 Allow updates if entry already exists in 728.44 even if it's no longer a clinic
 ; get stop codes and default style for feeder key
 ; 1 if no credit stop code - 5 if credit stop code exists
 K ECD2,ECS2,ECDNEW,ECDDIF,ECSCSIGN I $D(^ECX(728.44,EC,0)) S (ECD2,ECDDIF)=^(0),ECSCSIGN=""
 I $D(ECD2) F ECS=2,3,4,5 D
 .S (ECS2(ECS),X)=$P(ECD2,U,ECS)
 .K DIC,Y S DIC=40.7,DIC(0)="MXZ" D ^DIC
 .I +$G(Y)>0 S $P(ECS2(ECS),U,2)=$P(^DIC(40.7,+Y,0),U,3)
 S ID=+DAT,RD=$P(DAT,U,2)
 ;change in clinic inactivation for existing entry 
 I $D(ECD2) D
 .;don't include already old inactivated clinics in report
 .I ID,ID'>DT I ('RD)!(RD>DT) I $P(ECD2,U,10)'=ID D
 ..S $P(ECD2,U,7)="",$P(ECD2,U,10)=ID,ECSCSIGN="*"
 .I ID,RD,(RD'>DT) I $P(ECD2,U,10) D
 ..S $P(ECD2,U,7)="",$P(ECD2,U,10)="",ECSCSIGN="r"
 .I ID,(ID>DT) I $P(ECD2,U,10) D
 ..S $P(ECD2,U,7)="",$P(ECD2,U,10)="",ECSCSIGN="!"
 .I 'ID,$P(ECD2,U,10) D
 ..S $P(ECD2,U,7)="",$P(ECD2,U,10)="",ECSCSIGN="!"
 .S ECDDIF=ECD2
 ;setup for stops
 F ECS=7,18 S ECP=+$P(ECD,U,ECS),ECS(ECS)=$P($G(^DIC(40.7,ECP,0)),U,2)_U_$P($G(^DIC(40.7,ECP,0)),U,3)
 S ECDF=$S($P(ECS(18),U)]"":5,1:1) S:$P(ECD,U,17)="Y" ECDF=6 S:$G(^SC(EC,"OOS")) ECDF=6
 S ECDB=EC_U_$S(+ECS(7):+ECS(7),1:"")_U_$S(+ECS(18):+ECS(18),1:"")_U_$S(+ECS(7):+ECS(7),1:"")_U_$S(+ECS(18):+ECS(18),1:"") ;154 added DSS SC CSC
 ;new entry
 I '$D(ECD2) D
 .S $P(^ECX(728.44,EC,0),U,1,5)=ECDB ;154
 .;S $P(^ECX(728.44,EC,0),U,1,5)=ECDB_U_$S(+ECS(7):+ECS(7),1:"")_U_$S(+ECS(18):+ECS(18),1:"")
 .S $P(^(0),U,6)=ECDF,$P(^(0),U,12)=$P(ECD,U,17)
 .S ECDNEW=^ECX(728.44,EC,0)
 ;changes to existing entry
 I $D(ECD2) D
 .S $P(ECD2,U,1,5)=ECDB,$P(ECDDIF,U,1,3)=ECDB ;154 ADDED DSS SC CSC
 .;differs in stop code
 .I +ECS(7)'=+ECS2(2) S $P(ECD2,U,7)="",X=$P(ECDDIF,U,2)_"!",$P(ECDDIF,U,2)=X ;W !," SC ",?10,X,?20,ECS(7),?40,ECS2(2)
 .;154 added DSS STOP CODE
 .I +ECS(7)'=+ECS2(4) S $P(ECD2,U,7)="",X=$P(ECDDIF,U,4)_"!",$P(ECDDIF,U,4)=X ;W !,"DSS SC ",?10,X,?20,ECS(7),?40,ECS2(4)
 .;differs in credit stop code
 .I +ECS(18)'=+ECS2(3) S $P(ECD2,U,7)="",X=$P(ECDDIF,U,3)_"!",$P(ECDDIF,U,3)=X
 .;154 added DSS CREDIT STOP CODE
 .I +ECS(18)'=+ECS2(5) S $P(ECD2,U,7)="",X=$P(ECDDIF,U,5)_"!",$P(ECDDIF,U,5)=X ; W !,"DSS CSC",!
 .;change in non-count
 .I $P(ECD2,U,12)'=$P(ECD,U,17) S X=$P(ECD,U,17)_"!",$P(ECDDIF,U,12)=X,$P(ECD2,U,12)=$P(ECD,U,17),$P(ECD2,U,7)=""
 .;reset entry
 .S ^ECX(728.44,EC,0)=ECD2
 ;set tmp node
 S ECSC=$P(ECD,U) S:$L(ECSC)>27 ECSC=$E(ECSC,1,27)
 I $D(ECD2),$P(ECD2,U,7)="" D
 .I $D(^XTMP("ECX UNREVIEWED CLINICS",ECSC)) D UPDATE(ECSC,ECDDIF,ECSCSIGN)
 .I '$D(^XTMP("ECX UNREVIEWED CLINICS",ECSC)) S ^XTMP("ECX UNREVIEWED CLINICS",ECSC)=ECSCSIGN_U_$P(ECDDIF,U,2,200),^XTMP("ECX UNREVIEWED CLINICS",ECSC,"T")=$$NOW^XLFDT()
 I $D(ECDNEW) S ^XTMP("ECX UNREVIEWED CLINICS",ECSC)=""_U_$P(ECDNEW,U,2,200),^XTMP("ECX UNREVIEWED CLINICS",ECSC,"T")=$$NOW^XLFDT()
 S DIE=728.44,DA=EC,DR="12///TODAY" D ^DIE ;144 Set create date to today's date
 Q
 ;
UPDATE(ECSC,ECDDIF,ECSCSIGN) ;update ^xtmp node with today's changes
 N ECXOLD,J,L1,L2,X,X1,X2
 S ECXOLD=^XTMP("ECX UNREVIEWED CLINICS",ECSC)
 F J=2,3,4,5 S X1=+$P(ECXOLD,U,J),X2=+$P(ECDDIF,U,J) I X2=X1,$P(ECDDIF,U,J)'=$P(ECXOLD,U,J) D
 .S L1=$L($P(ECXOLD,U,J)),L2=$L($P(ECDDIF,U,J))
 .I L1>L2 S $P(ECDDIF,U,J)=$P(ECXOLD,U,J)
 S X1=$E($P(ECXOLD,U,12),1),X2=$E($P(ECDDIF,U,12),1) I X2=X1 S $P(ECDDIF,U,12)=$P(ECXOLD,U,12)
 S X1=$P(ECXOLD,U),X=X1_U_$P(ECDDIF,U,2,200)
 I ECSCSIGN'="",ECSCSIGN'=X1 S X=ECSCSIGN_U_$P(ECDDIF,U,2,200)
 S ^XTMP("ECX UNREVIEWED CLINICS",ECSC)=X
 Q
 ;
SELECT ;select IO device to 'gather clinic stop codes' and print 'unreviewd clinics' report;
 ;for menu option 'Create DSS Clinic Stop Code File' or 'Clinics and DSS Stop Codes Print'
 N DIR,ECALL,IOP,POP,XX,ZTIO,ZTRTN,ZTDESC,ZTSK,ZTSAVE
 ;does user hold key?
 I '$$KCHK^XUSRB("ECXMGR",$G(DUZ)) D  G ENDX
 .W !!,?5,"You do not have approved access to this option.",!,"Exiting...",!!
 .D PAUSE
 W !,"Please select a print device for the 'Unreviewed Clinics' report."
 W !,"**Please note: If printing in foreground, synching files may cause screen delay."
 W ! S %ZIS="Q" D ^%ZIS
 I POP Q
 ;queue the report
 I $D(IO("Q")) D  Q
 . K ZTSAVE S ZTDESC="Gather Clinic Stop Codes for DSS",ZTRTN="START^ECXSCLD"
 . D ^%ZTLOAD
 . I $G(ZTSK) W !,"Queued as Task #: "_ZTSK D ENDX D PAUSE
 W !!,">> Synchronizing Stop Codes file (#728.44) with the Hospital"
 W !,"   Location file (#44)...",!
 D START
 D ^%ZISC,HOME^%ZIS K IO("Q")
 Q
 ;
PRINT ; print worksheet for updates
 N OUT,DIR,ECALL
 I '$O(^ECX(728.44,0)) W !,"DSS Clinic stop code file does not exist",!! R X:5 K X Q
 W !!,"This option produces a worksheet of (A) All Clinics, (C) Active, (D) Duplicate, (I) Inactive, "
 W !,"or only the (U) Unreviewed Clinics that are awaiting approval."
 W !!,"Clinics that were defined as ""inactive"" by MAS the last time the option"
 W !,"""Create DSS Clinic Stop Code File"" was run will be indicated with an ""*""."
 W !!,"Choose (X) for exporting the CLINICS AND STOP CODES FILE to a text file for"
 W !,"spreadsheet use.",!
 W !,"**REMINDER - The CREATE option last ran on ",$S($D(^ECX(728.44,"C")):$$FMTE^XLFDT($O(^ECX(728.44,"C"," "),-1),2),1:"- No date on file"),"." ;144
 W !,"If the most recent clinic changes from the HOSPITAL LOCATION file #44",!,"are desired, run the CREATE option before running a report.**",! ;144
 S DIR(0)="S^A:ALL CLINICS;C:ALL ACTIVE CLINICS;D:DUPLICATE CLINICS;I:ALL INACTIVE CLINICS;U:UNREVIEWED CLINICS;X:EXPORT TO TEXT FILE FOR SPREADSHEET USE",DIR("A")="Enter ""A"", ""C"", ""D"", ""I"", ""U"", or ""X""" ;149
 S DIR("?",1)="Enter: ""C"" to print a worksheet of all active DSS Clinic Stops,"
 S DIR("?",2)="Enter: ""I"" to print a worksheet of all inactive DSS Clinic  Stops,"
 S DIR("?",3)="Enter: ""A"" to print a worksheet of all DSS Clinic  Stops,"
 S DIR("?",4)="Enter: ""U"" to print only the Clinic Stops that have not been approved."
 S DIR("?",5)="Enter: ""D"" to print the Duplicate Clinics found." ;149
 S DIR("?")="Enter: ""X"" to export CLINICS AND STOP CODES FILE to a text file."
 D ^DIR K DIR G ENDX:$D(DIRUT) S ECALL=$E(Y)
 I ECALL="X" D EXPORT^ECXSCLD1 Q
 ;sync #728.44 with #44 before printing 'unreviewed'
 S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) K ZTSAVE S ZTDESC="DSS clinic stop code work sheet",ZTRTN="SPRINT^ECXSCLD",ZTSAVE("ECALL")="" D ^%ZTLOAD,HOME^%ZIS Q
SPRINT ; queued entry to print work sheet
 N DC,ECSDC,DIV1,DIV2,APPL,APPL1,APPL2,STOPC,CREDSC,NATC,DUPIEN,FIEN,ECSC,ECSCI,ECSC2 ;149
 U IO
 S QFLG=0,$P(LN,"-",80)="",PG=0
 S ECDATE=$O(^ECX(728.44,"A1","")) I ECDATE S ECDATE=-ECDATE,ECDATE=$$FMTE^XLFDT(ECDATE,"5DF"),ECDATE=$TR(ECDATE," ","0")
 K ^TMP("EC",$J) ;144
 I ECALL'="D" D
 .F J=0:0 S J=$O(^ECX(728.44,J)) Q:'J  I $D(^ECX(728.44,J,0)) S ECSD=^ECX(728.44,J,0) D
 ..I $P($G(^SC(J,0)),U,3)'="C" Q  ;144 Don't include entries that aren't clinic types
 ..I ECALL="A" I $D(^SC(J,0)) S ECSC=$P(^SC(J,0),U),^TMP("EC",$J,ECSC)=$P(ECSD,U,2,200)
 ..I (ECALL="I"),($P(ECSD,U,10)) I $D(^SC(J,0)) S ECSC=$P(^SC(J,0),U),^TMP("EC",$J,ECSC)=$P(ECSD,U,2,200)
 ..I ((ECALL="C")&($P(ECSD,U,10)=""))!((ECALL="C")&($P(ECSD,U,10)>DT)) I $D(^SC(J,0)) S ECSC=$P(^(0),U),^TMP("EC",$J,ECSC)=$P(ECSD,U,2,200)
 ..I ECALL="U" I $P(ECSD,U,7)="" I $D(^SC(J,0)) S ECSC=$P(^SC(J,0),U),^TMP("EC",$J,ECSC)=$P(ECSD,U,2,200) ;144
 .D HEAD S ECSC="" I $O(^TMP("EC",$J,ECSC))="" W !!,"NO DATA FOUND FOR WORKSHEET.",! Q  ;144
 .I ECALL'="D" D  ;149
 ..F J=1:1 S ECSC=$O(^TMP("EC",$J,ECSC)) Q:ECSC=""  S ECD=^TMP("EC",$J,ECSC) D SHOWEM Q:QFLG  ;149
 I ECALL="D" D
 .S FIRST=1
 .F DC=0:0 S DC=$O(^ECX(728.44,DC)) Q:'DC  I $D(^ECX(728.44,DC,0)) S ECSDC=^ECX(728.44,DC,0) D
 ..I $P($G(^SC(DC,0)),U,3)'="C"!($P(^ECX(728.44,DC,0),U,10)'="") Q  ;149 Don't include non clinic types or inactive ones
 ..I $D(^SC(DC,0)) D
 ...S STOPC=$P(ECSDC,U,2),CREDSC=$P(ECSDC,U,3),NATC=$P(ECSDC,U,8) ;154 CVW
 ...S DIV=$$GET1^DIQ(44,$P(ECSDC,U),3.5,"I"),APPL=$$GET1^DIQ(44,$P(ECSDC,U),1912,"I")
 ...I 'FIRST D
 ....I ($D(^TMP("EC",$J,1_STOPC_CREDSC_NATC_DIV_APPL))) D
 .....S ^TMP("EC",$J,1_STOPC_CREDSC_NATC_DIV_APPL,0)="1"
 ...S ECSC=$P(^SC(DC,0),U),^TMP("EC",$J,1_STOPC_CREDSC_NATC_DIV_APPL,DC,ECSC)=$P(ECSDC,U,1,200)_U_APPL_U_DIV
 ..I FIRST D
 ...S ECSC=$P(^SC(DC,0),U),^TMP("EC",$J,1_STOPC_CREDSC_NATC_DIV_APPL,DC,ECSC)=$P(ECSDC,U,1,200)_U_APPL_U_DIV,FIRST=0
 .D HEAD S ECSC="" I $O(^TMP("EC",$J,ECSC))="" W !!,"NO DATA FOUND FOR WORKSHEET.",! Q  ;144
 I ECALL="D" D
 .S KEY="" F  S KEY=$O(^TMP("EC",$J,KEY)) Q:'+KEY  I $G(^TMP("EC",$J,KEY,0)) Q:QFLG  D
 ..S IEN=0 F  S IEN=$O(^TMP("EC",$J,KEY,IEN)) Q:'+IEN!(QFLG)  S NAME="" F  S NAME=$O(^TMP("EC",$J,KEY,IEN,NAME)) Q:NAME=""!(QFLG)  D
 ...I $Y+6>IOSL D HEAD Q:QFLG
 ...W !,$E($P(^SC(IEN,0),U),1,25)
 ...W:$P(^TMP("EC",$J,KEY,IEN,NAME),U,10)]"" "*" ;149
 ...W ?28,$P(^TMP("EC",$J,KEY,IEN,NAME),U),?40,$P(^TMP("EC",$J,KEY,IEN,NAME),U,4),?46,$P(^TMP("EC",$J,KEY,IEN,NAME),U,5),?55,$$GET1^DIQ(728.441,$P(^TMP("EC",$J,KEY,IEN,NAME),U,8),.01)
 ...W ?63,$P(^TMP("EC",$J,KEY,IEN,NAME),U,14),?72,$P(^TMP("EC",$J,KEY,IEN,NAME),U,15)
 ..Q:QFLG  W !
 ..I $Y+6>IOSL D HEAD Q:QFLG
 K ^TMP("EC",$J) ;144 
  I $E(IOST)="C",'QFLG D SS^ECXSCLD1 D ENDX
 W:$Y @IOF D ^%ZISC S ZTREQ="@"
 Q
HEAD ; header for worksheet 149 moved to ECXSCLD1 due to size
 D HEAD^ECXSCLD1
 Q
 ;
SHOWEM ; list clinics for worksheet 149 moved to ECXSCLD1 due to size
 D SHOWEM^ECXSCLD1
 Q
EDIT ; put in DSS stopcodes and which one to send
 I '$O(^ECX(728.44,0)) W !,"DSS Clinic stop code file does not exist",!! R X:5 K X Q
 ;patch 142-added for loop to allow for new clinic prompt
 F  W ! K DIC S DIC=728.44,DIC(0)="QEAMZ",DIC("S")="I $P($G(^SC(Y,0)),U,3)=""C""" D ^DIC Q:Y<0  D  ;149
 .S CLIEN1=+Y
 .W !!,"EXISTING CLINIC FILE DATA:" ;,?35,"EXISTING DSS CLINIC FILE DATA:" 154
 .W !!,"STOP CODE:        ",$P(Y(0),U,2) ;,?35,"DSS STOP CODE :   ",$P(Y(0),U,4) 154
 .W !,"CREDIT STOP CODE: ",$P(Y(0),U,3) ;,?35,"DSS CREDIT STOP CODE :",$P(Y(0),U,5) 154
 .W !
 .D ENDCHK
 .;D EDIT1 154 **EDIT1 code was moved to ECXSCLD1 for space
 D ENDX
 Q
ENDCHK ;check validity of clinic
 N ECXB4ARR,ECXAFARR,ECXCHNG ;154
 S ECXCHNG=0 ;154
 ;154 REMOVED ALL ERROR CHECKING SINCE EDIT OF FIELDS REMOVED **EDIT1 code was moved to ECXSCLD1 for space
 ;S CODE=$P(^ECX(728.44,CLIEN1,0),U,4)
 ;K ERR,WRN,ECXERR,WARNING,ERRCHK
 ;S ERRCHK=0
 ;D STOP^ECXSTOP(CODE,"DSS Stop Code",CLIEN1) D ERRPRNT
 ;I $D(ECXERR) S ERRCHK=1
 ;K ERR,WRN,ECXERR,WARNING
 ;S CODE=$P(^ECX(728.44,CLIEN1,0),U,5)
 ;D STOP^ECXSTOP(CODE,"Credit Stop Code",CLIEN1) D ERRPRNT
 ;I $D(ECXERR) S ERRCHK=1
 ;W; !!,"...Validity Checker Complete."
 ;I ERRCHK=1 W !!,"...Errors found please fix." G EDIT1
 ;remaining fields
 D GETS^DIQ(728.44,CLIEN1,"5;7;8","I","ECXB4ARR")
 S DIE=728.44,DA=+CLIEN1
 ;S DR="5//1;S:X'=4 Y=6;7CHAR4 CODE;6///"_DT_";8;10" D ^DIE ;136
 S DR="5//1;S:X'=4 Y=8;7CHAR4 CODE;8;10" D ^DIE ;154
 S:$P(^ECX(728.44,DA,0),U,6)'=4 $P(^ECX(728.44,CLIEN1,0),U,8)="" ;S $P(^(0),U,7)="" ;154
 D GETS^DIQ(728.44,CLIEN1,"5;7;8","I","ECXAFARR") ;154
 F I=5,7,8 I ECXB4ARR(728.44,CLIEN1_",",I,"I")'=ECXAFARR(728.44,CLIEN1_",",I,"I") S ECXCHNG=1 Q  ;154
 I ECXCHNG S $P(^ECX(728.44,CLIEN1,0),U,7)="" ;154
 Q
ERRPRNT ;print errors 149 moved to ECXSCLD1 due to size
 D ERRPRNT^ECXSCLD1
 Q
KILL ;
 K I,WARNING,DIC,DIE,DA,DR,DIR,DIRUT,DTOUT,DUOUT,X,Y,ERRCHK
 K CLIEN1,CODE,ECXMSG,IENS,STOP,CSTOP,AMIS,FDA,OUT,ERR,WRN,ECXERR
 G EDIT
 ;
ERRCHK(CODE,TYPE,CLIEN1) ;check for problems 149 moved to ECXSCLD1 due to size
 Q $$ERRCHK^ECXSCLD1(CODE,TYPE,CLIEN1)
 ;
APPROVE ; approve current DSS Stop and Credit Stop codes
 W !!,"This option allows you to mark the current clinic entries in the CLINICS AND",!,"STOP CODES file (#728.44) as ""reviewed"".  Those entries will then be omitted"
 W !,"from the list printed from the ""Clinic and DSS Stop Codes Print"" when you",!,"choose to print only ""unreviewed"" clinics.",!
 K DIR S DIR(0)="Y",DIR("A",1)="Are you ready to approve the reviewed information provided by the",DIR("A")="""Clinic and DSS Stop Codes Print""",DIR("B")="NO"
 S DIR("?",1)="   Enter:"
 S DIR("?",2)="     ""YES"" if you concur with the ""Clinic and DSS Stop Codes Print"","
 S DIR("?",3)="     ""NO"" or <RET> if you do not want to approve the current information,"
 S DIR("?")="     ""^"" to exit option."
 D ^DIR K DIR I 'Y!($D(DIRUT)) G ENDX
 W ! S ZTRTN="APPLOOP^ECXSCLD",ZTIO="",ZTDESC="Approve DSS stop codes for clinic extract" D ^%ZTLOAD W !!,"...approval queued" G ENDX
 ;
APPLOOP ; queued entry to approve action codes
 F EC=0:0 S EC=$O(^ECX(728.44,EC)) Q:'EC  I $D(^ECX(728.44,EC,0)) S DA=EC,DIE="^ECX(728.44,",DR="6///"_DT D ^DIE
 S ZTREQ="@"
 K ^XTMP("ECX UNREVIEWED CLINICS") S ^XTMP("ECX UNREVIEWED CLINICS",0)=$$FMADD^XLFDT(DT,180)_U_DT_U_"ECX UNREVIEWED CLINICS"
ENDX K X,Y,DA,DR,DIC,DIE,QFLG,PG,LN,ZTRTN,ZTIO,ZTDESC
 K DIR,DIRUT,DTOUT,DUOUT,CLIEN,CODE,ECXMSG,IENS,STOP,CSTOP,AMIS,FDA,OUT
 K J,ECSC,ECSD,ECDATE,ECD,ECN,ECNON,QFLG,PG,LN,SS,POP,%ZIS
 K EC,ECD,ECD2,ECL,ECS,ECS2,ECP,ECSC,ECSC2,ECDB,ECDNEW,ECDDIF,ECSCSIGN,ECDF,ECALL,ID,RD
 ;ECXINAC-patch 142 removed variable,it is no longer used
 Q
 ;
PAUSE ;pause screen
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S DIR(0)="E" W !! D ^DIR W !!
 Q
 ;
LOOK ;queued entry to check for new clinics
 N DAT,ECD0,ECXMISS,ID,ECGRP
 S ECD=$E(DT,1,5)-1-($E(DT,4,5)="01"*8800),ECD0=ECD_"00",ECXMISS=10,ECGRP="SCX" K ^TMP("ECXS",$J)
 F EC=0:0 S EC=$O(^SC(EC)) Q:'EC  I $D(^SC(EC,0)),$P(^SC(EC,0),U,3)="C",'$D(^ECX(728.44,EC)) S DAT=$G(^SC(EC,"I")) D
 .S ID=+DAT,RD=$P(DAT,U,2) I ID,ID<DT I 'RD!(RD>DT) Q
 .S ^TMP("ECXS",$J,ECXMISS,0)=$J(EC,6)_"    "_$$LJ^XLFSTR($P(^SC(EC,0),U),40),ECXMISS=ECXMISS+1
 D ^ECXSCX1
 Q
