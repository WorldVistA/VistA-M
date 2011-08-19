QACALRT2 ;HISC/DAD-RESEND/KILL ALERT ;7/12/95  15:20
 ;;2.0;Patient Representative;**9**;07/25/1995
 ;
 F  D  Q:QACD0'>0
 . K DIC S DIC="^QA(745.1,",DIC(0)="AEMNQZ"
 . S DIC("A")="Select CONTACT NUMBER: "
 . S DIC("S")="I ($P(^QA(745.1,+Y,7),""^"",2)=""O""),(($D(^XUSEC(""QAC EDIT"",DUZ))#2)!(DUZ=$P(^QA(745.1,+Y,0),U,7)))"
 . W ! D ^DIC S QACD0=+Y
 . I QACD0'>0 Q
 . F  D  Q:QACVA200'>0
 .. K DIR S DIR(0)="POA^200:AEMNQZ",DIR("A")="Select REFER CONTACT TO: "
 .. S DIR("?")="^D HELP^QACALRT2"
 .. W ! D ^DIR S QACVA200=+$G(Y),QACVA200(0)=$G(Y(0,0))
 .. I $D(DIRUT) Q
 .. D ALERT
 .. Q
 . Q
EXIT ;
 K D0,D1,DA,DD,DIC,DIK,DINUM,DIR,DIRUT,DLAYGO,DO,DTOUT,DUOUT,QACACTN
 K QACD0,QACD1,QACLINE,QACQUIT,QACREMOV,QACVA200,X,Y
 Q
 ;
ALERT ;
 K DIR S DIR(0)="SOM^S:Send alert;K:Kill alert;"
 S DIR("A")="Alert action"
 S DIR("?",1)="  Enter (S)end to generate a new alert."
 S DIR("?",2)="  Enter (K)ill to kill a pre-existing alert."
 S DIR("?")="  Enter a code from the list above."
 W ! D ^DIR S QACACTN=$G(Y)
 I $D(DIRUT) Q
 I QACACTN="S" D SET^QACALRT0(QACVA200,QACD0) Q
 I QACACTN="K" D KILL^QACALRT0(QACVA200,QACD0) Q
HELP ;
 W !!,"Entries in the REFER CONTACT TO field:"
 I $O(^QA(745.1,QACD0,11,0))'>0 W !?3,"None" Q
 S QACD1=0 K ^TMP("QACALRT2",$J)
 F  S QACD1=$O(^QA(745.1,QACD0,11,QACD1)) Q:QACD1'>0  D
 . S QACVA200=+$P($G(^QA(745.1,QACD0,11,QACD1,0)),U)
 . S QACVA200(0)=$P($G(^VA(200,QACVA200,0)),U)
 . I QACVA200(0)]"" S ^TMP("QACALRT2",$J,QACVA200)=QACVA200(0)
 . Q
 S (QACVA200,QACQUIT)=0,QACLINE=$Y
 F  S QACVA200=$O(^TMP("QACALRT2",$J,QACVA200)) Q:QACVA200'>0!QACQUIT  D
 . W !?3,QACVA200,?19,^TMP("QACALRT2",$J,QACVA200)
 . I $Y>(IOSL+QACLINE-3) D
 .. W !,"Press RETURN to continue or '^' to exit: "
 .. R QACQUIT:DTIME S:'$T QACQUIT=U S QACQUIT=$S($E(QACQUIT)=U:1,1:0)
 .. S QACLINE=$Y
 .. Q
 . Q
 K ^TMP("QACALRT2",$J)
 Q
