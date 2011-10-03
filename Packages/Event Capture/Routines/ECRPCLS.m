ECRPCLS ;ALB/JAP - Event Capture Invalid Provider Report ; 13 Aug 97
 ;;2.0; EVENT CAPTURE ;**5,47**;8 May 96
 ;
EN ;entry point from menu option
 W !
 D RANGE
 I '$G(ECLOOP)!'$G(ECBEGIN)!'$G(ECEND) G EXIT
 W !
 D SORT
 I $G(DIRUT) G EXIT
 I "PR"'[$G(ECSORT) G EXIT
 K DIR,DIRUT,DUOUT
 W !
 D DEVICE
 I POP G EXIT
 I $G(ZTSK) G EXIT
 I $G(IO("Q")),'$G(ZTSK) G EXIT
 D START
 D HOME^%ZIS
 G EXIT
 ;
START ;queued entry point or continuation
 D PROCESS
 U IO D PRINT
 I $D(ECGUI) D EXIT Q
 I IO'=IO(0) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@" D EXIT
 Q
 ;
RANGE ;get any date range between T and T-365
 N X1,X2,ECSTDT,ECENDDT
 W !,?5,"Enter a Begin Date and End Date for this Event Capture "
 W !,?5,"provider report -- both dates must be within the past "
 W !,?5,"365 days.",!
 S (ECBEGIN,ECEND)=0
 F  D  Q:ECBEGIN>0  Q:'$G(ECLOOP)
 .S ECLOOP=$$STDT^ECRUTL() I 'ECLOOP Q
 .S ECBEGIN=ECSTDT
 .S X1=DT,X2=ECBEGIN D ^%DTC I X>365 D
 ..W !!,?15,"The Begin Date for this report may not be"
 ..W !,?15,"more than 365 days ago.  Try again...",!
 ..S ECBEGIN=0
 Q:'$G(ECLOOP)!'$G(ECBEGIN)
 F  D  Q:ECEND>0  Q:'$G(ECLOOP)
 .S ECLOOP=$$ENDDT^ECRUTL(ECSTDT) I 'ECLOOP Q
 .S ECEND=ECENDDT
 .I ECEND>(DT+1) D
 ..W !!,?15,"The End Date for this report may not be"
 ..W !,?15,"a future date.  Try again...",!
 ..S ECEND=0
 Q 
 ;
SORT ;ask user if report should be alpha by patient (P) or
 ;                             alpha by provider (R)
 K DIR
 S DIR(0)="SAXB^P:PATIENT;R:PROVIDER"
 S DIR("?")="Enter an uppercase 'P' or 'R'."
 S DIR("A")="Select sorting by Patient or pRovider (P/R): "
 S DIR("A",1)=" "
 S DIR("A",2)="If you want the report to show Patient name in the 1st column,"
 S DIR("A",3)="enter a 'P'.  The listing will be alphabetical by Patient name."
 S DIR("A",4)=" "
 S DIR("A",5)="If you want the report to show Provider name in the 1st column,"
 S DIR("A",6)="enter an 'R'.  The listing will be alphabetical by Provider name."
 S DIR("A",7)=" "
 D ^DIR
 Q:$G(DIRUT)
 S ECSORT=Y
 Q
 ;
DEVICE ;get device and queue 
 K IOP S %ZIS="QM" D ^%ZIS
 I POP W !!,"No device selected.  Exiting...",!! S DIR(0)="E" W ! D ^DIR K DIR Q
 I $D(IO("Q")) D
 .S ZTRTN="START^ECRPCLS",ZTDESC="EC Invalid Provider Report"
 .S ZTSAVE("ECBEGIN")="",ZTSAVE("ECEND")="",ZTSAVE("ECSORT")=""
 .D ^%ZTLOAD
 .I '$G(ZTSK) W !,"Report canceled..." S DIR(0)="E" W ! D ^DIR K DIR Q
 .W !,"Report queued as Task #: ",ZTSK S DIR(0)="E" W ! D ^DIR K DIR
 Q
 ;
