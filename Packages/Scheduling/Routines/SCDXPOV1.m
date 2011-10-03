SCDXPOV1 ;ALB/SCK - VISIT REPORT BY NPCDB TRANSMISSION STATUS ;11/29/99  19:23
 ;;5.3;Scheduling;**73,173**;AUG 13, 1993
 Q
WRT ; Entry point for printing visit reprot
 ;
 ;   Variables:
 ;      DVN     - Division IEN used in VA(389.9, and DG(40.8 for retreiving division name
 ;      DNAME   - Division name for printing on report
 ;      SDASH   - Single dash line for report formatting
 ;      SDBDASH - Double dash line for report formatting
 ;      SCETOT  - Total encounters, Eligibility
 ;
 N DVN,DNAME,SDASH,SDBDASH,SDNM,SCETOT
 S $P(SDASH,"-",40)="",$P(SDBDASH,"=",76)=""
 ;
 U IO
 I 'SCXMD D  G END
 . S DVN=$P($$SITE^VASITE(SCXBEG),U,3),DNAME=$P($$SITE^VASITE(SCXBEG),U,2)
 . D XMTPRT
 ;
 I SCXTFLG D  G END
 . S DVN="TOT",DNAME="FACILITY TOTALS: "_$P($$SITE^VASITE(SCXBEG),U,2)
 . D XMTPRT
 ;
 S DVN=0
 F  S DVN=$O(^TMP("SCDXPOV",$J,DVN)) Q:DVN=""  S:DVN'["TOT" SDNM=$O(^VA(389.9,"D",DVN,0)),DNAME=+$P(^VA(389.9,SDNM,0),U,3) D  Q:SCXABRT
 . S DNAME=$S('DNAME:"UNKNOWN "_DVN,'$D(^DG(40.8,DNAME,0)):"UNKNOWN",1:$P(^DG(40.8,DNAME,0),U))
 . S:DVN["TOT" DNAME="FACILITY TOTALS: "_$P($$SITE^VASITE(SCXBEG),U,2)
 . D XMTPRT
END Q
 ;
XMTPRT ;  Print data for visit report
 ;
 ;  Variables
 ;    NUM, LL1   -  Local counters
 ;    SBTT       -  Track subtotals for each category
 ;    LL         -  Temporary holder for encounter status values
 ;
 N LL,SBTT,LL1,NUM,SCETOT
 ;
 D HDR1
 ;
 W !,?5,"VETERAN ELIGIBILITY",!
 K SBTT,LL
 S NUM=0
 F  S NUM=$O(^TMP("SCDXPOV",$J,DVN,"VELIG",NUM)) Q:'NUM  D  I $Y>(IOSL-8) D NEWPAGE G:SCXABRT XMTQ
 . S LL=^TMP("SCDXPOV",$J,DVN,"VELIG",NUM)
 . W !?8,$P(^DIC(8,NUM,0),U),?40,$J(+$P(LL,U,1),6),?51,$J(+$P(LL,U,2),6),?65,$J(+$P(LL,U,3),6)
 . F LL1=1:1:3 S SBTT(LL1)=+$G(SBTT(LL1))+$P(LL,U,LL1)
 ;
 W !?38,SDASH,!,?5,"Veteran Sub-Total",?40,$J(SBTT(1),6),?51,$J(SBTT(2),6),?65,$J(SBTT(3),6)
 F LL1=1:1:3 S SCETOT(LL1)=+$G(SCETOT(LL1))+$G(SBTT(LL1))
 I $Y>(IOSL-8) D NEWPAGE G:SCXABRT XMTQ
 ;
 W !!,?5,"NON-VETERAN ELIGIBILITY",!
 K SBTT,LL
 S NUM=0
 F  S NUM=$O(^TMP("SCDXPOV",$J,DVN,"NVELIG",NUM)) Q:'NUM  D  I $Y>(IOSL-8) D NEWPAGE G:SCXABRT XMTQ
 . S LL=^TMP("SCDXPOV",$J,DVN,"NVELIG",NUM)
 . W !?8,$P(^DIC(8,NUM,0),U),?40,$J(+$P(LL,U,1),6),?51,$J(+$P(LL,U,2),6),?65,$J(+$P(LL,U,3),6)
 . F LL1=1:1:3 S SBTT(LL1)=+$G(SBTT(LL1))+$P(LL,U,LL1)
 ;
 W !?38,SDASH,!,?5,"Non-Veteran Sub-Total",?40,$J(SBTT(1),6),?51,$J(SBTT(2),6),?65,$J(SBTT(3),6)
 F LL1=1:1:3 S SCETOT(LL1)=+$G(SCETOT(LL1))+$G(SBTT(LL1))
 I $Y>(IOSL-8) D NEWPAGE G:SCXABRT XMTQ
 ;
 W !!,?5,"CATEGORY OF VISIT",!
 K SBTT,LL
 S NUM=0
 F  S NUM=$O(^TMP("SCDXPOV",$J,DVN,"COV",NUM)) Q:'NUM  D  I $Y>(IOSL-8) D NEWPAGE G:SCXABRT XMTQ
 . S LL=^TMP("SCDXPOV",$J,DVN,"COV",NUM)
 . W !?8,$P($T(VISIT+NUM),";",3),?40,$J($P(LL,U,1),6),?51,$J($P(LL,U,2),6),?65,$J($P(LL,U,3),6)
 . F LL1=1:1:3 S SBTT(LL1)=+$G(SBTT(LL1))+$P(LL,U,LL1)
 ;
 W !?38,SDASH,!,?5,"Category Sub-Total",?40,$J(SBTT(1),6),?51,$J(SBTT(2),6),?65,$J(SBTT(3),6)
 I $Y>(IOSL-8) D NEWPAGE G:SCXABRT XMTQ
 ;
 W !!?2,SDBDASH,!?5,$S(DNAME["FACILITY":"Facility Total",1:"Total for "_$E(DNAME,1,25))_":",?40,$J(SCETOT(1),6),?51,$J(SCETOT(2),6),?65,$J(SCETOT(3),6)
 W !?16,"Total: ",SCETOT(1)+SCETOT(2)+SCETOT(3)
 I $Y>(IOSL-8) D NEWPAGE G:SCXABRT XMTQ
 ;
 W !!,?8,"Compensation and Pension appointments are included in the above",!?8,"categories and totals and are shown here for information only"
 K LL S LL=^TMP("SCDXPOV",$J,DVN,"CP")
 W !!?8,"COMPENSATION AND PENSION",?40,$J($P(LL,U,1),6),?51,$J($P(LL,U,2),6),?65,$J($P(LL,U,3),6)
 ;
 I SCXOPT>1&(IOST?1"C-".E) K LL W !," Press RETURN to continue or '^' to exit: " R LL:DTIME S SCXABRT='$T!(LL="^")
 ;
XMTQ Q
 ;
HDR1 ;   Print report header and column headers
 N HD2,HD1
 W @IOF
 S HD1="ENCOUNTER REPORT BY TRANSMISSION STATUS TO NPCDB"
 W !?(IOM-$L(HD1))/2,"ENCOUNTER REPORT BY TRANSMISSION STATUS TO NPCDB"
 S HD2="FOR PERIOD "
 S Y=SCXBEG D DTS^SDUTL
 S HD2=HD2_Y_" THRU "
 S Y=SCXEND D DTS^SDUTL
 S HD2=HD2_Y
 W !?2,DNAME,$S(DVN'["TOT"&SCXMD:" DIVISION",1:""),?(IOM-$L(HD2))-5,HD2
 W !!,?54,"ENCOUNTERS",!?38,SDASH
 W !?40,"WAITING",?51,"TRANSMITTED",?65,"ACKNOWLEDGED"
 W !?2,SDBDASH
 Q
 ;
NEWPAGE ;
 I IOST?1"C-".E S DIR(0)="E" D ^DIR S SCXABRT='+$G(Y) D CLEAR^SCDXPOV2
 I 'SCXABRT D HDR1
 Q
 ;
VISIT ;  Category of visits  Displayed value/Stored value
 ;;SCHEDULED VISIT;APPOINTMENT
 ;;UNSCHEDULED VISIT;STOP CODE ADDITION
 ;;10 - 10;DISPOSITION
