ECXSCLD ;BIR/DMA,CML-Enter, Print and Edit Entries in 728.44 ;9/4/12  12:55
 ;;3.0;DSS EXTRACTS;**2,8,24,30,71,80,105,112,120,126,132,136**;Dec 22, 1997;Build 28
EN ;entry point from option
 ;load entries
 W !!,"This option creates local entries in the DSS CLINIC AND STOP CODES"
 W !,"file (#728.44)."
 I '$D(^ECX(728.44)) W !,"DSS Clinic stop code file does not exist",!! R X:5 K X Q
 W !!,"It also compares file #728.44 to the HOSPITAL LOCATION file (#44) to see"
 W !,"if there are any differences since the last time the file was reviewed."
 W !!,"Any differences or new entries will cause an UNREVIEWED CLINICS report"
 W !,"to automatically print.",!
 D SELECT^ECXSCLD
 Q
START ; entry point
 N ZTREQ
 S EC=0 F  S EC=$O(^SC(EC)) Q:'EC  D FIX(EC)
 K DIK S DIK="^ECX(728.44,",DIK(1)=".01^B" D ENALL^DIK
 ;print 'unreviewed clinics' report
 S ECALL="U" D SPRINT^ECXSCLD
 S ZTREQ="@"
 Q
 ;
