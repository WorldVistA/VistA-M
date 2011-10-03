FHSP ; HISC/REL/NCA - Standing Orders ;2/13/95  14:30 
 ;;5.5;DIETETICS;**5,8**;Jan 28, 2005;Build 28
EN1 ; Enter/Edit Standing Orders
 K DIC W ! S (DIC,DIE)="^FH(118.3,",DIC(0)="AEQLM",DIC("DR")=".01",DLAYGO=118.3 W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN1:Y<1
 S DA=+Y,DR=".01:99" S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=118.3 D ^DIE K DA,DIE,DIDEL,DR G EN1
EN2 ; List Standing Orders
 W ! S L=0,DIC="^FH(118.3,",FLDS=".01,99,1",BY="NAME"
 S FR="",TO="",DHD="STANDING ORDERS" D EN1^DIP
 K %ZIS S IOP="" D ^%ZIS G KIL
SO ;OutPT SO
 S FHSOOP=$O(^FHPT(FHDFN,"OP","B",DT-1))
 I '$D(^FHPT(FHDFN,"OP"))!'$G(FHSOOP) W !!,"** NO OUTPATIENT DATA ON FILE!  Please enter outpatient meals from Recurring Meals Menu [FHOMRMGR]." Q
 W @IOF,!,"Outpatient Recurring Meals... "
