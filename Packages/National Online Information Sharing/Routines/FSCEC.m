FSCEC ;SLC/STAFF-NOIS List Edit Close ;12/15/96  17:17
 ;;1.1;NOIS;;Sep 06, 1998
 ;
CLOSE(CALL,OK) ; from FSCEL, FSCLMPE1
 N CDATE,FUNC,OPER,TASK S OK=1
 D DATA(CALL,"SUMMARY",.CDATE,.FUNC,.TASK,.OPER)
 I OPER'="ACCEPT" S OK=0 W !,"Call has NOT been closed.",$C(7) H 2 Q
 D CLOSE^FSCEF(CALL,"SUMMARY",CDATE,FUNC,TASK)
 Q
 ;
DATA(CALL,TYPE,CDATE,FUNC,TASK,OPER) ; from FSCEB
 N OK
 S CDATE=$$CDATE^FSCEUD(DUZ) S:$P(CDATE,U)="P" CDATE=$P(CDATE,U,2) I $P(CDATE,U)="S" S CDATE=$$DATE^FSCU($P(CDATE,U,2))
 S FUNC=$$FUNC^FSCEUD(DUZ),FUNC=$S($P(FUNC,U)="P":$P(FUNC,U,2),1:+$O(^FSC("FUNC","B",$P(FUNC,U,2),0)))
 S TASK=$$TASK^FSCEUD(DUZ),TASK=$S($P(TASK,U)="P":$P(TASK,U,2),1:+$O(^FSC("TASK","B",$P(TASK,U,2),0)))
 S OPER="QUIT"
 D WP^FSCEU(TYPE,"Enter a resolution summary:")
 Q:'$G(^TMP("FSC TEXT",$J,TYPE))  Q:$D(DTOUT)
 D
 .I 'CDATE D CDATE^FSCECD(CALL,.CDATE,.OK) I 'OK Q
 .I 'FUNC D FUNC^FSCECD(.FUNC,.OK) I 'OK Q
 .I 'TASK D TASK^FSCECD(.TASK,.OK) I 'OK Q
 Q:$D(DTOUT)
 D COMPLETE(CALL,TYPE,.CDATE,.FUNC,.TASK,.OPER)
 Q
 ;
COMPLETE(CALL,TYPE,CDATE,FUNC,TASK,OPER) ; from FSCEDC
 N DONE,OK
 S DONE=0 F  D  Q:DONE
 .D
 ..I $G(^TMP("FSC TEXT",$J,TYPE)),CDATE,FUNC,TASK D ACCEPT(.OPER) Q
 ..D EDIT(.OPER)
 .I OPER'="EDIT" S DONE=1 Q
 .D EDITWP^FSCEU("^TMP(""FSC TEXT"","_$J_","""_TYPE_""")","Edit Resolution Summary:")
 .I '$G(^TMP("FSC TEXT",$J,TYPE)) Q
 .D CDATE^FSCECD(CALL,.CDATE,.OK) I 'OK Q
 .D FUNC^FSCECD(.FUNC,.OK) I 'OK Q
 .D TASK^FSCECD(.TASK,.OK)
 Q
 ;
EDIT(OPER) ;
 N DIR,X,Y K DIR
 S DIR(0)="YAO",DIR("A")="Incomplete information.  Do you want to edit the data? ",DIR("B")="YES"
 S DIR("?",1)="In order to close a call, you must enter all closing information."
 S DIR("?",2)="Enter YES to reedit this information."
 S DIR("?",3)="Enter NO or '^' to exit, '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I Y=1 S OPER="EDIT" Q
 S OPER="QUIT"
 Q
 ;
ACCEPT(OPER) ;
 N DIR,X,Y K DIR
 S DIR(0)="SAMO^ACCEPT:ACCEPT;EDIT:EDIT",DIR("A")="(E)dit or (A)ccept to close call: ",DIR("B")="ACCEPT"
 S DIR("?",1)="Enter ACCEPT to close this call."
 S DIR("?",2)="Enter EDIT to reedit the closing information."
 S DIR("?",3)="Enter '^' to exit without closing the call or '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I Y="EDIT" S OPER="EDIT" Q
 I Y="ACCEPT" S OPER="ACCEPT" Q
 S OPER="QUIT"
 Q
