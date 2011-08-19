SPNMISS2 ;WDE/SAN-DIEGO;PRINT REPORT ON MISSING DATA ELEMENTS; 1-18-2005
 ;;2.0;Spinal Cord Dysfunction;**24**;01/02/97
 ;
 ;
EN ;
 W @IOF
 S PAGE=0,SPNCON=""
 D HDR
 S EQ="",$P(EQ,"-",80)="-"
 I $D(^TMP($J))=0 W !,"     No Missing Data to Report." D KILL^SPNMISS Q
 S PTNAM="" F  S PTNAM=$O(^TMP($J,PTNAM)) Q:PTNAM=""   S DFN=0 F  S DFN=$O(^TMP($J,PTNAM,DFN)) Q:(DFN=0)!('+DFN)  D  Q:SPNCON="^"
 .S X=$$GET1^DIQ(2,DFN_",",.09) S SPNSSN=$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,9)
 .W !,$$GET1^DIQ(2,DFN_",",.01),?30,SPNSSN D  D SSN
 ..S FIELD=0 F  S FIELD=$O(^TMP($J,PTNAM,DFN,FIELD)) Q:(FIELD="")!('+FIELD)  W !?20,$G(^TMP($J,PTNAM,DFN,FIELD))
 .W !,EQ
 .I $E(IOST,1)="P" I $Y>(IOSL-9) D HDR
 .I $E(IOST,1)="C" I $Y>(IOSL-7) D CONT Q:SPNCON="^"  D HDR
 I SPNCON'["^" I $E(IOST,1)="C" D CONT
 D STATS
 K STATS K ^TMP($J),DUPDFN,X,Y,SS,DFN,PTNAM,SPNCON,EQ,PTCNT,FIELD,SPNSSN
 K SPNEXIT,SUBCNT,SSN,SPNLEXIT,SPNIO,SPNDD,SPNCNT
 Q
SSN ;
 S X=0 F  S X=$O(^TMP($J,PTNAM,DFN,"SSN",X)) Q:X=""  D
 .S DUPDFN=$P(^TMP($J,PTNAM,DFN,"SSN",X),U,1)
 .W !?20,"Possible Duplicate SSN Assigned to ",$P($G(^DPT(DUPDFN,0)),U,1)
 .Q
 Q
HDR ;
 W @IOF
 S PAGE=PAGE+1
 W !,"        SCD Registry Missing Data Report   ","Run Date: ",$$FMTE^XLFDT($$NOW^XLFDT,"5DZP"),"   Page ",PAGE
 W !,"Patient Name",?30,"SSN"
 W !,"=============================================================================="
 Q
CONT ;
 I $E(IOST,1)="C" R !?20,"Press Return To Continue Or ^ to Exit ",SPNCON:DTIME
 I SPNCON="^" S PTNAM="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"  Q
 Q
STATS ;
 S PTCNT=0
 S X="" F  S X=$O(^TMP($J,X)) Q:X=""  S Y=0 F  S Y=$O(^TMP($J,X,Y)) Q:Y=""  S PTCNT=PTCNT+1 S FIELD="" F  S FIELD=$O(^TMP($J,X,Y,FIELD)) Q:FIELD=""  D
 .I $D(STATS(FIELD))=0 S STATS(FIELD)=0
 .S STATS(FIELD)=STATS(FIELD)+1
 .S SS="" S SS=$O(^TMP($J,X,Y,"SSN",SS))
 D HDR
 W !?20,"Total # of Patients with Missing Data: ",$J(STATS(0),3,0)
 I $G(STATS(991.01)) W !?20,"# Missing ICN: ",$J(STATS(991.01),3,0)
 I $G(STATS(.02)) W !?20,"# Missing Registration Date: ",$J(STATS(.02),3,0)
 I $G(STATS(.05)) W !?20,"# Missing Date of Last Review: ",$J(STATS(.05),3,0)
 I $G(STATS(1.1)) W !?20,"# Missing SCI Network: ",$J(STATS(1.1),3,0)
 I $G(STATS(.03)) W !?20,"# Missing Registration Status: ",$J(STATS(.03),3,0)
 I $G(STATS("SSN")) W !?20,"# of Possible Duplicate SSNs: ",$J(STATS("SSN"),3,0)
