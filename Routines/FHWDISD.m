FHWDISD ; HISC/REL - Delete Discharge ;2/2/95  10:14
 ;;5.5;DIETETICS;;Jan 28, 2005
 D DID^FHDPA Q:WARD=""  S ADM=$G(^DPT("CN",WARD,DFN)) Q:'ADM
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 S A0=$G(^FHPT(FHDFN,"A",ADM,0)),FHWF=$S($D(^ORD(101)):1,1:0) Q:A0=""
 S TIM=$P(A0,"^",14) Q:'TIM  S $P(^FHPT(FHDFN,"A",ADM,0),"^",14)="" Q
 ; Re-instate Additional Orders
 F FHDR=0:0 S FHDR=$O(^FHPT("AOO",FHDFN,ADM,FHDR)) Q:FHDR<1  S Y=$G(^(FHDR,0)) D AOO
 ; Re-instate Consults
 F FHDR=0:0 S FHDR=$O(^FHPT(FHDFN,"A",ADM,"DR",FHDR)) Q:FHDR<1  S Y=$G(^(FHDR,0)) D CON
 ; Re-instate Standing Orders
 F FHDR=0:0 S FHDR=$O(^FHPT(FHDFN,"A",ADM,"SP",FHDR)) Q:FHDR<1  S Y=^(FHDR,0) D SP
 ; Re-instate Tubefeeding
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"TF",K)) Q:K<1  I $P($G(^(K,0)),"^",11)=TIM D TF
 ; Re-instate Supplemental Feeding
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"SF",K)) Q:K<1  I $P($G(^(K,0)),"^",32)=TIM D SF
 ; Re-instate Diet Order
 D DO,WRD^FHWADM
KIL K %,%H,%I,A0,A1,FHDR,K,TIM,FHORD,FHRMB,FHWRD,FHX1,FHX2,FHX3,X,Y Q
AOO Q:$P(Y,"^",5,6)'=("X^"_TIM)
 S $P(^FHPT(FHDFN,"A",ADM,"OO",FHDR,0),"^",5,7)="A^^"
 S ^FHPT("AOO",FHDFN,ADM,FHDR)="" Q
CON Q:$P(Y,"^",8,9)'=("X^"_TIM)  S $P(^FHPT(FHDFN,"A",ADM,"DR",FHDR,0),"^",8,11)="A^^^"
 S K=$P(Y,"^",5) S:K ^FHPT("ADRU",K,FHDFN,ADM,FHDR)="" Q
SP Q:$P(Y,"^",6)'=TIM  S $P(^FHPT(FHDFN,"A",ADM,"SP",FHDR,0),"^",6,7)="^"
 S ^FHPT("ASP",FHDFN,ADM,FHDR)="" Q
TF S $P(^FHPT(FHDFN,"A",ADM,0),"^",4)=K S ^FHPT("ADTF",FHDFN,ADM)=""
 S $P(^FHPT(FHDFN,"A",ADM,"TF",K,0),"^",11,12)="^" Q
SF S $P(^FHPT(FHDFN,"A",ADM,0),"^",7)=K
 S $P(^FHPT(FHDFN,"A",ADM,"SF",K,0),"^",32,33)="^" Q
DO S FHORD=$P($G(^FHPT(FHDFN,"A",ADM,"AC",TIM,0)),"^",2) Q:'FHORD
 Q:$P($G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)),"^",7)'="X"
 K ^FHPT(FHDFN,"A",ADM,"AC",TIM)
 S FHORD="" F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"AC",K)) Q:K<1!(K>TIM)  S FHORD=$P(^(K,0),"^",2)
 Q:'FHORD  S $P(^FHPT(FHDFN,"A",ADM,0),"^",2,3)=FHORD_"^" S EVT="D^O^"_FHORD D ^FHORX
 Q
