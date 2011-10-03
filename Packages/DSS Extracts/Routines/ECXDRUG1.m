ECXDRUG1 ;ALB/TMD-Pharmacy Extracts Incomplete Feeder Key Report ; 2/17/04 3:23pm
 ;;3.0;DSS EXTRACTS;**40,68**;Dec 22, 1997
 ;
EN ; entry point
 N X,Y,DATE,ECRUN,ECXTL,ECSTART,ECEND,ECXDESC,ECXSAVE,ECXOPT,ECSD1,ECED,ECXERR,QFLG
 S QFLG=0
 ; get today's date
 D NOW^%DTC S DATE=X,Y=$E(%,1,12) D DD^%DT S ECRUN=$P(Y,"@") K %DT
 D BEGIN Q:QFLG
 D SELECT Q:QFLG
 S ECXDESC=ECXTL_" Extract Incomplete Feeder Key Report"
 S ECXSAVE("EC*")=""
 W !!,"This report requires 132 column format."
 D EN^XUTMDEVQ("PROCESS^ECXDRUG1",ECXDESC,.ECXSAVE)
 I POP W !!,"No device selected...exiting.",! Q
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
BEGIN ; display report description
 W @IOF,!,"This report prints a listing of Drug File (#50) entries that will generate",!,"incomplete Feeder keys in the three Pharmacy Extracts.  This listing",!,"can be used to identify and fix Drug File entries.  "
 W "The number of extract",!,"records, total, quantity, unit price and total cost for each drug are",!,"included to aid in determining the impact of the incomplete Feeder Keys."
 W !!,"This report is broken into 3 sections as follows:"
 W !!,"Section 1:  No PSNDF VA Product Name Entry (first 5 digits are zero)."
 W !!,"Section 2:  No National Drug Code (NDC) (last 12 digits are zero) or the NDC",!,?12,"is prefixed with an 'S', indicating possible supply item number",!,?12,"or UPC."
 W !!,"Section 3:  No PSNDF VA Product Name Entry, and"
 W !,?14,"a. no NDC (all 17 digits are zero), or"
 W !,?14,"b. The NDC is prefixed with an 'S', indicating possible supply",!,?17,"item number or UPC."
 W !,"Section 3:  No PSNDF VA Product Name Entry or NDC."
 W !!,"Run times for this report will vary depending upon the size of the extract and",!,"could take as long as 30 minutes or more to complete.  This report has no effect",!,"on the actual extracts and can be run as needed."
 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 W:$Y!($E(IOST)="C") @IOF,!!
 Q
 ;
