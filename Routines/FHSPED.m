FHSPED ; HISC/REL/NCA - Enter/Cancel Standing Orders ;7/22/94  13:59
 ;;5.5;DIETETICS;**5,8,17**;Jan 28, 2005;Build 9
EN1 ; Enter Standing Orders for Patient
 D NOW^%DTC S NOW=%
ASK K DIC,X,DFN,FHDFN,FHPTNM,Y S ADM="",FHALL=1 D ^FHOMDPA
 G:'FHDFN KIL
 S WARD="" I $G(DFN)'="" S WARD=$G(^DPT(DFN,.1))
 I WARD="" W !!,"** NO CURRENT ADMISSION ON FILE!  If this is an Inpatient, please admit the patient first.",! D SO^FHSP G ASK
 K ADM
A0 W !!,"Return for OUTPATIENT or 'C' for CURRENT Admission: " R X:DTIME G:X["^" KIL D:X="c" TR^FH
 I (X="")&'($D(^FHPT(FHDFN,"OP"))) W !!,"** NO OUTPATIENT DATA ON FILE!  Please enter outpatient meals from Recurring Meals Menu [FHOMRMGR]!!" G ASK
 I (X="") D SO^FHSP G ASK
 I WARD'="",X="C" S ADM=$G(^DPT("CN",WARD,DFN)) G CAD:ADM
 S DIC="^FHPT(FHDFN,""A"",",DIC(0)="EQM" D ^DIC G:Y<1 A0 S ADM=+Y
CAD I ADM,$G(^FHPT(FHDFN,"A",ADM,0)) S (SDT,STDT)=$P(^FHPT(FHDFN,"A",ADM,0),U,1),ENDT=DT G E1:SDT
 ;
E1 W ! S NO=1 D LIS G:'$G(LN) N1
 K DIR W ! S DIR(0)="YA",DIR("A")="Edit a Standing Order? ",DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT)!$D(DIROUT) EN1 G:Y<1 N1
N0 R !!,"Edit which Order #? ",X:DTIME G:'$T!("^"[X) EN1 I X'?1N.N!(X<1)!(X>LN) W *7," Enter # of Order to Edit" G N0
 S SP=$P(LS,",",+X),SP=$P($G(^FHPT(FHDFN,"A",ADM,"SP",+SP,0)),"^",2) I $D(P(+X,SP)) S LN=+X  G N1A
 W !!,"Standing Order ",$P($G(^FH(118.3,+SP,0)),"^",1)," added" S LN=LN+1,P(LN,SP)="" G N1A
