FHORC ; HISC/REL - Dietetic Consults ;9/4/96  09:22 ;
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
EN1 ; Order Consult
 S ALL=0 D ^FHDPA G:'DFN KIL G:'FHDFN KIL D ORD G:'$D(DFN) KIL D FIL G KIL
ORD ; Get Order
 W ! F K=0:0 S K=$O(^FH(119.5,K)) Q:K<1  W:'$D(^FH(119.5,K,"I")) !,$P(^(0),"^",1)
R1 W ! K DIC S DIC="^FH(119.5,",DIC(0)="AEQZM" D ^DIC G AB:U[X!$D(DTOUT),R1:Y<1 S REQ=+Y
R2 R !,"Comment: ",COM:DTIME G:'$T!(COM["^") AB I COM'?.ANP W *7," ??" G R2
 I $L(COM)>80!(COM?1"?".E) W *7,!,"Enter 1-80 character comment" G R2
R4 R !,"Ok to Enter Request? Y// ",YN:DTIME G AB:'$T!(YN["^") S:YN="" YN="Y" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G R4
 G:YN'?1"Y".E AB Q
FIL ; File Order
 L +^FHPT(FHDFN,"A",ADM,"DR",0) S:'$D(^FHPT(FHDFN,"A",ADM,"DR",0)) ^FHPT(FHDFN,"A",ADM,"DR",0)="^115.03^^"
 S DR=$P(^FHPT(FHDFN,"A",ADM,"DR",0),"^",3)+1,$P(^(0),"^",3,4)=DR_"^"_DR L -^FHPT(FHDFN,"A",ADM,"DR",0)
 D NOW^%DTC S NOW=% D CHK
 S ^FHPT(FHDFN,"A",ADM,"DR",DR,0)=NOW_"^"_REQ_"^"_COM_"^^"_XMKK_"^^"_DUZ_"^A"
 S ^FHPT("ADR",NOW,FHDFN,ADM,DR)="",^FHPT("ADRU",XMKK,FHDFN,ADM,DR)=""
 D POST Q
CHK ; Get Clinician
 S WRD=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8) G:WRD<1 RNO
 G:'$D(^FH(119.6,WRD)) RNO
 S XMKK=$P($G(^FH(119.5,+REQ,0)),"^",6)
 F FHXMKK=0:0 S FHXMKK=$O(^FH(119.6,WRD,2,"B",FHXMKK)) Q:FHXMKK'>0  D
 .S XMY(FHXMKK)=""
 I XMKK<1 S XMKK=$O(XMY("")) G:XMKK<1 RNO
 Q
RNO S XMKK=$O(^XUSEC("FHMGR",0)) S:XMKK<1 XMKK=.5 Q
AB W *7,!!,"Consult entry is TERMINATED - No request entered!"
KIL K %,%H,%I,A,G,I,XMKK,WARD,WRD,ADM,ALL,COM,DA,FHDFN,FHXMKK,DFN,DIC,DR,FHPV,K,NOW,REQ,X,Y,YN Q
POST ; Generate Bulletin
 S XMB="FHDIREQ" I '$D(XMY(XMKK)) S XMY(XMKK)=""
 S XMB(1)=$P(^FH(119.5,REQ,0),"^",1),XMB(2)=$S($D(^DPT(DFN,.101)):^(.101),1:"unknown")
 S XMB(3)=$P(^DPT(DFN,0),"^",1),XMB(4)=WARD,XMB(5)=COM D ^XMB K XMB,XMY,XMM,XMDT Q
