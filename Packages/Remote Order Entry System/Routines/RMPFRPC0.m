RMPFRPC0        ;DDC/PJU - Module to establish DDC elig for ROES3 ;7/14/04
 ;;3.0;REMOTE ORDER/ENTRY SYSTEM;**1**;11/1/02
START(AR,DFN,SHW)       ;called from RPC RMPFELIG
 ;;input: array name by ref, DFN, SHW=1(opt) if prompts can be shown
 ;;will return to the Delphi app as 0-7 subscripts in same order
 ;created during calculation in the AR array (passed by reference)
 ;PD = AR(0)=date of death msg or ""
 ;ED = AR(1)=eligibility status date FM
 ;EL = AR(2)=calculated eligibility code
 ;ES = AR(3)=eligibility status
 ;SR = AR(4)=sensitive record
 ;ER = AR(5) is for error msg's
 ;PE = AR(6)=primary eligibility
 ;PG = AR(7)=priority group
 ;RA = AR(8)=elig^APPR(1)/DISAPPR(0)/submit(2)^PSAS user^ASPS user^req dt^sug el^act dt
 ;PS = enrollment group sub
 ;R3 = array of auto accepted R3 elig's
 K AR ;in case came in with data (is called by ref)
 N ROES ;array of eligibilities to submitted to PSAS
N N ED,EL,ES,FL,ER,PD,PE,PG,PS,R3,RA,SR,SSN,VS,VT,IEN
 S (ED,EL,ES,FL,ER,PD,PE,PG,PS,R3,RA,SR,SSN,VS,VT,IEN)=""
 F X=0:1:8 S AR(X)="" ;re-establish AR
 F X="SC","COM","EP3","POW","AAA","HB","CAN","BRI","WWI" S R3(X)="" ;no PSAS ap needed
D K VADM,VAEL,VAMB,VAPA,VASV
 D DEM^VADPT ;sets up VADM() - demographic variables *** ck for errors
 I $G(VAERR) S ER="**ERROR** Problem in retrieving Demographic values" G END
 I $G(VADM(6)) D
 .S (PD,AR(0))=VADM(6) ;fm^external date of death
 S SSN=$P($G(VADM(2)),U,1)
 ;*** ADDED TO Integration agreement 767 NAME: DBIA268-C SEN REC ***
 I $P($G(^DGSL(38.1,DFN,0)),U,2) S AR(4)=1 ;ck for sensitive record
 S VAPA("P")="" D ADD^VADPT ;get permanent address
 I $G(VAERR) S ER="**ERROR** Problem in retrieving Permanent Address" G END