N1 K DIC W ! S DIC="^FH(118.3,",DIC("A")="Enter Standing Order: ",DIC(0)="AEQM"
 D ^DIC K DIC,DLAYGO G EN1:"^"[X!$D(DTOUT),N1:Y<1 S SP=+Y
 W !!,"Standing Order ",$P($G(^FH(118.3,+SP,0)),"^",1)," added"
 S LN=LN+1,P(LN,SP)=""
N1A W !,"Standing Order: ",$P($G(^FH(118.3,+SP,0)),"^",1)_" // " R X:DTIME G KIL:'$T,FHSPED:X="^"
 I X="@" D EN3 W "  .. Done" G E1
 I X'="" W *7,!,"Press Return to take Default or ""@"" to Delete" G N1A
 S $P(P(LN,SP),"^",5)=SP
N2 W !,"Select Meal (B,N,E or ALL): ",$S($P(P(LN,SP),"^",3)'="":$P(P(LN,SP),"^",3)_" // ",1:"") R MEAL:DTIME G:'$T!(MEAL="^") KIL
 I MEAL="" G:$P(P(LN,SP),"^",3)="" KIL S MEAL=$P(P(LN,SP),"^",3),$P(P(LN,SP),"^",6)=MEAL G N2A
 I MEAL="@" S $P(P(LN,SP),"^",3)="" G N2
 S X=MEAL D TR^FH S MEAL=X S:$P("ALL",MEAL,1)="" MEAL="BNE" S X=MEAL,MEAL="" S:X["B" MEAL="B" S:X["N" MEAL=MEAL_"N" S:X["E" MEAL=MEAL_"E"
 I $L(X)'=$L(MEAL) W *7,!,"Select B for Breakfast, N for Noon, E for Evening or ALL for all meals",!,"Answer may be multiple meals, e.g., BN or NE" G N2
 S $P(P(LN,SP),"^",6)=MEAL
N2A W !,"Quantity:  ",$S($P(P(LN,SP),"^",4):$P(P(LN,SP),"^",4)_"// ",1:"1// ") R NUM:DTIME S:NUM="" NUM=$S($P(P(LN,SP),"^",4):$P(P(LN,SP),"^",4),1:1) G:'$T!(NUM="^") KIL
 I NUM="@" S $P(P(LN,SP),"^",4)="" G N2A
 I NUM'?1N!(NUM<1) W !,*7,"Enter a number from 1-9." G N2A
 S $P(P(LN,SP),"^",7)=NUM
 S C1=$P(P(LN,SP),"^",2,4),C2=$P(P(LN,SP),"^",5,7) G:C1=C2 E1
N3 W !!,"ADD this Order? Y// " R YN:DTIME G:'$T!(YN="^") KIL S:YN="" YN="Y" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7,"  Answer YES or NO" G N3
 G:YN?1"N".E E1
 I C1'="^^" S OLD=$P(P(LN,SP),"^",1),$P(^FHPT(FHDFN,"A",ADM,"SP",OLD,0),"^",6,7)=NOW_"^"_DUZ K ^FHPT("ASP",FHDFN,ADM,OLD) S EVT="S^C^"_OLD D ^FHORX
 S $P(P(LN,SP),"^",2,4)="^^",$P(P(LN,SP),"^",2,4)=$P(P(LN,SP),"^",5,7),$P(P(LN,SP),"^",5,7)="^^"
ADD ; Add Standing Order
 L +^FHPT(FHDFN,"A",ADM,"SP",0):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 I '$D(^FHPT(FHDFN,"A",ADM,"SP",0)) S ^FHPT(FHDFN,"A",ADM,"SP",0)="^115.08^^"
 S X=^FHPT(FHDFN,"A",ADM,"SP",0),NO=$P(X,"^",3)+1,^(0)=$P(X,"^",1,2)_"^"_NO_"^"_($P(X,"^",4)+1)
 L -^FHPT(FHDFN,"A",ADM,"SP",0) I $D(^FHPT(FHDFN,"A",ADM,"SP",NO)) G ADD
 S ^FHPT(FHDFN,"A",ADM,"SP",NO,0)=NO_"^"_SP_"^"_MEAL_"^"_NOW_"^"_DUZ_"^^^"_NUM,^FHPT("ASP",FHDFN,ADM,NO)="",LS=LS_NO_","
 S $P(P(LN,SP),"^",1)=NO,EVT="S^O^"_NO D ^FHORX W "  .. done" G E1
EN2 ; Standing Order Inquiry
 K DIC,X,DFN,FHDFN,FHPTNM S ADM="",FHALL=1 D ^FHOMDPA
 ;S ALL=0 D ^FHDPA G:'DFN KIL G:'FHDFN KIL S NO=0 D LIS G EN2
 S (FHSOFG,WARD)="" I $G(DFN)'="" S WARD=$G(^DPT(DFN,.1))
 G:'FHDFN KIL S NO=0 D:$G(DFN) LIS
 I $D(^FHPT("ASPO",FHDFN)) D OUT
 G EN2
EN3 ; Cancel Standing Order
 S NO=$P($G(P(LN,SP)),"^",1) Q:'NO
 S $P(^FHPT(FHDFN,"A",ADM,"SP",NO,0),"^",6,7)=NOW_"^"_DUZ
 S X=^FHPT(FHDFN,"A",ADM,"SP",NO,0),SP=$P(X,"^",2),MEAL=$P(X,"^",3),NUM=""
 K ^FHPT("ASP",FHDFN,ADM,NO),P(LN,SP) S EVT="S^C^"_NO D ^FHORX Q
LIS ;list SO
 Q:WARD=""
 S NAM=$P(^DPT(DFN,0),"^",1) D CUR^FHORD7
 W !!,NAM,"  " W:WARD'="" "( ",WARD," )"
 W !!,"Current Diet: ",$S(Y'="":Y,1:"No current order")
 D ALG^FHCLN W !,"   Allergies: ",$S(ALG="":"None on file",1:ALG)
 K N,P S CTR=0
 F K=0:0 S K=$O(^FHPT("ASP",FHDFN,ADM,K)) Q:K<1  S X=^FHPT(FHDFN,"A",ADM,"SP",K,0),M=$P(X,"^",3),M=$S(M="BNE":"A",1:$E(M,1)),N(M,K)=$P(X,"^",2,3)_"^"_$P(X,"^",8,9)
 S FHSOFG=1
 S LN=0,LS="" I $O(N(""))="" W !!,"No Active Inpatient Standing Orders." Q
 W !!,"Active Inpatient Standing Orders: ",!
 F M="A","B","N","E" D
 .F K=0:0 S K=$O(N(M,K)) Q:K<1  S Z=+N(M,K) I Z D
 ..S LN=LN+1,LS=LS_K_"," D L1 W ! W:NO $J(LN,2)
 ..S NUM=$P(N(M,K),"^",3)
 ..W ?5,M2,?18,$S(NUM:NUM,1:1)," ",$P(^FH(118.3,Z,0),"^",1)_$S($P(N(M,K),"^",4)'="Y":" (I)",1:"") I $G(^FH(118.3,Z,"I"))="Y" W "     (** INACTIVE **)"
 ..S P(LN,+Z)=K_"^"_$P(N(M,K),"^",1,3) Q
 .Q
 Q
L1 ; Store Standing Order By Meal
 S M1=$P(N(M,K),"^",2) I M1="BNE" S M2="All Meals" Q
 S L=$E(M1,1),M2=$S(L="B":"Break",L="N":"Noon",1:"Even")
 S L=$E(M1,2) Q:L=""  S M2=M2_","_$S(L="B":"Break",L="N":"Noon",1:"Even") Q
OUT ;ask for Recurring Meal Entry
 W @IOF
 W "Outpatient Recurring Meals..."
 K FHDM14,FHEDI,FHEDIF,FHIEN,FHMIEN,FHFLG
 S FHQ=0
 S (FHTOTML("B"),FHTOTML("N"),FHTOTML("E"),FHTOTML("A"))=0
 F FHI=DT-1:0 S FHI=$O(^FHPT("RM",FHI)) Q:FHI'>0!FHQ  F FHJ=0:0 S FHJ=$O(^FHPT("RM",FHI,FHDFN,FHJ)) Q:FHJ'>0!FHQ  I ($P($G(^FHPT(FHDFN,"OP",FHJ,0)),U,15)'="C") D
 .S FHDA15=$G(^FHPT(FHDFN,"OP",FHJ,0))
 .S FHDM14(FHI,$P(FHDA15,U,4))=FHI_U_FHJ
 .;
 .S FHMEAL=$P(FHDA15,U,4),FHLOC=$P(FHDA15,U,3),FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1),FHMEAL=$S(FHMEAL="B":"Break",FHMEAL="N":"Noon",1:"Even"),FH11=FHMEAL_"  "_FHLOCN
 .S Y=$P(FHDA15,U,1) X ^DD("DD") S DTP=Y
 .S (FHCOFLG,FHDATL)=0
 .I $Y>(IOSL-5) K DIR S DIR(0)="E",DIR("A")="Enter RETURN to Continue or '^' to Quit Listing"  D ^DIR W:Y @IOF I 'Y S FHQ=1 Q
 .W !,DTP,?12,FH11,":"
 .S FHDATL=$L(DTP)+13+$L(FH11)
 .F FHSF=0:0 S FHSF=$O(^FHPT(FHDFN,"OP",FHJ,"SP",FHSF)) Q:FHSF'>0  D
 ..S FHDA15SF=$G(^FHPT(FHDFN,"OP",FHJ,"SP",FHSF,0))
 ..Q:$P(FHDA15SF,U,6)
 ..S FHDASFNM=$P($G(^FH(118.3,$P(FHDA15SF,U,2),0)),U,1),FHDASFQT=$P(FHDA15SF,U,8)
 ..I (FHDATL+$L(FHDASFNM)+3+$L(FHDASFQT))>79 W !,?19 S FHDATL=19
 ..I (FHDATL>19),(FHCOFLG=1) W ","
 ..S FHDATL=FHDATL+4+$L(FHDASFNM)+3+$L(FHDASFQT)
 ..W " ",FHDASFNM," = ",FHDASFQT
 I '$D(FHDM14) W !!,"NO OUTPATIENT DATA ON FILE for today's date and the future!!",! Q
 W !
 ;
 K DIC S DIC(0)="AEQM"
 S DIC("W")="S FHMEAL=$P(^(0),U,4),FHLOC=$P(^(0),U,3),FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1),FHMEAL=$S(FHMEAL=""B"":""Break"",FHMEAL=""N"":""Noon"",1:""Even""),FH11=FHMEAL_""  ""_FHLOCN D EN^DDIOL(FH11,"""",""?3"")"
 S DIC("S")="I $P(^FHPT(FHDFN,""OP"",+Y,0),U,1)>(DT-1),($P(^(0),U,15)'=""C"")"
 S DIC="^FHPT(FHDFN,""OP"","
 S DIC("?")="Select a Date, '^' to exit"
 S DIC("A")="Select the Outpatient Date :" D ^DIC K DIC Q:(Y'>0)!$D(DTOUT)
 S ADM=+Y
 D LIS^FHSP
 Q
CHK ;ENTER DATES.
 K FHDT1,FHDT2
 S FHFLG=0
F1 ;START DATE
 K DIC S DIC(0)="AEQM"
 W !
 S DIC("W")="S FHML=$P(^(0),U,4),FHLOC=$P(^(0),U,3),FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1),FHMEAL=$S(FHML=""B"":""Break"",FHML=""N"":""Noon"",1:""Even""),FH11=FHMEAL_""  ""_FHLOCN D EN^DDIOL(FH11,"""",""?3"")"
 S DIC("S")="S FHML=$P(^(0),U,4),FHDT1=$P(^(0),U,1) I $P(^(0),U,1)>(DT-1),($P(^(0),U,15)'=""C""),FHML=FHDTML"
 S DIC="^FHPT(FHDFN,""OP"","
 S DIC("?")="Enter a Date, '^' to exit"
 S DIC("A")="Enter a Start Date :" D ^DIC K DIC Q:(Y'>0)!$D(DTOUT)
 S FHDT1=$P(^FHPT(FHDFN,"OP",+Y,0),U,1)
F2 ;END DATE
 K DIC S DIC(0)="AEQM"
 W !
 S DIC("W")="S FHML=$P(^(0),U,4),FHLOC=$P(^(0),U,3),FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1),FHMEAL=$S(FHML=""B"":""Break"",FHML=""N"":""Noon"",1:""Even""),FH11=FHMEAL_""  ""_FHLOCN D EN^DDIOL(FH11,"""",""?3"")"
 S DIC("S")="S FHML=$P(^(0),U,4),FHDT2=$P(^(0),U,1) I $P(^(0),U,1)>(FHDT1-1),($P(^(0),U,15)'=""C""),FHML=FHDTML"
 S DIC="^FHPT(FHDFN,""OP"","
 S DIC("?")="Enter a Date, '^' to exit"
 S DIC("A")="Enter an End Date :" D ^DIC K DIC Q:(Y'>0)!$D(DTOUT)
 S FHDT2=$P(^FHPT(FHDFN,"OP",+Y,0),U,1)
 I FHDT2<FHDT1 W !!,"***End Date must be on or after Start Date!!!" G F2
 S FHFLG=1
 Q
CPRSO ;check previous SO
 K FHSOO,FHCK
 S (FHDAT,FHSO)=""
CPRS1 I FHSO="" S FHSO=$O(^FHPT("ASPO",FHDFN,""),-1)
 E  S FHSO=$O(^FHPT("ASPO",FHDFN,FHSO),-1)
 Q:'$G(FHSO)
 S FHDAT=$G(^FHPT(FHDFN,"OP",FHSO,0)),FHPRML=$P(FHDAT,U,4),FHPRCN=$P(FHDAT,U,15)
 I (FHPRML'=FHMEAL)!(FHPRCN="C") G CPRS1
 S FHCK(FHPRML)=""
 F FHI=0:0 S FHI=$O(^FHPT(FHDFN,"OP",FHSO,"SP",FHI)) Q:FHI'>0  D
 .S FHSODAT=$G(^FHPT(FHDFN,"OP",FHSO,"SP",FHI,0)),FHSOI=$P(FHSODAT,U,2),FHSOCN=$P(FHSODAT,U,6),FHSOQ=$P(FHSODAT,U,8)
 .Q:$P(FHSODAT,U,9)="Y"
 .I '$G(FHSOI)!$G(FHSOCN) Q
 .S FHSOO(FHI,FHSOI)=FHSOQ,P(1,FHSOI)=""
 Q
PPRSO ;PROCESS previous SO
 Q:'$D(FHSOO)
 S (LS,LN)=1
 D NOW^%DTC S NOW=%
 F FHI=0:0 S FHI=$O(FHSOO(FHI)) Q:FHI'>0  F FHJ=0:0 S FHJ=$O(FHSOO(FHI,FHJ)) Q:FHJ'>0  S NUM=FHSOO(FHI,FHJ),SP=FHJ D AD1^FHSP
 Q
SOEVNT S FHDTC=0
 S FHLOCN="" I $D(FHLOC),$G(FHLOC),$D(^FH(119.6,FHLOC,0)) S FHLOCN=$P(^(0),U,1)
 S FHDTC=FHDTC+1,DTP=FHOSTDT D DTP^FH S:FHDTC=1 FHDTP=DTP
 S DTP=$P(ENDT,".",1)  D DTP^FH
 I DTP'=FHDTP S FHDTP=FHDTP_" to "_DTP
 S FHALML=FHMEAL
 F FHI=0:0 S FHI=$O(FHSOO(FHI)) Q:FHI'>0  F FHJ=0:0 S FHJ=$O(FHSOO(FHI,FHJ)) Q:FHJ'>0  S NUM=FHSOO(FHI,FHJ),SP=FHJ D EVNT^FHSP1
 Q
KIL G KILL^XUSCLEAN