FIX(EC) ;
 ; synchronize files #44 and #728.44.
 ; differences are placed in ^XTMP("ECX UNREVIEWED CLINICS")
 S EC=$G(EC)
 I '$D(^SC(EC,0)) Q
 N ECD,DAT
 S ECD=^SC(EC,0),DAT=$G(^SC(EC,"I"))
 I $P(ECD,U,3)'="C" Q
 ; get stop codes and default style for feeder key
 ; 1 if no credit stop code - 5 if credit stop code exists
 K ECD2,ECS2,ECDNEW,ECDDIF,ECSCSIGN I $D(^ECX(728.44,EC,0)) S (ECD2,ECDDIF)=^(0),ECSCSIGN=""
 I $D(ECD2) F ECS=2,3,4,5 D
 .S (ECS2(ECS),X)=$P(ECD2,U,ECS)
 .K DIC,Y S DIC=40.7,DIC(0)="MXZ" D ^DIC
 .I +$G(Y)>0 S $P(ECS2(ECS),U,2)=$P(^DIC(40.7,+Y,0),U,3)
 S ID=+DAT,RD=$P(DAT,U,2),ECXINAC=0
 ;change in clinic inactivation for existing entry 
 I $D(ECD2) D
 .;don't include already old inactivated clinics in report
 .I ID,ID'>DT I ('RD)!(RD>DT) I $P(ECD2,U,10)=ID S ECXINAC=1
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
 S ECDB=EC_U_$S(+ECS(7):+ECS(7),1:"")_U_$S(+ECS(18):+ECS(18),1:"")
 ;new entry
 I '$D(ECD2) D
 .S $P(^ECX(728.44,EC,0),U,1,5)=ECDB_U_$S(+ECS(7):+ECS(7),1:"")_U_$S(+ECS(18):+ECS(18),1:"")
 .S $P(^(0),U,6)=ECDF,$P(^(0),U,12)=$P(ECD,U,17)
 .S ECDNEW=^ECX(728.44,EC,0)
 ;changes to existing entry
 I $D(ECD2) D
 .S $P(ECD2,U,1,3)=ECDB,$P(ECDDIF,U,1,3)=ECDB
 .;differs in stop code
 .I +ECS(7)'=+ECS2(2) S $P(ECD2,U,7)="",X=$P(ECDDIF,U,2)_"!",$P(ECDDIF,U,2)=X
 .;differs in credit stop code
 .I +ECS(18)'=+ECS2(3) S $P(ECD2,U,7)="",X=$P(ECDDIF,U,3)_"!",$P(ECDDIF,U,3)=X
 .;stop code inactive
 .;I $P(ECS(7),U,2) S $P(ECD2,U,7)="",X=$P(ECDDIF,U,2)_"*",$P(ECDDIF,U,2)=X
 .;credit stop code inactive
 .;I $P(ECS(18),U,2) S $P(ECD2,U,7)="",X=$P(ECDDIF,U,3)_"*",$P(ECDDIF,U,3)=X
 .;dss stop code inactive
 .;I $P(ECS2(4),U,2) S $P(ECD2,U,7)="",X=$P(ECDDIF,U,4)_"*",$P(ECDDIF,U,4)=X
 .;dss credit stop code inactive
 .;I $P(ECS2(5),U,2) S $P(ECD2,U,7)="",X=$P(ECDDIF,U,5)_"*",$P(ECDDIF,U,5)=X
 .;change in non-count
 .I $P(ECD2,U,12)'=$P(ECD,U,17) S X=$P(ECD,U,17)_"!",$P(ECDDIF,U,12)=X,$P(ECD2,U,12)=$P(ECD,U,17),$P(ECD2,U,7)=""
 .;reset entry
 .S ^ECX(728.44,EC,0)=ECD2
 ;set tmp node
 S ECSC=$P(ECD,U) S:$L(ECSC)>27 ECSC=$E(ECSC,1,27)
 I $D(ECD2),$P(ECD2,U,7)="" D
 .I ECXINAC,(ECDDIF'["!") Q
 .I $D(^XTMP("ECX UNREVIEWED CLINICS",ECSC)) D UPDATE(ECSC,ECDDIF,ECSCSIGN)
 .I '$D(^XTMP("ECX UNREVIEWED CLINICS",ECSC)) S ^XTMP("ECX UNREVIEWED CLINICS",ECSC)=ECSCSIGN_U_$P(ECDDIF,U,2,200),^XTMP("ECX UNREVIEWED CLINICS",ECSC,"T")=$$NOW^XLFDT()
 I $D(ECDNEW) S ^XTMP("ECX UNREVIEWED CLINICS",ECSC)=""_U_$P(ECDNEW,U,2,200),^XTMP("ECX UNREVIEWED CLINICS",ECSC,"T")=$$NOW^XLFDT()
 Q
 ;
UPDATE(ECSC,ECDDIF,ECSCSIGN) ;update ^xtmp node with today's changes
 N ECXOLD,J,L1,L2,X,X1,X2
 S ECXOLD=^XTMP("ECX UNREVIEWED CLINICS",ECSC)
 F J=2,3 S X1=+$P(ECXOLD,U,J),X2=+$P(ECDDIF,U,J) I X2=X1,$P(ECDDIF,U,J)'=$P(ECXOLD,U,J) D
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
 ;I IO=IO(0) W !,"You must queue to a print device.",! D HOME^%ZIS G SELECT
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
 W !!,"This option produces a worksheet of (A) All Clinics, (C) Active, (I) Inactive, "
 W !,"or only the (U) Unreviewed Clinics that are awaiting approval."
 W !!,"Clinics that were defined as ""inactive"" by MAS the last time the option"
 W !,"""Create DSS Clinic Stop Code File"" was run will be indicated with an ""*""."
 W !!,"Choose (X) for exporting the CLINICS AND STOP CODES FILE to a text file for"
 W !,"spreadsheet use.",!
 S DIR(0)="S^A:ALL CLINICS;C:ALL ACTIVE CLINICS;I:ALL INACTIVE CLINICS;U:UNREVIEWED CLINICS;X:EXPORT TO TEXT FILE FOR SPREADSHEET USE",DIR("A")="Enter ""A"", ""C"", ""I"", ""U"", or ""X"""
 S DIR("?",1)="Enter: ""C"" to print a worksheet of all active DSS Clinic Stops,"
 S DIR("?",2)="Enter: ""I"" to print a worksheet of all inactive DSS Clinic  Stops,"
 S DIR("?",3)="Enter: ""A"" to print a worksheet of all DSS Clinic  Stops,"
 S DIR("?",4)="Enter: ""U"" to print only the Clinic Stops that have not been approved."
 S DIR("?")="Enter: ""X"" to export CLINICS AND STOP CODES FILE to a text file."
 D ^DIR K DIR G ENDX:$D(DIRUT) S ECALL=$E(Y)
 I ECALL="X" D EXPORT^ECXSCLD1 Q
 ;sync #728.44 with #44 before printing 'unreviewed'
 I ECALL="U" D  Q
 .W !!,?5,"Before the UNREVIEWED CLINICS report prints, the Clinics and"
 .W !,?5,"Stop Codes file (#728.44) will be synchronized with the Hospital"
 .W !,?5,"Location file (#44).",!!
 .K DIR S DIR(0)="YA",DIR("A")="Do you wish to continue? (Y/N)// " D ^DIR
 .I ('$G(Y)!$G(DIRUT)!$G(DUOUT)!$G(DTOUT)) Q
 .D SELECT^ECXSCLD
 S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) K ZTSAVE S ZTDESC="DSS clinic stop code work sheet",ZTRTN="SPRINT^ECXSCLD",ZTSAVE("ECALL")="" D ^%ZTLOAD,HOME^%ZIS Q
SPRINT ; queued entry to print work sheet
 U IO
 S QFLG=0,$P(LN,"-",80)="",PG=0
 S ECDATE=$O(^ECX(728.44,"A1","")) I ECDATE S ECDATE=-ECDATE,ECDATE=$$FMTE^XLFDT(ECDATE,"5DF"),ECDATE=$TR(ECDATE," ","0")
 I ECALL'="U" K ^TMP("EC",$J)
 F J=0:0 S J=$O(^ECX(728.44,J)) Q:'J  I $D(^ECX(728.44,J,0)) S ECSD=^ECX(728.44,J,0) D
 .I ECALL="A" I $D(^SC(J,0)) S ECSC=$P(^SC(J,0),U),^TMP("EC",$J,ECSC)=$P(ECSD,U,2,200)
 .I (ECALL="I"),($P(ECSD,U,10)) I $D(^SC(J,0)) S ECSC=$P(^SC(J,0),U),^TMP("EC",$J,ECSC)=$P(ECSD,U,2,200)
 .I ((ECALL="C")&($P(ECSD,U,10)=""))!((ECALL="C")&($P(ECSD,U,10)>DT)) I $D(^SC(J,0)) S ECSC=$P(^(0),U),^TMP("EC",$J,ECSC)=$P(ECSD,U,2,200)
 I ECALL'="U" D
 .D HEAD S ECSC="" I $O(^TMP("EC",$J,ECSC))="" W !!,"NO DATA FOUND FOR WORKSHEET.",! Q
 .F J=1:1 S ECSC=$O(^TMP("EC",$J,ECSC)) Q:ECSC=""  S ECD=^TMP("EC",$J,ECSC) D SHOWEM Q:QFLG
 .K ^TMP("EC",$J)
 I ECALL="U" D
 .N ECSCSIGN
 .D HEAD S ECSC=0 I $O(^XTMP("ECX UNREVIEWED CLINICS",ECSC))="" W !!,"NO DATA FOUND FOR WORKSHEET.",! Q
 .F  S ECSC=$O(^XTMP("ECX UNREVIEWED CLINICS",ECSC)) Q:ECSC=""  Q:QFLG  D
 ..S ECSCSIGN=$P(^XTMP("ECX UNREVIEWED CLINICS",ECSC),U),ECD=$P(^XTMP("ECX UNREVIEWED CLINICS",ECSC),U,2,99)
 ..D SHOWEM
 I $E(IOST)="C",'QFLG D SS D ENDX
 W:$Y @IOF D ^%ZISC S ZTREQ="@"
 Q
HEAD ; header for worksheet
 D:PG SS Q:QFLG
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF W !,"WORKSHEET FOR DSS CLINIC STOPS",?71,"Page: ",PG
 I ECDATE]"" W !,"(last reviewed on ",ECDATE,")"
 E  W !,"(NEVER REVIEWED)"
 W !
 W !,?1,"CLINIC",?28,"STOP",?35,"CREDIT",?44,"DSS",?50,"DSS",?59,"ACTION",?68,"NAT'L",?74,"C/N"
 W !,?28,"CODE",?35,"STOP",?44,"STOP",?50,"CREDIT",?68,"CODE"
 W ! W:ECALL'="U" "( * - currently inactive)" W ?35,"CODE",?44,"CODE",?50,"CODE"
 I ECALL="U" W !,?8,"* - inactive     r - reactivated    ! - updated since last review"
 W !,LN
 Q
 ;
