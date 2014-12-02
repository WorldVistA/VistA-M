RMPFRPC0        ;DALC/PJU - Module to establish DALC elig for ROES3;06/18/2008
 ;;3.0;REMOTE ORDER ENTRY SYSTEM;**1,4**;Feb 9, 2011;Build 19
 ;;Updated for R3*4 2/1/2011
 ;;Per VHA Directive 10-92-142 this routine should not be modified
 ;;Uses supported IA's: 2343, 10003, 10015, 10061, 10103
 ;;subscriber to IA's: 174 & 767
START(AR,DFN,SHW)  ;called from RMPFRPC1 for elig variables
  ;input: array name by ref, DFN, SHW=1(opt) if prompts can be shown
  ;will return to the Delphi app as 0-7 subscripts in same order
  ;PD = AR(0)=date of death msg or ""
  ;ED = AR(1)=eligibility status date FM
  ;EL = AR(2)=calculated eligibility code
  ;ES = AR(3)=eligibility status
  ;SR = AR(4)=sensitive record
  ;ER = AR(5) is for error msg's
  ;PE = AR(6)=primary eligibility
  ;PG = AR(7)=priority group
  ;RA = AR(8)=elig^APPR(1)^PSAS user^ASPS user^req dt^sug el^act dt
  ;PS = enrollment group sub
  ;R3 = array of auto accepted R3 elig's
  ;VS = 0/1 for SC ^ %
  ;VT = y/n for veteran flag
  K AR ;in case came in with data (is called by ref)
  N ROES ;array of eligibilities to submitted to PSAS
  N A0,A1,A2,ED,EL,ES,ER,PD,PG,PS,R3,RA,RMDNM,SSN,VS,VT,IEN
  S (ED,EL,ES,ER,PD,PG,PS,R3,RA,RMDNM,SSN,VS,VT,IEN)=""
  F X=0:1:8 S AR(X)="" ;initialize array AR
  ;R3*4 removed or renamed:"WWI","AAA","EP3","HB"
  F X="SC","COM","PH","POW","PG3","PG4","NCA","0CA","OIF" S R3(X)=""
  F X="SCV","OGA","NSC","PG8","BLR","VOC","CAN","BRI" S R3(X)=""
  K VADM,VAEL,VAMB,VAPA,VASV
  D DEM^VADPT ;demographic vars
  I $G(VAERR) S ER="**ERROR retrieving Demographic values**" G END
  I $G(VADM(6)) D  ;fm^external date of death
  .S (PD,AR(0))=VADM(6)
  S RMDNM=$G(VADM(1)) ;Patient name for SHOW
  S SSN=$P($G(VADM(2)),U,1)
  I $P($G(^DGSL(38.1,DFN,0)),U,2) S AR(4)=1 ;IA 767 (DBIA268-C SEN REC)
  S VAPA("P")="" D ADD^VADPT ;permanent address
  I $G(VAERR) S ER="**ERROR** Problem retrieving Permanent Address" G END
  D ELIG^VADPT ;eligibility vars
  I $G(VAERR) D  G END
  .S ER="**ERROR** Problem in retrieving Eligibility (VADPT)."
  I $L(ER) G END
  S AR(6)=$P($G(VAEL(1)),U,2) ;external form PRIMARY ELIG
  S ES=$P($G(VAEL(8)),U,1) ;elig status
  I ES="V" D  ;verified
  .K RM S DIC=2,DA=DFN,DIQ="RM",DR=".3612" D EN^DIQ1
  .S ED=RM(2,DFN,.3612) ;elig date text
  .S %DT="X",X=ED D ^%DT S:+Y>1 ED=+Y_U_ED ;fmdate ^ text date
  .K RM,DIC,DA,DIQ,DR,%DT
  S VT=$S($G(VAEL(4)):"Y",1:"N") ;VET Y/N
  K RM S DIC=2,DA=DFN,DIQ="RM",DR="27.01",DIQ(0)="I" D EN^DIQ1
  S DA=$G(RM(2,DFN,27.01,"I")) ;CURRENT ENROLLMENT entry in ^DPT(
  I DA D
  .K RM2 S DIC=27.11,DIQ="RM2",DR=".07;.12",DIQ(0)="I" D EN^DIQ1
  .S (PG,AR(7))=$G(RM2(27.11,DA,.07,"I")) ;Priority Group
  .S PS1=$G(RM2(27.11,DA,.12,"I"))
  .S PS=$S(PS1=1:"A",PS1=2:"B",PS1=3:"C",PS1=4:"D",1:"") ;PG Subgroup
  K RM,RM2,DIC,DA,DIQ,DR,PS1
  I VT="Y" D  ;is veteran
  .D ELIGBL Q:$L(EL)  ; ck for SC for condition *** SC **
  .S VS=$G(VAEL(3)) I $P(VS,U,1) D  ;(3)=0/1 for SC ^ %
  ..I $P(VS,U,2)'<10 D
  ...I +PG>0,+PG<4 S EL="COM" ;PG 1-3 & SC >= 10% *** COM **
  G:$L(EL) END ;EL = COM or SC
  D SVC^VADPT I $G(VAERR) D  G END ;Service Info(SVC^VADPT)
  .S ER="**ERROR** Problem in retrieving Service Information."
  I ($G(VASV(4))=1)!($P(VAEL(1),U,2)="PRISONER OF WAR") D  G:$L(EL) END
  .S EL="POW" ;VASV(4)= POW status (1/0)      *** POW **
  I +$G(VASV(9)) S EL="PH" G END ;VASV(9)=1(current PH),else 0 ** PH **
  I VT="Y" D  G:$L(EL) END
  .S:PG=3 EL="PG3" ;                          *** PG3 **
  .S:PG=4 EL="PG4" ; include AAA & HB & catastrophic disabled ** PG4 **
  ;VAMB(1)=recv A&A ben's;VAMB(2)=recv HB bens both in PG4
  D ALLIED(DFN) G:$L(EL) END ;   *** CAN or BRI **
  I VT="Y" D  G:$L(EL) END
  .I PG=5 D  Q:$L(EL)  ;                      ***  NCA **
  ..I $P($G(VAEL(1)),U,2)="NSC, VA PENSION" S EL="NCA" Q
  ..S:$P($G(VAEL(6)),U,2)="NSC VETERAN" EL="NCA"
  .I $G(VAEL(3)),$P($G(VAEL(3)),U,2)=0 D  Q:$L(EL)  ; *** 0CA **
  ..I (PG=5)!(PG=7)!(PG=8) S EL="0CA" Q
  .I PG=6 D  Q:$L(EL)  ;VASV(11)= # OIF/OEF tours
  ..I +$G(VASV(11))>0 S EL="OIF" ;          *** OIF *** 
  ..E  S EL="SCV" ;Special category veterans  *** SCV **
  G:$L(EL) END
  S X=0 I ($D(VAEL(1))>9) D  G:$L(EL) END ;   *** OGA **
  .F  S X=$O(VAEL(1,X)) Q:'X  D  Q:$L(EL)
  ..I $P(VAEL(1,X),U,2)="OTHER FEDERAL AGENCY" S EL="OGA"
  I VT="Y",'$G(VAEL(3)) D  G:$L(EL) END ; *** NSC **
  .I (PG=7) S EL="NSC"
  I VT="Y",PG=8 S EL="PG8" ; *** PG8 **
END  I $L($G(ER)) S AR(5)=ER
  S:$L(ED) AR(1)=ED ; ***  ELIG DATE **
  S:$L(EL) AR(2)=EL ; *** calc elig CODE
  S:$L($G(ES)) AR(3)=ES ;ELIG STAT
  G:$L(EL) END2 ;R3*4
  ;if 'EL ck for PRIOR elig in ELIGIBILITY CONFIRMATION file
  S IEN="" I $D(^RMPF(791814,"B",DFN)) D
  .S IEN=$O(^RMPF(791814,"B",DFN," "),-1)
  G:'IEN END2
  S A0=$G(^RMPF(791814,IEN,0)),A1=$G(^(1)),A2=$G(^(2))
  S RA=$P(A2,U,2) ;0 or 1 or 2 (REJ, APPR, WAIT)
  I +RA<1 S RA=1,EL="NSC",$P(A2,U,1)=EL ;DEFAULT DISAPPROVED CHG'D TO NSC APPROVED
  I (RA>1) S RA=1 D  ; others auto approve
  .I $P(A2,U,1)'="" S EL=$P(A2,U,1) ;PSAS ELIG
  .I EL="" S EL="NSC",$P(A1,U,1)=EL ;DEFAULT 
  .S AR(2)=EL ;calculated elig
  .S X=$P(A2,U,3) S:(+X<1) X=DUZ ;psas or user DUZ
  .S Y=$$NAME^XUSER(X) S:Y="" Y="Unknown"
  .S $P(RA,U,2)=Y ;name
  .S X=$P(A0,U,3) S:(+X<1) X=DUZ ;ASPS user DUZ
  .S Y=$$NAME^XUSER(X) S:Y="" Y="Unknown"
  .S $P(RA,U,3)=Y ;name
  .S AR(8)=EL_U_RA ;elg^1^PSAS user^ASPS user
  .S Y=$P(A2,U,4) ;action date
  .I Y="" S Y=DT
  .D DD^%DT S $P(AR(8),U,7)=Y ;Action date
  ;;AR(8)=elg^1^P-user^A-user^entry DT^elg^Act DT
END2  I EL="" S EL="NSC" D  ;DEFAULT FOR R3*4  1/26/2011
  .S Y=DT D DD^%DT S ED=Y
  .S AR(1)=ED ; ***  ELIG DATE **
  .S AR(2)=EL ; *** calc elig CODE
  D:$G(SHW) SHOW ;SHW=1 to show calc'd values for TESTING ONLY
  D KVAR^VADPT K LD,S0,S1,S2,S6,YY,POP,VAERR
  Q
  ;
ELIGBL ;ELIGIBILITY FOR DISABILITY CONDITION - SC
  ;contains DFN,.372,X,0)=31 ptr^disabil %^SC 0/1
  ;DIC(31,i,0)= disab txt^abbrev^dx code
  Q:(+PG<1)  I "123578"'[PG Q  ;just 1,2,3,5,7&8 per Kyle 1/14/09
  Q:'$D(^DPT(DFN,.372))  N LD,S,RD,P,AX S AX=0
