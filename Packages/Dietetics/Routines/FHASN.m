FHASN ; HISC/REL - Nutrition Status ;10/29/93  08:55
 ;;5.5;DIETETICS;;Jan 28, 2005
EN4 ; List Nutrition Statuses
 W ! S L=0,DIC="^FH(115.4,",FLDS=".01,1",BY=".01"
 S (FR,TO)="",DHD="NUTRITION STATUS" D EN1^DIP,RSET Q
EN5 ; Enter Nutrition Status for Patient
 S ALL=1 D ^FHDPA G:'DFN KIL
 I $P($G(^DPT(DFN,.35)),"^",1) W *7,!!?5,"  [ Patient has expired. ]" G EN5
 ; If Multidivisional site Select Communications Office
 S FHCOMM="" I $P($G(^FH(119.9,1,0)),U,20)'="N" D  I FHCOMM="" Q
 .W ! K DIC S DIC="^FH(119.73," S DIC(0)="AEMQ" D ^DIC
 .I Y=-1 Q
 .S FHCOMM=+Y
 D DID^FHDPA,GET
 K DIC S DIC="^FH(115.4,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,2)'=""""" S:Y'="" DIC("B")=Y W ! D ^DIC K DIC G KIL:"^"[X!$D(DTOUT),EN5:Y<1 I +Y'=OLD S S2="I" G C2
C1 R !!,"Is this a re-screen (Y/N)? ",X:DTIME G KIL:'$T,EN5:X["^" S:X="" X="^" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,!,"  Answer YES or NO" G C1
 S S2=$S(X?1"Y".E:"F",1:"I")
C2 S S1=+Y D NOW^%DTC S NOW=%
 I '$D(^FHPT(FHDFN,0)) S ^(0)=FHDFN
 I '$D(^FHPT(FHDFN,"S",0)) S ^(0)="^115.012D^^"
 K DIC,DD,DO S DIC="^FHPT(FHDFN,""S"",",DIC(0)="L",DLAYGO=115,DA(1)=FHDFN,X=NOW,DINUM=9999999-NOW D FILE^DICN S ASE=+Y
 S $P(^FHPT(FHDFN,"S",ASE,0),"^",2,3)=S1_"^"_DUZ S:FHWRD $P(^(0),"^",6)=FHWRD
 S DTE=+$E(NOW,1,12),S3="Nutrition Status: "_$P(^FH(115.4,S1,0),"^",2),S1=2
 D FIL^FHASE3 G EN5
GET ; Get Nutrition Status for current admission
 S Y="",OLD="",X5=$O(^FHPT(FHDFN,"S",0)) Q:X5=""  S X5=^(X5,0)
 I WARD'="" Q:$P(X5,"^",1)<$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",1)
 S OLD=+$P(X5,"^",2),Y=$P($G(^FH(115.4,OLD,0)),"^",2) K X5 Q
RSET K %ZIS S IOP="" D ^%ZIS K %ZIS,IOP
KIL G KILL^XUSCLEAN