SHOWEM ; list clinics for worksheet
 I $Y+6>IOSL D HEAD Q:QFLG
 N ECNON1P
 S ECNON=$P(ECD,U,11),ECNON1P=$E(ECNON,1)
 S ECNON1P=$S(ECNON1P="Y":"N",1:"C") ;if 'yes', then, 'n'on count clinic
 S ECNON=ECNON1P_$E(ECNON,2,99)
 W !!,$E(ECSC,1,25)
 I ECALL="U" S:ECD["!" ECSCSIGN=ECSCSIGN_"!" W ECSCSIGN
 E  I ECALL'="U" W:$P(ECD,U,9)]"" "*"
 F J=1:1:5 W ?$P("28,35,44,50,62",",",J),$S($P(ECD,U,J):$P(ECD,U,J),J<3:"",1:"_____")
 S ECN=$P($G(^ECX(728.441,+$P(ECD,U,7),0)),U) W ?68,$S(ECN]"":ECN,1:"____"),?75,ECNON
 Q
SS ;SCROLL STOPS
 N JJ,SS
 W !,LN
 ;W !,"Key: + - new clinic; ! - updated since last review; * - currently inactiv
 I $E(IOST)="C" S SS=21-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 Q
 ;
EDIT ; put in DSS stopcodes and which one to send
 I '$O(^ECX(728.44,0)) W !,"DSS Clinic stop code file does not exist",!! R X:5 K X Q
 W ! K DIC S DIC=728.44,DIC(0)="QEAMZ" D ^DIC G ENDX:Y<0
 S CLIEN1=+Y
 W !!,"EXISTING CLINIC FILE DATA:",?35,"EXISTING DSS CLINIC FILE DATA:"
 W !!,"STOP CODE :       ",$P(Y(0),U,2),?35,"DSS STOP CODE :   ",$P(Y(0),U,4)
 W !,"CREDIT STOP CODE :",$P(Y(0),U,3),?35,"DSS CREDIT STOP CODE :",$P(Y(0),U,5)
 W !
