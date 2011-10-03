FSCNAS ;SLC/STAFF NOIS Notification Alert Send ;1/11/98  18:41
 ;;1.1;NOIS;;Sep 06, 1998
 ;
ALERT(MSG) ; from FSCLMPNN
 Q:'$D(MSG)
 N DELIVERY,OK,RECIP,TYPE K ^TMP("FSCCALLS",$J),RECIP S OK=1
 D
 .D CALLS(.OK) I 'OK Q
 .D TYPE(.TYPE,.OK) I 'OK Q
 .I TYPE="OTHERS" D
 ..D RECIP(.RECIP,.OK)
 ..S DELIVERY=""
 .E  D
 ..S RECIP(DUZ)="" ;$$VALUE^FSCGET(DUZ,7100,2.1)
 ..D DELIVER(.DELIVERY,.OK)
 .I 'OK Q
 .D SEND(MSG,.RECIP,DELIVERY,.OK)
 I 'OK W !!,"Alert was NOT sent."
 E  W !!,"Alert sent."
 K ^TMP("FSCCALLS",$J),RECIP H 2
 Q
 ;
CALLS(OK) ;
 N CALL,CHOICE,DIR,LISTNUM,Y K DIR S OK=1
 I '+@VALMAR Q
 S DIR(0)="YAO",DIR("A")="Do you want to include "_$S($D(^TMP("FSC SELECT",$J,"EVALUES")):"this call",1:"calls")_" with the alert? ",DIR("B")="YES"
 S DIR("?",1)="Enter YES to include calls with alert."
 S DIR("?",2)="Enter NO to not include calls with the alert."
 S DIR("?",3)="Enter '^' to exit without making changes or '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) S OK=0 Q
 I Y D  I 'OK Q
 .D
 ..I $D(^TMP("FSC SELECT",$J,"EVALUES")) S CHOICE=FSCCNT_"-"_FSCCNT Q
 ..I $D(^TMP("FSC SELECT",$J,"VVALUES")) S CHOICE=^("VVALUES") Q
 ..S CHOICE="1-"_+@VALMAR
 .D SELECT^FSCUL(CHOICE,"",CHOICE,"NVALUES",.OK)
 .I 'OK Q
 .S LISTNUM=0 F  S LISTNUM=$O(^TMP("FSC SELECT",$J,"NVALUES",LISTNUM)) Q:LISTNUM<1  S CALL=$$CALL^FSCLMPE1(LISTNUM),^TMP("FSCCALLS",$J,CALL)=""
 I $D(DIRUT) S OK=0 Q
 Q
TYPE(TYPE,OK) ;
 N DIR,Y K DIR S OK=1
 S DIR(0)="SAMO^YOURSELF:YOURSELF;OTHERS:OTHERS",DIR("B")="OTHERS"
 S DIR("A")="Will alert be sent to (Y)ourself or to (O)thers: "
 S DIR("?",1)="Enter Y to send alert this alert to yourself at a later date."
 S DIR("?",2)="Enter O to have alert sent to others immediately."
 S DIR("?",3)="Note: Alerts sent to others can only be sent immediately."
 S DIR("?",4)="      Alerts sent to yourself can be scheduled for later delivery."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) S OK=0 Q
 S TYPE=Y
 Q
 ;
