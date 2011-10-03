FHASP2 ; HISC/REL - Nutrition Profile (cont.) ;10/4/93  11:44
 ;;5.5;DIETETICS;**1**;Jan 28, 2005
 S X=$P($G(^DGPM(ADM,0)),"^",10) W !,"Adm. Dx: ",$E(X,1,27)
 S X(0)=$G(^FHPT(FHDFN,"A",ADM,0))
F1 D CUR^FHORD7 W !!,"Current Diet: ",$S(Y'="":Y,1:"No current order")
 I Y'="",FHORD>0 I $D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,1)) S COM=^(1) W:COM'="" !,"Comment: ",COM
 S TYP=$P(X,"^",8) I TYP'="" W !,"Service: ",$S(TYP="T":"Tray",TYP="D":"Dining Room",1:"Cafeteria")
 S DTP=$P(X(0),"^",3) I DTP D DTP^FH W !,"Expires: ",DTP
 S TF=$P(X(0),"^",4) G:TF<1 F2
 S Y=^FHPT(FHDFN,"A",ADM,"TF",TF,0)
 S DTP=$P(Y,"^",1),COM=$P(Y,"^",5),TQU=$P(Y,"^",6),CAL=$P(Y,"^",7)
 D DTP^FH W !!,"Tubefeed Ordered: ",DTP
 F TF2=0:0 S TF2=$O(^FHPT(FHDFN,"A",ADM,"TF",TF,"P",TF2)) Q:TF2<1  S XY=^(TF2,0) D LP
 W !,"Total Quantity: ",TQU," ml",?42,"Total KCAL: ",CAL
 W:COM'="" !,"Comment: ",COM
F2 S NO=$P(X(0),"^",7),Y=$S('NO:"",1:^FHPT(FHDFN,"A",ADM,"SF",NO,0))
 S L=$P(Y,"^",4) W !!,"Supplemental Feeding: ",$S('L:"No Order",1:$P(^FH(118.1,L,0),"^",1)) G:'NO F3
 S DTP=$P(Y,"^",30) D DTP^FH W ?50,"Reviewed: ",DTP
 S L=4 F K1=1:1:3 S K=0,N(K1)="" F K2=1:1:4 S Z=$P(Y,U,L+1),Q=$P(Y,U,L+2),L=L+2 I Z'="" S:'Q Q=1 S:N(K1)'="" N(K1)=N(K1)_"; " S N(K1)=N(K1)_Q_" "_$P(^FH(118,Z,0),"^",1)
 F K1=1:1:3 I N(K1)'="" W !?5,$P("10am; 2pm; 8pm",";",K1),":",?13,N(K1)
F3 K CAL,TF2,TQU,X(0),XY Q
LP S TUN=$P(XY,"^",1),STR=$P(XY,"^",2),QUA=$P(XY,"^",3)
 W !?3,$P($G(^FH(118.2,TUN,0)),"^",1),", ",$S(STR=4:"Full",STR=1:"1/4",STR=2:"1/2",1:"3/4")," Str., ",QUA Q
