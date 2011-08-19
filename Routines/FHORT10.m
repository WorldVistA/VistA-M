FHORT10 ; HISC/REL/NCA - Tubefeeding (cont) ;8/6/96  12:00
 ;;5.5;DIETETICS;**1**;Jan 28, 2005
E1 S FLG1=0 W ! K DIC S DIC="^FH(118.2,",DIC(0)="AEQM",STR=4,QUA=""
 S DIC("A")="Select Tubefeeding Product: " D ^DIC K DIC G AB:"^"[X!$D(DTOUT),E1:Y<1
E1A I $D(TUN(+Y)) S STR=$P(TUN(+Y),"^",2),QUA=$P(TUN(+Y),"^",3) S X=QUA D:X'="" FIX S QUA=X S:'STR STR=4
 E  G:NO>4 AB S $P(TUN(+Y),"^",1)=+Y,NO=NO+1 W !?5,"Product ",$P($G(^FH(118.2,+Y,0)),"^",1)," added"
E10 W !,"Product: ",$P($G(^FH(118.2,+Y,0)),"^",1)_"// " R X:DTIME G:'$T!(X=U) AB
 I X="" G E11
 I X="@" K TUN(+Y) S NO=NO-1 W "  Product including Strength and Quantity DELETED." S FLG1=1 G MORE
 I X["?" D HELP^FHORTR G E10
 S OLDT=$G(TUN(+Y))
 S Y=$$SRCH^FHORTR(X) I 'Y S Y=+OLDT G E10
 I +Y'=+OLDT D  G E1A
 .I '$D(TUN(+Y)) K TUN(+OLDT) W !!,$P($G(^FH(118.2,+OLDT,0)),"^",1)," Replaced With ",$P($G(^FH(118.2,+Y,0)),"^",1)
 .Q
E11 S T(0)=^FH(118.2,+Y,0),(FLG,FLG1)=0,S2="",TT=+Y
 I $E($P(T(0),"^",3),$L($P(T(0),"^",3)))?1"G" S FLG=1 G F0
E2 W !,"Strength: (1=1/4, 2=1/2, 3=3/4, 4=FULL): ",STR,"// " R X:DTIME G AB:'$T!(X=U),F0:X=""
 I X'?1N!(X<1)!(X>4) W *7,!!,"Enter 1 to 4 to indicate strength." G E2
 S STR=+X
F0 W !,"Enter quantity as 2000 K, 100 ML/HOUR, 8 OZ/TID, 500 ML/HR X 16, 20 GRAMS/DAY etc."
E3 W !,"Quantity: ",$S(QUA:QUA_"// ",1:"") R X:DTIME G:'$T!(X["^") AB S:X="" X=QUA G:"?"[X F5 D TR^FH
 I X=QUA G:STR=$P(TUN(TT),"^",2) MORE
 S (TC,TK,TP,TW)=0
 I $E(X,$L(X))="K" S X=X_"/QD"
 S A1="" F K=1:1:$L(X) S Z=$E(X,K) I Z'=" " S A1=A1_Z
 F K=1:1:$L(A1) Q:$E(A1,K)?1U
 S A2=$E(A1,K,99),A1=+$E(A1,1,K-1)
 I A2?1"G".E,'FLG W *7,!!,"Cannot enter ""GRAMS"" if AMT/UNIT is specified in ML's." G F0
 S A3=$P(A2,"/",2),A2=$P(A2,"/",1)
 I FLG S XX=$F("KCAL CC ML OZ TBSP",A2) I XX W *7,!!,"Enter quantity in powder form when AMT/UNIT is in Grams (e.g., # GMS, 1 PKG, or 1 U/Frequency)." G F0
 D:FLG GRAM F K=1:1:11 S S1=$P("KCAL CC ML OZ UNITS BOTTLES CANS PKG TBSP GMS GRAMS"," ",K) G:$P(S1,A2,1)="" F3
 G F5
F3 S S1=$S(K=1:1,K<4:2,K=4:3,K=9:5,K>9:6,1:4),A2=$P(A3,"X",1),A3=$P(A3,"X",2)
 G:A2'?1U.E F5 I $L(A2)=1,"DH"'[A2 G F5
 S S2=$F("DAY QD QH HOUR HR BID TID Q2H Q3H Q4H Q6H QID",A2) G:'S2 F5 S S2=$S(S2<8:1,S2<19:2,S2<23:3,S2<27:4,S2<31:5,S2<35:6,S2<39:7,1:8)
 S QUA=A1_" "_$P("KCAL ML OZ UNITS TBSP GM"," ",S1),QUA=QUA_" "_$P($T(F6),";",S2+2)
 S:A3'="" QUA=QUA_" X "_(+A3)_" "_$S(A3["F":"fdgs",1:"hrs")
 I S1=1 S DX=$P(T(0),"^",4) G:'DX F5 S TK=A1,TC=A1/DX*$S(STR=4:1,STR=3:1.333,STR=2:2,1:4)
 I S1=4 S DX=+$P(T(0),"^",3) G:'DX F5 S TC=A1*DX*$S(STR=4:1,STR=3:1.333,STR=2:2,1:4)
 S:S1=2 TC=A1 S:S1=3 TC=A1*29.5 S:S1=5 TC=A1*15 I S1=6 S TC=0,A3=0 G C1
ML I 'A3 S A3=$P("1,24,2,3,12,8,6,4",",",S2) G C1
 I A3'["F" S A3=$S(S2=1:1,S2=2:A3,S2=3:2,S2=4:3,S2=5:A3\2,S2=6:A3\3,S2=7:A3\4,1:A3\6)
 E  S:S2=1 A3=1
C1 S TC=$J(TC*A3,0,0)
 W !!,"Quantity: ",QUA,"  -- Total: ",TC," ml"
 I TC>5000 W *7,!!,"WARNING: Total Amount should be between 0 to 5000 ml",!,"Please Edit Tubefeeding and Modify."
 S:TC'<1 TP=$S(STR=4:TC,STR=3:TC*.75,STR=2:TC/2,1:TC/4),TP=$J(TP,0,0),TW=TC-TP
 I S1'=1!(S1'=6) S TK="",DX=$P(T(0),"^",4) I DX S TK=DX*TP,TK=$J(TK,0,0)
 S $P(TUN(TT),"^",2,6)=STR_"^"_QUA_"^"_TP_"^"_TW_"^"_TK G:TC>5000 E1
MORE R !!,"Enter/Edit another Tubefeeding product ? N// ",ANS:DTIME G:'$T!(ANS="^") AB S:ANS="" ANS="N" S X=ANS D TR^FH S ANS=X
 I $P("YES",ANS,1)'="",$P("NO",ANS,1)'="" W *7,!,"Answer YES to Enter More Products or Edit Existing Product.",!,"Answer NO to End Entering and Editing and Process the Products.",!,"Enter ""^"" will Terminate process." G MORE
 I ANS?1"Y".E  D DISP^FHORTR G E1
 I FLG1,'NO S TF=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",4) D:TF CAN^FHORT2
 Q
FIX ; Reset Quantity to parsable string
 S K=$F(X,"fdgs") I K>1 S X=$E(X,1,K-5)_"F"
 S K=$F(X,"hrs") I K>1 S X=$E(X,1,K-5)
 F K=1:1:8 S Z=" "_$P($T(F6),";",K+2) I X[Z G F1
 Q
F1 S X=$P(X,Z,1)_"/"_$P("QD QH BID TID Q2H Q3H Q4H Q6H"," ",K)_$P(X,Z,2) Q
GRAM ; Get the Grams for powder form
 Q:$E(A2,1)="G"
 S A1=A1*+$P(T(0),"^",3),A2="GRAM"
 Q
AB W *7,!!,"Tubefeeding Order TERMINATED - No order entered!" D:FHWF=2 WAIT^FHORD71 S (DFN,FHDFN)="" K TUN Q
F5 W *7,!!,"Units may be K for Kcals, M for ml's, O for oz. or U for units (e.g., cans)"
 W !,"Frequency may be DAY, HOUR, QD, QH, BID, TID, QID, Q2H, Q3H, Q4H or Q6H"
 W !,"May also input 100ML/HR X 16 for 16 hours or 100ML/Q3H X 6F for 6 feedings."
 W !,"When feeding is specified, it is taken into account other than the predetermined frequency interval.",!,"If Frequency is ordered per day, the Total ml is always the Units ordered."
 W !,"Valid quantity for powder form product can be ""# GRAMS"" as 20 G, GRAMS",!,"or GMS or as 1 PKG or 1 U and the frequency (e.g.,20 GRAMS/DAY, 1 PKG/TID).",! G F0
F6 ;;per Day;per Hour;Twice a Day;Three times a Day;Every 2 Hours;Every 3 Hours;Every 4 Hours;Every 6 Hours
