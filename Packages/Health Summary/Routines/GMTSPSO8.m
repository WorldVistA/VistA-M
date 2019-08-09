GMTSPSO8 ; RS/DLC - OP Rx Summary Component by VA Drug Class ;Apr 23, 2019@21:29:01
 ;;2.7;Health Summary;**125**;Oct 20, 1995;Build 15
 ;
 ; This is a copy of GMTSPSO7 with modifications to enable selections by class
 ; External References
 ;   DBIA    330  ^PSOHCSUM, ACS^PSOHCSUM
 ;   DBIA    522  ^PS(55,
 ;   DBIA  10035  ^DPT(  file #2
 ;   DBIA   3136  ^PS(59.7,
 ;   DBIA  10011  ^DIWP
 ;   DBIA   4820  ^PSO52API
 ;   DBIA   4828  ^PSS59P7
 ;
MAIN ; OP Rx HS Component
 N DC,ECD,GMR,IX,PSOBEGIN,PSOACT,GMX,GMTOP,GMTSI
 ; Added DC as drug class variable and GMTSI for sel item -dlc 12/28/11
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
 ;---filter first before directing to print/wrt
 F  S IX=$O(^TMP("PSOO",$J,IX)) Q:IX'>0  S GMR=$G(^(IX,0)) D
 .S DC=$$GET1^DIQ(50,+$P(GMR,U,3),25,"I")
 .S GMTSI=0
 .F  S GMTSI=$O(GMTSEG(GMTSEGN,50.605,GMTSI)) Q:GMTSI'>0  D
 ..I DC=GMTSEG(GMTSEGN,50.605,GMTSI) D WRT
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
 N A,GMNAME,GMI,GMY
 S GMTOP=1
 K ^TMP($J,"GMTSPSSYS") D PSS^PSS59P7(1,,"GMTSPSSYS")
 I GMX'>0,$D(^DPT(DFN,.1)),^(.1)]"",+$G(^TMP($J,"GMTSPSSYS",1,40.1)) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Outpatient prescriptions are cancelled 72 hours after admission",!
 ;I GMX'>0,$D(^DPT(DFN,.1)),^(.1)]"",+($P($G(^PS(59.7,1,40.1)),"^")) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Outpatient prescriptions are cancelled 72 hours after admission",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
  W "VA drug class(es) selected: "
 S (GMI,GMY)=0
 F  S GMI=$O(GMTSEG(1,50.605,GMI)) Q:'GMI  D
 . S GMY=GMY+1
 . W:GMY>1 "; "
 . S A=GMTSEG(1,50.605,GMI) D IEN^PSN50P65(A,,"GMTS2") S GMNAME=$G(^TMP($J,"GMTS2",A,.01))
 . W:(75)'>($X+$L(GMNAME)) !?5
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W GMNAME
 W !
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !?65,"Last",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?18,"Rx #",?31,"Stat",?45,"Qty",?54,"Issued",?65,"Filled",?76,"Rem"
 W:$Y'>(IOSL-GMTSLO)!(+($G(GUI))>0) !
 Q