E1  ;*** added IA #174(rated disabilities mult node direct read)
  S AX=$O(^DPT(DFN,.372,AX)) G E1END:'AX
  I $D(^DPT(DFN,.372,AX,0)) D  G:$L(EL) E1END
  .S S=^DPT(DFN,.372,AX,0) I $P(S,U,3) D  ;service connected
  ..S RD=$P(S,U,1) D:RD  ;disibility file ptr
  ...S X=RD,DIC=31,DIC(0)="NZ" D ^DIC
  ...S LD=$S(+Y>0:$P(Y(0),U,3),1:"Unknown") K DIC,Y ;DX codes
  ...Q:+LD<5000  Q:+LD>6300  S LD=+LD ;ck specific hearing DX codes
  ...I (LD=6016)!((LD>6099)&(LD<6111)) S EL="SC" Q
  ...I ((LD>6198)&(LD<6212))!((LD>6249)&(LD<6264)) S EL="SC" Q
  ...I ((LD>6276)&(LD<6300)) S EL="SC"
  G E1 ;dis
E1END  Q
  ;
ALLIED(DFN)  ;Determine if qualifying Allied Veteran
  ;output: EL= CAN or BRI if true
  N DIC,DA,DIQ,DR,RM
  I $P(VAEL(3),U,1)=1 D  ; SC
  .S DIC=2,DA=DFN,DIQ="RM",DR=".309" D EN^DIQ1
  .S:(RM(2,DFN,.309)="CANADA") EL="CAN"
  .S:(RM(2,DFN,.309)["BRITAIN") EL="BRI"
  Q
  ;
SHOW ;View data retrieved - for debugging only if SHW=1
  ;called from END2
  W !!,"Patient: ",$G(RMDNM)
  W !,"Calculated R3 elig = " W:$L(EL) EL
  W !,"VA Elig status: " W:$L(ES) ES
  W !,"Elig status date: " W:$L(ED) ED
  ;W ! ZW AR ;FOR TESTING ONLY
ENDS Q
