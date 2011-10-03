QANEDIT ;WCIOFO/ERC-Edit a Brief Incident ;4/22/99
 ;;2.0;Incident Reporting;**27,26,32**;08/07/1992;Build 3
 ;
START ;
 W @IOF
 N QANBFLG,QANIEN,QANNOPAT
 F  W !!,"Do you want to edit one of your open Incident Reports" S %=1 D YN^DICN Q:"-112"[%  W !!,"Enter (Y)es, (N)o or ""^"" to exit"
 I %=1 D EDIT
 K QANXIT
 Q
EDIT ;
 K ^TMP("QAN EDIT")
 S QANCNT=1
 S QANDUZ=DUZ
 S QANEE=0
 F  S QANEE=$O(^QA(742.4,"ACS",1,QANEE)) Q:QANEE'>0  D
 . I QANDUZ=$P(^QA(742.4,QANEE,0),U,5) S ^TMP("QAN EDIT",$J,QANCNT,QANEE)="",QANCNT=QANCNT+1
 W @IOF
 I '$D(^TMP("QAN EDIT")) D  Q
 . W !!,"**** You have no open Incident Reports to edit.  Exiting.",!!
 W !!,"Here are your open Incident Reports."
 S QANEE=0
 S QANTOT=0
 F  S QANEE=$O(^TMP("QAN EDIT",$J,QANEE)) Q:QANEE'>0  D
 . S QANIEN=$O(^TMP("QAN EDIT",$J,QANEE,0)) Q:QANIEN'>0
 . S QAN0=^QA(742.4,QANIEN,0)
 . S QANCC=0,QANCNT=1
 . S QANTOT=QANTOT+1 ;gets number of IRs for selecting record to edit
 . F  S QANCC=$O(^QA(742,"BCS",QANIEN,QANCC)) Q:QANCC'>0  D
 . . S QANNAME=$P(^DPT($P(^QA(742,QANCC,0),U),0),U)
 . . S Y=$P(QAN0,U,3) D DD^%DT S QANDATE=Y
 . . S QANINC=$P(^QA(742.1,$P(QAN0,U,2),0),U)
 . . I $Y>(IOSL-6) K DIR S DIR(0)="E" D ^DIR K DIR W @IOF
 . . I QANCNT=1 W !,QANEE,?4,QANDATE,?25,$E(QANINC,1,25),?51,QANNAME
 . . I QANCNT>1 W !?51,QANNAME
 . . S QANCNT=QANCNT+1
DIR ;
 I $G(QANTOT)=1 S QANIEN=$O(^TMP("QAN EDIT",$J,1,0)) G DIE
 K DIR
 S DIR(0)="NOA"
 S DIR("A")="Select a number from 1 to "_QANTOT_": "
 D ^DIR K DIR Q:$D(DIRUT)!(+Y<1)
 I +Y>QANTOT W !,"Number selected must be from 1 to "_QANTOT_", try again." G DIR
 S QANIEN=$O(^TMP("QAN EDIT",$J,+Y,0))
 I $G(QANIEN)]"",($D(^QA(742.4,QANIEN,0))) D
 . L +^QA(742.4,QANIEN):5 I '$T W !!,"Another user is editing this record." Q
 . S QANEDFLG=1
 . D DIE
 . I $O(^QA(742,"BCS",QANIEN,0))']"" D
 . . ;if no patients entered, delete the incident
 . . W !!,"No patients on this Incident Report - deleting Report."
 . . S DIK="^QA(742.4,",DA=QANIEN D ^DIK K DIK
 . D EXIT
 Q
DIE ;
 W !!
 N QANCNT,QANEE
 S QANEFLG=0
 S QANEE=0
 S QANCNT=1
 F  S QANEE=$O(^QA(742,"BCS",QANIEN,QANEE)) Q:QANEE'>0  D
 . S QANPAT(QANCNT)=QANEE
 . S QANCNT=QANCNT+1
 K DIE S DIE="^QA(742.4,",DA=QANIEN,DR=".02;.03;.04"
 D ^DIE K DIE
 L -^QA(742.4,QANIEN)
