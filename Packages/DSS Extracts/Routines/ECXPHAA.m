ECXPHAA ;ALB/JRC Pharmacy DSS Extract UDP/IVP Source Audit Report ;5/31/17  16:00
 ;;3.0;DSS EXTRACTS;**92,142,149,161,166**;Dec 22, 1997;Build 24
 ;
EN ;entry point from option
 N SCRNARR,STOP,REPORT,DIVISION,SDATE,EDATE,X,TMP,ECXPORT,CNT ;149
 S SCRNARR="^TMP($J,""ECXPHAA"")",STOP=0
 K @SCRNARR
 S STOP=0
 ;Select report
 D REPORT  Q:STOP
 ;Select division
 D DIVISION  Q:STOP
 ;Select date range
 D DATES  Q:STOP
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I $G(ECXPORT) D  Q  ;149 Section added
 .K ^TMP($J,"ECXPORT")
 .S ^TMP($J,"ECXPORT",0)="DIVISION^DATE^RECORD COUNT",CNT=1
 .D @$S(REPORT=2:"GETUDATA",REPORT=1:"GETIDATA",1:"")  ;tjl 166 Changed order
 .D DETAIL
 .D EXPDISP^ECXUTL1
 .K ^TMP($J,"ECXPORT"),^TMP($J,"ECXPHAA")
 ;Queue Report
 N ZTDESC,ZTIO,ZTSAVE
 F X="REPORT","SDATE","EDATE","STOP" S ZTSAVE(X)=""
 S ZTSAVE("SCRNARR")=""
 S TMP=$$OREF^DILF(SCRNARR)
 S ZTSAVE(TMP)=""
 I $D(@SCRNARR)#2 S ZTSAVE(SCRNARR)=""
 S ZTIO=""
 S ZTDESC="DSS UDP/IVP Source Audit Report"
 D EN^XUTMDEVQ("EN1^ECXPHAA",ZTDESC,.ZTSAVE)
 Q
 ;
EN1 ;Init variables
 N PAGE,LN,SUB
 S SUB="",PAGE=0
 D HEADER I STOP D EXIT Q
 S SUB=$S(REPORT=2:"GETUDATA",REPORT=1:"GETIDATA",1:"")  ;tjl 166 Changed order
 D @SUB I STOP D EXIT Q
 I '$O(^TMP($J,"ECXPHAA",0)) D  Q
 .W !
 .W !,"************************************************************"
 .W !,"*  NOTHING TO REPORT FOR PHARMACY "_$S(REPORT=2:"UDP",REPORT=1:"IVP",1:"")_" SOURCE AUDIT REPORT  *"
 .W !,"************************************************************"
 .D WAIT
 .D EXIT
 D DETAIL I STOP D EXIT Q
EXIT K @SCRNARR Q
 ;
REPORT ;Select report
 N DIR,DIRUT,DUOUT
 ;Prepare choices
 S DIR(0)="S^1:IVP;2:UDP"  ;tjl 166 Changed order
 S DIR("A")="Select Source Audit Report"
 D ^DIR
 I $D(DIRUT)!$D(DUOUT) S STOP=1 Q
 S REPORT=Y
 Q
 ;