PROCESS ;process the "AC" x-ref in file #721
 ;^ECH("AC",date,file#721 ien)=""
 ;$ORDER from begindate to enddate
 ;use $$GET^XUA4A72(provider ien,date)
 ;if return is >0 then get next x-ref entry
 ;
 N ECD,ECDATA,ECDATE,ECDDT,ECDT,ECERR,ECIEN,ECPIEN,ECPRDT,ECPRIEN,ECPRVN,ECPT,ECPTN,ECS,ECSSN,ECT,ECU,ECU2,ECU3
 K ^TMP("ECRPCLS",$J) S ECDT=ECBEGIN
 F  S ECDT=$O(^ECH("AC",ECDT)) Q:ECDT>ECEND  Q:ECDT=""  D
 .S ECIEN=""
 .F  S ECIEN=$O(^ECH("AC",ECDT,ECIEN)) Q:ECIEN=""  D
 ..S ECDATA=$G(^ECH(ECIEN,0)) I '+ECDATA Q  ;file problem
 ..S ECPRDT=$P(ECDT,".",1),ECDDT=$P(ECDATA,"^",3) I ECDDT'=ECDT S ECPRDT=$P(ECDDT,".",1) ;there's a problem in the x-ref
 ..I ECPRDT<ECBEGIN!(ECPRDT>ECEND) Q
 ..S ECU=$P(ECDATA,"^",11),ECU2=$P(ECDATA,"^",15),ECU3=$P(ECDATA,"^",17)
 ..F ECPIEN=ECU,ECU2,ECU3 D
 ...Q:'+ECPIEN
 ...S ECERR=$$GET^XUA4A72(ECPIEN,ECPRDT) Q:+ECERR>0
 ...S ECD=$P(ECDDT,".",1),ECT=$P(ECDDT,".",2)
 ...S ECDATE=$E(ECD,4,5)_"/"_$E(ECD,6,7)_"/"_$E(ECD,2,3) I +ECT S ECT=$$LJ^XLFSTR(ECT,4,0),ECDATE=ECDATE_" "_$E(ECT,1,2)_":"_$E(ECT,3,4)
 ...S ECPT=$P(ECDATA,"^",2),ECPTN=$P($G(^DPT(ECPT,0)),"^",1) Q:ECPTN=""
 ...S ECS=$P(^(0),"^",9),ECS=$E(ECS,1,9),ECSSN=$E(ECS,6,9)
 ...S ECPRVN=$P($G(^VA(200,ECPIEN,0)),"^",1) Q:ECPRVN=""
 ...S ECPRIEN="("_ECPIEN_")",ECPRIEN=$$RJ^XLFSTR(ECPRIEN,10," ")
 ...;if sort by patient then patient name is 3rd subscript
 ...I ECSORT="P" S ^TMP("ECRPCLS",$J,ECPTN,ECPRVN,ECIEN)=ECERR_"^"_ECPRIEN_"^"_ECSSN_"^"_ECDATE
 ...;if sort by provider then provider name is 3rd subscript
 ...I ECSORT="R" S ^TMP("ECRPCLS",$J,ECPRVN,ECPTN,ECIEN)=ECERR_"^"_ECPRIEN_"^"_ECSSN_"^"_ECDATE
 Q
 ;
PRINT ;output report
 ;
 N X1,X2,PROVIDER,PATIENT,PAGE,PRNTDT,QFLAG,DASH,JJ,SS
 N ECDATA,ECDATE,ECERR,ECIEN,ECPRIEN,ECPRVN,ECPTN,ECSSN
 S (PAGE,QFLAG)=0 S $P(DASH,"-",80)=""
 S Y=$P(ECBEGIN,".",1)+1 D DD^%DT S ECBEGIN=Y S Y=$P(ECEND,".",1) D DD^%DT S ECEND=Y
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S PRNTDT=Y
 D HEAD
 I '$D(^TMP("ECRPCLS",$J)) D  Q
 .W !!,?12,"No invalid providers found for date range specified."
 .I $E(IOST)="C"&('QFLAG) S DIR(0)="E" D  D ^DIR K DIR
 ..S SS=22-$Y F JJ=1:1:SS W !
 .W:$E(IOST)'="C" @IOF
 S X1="" F  S X1=$O(^TMP("ECRPCLS",$J,X1)) Q:X1=""  D
 .S:ECSORT="P" ECPTN=X1 S:ECSORT="R" ECPRVN=X1
 .S X2="" F  S X2=$O(^TMP("ECRPCLS",$J,X1,X2)) Q:X2=""  D
 ..S:ECSORT="P" ECPRVN=X2 S:ECSORT="R" ECPTN=X2
 ..S ECIEN="",ECIEN=$O(^TMP("ECRPCLS",$J,X1,X2,ECIEN)),ECDATA=^(ECIEN)
 ..S ECERR=$P(ECDATA,"^",1),ECPRIEN=$P(ECDATA,"^",2),ECSSN=$P(ECDATA,"^",3),ECDATE=$P(ECDATA,"^",4)
 ..S PROVIDER=$$LJ^XLFSTR($E(ECPRVN,1,20),20," ")_" "_ECPRIEN_"  "_ECERR
 ..S PATIENT=$$LJ^XLFSTR($E(ECPTN,1,20),20," ")_" "_ECSSN_"  "_ECDATE
 ..D:($Y+3>IOSL) HEAD
 ..I ECSORT="P" W !,PATIENT_"  "_PROVIDER
 ..I ECSORT="R" W !,PROVIDER_"   "_PATIENT
 I $E(IOST)="C"&('QFLAG) S DIR(0)="E" D  D ^DIR W @IOF
 .S SS=22-$Y F JJ=1:1:SS W !
 W:$E(IOST)'="C" @IOF
 Q
 ;
HEAD ;report header
 ;write the header line with page # and print date and explanation
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PAGE>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLAG=1 Q
 W:$Y!($E(IOST)="C") @IOF
 S PAGE=PAGE+1
 W !,?12,"Event Capture Providers with Inactive/Missing Person Class"
 W !,?12,"for the Date Range "_ECBEGIN_" through "_ECEND
 W !!,"Printed: "_PRNTDT,?65,"Page: "_PAGE,!
 I PAGE=1 D
 .W !,?12,"The following entries in the Event Capture Patient file (#721)"
 .W !,?12,"are associated with a provider who meets one of the following"
 .W !,?12,"criteria:",!
 .W !,?22,"(a) The provider has no Person Class"
 .W !,?22,"    specified in file #200. (Error=-1)"
 .W !,?22,"(b) The provider does not have an active"
 .W !,?22,"    Person Class in file #200 for the"
 .W !,?22,"    date of procedure. (Error=-2)",!
 .W !,?12,"The provider's record number in file #200 is shown in parentheses"
 .W !,?12,"after the provider name.",!
 I ECSORT="P" D SUBHDA
 I ECSORT="R" D SUBHDB
 Q
 ;
SUBHDA ;subheader for sort by patient
 W !,?27,"Date of"
 W !,"Patient",?21,"SSN",?27,"Procedure",?43,"Provider",?75,"Err."
 W !,DASH,!
 Q
 ;
SUBHDB ;subheader for sort by provider
 W !,?65,"Date of"
 W !,"Provider",?32,"Err.",?38,"Patient",?59,"SSN",?65,"Procedure"
 W !,DASH,!
 Q
 ;
EXIT ;common exit point & clean-up
 D ^ECKILL
 D:'$D(ECGUI) ^%ZISC
 K ^TMP("ECRPCLS",$J)
 K DIR,DIRUT,DTOUT,DUOUT,ECBEGIN,ECEND,ECSORT,ECLOOP
 K IO("Q"),POP,X,Y,ZTSK,ZTRTN,ZTDESC,ZTSAVE
 Q
