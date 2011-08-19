FHORX1C ; HISC/REL/NCA/RVD - List Dietetic Events ;11/15/00  14:38
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
 F TYP="L","D","M","I","T","O","P","S","F" I $D(PP(TYP)) S NXT="" F  S NXT=$O(PP(TYP,NXT)) Q:NXT=""  S ADM=$P(NXT,"~",1),FHORD=$P(NXT,"~",2),ACT=$P(PP(TYP,NXT),"^",1),TXT=$P(PP(TYP,NXT),"^",2),CLK=$P(PP(TYP,NXT),"^",3) D @TYP
 Q
L ; Location
 S EVT=$S(ACT="A":"Admit to ",ACT="T":"Transfer from ",1:"Discharge from ")
 I "DT"[ACT S X1=$P(TXT,"~",1) S:X1 X1=$P($G(^FH(119.6,X1,0)),"^",1) S EVT=EVT_X1 S X1=$P(TXT,"~",2) S:X1 X1=$P($G(^DG(405.4,X1,0)),"^",1) S:X1'="" EVT=EVT_" "_X1
 S:ACT="T" EVT=EVT_" to "
 I "AT"[ACT S X1=$P(TXT,"~",3) S:X1 X1=$P($G(^FH(119.6,X1,0)),"^",1) S EVT=EVT_X1 S X1=$P(TXT,"~",4) S:X1 X1=$P($G(^DG(405.4,X1,0)),"^",1) S:X1'="" EVT=EVT_" "_X1
 G LNE
D ; Diet
 S X=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)),COM=$G(^(1)) Q:X=""  D CUR S EVT="Diet: "_Y
 I FHLD="" S X9=$P(X,"^",8) I X9'="",X9'=TC S EVT=EVT_"  ("_$S(X9="T":"Tray",X9="D":"Dining Room",1:"Cafe")_")"
 S:COM'="" EVT=EVT_", "_COM D LNE
 S X2="" F NX=0:0 S NX=$O(^FHPT(FHDFN,"A",ADM,"AC",NX)) Q:NX<1!(NX>TIM)  S X2=$P(^(NX,0),"^",2)
 Q:X2=FHORD!(X2="")  S X=$G(^FHPT(FHDFN,"A",ADM,"DI",X2,0)) D CUR
 S EVT="Old:  "_Y G LNE
I ; Isolation
 S EVT="IS: "_$P($G(^FH(119.4,FHORD,0)),"^",1)
 S:ACT="C" EVT=EVT_" Cancelled" G LNE
T ; Tubefeed
 S EVT=""
 F K1=0:0 S K1=$O(^FHPT(FHDFN,"A",ADM,"TF",FHORD,"P",K1)) Q:K1<1  S X3=$G(^(K1,0)),TUN=$P(X3,"^",1),XX=$G(^FH(118.2,TUN,0)) D CALC^FHORX3 S:EVT'="" EVT=EVT_", " S EVT=EVT_P2_" "_$P(XX,"^",1)
 S COM=$P($G(^FHPT(FHDFN,"A",ADM,"TF",FHORD,0)),"^",5) I COM'="" S EVT=EVT_", "_COM
 S EVT="TF: "_EVT S:ACT="C" EVT=EVT_" Cancelled"
 G LNE
O ; Additional Order
 S Y=$P($G(^FHPT(FHDFN,"A",ADM,"OO",FHORD,0)),"^",3) Q:Y=""
 S EVT="AO: "_Y S:ACT="C" EVT=EVT_" Cancelled" G LNE
P ; Food Preferences
 S EVT="FP: "_TXT D CLK G LNE
M ; Message
 S EVT="Msg: "_TXT G LNE
F ; Suppl. feedings P30
 S Z=$G(^FHPT(FHDFN,"A",ADM,"SF",+FHORD,0)) Q:Z=""  S SP=$P(Z,"^",4)
 S EVT="SF: "_$P($G(^FH(118.1,+SP,0)),"^",1) S:ACT="C" EVT=EVT_" Cancelled" G LNE
S ; Standing Orders
 S Z=$G(^FHPT(FHDFN,"A",ADM,"SP",+FHORD,0)) Q:Z=""  S SP=$P(Z,"^",2),MEAL=$P(Z,"^",3),QTY=$P(Z,"^",8)
 S EVT="SO: "_$S(QTY:QTY,1:1)_" "_$P($G(^FH(118.3,+SP,0)),"^",1)_" ("_MEAL_")" S:ACT="C" EVT=EVT_" Cancelled" G LNE
CUR S Y="" Q:X=""  S FHOR=$P(X,"^",2,6),FHLD=$P(X,"^",7)
 I FHLD'="" S FHDU=";"_$P(^DD(115.02,6,0),"^",3),%=$F(FHDU,";"_FHLD_":") Q:%<1  S Y=$P($E(FHDU,%,999),";",1) Q
 F A1=1:1:5 S D3=$P(FHOR,"^",A1) I D3 S:Y'="" Y=Y_", " S Y=Y_$P(^FH(111,D3,0),"^",7)
 Q
CLK ; Get entered clerk
 I CLK S EVT=EVT_" By: "_$P($G(^VA(200,+CLK,0)),"^",1)
 Q
LNE ; Break line if longer than 48 chars
 I $Y>(IOSL-6) D HDR^FHORX1A W !
 I $L(EVT)<49 G EX
 F KK=49:-1:4 Q:$E(EVT,KK)?1P
 I KK=4 S KK=48 W !?12,$E(EVT,1,48)
 E  W !?12,$E(EVT,1,KK-1)
 S EVT="    "_$E(EVT,KK+1,999) G LNE
EX W !?12,EVT Q
