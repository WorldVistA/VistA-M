FHORC2 ; HISC/REL/NCA - Clear/Query a Consult ;9/4/96  09:32 ;
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Clear/Cancel/Reassign a Consult
Q1 K DIC S DIC="^VA(200,",DIC(0)="AQEM",DIC("A")="Select CLINICIAN: " W ! D ^DIC G KIL:"^"[X!$D(DTOUT),Q1:Y<1 S FHX1=+Y
Q2 S (N1,FHDFN)=0
Q3 S FHDFN=$O(^FHPT("ADRU",FHX1,FHDFN)),ADM=0 I FHDFN="" W:'N1 !!,"No Consults to Clear" G Q1
Q4 S ADM=$O(^FHPT("ADRU",FHX1,FHDFN,ADM)) G:ADM="" Q3 S FHDR=0
Q5 S FHDR=$O(^FHPT("ADRU",FHX1,FHDFN,ADM,FHDR)) G:FHDR="" Q4
 S ALL=0 D DISP G:DTP="^" Q5 S N1=N1+1
Q6 R !!,"Disposition (C=Complete, X=Cancelled, R=Reassign, RETURN to bypass): ",TYP:DTIME G KIL:'$T!(TYP=U),Q5:TYP="" S X=TYP D TR^FH S TYP=X I TYP'?1U!("XCR"'[TYP) W *7,!,"Enter C, X or R or Press RETURN to bypass" G Q6
 S S1="" G Q9:TYP="X",Q10:TYP="R" S S1="I" G:$P(^FH(119.5,CON,0),"^",3)'="Y" Q9
Q7 R !,"Initial or Follow-up (I/F)? ",S1:DTIME G KIL:'$T!(S1["^") S X=S1 D TR^FH S S1=X I S1'="I",S1'="F" W *7,"  Enter I or F" G Q7
Q9 K ^FHPT("ADRU",FHX1,FHDFN,ADM,FHDR)
 D NOW^%DTC S $P(^FHPT(FHDFN,"A",ADM,"DR",FHDR,0),"^",8,11)=TYP_"^"_%_"^"_DUZ_"^"_S1 W "  ... done"
 D EN31^FHASE G Q5
Q10 K DIC S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")="REASSIGN to Clinician: " W ! D ^DIC G KIL:U[X!$D(DTOUT),Q10:Y<1 S XMKK=+Y K DIC
 K ^FHPT("ADRU",FHX1,FHDFN,ADM,FHDR) S ^FHPT("ADRU",XMKK,FHDFN,ADM,FHDR)=""
 S $P(^FHPT(FHDFN,"A",ADM,"DR",FHDR,0),"^",5)=XMKK
 S REQ=CON D POST^FHORC
 W "  ... done" G Q5
EN2 ; Consult Inquiry
 S ALL=1 D ^FHDPA G:'DFN KIL G:'FHDFN KIL
 S ADM=$O(^FHPT(FHDFN,"A",0)) I ADM<1 W !,"No Admissions on File" G EN2
 I $P(^FHPT(FHDFN,"A",0),"^",4)=1 G E2
E1 S DIC="^FHPT(FHDFN,""A"",",DIC(0)="Q",X="??" D ^DIC S DIC(0)="AQM" W ! D ^DIC K DIC G KIL:U[X!$D(DTOUT),E1:Y<1 S ADM=+Y
E2 S FHDR=$O(^FHPT(FHDFN,"A",ADM,"DR",0)) I FHDR<1 W !,"No Consultations for this admission" G EN2
 I $P(^FHPT(FHDFN,"A",ADM,"DR",0),"^",4)=1 G E4
E3 S DIC="^FHPT(FHDFN,""A"",ADM,""DR"",",DIC(0)="Q",X="??" D ^DIC S DIC(0)="AQM" W ! D ^DIC K DIC G KIL:U[X!$D(DTOUT),E2:Y<1 S FHDR=+Y
E4 S ALL=1 D DISP G EN2
DISP S Y=^FHPT(FHDFN,"A",ADM,"DR",FHDR,0)
 I '$D(^DGPM(ADM,0)) S XMKK=$P(Y,"^",5) K:XMKK ^FHPT("ADRU",XMKK,FHDFN) S $P(^FHPT(FHDFN,"A",ADM,"DR",FHDR,0),"^",8)="X",DTP=U Q
 D PATNAME^FHOMUTL I DFN="" Q
 S PNAM=$P(^DPT(DFN,0),"^",1),FHWRD=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8),WARD=$S(FHWRD:$P($G(^FH(119.6,FHWRD,0)),"^",1),1:"Discharged") I $P($G(^DGPM(ADM,0)),"^",17) S WARD="Discharged"
 S DTP=+^DGPM(ADM,0) D DTP^FH W !!,$E(PNAM,1,25),?27,"Admitted: ",DTP,?57,"Ward: ",$E(WARD,1,16)
D1 ; Display consult
 S CON=$P(Y,"^",2),DTP=$P(Y,"^",1),DIET=$P(Y,"^",5),COM=$P(Y,"^",3),STAT=$P(Y,"^",8)
 W !!,"Consult: ",$P($G(^FH(119.5,CON,0)),"^",1)
 W:COM'="" !,"Comment: ",COM
 W !,"Status: ",$S(STAT="A":"ACTIVE",STAT="C":"COMPLETE",1:"CANCELLED")
 D DTP^FH W !,"Ordered: ",DTP,?40,"Clinician: ",$P($G(^VA(200,DIET,0)),"^",1)
 Q:'ALL  S D1=$P(Y,"^",7),D2=$P(Y,"^",10),DTP=$P(Y,"^",9),S1=$P(Y,"^",11)
 W !!,"Order Entered: ",$P($G(^VA(200,D1,0)),"^",1)
 Q:'D2  D DTP^FH W !,"Order Cleared: ",$P($G(^VA(200,D2,0)),"^",1)
 W !,"Date Cleared:  ",DTP W:S1'="" ?40,"Consult Type: ",$S(S1'="F":"INITIAL",1:"FOLLOW-UP") Q
KIL K %,%H,%I,ADM,ALL,ASE,COM,CON,D1,D2,DA,FHDFN,DFN,DIC,DIET,DTP,FHAP,FHWRD,FHWF,FHPV,FHX1,FHX2,FHX3,FHX4,LP,N1,PNAM,FHDR,STAT,S1,ST,TYP,REQ,WARD,X,X1,X9,Y,XMKK Q
