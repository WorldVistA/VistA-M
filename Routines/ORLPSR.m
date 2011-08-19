ORLPSR ; SLC/RAF-unsigned orders search ;10/19/00  14:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243**;Dec 17, 1997;Build 242
 ;
 ;This routine will loop thru the "AS" xref in file 100 and 
 ;allow the user to sort orders by date range, with a status of unsigned,
 ;released/unsigned or unsigned/unreleased. It will also allow sorting by
 ;service/section, provider, patient, location, entered by person,
 ;or division
 ;
EN ;
 N CNT,DASH,DATE,DCNT,DFN,DIR,DIRUT,DIV,DTOUT,DUOUT,EDATE,EDT
 N HDR,HDR1,IEN,LCNT,LOC,LONER,LONUM,PAGE,PAT,PNM,PROV,QUIT,RPDT
 N SD1,SD2,SDATE,SDT,SER,SINGLE,SORT,SSN,STOP,STATUS,SUB,SUMONLY,TOT,TOT0,TOT1
 N TYPE,VA,VADM,VAERR,WHO,WHEN,Y
 S U="^" K ^TMP("ORUNS",$J),^TMP("ORSTATS",$J)
 W @IOF,!!?30,"Lapsed Orders Search",!?15,"This report is formatted for a 132 column output.",!
TYPE S TYPE=2
SORT ;sets DIR call to ask for the sorting criteria
 S DIR(0)="SX^1:Service/Section;2:Provider;3:Patient;4:Location;5:Entered By;6:Division"
 S DIR("A")="Enter the sort criteria"
 S DIR("?")="To sort orders by Service/Section enter a 1, by Provider enter a 2, by Patient enter a 3, by Location enter a 4, by Entering Person enter a 5 and by Division enter a 6, Enter an ^ to exit the option"
 D ^DIR S:+Y>0 SORT=+Y K DIR I $D(DTOUT)!$D(DUOUT) G EXIT
SINGLE ;sets DIR call to ask the user if they want to sort for a single
 ;service, provider, patient, location, division or entered by
 S DIR(0)="Y"
 S DIR("A")="Would you like a specific "_$S(SORT=1:"Service/Section",SORT=2:"Provider",SORT=3:"Patient",SORT=4:"Location",SORT=5:"Entering person",1:"Division")
 S DIR("B")="NO"
 S DIR("?")="You can limit your sort to one or more Service/Section, Provider, Patient, Location, Entered by, or Division, by entering a YES  here"
 D ^DIR S:+Y>0 SINGLE=+Y K DIR I $D(DTOUT)!$D(DUOUT) G EXIT
