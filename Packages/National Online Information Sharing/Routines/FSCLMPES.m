FSCLMPES ;SLC/STAFF-NOIS List Manager Protocol Edit Status ;5/14/97  10:16
 ;;1.1;NOIS;;Sep 06, 1998
 ;
STATUS ; from FSCLMP
 N CALLNUM,OK,OLDSTAT,REOPEN,STATUS
 S CALLNUM=$$CALL^FSCLMPE1(FSCCNT)
 S OLDSTAT=$$STATCALL^FSCESU(CALLNUM)
 I '$$ACCESS(DUZ,CALLNUM,+OLDSTAT) D  Q
 .W !,"You do not have access to change the status of this call." H 2
 I 'OLDSTAT D STATUS^FSCES(CALLNUM,"",1) D UPDATE^FSCEU(CALLNUM) W !,"This call did not have a complete status.  The status is now OPEN.",$C(7) H 2 Q
 W !,"Current Status is ",$P(OLDSTAT,U,3)
 S STATUS=+OLDSTAT
 D ASK(.STATUS,.REOPEN,.OK)
 I 'OK Q
 I STATUS=2 D RES^FSCLMPE1 Q
 I REOPEN D REOPEN(.OK) I 'OK Q
 I REOPEN D GOODWKLD^FSCEWKLD(CALLNUM)
 D STATUS^FSCES(CALLNUM,+OLDSTAT,STATUS,REOPEN)
 I STATUS=6 D PATCH(CALLNUM,.OK) I 'OK D UPDATE^FSCEU(CALLNUM) Q
 D NOTE(.OK) I OK D
 .N OPER
 .D DATA^FSCEN("ACTION",.OPER)
 .I OPER="TIMEOUT" Q
 .I OPER="QUIT" Q
 .I OPER="ACCEPT" D NOTE^FSCEF(CALLNUM,"ACTION")
 I STATUS=99 D BADWKLD^FSCEWKLD(CALLNUM)
 E  D WKLD^FSCEWKLD(CALLNUM,1)
 D UPDATE^FSCEU(CALLNUM)
 Q
 ;
ACCESS(USER,CALL,STATUS) ; $$(user,call,status) -> 1 to allow editing else 0
 I $$ACCESS^FSCU(USER,"SPEC") Q 1
 I '(STATUS=2!(STATUS=99)) Q 0
 I USER=$P($G(^FSCD("CALL",CALL,0)),U,6) Q 1
 I USER=$P($G(^FSCD("CALL",CALL,120)),U,20) Q 1
 Q 0
 ;
PATCH(DA,OK) ;
 N DIE,DR,X,Y S OK=1
 S DIE="^FSCD(""CALL"",",DR=7
 D ^DIE
 I $D(DTOUT) S OK=0
 Q
 ;
NOTE(OK) ;
 N DIR,X,Y K DIR S OK=0
 S DIR(0)="YAO",DIR("A")="Include a note with this status change? ",DIR("B")="NO"
 S DIR("?",1)="Enter YES to make a note on this call."
 S DIR("?",2)="Enter NO change the status without making a note."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I Y=1 S OK=1
 Q
 ;
ASK(STATUS,REOPEN,OK) ;
 N DIC,X,Y K DIC
 S (OK,REOPEN)=0
 I '$G(STATUS) Q
 I STATUS=2!(STATUS=99) S (OK,REOPEN,STATUS)=1 Q  ; closed or cancelled can only be reopened
 S DIC=7106.1,DIC(0)="AEMOQ",DIC("A")="Select Status: "
 S DIC("S")="I $D(^FSC(""STATUS"",STATUS,1,""B"",+Y))"
 D ^DIC K DIC
 I Y<1 Q
 S OK=1,STATUS=+Y
 Q
 ;
REOPEN(OK) ;
 N DIR,X,Y K DIR S OK=0
 S DIR(0)="YAO",DIR("A")="Are you sure you want to REOPEN this call? ",DIR("B")="NO"
 S DIR("?",1)="Enter YES to reopen this call.  The status will return to open"
 S DIR("?",2)="allowing editing, referrals, etc."
 S DIR("?",3)="Enter NO or '^' to exit without reopening the call, '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I Y=1 S OK=1
 Q
