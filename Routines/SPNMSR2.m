SPNMSR2 ;SAN/WDE/MS Canned report CONT print segment
 ;;2.0;Spinal Cord Dysfunction;**12**;01/02/1997
EN ;
 S SPNPAGE=1,SPNLEXIT=0
 S Y=DT X ^DD("DD") S SPNDATE=Y K Y
 D HEAD
 ;
 ;
 S SPNAME="" F  S SPNAME=$O(^UTILITY($J,SPNAME)) Q:SPNAME=""  S SPNDFN=0 F  S SPNDFN=$O(^UTILITY($J,SPNAME,SPNDFN)) Q:(SPNDFN="")!('+SPNDFN)!(SPNLEXIT=1)  D
 .S SPNDATA=$G(^UTILITY($J,SPNAME,SPNDFN))
 .W !,$P(SPNDATA,U,1),?25,$P(SPNDATA,U,2),?40,$P(SPNDATA,U,3),?66,$E($P(SPNDATA,U,4),1,14)
 .W !,"(",$P(SPNDATA,U,5),?14,$P(SPNDATA,U,6),")",?33,$P(SPNDATA,U,7),?58,"(",$P(SPNDATA,U,8),"  ",$P(SPNDATA,U,9),")"
 .W !,"--------------------------------------------------------------------------------"
 .I $Y>(IOSL-6) D HEAD
 I $E(IOST,1)="C" I SPNLEXIT=0 N DIR S DIR(0)="E" D ^DIR K Y
 D CLOSE^SPNPRTMT
 Q
 ;
 ;
HEAD ;Header
 I $E(IOST,1)="C" D  Q:SPNLEXIT
 .I SPNPAGE'=1 D  Q:SPNLEXIT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S SPNLEXIT=1
 ..I $D(DTOUT) S SPNLEXIT=1
 ..K Y
 ..Q
 .Q
 I $E(IOST,1)="C" W @IOF
 I $E(IOST,1)="P" W #
 W !,?25,"MS Patient Listing Report",?55,SPNDATE,?70,"Page: ",SPNPAGE
 W !,"Patient",?25,"SSN",?40,"MS Subtype",?66,"Provider"
 W !,"(Last / Next Eval)",?33,"Date of Onset",?58,"(EDSS Date & Score)"
 W !,"-------------------------------------------------------------------------------"
 I $D(^UTILITY($J))=0 W !?10,"No Patients to report.",!!
 S SPNPAGE=SPNPAGE+1
 Q
EXIT ;
 K Y,DIR,SPNPAGE,SPNDATE,SPNDATA,SPNLEXIT,SPNAME
 K SPNNAME,SPNDFN,SPNDATA
 Q
