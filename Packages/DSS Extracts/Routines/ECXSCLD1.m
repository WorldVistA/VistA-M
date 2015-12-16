ECXSCLD1 ;ALB/DAN <CONT> Enter, Print and Edit Entries in 728.44 ;5/20/15  15:25
 ;;3.0;DSS EXTRACTS;**132,136,144,149,154**;Dec 22, 1997;Build 13
 ;
HEAD ; header for worksheet 149 - moved from ECXSCLD due to size restraints. 
 D:PG SS Q:QFLG
 N HEAD1 ;154
 S HEAD1="WORKSHEET FOR DSS CLINIC STOPS" ;154
 I (ECALL="D") S HEAD1=HEAD1_" (DUPLICATE CLINIC LIST)" ;154
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF W !,HEAD1,?71,"Page: ",PG
 I ECDATE]"" W !,"(last approved on ",ECDATE,")",?59,"Print Date:",$TR($$FMTE^XLFDT(DT,"2F")," ",0) ;144
 I ECDATE="" W !,"(NEVER APPROVED)",?59,"Print Date:",$TR($$FMTE^XLFDT(DT,"2F")," ",0) ;144
 I (ECALL'="D") D  ;149 
 .W !
 .W !,?1,"CLINIC",?33,"STOP",?42,"CREDIT",?52,"ACTION",?63,"CHAR4",?70,"C/N" ;154 CVW
 .W !,?33,"CODE",?42,"STOP",?63,"CODE"
 .W !,?42,"CODE" ;144,149 CVW
 .W !,"( * - currently inactive)" ;154 CVW
 .W !,LN
 I (ECALL="D") D  ;149 
 .W !
 .W !,?1,"CLINIC NAME",?28,"CLINIC",?40,"STOP",?46,"CREDIT",?55,"CHAR4",?63,"CLINIC",?72,"DIV" ;154 CVW
 .W !,?28,"IEN",?40,"CODE",?46,"STOP",?55,"CODE",?63,"APPT" ;154 CVW
 .W !,?46,"CODE",?63,"LENGTH" ;154 CVW
 .W !,LN
 Q
 ;
SS ;SCROLL STOPS 149 - moved from ECXSCLD due to size restraints.
 N JJ,SS
 W !,LN
 ;W !,"Key: + - new clinic; ! - updated since last review; * - currently inactiv
 I $E(IOST)="C" S SS=21-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 Q
 ;
ERRCHK(CODE,TYPE,CLIEN1) ;check for problems 149 - moved from ECXSCLD due to size restraints.
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
SHOWEM ; list clinics for worksheet 149 moved from ECXSCLD due to size. 
 I $Y+6>IOSL D HEAD Q:QFLG
 N ECNON1P
 S ECNON=$P(ECD,U,11),ECNON1P=$E(ECNON,1)
 S ECNON1P=$S(ECNON1P="Y":"N",1:"C") ;if 'yes', then, 'n'on count clinic
 S ECNON=ECNON1P_$E(ECNON,2,99)
 W !!,$E(ECSC,1,25)
 W:$P(ECD,U,9)]"" "*" ;144
 W ?33,$P(ECD,U,1),?42,$P(ECD,U,2),?55,$P(ECD,U,5)
 ;F J=1:1:5 W ?$P("28,35,44,50,62",",",J),$S($P(ECD,U,J):$P(ECD,U,J),J<3:"",1:"_____")
 S ECN=$P($G(^ECX(728.441,+$P(ECD,U,7),0)),U) W ?63,$S(ECN]"":ECN,1:"____"),?71,ECNON
 Q
ERRPRNT ;print errors
 I $G(ERR)>0,$D(ECXERR) D
 . W ! S I=0 F  S I=$O(ECXERR(I)) Q:'I  D
 . . W !,"..",ECXERR(I)
 I $G(WRN)>0,$D(WARNING) D
 . W ! S I=0 F  S I=$O(WARNING(I)) Q:'I  D
 . . W !,"..",WARNING(I)
 Q
