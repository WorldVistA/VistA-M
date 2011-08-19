QACALRT1 ;HISC/DAD-PROCESS AN ALERT ;3/23/95  10:22
 ;;2.0;Patient Representative;**3,7,6,9,12**;07/25/1995
EN ;
 N QACDATE
 K QACDELET
 S QACX=$P(XQADATA,U),QACD0=$P(XQADATA,U,2),QACDUZ=$P(XQADATA,U,3)
 S QACXQAID=$P(XQAID,";")
 ;
 ; Display contact information when alert processed.
 S QAC=QACD0,QACRES=0 D START1^QACRPT
 ;
 S QAC=$S($D(^QA(745.1,QACD0,0))[0:1,$P($G(^(7)),U,2)="C":2,1:0)
 I QAC D  G EXIT
 . W !!?5,"*** The Patient Rep record associated with this alert"
 . W ?63,"***",!?5,"*** has been ",$P("deleted^closed",U,QAC)
 . W ".  No response needed, killing alert.",?63,"***",$C(7)
 . D KILLALRT
 . Q
 ;
 I $O(^XTMP(QACXQAID,"TXT",0)) D
 . W !!?5,"*** You have an unsent response to this alert. ***",$C(7)
 . Q
 ;
 ; Alert action (Respond / Ignore / Delete / Print)
 K DIR S QACACTN=""
 F  D  Q:QACACTN]""
 . S DIR(0)="SOM^R:Respond;I:Ignore;D:Delete;P:Print"
 . S DIR("A")="Alert action"
 . S DIR("?",1)="  Enter (R)espond to enter your response to this alert."
 . S DIR("?",2)="  Enter (I)gnore to save this alert for a later response."
 . S DIR("?",3)="  Enter (D)elete to delete this alert without a response."
 . S DIR("?",4)="  Enter (P)rint to print the report of contact."
 . S DIR("?")="  Enter one of the codes listed above."
 . W ! D ^DIR S QACACTN=$S($D(DIRUT):U,1:Y)
 . I QACACTN="P" D
 .. S QAC=QACD0,QACRES=0
 .. N QACD0,QACX,QACXQAID
 .. D EN^QACRPT
 .. S QACACTN="",DIR("B")="Ignore"
 .. Q
 . Q
 I (QACACTN="I")!(QACACTN=U) D SAVEALRT
 I QACACTN="D" S QACDELET=1 D RESPOND,KILLALRT
 I QACACTN="R" D RESPOND
 G EXIT
 ;
