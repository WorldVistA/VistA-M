FSCEDC ;SLC/STAFF-NOIS List Edit Duplicate Close ;12/15/96  17:00
 ;;1.1;NOIS;;Sep 06, 1998
 ;
CLOSE(CALLNUM,OLDCALL,OLDV,STATUS) ; from FSCED
 N CDATE,DA,DIE,DONE,DR,EDIT,FUNC,OK,OPER,TASK,TYPE
 W !,"This call is copied from a call that was closed."
 W !,"If you wish to edit or make a note on this call before proceeding"
 W !,"to close this call, you may do so now."
 S DONE=0 F  D  Q:DONE
 .D EDIT(.EDIT) I EDIT="ACCEPT"!$D(DIRUT) S DONE=1 Q
 .I EDIT="EDIT" D
 ..S DA=CALLNUM,DIE="^FSCD(""CALL"",",DR="1R;2.1R;2.2R;3;5R;6R;30;"
 ..L +^FSCD("CALL",CALLNUM):1 I '$T D SOMEONE^FSCLMPE1 Q
 ..D ^DIE
 ..L -^FSCD("CALL",CALLNUM)
 ..I $D(DTOUT) S DONE=1
 .I EDIT="NOTE" D
 ..D DATA^FSCEN("ACTION",.OPER)
 ..I OPER="TIMEOUT" S DONE=1 Q
 ..I OPER="QUIT" Q
 ..I OPER="ACCEPT" D NOTE^FSCEF(CALLNUM,"ACTION")
 I EDIT'="ACCEPT" S STATUS=1
 Q:$D(DTOUT)  Q:$D(DIRUT)
 S TYPE="SUMMARY" M ^TMP("FSC TEXT",$J,TYPE)=^FSCD("CALL",OLDCALL,80)
 S ^TMP("FSC TEXT",$J,TYPE)=+$P(^FSCD("CALL",OLDCALL,80,0),U,3)
 S CDATE=$$CDATE^FSCEUD(DUZ) S:$P(CDATE,U)="P" CDATE=$P(CDATE,U,2) I $P(CDATE,U)="S" S CDATE=$$DATE^FSCU($P(CDATE,U,2))
 I 'CDATE D CDATE^FSCECD(CALLNUM,.CDATE,.OK) I 'OK Q
 S FUNC=+OLDV("FUNC"),TASK=+OLDV("TASK")
 D COMPLETE^FSCEC(CALLNUM,TYPE,.CDATE,.FUNC,.TASK,.OPER)
 I OPER'="ACCEPT" S STATUS=1 Q
 D CLOSE^FSCEF(CALLNUM,TYPE,CDATE,FUNC,TASK)
 Q
 ;
EDIT(EDIT) ;
 N DIR,X,Y K DIR
 S DIR(0)="SAMO^EDIT:EDIT;NOTE:NOTE;ACCEPT:ACCEPT",DIR("A")="(E)dit, make a (N)ote, or (A)ccept: ",DIR("B")="ACCEPT"
 S DIR("?",1)="Enter EDIT to edit the call (this does not include the close data)."
 S DIR("?",2)="Enter NOTE to add a note to the call."
 S DIR("?",3)="Enter ACCEPT to proceed to closing the call."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 S EDIT=Y
 Q