SELECT ; user inputs for report option and date range
 N DONE,OUT
 ; allow user to select report option (PRE,IVP or UDP)
 W "Choose the report you would like to run."
 S DIR(0)="S^1:PRE;2:IVP;3:UDP",DIR("A")="Selection",DIR("B")=1 D ^DIR K DIR S ECXOPT=Y I X["^" S QFLG=1 Q
 S ECXTL=$S(ECXOPT=1:"Prescription",ECXOPT=2:"IV Detail",ECXOPT=3:"Unit Dose Local",1:"")
 ; allow user to select date range for report records
 W !!,"Enter the date range for which you would like to scan the ",ECXTL,!,"Extract records."
 S DONE=0 F  S (ECED,ECSD)="" D  Q:QFLG!DONE
 .K %DT S %DT="AEX",%DT("A")="Starting with Date: ",%DT(0)=-DATE D ^%DT
 .I Y<0 S QFLG=1 Q
 .S ECSD=Y,ECSD1=ECSD-.1
 .D DD^%DT S ECSTART=Y
 .K %DT S %DT="AEX",%DT("A")="Ending with Date: ",%DT(0)=-DATE D ^%DT
 .I Y<0 S QFLG=1 Q
 .I Y<ECSD D  Q
 ..W !!,"The ending date cannot be earlier than the starting date."
 ..W !,"Please try again.",!!
 .I $E(Y,1,5)'=$E(ECSD,1,5) D  Q
 ..W !!,"Beginning and ending dates must be in the same month and year."
 ..W !,"Please try again.",!!
 .S ECED=Y
 .D DD^%DT S ECEND=Y
 .S DONE=1
 Q
 ;
PROCESS ; entry point for queued report
 S ZTREQ="@"
 S ECXERR=0 D EN^ECXDRUG2 Q:ECXERR
 S QFLG=0 D PRINT
 Q
 ;
PRINT ; process temp file and print report
 N PG,GTOT,LN,S,COUNT,SUBTOT,DR,ECTYPE,REC,STATS,ECCOUNT,ECQTY,ECPRC,ECCOST
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (PG,QFLG,GTOT)=0,$P(LN,"-",132)=""
 F S=1:1:3  Q:QFLG  D HEADER Q:QFLG  D
 .S (COUNT,SUBTOT)=0,DR="" F  S DR=$O(^TMP($J,DR)) Q:DR=""!QFLG  S ECTYPE=$P(^(DR),U,4) I ECTYPE=S D
 ..S REC=^TMP($J,DR),STATS=^(DR,0)
 ..S COUNT=COUNT+1
 ..S ECCOUNT=$FNUMBER($P(STATS,U),",")
 ..S ECQTY=$FNUMBER($P(STATS,U,2),",")
 ..S ECPRC="$"_$FNUMBER($P(REC,U,3),",",4)
 ..S ECCOST="$"_$FNUMBER($P(STATS,U,3),",",2)
 ..S SUBTOT=SUBTOT+$P(STATS,U,3)
 ..W !,$$RJ^XLFSTR(DR,5),?8,$P(REC,U),?60,$P(REC,U,2),?79,$$RJ^XLFSTR(ECCOUNT,5),?87,$$RJ^XLFSTR(ECQTY,10),?99,$$RJ^XLFSTR(ECPRC,16),?117,$$RJ^XLFSTR(ECCOST,13)
 ..I $Y+2>IOSL D HEADER
 .Q:QFLG
 .I COUNT=0 W !!,?8,"No drugs to report for this section"
 .; print sub total
 .I COUNT D
 ..I $Y+3>IOSL D HEADER Q:QFLG
 ..S GTOT=GTOT+SUBTOT
 ..S SUBTOT="$"_$FNUMBER(SUBTOT,",",2)
 ..W !!,?110,"TOTAL",?116,$$RJ^XLFSTR(SUBTOT,14)
 ; print grand total
 I GTOT,'QFLG D
 .I $Y+3>IOSL D HEADER Q:QFLG
 .S GTOT="$"_$FNUMBER(GTOT,",",2)
 .W !!,?104,"GRAND TOTAL",?116,$$RJ^XLFSTR(GTOT,14)
 ;
CLOSE ;
 I $E(IOST)="C",'QFLG D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 Q
 ;
HEADER ; header and page control
 N SS,JJ
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,ECXTL_" Extract Incomplete Feeder Key Report",?124,"Page: "_PG
 W !,"Start Date: ",ECSTART
 W !,"End Date:   ",ECEND,?97,"Report Run Date/Time:  "_ECRUN
 W !!,"Drug",?8,"Generic Name",?60,"Feeder Key",?79,"# of",?89,"Total",?107,"Unit",?122,"Total"
 W !,"Entry",?79,"Records",?89,"Quantity",?107,"Price",?122,"Cost"
 W !,LN
 I S=1 W !!,"No PSNDF VA Product Name Entry (Five leading zeros)",!
 I S=2 W !!,"No National Drug Code (NDC) (Last 12 zeros, 'N/A', or 'S' prefix)",!
 I S=3 W !!,"No PSNDF VA Product Name Entry or National Drug Code (NDC)",!
 Q
 ;
