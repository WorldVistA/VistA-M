FSCEN ;SLC/STAFF-NOIS Edit Note ;1/11/96  13:42
 ;;1.1;NOIS;;Sep 06, 1998
 ;
NOTE ; from FSCLMP
 N CALL,OK,OPER
 S CALL=$$CALL^FSCLMPE1(FSCCNT)
 D CHECK^FSCLMPE1(CALL,.OK) I 'OK Q
 D DATA("ACTION",.OPER)
 I OPER="TIMEOUT" Q
 I OPER="QUIT" Q
 I OPER="ACCEPT" D
 .D NOTE^FSCEF(CALL,"ACTION")
 .D WKLD^FSCEWKLD(CALL)
 .D UPDATE^FSCEU(CALL)
 Q
 ;
DATA(TYPE,OPER) ; from FSCEB, FSCEDC, FSCEL, FSCLMPES
 N DONE S OPER="QUIT"
 D WP^FSCEU(TYPE,"Enter a new note:")
 I '$G(^TMP("FSC TEXT",$J,TYPE)) Q
 S DONE=0 F  D  Q:DONE
 .N DIR,X,Y K DIR
 .S DIR(0)="SAMO^ACCEPT:ACCEPT;EDIT:EDIT",DIR("A")="(E)dit or (A)ccept note: ",DIR("B")="ACCEPT"
 .S DIR("?",1)="Enter ACCEPT to add this note to the call."
 .S DIR("?",2)="Enter EDIT to reedit your note."
 .S DIR("?",3)="Enter '^' to exit without making a note or '??' for more help."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .D ^DIR K DIR
 .I $D(DIRUT) S DONE=1 Q
 .I Y="ACCEPT" S DONE=1,OPER="ACCEPT" Q
 .I Y="EDIT" D EDITWP^FSCEU("^TMP(""FSC TEXT"","_$J_","""_TYPE_""")","Edit Note:") Q
 Q