E D ELIG^VADPT ;sets up VAEL() - eligibility variables & ck for errors
 I $G(VAERR) D  G END
 .S ER="**ERROR** Problem in retrieving Eligibility from ELIG^VADPT"
 I $L(ER) G END
 S (PE,AR(6))=$P($G(VAEL(1)),U,2) ;external form of PRIMARY ELIG
 S ES=$P($G(VAEL(8)),U,1) ;elig status
 I ES="V" D
 .K RM S DIC=2,DA=DFN,DIQ="RM",DR=".3612" D EN^DIQ1
 .S ED=RM(2,DFN,.3612) ;elig date text
 .S %DT="X",X=ED D ^%DT S:+Y>1 ED=+Y_U_ED ;fmdate ^ text date
 .K RM,DIC,DA,DIQ,DR
 S VT=$S($G(VAEL(4)):"Y",1:"N") ;VET Y/N
 I VT="Y" D  ;G:$L(EL) END ;11/19/03 need PG for ALL
 .D ELIGBL Q:$L(EL)  ; checks for SC for condition                       SC
 .S VS=$G(VAEL(3)) I $P(VS,U,1) D  ;VAEL(3)=0/1 for SC ^ %
 ..I $P(VS,U,2)'<10  S EL="COM" ;SC 10% or greater                       COM
 K RM S DIC=2,DA=DFN,DIQ="RM",DR="27.01",DIQ(0)="I" D EN^DIQ1
 S DA=$G(RM(2,DFN,27.01,"I")) ;CURRENT ENROLLMENT entry in patient file
 I DA D
 .K RM2 S DIC=27.11,DIQ="RM2",DR=".07;.12",DIQ(0)="I" D EN^DIQ1
 .S (PG,AR(7))=$G(RM2(27.11,DA,.07,"I")) ;Priority Group
 .S PS1=$G(RM2(27.11,DA,.12,"I"))
 .S PS=$S(PS1=1:"A",PS1=2:"B",PS1=3:"C",PS1=4:"D",1:"") ;Priority Subgroup
 K RM,RM2,DIC,DA,DIQ,DR,PS1
 G:$L(EL) END ;11/19/03 now can go to end if know EL
 I VT="Y",PG=3 D  G:$L(EL) END
 .S EL="EP3" ;                                                           EP3
 D SVC^VADPT I $G(VAERR) D  G END
 .S ER="**ERROR** Problem in retrieving Service Information(SVC^VADPT)"
 I ($G(VASV(4))=1)!($P(VAEL(1),U,2)="PRISONER OF WAR") D  G:$L(EL) END
 .S EL="POW" ;                                                           POW
 D MB^VADPT I $G(VAERR) D  G END
 .S ER="**ERROR** Problem in retrieving Benefit information(MB^VADPT)"
 ; VAEL(1)=#^PRIMARY ELIG
 I VT="Y" D  G:$L(EL) END
 .I $G(VAMB(1))!($P(VAEL(1),U,2)="AID & ATTENDANCE") S EL="AAA" Q  ;     AAA **PRI ELIG
 .I $G(VAMB(2))!($P(VAEL(1),U,2)="HOUSEBOUND") S EL="HB" Q  ;            HB **
 .I $G(VAEL(3)),$P($G(VAEL(3)),U,2)=0 D  Q:$L(EL)  ;                     0CA
 ..I PG=5 S EL="0CA" Q
 ..I PG=7,PS="A" S EL="0CA"
 .I PG=5 D  Q:$L(EL)  ;                                                  NCA**
 ..I $P($G(VAEL(1)),U,2)="NSC, VA PENSION" S EL="NCA" Q  ;PG5 NSC, VA PENSION primary eligibility
 ..I $P($G(VAEL(6)),U,2)="NSC VETERAN" S EL="NCA" Q  ;PG 5 NSC Veteran
 .;I PG=6 S EL="SCV" Q  ;Special category veterans                        SCV
 .I ($P($G(VAEL(2)),U,2)="WORLD WAR I")!($P($G(VAEL(2)),U,2)="MEXICAN BORDER WAR") D
 ..S EL="WWI" ;                                                          WWI
 G:$L(EL) END
 D ALLIED(DFN) G:$L(EL) END ;                                            CAN or BRI
 S X=0 D:($D(VAEL(1))>9)  G:$L(EL) END ;                                 OGA
 .F  S X=$O(VAEL(1,X)) Q:'X  D  Q:$L(EL)
 ..I $P(VAEL(1,X),U,2)="OTHER FEDERAL AGENCY" S EL="OGA"
 I VT="Y",'$G(VAEL(3)) D  G:$L(EL) END ;                                 NSC
 .I (PG=7)&(PS="C") S EL="NSC"
 I VT="Y",PG=8 S EL="PG8" ;                                              PG8
