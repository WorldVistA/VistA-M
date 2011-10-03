GMTSPSZO ;SLC/JER - OP Rx 5.6 Summary Component ;12/2/91  13:45 ;
 ;;2.7;Health Summary;**80**;Oct 20, 1995;Build 9
GMTSPSO ;SLC/JER - OP Rx Summary Component ;12/2/91  13:45 ;
 ;;2.7;Health Summary;;Oct 20, 1995
MAIN N ECD,GMR,GMW,IX,PSOBEGIN
 S PSOBEGIN=$S(GMTS2'=9999999:(9999999-GMTS2),1:"")
 I PSOBEGIN="" S PSOACT=1
 K ^UTILITY("PSOO",$J),^TMP($J,"GMTSPS")
 D PROF^PSO52API(DFN,"GMTSPS",1,9999999)
 I +$G(^TMP($J,"GMTSPS",DFN,0))<1,'$D(^TMP($J,"GMTSPS",DFN,"ARC")) Q
 I '$G(^TMP($J,"GMTSPS",DFN,0)),$D(^TMP($J,"GMTSPS",DFN,"ARC")) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Patient Has Archived OP Prescriptions",!
 ;I '$D(^PS(55,DFN,"P")),'$D(^("ARC")) Q
 ;I '$O(^PS(55,DFN,"P",0)),$D(^PS(55,DFN,"ARC")) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Patient Has Archived OP Prescriptions",!
 D ^PSOHCSUM I '$D(^UTILITY("PSOO",$J)) Q
 I $D(^DPT(DFN,.1)),^(.1)]"",$D(^DIC(59,+$O(^DIC(59,0)),1)),$P(^(1),"^",8) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Outpatient prescriptions are cancelled 72 hours after admission",!
 S GMTSLO=GMTSLO+3
 D HEAD
 S IX=0 F  S IX=$O(^UTILITY("PSOO",$J,IX)) Q:IX'>0  S GMR=$G(^(IX,0)) D WRT
 S GMTSLO=GMTSLO-3
 K ^UTILITY("PSOO",$J)
 Q
HEAD ; Prints Header
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?67,"Last",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "Drug",?27,"Rx #",?38,"St (Exp/Can)",?51,"Qty",?58,"Issued",?67,"Filled",?76,"Rem",! W:$Y'>(IOSL-GMTSLO) !
 Q
WRT ; Writes OP Pharmacy Segment Record
 N ID,LFD,X,MI,NL,CF,GMD,GMV,GMI
 S ID=$P(GMR,U),LFD=$P(GMR,U,2),ECD=$P(GMR,U,11),CF=$P(GMR,U,10)
 F GMV="ID","LFD","ECD" S X=@GMV D REGDT^GMTSU S @GMV=X K X
 S MI=$G(^UTILITY("PSOO",$J,IX,1)),NL=0 I $L(MI)>73 D PARSE
 S GMD=$P($P(GMR,U,4),";",2)
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HEAD W $E($P($P(GMR,U,3),";",2),1,25),?27,$P(GMR,U,6),?38,$P($P(GMR,U,5),";"),?40,$S("EC"[$P($P(GMR,U,5),";"):"("_ECD_")",1:""),?51,$P(GMR,U,7),?57,ID,?67,LFD,?76,"("_$P(GMR,U,8)_")",!
 I 'NL D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HEAD W ?2,MI,!
 F GMI=1:1:NL D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HEAD W ?2,MI(GMI),!
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HEAD W ?4,"Provider: ",$E(GMD,1,26) W:CF ?41,"Cost/Fill: $",$J(CF,6,2) W !
 Q
PARSE ; Parses Medication Instructions
 N GMI,NW,WPL
 S NL=$S(($L(MI)/73)>($L(MI)\73):($L(MI)\73)+1,1:$L(MI)\73)
 S NW=$L(MI," "),WPL=$S((NW/NL)>(NW\NL):(NW\NL)+1,1:NW\NL)
 F GMI=1:1:NL S MI(GMI)=$P(MI," ",(GMI-1)*WPL+1,GMI*WPL)
 Q