EDIT1 ;check input & update field #3; allow '@' deletion; allow bypass empty with no entry
 ;**NOTE THIS CODE IS NOT CURRENT as of patch 154, and it was moved here from ECXSCLD due
 ;to size constraints. The code was left as documentation of what was changed, and for potential
 ;re-instatement by the customer. Please note, there are calls that would need to be updated if used 
 ;again from within this routine. 
 ;N DIR ;136
 ;S OUT=0 F  D  Q:OUT
 ;.K DIC,DIR,ECXMSG,FDA,AMIS,X,Y
 ;.S STOP=$P(^ECX(728.44,CLIEN1,0),U,4)
 ;.S DIR(0)="FO^1:99",DIR("A")="DSS STOP CODE (3-digit code only)" I STOP]"" S DIR("B")=STOP
 ;.S DIR("?")="^S DIC=40.7,DIC(0)=""EMQZ"" D ^DIC"
 ;.D ^DIR
 ;.I X="@" D  Q
 ;..S IENS=CLIEN1_",",FDA(728.44,IENS,3)=X D FILE^DIE("","FDA")
 ;..S OUT=1 W "   deleted..."
 ;.I X="" S X=STOP K DIRUT S OUT=2 Q
 ;.S DIC("A")="DSS STOP CODE (3-digit code only): "
 ;.S DIC="^DIC(40.7,",DIC(0)="EMQZ"
 ;.S DIC("S")="I $P(^(0),U,3)=""""" D ^DIC
 ;.I X="@" D  Q
 ;..S IENS=CLIEN1_",",FDA(728.44,IENS,3)=X D FILE^DIE("","FDA")
 ;..S OUT=2 W "   deleted..."
 ;.I X="" K DIRUT S OUT=2 Q
 ;.I ($G(DIRUT)!$G(DUOUT)!$G(DTOUT)) S OUT=3 Q
 ;.I +X'=X W !,?5,"Invalid... try again." Q
 ;.I +Y'>0  Q
 ;.S AMIS=$P(^DIC(40.7,+Y,0),"^",2)
 ;.S CODE=+Y,ECXMSG=$$ERRCHK(CODE,3,CLIEN1)
 ;.I ECXMSG=-1 W !,?5,"Invalid... try again." Q
 ;.I $G(ECXMSG)]"" W !,?5,ECXMSG,! Q
 ;.S IENS=CLIEN1_",",FDA(728.44,IENS,3)=AMIS D FILE^DIE("U","FDA")
 ;.S OUT=1
 ;I ($G(DIRUT)!$G(DUOUT)!$G(DTOUT)) G ENDX
 ;check input & update field #4; allow '@' deletion; allow bypass empty with no entry
 ;S OUT=0 F  D  G:OUT=1 ENDCHK
 ;.K DIC,DIR,ECXMSG,FDA,AMIS,X,Y
 ;.S CSTOP=$P(^ECX(728.44,CLIEN1,0),U,5)
 ;.S DIR(0)="FO^1:99",DIR("A")="DSS CREDIT STOP CODE (3-digit code only)" I CSTOP]"" S DIR("B")=CSTOP
 ;.S DIR("?")="^S DIC=40.7,DIC(0)=""EMQZ"" D ^DIC"
 ;.D ^DIR
 ;.I X="@" D  Q
 ;..S IENS=CLIEN1_",",FDA(728.44,IENS,4)=X D FILE^DIE("","FDA")
 ;..S OUT=1 W "   deleted..."
 ;.I X="" S X=CSTOP K DIRUT S OUT=1 Q
 ;.S DIC("A")="DSS CREDIT STOP CODE (3-digit code only): "
 ;.S DIC("S")="I $P(^(0),U,3)=""""" D ^DIC
 ;.S DIC=40.7,DIC(0)="EMQZ" D ^DIC
 ;.I X="" K DIRUT S OUT=1 Q
 ;.I ($G(DIRUT)!$G(DUOUT)!$G(DTOUT)) S OUT=1 Q
 ;.I +X'=X W !,?5,"Invalid... try again." Q
 ;.I +Y'>0  Q
 ;.S AMIS=$P(^DIC(40.7,+Y,0),"^",2)
 ;.S CODE=+Y,ECXMSG=$$ERRCHK(CODE,4,CLIEN1)
 ;.I ECXMSG=-1 W !,?5,"Invalid... try again." Q
 ;.I $G(ECXMSG)]"" W !,?5,ECXMSG,! Q
 ;.S IENS=CLIEN1_",",FDA(728.44,IENS,4)=AMIS D FILE^DIE("U","FDA")
 ;.S OUT=1
 ;I ($G(DIRUT)!$G(DUOUT)!$G(DTOUT)) G ENDX
 ;K I,WARNING,DIC,DIE,DA,DR,DIR,DIRUT,DTOUT,DUOUT,X,Y,ERRCHK
 ;K CLIEN1,CODE,ECXMSG,IENS,STOP,CSTOP,AMIS,FDA,OUT,ERR,WRN,ECXERR
 Q
