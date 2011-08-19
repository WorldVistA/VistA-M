FHXWRD ; HISC/REL/NCA - Update Patient Dietetic Ward ;8/7/95  15:13
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Ask user whether they want to update
 R !!,"Update the Patient Dietetic Location? N// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="N" D TR^FH
 I $P("YES",X,1)'="",$P("NO",X,1)'="" D MSG G EN1
 I X?1"Y".E D E1 W !!,"....Done"
 G KIL
E1 ; Process Updating Patient Dietetic Ward
 K ^FHPT("AW")
 S NX="" F  S NX=$O(^DPT("CN",NX)) Q:NX=""  F DFN=0:0 S DFN=$O(^DPT("CN",NX,DFN)) Q:DFN'>0  S ADM=^(DFN) D SET
 Q
SET D DID^FHDPA
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 Q:$D(^FHPT(FHDFN,"A",+ADM,0))#2=0
 S Y=$P(^FHPT(FHDFN,"A",ADM,0),"^",8,9),$P(^(0),"^",8,9)=FHWRD_"^"_FHRMB
 S:FHWRD ^FHPT("AW",FHWRD,FHDFN)=ADM
 I (FHWRD_"^"_FHRMB)'=Y S EVT="L^T^^"_$P(Y,"^",1)_"~"_$P(Y,"^",2) S:FHWRD EVT=EVT_"~"_FHWRD_"~"_FHRMB S:'FHWRD $P(EVT,"^",2)="D" D ^FHORX
 Q:'FHWRD
 ; Update Type of Service
 S FHX3=$P($G(^FH(119.6,+FHWRD,0)),"^",10) S:FHX3="" FHX3="TCD" I FHX3[$P(^FHPT(FHDFN,"A",ADM,0),"^",5) Q
 S FHX3=$S($L(FHX3)=1:FHX3,FHX3["D":"D",1:"C"),$P(^FHPT(FHDFN,"A",ADM,0),"^",5)=FHX3
 S FHX2=$P(^FHPT(FHDFN,"A",ADM,0),"^",2) I FHX2,$P($G(^FHPT(FHDFN,"A",ADM,"DI",+FHX2,0)),"^",8)'="" S $P(^(0),"^",8)=FHX3
 Q
KIL G KILL^XUSCLEAN
MSG ; Write Error Message
 W *7,!,"Answer YES or NO on whether you want to update the Dietetic"
 W !,"locations for inpatients.  This will insert the proper location"
 W !,"into the Dietetic Patient file for the appropriate admission."
 W !,"NOTE: During installation, the Dietetic locations for inpatients"
 W !,"have been updated already and this option will update them again."
 Q
