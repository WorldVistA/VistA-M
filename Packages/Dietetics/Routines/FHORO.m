FHORO ; HISC/REL - Additional Orders ;2/22/95  10:06 ;
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter Order
 S ALL=0 D ^FHDPA G:'DFN KIL G:'FHDFN KIL D R1 G:'$D(DFN) KIL G:'$D(FHDFN) KIL D ORD G:'FHWF A0
 ; Set HL7
 D AO^FHWOR1,KIL I $D(MSG) D MSG^XQOR("FH EVSEND OR",.MSG) K MSG
A0 W "  ... done" Q
R1 ; Process Order
 D LIS
R2 R !!,"Additional Order: ",COM:DTIME G:'$T!(COM="")!(COM["^") AB I COM'?.ANP W *7," ??" G R2
 I COM?1."?" W *7,!,"Enter your dietetic request. Do not use ^ or ? in your response." G R2
 I $L(COM)>160 W *7,!,"Order not accepted! - Enter 1-160 character order" G R2
 Q:FHWF=2
R3 R !,"Ok to Enter Request? Y// ",YN:DTIME G AB:'$T!(YN["^") S:YN="" YN="Y" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G R3
 G:YN'?1"Y".E AB Q
ORD ; Set Order
 L +^FHPT(FHDFN,"A",ADM,"OO",0) S:'$D(^FHPT(FHDFN,"A",ADM,"OO",0)) ^FHPT(FHDFN,"A",ADM,"OO",0)="^115.06^^"
 S FHDR=$P(^FHPT(FHDFN,"A",ADM,"OO",0),"^",3)+1,$P(^(0),"^",3,4)=FHDR_"^"_FHDR L -^FHPT(FHDFN,"A",ADM,"OO",0)
 D NOW^%DTC S NOW=%
 S ^FHPT(FHDFN,"A",ADM,"OO",FHDR,0)=FHDR_"^"_NOW_"^"_COM_"^"_DUZ_"^A"
 S ^FHPT("AOO",FHDFN,ADM,FHDR)="" S EVT="O^O^"_FHDR D ^FHORX Q
AB W *7,!!,"Order entry is TERMINATED - No request entered!"
KIL K %,%H,%I,%T,A,C,CT,ADM,ALL,COM,DA,FHDFN,DFN,DTP,FHDR,FHPV,FHWF,G,K,I,NOW,POP,WARD,X,X1,X2,Y,YN Q
LIS D NOW^%DTC S X1=%,X2=-1 D C^%DTC S A=X
 S CT=0 W !!,"Additional Orders Last 24 Hours:",!
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"OO",K)) Q:K<1  S X=^(K,0) I $P(X,"^",2)'<A,$P(X,"^",5)'="X" D L1
 W:'CT !?5,"None Entered." Q
L1 S DTP=$P(X,"^",2),CT=1 D DTP^FH W !,DTP,?20,$P(X,"^",3) Q