LONER ;sets DIR call to allow the user to select the specific sort entity
 ;only asked if the user entered a YES in the previous prompt
 I $D(SINGLE) D  I $D(QUIT)!('$D(LONER)) G EXIT
 .F  D  I Y=-1!($D(QUIT)) Q
 ..S DIR(0)=$S(SORT=1:"PAO^49:AEQM",SORT=2:"PAO^200:AEQM,",SORT=3:"PAO^2:AEQM",SORT=4:"PAO^44:AEQM",SORT=5:"PAO^200:AEQM",SORT=6:"PAO^40.8:AEQM")
 ..S DIR("A")="Select "_$S(SORT=1:"Service/Section: ",SORT=2:"Provider: ",SORT=3:"Patient: ",SORT=4:"Location: ",SORT=5:"Entering Person: ",1:"Division: ")
 ..S DIR("?")="When finished entering all the selections you want, press return or enter to go on. Enter an ^ to exit the option."
 ..D ^DIR S:+Y>0 LONER($P(Y,U,2))=+Y K DIR I $D(DTOUT)!$D(DUOUT) S QUIT=1
SDATE ;sets DIR call to ask the user for a starting date
 S DIR(0)="DA^::ETX"
 S DIR("A")="Enter a starting date: "
 S DIR("?")="Enter the date or date/time that you want the search to start with.  Example: If your site has a 48 hr grace period for signing orders,         enter T-2"
 D ^DIR S:+Y>0 (SDATE,SD1)=(9999999-Y),SDT=$$FMTE^XLFDT(Y) K DIR I $D(DTOUT)!$D(DUOUT) G EXIT
EDATE ;sets DIR call to ask the user for an ending date (optional)
 S DIR(0)="DA^::ETX"
 S DIR("A")="Enter an ending date: "
 S DIR("?")="Enter the date or date/time that you want the search to end with. This field can be used to ignore pre-CPRS unsigned orders by entering the date of your CPRS installation."
 D ^DIR S (EDATE,SD2)=(9999999-Y),EDT=$$FMTE^XLFDT(Y) K DIR I $D(DTOUT)!$D(DUOUT) G EXIT
SWITCH ;takes the date input from the user and does a switcheroo so the program
 ;can work as intended
 I EDATE'>SDATE S EDATE=SD1,SDATE=SD2
SUMONLY ;ask if summary only or full detail
 S DIR(0)="Y",DIR("A")="Print summary only ",DIR("B")="NO",DIR("?")="Enter yes for summary report (statistics), no for detailed report."
 D ^DIR S SUMONLY=$S(Y=1:1,Y=0:0,1:"^") K DIR I SUMONLY="^" Q
TASK ;
 S %ZIS="Q" D ^%ZIS I POP Q
 I $D(IO("Q")) D  K IO("Q") Q
 .S ZTIO=ION,ZTDESC="File 100 order status search"
 .S ZTRTN="LOOP^ORLPSRA",ZTSAVE("SORT")="",ZTSAVE("TYPE")=""
 .S ZTSAVE("SDATE")="",ZTSAVE("EDATE")="",ZTSAVE("SINGLE")=""
 .S ZTSAVE("LONER*")="",ZTSAVE("SDT")="",ZTSAVE("EDT")="",ZTSAVE("SUMONLY")=""
 .D ^%ZTLOAD I $D(ZTSK) W !,?32,"REQUEST QUEUED"
 U IO D LOOP^ORLPSRA Q
STATS ;SERVICE/SECTION statistics
 S:SUMONLY PAGE=0 S SUMONLY=0 ;Set SUMONLY back to zero so header will print.
 I '$D(^TMP("ORSTATS",$J)) D HDR Q:STOP  W !,"There are no statistics for the selected sort range." Q
 I SORT=1&($D(^TMP("ORSTATS",$J))) D
 .S HDR="!!?25,""Order Statistics for Service/Section sort"""
 .S HDR1="!,""Service/Section"",?25,""Provider"",?50,""# of Orders"""
 .S TOT=0 D HDR
 .S SER="" F  S SER=$O(^TMP("ORSTATS",$J,SER)) S TOT0=0 Q:SER=""!STOP  D
 ..S PROV="" F  S PROV=$O(^TMP("ORSTATS",$J,SER,PROV)) Q:PROV=""!STOP  D
 ...W SER,?25,PROV,?50,^(PROV),! S TOT1=^(PROV),TOT0=TOT0+TOT1
 ...S TOT=TOT+TOT1 D:$Y>(IOSL-4) HDR Q:STOP
 ..W:'STOP ?46,"SUBTOTAL: ",TOT0,!
 .W:'STOP ?46,"------------",!?46,"TOTAL: ",TOT
PV ;PROVIDER statistics
 I SORT=2&($D(^TMP("ORSTATS",$J))) D
 .S HDR="!!?25,""Order Statistics for Provider sort"""
 .S HDR1="!,""Provider"",?25,""Patient"",?50,""# of Orders"""
 .S TOT=0 D HDR
 .S PROV="" F  S PROV=$O(^TMP("ORSTATS",$J,PROV)) S TOT0=0 Q:PROV=""!STOP  D
 ..S PNM="" F  S PNM=$O(^TMP("ORSTATS",$J,PROV,PNM)) Q:PNM=""!STOP  D
 ...W PROV,?25,PNM,?50,^(PNM),! S TOT1=^(PNM)
 ...S TOT=TOT+TOT1,TOT0=TOT0+TOT1 D:$Y>(IOSL-4) HDR Q:STOP
 ..W:'STOP ?46,"SUBTOTAL: ",TOT0,!
 .W:'STOP ?46,"------------",!?46,"TOTAL: ",TOT
PT ;PATIENT statistics
 I SORT=3&($D(^TMP("ORSTATS",$J))) D
 .S HDR="!!?25,""Order Statistics for Patient sort"""
 .S HDR1="!,""Patient"",?25,""Provider"",?50,""# of Orders"""
 .S TOT=0 D HDR
 .S PNM="" F  S PNM=$O(^TMP("ORSTATS",$J,PNM)) S TOT0=0 Q:PNM=""!STOP  D
 ..S PROV="" F  S PROV=$O(^TMP("ORSTATS",$J,PNM,PROV)) Q:PROV=""!STOP  D
 ...W PNM,?25,PROV,?50,^(PROV),! S TOT1=^(PROV),TOT0=TOT0+TOT1
 ...S TOT=TOT+TOT1 D:$Y>(IOSL-4) HDR Q:STOP
 ..W:'STOP ?46,"SUBTOTAL: ",TOT0,!
 .W:'STOP ?46,"------------",!?46,"TOTAL: ",TOT
L ;LOCATION statistics
 I SORT=4&($D(^TMP("ORSTATS",$J))) D
 .S HDR="!!?25,""Order Statistics for Location sort"""
 .S HDR1="!,""Location"",?25,""Provider"",?50,""# of Orders"""
 .S TOT=0 D HDR
 .S LOC="" F  S LOC=$O(^TMP("ORSTATS",$J,LOC)) S TOT0=0 Q:LOC=""!STOP  D
 ..S PROV="" F  S PROV=$O(^TMP("ORSTATS",$J,LOC,PROV)) Q:PROV=""!STOP  D
 ...W $E(LOC,1,24),?25,PROV,?50,^(PROV),! S TOT1=^(PROV),TOT0=TOT0+TOT1
 ...S TOT=TOT+TOT1 D:$Y>(IOSL-4) HDR Q:STOP
 ..W:'STOP ?46,"SUBTOTAL: ",TOT0,!
 .W:'STOP ?46,"------------",!?46,"TOTAL: ",TOT
EB ;ENTERED BY statistics
 I SORT=5&($D(^TMP("ORSTATS",$J))) D
 .S HDR="!!?25,""Order Statistics for Entering Person sort"""
 .S HDR1="!,""Entering person"",?25,""Patient"",?50,""# of Orders"""
 .S TOT=0 D HDR
 .S WHO="" F  S WHO=$O(^TMP("ORSTATS",$J,WHO)) S TOT0=0 Q:WHO=""!STOP  D
 ..S PNM="" F  S PNM=$O(^TMP("ORSTATS",$J,WHO,PNM)) Q:PNM=""!STOP  D
 ...W WHO,?25,PNM,?50,^(PNM),! S TOT1=^(PNM),TOT0=TOT0+TOT1
 ...S TOT=TOT+TOT1 D:$Y>(IOS-4) HDR Q:STOP
 ..W:'STOP ?46,"SUBTOTAL: ",TOT0,!
 .W:'STOP ?46,"------------",!?46,"TOTAL: ",TOT
D ;DIVISION statistics
 I SORT=6&($D(^TMP("ORSTATS",$J))) D
 .S HDR="!!?25,""Order Statistics for Division sort"""
 .S DIV="" F  S DIV=$O(^TMP("ORSTATS",$J,DIV)) Q:DIV=""!STOP  S DCNT=0 D
 ..S LOC="" F  S LOC=$O(^TMP("ORSTATS",$J,DIV,LOC)) Q:LOC=""!STOP  S LCNT=0 D
 ...S HDR1="!!,""Division: "",DIV,!?5,""Location: "",LOC,!?20,""Provider"",?51,""Orders""" D HDR Q:STOP
 ...S PROV="" F  S PROV=$O(^TMP("ORSTATS",$J,DIV,LOC,PROV)) Q:PROV=""!STOP  D
 ....W ?20,PROV,?51,^(PROV),! S LCNT=LCNT+^(PROV) D:$Y>(IOSL-4) HDR Q:STOP
 ...I 'STOP W !?41,"Subtotal",?51,LCNT S DCNT=DCNT+LCNT
 ..I 'STOP W !?5,"Total orders for Division: ",DIV_" = "_DCNT
EXIT K ^TMP("ORUNS",$J),^TMP("ORSTATS",$J)
 D ^%ZISC
 Q
LOC(LOC) ;resolves the location pointer
 N X
 S X=$P(^SC(+LOC,0),U)
 Q X
USER(USER) ;resolves user pointers
 N X
 S X=$E($P(^VA(200,+USER,0),U),1,24)
 Q X
STAT(STA) ;resolves pointer to the order status file
 N X
 S X=$E($P(^ORD(100.01,+STA,0),U),1,14)
 Q X
SER(SER) ;resolves pointer to the service/section file
 N X
 S X=$P(^DIC(49,+SER,0),U)
 Q X
DIV(LOC) ;determines the division based on the entry in file 44
 N X
 S X=$P(^SC(+LOC,0),U,15) I X="" Q "UNKNOWN"
 S X=$P(^DG(40.8,X,0),U)
 Q X
HDR ;Print header
 I $G(SUMONLY) Q
 I $E(IOST)="C"&(PAGE) S DIR(0)="E" D ^DIR S:Y'=1 STOP=1 K DIR Q:STOP
 I PAGE!('PAGE&($E(IOST)="C")) W @IOF
 I $D(RPDT) W @RPDT
 I $D(HDR) W @HDR
 I $D(HDR1) W @HDR1
 W !,$$REPEAT^XLFSTR("-",IOM),!
 S PAGE=1
 Q