EXPORT ;Export clinic review data to spreedsheet
 N DIC,DIR,FLDS,BY,FR,L,DIOBEG,DIR,DIS,Y,DIRUT,POP,DUOUT,DTOUT,DIROUT,X,%ZIS,IOP,CCNT,ECXCLX,APPL ;144
 W !!,"Select which clinics to include on the spreadsheet for exporting." ;144
 S DIR(0)="SAO^A:ALL CLINICS;C:ACTIVE CLINICS;D:DUPLICATE CLINICS;I:INACTIVE CLINICS;U:UNREVIEWED CLINICS",DIR("?")="Enter letter associated with the group of clinics to include on the spreadsheet" ;149
 S DIR("A",1)="Select (A)ll, a(C)tive, (D)uplicate, (I)nactive, " ;149
 S DIR("A")="or (U)nreviewed clinics for export: "
 D ^DIR K DIR I $D(DIRUT) Q  ;144 Stop if no selection made
 S ECALL=$E(Y)
 I ECALL'="D" D
 .W !!,"To ensure all data is captured during the export:" ;144
 .W !!,"1. Select 'Logging...' from the File Menu. Select your file, and where to save." ;144
 .W !,"2. On the Setup menu, select 'Display...',then 'screen' tab and modify 'columns'",!,"   setting to at least 225 characters." ;144
 .W !,"3. The DEVICE input for the columns should also contain a large enough",!,"   parameter (e.g. 225).  The DEVICE prompt is defaulted to 0;225;99999 for you.",!,"   You may change it if need be." ;144
 .W !,"Example: DEVICE: 0;225;99999 *Where 0 is your screen, 225 is the margin width",!?17,"and 99999 is the screen length."
 .W !!,"NOTE:  In order for all number fields, such as SSN and Feeder Key, to be",!,"displayed correctly in the spreadsheet, these fields must be formatted as Text",!,"when importing the data into the spreadsheet.",! ;144
 .S DIC="^ECX(728.44,",FLDS="[ECX CLINIC REVIEW EXPORT]",BY="NUMBER",FR="",L=0
 .;The following line has been patched in 136 and 144
 .S DIOBEG="W ""IEN^Clinic^Stop Code^Credit Stop Code^Action^Last Approved Date^CHAR4 Code^Inact Date^React Date^Clinic Type" ;154 CVW
 .S DIOBEG=DIOBEG_"^App Len^Div^App Type^Non Cnt^OOS^OOS Calling Pkg^Var Length Appt^DSS Prod Dept"""
 .S DIS(0)=$S(Y="U":"I $P(^ECX(728.44,D0,0),U,7)=""""",Y="I":"I $P(^ECX(728.44,D0,0),U,10)'=""""",Y="C":"I $P(^ECX(728.44,D0,0),U,10)=""""",1:"I 1") ;144
 .S DIS(1)="I $P($G(^SC(D0,0)),U,3)=""C""" ;144 Only include clinics in report
 .S %ZIS="N",%ZIS("B")="0;225;99999" D ^%ZIS Q:POP  S IOP=ION_";"_IOM_";"_IOSL ;144
 .D EN1^DIP
 I ECALL="D" D
 .K ^TMP("EC",$J)
 .W !!,"Gathering data for export..."
 .S FIRST=1,X=0,CCNT=1
 .F DC=0:0 S DC=$O(^ECX(728.44,DC)) Q:'DC  I $D(^ECX(728.44,DC,0)) S ECSDC=^ECX(728.44,DC,0) D
 ..I $P($G(^SC(DC,0)),U,3)'="C"!($P(^ECX(728.44,DC,0),U,10)'="") Q  ;149 Don't include non clinic types or inactive ones
 ..S STOPC=$P(ECSDC,U,2),CREDSC=$P(ECSDC,U,3),NATC=$P(ECSDC,U,8) ;154 CVW
 ..S DIV=$$GET1^DIQ(44,$P(ECSDC,U),3.5,"I"),APPL=$$GET1^DIQ(44,$P(ECSDC,U),1912,"I")
 ..I 'FIRST D
 ...I ($D(^TMP("EC",$J,1_STOPC_CREDSC_NATC_DIV_APPL))) D
 ....S ^TMP("EC",$J,1_STOPC_CREDSC_NATC_DIV_APPL,0)="1"
 ...S ECSC=$P(^SC(DC,0),U),^TMP("EC",$J,1_STOPC_CREDSC_NATC_DIV_APPL,DC,ECSC)=$P(ECSDC,U,1,200)_U_APPL_U_DIV
 ..I FIRST D
 ...S ECSC=$P(^SC(DC,0),U),^TMP("EC",$J,1_STOPC_CREDSC_NATC_DIV_APPL,DC,ECSC)=$P(ECSDC,U,1,200)_U_APPL_U_DIV,FIRST=0
 .K ^TMP($J,"ECXPORT")
 .S ^TMP($J,"ECXPORT",0)="CLINIC NAME^CLINIC IEN^STOP CODE^CREDIT STOP CODE^CHAR4 CODE^CLINIC APPOINTMENT LENGTH^DIVISION"
 .S KEY="" F  S KEY=$O(^TMP("EC",$J,KEY)) Q:'+KEY  I $G(^TMP("EC",$J,KEY,0)) D
 ..S IEN=0 F  S IEN=$O(^TMP("EC",$J,KEY,IEN)) Q:'+IEN  S NAME="" F  S NAME=$O(^TMP("EC",$J,KEY,IEN,NAME)) Q:NAME=""  D
 ...S ECXCLX=^TMP("EC",$J,KEY,IEN,NAME)
 ...S ^TMP($J,"ECXPORT",CCNT)=$E($P(^SC(IEN,0),U),1,25)_$S($P(ECXCLX,U,10)]"":"*",1:"")_U_$P(ECXCLX,U)_U_$P(ECXCLX,U,4)_U_$P(ECXCLX,U,5)_U_$$GET1^DIQ(728.441,$P(ECXCLX,U,8),.01)_U_$P(ECXCLX,U,14)_U_$P(ECXCLX,U,15)
 ...S CCNT=CCNT+1
 ..S ^TMP($J,"ECXPORT",CCNT)=U,CCNT=CCNT+1
 .D EXPDISP^ECXUTL1
 I '$G(POP) D  ;144 Don't print the following lines if the report didn't print
 .I ECALL'="D" D
 ..W !!,"Turn off your logging..." ;144
 ..W !,"...Then, pull your export text file into your spreadsheet.",! ;144
 ..S DIR(0)="E",DIR("A")="Press any key to continue" D ^DIR K DIR
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 Q
