GMTSPSO7 ; SLC/JER/KER - OP Rx Summary Component (V7) ; 08/27/2002
 ;;2.7;Health Summary;**15,28,37,56,78,80**;Oct 20, 1995;Build 9
 ;
 ; External References
 ;   DBIA    330  ^PSOHCSUM, ACS^PSOHCSUM
 ;   DBIA    522  ^PS(55,
 ;   DBIA  10035  ^DPT(  file #2
 ;   DBIA   3136  ^PS(59.7,
 ;   DBIA  10011  ^DIWP
 ;                      
MAIN ; OP Rx HS Component
 N ECD,GMR,IX,PSOBEGIN,PSOACT,GMX,GMTOP
 S PSOBEGIN=$S(GMTS2'=9999999:(9999999-GMTS2),1:"")
 I PSOBEGIN="" S PSOACT=1 K PSOBEGIN
 K ^TMP("PSOO",$J),^TMP($J,"GMTSPS")
 D PROF^PSO52API(DFN,"GMTSPS",1,9999999)
 I +$G(^TMP($J,"GMTSPS",DFN,0))<1,'$D(^TMP($J,"GMTSPS",DFN,"ARC")) Q
 I '$G(^TMP($J,"GMTSPS",DFN,0)),$D(^TMP($J,"GMTSPS",DFN,"ARC")) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Patient Has Archived OP Prescriptions",!
 ;I '$D(^PS(55,DFN,"P")),'$D(^("ARC")) Q
 ;I '$O(^PS(55,DFN,"P",0)),$D(^PS(55,DFN,"ARC")) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Patient Has Archived OP Prescriptions",!
 I $L($T(ACS^PSOHCSUM))>0 D ACS^PSOHCSUM I '$D(^TMP("PSOO",$J)) Q
 I $L($T(ACS^PSOHCSUM))'>0 D ^PSOHCSUM I '$D(^TMP("PSOO",$J)) Q
 S GMTSLO=GMTSLO+3
 S (GMTOP,GMX,IX)=0
 F  S IX=$O(^TMP("PSOO",$J,IX)) Q:IX'>0  S GMR=$G(^(IX,0)) D WRT
 S GMTSLO=GMTSLO-3
 K ^TMP("PSOO",$J),^UTILITY($J,"W")
 Q
WRT ; Writes OP Pharmacy Segment Record
 N ID,LFD,X,MI,NL,CF,GMD,GMV,GMI,DIWL,DIWR,DIWF,GMSIG,GUI S GUI=$$HF^GMTSU
 S ID=$P(GMR,U),LFD=$P(GMR,U,2),ECD=$P(GMR,U,11),CF=$P(GMR,U,10)
 ;   Don't display when issue date is after To Date
 Q:+$G(GMRANGE)&(ID>(9999999-GMTS1))
 F GMV="ID","LFD","ECD" S X=@GMV D REGDT4^GMTSU S @GMV=X K X
 S NL=0,DIWL=1,DIWR=73,DIWF="" K ^UTILITY($J,"W")
 F  S NL=$O(^TMP("PSOO",$J,IX,NL)) Q:NL'>0  D
 . S X=$G(^TMP("PSOO",$J,IX,NL,0)) D ^DIWP
 S GMD=$P($P(GMR,U,4),";",2)
 D CKP^GMTSUP Q:$D(GMTSQIT)
 D:GMTSNPG!(GMX'>0) HEAD W:'GMTOP ! S GMTOP=0 W $P($P(GMR,U,3),";",2)
 W !,?18,$P(GMR,U,6),?31,$S($G(GMR)["SUSPENDED":"ACTIVE/SUSP",1:$P($P(GMR,U,5),";",2)),?45,$P(GMR,U,7),?54,ID,?65,LFD,?76,"("_$P(GMR,U,8)_")",!
 S GMX=1,GMI=0,GMSIG=1
 F  S GMI=$O(^UTILITY($J,"W",DIWL,GMI)) Q:GMI'>0!$D(GMTSQIT)  D
 . D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HEAD
 . S MI=$G(^UTILITY($J,"W",DIWL,GMI,0))
 . W:GMSIG=1 ?2,"SIG: " S:GMSIG=1 GMSIG=0 W ?7,MI,! S GMTOP=0
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HEAD W ?4,"Provider: ",$E(GMD,1,22) W:CF ?37,"Cost/Fill: $",$J(CF,6,2)
 I "EC"[$P($P(GMR,U,5),";"),ECD]"" W ?57,"Exp/Can Dt: "_ECD
 W ! S GMTOP=0
 Q
HEAD ; Prints Header
 ;   Only write the next line when there is data
 S GMTOP=1
 K ^TMP($J,"GMTSPSSYS") D PSS^PSS59P7(1,,"GMTSPSSYS")
 I GMX'>0,$D(^DPT(DFN,.1)),^(.1)]"",+$G(^TMP($J,"GMTSPSSYS",1,40.1)) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Outpatient prescriptions are cancelled 72 hours after admission",!
 ;I GMX'>0,$D(^DPT(DFN,.1)),^(.1)]"",+($P($G(^PS(59.7,1,40.1)),"^")) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Outpatient prescriptions are cancelled 72 hours after admission",!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,"Drug....................................",?65,"Last",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?18,"Rx #",?31,"Stat",?45,"Qty",?54,"Issued",?65,"Filled",?76,"Rem"
 W:$Y'>(IOSL-GMTSLO)!(+($G(GUI))>0) !
 Q