EDIT1 ;check input & update field #3; allow '@' deletion; allow bypass empty with no entry
 N DIR ;136
 S OUT=0 F  D  Q:OUT
 .K DIC,DIR,ECXMSG,FDA,AMIS,X,Y
 .S STOP=$P(^ECX(728.44,CLIEN1,0),U,4)
 .S DIR(0)="FO^1:99",DIR("A")="DSS STOP CODE (3-digit code only)" I STOP]"" S DIR("B")=STOP
 .S DIR("?")="^S DIC=40.7,DIC(0)=""EMQZ"" D ^DIC"
 .D ^DIR
 .I X="@" D  Q
 ..S IENS=CLIEN1_",",FDA(728.44,IENS,3)=X D FILE^DIE("","FDA")
 ..S OUT=1 W "   deleted..."
 .I X="" S X=STOP K DIRUT S OUT=2 Q
 .S DIC("A")="DSS STOP CODE (3-digit code only): "
 .S DIC="^DIC(40.7,",DIC(0)="EMQZ"
 .S DIC("S")="I $P(^(0),U,3)=""""" D ^DIC
 .I X="@" D  Q
 ..S IENS=CLIEN1_",",FDA(728.44,IENS,3)=X D FILE^DIE("","FDA")
 ..S OUT=2 W "   deleted..."
 .I X="" K DIRUT S OUT=2 Q
 .I ($G(DIRUT)!$G(DUOUT)!$G(DTOUT)) S OUT=3 Q
 .I +X'=X W !,?5,"Invalid... try again." Q
 .I +Y'>0  Q
 .S AMIS=$P(^DIC(40.7,+Y,0),"^",2)
 .S CODE=+Y,ECXMSG=$$ERRCHK(CODE,3,CLIEN1)
 .I ECXMSG=-1 W !,?5,"Invalid... try again." Q
 .I $G(ECXMSG)]"" W !,?5,ECXMSG,! Q
 .S IENS=CLIEN1_",",FDA(728.44,IENS,3)=AMIS D FILE^DIE("U","FDA")
 .S OUT=1
 I ($G(DIRUT)!$G(DUOUT)!$G(DTOUT)) G ENDX
 ;check input & update field #4; allow '@' deletion; allow bypass empty with no entry
 S OUT=0 F  D  G:OUT=1 ENDCHK
 .K DIC,DIR,ECXMSG,FDA,AMIS,X,Y
 .S CSTOP=$P(^ECX(728.44,CLIEN1,0),U,5)
 .S DIR(0)="FO^1:99",DIR("A")="DSS CREDIT STOP CODE (3-digit code only)" I CSTOP]"" S DIR("B")=CSTOP
 .S DIR("?")="^S DIC=40.7,DIC(0)=""EMQZ"" D ^DIC"
 .D ^DIR
 .I X="@" D  Q
 ..S IENS=CLIEN1_",",FDA(728.44,IENS,4)=X D FILE^DIE("","FDA")
 ..S OUT=1 W "   deleted..."
 .I X="" S X=CSTOP K DIRUT S OUT=1 Q
 .S DIC("A")="DSS CREDIT STOP CODE (3-digit code only): "
 .S DIC("S")="I $P(^(0),U,3)=""""" D ^DIC
 .S DIC=40.7,DIC(0)="EMQZ" D ^DIC
 .I X="" K DIRUT S OUT=1 Q
 .I ($G(DIRUT)!$G(DUOUT)!$G(DTOUT)) S OUT=1 Q
 .I +X'=X W !,?5,"Invalid... try again." Q
 .I +Y'>0  Q
 .S AMIS=$P(^DIC(40.7,+Y,0),"^",2)
 .S CODE=+Y,ECXMSG=$$ERRCHK(CODE,4,CLIEN1)
 .I ECXMSG=-1 W !,?5,"Invalid... try again." Q
 .I $G(ECXMSG)]"" W !,?5,ECXMSG,! Q
 .S IENS=CLIEN1_",",FDA(728.44,IENS,4)=AMIS D FILE^DIE("U","FDA")
 .S OUT=1
 I ($G(DIRUT)!$G(DUOUT)!$G(DTOUT)) G ENDX
 K I,WARNING,DIC,DIE,DA,DR,DIR,DIRUT,DTOUT,DUOUT,X,Y,ERRCHK
 K CLIEN1,CODE,ECXMSG,IENS,STOP,CSTOP,AMIS,FDA,OUT,ERR,WRN,ECXERR
 Q
