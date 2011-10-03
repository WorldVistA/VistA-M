FHPRC1 ; HISC/REL/NCA - Menu Cycle Utilities ;3/28/95  08:16
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Find current cycle & day
 S %DT="X",X="T" D ^%DT S X1=+Y K %DT
E1 ; Find based upon X1 date
 S FHCY=-1 F K=0:0 S K=$O(^FH(116,"AB",K)) Q:K<1!(K>X1)  S FHCY=$O(^(K,0)),X2=K
 Q:FHCY<1  S Y=^FH(116,FHCY,0),K1=$P(Y,"^",2) D ^%DTC K %T,%Y
 S FHDA=X+1#K1 S:'FHDA FHDA=K1 Q
EN2 ; Check validity of Production Code string in Menu
 D TR^FH I $E(X,$L(X))=" " S X=$E(X,1,$L(X)-1)
 S (X9,XX)="" I $E(X,1,3)="ALL" D V3 G KIL
 F X4=1:1 Q:$P(X," ",X4,99)=""  S X6=0,X1=$P(X," ",X4) D V1 I 'X6 S:XX'="" XX=XX_" " S XX=XX_X1
KIL D SRT S X=XX K:X="" X K X1,X2,X3,X4,X5,X6,X8,X9,XX Q
V1 I X1="" S X6=1 Q
 S X2=$P(X1,";",1) S:X2="" X2=";" I '$D(^FH(116.2,"C",X2)) W *7,!?5,X2," not a valid Production Diet code" S X6=1
 I X9[X2 W *7,!?5,X2," code used more than once" S X6=1
 S X9=X9_" "_X2,X8="*",X5=2,X2=$P(X1,";",X5) I X2'="" D V2 S X5=3,X2=$P(X1,";",X5) I X2'="" D V2 S X5=4
 Q:$P(X1,";",X5,99)=""  W *7,!?5,"Extra specifications in ",X1 S X6=1 Q
V2 S X3=$E(X2,1) I X3=""!("CT"'[X3) W *7,!?5,"Illegal Tray/Cafe specification in ",X1 S X6=1
 I X8=X3 W *7,!?5,X3," Tray/Cafe used more than once" S X6=1
 S X8=X3,X3=$E(X2,2,99)
 I +X3'=X3!(X3>999)!(X3<0)!(X3?.E1"."2N.N) W *7,!?5,"Illegal percentage in ",X1 S X6=1
 Q
V3 I $E(X,4)="+" G ALL
 I $E(X,5)="" S XX="" W !?5,"No + after ALL" Q
 I $E(X,5)="+" G ALL
 W !?5,"Invalid ALL statement" S XX="" Q
ALL S (FHPD,XX)=""
 F  S FHPD=$O(^FH(116.2,"C",FHPD)) Q:FHPD=""  F LP=0:0 S LP=$O(^FH(116.2,"C",FHPD,LP)) Q:LP<1  I '$D(^FH(116.2,LP,"I")) S:XX'="" XX=XX_" " S XX=XX_FHPD
 K LP,FHPD
 Q
SRT ; Sort and store Production Diet Code in print order
 K SR F LP=1:1 S CODE=$P(XX," ",LP) Q:CODE=""  S PD=$P(CODE,";",1) I PD'="" S Z=0,Z=$O(^FH(116.2,"C",PD,Z)) I Z D
 .S Z1=$P($G(^FH(116.2,+Z,0)),"^",6),Z1=$S(Z1<1:99,Z1<10:"0"_Z1,1:Z1)
 .S:'$D(SR(Z1_"~"_PD)) SR(Z1_"~"_PD)=CODE Q
 S (PD,ZZ)="" F  S ZZ=$O(SR(ZZ)) Q:ZZ=""  S Z=$G(SR(ZZ)) I Z'="" Q:$L(PD_" "_Z)>200  S:PD'="" PD=PD_" " S PD=PD_Z
 S XX=$S(PD'="":PD,1:"") K CODE,LP,PD,SR,Z,Z1,ZZ
 Q
EN3 ; Help Prompt for Production String
 W !!,"List Production Diet Codes separated by a single space"
 W !!,"Example:  LS;C25;T30 RG ME;T20.1 CR;C50"
 W !,"          --            Production Diet Code"
 W !,"             -          T = Tray or C = Cafeteria"
 W !,"              --        % of T or C census receiving recipe (max. 1 dec. place)"
 W !!,"Production Diets listed without a specification (e.g., RG)"
 W !,"are assumed to be 100% of census.",!
 W !,"ALL + will add all production diet codes.",! Q
