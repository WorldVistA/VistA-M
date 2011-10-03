FSCELSNS ;SLC/STAFF-NOIS Edit Log Setup Non Specialist ;10/13/96  23:56
 ;;1.1;NOIS;;Sep 06, 1998
 ;
NEW(CALLID,CALLNUM) ; from FSCEL
 N ACTION,DA,DIE,DONE,DR,PH,X,Y
 S ACTION="",DONE=0,PH=$$PH^FSCELS(DUZ)
 S DA=CALLNUM,DIE="^FSCD(""CALL"","
 S DR="2.1T///`"_DUZ_";3T;1T;30Request Description;2.2T"_$S($L(PH):"//"_PH,1:"")_";6T//ROUTINE"
 F  D  I DONE Q
 .L +^FSCD("CALL",CALLNUM):30 I '$T D SOMEONE^FSCLMPE1 S DONE=1 Q
 .D ^DIE
 .L -^FSCD("CALL",CALLNUM)
 .I $D(DTOUT) S ACTION="TIMEOUT",DONE=1 Q
 .N DIR,X,Y K DIR
 .S DIR(0)="SAMO^EDIT:EDIT;CANCEL:CANCEL;FILE:FILE"
 .S DIR("A",1)=""
 .S DIR("A")="Further action - (E)dit, (C)ancel, or (F)ile: "
 .S DIR("?",1)="Enter E to be re-edit this information."
 .S DIR("?",2)="Enter C to be cancel this call."
 .S DIR("?",3)="Enter F or '^' to file this information."
 .S DIR("?",4)="Enter '??' for additional help."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .S DIR("B")=$$DEFAULT(CALLNUM)
 .I DIR("B")="EDIT" W !,"Warning - a Module\Version # should be entered.",$C(7)
 .D ^DIR
 .I Y="EDIT" S DR="3T;1T;30Request Description;2.2T;6T" Q
 .S ACTION=Y,DONE=1
 .I $D(DTOUT) S ACTION="TIMEOUT"
 K DIR
 I ACTION="CANCEL" D  Q
 .;D STATUS^FSCES(CALLNUM,"",1)
 .D UPDATE^FSCTASK(CALLNUM)
 .D STATUS^FSCES(CALLNUM,1,99)
 .D UPDATE^FSCTASK(CALLNUM)
 .W !,"This call ("_CALLID_") has been cancelled."
 D OPEN^FSCEL(CALLID,CALLNUM)
 N NSALERT S NSALERT=$$NSALERT^FSCUP
 I NSALERT="F" D
 .N CALLS K CALLS S CALLS(CALLNUM)=""
 .D BENOTIFY^FSCLMPNB(DUZ,.CALLS,"ALERT","EDITED")
 .W !,"You will be alerted whenever this call is edited."
 I ACTION="TIMEOUT" Q
 I NSALERT'="P" Q
 N DIR,X,Y K DIR
 S DIR(0)="SAMO^EDITED:EDITED;STATUS CHANGED:STATUS CHANGED;NONE:NONE"
 S DIR("A",1)=""
 S DIR("A",2)="You can be alerted whenever this request is acted on."
 S DIR("A")="Receive notification when (E)dited, (S)tatus changed, or (N)one: ",DIR("B")="EDITED"
 S DIR("?",1)="Enter E to be alerted when this request is edited."
 S DIR("?",2)="Enter S to be alerted when this requests status changes."
 S DIR("?",3)="Enter N to not receive alerts."
 S DIR("?",4)="Enter '??' for additional help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I Y="EDITED"!(Y="STATUS CHANGED") D
 .N CALLS K CALLS S CALLS(CALLNUM)=""
 .D BENOTIFY^FSCLMPNB(DUZ,.CALLS,"ALERT",Y)
 Q  ; *** remove this line to allow E3Rs
 N DIR,X,Y K DIR
 S DIR(0)="SAMO^PROBLEM:PROBLEM;ENHANCEMENT:ENHANCEMENT",DIR("A")="This request concerns a (P)roblem or (E)nhancement? ",DIR("B")="PROBLEM"
 S DIR("?",1)="Enter P to log a problem."
 S DIR("?",2)="Enter E to log an enhnacement request."
 S DIR("?",3)="Enter '??' for additional help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I Y="PROBLEM"!$D(DIRUT) D OPEN^FSCEL(CALLID,CALLNUM) Q
 ;D STATUS^FSCES(CALLNUM,"",1)
 D UPDATE^FSCTASK(CALLNUM)
 D STATUS^FSCES(CALLNUM,1,3)
 D UPDATE^FSCTASK(CALLNUM)
 D STATUS^FSCES(CALLNUM,3,5)
 D UPDATE^FSCTASK(CALLNUM)
 Q
 ;
DEFAULT(CALL) ;
 I '$L($G(^FSCD("CALL",CALL,1))),'$P($G(^(0)),U,8),'$O(^(30,0)) Q "CANCEL"
 I '$P($G(^FSCD("CALL",CALL,0)),U,8) Q "EDIT"
 Q "FILE"