END I $L($G(ER)) S AR(5)=ER
 S:$L(ED) AR(1)=ED ;                                                     ELIG DATE
 S:$L(EL) AR(2)=EL ;                                                     calc elig CODE
 S:$L($G(ES)) AR(3)=ES ;                                                 ELIG STAT
 ;CK FOR ACCEPTANCE OR REJECTION
 S IEN="" I $D(^RMPF(791814,"B",DFN)) D
 .S IEN=$O(^RMPF(791814,"B",DFN," "),-1)
 G:'IEN END2
 I (EL="")!(EL="NSC")!(EL="BLR")!(EL="VOC")!(EL="OGA")!(EL="PG8")!(EL="NCA")!(EL="0CA") D
 .S RA=$P($G(^RMPF(791814,IEN,2)),U,2) ;0 or 1 or 2
 .S:RA="" RA=2 ;submitted, but not acted on
 .S EL=$S(RA=1:$P($G(^RMPF(791814,IEN,2)),U,1),1:EL),AR(2)=EL ;appr elig code or CALC
 .S X=$P($G(^RMPF(791814,IEN,2)),U,3),Y="Unknown" ;PSAS user DUZ
 .I X>0 S DIC=200,DIC(0)="N" D ^DIC D
 ..S Y=$S(+Y>0:$P(Y,U,2),1:"Unknown") K DIC
 ..S $P(RA,U,2)=Y ;name of PSAS user
 .S X=$P($G(^RMPF(791814,IEN,0)),U,3),Y="Unknown" ;ASPS user DUZ
 .I X>0 S DIC=200,DIC(0)="N" D ^DIC D
 ..S Y=$S(+Y>0:$P(Y,U,2),1:"Unknown") K DIC
 ..S $P(RA,U,3)=Y ;name of ASPS user
 .S:$L(RA) AR(8)=EL_U_RA ;elg^0/1/2^PSAS user^ASPS user name
 .S Y=$P(^RMPF(791814,IEN,0),U,2) D DD^%DT ;ret Y=date of req
 .S $P(AR(8),U,5)=Y ;elg^0/1/2^PSAS user ^ASPS user name^dt req ent
 .I $D(^RMPF(791814,IEN,1)) D
 ..S $P(AR(8),U,6)=$P(^RMPF(791814,IEN,1),U,1) ;sugg elig
 .I $D(^RMPF(791814,IEN,2)) D
 ..S Y=$P(^RMPF(791814,IEN,2),U,4) D:$L(Y) DD^%DT
 ..S $P(AR(8),U,7)=Y ;Action date
END2 D:$G(SHW) SHOW ; show calc'd values for testing
 D KVAR^VADPT K LD,S0,S1,S2,S6,YY,POP
 Q
ELIGBL ;ELIGIBILITY FOR DISABILITY CONDITION
 ;contains DFN,.372,X,0)=31 ptr^disabil %^SC 0/1
 ;DIC(31,i,0)= disab txt^abbrev^dx code
 N LD,S,RD,P,AX S AX=0
E1 ;*** added to IA #174 for rated disabilities multiple node direct read
 S AX=$O(^DPT(DFN,.372,AX)) G E1END:'AX
 I $D(^DPT(DFN,.372,AX,0)) D  G:$L(EL) E1END
 .S S=^DPT(DFN,.372,AX,0) I $P(S,U,3) D  ;service connected
 ..S RD=$P(S,U,1) D:RD  ;disibility file ptr
 ...S X=RD,DIC=31,DIC(0)="NZ" D ^DIC
 ...S LD=$S(+Y>0:$P(Y(0),U,3),1:"Unknown") K DIC,Y
 ...Q:+LD<5000  Q:+LD>6300  S LD=+LD ;ck hearing loss DX codes/ck on codes 6259 & 6298
 ...I (LD=6016)!((LD>6099)&(LD<6111)) S EL="SC" Q
 ...I ((LD>6198)&(LD<6212))!((LD>6249)&(LD<6264)) S EL="SC" Q  ; SC for condition
 ...I ((LD>6276)&(LD<6300)) S EL="SC"
 G E1 ;dis
E1END Q
 ;
SHOW ;all visible prompts if needed FOR TESTING ONLY
 ;ZW AR ; for testing
 W !!,"Patient: " I $G(DFN) W $S($D(^DPT(DFN,0)):$P(^(0),U,1),1:DFN)
 I $L(EL) D
 .W !,"Calculated R3 elig = ",EL
 .I '$D(R3(EL)) D
 ..W !," ***** ","ROES3 ELIGIBILITY MUST BE APPROVED BY PSAS *****"
 I '$L(EL) D
 .W !," ***** ","ROES3 ELIGIBILITY NOT DETERMINED, ORDER MUST BE APPROVED BY PSAS *****"
 W !,"VA Elig status: "
 I $L(ES) W ES
 E  W !," ***** ","NO ELIG STATUS - MUST BE APPROVED BY PSAS *****"
 W !,"Elig status date: " I $L(ED) W ED
ENDS Q
 ;
ALLIED(DFN)  ;;input: DFN
 ;;output: EL= CAN or BRI if true
 I $P(VAEL(3),U,1)=1 D  ;sc
 .N DIC,DA,DIQ,DR,RM
 .S DIC=2,DA=DFN,DIQ="RM",DR=".309" D EN^DIQ1
 .S:(RM(2,DFN,.309)="CANADA") EL="CAN"
 .S:(RM(2,DFN,.309)["BRITAIN") EL="BRI"
 Q