DIVISION ;Prompt for division
 ; Set Divisions into screen array (prompt is one/many/all)
 ;Input  : SCRNARR - Screen array full global reference
 ;Output : 1 = OK     0 = User abort/timeout
 ;         @SCRNARR@("DIVISION") = User pick all divisions ?
 ;           1 = Yes (all)     0 = No
 ;         @SCRNARR@("DIVISION",PtrDiv) = Division name
 ;Note   : @SCRNARR@("DIVISION") is initialized (KILLed) on input
 ;       : @SCRNARR@("DIVISION",PtrDiv) is only set when the user
 ;         picked individual divisions (i.e. didn't pick all)
 ;
 ;Declare variables
 N VAUTD,Y,DIV,FAC
 ;Get division selection
 D DIVISION^VAUTOMA
 I Y<0 S STOP=1 Q
 M @SCRNARR@("DIVISION")=VAUTD
 I VAUTD=0 D
 .S DIV=0 F  S DIV=$O(VAUTD(DIV)) Q:DIV'>0  S FAC=$$GETDIV^ECXDEPT(DIV) S @SCRNARR@("DIVISION",FAC)=""
 Q
 ;
DATES ;Prompt for start date
 N DIR,DIRUT,X,Y
 S DIR(0)="D^:NOW:EX"
 S DIR("A")="Enter Report Start Date"
 S DIR("B")=$$FMTE^XLFDT($$NOW^XLFDT,"1D")
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 S SDATE=Y
 ;Prompt for end date
 K DIR,DIRUT,X,Y
 S DIR(0)="D^:NOW:EX"
 S DIR("A")="Enter Report End Date"
 S DIR("B")=$$FMTE^XLFDT($$NOW^XLFDT,"1D")
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 S EDATE=Y
 Q
 ;
HEADER ;Print header
 S PAGE=$G(PAGE)+1,$P(LN,"=",80)=""
 W @IOF
 W !,$S(REPORT=2:"UDP",REPORT=1:"IVP",1:"")_" Source Audit Report",?70,"PAGE: "_PAGE
 W !!,"Run Date:   "_$$FMTE^XLFDT(DT)
 W !!,"Start Date: "_$$FMTE^XLFDT(SDATE)
 W !,"End Date:   "_$$FMTE^XLFDT(EDATE)
 W !!,?1,"Division",?24,"Date",?39,"Record Count"
 W !,LN
 Q
 ;
GETIDATA ;Get data from pharmacy IVP intermediate files
 ;Init variables
 N DATE,FILE,DFN,ERROR,ON,DA,ECPAT,EC,ENDATE ;161
 S DATE=SDATE-.1,ENDATE=EDATE+.999,FILE=728.113 ;161
 F  S DATE=$O(^ECX(FILE,"A",DATE)) Q:'DATE!(DATE>ENDATE)  D  Q:STOP  ;161
 .S DFN=0 F  S DFN=$O(^ECX(FILE,"A",DATE,DFN)) Q:'DFN  D  Q:STOP
 ..;Filter out test patients or bad records
 ..;patch 142--corrected to not display test patients
 ..S ERROR=$$PAT^ECXNUT(DFN) Q:ERROR
 ..S ON=0 F  S ON=$O(^ECX(FILE,"A",DATE,DFN,ON)) Q:'ON  D  Q:STOP
 ...S DA=0 F  S DA=$O(^ECX(FILE,"A",DATE,DFN,ON,DA)) Q:'DA!(STOP)  D  Q:STOP
 ....I $D(^ECX(728.113,DA,0)) S EC=^(0) D  Q:STOP
 .....;get inpatient data if exist
 .....N MOVEMENT,ADMIT,SPECIAL,WARD,DIVISION,CLINIC ;161
 .....N DIC,DIQ,DR,ECXDIC,DA
 .....S (MOVEMENT,ADMIT,SPECIAL,WARD,DIVISION,CLINIC)="" ;161
 .....S WARD=$$GET1^DIQ(55.01,ON_","_DFN_",",104,"I") S:WARD=.5 WARD="" S:WARD'="" WARD=WARD_";"_$$GET1^DIQ(42,WARD,.015,"I") ;161 Get ward information from pharmacy order. Ward of .5 indicates outpatient
 .....I WARD'="" S DIVISION=$$GETDIV^ECXDEPT($P(WARD,";",2)) ;161
 .....I WARD="" D  Q:STOP  ;161
 ......;Get division from outpatient location file 44
 ......S CLINIC=+$P(EC,U,13)
 ......S DIC="^SC(",DIQ(0)="I",DIQ="ECXDIC",DR="3.5",DA=CLINIC ;161
 ......D EN^DIQ1
 ......S DIVISION=$$GETDIV^ECXDEPT(+$G(ECXDIC(44,CLINIC,3.5,"I"))) ;161
 ......S DIVISION=$S(DIVISION'="":DIVISION,1:"UNKNOWN")
 .....I DIVISION="UNKNOWN",$P(EC,U,15) D  ;161 Section added to get information from IV room if no ward or clinic is available
 ......S DIVISION=$$GETDIV^ECXDEPT($$PSJ59P5^ECXUTL5($P(EC,U,15)))
 .....;Save in temp global and filter division
 .....I '@SCRNARR@("DIVISION")=1&'($D(@SCRNARR@("DIVISION",DIVISION))) Q
 .....S ^TMP($J,"ECXPHAA",$P(DATE,".",1),DIVISION)=$G(^TMP($J,"ECXPHAA",$P(DATE,".",1),DIVISION))+1
 Q
 ;
GETUDATA ;Get unit dose data from intermediate file 728.904
 ;Init variables
 N DATE,FILE,RECORD,DATA,DFN,ERROR,ON,WARD,DIVISION,DIC,DIQ,DR,DA,ECPAT,CLINIC,COUNT,L,ECXDIC,ENDATE ;149,161
 S DATE=SDATE-.1,ENDATE=EDATE+.999,STOP=0 ;161
 S FILE=728.904
 F  S DATE=$O(^ECX(FILE,"A",DATE)) Q:'DATE!(DATE>ENDATE)  D  Q:STOP  ;161
 .S RECORD=0 F  S RECORD=$O(^ECX(FILE,"A",DATE,RECORD)) Q:'RECORD  D  Q:STOP
 ..S DATA=$G(^ECX(FILE,RECORD,0)),DFN=$P(DATA,U,2)
 ..;Filter out test patients or bad records
 ..;patch 142-corrected to not display test patients
 ..S ERROR=$$PAT^ECXNUT(DFN) Q:ERROR
 ..S ON=$P(DATA,U,10),WARD=$P(DATA,U,6)
 ..S DIVISION=$$GETDIV^ECXDEPT($P($G(^DIC(42,+WARD,0)),U,11))
 ..I WARD=""&(ON) D  Q:STOP  ;161
 ...;Get division from outpatient location from file 44
 ...S DIC=55,DIQ(0)="I",DIQ="ECXDIC",DR="62",DR(55.06)="130",DA=DFN
 ...S DA(55.06)=+ON D EN^DIQ1
 ...S CLINIC=+$G(ECXDIC(55.06,+ON,130,"I")) ;161
 ...S DIC="^SC(",DIQ(0)="I",DIQ="ECXDIC",DR=3.5,DA=CLINIC D EN^DIQ1 ;161
 ...S DIVISION=$$GETDIV^ECXDEPT(+$G(ECXDIC(44,CLINIC,3.5,"I"))) ;161
 ...S DIVISION=$S(DIVISION'="":DIVISION,1:"UNKNOWN") K ECXDIC ;161
 ..;Save in temp global and filter division
 ..I '@SCRNARR@("DIVISION")=1&'($D(@SCRNARR@("DIVISION",DIVISION))) Q
 ..S ^TMP($J,"ECXPHAA",$P(DATE,".",1),DIVISION)=$G(^TMP($J,"ECXPHAA",$P(DATE,".",1),DIVISION))+1
 Q
 ;
DETAIL ;Print report
 ;Init variables
 N DATE,DIV,COUNT ;149
 S (DATE,COUNT)=0,DIV="" ;149
 F  S DATE=$O(^TMP($J,"ECXPHAA",DATE)) Q:'DATE!(STOP)  F  S DIV=$O(^TMP($J,"ECXPHAA",DATE,DIV)) Q:DIV=""!(STOP)  S COUNT=^(DIV) D  ;149
 .I $G(ECXPORT) S ^TMP($J,"ECXPORT",CNT)=DIV_U_$$FMTE^XLFDT(DATE)_U_COUNT,CNT=CNT+1 Q  ;149
 .W !,?1,DIV,?20,$$FMTE^XLFDT(DATE),?45,COUNT I $Y>(IOSL-5) D WAIT Q:STOP  D HEADER ;149
 Q
 ;
WAIT ;End of page logic
 ;Input   ; None
 ;Output  ; STOP - Flag indicating if printing should continue
 ;                 1 = Stop     0 = Continue
 ;
 S STOP=0
 ;CRT - Prompt for continue
 I $E(IOST,1,2)="C-"&(IOSL'>24) D  Q
 .F  Q:$Y>(IOSL-3)  W !
 .N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 .S DIR(0)="E"
 .D ^DIR
 .S STOP=$S(Y'=1:1,1:0)
 ;Background task - check taskman
 S STOP=$$S^%ZTLOAD()
 I STOP D
 .W !,"*********************************************"
 .W !,"*  PRINTING OF REPORT STOPPED AS REQUESTED  *"
 .W !,"*********************************************"
 Q
