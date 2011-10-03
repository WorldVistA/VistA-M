FHWOR51 ; HISC/NCA - HL7 Tubefeeding (Cont.) ;6/28/96  16:28
 ;;5.5;DIETETICS;**1**;Jan 28, 2005
 I $E(DATA,1,3)'="ODS" S TXT="Message 5 not ODS as expected." Q
 S TYP=$P(DATA,"|",2)
 I TYP'="ZE" S TXT="Type of Diet Order not ZE as expected." Q
 I $E(DATA1,1,3)'="ZQT" S TXT="Message not ZQT as expected." Q
 S QUA=$P(DATA1,"|",3),A1=+QUA,A2=$E($P(QUA,"&",2),1),A3=$P(QUA,"^",2),FDG=$P(QUA,"^",3)
 S (TC,TK,TP,TW)=0
 S X=A1_A2_"/"_A3
 I FDG'="","XH"'[$E(FDG,1) S FDG=""
 S:'$E(FDG,2,99) FDG=""
 I FDG'="" S X=X_$S($E(FDG,1)="H":"X"_$E(FDG,2,99),1:FDG_"F")
 S QUA=X,A2=A2_"/"_$P(QUA,"/",2)
 S DIET=$P(DATA,"|",4),DIET=$E(DIET,4,$L(DIET)),TFCOM=$E($P(DATA,"|",5),1,160)
 S TT=+$P(DIET,"-",1) I 'TT S TXT="No internal entry number in coded identifier." Q
 S STR=+$P(DIET,"-",2) I 'STR S TXT="No Tubefeeding Product Strength." Q
 I $E($P(DIET,"^",3),1,5)'="99FHT" S TXT="No 99FHT code."
 S T(0)=$G(^FH(118.2,+TT,0))
 S A3=$P(A2,"/",2),A2=$P(A2,"/",1)
 I $E($P(T(0),"^",3),$L($P(T(0),"^",3)))?1"G" S:$E(A2,1)'="G" A1=A1*+$P(T(0),"^",3),A2="GRAM"
 F K=1:1:11 S S1=$P("KCAL CC ML OZ UNITS BOTTLES CANS PKG TBSP GMS GRAMS"," ",K) G:$P(S1,A2,1)="" F3
 G ERR
F3 S S1=$S(K=1:1,K<4:2,K=4:3,K=9:5,K>9:6,1:4),A2=$P(A3,"X",1),A3=$P(A3,"X",2)
 G:A2'?1U.E ERR I $L(A2)=1,"DH"'[A2 G ERR
 S S2=$F("DAY QD QH HOUR HR BID TID Q2H Q3H Q4H Q6H QID",A2) G:'S2 ERR S S2=$S(S2<8:1,S2<19:2,S2<23:3,S2<27:4,S2<31:5,S2<35:6,S2<39:7,1:8)
 S QUA=A1_" "_$P("KCAL ML OZ UNITS TBSP GM"," ",S1),QUA=QUA_" "_$P($T(F6),";",S2+2)
 S:A3'="" QUA=QUA_" X "_(+A3)_" "_$S(A3["F":"fdgs",1:"hrs")
 I S1=1 S DX=$P(T(0),"^",4) G:'DX ERR  S TK=A1,TC=A1/DX*$S(STR=4:1,STR=3:1.333,STR=2:2,1:4)
 I S1=4 S DX=+$P(T(0),"^",3) G:'DX ERR S TC=A1*DX*$S(STR=4:1,STR=3:1.333,STR=2:2,1:4)
 S:S1=2 TC=A1 S:S1=3 TC=A1*29.5 S:S1=5 TC=A1*15 I S1=6 S TC=0,A3=0 G C1
ML I 'A3 S A3=$P("1,24,2,3,12,8,6,4",",",S2) G C1
 I A3'["F" S A3=$S(S2=1:1,S2=2:A3,S2=3:2,S2=4:3,S2=5:A3\2,S2=6:A3\3,S2=7:A3\4,1:A3\6)
 E  S:S2=1 A3=1
C1 S TC=$J(TC*A3,0,0)
 I TC>5000 S TXT="WARNING: Total Amount should be between 0 to 5000 ml."  Q
 S:TC'<1 TP=$S(STR=4:TC,STR=3:TC*.75,STR=2:TC/2,1:TC/4),TP=$J(TP,0,0),TW=TC-TP
 I S1'=1!(S1'=6) S TK="",DX=$P(T(0),"^",4) I DX S TK=DX*TP,TK=$J(TK,0,0)
 S $P(TUN(TT),"^",1,6)=TT_"^"_STR_"^"_QUA_"^"_TP_"^"_TW_"^"_TK,NO=NO+1
 Q
ERR S TXT="Wrong Interval/Duration." Q
F6 ;;per Day;per Hour;Twice a Day;Three times a Day;Every 2 Hours;Every 3 Hours;Every 4 Hours;Every 6 Hours
