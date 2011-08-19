FHDMP3 ; HISC/REL/NCA - Patient Data Log (cont) ;4/30/92  10:15 
 ;;5.5;DIETETICS;;Jan 28, 2005
 D:$Y>(S1-4) HDR^FHDMP G:QT="^" KIL^FHDMP W !,LN,!?19,"S U P P L E M E N T A L   F E E D I N G S" S LST=1
 I SDT F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"SF",KK)) Q:KK<1  S D1=$P(^(KK,0),"^",2) Q:D1=""!(D1'<SDT)  S LST=KK
 S CT=0 F NO=LST-1:0 S NO=$O(^FHPT(FHDFN,"A",ADM,"SF",NO)) Q:NO<1  I $D(^(NO,0)) S X=^(0) D:$Y>(S1-10) HDR^FHDMP G:QT="^" KIL^FHDMP D LIS
 I 'CT W !!,"No Supplemental Feedings for this Admission"
 W ! G ^FHDMP4
LIS S CT=CT+1 W !!,"Order: ",?11,NO S Y=$P(X,"^",4) W ?40,"Menu: ",$P($G(^FH(118.1,+Y,0)),"^",1)
 S Y=$P(X,"^",2) W !,"Ordered:   " D DTP S Y=$P(X,"^",3) W ?40,"By:   ",$P($G(^VA(200,+Y,0)),"^",1)
 S Y=$P(X,"^",30) W !,"Reviewed:  " D DTP S Y=$P(X,"^",31) W ?40,"By:   ",$P($G(^VA(200,+Y,0)),"^",1)
 S Y=$P(X,"^",32) W !,"Cancelled: " D DTP S Y=$P(X,"^",33) W ?40,"By:   ",$P($G(^VA(200,+Y,0)),"^",1)
 S Y=$P(X,"^",29) W !,"Type: ",?11,$S(Y="D":"Dietary",Y="T":"Therapeutic",1:"") S Y=$P(X,"^",34) W ?40,"Diet Associated: ",$S(Y="Y":"Yes",1:"No")
 K N S L=4 F K1=1:1:3 S K=0,N(K1)="" F K2=1:1:4 S Z=$P(X,"^",L+1),Q=$P(X,"^",L+2),L=L+2 I Z'="" S:'Q Q=1 S:N(K1)'="" N(K1)=N(K1)_"; " S N(K1)=N(K1)_Q_" "_$P($G(^FH(118,Z,0)),"^",1)
 F K1=1:1:3 I N(K1)'="" W !,$P("10 Am; 2 Pm; 8 Pm",";",K1),?8,$E(N(K1),1,52)
 Q
DTP ; Printable Date/Time
 Q:Y<1  W $J(+$E(Y,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(Y,4,5))_"-"_$E(Y,2,3)
 I Y["." S %=+$E(Y_"0",9,10) W $J($S(%>12:%-12,1:%),3)_":"_$E(Y_"000",11,12)_$S(%<12:"am",%<24:"pm",1:"m")
 K % Q