RECIP(RECIP,OK) ;
 N DEL,DIR,DONE,X,Y K DIR,RECIP S OK=1
 S DIR(0)="FAO^1:32",DIR("A")="Send to: "
 S DIR("?",1)="Enter the persons to whom you want to send alerts."
 S DIR("?",2)="You can also enter mail groups."
 S DIR("?",3)="Enter 'return' or '^' to exit, '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 S DONE=0 F  D  Q:DONE
 .D ^DIR
 .I $D(DIRUT) S DONE=1 Q
 .I '$L(Y) S DONE=1 Q
 .S Y=$$UP^XLFSTR(Y)
 .S DEL=0 I $E(Y)="-" S (X,Y)=$E(Y,2,245),DEL=1
 .I '$L(Y) W "  ??",$C(7) Q
 .I DEL,'$D(RECIP) W "  ??",$C(7) Q
 .D
 ..I $E(Y,1,2)="G." D  Q
 ...N DIC K DIC
 ...S X=$E(Y,3,99),DIC=3.8,DIC(0)="EMQ" D ^DIC K DIC I Y<1 Q
 ...I 'DEL S RECIP("G."_$P(Y,U,2))="" ;"G."_$P(Y,U,2)
 ...E  D
 ....I $D(RECIP("G."_$P(Y,U,2))) K RECIP("G."_$P(Y,U,2)) W "  Deleted."
 ....E  W "  ??  <not previously selected>",$C(7)
 ..N DIC K DIC
 ..S X=Y,DIC=200,DIC(0)="EMQ" D ^DIC K DIC I Y<1 Q
 ..I 'DEL S RECIP(+Y)="" ;$P(Y,U,2)
 ..E  D
 ...I $D(RECIP(+Y))#2 K RECIP(+Y) W "  Deleted."
 ...E  W "  ??  <not previously selected>",$C(7)
 .S DIR("A")="And send to: "
 K DIR I $D(DTOUT) S OK=0
 I '$L($O(RECIP(0))) S OK=0
 Q
 ;
DELIVER(DELIVERY,OK) ;
 N DIR,FUTURE,LIMIT,Y K DIR S OK=1
 S LIMIT=180,FUTURE=$$FMADD^XLFDT(DT,LIMIT)
 S DIR(0)="DAO^DT:"_FUTURE_":EX",DIR("A")="Enter delivery date: ",DIR("B")="T"
 S DIR("?",1)="Enter the delivery date for this alert."
 S DIR("?",2)="This date can range from TODAY to T+"_LIMIT_" ("_$$FMTE^XLFDT(FUTURE)_")."
 S DIR("?")="^D HELP^%DTC,HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) S OK=0 Q
 S DELIVERY=Y
 Q
 ;
SEND(XQAMSG,XQA,DELIVERY,OK) ;
 N ALERT,CALL,DIR,XQADATA,XQAID,XQAROU,Y K DIR S OK=1
 I $L(DELIVERY) S XQAMSG=XQAMSG_" from: Yourself, sent: "_$$FMTE^XLFDT(DT)
 E  S XQAMSG=XQAMSG_" from: "_$$VALUE^FSCGET(DUZ,7100,2.1)
 I DELIVERY=DT S DELIVERY=""
 S DIR(0)="YAO",DIR("A")="Send this alert? ",DIR("B")="YES"
 S DIR("?",1)="Enter YES to send this alert."
 S DIR("?",2)="Enter NO or '^' to exit or '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) S OK=0 Q
 I Y'=1 S OK=0 Q
 D NEWALERT^FSCNOTS(DUZ,,XQAMSG,.ALERT,DELIVERY)
 S CALL=0 F  S CALL=$O(^TMP("FSCCALLS",$J,CALL)) Q:CALL<1  D NEWSEND(ALERT,CALL)
 I DELIVERY Q
 S XQADATA=ALERT,XQAROU="ALERT^FSCNAR",XQAID="FSC-M"
 D SETUP^XQALERT
 Q
 ;
NEWSEND(ALERT,CALL) ; from FSCRPCN
 N DA,DIK,NUM
 S NUM=1+$P(^FSCD("SEND",0),U,3)
 L +^FSCD("SEND",0):30 I '$T Q  ; *** needs ok
 F  Q:'$D(^FSCD("SEND",NUM,0))  S NUM=NUM+1
 S ^FSCD("SEND",NUM,0)=ALERT_U_CALL
 S $P(^FSCD("SEND",0),U,3)=NUM,$P(^(0),U,4)=$P(^(0),U,4)+1
 L -^FSCD("SEND",0)
 S DIK="^FSCD(""SEND"",",DA=NUM D IX1^DIK
 Q