ENDCHK ;check validity of clinic
 S CODE=$P(^ECX(728.44,CLIEN1,0),U,4)
 K ERR,WRN,ECXERR,WARNING,ERRCHK
 S ERRCHK=0
 D STOP^ECXSTOP(CODE,"DSS Stop Code",CLIEN1) D ERRPRNT
 I $D(ECXERR) S ERRCHK=1
 K ERR,WRN,ECXERR,WARNING
 S CODE=$P(^ECX(728.44,CLIEN1,0),U,5)
 D STOP^ECXSTOP(CODE,"Credit Stop Code",CLIEN1) D ERRPRNT
 I $D(ECXERR) S ERRCHK=1
 W !!,"...Validity Checker Complete."
 I ERRCHK=1 W !!,"...Errors found please fix." G EDIT1
 ;remaining fields
 S DIE=728.44,DA=+CLIEN1
 S DR="5//1;S:X'=4 Y=6;7;6///"_DT_";8;10" D ^DIE ;136
 S:$P(^ECX(728.44,DA,0),U,6)'=4 $P(^(0),U,8)="" S $P(^(0),U,7)=""
 Q
ERRPRNT ;print errors
 I $G(ERR)>0,$D(ECXERR) D
 . W ! S I=0 F  S I=$O(ECXERR(I)) Q:'I  D
 . . W !,"..",ECXERR(I)
 I $G(WRN)>0,$D(WARNING) D
 . W ! S I=0 F  S I=$O(WARNING(I)) Q:'I  D
 . . W !,"..",WARNING(I)
 Q
KILL ;
 K I,WARNING,DIC,DIE,DA,DR,DIR,DIRUT,DTOUT,DUOUT,X,Y,ERRCHK
 K CLIEN1,CODE,ECXMSG,IENS,STOP,CSTOP,AMIS,FDA,OUT,ERR,WRN,ECXERR
 G EDIT
 ;
ERRCHK(CODE,TYPE,CLIEN1) ;check for problems
 ;input
 ;   code: stop code IEN in #40.7
 ;   type: type (3=dss stop code, 4=dss credit stop code)
 ;  clien: clinic IEN in #728.44
 ;output
 ;  ecxerr: error msg
 N XCODE,INACT,RTYPE,ERR,WRN
 K ECXERR,WARNING
 S ECXERR="",WARNING="",ERR=0
 Q:'$G(CODE) -1 Q:'$G(CLIEN1) -1
 Q:(TYPE="") -1 Q:((TYPE<3)&(TYPE>4)) -1
 S XCODE=$P(^DIC(40.7,CODE,0),"^",2)
 S TYPE=$S(TYPE=3:"DSS Stop Code",1:"DSS Credit Stop Code")
 I TYPE="DSS Stop Code" D STOP^ECXSTOP(XCODE,TYPE,,,CODE)
 I TYPE="DSS Credit Stop Code" D STOP^ECXSTOP(XCODE,TYPE,CLIEN1,,CODE)
 I $G(ERR)>0,$D(ECXERR(1)) S ERR=$O(ECXERR(0)),ECXERR=ECXERR(ERR) Q ECXERR
 E  S ECXERR="" Q ECXERR
 Q ECXERR
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
 K J,ECSC,ECSD,ECDATE,ECD,ECN,ECNON,ECXINAC,QFLG,PG,LN,SS,POP,%ZIS
 K EC,ECD,ECD2,ECL,ECS,ECS2,ECP,ECSC,ECSC2,ECDB,ECDNEW,ECDDIF,ECSCSIGN,ECDF,ECALL,ID,RD
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
