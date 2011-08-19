FHDMP2 ; HISC/REL/NCA/FAI - Patient Data Log (cont) ;10/19/04  14:38
 ;;5.5;DIETETICS;;Jan 28, 2005
 S LST=1 D:$Y>(S1-4) HDR^FHDMP G:QT="^" KIL^FHDMP W !,LN,!?29,"D I E T   O R D E R S"
 I '$D(^FHPT(FHDFN,"A",ADM,"DI")) W !!,"No Diet Orders for this Admission",! G ^FHDMP3
 I SDT F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"DI",K)) Q:K<1  S D1=$P(^(K,0),"^",9) Q:D1=""!(D1'<SDT)  S LST=K
 F FHORD=LST-1:0 S FHORD=$O(^FHPT(FHDFN,"A",ADM,"DI",FHORD)) Q:FHORD<1  I $D(^(FHORD,0)) S X=^(0) D:$Y>(S1-6) HDR^FHDMP G:QT="^" KIL^FHDMP D LIS
 W !
 S LST=1 D:$Y>(S1-3) HDR^FHDMP G:QT="^" KIL^FHDMP W !,LN,!?21,"D I E T   O R D E R   S E Q U E N C E",!
 I SDT F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"AC",K)) Q:K=""!(K'<SDT)  S LST=K
 S CT=0 F KK=LST-.0001:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1  S FHORD=$P(^(KK,0),"^",2) D:$Y>(S1-2) HDR^FHDMP G:QT="^" KIL^FHDMP D T1
 I 'CT W !!,"No Diet Order Sequence for this Admission",!
 W ! G ^FHDMP3
LIS S COM=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,1))
 S FHOR=$P(X,"^",2,6),FHLD=$P(X,"^",7)
 W !!,"Order: ",?12,FHORD S Y=$P(X,"^",9) W ?18,"Effective: " D DTP S Y=$P(X,"^",10) W ?53,"Expires: " D DTP
 S Y=$P(X,"^",11) W !,"Ordered by: ",?12,$P($G(^VA(200,+Y,0)),"^",1) S Y=$P(X,"^",12) W ?53,"Ordered: " D DTP
 D ORD W !,"Diet: ",?12 I $L(Y)<66 W Y
 E  W $P(Y,",",1,3),!?11,$P(Y,",",4,5)
 W:COM'="" !,"Comment: ",COM
 S Y=$P(X,"^",13) W !,"Prod. Diet: ",?12,$P($G(^FH(116.2,+Y,0)),"^",1)
 S Y=$P(X,"^",8) W ?53,"Service: ",$S(Y="T":"Tray",Y="C":"Cafeteria",Y="D":"Dining Room",1:"")
 I FHLD'="" S Y=$P(X,"^",19) I Y W !,"Canc. By: ",?12,$P($G(^VA(200,+Y,0)),"^",1) S Y=$P(X,"^",18) W:Y'="" ?53,"Canc.  : " D DTP
 Q
ORD S Y="" I FHLD'="" S FHDU=";"_$P(^DD(115.02,6,0),"^",3),%=$F(FHDU,";"_FHLD_":") Q:%<1  S Y=$P($E(FHDU,%,999),";",1) Q
 F A1=1:1:5 S D3=$P(FHOR,"^",A1) I D3 S:Y'="" Y=Y_", " S Y=Y_$P(^FH(111,D3,0),"^",7)
 Q
T1 S CT=CT+1,Y=KK W ! D DTP W ?25,"Order: ",FHORD Q
DTP ; Printable Date/Time
 Q:Y<1  W $J(+$E(Y,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(Y,4,5))_"-"_$E(Y,2,3)
 I Y["." S %=+$E(Y_"0",9,10) W $J($S(%>12:%-12,1:%),3)_":"_$E(Y_"000",11,12)_$S(%<12:"am",%<24:"pm",1:"m")
 K % Q
