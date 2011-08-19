FHORX3 ; HISC/REL/NCA/RTK - List Dietetic Events ;2/23/01  09:17
 ;;5.5;DIETETICS;;Jan 28, 2005
 S Z=$G(^FH(119.8,DA,0)) Q:Z=""  S D1=$P(Z,"^",2),FHDFN=$P(Z,"^",3),ADM=$P(Z,"^",4),TYP=$P(Z,"^",5),ACT=$P(Z,"^",6),FHORD=$P(Z,"^",7),TXT=$P(Z,"^",8),CLK=$P(Z,"^",9)
 I TYP="Z" D OUTPEV Q
 I "DITOS"[TYP,'FHORD Q
 G L:TYP="L",D:TYP="D",M:TYP="M",I:TYP="I",T:TYP="T",O:TYP="O",P:TYP="P",S:TYP="S",F:TYP="F" Q  ;P30
L ; Location
 S EVT=$S(ACT="A":"Admit to ",ACT="T":"Transfer from ",1:"Discharge from ")
 I "DT"[ACT S X1=$P(TXT,"~",1) S:X1 X1=$P($G(^FH(119.6,X1,0)),"^",1) S EVT=EVT_X1 S X1=$P(TXT,"~",2) S:X1 X1=$P($G(^DG(405.4,X1,0)),"^",1) S:X1'="" EVT=EVT_" "_X1
 S:ACT="T" EVT=EVT_" to "
 I "AT"[ACT S X1=$P(TXT,"~",3) S:X1 X1=$P($G(^FH(119.6,X1,0)),"^",1) S EVT=EVT_X1 S X1=$P(TXT,"~",4) S:X1 X1=$P($G(^DG(405.4,X1,0)),"^",1) S:X1'="" EVT=EVT_" "_X1
 G EX
D ; Diet
 Q:'FHORD  Q:'$D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0))
 D C2^FHORD7 S EVT="Diet: "_Y G:FHLD'="" EX
 S X9=$P(X,"^",8) S:X9'="" EVT=EVT_"  ("_$S(X9="T":"Tray",X9="D":"Dining Room",1:"Cafe")_")" G EX
I ; Isolation
 S EVT="Isolation: "_$P($G(^FH(119.4,FHORD,0)),"^",1)
 S:ACT="C" EVT=EVT_" Cancelled" G EX
T ; Tubefeed
 S EVT=""
 F K1=0:0 S K1=$O(^FHPT(FHDFN,"A",ADM,"TF",FHORD,"P",K1)) Q:K1<1  S X3=$G(^(K1,0)),TUN=$P(X3,"^",1),XX=$G(^FH(118.2,TUN,0)) D CALC S:EVT'="" EVT=EVT_", " S EVT=EVT_P2_" "_$P(XX,"^",1)
 S COM=$P($G(^FHPT(FHDFN,"A",ADM,"TF",FHORD,0)),"^",5) I COM'="" S EVT=EVT_", "_COM
 S EVT="TF: "_EVT S:ACT="C" EVT=EVT_" Cancelled" G EX
 Q
O ; Additional Order
 S Y=$P($G(^FHPT(FHDFN,"A",ADM,"OO",FHORD,0)),"^",3) Q:Y=""
 S EVT="Add. Order: "_Y S:ACT="C" EVT=EVT_" Cancelled" G EX
P ; Food Preferences
 S EVT="Pref: "_TXT_$S(CLK:" By: "_$P($G(^VA(200,+CLK,0)),"^",1),1:"") G EX
M ; Message
 S EVT="Msg: "_TXT G EX
S ; Standing Orders
 S Z=$G(^FHPT(FHDFN,"A",ADM,"SP",+FHORD,0)) Q:Z=""  S SP=$P(Z,"^",2),MEAL=$P(Z,"^",3),QTY=$P(Z,"^",8)
 S EVT="Std. Order: "_$S(QTY:QTY,1:1)_" "_$P($G(^FH(118.3,+SP,0)),"^",1)_" ("_MEAL_")" S:ACT="C" EVT=EVT_" Cancelled" G EX
 Q
F ; Suppl. feedings P30
 S Z=$G(^FHPT(FHDFN,"A",ADM,"SF",+FHORD,0)) Q:Z=""  S SP=$P(Z,"^",4)
 S EVT="Supp. Fdg. Menu: "_$P($G(^FH(118.1,+SP,0)),"^",1) S:ACT="C" EVT=EVT_" Cancelled" G EX
 Q
EX W ! D DTP W ?20,EVT Q
DTP ; Printable Date/Time
 Q:D1<1  W $J(+$E(D1,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(D1,4,5))_"-"_$E(D1,2,3)
 I D1["." S %=+$E(D1_"0",9,10) W $J($S(%>12:%-12,1:%),3)_":"_$E(D1_"000",11,12)_$S(%<12:"am",%<24:"pm",1:"m")
 K % Q
CALC ; Figure # of units for TF
 I $E($P(XX,"^",3),$L($P(XX,"^",3)))="G" D GRM Q
 S TU=$P(X3,"^",4)/$S(+$P(XX,"^",3):+$P(XX,"^",3),1:9999),TW=$P(X3,"^",5)
 I TW<6 S TU=TU+.75\1,P2=TU,P2=P2_" "_$S(P2>1:$P(XX,"^",2)_"S",1:$P(XX,"^",2)) Q
 S TU=TU+.2*4\1/4,P2=$S(TU<1:"",1:TU\1) I TU#1 S:P2 P2=P2_"-" S P3=TU#1,P2=P2_$S(P3<.3:"1/4",P3<.6:"1/2",1:"3/4")
 S P2=P2_" "_$S(P2>1:$P(XX,"^",2)_"S",1:$P(XX,"^",2))
 Q
GRM ; Calculate for Grams
 S X=$P(X3,"^",3) D FIX^FHORT10 S Z5="" F LL=1:1:$L(X) I $E(X,LL)'=" " S Z5=Z5_$E(X,LL)
 S Z5=$P(Z5,"/",2),Z5=$P(Z5,"X",2)
 I 'Z5 S Z5=$P("1,24,2,3,12,8,6,4",",",K) G G1
 I Z5'["F" S Z5=$S(K=1:1,K=2:Z5,K=3:2,K=4:3,K=5:Z5\2,K=6:Z5\3,K=7:Z5\4,1:Z5\6)
 E  S:K=1 Z5=1
G1 S TU=+$P(X3,"^",3)*Z5
 S TU=TU/$S(+$P(XX,"^",3):+$P(XX,"^",3),1:9999)
 S P2=$S(TU<1:"",1:TU\1) I P2="" S TU=TU+.95\1,P2=TU
 I TU#1 S:P2 P2=P2_"-" S TU=TU#1,P2=P2_$S(TU<.3:"1/4",TU<.6:"1/2",1:"3/4")
 S P2=P2_" "_$S(P2>1:$P(XX,"^",2)_"S",1:$P(XX,"^",2))
 Q
OUTPEV ; Display outpatient events
 S EVT=TXT D EX
 Q
