GMTSPSO9 ;RS/DLC - OP Rx Summary Component by Select Med ;Jun 14, 2021@12:10:06
 ;;2.7;Health Summary;**125,115**;Oct 20, 1995;Build 190
 ;
 ; This is a copy of GMTSPSO7 with modifications to enable selections by class
 ; External References
 ;   DBIA    330  ^PSOHCSUM, ACS^PSOHCSUM
 ;   DBIA  10035  ^DPT(  file #2
 ;   DBIA  10011  ^DIWP
 ;   DBIA   4820  PROF^PSO52API
 ;   DBIA   2858  ^PSDRUG
 ;   DBIA   6263  ^UTILITY
 ;   DBIA   4828  PSS^PSS59P7
 ;   DBIA   4662  NAME^PSS50P7
 ;
MAIN ; OP Rx HS Component
 N SELMED,SELMEDOI,ECD,GMR,IX,PSOBEGIN,PSOACT,GMX,GMTOP,GMTSI
 ; Added SELMED as sel med variable and GMTSI for sel item -dlc 12/28/11
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
 .S SELMED=+$P(GMR,U,3),SELMEDOI=$$GET1^DIQ(50,SELMED,2.1,"I")
 .S GMTSI=0
 .F  S GMTSI=$O(GMTSEG(GMTSEGN,50.7,GMTSI)) Q:GMTSI'>0  D
 ..I SELMEDOI=GMTSEG(GMTSEGN,50.7,GMTSI) D WRT
 S GMTSLO=GMTSLO-3
 K ^TMP("PSOO",$J),^UTILITY($J,"W")
 Q
WRT ; Writes OP Pharmacy Segment Record
 N ID,LFD,X,MI,NL,CF,GMD,GMV,GMI,DIWL,DIWR,DIWF,GMSIG,GUI,IND S GUI=$$HF^GMTSU
 S ID=$P(GMR,U),LFD=$P(GMR,U,2),ECD=$P(GMR,U,11),CF=$P(GMR,U,10)
 ;   Don't display when issue date is after To Date
 Q:+$G(GMRANGE)&(ID>(9999999-GMTS1))
 F GMV="ID","LFD","ECD" S X=@GMV D REGDT4^GMTSU S @GMV=X K X
 S IND=$P($G(^TMP("PSOO",$J,IX,"IND")),U)
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
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HEAD W:IND]"" ?4,"Indication: "_IND,! W ?4,"Provider: ",$E(GMD,1,22) W:CF ?37,"Cost/Fill: $",$J(CF,6,2)
 I "EC"[$P($P(GMR,U,5),";"),ECD]"" W ?57,"Exp/Can Dt: "_ECD
 W ! S GMTOP=0
 Q
HEAD ; Prints Header
 ;   Only write the next line when there is data
 N GMI,A,GMNAME,GMY
 S GMTOP=1
 K ^TMP($J,"GMTSPSSYS") D PSS^PSS59P7(1,,"GMTSPSSYS")
 I GMX'>0,$D(^DPT(DFN,.1)),^(.1)]"",+$G(^TMP($J,"GMTSPSSYS",1,40.1)) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Outpatient prescriptions are cancelled 72 hours after admission",!
 ;I GMX'>0,$D(^DPT(DFN,.1)),^(.1)]"",+($P($G(^PS(59.7,1,40.1)),"^")) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Outpatient prescriptions are cancelled 72 hours after admission",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "Orderable item(s) selected: "
 S (GMI,GMY)=0
 F  S GMI=$O(GMTSEG(GMTSEGN,50.7,GMI)) Q:'GMI  D  ;p115 mwa replaced hard coded 1 with GMTSEGN
 . S GMY=GMY+1
 . W:GMY>1 "; "
 . S A=GMTSEG(GMTSEGN,50.7,GMI),GMNAME=$$NAME^PSS50P7(A) ;p115 mwa replaced hard coded 1 with GMTSEGN
 . W:(75)'>($X+$L(GMNAME)) !?5
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . W GMNAME
 W !
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !?65,"Last",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?18,"Rx #",?31,"Stat",?45,"Qty",?54,"Issued",?65,"Filled",?76,"Rem"
 W:$Y'>(IOSL-GMTSLO)!(+($G(GUI))>0) !
 Q
