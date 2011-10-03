PSGVBW ;BIR/CML3,MV - VERIFY ORDERS BY WARD, WARD GROUP, PATIENT, OR PRIORITY ;10/22/98 3:14 PM
 ;;5.0;INPATIENT MEDICATIONS;**5,16,39,59,62,67,58,81,80,110,111,133,139,155,241,243**;DEC 16, 1997;Build 45
 ;
 ; Reference to ^PS(55 is supported by DBIA #2191
 ; Reference to ^PS(51.1 is supported by DBIA #2177
 ; Reference to ^DPT is supported by DBIA #10035
 ;
 N PSJNEW,PSGPTMP,PPAGE,CL,CG S PSJNEW=1
START ; Lookup patient by ward group, ward, priority, or patient; depending on value of PSGSS
 ; 
 D ENCV^PSGSETU I $D(XQUIT) K XQUIT Q
 D ^PSIVXU I $D(XQUIT) K XQUIT Q
 D NOW^%DTC S PSGDT=%
 I '$D(^XTMP("PSJPVNV")) D
 .K DIR S DIR(0)="Y",DIR("A")="Display an Order Summary",DIR("B")="NO"
 .S DIR("?",1)="Enter 'YES' to see a summary of orders by type and ward group",DIR("?")="or 'NO' to go directly to patient selection."
 .D ^DIR K DIR Q:$D(DIRUT)!$D(DUOUT)  I Y D CNTORDRS^PSGVBWU
 K ^TMP("PSJ",$J) S PSGPXN=0 D GTOOP G:$D(DIRUT) DONE L +^PS(53.45,PSJSYSP):1 E  D LOCKERR^PSJOE G DONE
 S PSGSSH="VBW",PSGPXN=0,PSJPROT=$S($P(PSJSYSU,";",3)=3:3,$G(PSJRNF):3,$G(PSJIRNF):3,1:1)
 S PSGVBWW=$S(PSJTOO=1:"NON-VERIFIED",PSJTOO=2:"PENDING",1:"NON-VERIFIED AND/OR PENDING")
 F  K ^TMP("PSJSELECT",$J) D PRI^PSGSEL Q:"^"[PSGSS  F  S (PSGP,WD,WG)=0 S PSGPTMP=0,PPAGE=1 K PSGPRIF D @PSGSS Q:+Y'>0  D GO
 ;
DONE ; Cleanup
 D DONE2
 K SETWDN,PTPRI,SETTM,SETPN,SUBS,TMPWD,STATUS
 K CHK,D0,DRGI,FQC,J,ND,ON,PN,PSGODT,PSGOEA,PSGOP,PSGSS,PSGSSH,RB,SD,ST,TM,WD,WDN,WG,PRI,PSJPNV,PSJCT,PSGCLF,PSGPRIF,LIDT,WDNAME,IFPRI
 K PSGODDD,PSGOEORF,PSJORL,PSJORPCL,PSJORTOU,PSJORVP,PSGTOL,PSJTOO,PSGUOW,PSGONV,PX,PSGOEAV,PSGPX,PSGVBWTO,PSGVBWW,PSJOPC,PSGOENOF,PSJPROT,PSJLM,PSJASK
 K PSJPAC,PSJINDEX,PSJCNT,PSIVSN,PSGWORP1,PSGWORP2,PSGVBY,PSGVBWN,PSGVBTM,PSGVBPN,PSGPXN,PSGPRIN,PSGPRD,PSGINWD,PSGINCL,PRDON,PRDNS,PRD,PPN,ORDT
 L -^PS(53.45,PSJSYSP) G:$G(PSGPXN) ^PSGPER1 D ENKV^PSGSETU K ND Q
 ;
DONE2 ; Partial Cleanup
 K ^TMP("PSGVBW",$J),^TMP("PSGVBW2",$J),^TMP("PSGVBW3",$J),^TMP("PSJSELECT",$J),^TMP("PSJLIST",$J),^TMP("PSJON",$J)
 K PRD
 Q
 ;
GO ; Find and display matching patients
 I PSGSS'="P" W !,"...a few moments, please..." K ^TMP("PSGVBW",$J),^TMP("PSGVBW2",$J) D ARRAY K CHK,ON,PN,RB,SD,TM,WD,WDN,WG,X,Y
 I PSGSS'="P",'$D(^TMP("PSGVBW",$J)) W !,$C(7),"NO ",PSGVBWW," ORDERS FOR ",$S(PSGSS="P":"PATIENT",PSGSS="L":"CLINIC GROUP",PSGSS="C":"CLINIC",PSGSS="PR":"PRIORITY",1:"WARD"),$S(PSGSS="G":" GROUP",1:"")," SELECTED." Q
 D ^PSGVBW0,DONE2 Q
 ;
G ; Select a Ward Group
 K DIR S DIR(0)="FAO",DIR("A")="Select WARD GROUP: "
 S DIR("?")="^D GDIC^PSGVBW" W ! D ^DIR
 I Y="^OTHER" D OUTPT^PSGVBW1 Q
GDIC ; Ward Group lookup
 K DIC S DIC="^PS(57.5,",DIC(0)="QEMI" D ^DIC K DIC S:+Y>0 WG=+Y
 W:X["?" !!,"Enter ""^OTHER"" to include all orders from the wards that do not",!,"belong to a ward group, or orders that have neither a ward nor a clinic.",! ;PSJ*5*241: Updated help text
 Q
C ; Select a Clinic
 K DIR S DIR(0)="FAO",DIR("A")="Select CLINIC: "
 S DIR("?")="^D CDIC^PSGVBW" W ! D ^DIR
CDIC ; Clinic lookup
 K DIC S DIC="^SC(",DIC(0)="QEMIZ" D ^DIC K DIC S:+Y>0 CL=+Y
 W:X["?" !!,"Enter the clinic you want to use to select patients for processing.",!
 Q
L ; Select a Clinic Group
 K DIR S DIR(0)="FAO",DIR("A")="Select CLINIC GROUP: "
 S DIR("?")="^D LDIC^PSGVBW" W ! D ^DIR
LDIC ; Clinic Group lookup
 K DIC S DIC="^PS(57.8,",DIC(0)="QEMI" D ^DIC K DIC S:+Y>0 CG=+Y
 W:X["?" !!,"Enter the name of the clinic group you want to use to select patients for processing."
 Q
W ; Select a Ward
 K DIR S DIR(0)="FAO",DIR("A")="Select WARD: "
 S DIR("?")="^D WDIC^PSGVBW" W ! D ^DIR
 I Y="^OTHER" D OUTPT^PSGVBW1 Q
WDIC ; Ward lookup
 K DIC S DIC="^DIC(42,",DIC(0)="QEMIZ" D ^DIC K DIC S:+Y>0 WD=+Y
 W:X["?" !!,"Enter ""^OTHER"" for Outpatient IV orders",!
 Q
PR ; Select order priority
 K DIR S DIR(0)="SO^1:STAT;2:ASAP;3:ROUTINE"
 S DIR("A")="Select 1-3 ",DIR("?")="        Choose a Priority."
 S DIR("?",1)="Enter a PRIORITY to include all patients with orders containing that PRIORITY"
 D ^DIR S:Y>0 PRD=+Y S:+Y>0 WDN=$S(PRD=1:"STAT",PRD=2:"ASAP",3:"ROUTINE")
 Q
P ; Select patient
 K ^TMP("PSJSELECT",$J) S PSJCNT=1 F  D ^PSJP Q:PSGP<0  D
 .S PSJNV=0
 .NEW ON,XX F ON=0:0 S ON=$O(^PS(53.1,"AS","N",PSGP,ON)) Q:'ON  S ND=$P($G(^PS(53.1,ON,0)),U,4) S XX=$S(ND="U"&(PSJPAC'=2):1,ND'="U"&(PSJPAC'=1):1,1:0) I XX S PSJNV=1 Q
 .;S PSJNV=$O(^PS(53.1,"AS","N",+PSGP,0)),PSJPEN=$O(^PS(53.1,"AS","P",+PSGP,0))
 .S PSJPEN=$O(^PS(53.1,"AS","P",+PSGP,0))
 .I 'PSJNV D ^PSJAC D
 ..I '$D(PSGDT) D NOW^%DTC S PSGDT=$E(%,1,12)
 ..S X1=$P(PSGDT,"."),X2=-2 D C^%DTC S PSGODT=X_(PSGDT#1)
 ..I PSJPAC'=2 F ST="C","O","OC","P","R" F SD=$S(ST="O":PSJPAD,1:PSGODT):0 S SD=$O(^PS(55,PSGP,5,"AU",ST,SD)) Q:'SD!PSJNV  F ON=0:0 S ON=$O(^PS(55,PSGP,5,"AU",ST,SD,ON)) Q:'ON  I $D(^PS(55,PSGP,5,ON,0)),$P(^(0),"^",9)'["D" D IFT I  S PSJNV=1 Q
 ..I PSJPAC'=1 F SD=+PSJPAD:0 S SD=$O(^PS(55,PSGP,"IV","AIS",SD)) Q:'SD  F ON=0:0 S ON=$O(^PS(55,PSGP,"IV","AIS",SD,ON)) Q:'ON  I $D(^PS(55,PSGP,"IV",ON,0)),$P(^(0),"^",17)'["D" D IFT2 I  S PSJNV=1 Q
 .S X=$S(PSJTOO=1:PSJNV,PSJTOO=2:PSJPEN,1:(PSJNV+PSJPEN))
 .I X D SETPN S ^TMP("PSJSELECT",$J,PSJCNT)=PN,^TMP("PSJSELECT",$J,"B",$P(PN,U),PSJCNT)="",PSJCNT=PSJCNT+1 Q
 .W !,"No ",PSGVBWW," orders found for this patient."
 S:$D(^TMP("PSJSELECT",$J)) Y=1
 Q
ARRAY ; put patient(s) with non-verified orders into array
 I '$D(PSGDT) D NOW^%DTC S PSGDT=$E(%,1,12)
 S X1=$P(PSGDT,"."),X2=-2 D C^%DTC S PSGODT=X_(PSGDT#1),PSGVBWW=$S(PSJTOO=1:"NON-VERIFIED",PSJTOO=2:"PENDING",1:"NON-VERIFIED AND/OR PENDING") I PSGSS="P" D IF S:$T ^TMP("PSGVBW",$J)=$P(PSGP(0),"^")_"^"_PSGP Q
 G CG:PSGSS="L",CL:PSGSS="C",WD:PSGSS="W",PRI:PSGSS="PR" S WD=0 F  S WD=$O(^PS(57.5,"AC",WG,WD)) Q:'WD  D WD
 Q
 ;
CG ; Find all clinics in selected clinic group
 S CL="" F  S CL=$O(^PS(57.8,"AD",CG,CL)) Q:CL=""  D CL
 Q
CL ; Find all patients in selected clinic
 S WDN=$S($D(^SC(CL,0)):$P(^(0),"^"),1:"")
 S PSGP="",PSGCLF=1 F  S PSGP=$O(^PS(53.1,"AD",CL,PSGP)) Q:PSGP=""  D ^PSJAC,IF
 K PSGCLF
 Q
WD ; Find all patients in selected ward
 S WDN=$S($D(^DIC(42,WD,0)):$P(^(0),"^"),1:"")
 I WDN]"" S PSGP=0 F  S PSGP=$O(^DPT("CN",WDN,PSGP)) Q:'PSGP  D
 .I $S($D(^PS(55,"APV",PSGP)):1,$D(^PS(55,"APIV",PSGP)):1,$O(^PS(55,PSGP,5,"AUS",PSGDT)):1,1:$D(^PS(53.1,"AC",PSGP))) D ^PSJAC,IF
 Q
PRI ; Find orders with selected Priority
 ; Once a patient is identified in any status index ("I", "N", or "P"), all orders for that patient are checked in the 
 ; IF subroutine. To prevent unnecessary duplication of processing, "PSGVBW3" node of ^TMP, sorted by patient, will be 
 ; set when a patient's orders are processed, and checked for each status index. If patient exists in the "PSGVBW3" node,
 ; patient has already been processed, so quit.
 N NDP2,PSGALL,ND0,PSGPRIFZ K ^TMP("PSGVBW3",$J)
 S PSGPRIF=1 F STATUS="I","N","P" S PSGP=0 F  S PSGP=$O(^PS(53.1,"AS",STATUS,PSGP)) Q:'PSGP  Q:($D(^TMP("PSGVBW3",$J,PSGP)))  D ^PSJAC,IF
 K ^TMP("PSGVBW3",$J)
 Q
IF ;BHW;PSJ*5*155;Added PSGCLF and PS(53.1,"AD" Check below.  If called from CL subroutine and the order Doesn't exist for that Clinic, then QUIT.;PSJ*5*241:Changed quit conditions
 W "." I PSJTOO'=1 S ON=0 F  S ON=$O(^PS(53.1,"AS","P",PSGP,ON)) Q:'ON!(($G(PSGCLF))&('$D(^PS(53.1,"AD",+$G(CL),PSGP,+$G(ON)))))!(($G(WDN)="ZZ")&(+$P($G(^PS(53.1,+$G(ON),"DSS")),U,1)'=0))  D
 .S X=$P($G(^PS(53.1,ON,0)),U,4),IFPRI=0,Y=0 I "FIU"[X D  D:Y SET
 ..I $G(PSGPRIF) D  Q:'IFPRI
 ...N PRIO S PRIO=$P($G(^PS(53.1,+ON,.2)),"^",4),PRIO=$S(PRIO="S":1,PRIO="A":2,1:3) S IFPRI=$S(PRD=PRIO:1,1:"")
 ..I PSJPAC=3 S Y=1 Q
 ..I PSJPAC=2 S Y=X'="U" Q
 ..I PSJPAC=1 S Y=X="U"
 I PSJTOO=2 D  Q
 .I '$G(PSGPRIF),$D(^TMP("PSGVBW2",$J)) D SET2
 F X="N","I" I $D(^PS(53.1,"AS",X,PSGP)) NEW XX S XX=0 D  I XX D SET K ON
 . NEW PRIOAR F ON=0:0 S ON=$O(^PS(53.1,"AS",X,PSGP,ON)) Q:'ON!(($G(WDN)="ZZ")&(+$P($G(^PS(53.1,+$G(ON),"DSS")),U,1)'=0))  S ND=$P($G(^PS(53.1,ON,0)),U,4) S XX=$S(ND="U"&(PSJPAC'=2):1,ND'="U"&(PSJPAC'=1):1,1:0) I XX D  Q:($G(PRD)&$G(XX))
 .. S PRIOAR=$P($G(^PS(53.1,+$G(ON),.2)),U,4) S PRIOAR=$S(PRIOAR="S":"S",PRIOAR="A":"A",1:"R")
 .. I $G(PRD) S XX=$S(PRD=1&(PRIOAR="S"):1,PRD=2&(PRIOAR="A"):1,PRD=3&(PRIOAR="R"):1,1:0) Q
 .. S PRIOAR(PRIOAR)=ON
 . Q:$G(PRD)  S ON=$S($G(PRIOAR("S")):PRIOAR("S"),$G(PRIOAR("A")):PRIOAR("A"),1:$G(PRIOAR("R")))
 S X1=$P(PSGDT,"."),X2=-2 D C^%DTC S PSGODT=X_(PSGDT#1)
 I PSJPAC'=2 F ST="C","O","OC","P","R" F SD=$S(ST="O":PSJPAD,1:PSGODT):0 S SD=$O(^PS(55,PSGP,5,"AU",ST,SD)) Q:'SD  F ON=0:0 S ON=$O(^PS(55,PSGP,5,"AU",ST,SD,ON)) Q:'ON  I $D(^PS(55,PSGP,5,ON,0)),$P(^(0),"^",9)'["D" D IFT I  D SET
 ;*PSJ*5*241:Expired IV orders must be one-time
 I PSJPAC'=1 F SD=+PSJPAD:0 S SD=$O(^PS(55,PSGP,"IV","AIS",SD)) Q:'SD  F ON=0:0 S ON=$O(^PS(55,PSGP,"IV","AIS",SD,ON)) Q:'ON  D
 .N SCH,STYPE S STYPE=0,SCH=$P($G(^PS(55,PSGP,"IV",ON,0)),U,9)
 .S:SCH]"" SCH=$O(^PS(51.1,"APPSJ",SCH,STYPE)) S:SCH]"" STYPE=$P($G(^PS(51.1,SCH,0)),U,5)
 .I $D(^PS(55,PSGP,"IV",ON,0)),$P(^(0),"^",17)'["D",'(($P(^(0),"^",17)="E")&($G(STYPE)'="O")) D IFT2 I  D SET
 I '$G(PSGPRIF),$D(^TMP("PSGVBW2",$J)) D SET2
 Q
 ;
IFT ; Loop through active UD orders in ^PS(55 that have not been verified by pharmacist.
 S ND=$G(^PS(55,PSGP,5,ON,4)) I $S(SD>PSGDT:$S(ND="":1,'$P(ND,"^",$S(PSJSYSU:PSJSYSU,1:1)):1,$P(ND,"^",13):1,$P(ND,"^",19):1,$P(ND,"^",23):1,1:$P(ND,"^",16)),ST="O":$S(ND="":1,1:'$P(ND,"^",$S(PSJSYSU:PSJSYSU,1:1))),1:$P(ND,"^",16))
 Q
 ;
IFT2 ; Loop through active IV orders in ^PS(55 that have not been verified by pharmacist.
 ;S ND=$G(^PS(55,PSGP,"IV",ON,4)) I $S((SD>PSGDT)&(ND=""):1,'$P(ND,"^",$S(+PSJSYSU=1:1,1:4)):1,1:0)
 S ND=$G(^PS(55,PSGP,"IV",ON,4))
 I ($P($G(^PS(55,PSGP,"IV",ON,.2)),"^",4)="D")&('$P(ND,"^",$S(+PSJSYSU=1:1,1:4)))  Q
 I $S((SD>PSGDT)&('$P(ND,"^",$S(+PSJSYSU=1:1,1:4))):1,1:0)
 Q
SET ; Set patient specific variables for ^TMP subscripts
 S PRDON=""
 I $G(ON) S PRDON=$P($G(^PS(53.1,+ON,.2)),"^",4),PRDON=$S(PRDON="A":"ASAP",PRDON="S":"STAT",PRDON="R":"ROUTINE",1:"zz")
 S PTPRI=$S(PRDON="STAT":1,PRDON="ASAP":2,PRDON="ROUTINE":3,1:3)
 I $G(PSGPRIF) Q:(PRD'=PTPRI)
 K DIC,X,Y,WDNAME,TMPWD S WDNAME=$G(^DPT(+PSGP,.1)) S X=WDNAME,DIC="^DIC(42,",DIC(0)="BOXZ" D ^DIC S TMPWD=+Y
 S TM=$S(PSJPRB="":"",1:$P($G(^PS(57.7,TMPWD,1,+$O(^PS(57.7,"AWRT",TMPWD,PSJPRB,0)),0)),"^")) S:TM="" TM="zz"
 ;
SETPN ; If searching for specific priority:
 ;            -  set patient into ^TMP("PSGBW" sorted by Priority Name, Priority #, Team, Patient Name^IEN^SSN
 ; If not searching for specific priority:
 ;            - set patient into ^TMP("PSGVBW2" sorted by 'Patient Name^IEN^SSN', then Priority
 ;            - set patient into ^TMP("PSGVBW3" sorted by Patient IEN
 S PN=$P(PSGP(0),"^")_U_PSGP_U_PSJPBID
 Q:PSGSS="P"
 I $G(PSGPRIF) S ^TMP("PSGVBW",$J,WDN,PTPRI,TM,PN)="" Q
 S ^TMP("PSGVBW2",$J,PN,+$G(PTPRI))=WDN_"^"_TM,^TMP("PSGVBW3",$J,+PSGP)=""
 Q
 ;
SET2 ; If not searching for a specific priority,find the highest priority order associated with patient. 
 ; Set the patient into ^TMP("PSGVBW" sorted by highest Priority Name, Priority #, Team, Patient Name^IEN^SSN
 S SETPN="" F  S SETPN=$O(^TMP("PSGVBW2",$J,SETPN)) Q:SETPN=""  D
 .S PTPRI=$O(^TMP("PSGVBW2",$J,SETPN,0)) Q:'$G(PTPRI)
 .S SUBS=$G(^TMP("PSGVBW2",$J,SETPN,PTPRI)),SETWDN=$P(SUBS,"^"),SETTM=$P(SUBS,"^",2) Q:SETWDN=""!(SETTM="")
 .S ^TMP("PSGVBW",$J,SETWDN,PTPRI,SETTM,SETPN)=""
 K ^TMP("PSGVBW2",$J)
 Q
GTOOP ; Get 'Type Of Order' and Package
 I $P(PSJSYSU,";",3)<2,'$G(PSJRNF),'$G(PSJIRNF) S PSJPAC=0,PSJTOO=1 D GTPAC Q
 S (PSJPAC,PSJTOO)=0 W !!,"1) Non-Verified Orders",!,"2) Pending Orders",!!
 N DIR S DIR(0)="LAO^1:2",DIR("A")="Select Order Type(s) (1-2): ",DIR("?")="^D TOH^PSGVBW" D ^DIR
 I 'Y D EXIT("TYPE OF ORDER") Q
 S PSJTOO=$S($L(Y)>2:3,1:$P(Y,","))
 D GTPAC
 I 'PSJPAC D EXIT("PACKAGE") Q
 Q
 ;
GTPAC ; Prompt user for Package
 I ($G(PSJRNF))&('$G(PSJIRNF))&(PSJTOO=2) S PSJPAC=1 Q
 I ($G(PSJIRNF))&('$G(PSJRNF))&(PSJTOO=2) S PSJPAC=2 Q
 W !!,"1) Unit Dose Orders",!,"2) IV Orders",!
 K DIR S DIR(0)="LAO^1:2",DIR("A")="Select Package(s) (1-2): ",DIR("?")="^D TOH^PSGVBW" W ! D ^DIR
 S PSJPAC=$S($L(Y)>2:3,1:$P(Y,","))
 Q
EXIT(X) ; Generic user error message
 W !!,X," not selected, option terminated."
 Q
 ;
TOH ; Help text
 W !!,"SELECT FROM:",!?5,"1 - NON-VERIFIED ORDERS",!?5,"2 - PENDING ORDERS"
 W !!?2,"Enter '1' if you want to verify non-verified orders.  Enter '2' if you",!,"want to complete pending orders.  Enter '1,2' or '1-2' if you want to do both." Q