A0 ;Rec Meal entry.
 K FHDM14,FHEDI,FHEDIF,FHIEN,FHMIEN,FHFLG,FHCK
 S FHQ=0
 S (FHTOTML("B"),FHTOTML("N"),FHTOTML("E"),FHTOTML("A"))=0
 F FHI=DT-1:0 S FHI=$O(^FHPT("RM",FHI)) Q:FHI'>0!FHQ  F FHJ=0:0 S FHJ=$O(^FHPT("RM",FHI,FHDFN,FHJ)) Q:FHJ'>0!FHQ  I ($P($G(^FHPT(FHDFN,"OP",FHJ,0)),U,15)'="C") D
 .S FHDA15=$G(^FHPT(FHDFN,"OP",FHJ,0))
 .S FHDM14(FHI,$P(FHDA15,U,4))=FHI_U_FHJ
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
 ..S FHCOFLG=1
 F FHI=0:0 S FHI=$O(FHDM14(FHI)) Q:FHI'>0  D
 .F FHJ="B","N","E" Q:FHJ=""  D
 ..I (FHJ="B")&$D(FHDM14(FHI,FHJ)) S FHTOTML("B")=FHTOTML("B")+1,FHIEN(FHJ)=FHDM14(FHI,FHJ)
 ..I (FHJ="N")&$D(FHDM14(FHI,FHJ)) S FHTOTML("N")=FHTOTML("N")+1,FHIEN(FHJ)=FHDM14(FHI,FHJ)
 ..I (FHJ="E")&$D(FHDM14(FHI,FHJ)) S FHTOTML("E")=FHTOTML("E")+1,FHIEN(FHJ)=FHDM14(FHI,FHJ)
 I '$D(FHDM14) W !!,"NO OUTPATIENT DATA ON FILE for today's date and the future!!",! Q
 ;
R1 S (FHCNSOF,FH1,FHQ)=0,(FHDTML,FHX,FHALML)="" R !!,"Enter a Meal (B,N,E or ALL): ALL// ",FHDTML:DTIME
 Q:'$T!(FHDTML["^")
 S:FHDTML="" FHDTML="ALL"
 I FHDTML["?" S FHQ=1 G MS1
 S X=FHDTML D TR^FH S (FHX,FHDTML)=X
 I FHDTML="A" S FHQ=1 G MS1
 S FHALML=FHX
 I FHDTML="ALL" S FHDTML=$E(FHDTML,1),FHALML="BNE"
 I $L(FHDTML)=3 S:("BNE")'[$E(FHDTML,1) FHQ=1 S:("BNE")'[$E(FHDTML,2) FHQ=1 S:("BNE")'[$E(FHDTML,3) FHQ=1 S FHCK($E(FHDTML,1))="",FHCK($E(FHDTML,2))="",FHCK($E(FHDTML,3))=""
 I $L(FHDTML)=2 S:("BNE")'[$E(FHDTML,1) FHQ=1 S:("BNE")'[$E(FHDTML,2) FHQ=1 S FHCK($E(FHDTML,1))="",FHCK($E(FHDTML,2))=""
 I $L(FHDTML)=1 S:("ABNE")'[$E(FHDTML,1) FHQ=1 S FHCK(FHDTML)=""
 I FHDTML="A" S (FHCK("B"),FHCK("N"),FHCK("E"))=""
 S:$L(FHDTML)>3 FHQ=1
 G:FHQ MS1
 I $L(FHDTML)=3 S:'$G(FHTOTML($E(FHDTML,1))) FH1=1 S:'$G(FHTOTML($E(FHDTML,2))) FH1=1 S:'$G(FHTOTML($E(FHDTML,3))) FH1=1 I FH1 W !!,"There is no outpatient data for this Meal!!" G R1
 I $L(FHDTML)=2 S:'$G(FHTOTML($E(FHDTML,1))) FH1=1 S:'$G(FHTOTML($E(FHDTML,2))) FH1=1 I FH1 W !!,"There is no outpatient data for this Meal!!" G R1
MS1 I FHQ W *7,!,"Select B for Breakfast, N for Noon, E for Evening or ALL for all meals",!,"Answer may be multiple meals, e.g., BN or NE" G R1
 S:$L(FHDTML)>1 FHDTML="A"
 S FHLIS=0
 I (FHDTML'="A"),(FHTOTML(FHDTML)'>0) W !!,"There is no outpatient data for this Meal!!" G R1
 I FHDTML'="A",(FHTOTML(FHDTML)=1) S FHEDI($P(FHIEN(FHDTML),U,2))="" G E0
 I FHDTML="A" G ALL
 I FHDTML'="A",(FHTOTML(FHDTML)>1) D CHK^FHSPED Q:'$G(FHFLG)   ;quit dates are not entered for range.
 I $G(FHFLG) F FHI=FHDT1-1:0 S FHI=$O(FHDM14(FHI)) Q:(FHI'>0)!(FHI>FHDT2)  S:$D(FHDM14(FHI,FHDTML)) FHEDI($P(FHDM14(FHI,FHDTML),U,2))=""
 G E0
ALL S FHCT=0,(FHDT1,FHDT2,FHDTSV)=DT F FHI=DT-1:0 S FHI=$O(FHDM14(FHI)) S:'FHI FHDT2=FHDTSV Q:FHI'>0  S FHCT=FHCT+1,FHDTSV=FHI S:FHCT=1 FHDT1=FHI S FHJ="" F  S FHJ=$O(FHDM14(FHI,FHJ)) Q:FHJ=""  S FHEDI($P(FHDM14(FHI,FHJ),U,2))=""
E0 S ADM=0
E1 W ! S FHLOCN="",ADM=$O(FHEDI(ADM)) Q:'ADM  S NO=1,MEAL=$P($G(^FHPT(FHDFN,"OP",ADM,0)),U,4),FHLOC=$P($G(^(0)),U,3)
 I FHX'="ALL",FHX'[MEAL G E1
 I $G(FHLOC) S FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1)
 D LIS G:'LN N1
 K DIR W ! S DIR(0)="YA",DIR("A")="Edit a Standing Order? ",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)!$D(DIROUT)  G N1:Y<1
N0 R !!,"Edit which Order #? ",X:DTIME Q:'$T!("^"[X)  I X'?1N.N!(X<1)!(X>LN) W *7," Enter # of Order to Edit" G N0
 S SP=$P(LS,",",+X),SP=$P($G(^FHPT(FHDFN,"OP",ADM,"SP",+SP,0)),"^",2) I $D(P(+X,SP)) S LN=+X  G N1A
 W !!,"Standing Order ",$P($G(^FH(118.3,+SP,0)),"^",1)," added" S LN=LN+1,P(LN,SP)="" G N1A
N1 K DIC W ! S DIC="^FH(118.3,",DIC("A")="Enter Standing Order: ",DIC(0)="AEQM"
 D ^DIC K DIC,DLAYGO Q:"^"[X!$D(DTOUT)  G SO:Y<1 S SP=+Y
 W !!,"Standing Order ",$P($G(^FH(118.3,+SP,0)),"^",1)," added"
 S LN=LN+1,P(LN,SP)=""
N1A W !,"Standing Order: ",$P($G(^FH(118.3,+SP,0)),"^",1)_" // " R X:DTIME G KIL:'$T
 I X="^" G E0
 I X="@" D SO3 W "  .. Done" G E0
 I X'="" W *7,!,"Press Return to take Default or ""@"" to Delete" G N1A
 S $P(P(LN,SP),"^",5)=SP
N2 ;
 S $P(P(LN,SP),"^",6)=MEAL
N2A W !,"Quantity:  ",$S($P(P(LN,SP),"^",4):$P(P(LN,SP),"^",4)_"// ",1:"1// ") R NUM:DTIME S:NUM="" NUM=$S($P(P(LN,SP),"^",4):$P(P(LN,SP),"^",4),1:1) G:'$T!(NUM="^") KIL
 I NUM="@" S $P(P(LN,SP),"^",4)="" G N2A
 I NUM'?1N!(NUM<1) W !,*7,"Enter a number from 1-9." G N2A
 S $P(P(LN,SP),"^",7)=NUM
 S C1=$P(P(LN,SP),"^",2,4),C2=$P(P(LN,SP),"^",5,7)
 Q:C1=C2
N3 W !!,"ADD this Order? Y// " R YN:DTIME G:'$T!(YN="^") KIL S:YN="" YN="Y" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7,"  Answer YES or NO" G N3
 Q:YN?1"N".E
 I C1'="^^" S OLD=$P(P(LN,SP),"^",1),$P(^FHPT(FHDFN,"OP",ADM,"SP",OLD,0),"^",6,7)=NOW_"^"_DUZ K ^FHPT("ASPO",FHDFN,ADM,OLD) D
 .S DTP=$P($G(^FHPT(FHDFN,"OP",ADM,0)),U,1) D DTP^FH
 .S FHACT="O",FHTXT="Outpatient Standing Order: "_NUM_" "_$P($G(^FH(118.3,SP,0)),U,1)_" ("_MEAL_"), "_FHLOCN_", "_DTP D OPFILE^FHORX Q
 S $P(P(LN,SP),"^",2,4)="^^",$P(P(LN,SP),"^",2,4)=$P(P(LN,SP),"^",5,7),$P(P(LN,SP),"^",5,7)="^^"
ADD ; Add SO
 F FHI=0:0 S FHI=$O(FHEDI(FHI)) Q:FHI'>0  S ADM=FHI D AD1
 D EVNT^FHSP1
 G E0
AD1 L +^FHPT(FHDFN,"OP",ADM,"SP",0)
 S FHLOCN="" S:'$D(FHCNSOF) FHCNSOF=0
 S MEAL=$P($G(^FHPT(FHDFN,"OP",ADM,0)),U,4) Q:'$D(FHCK(MEAL))
 S FHLOC=$P($G(^(0)),U,3) I $G(FHLOC) S FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1)
 I '$D(^FHPT(FHDFN,"OP",ADM,"SP",0)) S ^FHPT(FHDFN,"OP",ADM,"SP",0)="^115.1626^^"
 S X=^FHPT(FHDFN,"OP",ADM,"SP",0),NO=$P(X,"^",3)+1,^(0)=$P(X,"^",1,2)_"^"_NO_"^"_($P(X,"^",4)+1)
 L -^FHPT(FHDFN,"OP",ADM,"SP",0) I $D(^FHPT(FHDFN,"OP",ADM,"SP",NO)) G AD1
 S ^FHPT(FHDFN,"OP",ADM,"SP",NO,0)=NO_"^"_SP_"^"_MEAL_"^"_NOW_"^"_DUZ_"^^^"_NUM,^FHPT("ASPO",FHDFN,ADM,NO)="",LS=LS_NO_","
 S $P(P(LN,SP),"^",1)=NO
 S DTP=$P($G(^FHPT(FHDFN,"OP",ADM,0)),U,1) D DTP^FH S FHCNSOF=FHCNSOF+1 S:FHCNSOF=1 FHDTP=DTP
 Q
SO2 ; SO Inquiry
 Q:'$G(ADM)
 S ALL=1 D ^FHOMDPA G:'FHDFN KIL S NO=0 D LIS G SO2
SO3 ; Cancel SO
 S (FHLOCN,FHDTP)="" S:'$D(FHCNSOF) FHCNSOF=0
 F FHI=0:0 S FHI=$O(FHEDI(FHI)) Q:FHI'>0  S ADM=FHI D
 .S MEAL=$P($G(^FHPT(FHDFN,"OP",ADM,0)),U,4) Q:'$D(FHCK(MEAL))
 .S FHLOCN=""
 .S FHLOC=$P($G(^FHPT(FHDFN,"OP",ADM,0)),U,3) I $G(FHLOC) S FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1)
 .F FHJ=0:0 S FHJ=$O(^FHPT(FHDFN,"OP",ADM,"SP",FHJ)) Q:FHJ'>0  D
 ..S SPD=$P($G(^FHPT(FHDFN,"OP",ADM,"SP",FHJ,0)),U,2)
 ..S NO=""
 ..I SP=SPD,$P($G(^FHPT(FHDFN,"OP",ADM,"SP",FHJ,0)),U,6)="" S NO=FHJ
 ..Q:'NO
 ..S $P(^FHPT(FHDFN,"OP",ADM,"SP",NO,0),"^",6,7)=NOW_"^"_DUZ
 ..S X=^FHPT(FHDFN,"OP",ADM,"SP",NO,0),SP=$P(X,"^",2),MEAL=$P(X,"^",3),NUM=$P(X,"^",8)
 ..K ^FHPT("ASPO",FHDFN,ADM,NO),P(LN,SP)
 ..S DTP=$P($G(^FHPT(FHDFN,"OP",ADM,0)),U,1) D DTP^FH S FHDTP=DTP
 S:'$D(FHDTP) FHDTP=DT
 I $D(FHDT1) S DTP=FHDT1 D DTP^FH S FHDTP=DTP
 I $D(FHDT2) S DTP=FHDT2 D DTP^FH S:FHDTP'=DTP FHDTP=FHDTP_" to "_DTP
 S FHACT="C",FHTXT="Outpatient Standing Order:  "_$P($G(^FH(118.3,SP,0)),U,1)_" ("_FHALML_"), "_FHLOCN_", Cancelled "_FHDTP D OPFILE^FHORX
 Q
LIS ;list outpt SO
 Q:'$G(ADM)
 D PATNAME^FHOMUTL
 S FHDATA0=$G(^FHPT(FHDFN,"OP",ADM,0))
 S DTP=$P(FHDATA0,U,1) D DTP^FH S FHDTST=DTP
 S NAM=FHPTNM,Y="",(FHDIETP,FHDIET,WARD)=""
 S FHDIET=$P(FHDATA0,U,2) I $D(^FH(119.6,$P(FHDATA0,U,3),0)) S WARD=$P(^FH(119.6,$P(FHDATA0,U,3),0),U,1)
 I $G(FHDIET) S Y=$P(^FH(111,FHDIET,0),U,1)
 I FHDIET="" S FHRNUM=ADM D DIETPAT^FHOMRR1 S:$D(FHDIETP) Y=FHDIETP
 W !!,NAM,"  " W:WARD'="" "( ",WARD," )" W:$D(FHDTST) ?40,"Date: ",FHDTST
 W !!,"Current Diet: ",$S(Y'="":Y,1:"No current order")
 D ALG^FHCLN W !,"   Allergies: ",$S(ALG="":"None on file",1:ALG)
 K N,P S CTR=0
 F K=0:0 S K=$O(^FHPT("ASPO",FHDFN,ADM,K)) Q:K<1  S X=^FHPT(FHDFN,"OP",ADM,"SP",K,0),M=$P(X,"^",3),M=$S(M="BNE":"A",1:$E(M,1)),N(M,K)=$P(X,"^",2,3)_"^"_$P(X,"^",8,9)
 S FHSOFG=1
 S LN=0,LS="" I $O(N(""))="" W !!,"No Active Outpatient Standing Orders." Q
 W !!,"Active Outpatient Standing Orders: ",!
 F M="A","B","N","E" D
 .F K=0:0 S K=$O(N(M,K)) Q:K<1  S Z=+N(M,K) I Z D
 ..S LN=LN+1,LS=LS_K_"," D L1 W ! W:NO $J(LN,2)
 ..S NUM=$P(N(M,K),"^",3)
 ..W ?5,M2,?18,$S(NUM:NUM,1:1)," ",$P(^FH(118.3,Z,0),"^",1)_$S($P(N(M,K),"^",4)'="Y":" (I)",1:"") I $G(^FH(118.3,Z,"I"))="Y" W "     (** INACTIVE **)"
 ..S P(LN,+Z)=K_"^"_$P(N(M,K),"^",1,3) Q
 Q
L1 ; Store SO
 S M1=$P(N(M,K),"^",2) I M1="BNE" S M2="All Meals" Q
 S L=$E(M1,1),M2=$S(L="B":"Break",L="N":"Noon",1:"Even")
 S L=$E(M1,2) Q:L=""  S M2=M2_","_$S(L="B":"Break",L="N":"Noon",1:"Even") Q
 Q
KIL G KILL^XUSCLEAN