RESPOND ; Get user's response
 I $O(^XTMP(QACXQAID,"TXT",0))'>0 K ^XTMP(QACXQAID)
 K DIC,DIWEPSE,DTOUT,DWLW,DWPK
 S ^XTMP(QACXQAID,0)=$$FMADD^XLFDT(DT,14)_U_DT
 I $G(QACDELET)<1 D
 . S DIC="^XTMP("""_QACXQAID_""",""TXT"","
 . D EN^DIWE
 I $G(QACDELET)=1 D DELMSG
 I $O(^XTMP(QACXQAID,"TXT",0))'>0 K ^XTMP(QACXQAID) D SAVEALRT Q
 I $D(DTOUT) D  Q
 . W $C(7),!
 . W !?5,"***     You have timed out while entering a response.     ***"
 . W !?5,"*** The text can be recovered if you re-enter the alert.  ***"
 . W !?5,"*** If not, it will be automatically purged in two weeks. ***"
 . D SAVEALRT
 . Q
 S QACX(0)=$P($G(^VA(200,QACX,0)),U) I QACX(0)="" S QACX(0)="UNKNOWN"
 S QACHDR="***  "_$$FMTE^XLFDT($$NOW^XLFDT,"2PS")_"  "_QACX(0)_"  ***"
 S ^XTMP(QACXQAID,"TXT",.1,0)=""
 S ^XTMP(QACXQAID,"TXT",.2,0)=QACHDR
 S ^XTMP(QACXQAID,"TXT",.3,0)=""
 ; Save user's response
 W !!,"Saving your response, please wait . . . "
 K ^TMP("QACALRT1",$J)
 S %X="^XTMP("""_QACXQAID_""",""TXT"","
 S %Y="^TMP(""QACALRT1"",$J,"
 D %XY^%RCR
 S ZTRTN="TASK^QACALRT1",ZTDESC="Patient Rep resolution comments update"
 S (ZTSAVE("QACD0"),ZTSAVE("^TMP(""QACALRT1"",$J,"),ZTIO)="",ZTDTH=$H
 S (ZTSAVE("QACX"),ZTSAVE("QACDUZ"))=""
 S ZTSAVE("QACDELET")=""
 D ^%ZTLOAD
 W "Done"
KILLALRT ; Kill this alert
 K ^XTMP(QACXQAID)
 S XQAKILL=1
 Q
SAVEALRT ; Do not kill this alert
 K XQAKILL
 Q
 ;
TASK ; Tasked entry point
 F  L +^QA(745.1,QACD0):5 Q:$T  H 5
 I $D(^QA(745.1,QACD0,0))[0 L -^QA(745.1,QACD0) G EXIT
 S (QACD1,QACD1(0))=0
 F  S QACD1=$O(^QA(745.1,QACD0,6,QACD1)) Q:QACD1'>0  S QACD1(0)=QACD1
 S (QACTMP,QACOUNT)=0
 F  S QACTMP=$O(^TMP("QACALRT1",$J,QACTMP)) Q:QACTMP'>0  D
 . S QACOUNT=QACOUNT+1
 . S ^QA(745.1,QACD0,6,QACD1(0)+QACOUNT,0)=^TMP("QACALRT1",$J,QACTMP,0)
 . Q
 S QACOUNT=QACOUNT+1
 S ^QA(745.1,QACD0,6,QACD1(0)+QACOUNT,0)=""
 S QACOUNT=QACOUNT+1
 S ^QA(745.1,QACD0,6,QACD1(0)+QACOUNT,0)="***  End of response  ***"
 S QACWPHDR=$G(^QA(745.1,QACD0,6,0))
 S $P(QACWPHDR,U,3)=($P(QACWPHDR,U,3)+QACOUNT)
 S $P(QACWPHDR,U,4)=($P(QACWPHDR,U,4)+QACOUNT)
 S $P(QACWPHDR,U,5)=DT
 S ^QA(745.1,QACD0,6,0)=QACWPHDR
 L -^QA(745.1,QACD0)
 S QACX(0)=$P($G(^VA(200,+QACX,0)),U) S:QACX(0)="" QACX(0)="UNKNOWN"
 S QACCASE=$P($G(^QA(745.1,+QACD0,0)),U) S:QACCASE="" QACCASE="UNKNOWN"
 S XQA(+QACDUZ)=""
 S XQAMSG="Patient Rep response by "_QACX(0)_" to "_QACCASE_"."
 I $G(QACDELET)=1 S XQAMSG="Patient Rep Alert "_QACCASE_" deleted by "_QACX(0)_"."
 D SETUP^XQALERT
 ;D SET^QACALRT0(+QACDUZ,QACD0)
EXIT ;
 S:$D(ZTQUEUED) ZTREQ="@"
 K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,QAC,QACACTN,QACCASE,QACD0,QACD1
 K QACDUZ,QACEE,QACHDR,QACOUNT,QACRES,QACTMP,QACWPHDR,QACX,QACXQAID,X,Y
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,^TMP("QACALRT1",$J),%X,%Y
 Q
DELMSG ;If user deletes an alert on a report of contact a message is sent
 ;as if it were a response to the alert.  It will be stored in the 
 ;Resolution Comments field.
 S $P(^XTMP(QACXQAID,"TXT",0),U,5)=DT
 F QACEE=3,4  S $P(^XTMP(QACXQAID,"TXT",0),U,QACEE)=$P(^XTMP(QACXQAID,"TXT",0),U,QACEE)+1
 S Y=DT D DD^%DT S QACDATE=Y
 S QACNAME=$P($P(^VA(200,DUZ,0),U),",",2)_" "_$P($P(^VA(200,DUZ,0),U),",")
 S ^XTMP(QACXQAID,"TXT",1,0)="VA Alert on Report of Contact "_$P(QACXQAID,"-",2)_" deleted by "_QACNAME_" on "_QACDATE
 Q
