FHORC4 ; HISC/REL - Re-Assign Active Consults ;5/18/93  15:42 
 ;;5.5;DIETETICS;;Jan 28, 2005
 W !!,"This will re-assign all ACTIVE consults from one Clinician to another",!!
E1 K DIC S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")="Select CURRENT Clinician: " W ! D ^DIC G KIL:U[X!$D(DTOUT),E1:Y<1 S OLD=+Y
E2 S DIC("A")="Select NEW Clinician: " W ! D ^DIC G KIL:U[X!$D(DTOUT),E2:Y<1 S NEW=+Y,N1=0,FHDFN=0
 S WRD="" I OLD=NEW W !!,"No change in Clinician!" G KIL
E3 S FHDFN=$O(^FHPT("ADRU",OLD,FHDFN)) G:FHDFN<1 E6 S ADM=0
E4 S ADM=$O(^FHPT("ADRU",OLD,FHDFN,ADM)) G:ADM<1 E3 S REQ=0
E5 S REQ=$O(^FHPT("ADRU",OLD,FHDFN,ADM,REQ)) G:REQ<1 E4
 I WRD,'$D(^FHPT("AW",WRD,FHDFN)) G E5
 S N1=N1+1 K ^FHPT("ADRU",OLD,FHDFN,ADM,REQ)
 S ^FHPT("ADRU",NEW,FHDFN,ADM,REQ)="",$P(^FHPT(FHDFN,"A",ADM,"DR",REQ,0),"^",5)=NEW G E5
E6 W !!,N1," Consults were transferred"
KIL K ADM,FHDFN,DFN,DIC,N1,NEW,OLD,REQ,WRD,X,Y Q
EN2 ; Entry point from Edit Ward Assignment
 W !!,"Since you have changed a ward assignment, do you wish to"
 W !,"re-assign all active consults from ",$P(^VA(200,OLD,0),"^",1)
 W !,"to ",$P(^VA(200,NEW,0),"^",1)," ? N// "
N2 R X:DTIME Q:'$T!(X["^")  S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7," Answer YES or NO" G EN2
 Q:X'?1"Y".E  S (N1,FHDFN,DFN)=0,WRD=+DA D E3 Q
