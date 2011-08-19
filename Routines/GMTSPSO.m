GMTSPSO ; SLC/JER,KER/NDBI - OP Rx Summary Component (V6) ; 08/27/2002
 ;;2.7;Health Summary;**15,28,37,56,78,80**;Oct 20, 1995;Build 9
 ;
 ; External References
 ;   DBIA  10141  $$VERSION^XPDUTL
 ;   DBIA   2931  HS^A7RPSOHS
 ;   DBIA   2931  HS^A7RPSOHS
 ;   DBIA    330  ^PSOHCSUM, ACS^PSOHCSUM
 ;   DBIA    522  ^PS(55,
 ;   DBIA  10035  ^DPT(  file #2
 ;   DBIA   3136  ^PS(59.7,
 ;                    
MAIN ; OP Rx HS Comp
 ;   Check for version 7 (or greater)   MAIN^GMTSPSO7
 I $$VERSION^XPDUTL("PSO")'<7 G MAIN^GMTSPSO7
 ;   If not version 7                   MAIN^GMTSPSO
 N ECD,GMR,IX,PSOBEGIN,PSOACT,GMX,GMTOP
 S PSOBEGIN=$S(GMTS2'=9999999:(9999999-GMTS2),1:"")
 I PSOBEGIN="" S PSOACT=1 K PSOBEGIN
 K ^TMP("PSOO",$J),^TMP($J,"GMTSPS")
 D PROF^PSO52API(DFN,"GMTSPS",1,9999999)
 D:$$ROK^GMTSU("A7RPSOHS")&($$NDBI^GMTSU) HS^A7RPSOHS(DFN)
 I +$G(^TMP($J,"GMTSPS",DFN,0))<1,'$D(^TMP($J,"GMTSPS",DFN,"ARC")) Q
 I '$G(^TMP($J,"GMTSPS",DFN,0)),$D(^TMP($J,"GMTSPS",DFN,"ARC")) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Patient Has Archived OP Prescriptions",!
 ;I '$D(^PS(55,DFN,"P")),'$D(^("ARC")),'$D(^TMP("PSOO",$J)) Q
 ;I '$O(^PS(55,DFN,"P",0)),$D(^PS(55,DFN,"ARC")) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Patient Has Archived OP Prescriptions",!
 I $L($T(ACS^PSOHCSUM))>0 D ACS^PSOHCSUM D:$$ROK^GMTSU("A7RPSOHS")&($$NDBI^GMTSU) HS^A7RPSOHS(DFN) I '$D(^TMP("PSOO",$J)) Q
 I $L($T(ACS^PSOHCSUM))'>0 D ^PSOHCSUM D:$$ROK^GMTSU("A7RPSOHS")&($$NDBI^GMTSU) HS^A7RPSOHS(DFN) I '$D(^TMP("PSOO",$J)) Q
 S GMTSLO=GMTSLO+3
 S (GMX,GMTOP,IX)=0
 F  S IX=$O(^TMP("PSOO",$J,IX)) Q:IX'>0  S GMR=$G(^(IX,0)) D WRT
 S GMTSLO=GMTSLO-3
 K ^TMP("PSOO",$J)
 Q
WRT ; Writes OP Pharmacy Segment Record
 N ID,LFD,X,MI,NL,CF,GMD,GMV,GMI,GUI S GUI=$$HF^GMTSU
 S ID=$P(GMR,U),LFD=$P(GMR,U,2),ECD=$P(GMR,U,11),CF=$P(GMR,U,10)
 ;   Don't display when issue date is after To Date
 Q:+$G(GMRANGE)&(ID>(9999999-GMTS1))
 F GMV="ID","LFD","ECD" S X=@GMV D REGDT4^GMTSU S @GMV=X K X
 S MI=$G(^TMP("PSOO",$J,IX,1)),NL=0 I $L(MI)>73 D PARSE
 S GMD=$P($P(GMR,U,4),";",2)
 D CKP^GMTSUP Q:$D(GMTSQIT)
 D:GMTSNPG!(GMX'>0) HEAD W:'GMTOP ! S GMTOP=0 W $P($P(GMR,U,3),";",2)
 W !,?18,$P(GMR,U,6),?31,$S($P($P(GMR,U,5),";")="S":"ACTIVE/SUSP",1:$P($P(GMR,U,5),";",2)),?45,$P(GMR,U,7),?54,ID,?65,LFD,?76,"("_$P(GMR,U,8)_")",!
 S GMX=1 I 'NL D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HEAD W ?2,"SIG: ",MI,! S GMTOP=0
 F GMI=1:1:NL D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HEAD W:GMI=1 ?2,"SIG: " W ?7,MI(GMI),! S GMTOP=0
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HEAD W ?4,"Provider: ",$E(GMD,1,22) W:CF ?37,"Cost/Fill: $",$J(CF,6,2)
 I "EC"[$P($P(GMR,U,5),";"),ECD]"" W ?57,"Exp/Can Dt: "_ECD
 W ! S GMTOP=0
 Q
PARSE ; Parses Medication Instructions
 N GMI,NW,WPL
 S NL=$S(($L(MI)/73)>($L(MI)\73):($L(MI)\73)+1,1:$L(MI)\73)
 S NW=$L(MI," "),WPL=$S((NW/NL)>(NW\NL):(NW\NL)+1,1:NW\NL)
 F GMI=1:1:NL S MI(GMI)=$P(MI," ",(GMI-1)*WPL+1,GMI*WPL)
 Q
HEAD ; Prints Header
 S GMTOP=1
 K ^TMP($J,"GMTSPSSYS") D PSS^PSS59P7(1,,"GMTSPSSYS")
 I GMX'>0,$D(^DPT(DFN,.1)),^(.1)]"",+$G(^TMP($J,"GMTSPSSYS",1,40.1)) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Outpatient prescriptions are cancelled 72 hours after admission",!
 ;I GMX'>0,$D(^DPT(DFN,.1)),^(.1)]"",+($P($G(^PS(59.7,1,40.1)),"^")) D CKP^GMTSUP Q:$D(GMTSQIT)  W "Outpatient prescriptions are cancelled 72 hours after admission",!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,"Drug....................................",?65,"Last",!
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W ?18,"Rx #",?31,"Stat",?45,"Qty",?54,"Issued",?65,"Filled",?76,"Rem"
 W:$Y'>(IOSL-GMTSLO)!(+($G(GUI))>0) !
 Q
