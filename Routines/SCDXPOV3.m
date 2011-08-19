SCDXPOV3 ; ALB/SCK - VISIT REPORT BY NPCDB TRANSMISSION STATUS ; 05 Oct 98  8:38 PM
 ;;5.3;Scheduling;**73,159,173**;AUG 13, 1993
 Q
VISIT(SCXDT,SCXP,SCXE,SCXET,SCXV,SCXC) ; Update visit count for this encounter
 ;   Input:
 ;      SCXDT - Visit date
 ;      SCXP  - Patients DFN
 ;      SCXE  - Vet Eligibility status of encounter
 ;      SCXET - Vet. or Non-Vet status
 ;      SCXV  - Category of visit
 ;      SCXC  - C&P status of encounter
 ;
 ;   Variables:
 ;      SCHL  - Current Hierarchy level
 ;      L1    - Local variable
 ;
 N L1,SCHL
 ;
 I $D(^TMP("SCDXV",$J,"ELG",SCXDT,SCXP)) D
 . S SCHL=$P(^TMP("SCDXV",$J,"ELG",SCXDT,SCXP),U,3)
 . S L1=$$ELGPRI^SCDXPOV2(SCXE,SCHL)
 . S:$P(L1,U,2) ^TMP("SCDXV",$J,"ELG",SCXDT,SCXP)=SCXE_U_SCXET_U_$P(L1,U)
 E  S ^TMP("SCDXV",$J,"ELG",SCXDT,SCXP)=SCXE_U_SCXET_U_$P($$ELGPRI^SCDXPOV2(SCXE,0),U)
 ;
 I $D(^TMP("SCDXV",$J,"COV",SCXDT,SCXP)) D
 . S SCHL=$P(^TMP("SCDXV",$J,"COV",SCXDT,SCXP),U,2)
 . S L1=$$COVPRI^SCDXPOV2(SCXV,SCHL)
 . S:$P(L1,U,2) ^TMP("SCDXV",$J,"COV",SCXDT,SCXP)=SCXV_U_$P(L1,U)
 E  S ^TMP("SCDXV",$J,"COV",SCXDT,SCXP)=SCXV_U_$P($$COVPRI^SCDXPOV2(SCXV,0),U)
 ;
 I SCXC,'$D(^TMP("SCDXV",$J,"CP",SCXDT,SCXP)) D
 . S ^TMP("SCDXV",$J,"CP",SCXDT,SCXP)=1
 Q
 ;
WRT ;  Call procedures to initialize report data global, build the report global, and then print the report.
 ;
 ;   Variables
 ;        DVN   -  Facility number from VASITE
 ;        DNAME -  Facility name from VASITE
 ;
 N SDBDASH,SDASH,DNAME,DVN
 S $P(SDBDASH,"=",75)="",$P(SDASH,"-",15)=""
 U IO
 ;
 S DVN=$P($$SITE^VASITE(SCXBEG),U,3),DNAME=$P($$SITE^VASITE(SCXBEG),U,2)
 D INIT^SCDXPOV("VISITS"),BLDRPT,VISRPT
 Q
 ;
BLDRPT ;  Build data global for report.  Order through date/patient TMP global, and count the number of unique
 ;  visits.  Increment the appropriate report data global.
 ;
 ;    Variables
 ;        SCXDT -  Date the Visit occurred (Encounter date)
 ;        SCXP  -  DFN of patient for this encounter 
 ;        SCX   -  Node of TMP global visits are being counted from
 ;        LV1   -  Local variable for incremneting report data global
 ;
 N SCXDT,SCXP,SCX,LV1
 S SCXDT=""
 ;     Count visits for Vet./Non-Vet. eligibility 
 F  S SCXDT=$O(^TMP("SCDXV",$J,"ELG",SCXDT)) Q:SCXDT'>0  D
 . S SCXP="" F  S SCXP=$O(^TMP("SCDXV",$J,"ELG",SCXDT,SCXP)) Q:'SCXP  D
 .. S SCX=^TMP("SCDXV",$J,"ELG",SCXDT,SCXP)
 .. S LV1=$P($G(^TMP("SCDXPOV",$J,"VISITS",$S($P(SCX,U,2)="Y":"VELIG",1:"NVELIG"),$P(SCX,U))),U)
 .. S $P(^TMP("SCDXPOV",$J,"VISITS",$S($P(SCX,U,2)="Y":"VELIG",1:"NVELIG"),$P(SCX,U)),U)=LV1+1
 ;
 ;    Count visits for Category of Visit.
 F  S SCXDT=$O(^TMP("SCDXV",$J,"COV",SCXDT)) Q:SCXDT'>0  D
 . S SCXP="" F  S SCXP=$O(^TMP("SCDXV",$J,"COV",SCXDT,SCXP)) Q:'SCXP  D
 .. S LV1=$P(^TMP("SCDXPOV",$J,"VISITS","COV",$P(^TMP("SCDXV",$J,"COV",SCXDT,SCXP),U)),U)
 .. S $P(^TMP("SCDXPOV",$J,"VISITS","COV",$P(^TMP("SCDXV",$J,"COV",SCXDT,SCXP),U)),U)=LV1+1
 ;
 ;    Count visits with a type of appt. of C&P
 F  S SCXDT=$O(^TMP("SCDXV",$J,"CP",SCXDT)) Q:SCXDT'>0  D
 . S SCXP="" F  S SCXP=$O(^TMP("SCDXV",$J,"CP",SCXDT,SCXP)) Q:'SCXP  D
 .. S $P(^TMP("SCDXPOV",$J,"VISITS","CP"),U)=$P(^TMP("SCDXPOV",$J,"VISITS","CP"),U)+1
 Q
 ;
