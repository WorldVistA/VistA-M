DGYMF31A ;ALB/CMM FIND DANGLING PT IN ^DPT TO ^DIC(31 ;12/30/94
 ;;5.3;Registration;**53**;Aug 13, 1993
 ;
 ;This is a one shot routine that will loop through the patient
 ;file entries looking at the disabilities to see if the pointer
 ;values are valid to file 31 (disability conditions file).
 ;
DRIVE ;
 U IO S PAGE=1
 D LOOP
 S ^TMP($J,"DG31",0)=NXT,INDEX="B"
 D HEAD1 I $O(^TMP($J,"DG31",0))="" W !!,"No bad pointers." Q
 D REPORT I END="Y" Q
 I $D(^TMP($J,"DG31","D")) S INDEX="D" D HEAD I END'="Y" D REPORT
 I END'="Y" W !!,"TOTAL PATIENTS WITH DANGLING POINTER(S) = ",NXT
 I $D(ZTSK) D EXIT^DGYMF31
 Q
LOOP ;looping through patient file
 S (DFN,NXT,CPT)=0 K ^TMP($J,"DG31")
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .S (ANY,CNT)=0,CPT=CPT+1
 .I $E(IOST,1,2)="C-" W:'(CPT#100) "."
 .F  S CNT=$O(^DPT(DFN,.372,CNT)) Q:CNT=""  D
 ..S PTR=+^DPT(DFN,.372,CNT,0)
 ..I '$D(^DIC(31,PTR,0)) D:BADDEL="Y" KILL S ANY=ANY+1 I ANY D FOUND
 .I ANY&(INVALID="Y") D DIS
 Q
FOUND ;
 S LAST=$$LTD(DFN)
 S DEAD=+$G(^DPT(DFN,.35))
 I '$D(^TMP($J,"DG31",$S('DEAD:"B",1:"D"),$P(^DPT(DFN,0),"^"))) D
 .S NXT=NXT+1,^TMP($J,"DG31",NXT)=$P(^DPT(DFN,0),"^")_"^"_$P(^DPT(DFN,0),"^",9)_"^"_$P(^DPT(DFN,0),"^",3)_"^"_LAST_"^"_DEAD
 .S ^TMP($J,"DG31",$S('DEAD:"B",1:"D"),$P(^DPT(DFN,0),"^"),NXT)=""
 Q
DIS ;include 'good' disabilities in report
 N PTR,TLP,TCT S (TLP,TCT)=0
 F  S TLP=$O(^DPT(DFN,.372,TLP)) Q:TLP=""  D
 .S PTR=+^DPT(DFN,.372,TLP,0)
 .I $D(^DIC(31,PTR,0)) S TCT=TCT+1,^TMP($J,"DG31",NXT,TCT)=$P(^DIC(31,PTR,0),"^")
 Q
HEAD ;
 S END="N"
 I ($E(IOST,1,2)="C-") S DIR(0)="E" D ^DIR I 'Y S END="Y" K X,Y,DUOUT,DTOUT,DIRUT Q
HEAD1 ;
 W @IOF
 W !!,"Patients with bad pointers in the Rated Disability field ",?100,"PAGE ",PAGE,!
 W !,?5,"Patient Name",?35,"SSN",?50,"Date of Birth",?70,"Last Date of Contact"
 I INDEX="D" W ?100,"Date of Death"
 I INVALID="Y" W !,?10,"Valid Disabilities on file"
 W !
 S PAGE=PAGE+1
 Q
REPORT ;Display information gathered.
 N NM S LP=0,END="N",NM=""
 F  S NM=$O(^TMP($J,"DG31",INDEX,NM)) Q:(NM="")!(END="Y")  D
 .F  S LP=$O(^TMP($J,"DG31",INDEX,NM,LP)) Q:(LP="")!(END="Y")  D
 ..I $Y+3>IOSL D HEAD I END="Y" Q
 ..D DATA
 ..I INVALID="Y" D DATA2
 Q
DATA ;
 N NODE S NODE=^TMP($J,"DG31",LP)
 S SSN=$P(NODE,"^",2),SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)
 S DEAD=$$FMTE^XLFDT($P(NODE,"^",5)) I DEAD=0 S DEAD=""
 S LAST=$$FMTE^XLFDT($P(NODE,"^",4)) I LAST=0 S LAST=""
 W !,$P(NODE,"^"),?31,SSN,?50,$$FMTE^XLFDT($P(NODE,"^",3)),?70,LAST,?100,DEAD
 ;NAME,SSN,DOB,LAST DATE OF CONTACT,DATE OF DEATH
 Q
 ;
DATA2 ;
 N TCT S TCT=0
 F  S TCT=$O(^TMP($J,"DG31",LP,TCT)) Q:TCT=""!(END="Y")  D
 .I $Y+2>IOSL D HEAD I END'="Y" S NX="Y"
 .I END="Y" Q
 .I $D(NX) K NX D DATA
 .W !,?10,^TMP($J,"DG31",LP,TCT)
 Q
LTD(DFN) ; Find Last Treatment Date
 ;  Input:  DFN - pointer to the patient in file #2
 ; Output:  LTD - Last Treatment Date (really last date seen at facility)
 ;
 N LTD,X
 ; - if current inpatient, set LTD = today and quit
 I $G(^DPT(DFN,.105)) S LTD=DT G LTDQ
 ; - get the last discharge date
 S LTD=+$O(^DGPM("ATID3",DFN,"")) S:LTD LTD=9999999.9999999-LTD\1 S:LTD>DT LTD=DT
 ; - get the last registration date and compare to LTD
 S X=+$O(^DPT(DFN,"DIS",0)) I X S X=9999999-X\1 S:X>LTD LTD=X
 ; - get the last appointment and compare to LTD
 S X=LTD F  S X=$O(^DPT(DFN,"S",X)) Q:'X!(X>DT)  I $D(^(X,0)),$P(^(0),"^",2)="" S LTD=X\1
 ; - get the last stop and compare to LTD
 S X=LTD F  S X=$O(^SDV("ADT",DFN,X)) Q:'X  S LTD=X
LTDQ Q LTD
 ;
KILL ;Delete pointer from Patient file
 S DA(1)=DFN,DA=CNT,DIK="^DPT("_DA(1)_",.372," D ^DIK K DIK,DA
 Q
