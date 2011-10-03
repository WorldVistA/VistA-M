FBNHPAMS ;AISC/GRR-PRINT AMIS ; 21JUN90
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S FBUL="",$P(FBUL,"-",40)="-",(FBDV,FBPG)=0
 W:$E(IOST,1,2)["C-" @IOF D HDR I $D(FBER) W ?30,">>>NOTICE<<<",!?5,">>>Incomplete patient movements affect the AMIS totals below<<<",!,?24,">>>Refer to last page for details<<<",!
 W "G A I N S",!,$E(FBUL,1,9)
 W !,?4,"ADMISSIONS"
 W !!,?10,"01  AFTER REHOSP > 15 DAYS",?40,$J(FBG(1),5) D DV Q:$G(FBOUT)  W !,?10,"02  ALL OTHER",?40,$J(FBG(2),5) D DV Q:$G(FBOUT)
 W !!,?4,"TRANSFERS IN"
 W !!,?10,"03  FROM OTHER CNH",?40,$J(FBG(3),5) D DV Q:$G(FBOUT)  W !,?10,"04  FROM ASIH",?40,$J(FBG(4),5) D DV Q:$G(FBOUT)
 D PGCK(9) Q:$G(FBOUT)  W !!,"L O S S E S",!,$E(FBUL,1,11)
 D PGCK(6) Q:$G(FBOUT)  W !?4,"DISCHARGES & DEATHS",!!,?10,"05  DISCHARGES",?40,$J(FBL(1),5) D DV Q:$G(FBOUT)  W !,?10,"06  DEATHS",?40,$J(FBL(2),5) D DV Q:$G(FBOUT)
 D PGCK(7) Q:$G(FBOUT)  W !!?4,"TRANSFERS OUT",!!,?10,"07  TO OTHER CNH",?40,$J(FBL(3),5) D DV Q:$G(FBOUT)  W !,?10,"08  TO ASIH",?40,$J(FBL(4),5) D DV Q:$G(FBOUT)
 D PGCK(8) Q:$G(FBOUT)  W !!,"R E M A I N I N G",!,$E(FBUL,1,17),!
 F I=1:1:3 W !,?10,$P($T(PR+I),";;",2),?40,$J(FBR(I),5) D DV Q:$G(FBOUT)
 Q:$G(FBOUT)
 W !,?10,"12  FEMALE BED OCCUPANTS",?40,$J(FBFEM,5) D DV Q:$G(FBOUT)
 D PGCK(8) Q:$G(FBOUT)  W !!,"L O S S E S    F R O M    A S I H",!,$E(FBUL,1,33)
 W !!,?10,"13  DISCHARGES",?40,$J(FBASDIS,5) D DV Q:$G(FBOUT)  W !,?10,"14  DEATHS",?40,$J(FBASDEAD,5) D DV Q:$G(FBOUT)
 D PGCK(8) Q:$G(FBOUT)  W !!,"M I S C    T O T A L S",!,$E(FBUL,1,22),!!,?10,"15  PATIENT DAYS OF CARE",?40,$J(TOTDAYS,5) D DV Q:$G(FBOUT)  W !,?10,"16  SC PLACEMENTS",?40,$J(FBSC,5) D DV Q:$G(FBOUT)
 D PGCK(12) Q:$G(FBOUT)  W !!,"AMIS BALANCING SEGMENT",!,$E(FBUL,1,22),!!?5,"PRIOR MONTH FIELDS 09 AND 10",?60,$J(FBPRIOR,6),!?5,"+ CURRENT MONTH FIELDS 01, 02, 03 AND 04",?60,$J("+"_(FBG(1)+FBG(2)+FBG(3)+FBG(4)),6)
 W !?5,"- CURRENT MONTH FIELDS 05, 06, 07 AND 08",?60,$J("-"_(FBL(1)+FBL(2)+FBL(3)+FBL(4)),6),!?60,"------"
 W !?5,"= CURRENT MONTH FIELDS 09 AND 10",?45,$J((FBR(1)+FBR(2)),5),"  <======>" S FBCHK=FBPRIOR+FBG(1)+FBG(2)+FBG(3)+FBG(4)-FBL(1)-FBL(2)-FBL(3)-FBL(4) W ?60,$J(FBCHK,6)
 W !,"**",$S(FBCHK=(FBR(1)+FBR(2)):"BALANCING SEGMENT OK",1:"PROBLEM FOUND IN BALANCING (see last page for details)")
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR Q:'Y
 D:$D(FBER) DISCR^FBNHAMIS
BAL I FBCHK'=(FBR(1)+FBR(2)),('$G(FBMOV)) D
 .I '$D(FBER) W @IOF D HDR^FBNHPAMS
 .W ! F I=1:1:22 D PGCK(3) Q:$G(FBOUT)  W !,$P($T(TEXT+I),";;",2)
 Q
HDR S FBPG=FBPG+1 I FBPG>1 W "Page ",FBPG
 D PRPRDT^FBAAUTL2 W !,?15,"COMMUNITY NURSING HOME CARE ACTIVITY - AMIS 349",!,?21,$$DATX^FBAAUTL(+FBMONTH),"  THRU  ",$$DATX^FBAAUTL($P(FBMONTH,"^",2)),!!
 Q
DV ;
 I $G(FBVAL) D
 .S FBIFN=0,FBDV=FBDV+1
 .F  S FBIFN=$O(^TMP($J,"FBAMIS",FBDV,FBIFN)) Q:'FBIFN  D  Q:$G(FBOUT)
 ..D PGCK(3) Q:$G(FBOUT)
 ..I (FBDV>8&(FBDV<13))!(FBDV=15) W !,?17,$$NAME^FBCHREQ2($P($G(^FB7078(FBIFN,0)),"^",3))
 ..I (FBDV<9)!(FBDV=13)!(FBDV=14)!(FBDV=16) W !,?17,$$NAME^FBCHREQ2($P($G(^FBAACNH(FBIFN,0)),"^",2)),?50,$$DATX^FBAAUTL(+$G(^FBAACNH(FBIFN,0)))
 ..I FBDV=15 W ?47,+^TMP($J,"FBAMIS",FBDV,FBIFN)
 Q:$G(FBOUT)
 D PGCK(3)
 Q
PGCK(X) ;
 I '$G(X) S X=1
 I ($Y+X)>IOSL D
 .I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S FBOUT=1 Q
 .W @IOF D HDR
 Q
PR ;;
 ;;09  BED OCCUPANTS
 ;;10  ABSENT BED OCCUPANTS
 ;;11  ABSENT SICK IN HOSP.
 Q
TEXT ;;
 ;;          Fixing AMIS BALANCING SEGMENT problems:
 ;;
 ;; 1)  Obtain a listing of all patients in a CNH during the month.
 ;;     Use either the Estimate Funds for Obligation option for the
 ;;     month or the CNH Census Report for each day of the month.
 ;; 2)  Verify all movements agree with those that preceed them
 ;;     by running the Display Episode of Care option for each patient.
 ;;      ***Transfers TO ASIH must be followed by one of the movement
 ;;         types listed below.  Any other movement types followed
 ;;         by the types listed below will result in Segment Balancing
 ;;         problems.
 ;;              a) a transfer type of From ASIH < 15 days
 ;;              b) a discharge type of ASIH
 ;;              c) a discharge type of Death while ASIH
 ;;
 ;; 3)  Use the Movement menu to edit the movement types for those found
 ;;     to be inappropriate.
 ;; 4)  Re-run the AMIS 349 once the movements have been updated.
