QANCDNT ;HISC/GJC-Initial sighting of an incident ; 10/29/03 10:39am
 ;;2.0;Incident Reporting;**1,9,14,27,26,28,29,30,32**;08/07/1992;Build 3
 ;
 ;
 N QANQFLG
 D NEWREC ;I $G(QANLOCK)=1 L -^QA(742.4) S QANLOCK=0 Q
 D DIV
 I $G(QANQFLG)=1 D DEL Q
 D DIE
 Q
NEWREC ;create new record number
 ;record number will be in the format XXX.YYnnnn where XXX is the
 ;three digit station number, YY is the 2 digit year and nnnn is
 ;the sequence number (and is also the IEN of file 742.4)
 N EE,QANCNT,QANLIST,QANNO,QANQFLG
 K QANLOCK
 S (QANFLAG,QANXIT,QANOUT)=0,QANST=$S($D(^QA(740,1,0))#2:$P(^(0),"^"),1:""),QANST1=$S($D(^DIC(4,QANST,99))#2:$P(^(99),"^"),1:QANST)
 S QANDUZ=$S($D(DUZ):DUZ,1:""),QANTTL=$P(^VA(200,QANDUZ,0),U,9)
 ;set QANDT variable as "." concatonated with 2 digit year so that
 ;years 2000-2009 don't have leading zeroes.
 S QANDT=$S($D(DT):$E(DT,2,3),1:""),QANDT="."_QANDT
 S QANINCR=+$P($G(^QA(742.4,0)),U,3)+1 ;Grab the new IEN
 F  Q:$D(^QA(742.4,QANINCR,0))=0  S QANINCR=QANINCR+1
 S QANCODE(0)=QANDT_QANINCR
 I $L(QANINCR)<4 S QANCODE(0)=QANDT_$E("000",1,(4-$L(QANINCR)))_QANINCR
 S QANCODE(1)=QANST1_QANCODE(0)
 S QANCHK=$O(^QA(742.4,"B",QANCODE(1),0)) I +QANCHK,$D(^(QANCHK))#2 D  Q
 . W !!,$C(7),"CASE NUMBER VIOLATION, CONTACT YOUR QA COORDINATOR!!"
 . S QANXIT=1
 . K QANST,QANST1,QANDT,QANCODE,QANINCR,QANFLAG,QANOUT,QANDUZ,QANCHK,QANTTL
 I $G(QANXIT)=1 Q
 K DIC,DD,DO,DLAYGO,DINUM S (DIC,DIE)="^QA(742.4,",DIC(0)="L",X=QANCODE(1)
 D FILE^DICN
 K DIC,DD,DO,DLAYGO,DINUM
 L +^QA(742.4,+Y):3 I '$T W !!,"Another user is editing this incident." S QANLOCK=1 Q
 S QANBFLG=1 ;set brief flag so that if this subroutine was called
 ;from full incident edit you do not re-lock the record when you
 ;get back to full incident edit.
 Q:+Y<1  S QANIEN=+Y
 S QANHOME=$G(^QA(742.4,QANIEN,0)),$P(QANHOME,U,5)=QANDUZ,$P(QANHOME,U,6)=QANTTL,$P(QANHOME,U,15)=1,$P(QANHOME,U,8)=1
 K DA,DIK S DIK="^QA(742.4,",DA=QANIEN,^QA(742.4,QANIEN,0)=QANHOME D IX1^DIK K DA,DIK
 Q
DIV ;check to see if station is multi-divisional for Incid Reporting.  If
 ;so, and there are hosp locations in file 740 (node "QAN2") then
 ;prompt user for Division.
 I $P($G(^QA(740,1,"QAN")),U,5)=1 S TEMPY=$G(Y) D  S Y=$G(TEMPY)
 . W !!,"DIVISION: "
 . S QANCNT=0 S QANLIST="S EE=0 F  S EE=$O(^QA(740,1,""QAN2"",EE)) Q:EE'>0  W !?5,EE,?10,$P(^DIC(4,$P(^QA(740,1,""QAN2"",EE,0),U),0),U) S QANCNT=QANCNT+1"
LIST . S QANCNT=0 X QANLIST
 . I $G(QANCNT)<1 W !?5,"There are no divisions entered in your QA Site Parameter File (#704).",!?5,"Ask your IRM support person to edit this file.  If your site"
 . I $G(QANCNT)<1 W !?5,"is entered in file #740 as a MULTI-DIVISIONAL INCID REP FACILITY you need",!?5,"entries in the IR HOSPITAL DIVISION multiple."
 . S DIR(0)="NA"
 . S DIR("A")="Enter the number of your choice: "
 . S DIR("?")="Choose the number of your division."
 . S DIR("??")="^S X=QANCNT X QANLIST"
 . D ^DIR
 . I $G(Y)']""!($G(Y)="^") D
 . . W !!?5,"You must enter a Division.",!
 . . D ^DIR
 . . I $G(Y)']""!($G(Y)="^") S QANQFLG=1 Q
 . I $G(QANQFLG)=1 Q
 . I '$G(^QA(740,1,"QAN2",+Y,0)) W !,"Enter the number of your choice." S QANCNT=0 G LIST
 . S QANNO=+Y
 . S DIE="^QA(742.4,",DR="52///^S X=$P(^DIC(4,+^QA(740,1,""QAN2"",QANNO,0),0),U)"
 . S DA=QANIEN
 . D ^DIE I $D(Y)>0 S QANCNT=0 G LIST
 Q
DIE S DIE="^QA(742.4,",DA=QANIEN,DR="[QAN ENTER TIME]"
 D ^DIE K DIE,DR I $D(Y) D DEL Q:QANXIT
 S QANST=$P(^QA(742.4,QANIEN,0),U,2) I "12"[$P(^QA(742.1,QANST,0),U,2) S $P(^QA(742.4,QANIEN,0),U,9)=DT,QAQADICT=742.4,QAQAFLD=".1",X=DT D ENSET^QAQAXREF
 K ^UTILITY($J,"QAN PAT") F  D PAT Q:QANXIT!(QANOUT)  ;get the patient
 Q:QANXIT
SC1 ;
 K Y S DIE="^QA(742.4,",DA=QANIEN,DR=".05;@1;.08;S X=X" D ^DIE K DIE,DR I $D(Y) Q:QANXIT
 K QAUDIT S QAUDIT("FILE")="742.4^50",QAUDIT("DA")=QANIEN,QAUDIT("ACTION")="o",QAUDIT("COMMENT")="Open an incident record" D ^QAQAUDIT
 S DIE="^QA(742.4,",DR=".09///"_1,DA=QANIEN D ^DIE ; Set 'Local Case' flag to open.
 I $G(QANFFLG)<1 D DISP
 I $G(QANFFLG)<0 L -^QA(742.4,QANIEN) ;if this subroutine has not
 ;been called from the full incident edit, then unlock incident report.
 ;D ^QANBRIF ;transmit message to local mail group
 Q
DEL ;Delete incident.
 K DIK S DIK="^QA(742.4,",DA=QANIEN W !!,$C(7),"Insufficient data entered for an incident, deleting!!" D ^DIK K DA,DIK S QANXIT=1
 Q
PAT ;Patient data.
 K DIC S DIC="^DPT(",DIC(0)="QEAMNZ",DIC("A")="Select Patient: ",DIC("W")="W "" "",$P(^(0),U,9)",D="B^BS5"
 D MIX^DIC1 K DIC S:+Y<1&($G(QANFLAG)) QANOUT=1
 D:+Y<1&('$G(QANFLAG)) DEL^QANCDNT Q:QANXIT!(QANOUT)
 F  D  Q:"-12"[%
 . W !?5,$G(Y(0,0))_" OK?"
 . S %=1 D YN^DICN Q:"-12"[%
 . W " Confirm that this is the correct patient."
 D:%=-1&('$G(QANFLAG)) DEL^QANCDNT Q:QANXIT!(QANOUT)
 I %=-1,($G(QANFLAG)) S QANXIT=1 Q
 I %=2 W " ??" G PAT
 D PRIOR I QANXIT D  Q
 . I '$G(QANFLAG) K DA,DIK S DA=QANIEN,DIK="^QA(742.4," D ^DIK K DA,DIK
 I $D(^UTILITY($J,"QAN PAT",+Y)) W !!,$C(7),$P(^DPT(+Y,0),U)_" has been previously entered for this incident." K Y G PAT
 I $D(^DPT(+Y,.35)),$P(^DPT(+Y,.35),U)]"",($P(^DPT(+Y,.35),U)<$P(^QA(742.4,QANIEN,0),U,3)) W !!,$C(7),"The date of death for patient: "_$P(^DPT(+Y,0),U)_" precedes the incident date." K Y G PAT
 I $G(QANXIT)!($G(QANOUT)) D DEL Q
 S QANPIEN=+Y,QANZERO=Y(0),QANAME=Y(0,0),QANSSN=$P(QANZERO,U,9),^UTILITY($J,"QAN PAT",+Y)=""
 S QANDOB=$P(^DPT(QANPIEN,0),U,3)
 I QANDOB]"" S X=DT,X1=X,X2=QANDOB,X="" D:X2 ^%DTC S X=X\365.25,QANAGE=X
 S QANPSDO(0)=Y(0),QANPSDO(0,0)=Y(0,0)
 S QANPID=$$QANPID(.Y)
 D ADMDT^QANUTL1
 K DIC,DD,DO,DINUM,DLAYGO S DLAYGO=742,DIC="^QA(742,",DIC(0)="L",X=QANPIEN D FILE^DICN K DIC,DD,DO,DINUM,DLAYGO
 I +Y=-1,('$G(QANFLAG)) D DEL Q
 I +Y=-1,($G(QANFLAG)) S QANXIT=1 Q  ;Something is wrong, exit.
 S QANDFN=+Y
 L +^QA(742,QANDFN):10 I '$T W !!,"Another user is editing this patient incident." Q
 S $P(^QA(742,QANDFN,0),U,2,6)=QANPID_U_QANIEN_U_QANADMDT_U_QANINPAT_U_QANWARD
 S $P(^QA(742,QANDFN,0),U,7)=QANTRSP,$P(^QA(742,QANDFN,0),U,12)=1
 S DIK="^QA(742,",DA=QANDFN D IX1^DIK K DA,DIK
 L -^QA(742,QANDFN)
 S QANFLAG=1 ;D:'$D(QANF) BULL^QANUTL3
 K QAUDIT S QAUDIT("FILE")="742^50",QAUDIT("DA")=QANDFN,QAUDIT("ACTION")="o",QAUDIT("COMMENT")="Open a patient record" D ^QAQAUDIT
 Q
PRIOR ;
 S QANTST(1)=$G(^QA(742.4,QANIEN,0))
 S QANTST("INC")=$P(QANTST(1),U,2),QANTST("DATE")=$P(QANTST(1),U,3)
 F QAN99=0:0 S QAN99=$O(^QA(742,"AA",+Y,QAN99)) Q:QAN99'>0!(QANXIT)  S QANPRS=+$O(^QA(742,"AA",+Y,QAN99,"")) I QANPRS>0,($P(^QA(742,QANPRS,0),U,12)'<0) S QANTST(2)=$G(^QA(742.4,QAN99,0)) D PRIOR1
 K QAN99,QANPRS,QANTST
 Q
PRIOR1 ;
 I (QANTST("INC")=$P(QANTST(2),U,2)),(QANTST("DATE")=$P(QANTST(2),U,3)) D
 . W !!,$C(7),"Patient "_$P(^DPT(+Y,0),U)_" has a duplicate incident on record."
 . W:'$G(QANFLAG) !,"Deleting the incident."
 . S:'$G(QANFLAG) QANXIT=1
 . W:$G(QANFLAG) !,"Please select new patient or press 'RETURN'!"
 ; . W:$G(QANFLAG) !,"Exiting!"
 ; . S QANXIT=1
 Q
DISP ;display to user what has been entered and ask if it is okay
 N QANCC,QANEE
 W @IOF
 S QAN74240=^QA(742.4,QANIEN,0)
 W !!!,"Incident Report: "_$P(QAN74240,U)
 S Y=$P(QAN74240,U,3) D DD^%DT
 W ?35,"Date of Incident: "_Y
 W !,"Patient: "
 S QANCC=0 F  S QANCC=$O(^QA(742,"BCS",QANIEN,QANCC)) Q:QANCC'>0  D
 . W ?10,$P(^DPT($P(^QA(742,QANCC,0),U),0),U),!
 W !,"Incident Type: "
 I $P(QAN74240,U,2)]"" W $P(^QA(742.1,$P(QAN74240,U,2),0),U)
 W !,"Incident Location: "
 I $P(QAN74240,U,4)]"" W $P(^QA(742.5,$P(QAN74240,U,4),0),U)
 W !,"Was the Incident Witnessed?: "_$S($P(QAN74240,U,7)=1:"Yes",$P(QAN74240,U,7)=0:"No",1:"")
 W !,"Incident Description: "
 S QANEE=0 F  S QANEE=$O(^QA(742.4,QANIEN,1,QANEE)) Q:QANEE'>0  D
 . W !?3,^QA(742.4,QANIEN,1,QANEE,0)
 W !!
 S DIR("A")="Is this information correct?"
 S DIR("B")="Yes"
 S DIR("?")="Enter 'Yes' or 'No'."
 S DIR(0)="YAO"
 S DIR("?",1)="Enter 'Yes' if the information displayed is correct."
 S DIR("?",2)="Enter 'No' if you need to edit this information."
 D ^DIR
GOEDIT ;
 ;if info is not right, use code from QANEDIT to edit just the fields
 ;in a brief incident.  There must be at least one patient/report.
 I Y=0 S QANOUT=0 D
 . D DIE^QANEDIT
 . I $O(^QA(742,"BCS",QANIEN,0))']"" D
 . . W !!,"No patients on this Incident Report - deleting Report."
 . . S DIK="^QA(742.4,",DA=QANIEN D ^DIK K DIK
 . . ;also need to remove entry from QA Audit file (#740.5)
 . . ;get most recent entry for 742 and 742.4 and if matches
 . . ;this entry, delete
 . . F QANFILE=742,742.4 D DIKAUDIT^QANEDIT(QANFILE) K QANFILE
 I $G(^QA(742.4,QANIEN,0))]"" D
 . D ^QANBRIF ;transmit message to local mail group
 . S QANCC=0
 . F  S QANCC=$O(^QA(742,"BCS",QANIEN,QANCC)) Q:QANCC'>0  D
 . . S QANPTNUM=$P(^QA(742,QANCC,0),U)
 . . S QANODE=^DPT(QANPTNUM,0)
 . . S QANAME=$P(QANODE,U)
 . . S QANSSN=$P(QANODE,U,9)
 . . D:'$D(QANF) BULL^QANUTL3
QANPID(Y) ;Function to set up Patient ID.
 N QANF,QANM,QANL
 S QANL=$P(Y(0,0),",")
 I QANL[" " D
 .S QANF=$E($P(Y(0,0),",",2))
 .S QANM=$E($P(Y(0,0)," ",3))
 .S QANPID=$G(QANF)_$G(QANM)_$E(QANL)_$E(QANSSN,6,9)
 I QANL'[" " D
 .S QANF=$E($P(Y(0,0),",",2))
 .S QANM=$E($P(Y(0,0)," ",2))
 .S QANPID=$G(QANF)_$G(QANM)_$E(QANL)_$E(QANSSN,6,9)
 Q QANPID
 Q