PAT ;edit patient(s) on report
 ;if no patients entered go directly to PTADD
 I $O(^QA(742,"BCS",QANIEN,0))']"" G PTADD
 K QANPNAM,QANPNUM
 W !,"Patient(s) on this Incident Report."
 S QANEE=0
 S QANCNT=1
 F  S QANEE=$O(QANPAT(QANEE)) Q:QANEE'>0  D
 . S QANPNUM(QANEE)=$P(^QA(742,QANPAT(QANEE),0),U)
 . S QANPNAM(QANEE)=$P(^DPT(QANPNUM(QANEE),0),U)
 . W !?5,QANCNT,"  ",QANPNAM(QANEE)
 . S QANCNT=QANCNT+1
 S DIR("A")="Is this correct"
 S DIR("B")="YES"
 S DIR(0)="Y"
 D ^DIR K DIR Q:$D(DIRUT)
 I Y<1 D
 . S DIR(0)="Y",DIR("A")="Would you like to add a patient"
 . S DIR("B")="YES"
 . K DIRUT
 . D ^DIR K DIR Q:$D(DIRUT)
 . I Y=1 D PTADD S (QANEFLG,QANEDFLG)=1 Q
 . ;deleting patients from record only allowed if editing a new record
 . I $G(QANBFLG)'=1 Q
 . K DIR S DIR(0)="Y",DIR("A")="Would you like to delete a patient"
 . S DIR("B")="NO"
 . K DIRUT
 . D ^DIR K DIR Q:$D(DIRUT)
 . I Y=1 D PTDEL S (QANEFLG,QANEDFLG)=1
 ;if the user has deleted all patients and has not re-entered one,
 ;exit the subroutine (a message will be displayed & the record deleted)
 I $G(QANNOPAT)=1 K QANNOPAT Q
 I $G(QANEFLG)=1 S QANEFLG=0 G PAT
 ;if no patients on report skip description and witnessed and quit
 I $O(^QA(742,"BCS",QANIEN,0))']"" Q
 K DIE S DIE="^QA(742.4,",DR=".05;.08"
 D ^DIE K DIE
 Q
PTADD ;
 K DIC S DIC="^DPT(",DIC(0)="QEAMNZ",DIC("A")="Select Patient: ",DIC("W")="W "" "",$P(^(0),U,9)",D="B^BS5"
 D MIX^DIC1 K DIC
 I +Y<1 S QANXIT=1 Q
 F  D  Q:"-12"[%
 . W !?5,$G(Y(0,0))_" OK"
 . S %=1 D YN^DICN Q:"-12"[%
 . W " Confirm that this is the correct patient."
 I %=-1 S QANXIT=1 Q
 I %=2 W " ??" G PTADD
 S QANEE=0
 F  S QANEE=$O(QANPNUM(QANEE)) Q:QANEE'>0  D
 . I +Y=QANPNUM(QANEE) W !!,$C(7),$P(^DPT(+Y,0),U)_" has been previously entered for this incident." K Y S QANXFLG=1 Q
 I $G(QANXFLG)=1 S QANXFLG=0 G PTADD
 I $D(^DPT(+Y,.35)),$P(^DPT(+Y,.35),U)]"",($P(^DPT(+Y,.35),U)<$P(^QA(742.4,QANIEN,0),U,3)) W !!,$C(7),"The date of death for patient: "_$P(^DPT(+Y,0),U)_" precedes the incident date." K Y G PTADD
 S QANPIEN=+Y,QANZERO=Y(0),QANAME=Y(0,0),QANSSN=$P(QANZERO,U,9),^UTILITY($J,"QAN PAT",+Y)=""
 S QANDOB=$P(^DPT(QANPIEN,0),U,3)
 I QANDOB]"" S X=DT,X1=X,X2=QANDOB,X="" D:X2 ^%DTC S X=X\365.25,QANAGE=X
 S QANPSDO(0)=Y(0),QANPSDO(0,0)=Y(0,0)
 S QANPID=$$QANPID^QANCDNT(.Y)
 D ADMDT^QANUTL1
 K DIC,DD,DO,DINUM,DLAYGO S DLAYGO=742,DIC="^QA(742,",DIC(0)="L",X=QANPIEN D FILE^DICN K DIC,DD,DO,DINUM,DLAYGO
 I +Y=-1,($G(QANFLAG)) S QANXIT=1 Q
 S QANDFN=+Y
 S $P(^QA(742,QANDFN,0),U,2,6)=QANPID_U_QANIEN_U_QANADMDT_U_QANINPAT_U_QANWARD
 S $P(^QA(742,QANDFN,0),U,7)=QANTRSP,$P(^QA(742,QANDFN,0),U,12)=1
 S DIK="^QA(742,",DA=QANDFN D IX1^DIK K DA,DIK
 S QANNUM=$O(QANPAT(" "),-1)+1
 S QANPAT(QANNUM)=QANDFN
 S QANPNUM(QANNUM)=QANPIEN
 S QANPNAM(QANNUM)=QANAME
 S QANFLAG=1 D:'$D(QANF) BULL^QANUTL3
 K QAUDIT S QAUDIT("FILE")="742^50",QAUDIT("DA")=QANDFN,QAUDIT("ACTION")="e",QAUDIT("COMMENT")="Edit a brief patient record" D ^QAQAUDIT
 Q