VISRPT ;  Print body of the Visit report consolidated by number of visits.
 ;
 ;     Variables
 ;        SBTT     - Subtotal of categories
 ;        NUM      - local counting variable
 ;        SCDXABRT - Abort Printing (Screen only)
 ;
 N NUM,SBTT,L1
 ;
 D HDR
 I $Y>(IOSL-8) D NEWPAGE G:SCXABRT VISQ
 W !,?5,"VETERAN ELIGIBILITY",!
 S (NUM,SBTT)=0
 F  S NUM=$O(^TMP("SCDXPOV",$J,"VISITS","VELIG",NUM)) Q:'NUM  D  I $Y>(IOSL-8) D NEWPAGE G:SCXABRT VISQ
 . W !?8,$P(^DIC(8,NUM,0),U),?45,$J($P(^TMP("SCDXPOV",$J,"VISITS","VELIG",NUM),U),6)
 . S SBTT=+$G(SBTT)+$P(^TMP("SCDXPOV",$J,"VISITS","VELIG",NUM),U)
 ;
 W !?42,SDASH,!,?5,"Veteran Sub-Total",?45,$J(SBTT,6)
 I $Y>(IOSL-8) D NEWPAGE G:SCXABRT VISQ
 ;
 W !!,?5,"NON-VETERAN ELIGIBILITY",!
 S (NUM,SBTT)=0
 F  S NUM=$O(^TMP("SCDXPOV",$J,"VISITS","NVELIG",NUM)) Q:'NUM  D  I $Y>(IOSL-8) D NEWPAGE G:SCXABRT VISQ
 . W !?8,$P(^DIC(8,NUM,0),U),?45,$J($P(^TMP("SCDXPOV",$J,"VISITS","NVELIG",NUM),U),6)
 . S SBTT=+$G(SBTT)+$P(^TMP("SCDXPOV",$J,"VISITS","NVELIG",NUM),U)
 ;
 W !?42,SDASH,!,?5,"Non-Veteran Sub-Total",?45,$J(SBTT,6)
 I $Y>(IOSL-8) D NEWPAGE G:SCXABRT VISQ
 ;
 W !!,?5,"CATEGORY OF VISIT",!
 S (NUM,SBTT)=0
 F  S NUM=$O(^TMP("SCDXPOV",$J,"VISITS","COV",NUM)) Q:'NUM  D  I $Y>(IOSL-8) D NEWPAGE G:SCXABRT VISQ
 . W !?8,$P($T(VISIT+NUM^SCDXPOV1),";",3),?45,$J($P(^TMP("SCDXPOV",$J,"VISITS","COV",NUM),U),6)
 . S SBTT=+$G(SBTT)+$P(^TMP("SCDXPOV",$J,"VISITS","COV",NUM),U)
 ;
 W !?42,SDASH,!,?5,"Category Sub-Total",?45,$J(SBTT,6)
 I $Y>(IOSL-8) D NEWPAGE G:SCXABRT VISQ
 ;
 W !!,?8,"Compensation and Penison appointments are included in the above",!?8,"categories and totals and are shown here for information only"
 W !!?8,"COMPENSATION AND PENSION",?45,$J($P(^TMP("SCDXPOV",$J,"VISITS","CP"),U),6)
 ;
VISQ Q
 ;
HDR ;  Print the report header
 ;  Variables
 ;     LINEOUT - Message line for header
 ;     END     - Timeout or Uparrow flag for read
 ;
 N END,LINEOUT,LL,HD1,HD2
 ;
 W @IOF
 S HD2="VISIT REPORT FOR ACTIVITY TRANSMITTED TO NPCDB"
 W !?(IOM-$L(HD2))/2,HD2
 S HD1="FOR PERIOD "
 S Y=SCXBEG D DTS^SDUTL
 S HD1=HD1_Y_" THRU "
 S Y=SCXEND D DTS^SDUTL
 S HD1=HD1_Y
 W !?2,"Facility: "_DNAME,?(IOM-$L(HD1))-5,HD1
 W !!
 F LL=0:1 S LINEOUT=$P($T(MSG+(LL+1)),";;",2) Q:LINEOUT["$$END"  W !?8,LINEOUT
 W !!?48,"VISITS"
 W !,SDBDASH
 Q
 ;
NEWPAGE ;
 N LL
 I IOST?1"C-".E S DIR(0)="E" D ^DIR S SCXABRT='+$G(Y) D CLEAR^SCDXPOV2
 ;W !," Press RETURN to continue or '^' to exit: " R LL:DTIME S SCXABRT='$T!(LL="^")
 I 'SCXABRT D HDR
 Q
 ;
MSG ;
 ;;*NOTE*  This section consolidates all encounters into visits, where
 ;;one visit is all encounters for a patient on a single day.  For
 ;;example, three encounters for a patient on one day, is one visit.  
 ;;$$END
