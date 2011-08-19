FHORD1 ; HISC/REL/NCA - Diet Order ;3/28/01  10:28
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
F0 S ALL=1 D ^FHDPA G:'DFN KIL G:'FHDFN KIL
 I $G(ADM)="" W *7,!!," NOT CURRENTLY AN INPATIENT" D KIL Q
 D D0 G:'DFN KIL G:'FHDFN KIL D PROC
 S DTE="" D ^FHORD1A I FHWF,DTE S (SDT,EDT)=DTE,WKD="",SERV="L" D EL^FHWOR3 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG
 S TF=$P(^FHPT(FHDFN,"A",ADM,0),"^",4) I TF W !!,"An ACTIVE Tubefeeding Order Exists!" S FHD="Y" D DIS^FHORT2,ASK^FHORT2 D:FHD="Y" CAN^FHORT2
 G F0
D0 ; Process Diet Order
 D CUR^FHORD7 W !!,"Current Diet: ",$S(Y'="":Y,1:"No current order")
 D ALG^FHCLN W !!,"Allergies: ",$S(ALG="":"None on file",1:ALG)
 I FHORD S COM=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,1)) I COM'="" W !,"Comment: ",COM
 D NOW^%DTC S NOW=% K %,%H,%I D FUT
C0 I CT W *7 R !!,"A new order with no expiration date will CANCEL these diets.",!!,"Do you wish to CONTINUE? (Y/N): ",X:DTIME G:'$T!(X="^") AB S:X="" X="^" D TR^FH G:$P("NO",X,1)="" AB I $P("YES",X,1)'="" W *7,"  Answer YES or NO" G C0
F7 S WRD=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8),SVC="" I WRD>0 S SVC=$P($G(^FH(119.6,WRD,0)),"^",10)
 S:SVC="" SVC="T" I $L(SVC)=1 S TYP=SVC G F8
 S N1=$P(^FHPT(FHDFN,"A",ADM,0),"^",5) S:SVC'[N1 N1=""
 S X="Tray^Cafeteria^Dining Room" W !!,$P(X,"^",$F("TCD",$E(SVC,1))-1),$S($L(SVC)=2:" or ",1:", "),$P(X,"^",$F("TCD",$E(SVC,2))-1)
 W:$L(SVC)=3 " or ",$P(X,"^",$F("TCD",$E(SVC,3))-1) W ": ",$S(N1="":$E(SVC,1),1:N1),"// "
 R X:DTIME G:'$T!(X="^") AB S:X="" X=$S(N1="":$E(SVC,1),1:N1) S X=$E(X,1) D TR^FH
 I SVC'[X W *7,!,"Enter one of the given type of services." G F7
 S TYP=X
 I 'FHORD!(N1="")!(N1=TYP) G F8
 S N1=^FHPT(FHDFN,"A",ADM,"DI",FHORD,0) I "^^^^"[$P(N1,"^",2,6) G F8
R1 R !!,"Retain Current Diet? N// ",Y:DTIME G:'$T!(Y="^") AB S:Y="" Y="N" S X=Y D TR^FH S Y=X I $P("YES",Y,1)'="",$P("NO",Y,1)'="" W *7,"  Answer YES or NO" G R1
 G:Y?1"N".E F8 S FHOR=$P(N1,"^",2,6),(D3,D4)=0,D2=$P(N1,"^",10)
 S D1=NOW G F10
F8 K DI S N1=0 G:FHWF=2 F1 R !!,"Order a REGULAR Diet? (Y/N) ",Y:DTIME G:'$T!(Y="^") AB S:Y="" Y="^" S X=Y D TR^FH S Y=X I $P("YES",Y,1)'="",$P("NO",Y,1)'="" W *7,"  Answer YES or NO" G F8
 G:Y'?1"Y".E F1 S Y(0)=^FH(111,1,0),PREC=$P(Y(0),U,4),DI(PREC)="1^"_Y(0),N1=1 G F5
F1 W ! K DIC S DIC="^FH(111,",DIC(0)="AEQMZ" S DIC("S")="I '$D(^(""I""))&(Y>1)" D ^DIC K DIC G AB:X[U!$D(DTOUT),F5:X="",F1:Y<1
 S PREC=$P(Y(0),U,4) I PREC,$D(DI(PREC)) W *7,!!,"This conflicts with ",$P(DI(PREC),"^",2),! G F1
 S N1=N1+1,DI(PREC)=+Y_"^"_Y(0) G F5:+Y=1,F1:N1<5 W *7,!!,"You have now selected the maximum of 5 Diet Modifications!"
F5 G:'N1 AB W !!,"You have selected the following Diet:",!
 S (D3,D4)=0 F D0=0:0 S D0=$O(DI(D0)) Q:D0=""  W !?5,$P(DI(D0),U,2) S:$P(DI(D0),U,4)="Y" D3=1 S:$P(DI(D0),U,7)="Y" D4=1
F9 G:FHWF=2 F6 R !!,"Is this Correct? Y// ",Y:DTIME G:'$T!(Y="^") AB S:Y="" Y="Y" S X=Y D TR^FH S Y=X
 I $P("YES",Y,1)'="",$P("NO",Y,1)'="" W *7,!,"  Answer YES to accept diet list; NO to select diets again" G F9
 I Y'?1"Y".E K DI S N1=0 W !!,"Select new diets ..." G F1
F6 S COM="" ;R !!,"Comment: ",COM:DTIME G:'$T!(COM["^") AB I COM'?.ANP W *7," ??" G F6
 I $L(COM)>80!(COM?1"?".E) W *7,!,"Enter any special instructions of up to 80 characters!" G F6
 D GETD^FHORD71 G:'D1 AB
 S FHOR="^^^^",FHEVTX="",N1=0 F D0=0:0 S D0=$O(DI(D0)) Q:D0=""  S N1=N1+1,$P(FHOR,U,N1)=+DI(D0),FHEVTX=FHEVTX_", "_$P(DI(D0),U,8)
 ; [SEE NOIS SDC-0402-62498] S FHDPATT=$O(^FH(111.1,"AB",FHOR,0)) I FHDPATT'="" I $G(^FH(111.1,FHDPATT,"I"))="Y" W !!,"  ** INACTIVE DIET PATTERN! **" G AB
 I '$O(^FH(111.1,"AB",FHOR,0)),$P($G(^FH(119.9,1,4)),"^",2)="Y" S EVT="M^O^^No Diet Pattern ("_$E(FHEVTX,3,999)_")" D ^FHORX
F10 S FHLD="" W:FHWF'=2 !!,"... Diet Order Accepted"
 Q
PROC ; Process & file order
 D STR^FHORD7,^FHORDR D:D4 POST^FHORD7 Q
AB W *7,!!,"Diet Order for this Patient is UNCHANGED -- No order entered!",! S (DFN,FHDFN)="" Q
KIL ; Final variable kill
 K %,%H,%I,%T,%DT,A1,A2,ADM,ALL,C,COM,CORD,CT,D0,D1,D2,D3,D4,DA,FHDFN,DFN,DTP,DI,DIC,FHDU,FHD,FHLD,FHOR,FHPAR,FHWF,FHPV,FLG,I,J,K,KK,N1,NOW,FHORD,FHSAV,FHSAV1,FHDAY
 K FHK,FHK1,FHOE,FHOLD,FHMSG,FHNEW,K1,K2,KK1,LC,M,PREC,SVC,TYP,X,X1,X2,Y,WRD,WARD,TF,QUA,STR,TUN,XMKK,Z Q
FUT ; List future diets
 S CT=0,CORD=FHORD F KK=NOW:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1  S FHORD=$P(^(KK,0),"^",2) D T1
 S FHORD=CORD Q
T1 Q:'$D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0))  S DTP=KK D DTP^FH,C2^FHORD7
 I 'CT W !!,"Future Diet Orders:",!
 S CT=CT+1 W !?5,DTP,?25,Y Q