PTDEL ;
 S QANCC=0
 F  S QANCC=$O(QANPNUM(QANCC)) Q:QANCC'>0  D
 . S QANNUM=QANCC
 . W !?5,QANCC_"   "_QANPNAM(QANCC)
 I '$G(QANNUM) S QANXIT=1 Q
 S DIR(0)="NOA"
 S DIR("A")="Delete which patient number: "
 D ^DIR K DIR Q:$D(DIRUT)
 I $G(QANPNAM(+Y))']"" W !!?5,"Choice must be one of the displayed numbers." G PTDEL
 I Y>QANNUM W !!?5,"Answer must be a number less than ",QANNUM+1 G PTDEL
 I Y<1 S QANXIT=1 Q
 S QANTEMP=+Y
 S QANDFN=QANPAT(+Y)
 S QANAME=QANPNAM(+Y)
 S DIK="^QA(742,",DA=QANPAT(+Y) D ^DIK
 ;D BULL^QANUTL3
 ;K QAUDIT S QAUDIT("FILE")="742^50",QAUDIT("DA")=QANDFN,QAUDIT("ACTION")="d",QAUDIT("COMMENT")="Delete a brief patient record" D ^QAQAUDIT
 K QANPAT(QANTEMP),QANPNUM(QANTEMP),QANPNAM(QANTEMP)
 ;if there are no patients on the report set a flag and go back to PTADD
 I $O(^QA(742,"BCS",QANIEN,0))']"" W !!,"You must have at least one patient on an incident report." S QANNOPAT=1 G PTADD
 G PTDEL
 Q
EXIT ;
 K QAN0,QANADMDT,QANCC,QANCNT,QANDATE,QANDFN,QANDOB,QANEE
 K QANEDFLG,QANELFG,QANFLAG,QANIEN,QANINC,QANAME,QANNAME,QANNOPAT
 K QANNUM,QANPAT,QANPID,QANPIEN,QANPNAM,QANPNUM,QANPSDO,QANTEMP
 K QANTOT,QANTRSP,QANXFLG,QANXIT,QANY,QANZERO
 Q
DIKAUDIT(QANFIL) ;
 ;deletes the entries for this Incident Report from
 ;the QA Audit file.  Input is the QA file (742 for the patient,
 ;742.4 for the incident).
 ;
 S QANID=$S(QANFIL=742:QANDFN,1:QANIEN)
 S QANEE=$O(^QA(740.5,"B",QANFIL," "),-1)+1
 F  S QANEE=$O(^QA(740.5,"B",QANFIL,QANEE),-1) Q:QANEE'>0  I $P(^QA(740.5,QANEE,0),U,2)=QANID S QANAUD=QANID Q
 I $G(QANAUD)]"" D
 . S DIK="^QA(740.5,",DA=QANEE
 . D ^DIK K DIK
 . K QANID,QANAUD,QANEE
 Q
