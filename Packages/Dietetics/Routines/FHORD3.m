FHORD3 ; HISC/REL/NCA - Withhold Service ;8/20/96  09:09 ;
 ;;5.5;DIETETICS;;Jan 28, 2005;
F0 S ALL=0 D ^FHDPA G:'DFN KIL^FHORD1 G:'FHDFN KIL^FHORD1
 D NOW^%DTC S NOW=% D CUR,FUT^FHORD1
 W !!,"Place patient on NPO/HOLD-TRAY." D F5 Q:'$D(DFN)  Q:'$D(FHDFN)  D F7 W !!,"... done" G F0
F5 ; Process NPO
 S D3=1 D GETD^FHORD71 G:'D1 AB
F6 R !!,"Comment: ",COM:DTIME G:'$T!(COM[U) AB I COM'?.ANP W *7," ??" G F6
 I $L(COM)>80!(COM?1"?".E) W *7,!,"Enter comment of up to 80 characters!" G F6
 Q
F7 ; File NPO
 S FHOR="^^^^",FHLD="N",TYP="",D4=0 D STR^FHORD7
 G KIL^FHORD1
EN2 ; Cancel Withhold Order
 D NOW^%DTC S NOW=%,DT=%\1
 S ALL=0 D ^FHDPA G:'DFN KIL G:'FHDFN KIL D CUR S OLD=FHLD
 S (A2,CT)=0 F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1!(KK'<NOW)  S A2=KK
 S XT="" K N F KK=A2-.000001:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1  S FHORD=$P(^(KK,0),"^",2) D T1
 I 'CT W !!,"No WITHHOLD Orders to Cancel" G KIL
C0 R !!,"Cancel Which Order #? ",X:DTIME G:'$T!("^"[X) AB I X'?1N.N!(X<1)!(X>CT) W *7," Enter # of Order to Cancel" G C0
 S FHORD=$P(XT,",",X),KK=N(FHORD) D T0 G KIL
T0 ; Update cancelled NPO
 S X=^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),D1=$P(X,"^",9),D2=$S(D1'>NOW:NOW,1:D1)
 S $P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",10)=D2
 S $P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",18,19)=D2_"^"_DUZ
 S:FHWF'=2 FHORN=$P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",14)
 F K9=KK-.000001:0 S K9=$O(^FHPT(FHDFN,"A",ADM,"AC",K9)) Q:K9<1  I $P(^(K9,0),"^",2)=FHORD S D1=K9 D S0
 D UPD^FHORD7 W:FHWF'=2 "  ... done" Q:FHWF=2  D CUR
 I OLD'="","^^^^"'[FHOR S D1=NOW D ^FHORD1A
 Q
S0 ; Set AC cross-ref data field
 S X2=D1+.0000001,D2=$O(^FHPT(FHDFN,"A",ADM,"AC",D1)) S:D2<1 D2=""
S1 S A2=0 F A1=0:0 S A1=$O(^FHPT(FHDFN,"A",ADM,"AC",A1)) Q:A1<1!(A1'<X2)  S A2=A1
 I A2 S X2=A2,A2=$P(^FHPT(FHDFN,"A",ADM,"AC",A2,0),"^",2),X1=$P(^FHPT(FHDFN,"A",ADM,"DI",A2,0),"^",10) I X1'="",X1'>D1 G S1
 D:'A2 NOR S Z6=D1_"^"_A2 D ACR^FHORD71
 I X1'="",D2=""!(X1<D2) S D1=X1 G S0
S2 S X1="",A1=0 G S4
S3 S A1=$O(^FHPT(FHDFN,"A",ADM,"AC",A1)) G:A1="" S4 S X2=$P(^(A1,0),"^",2)
 I X2<1 D SK G S3
 I '$D(^FHPT(FHDFN,"A",ADM,"DI",X2,0)) D SK G S3
 S X2=^FHPT(FHDFN,"A",ADM,"DI",X2,0) I $P(X2,"^",2,8)'=$P(X1,"^",2,8) S X1=X2 G S3
 I $P(X1,"^",10)="" D SK G S3
 I $P(X2,"^",10),$P(X2,"^",10)'>$P(X1,"^",10) D SK G S3
 S X1=X2 G S3
S4 D OEU^FHORD71 Q
SK K ^FHPT(FHDFN,"A",ADM,"AC",A1) S Z6=-1 G ACR^FHORD71
NOR L +^FHPT(FHDFN,"A",ADM,"DI",0)
 I '$D(^FHPT(FHDFN,"A",ADM,"DI",0)) S ^FHPT(FHDFN,"A",ADM,"DI",0)="^115.02A^^"
 S X=^FHPT(FHDFN,"A",ADM,"DI",0),A2=$P(X,"^",3)+1,^(0)=$P(X,"^",1,2)_"^"_A2_"^"_($P(X,"^",4)+1) L -^FHPT(FHDFN,"A",ADM,"DI",0)
 S ^FHPT(FHDFN,"A",ADM,"DI",A2,0)=A2_"^^^^^^X^^"_D1_"^^"_DUZ_"^"_NOW,X="" Q
CUR D CUR^FHORD7 W !!,"Current Diet: ",$S(Y'="":Y,1:"No Current Order")
 Q:'FHORD  S X9=$P(X,"^",8) W:X9'="" " (",$S(X9="T":"Tray",X9="D":"Dining Room",1:"Cafe"),")" Q
T1 Q:'$D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0))!($D(N(FHORD)))  Q:$P(^(0),"^",7)=""  S P2=$P(^(0),"^",10)
 S DTP=KK D DTP^FH,C2^FHORD7
 I 'CT W !!," #      Effective            Expires           Order",!
 S CT=CT+1,XT=XT_FHORD_",",N(FHORD)=KK W !,$J(CT,2),"  ",DTP
 S DTP=P2 D:DTP DTP^FH W ?24,DTP,?47,Y Q
AB W *7,!!,"Withhold entry TERMINATED - No change!"
KIL K %,%H,%I,C,CT,DA,DG,DLB,DTP,I,K9,N,OLD,POP,P2,X9,XT G KIL^FHORD1
