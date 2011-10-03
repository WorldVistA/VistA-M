QANUTL4 ;HISC/GJC-Utilities for report generation ;6/16/93  12:05
 ;;2.0;Incident Reporting;**1,20,26**;08/07/1992
QANLOC ;Finding Incident Locations.
 S (QANFLG,QANY)=0
 W !!,"Enter the beginning and ending Incident Locations."
 R !,"Start with Incident Location: First// ",X:DTIME
 I '$T!(X["^") S QANY=1 Q
 I X="" S QANLCFLG=1 Q
 S X=$E(X)_$TR($E(X,2,999),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 S DIC=742.5,DIC(0)="EZ" D ^DIC K DIC
 I +Y>0 S:$D(Y(0,0)) QANDATA1=Y(0,0),QANDAT1=+Y G QANLOC1
 I $D(DTOUT)!$D(DUOUT) S QANY=1 Q
 I $D(X),$D(Y),X'["?",+Y=-1 W $C(7)," ??"
 G QANLOC
QANLOC1 ;
 R !,"End with Incident Location: Last// ",X:DTIME
 I '$T!(X["^") S QANY=1 Q
 I X="" S QANDATA2="~" D QANLOC3 Q
 S X=$E(X)_$TR($E(X,2,999),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 S DIC=742.5,DIC(0)="EZ" D ^DIC K DIC
 I +Y>0 S:$D(Y(0,0)) QANDATA2=Y(0,0),QANDAT2=+Y G QANLOC2
 I $D(DTOUT)!$D(DUOUT) S QANY=1 Q
 I $D(X),$D(Y),X'["?",+Y=-1 W $C(7)," ??"
 G QANLOC1
QANLOC2 I (QANDATA2']QANDATA1),(QANDATA2'=QANDATA1) D
 . W !!,$C(7),"The 'Start With' value must fall before the 'End With' value."
 . K QANDATA1,QANDATA2
 . S QANFLG=1 Q
 I $G(QANFLG) G QANLOC
QANLOC3 ;
 N QANCC,QANEE
 S QANEE=$E(QANDATA1,1,$L(QANDATA1)-1)
 S QANCC=QANDATA2_"Z"
 F  S QANEE=$O(^QA(742.5,"B",QANEE)) Q:QANEE']""!(QANEE]QANCC)  D
 . S QANDD=$O(^QA(742.5,"B",QANEE,0)),^TMP("QANRPT1",$J,"LOC",QANDD)=QANEE
 Q
WARD ;Grabbing the patient's Ward Location
 S (QANFLG,QANY)=0
 W !!,"Enter the beginning and ending ward/clinic locations for a patient."
 S DIC=44,DIC(0)="QEAMNZ",DIC("A")="Start with Ward/Clinic: First// "
 S DIC("S")="S QA=$P(^(0),U,3) I QA=""W""!(QA=""C"")" D ^DIC K DIC
 I X="" S QANLCFLG=1 Q
 I $D(DTOUT)!$D(DUOUT) S QANY=1 Q
 S:$D(Y(0,0)) QANDATA1=Y(0,0),QANDAT1=+Y
WARD1 S DIC=44,DIC(0)="QEAMNZ",DIC("A")="End with Ward/Clinic: Last// ",DIC("S")="S QA=$P(^(0),U,3) I QA=""W""!(QA=""C"")" D ^DIC K DIC
 I X="" S QANDATA2="~" G WARD2
 I $D(DTOUT)!$D(DUOUT) S QANY=1 Q
 S:$D(Y(0,0)) QANDATA2=Y(0,0),QANDAT2=+Y
WARD2 I (QANDATA2']QANDATA1),(QANDATA2'=QANDATA1) W !!,$C(7),"The 'Start with' values must fall before the 'End with' values." K QANDATA1,QANDATA2 G WARD
 D WARD3
 Q
WARD3 ;STORING THE WARD LOCATION
 N QANCC,QANEE
 S QANEE=$E(QANDATA1,1,$L(QANDATA1)-1) ;$S($G(QANDATA1)=" ":0,1:$E(QANDATA1,1,$L(QANDATA1)-1))
 S QANCC=$S($G(QANDATA2)="~":"ZZ",1:QANDATA2_"Z")
 F  S QANEE=$O(^SC("B",QANEE)) Q:QANEE']""!(QANEE]QANCC)  D
 . S QANDD=$O(^SC("B",QANEE,0))
 . S ^TMP("QANRPT1",$J,"LOC",QANDD)=QANEE
 Q
INCD ;Grabbing the incident.
 S QANY=0 W !!,"Enter the beginning and ending incident for a patient."
 S DIC=742.1,DIC(0)="QEAMNZ",DIC("A")="Start with Incident: First// ",D="B^BUPPER" D MIX^DIC1 K D,DIC
 I X="" S QANINFLG=1 Q
 I $D(DTOUT)!$D(DUOUT) S QANY=1 Q
 S:$D(Y(0,0)) QANDATA1=Y(0,0),QANDAT1=+Y
INCD1 S DIC=742.1,DIC(0)="QEAMNZ",DIC("A")="End with Incident: Last// ",D="B^BUPPER" D MIX^DIC1 K D,DIC
 I X="" S QANDATA2="~" G INCD2
 I $D(DTOUT)!$D(DUOUT) S QANY=1 Q
 S:$D(Y(0,0)) QANDATA2=Y(0,0),QANDAT2=+Y
INCD2 I (QANDATA2']QANDATA1),(QANDATA2'=QANDATA1) W !!,$C(7),"The 'Start with' values must fall before the 'End with' values." K QANDATA1,QANDATA2 G INCD
 D INCD3
 Q
INCD3 ;STORING THE INCIDENT
 N QANCC,QANEE
 S QANEE=$E(QANDATA1,1,$L(QANDATA1)-1) ;$S(QANDATA1=" ":"A",1:$E(QANDATA1,1,$L(QANDATA1)-1))
 S QANCC=QANDATA2_"Z"
 F  S QANEE=$O(^QA(742.1,"B",QANEE)) Q:QANEE']""!(QANEE]QANCC)  D
 . S QANDD=$O(^QA(742.1,"B",QANEE,0)),^TMP("QANRPT1",$J,"INC",QANDD)=QANEE
 Q
CHECK ;Check for the final Incident type
 W !!?10,"INCIDENT: "_$S(QANIRIN>0:$P(^QA(742.1,QANIRIN,0),U),1:""),!?10,"SEVERITY LEVEL: "_$S("16"'[QANIRIN:$P(^QA(742,QANDFN,0),U,10),"16"[QANIRIN:"3",1:"")
 I "16"[QANIRIN,(+$P($G(^QA(742,QANDFN,0)),U,10)'=3) D
 . K DA,DIE,DR S DA=QANDFN,DIE="^QA(742,",DR=".1///"_3 D ^DIE
 . K DA,DIE,DR
 S %=$S(+$P(^QA(742.4,QANIEN,0),U,17)=1:1,1:2)
CHK1 F  W !!,"Is this the final incident type" D YN^DICN Q:"-112"[%  W !!,"Enter ""N""o if you wish to enter a new Incident and Severity Level,",!,"""Y""es if the current Incident and Severity Level are correct."
 S QANYN=%
 K DA,DR,DIE S DIE="^QA(742.4,",DA=QANIEN,DR=".19///"_$S(%=1:1,1:0) D ^DIE K DA,DR,DIE
 Q
