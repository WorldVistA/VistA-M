ORSNAST ;SLC/RAF - Policy order search  ;06/25/2007
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**50,263**;Dec 17, 1997;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;this utility will allow the user to enter a date range to search
 ;the orders file, 100, looking for orders with a specific nature
 ;of order or status
 ;
 ;
EN ;
 S U="^" K ^TMP("ORNS",$J),^TMP("ORSERV",$J)
 W @IOF,!!?18,"Nature of Order or Order Status Search.",!?15,"This report is formatted for 132 column output."
 N DASH,DATE,DFN,DIR,DTOUT,DUOUT,EDATE,FORMAT,HDR,HDR1,IEN
 N LOC,LONER,ORIGVIEW,PAGE,PNM,PROV,QUIT,REF,RPDT,SDATE,SER,SERVICE,STOP,TEXT,TEXTSUB
 N SINGLE,SIGNED,SNAME,SSN,STATUS,SORT,SEARCH,SUB
 N VA,VADM,WHEN,WHO,Y
SORT S DIR(0)="SX^1:Nature of order;2:Order Status"
 S DIR("A")="Enter the search criteria"
 S DIR("?")="Enter a 1 to search orders by the Nature of order or a 2 to search orders by the Order Status. Enter an ^ to exit the option."
 D ^DIR S:+Y>0 SORT=+Y K DIR I $D(DTOUT)!($D(DUOUT)) G EXIT
 S DIR(0)=$S(SORT=1:"PA^100.02:AEMQ",SORT=2:"PA^100.01:AEMQ")
 S DIR("A")="Select "_$S(SORT=1:"Nature of order: ",1:"Order Status: ")
 D ^DIR S:+Y>0 SEARCH=+Y,SNAME=$P(Y,U,2) K DIR I $D(DTOUT)!($D(DUOUT)) G EXIT
 D SDATE I $D(DTOUT)!$D(DUOUT) G EXIT
 D EDATE I $D(DTOUT)!$D(DUOUT) G EXIT
 D CKDATE I $D(DTOUT)!$D(DUOUT) G EXIT
FORMAT ;allows choice of formats for evaluation purpose
 S DIR(0)="SX^1:Detailed format;2:Columnar format"
 S DIR("A")="Select output format"
 S DIR("?")="Enter a 1 for a Detailed format and a 2 for a Columnar format. Enter an ^ to exit the option."
 D ^DIR S:+Y>0 FORMAT=+Y K DIR I $D(DTOUT)!$D(DUOUT) G EXIT
SERV ;sets the variable SERVICE equal to 1 if the user wants to sort by
 ;service, or sets it to 0 if not
 I FORMAT=2 D  I $D(DTOUT)!($D(DUOUT)) G EXIT
 .S DIR(0)="Y"
 .S DIR("A")="Would you like to sort the output by service"
 .S DIR("?")="If you answer yes, the output will be sorted by service. Enter an ^ to exit the option."
 .S DIR("B")="NO"
 .D ^DIR S SERVICE=+Y K DIR
SINGLE ;sets variable SINGLE to set up a search of a single service
 I FORMAT=2&($G(SERVICE)) D  I $D(DTOUT)!($D(DUOUT)) G EXIT
 .S DIR(0)="Y",DIR("B")="NO"
 .S DIR("A")="Would you like to search for specific SERVICE/SECTIONS"
 .S DIR("?")="Enter a YES to search by a single SERVICE/SECTION. You may either press enter without selecting a SERVICE/SECTION or enter an ^ to exit the option,"
 .D ^DIR S:+Y>0 SINGLE=+Y K DIR
LONER ;sets DIR call to allow the user to select a single service/section
 I FORMAT=2&($G(SERVICE))&($G(SINGLE)) D  I $D(QUIT)!('$D(LONER)) G EXIT
 .F  D  I $D(QUIT)!(Y=-1) Q
 ..S DIR(0)="PAO^49:AEQM"
 ..S DIR("A")="Select Service/Section: "
 ..D ^DIR S:+Y>0 LONER($P(Y,U,2))=+Y K DIR I $D(DTOUT)!($D(DUOUT)) S QUIT=1
TASK ;
 S %ZIS="Q" D ^%ZIS I POP Q
 I $D(IO("Q")) D  K IO("Q") Q
 .S ZTIO=ION,ZTDESC="File 100 order status search"
 .S ZTRTN="EN^ORSNAST1",ZTSAVE("SORT")="",ZTSAVE("FORMAT")=""
 .S ZTSAVE("SDATE")="",ZTSAVE("EDATE")="",ZTSAVE("SEARCH")=""
 .S ZTSAVE("SNAME")="",ZTSAVE("SERVICE")="",ZTSAVE("SD1")=""
 .S ZTSAVE("ED1")="",ZTSAVE("LONER*")="",ZTSAVE("SINGLE")=""
 .D ^%ZTLOAD I $D(ZTSK) W !,?32,"REQUEST QUEUED"
 U IO D EN^ORSNAST1
 G EXIT
 ;
SDATE ;sets DIR call to ask the user for a starting date
 S DIR(0)="DA^::ETX"
 S DIR("A")="Enter a starting date: "
 S DIR("?")="Enter the date that you wish to start searching with. This date needs to be older than the ending date. For example: If you enter a start date of T-3, the Stop date should be T-2 or less. Enter an ^ to exit the option."
 D ^DIR S:+Y>0 SDATE=+Y K DIR I $D(DTOUT)!($D(DUOUT)) Q
 I SDATE'["." S SDATE=SDATE_.0001
 Q
EDATE ;sets DIR call to ask the user for an ending date (optional)
 S DIR(0)="DA^::ETX"
 S DIR("A")="Enter a ending date: "
 S DIR("?")="Enter the date that you would like the search to end with. This date needs to be more recent than the start date. For example: If you entered a T-3 for the start date, enter a T-2 or less here. Enter an ^ to exit the option."
 D ^DIR S:+Y>0 EDATE=+Y K DIR I $D(DTOUT)!($D(DUOUT)) Q
 I EDATE'["." S EDATE=EDATE_.2359
 Q
CKDATE ; Make sure the end date is not older than the start date.
 I EDATE>SDATE Q
 W !!,?10,"The starting date must be older than the ending date.",!,?10,"Please re-enter start and end dates.",!!
 D SDATE I $D(DTOUT)!$D(DUOUT) Q
 D EDATE I $D(DTOUT)!$D(DUOUT) Q
 G CKDATE
EXIT ;
 K ^TMP("ORNS",$J),^TMP("ORSERV",$J)
 D ^%ZISC
 Q
