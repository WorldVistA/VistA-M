FSCEL ;SLC/STAFF-NOIS Edit Log ;3/16/98  19:24
 ;;1.1;NOIS;;Sep 06, 1998
 ;
NEW ; from FSCLMP, FSCOPT
 N ACTION,CALLID,CALLNUM,OK,RDATE,SITE
 D ID^FSCELID(.SITE,.RDATE,.CALLID,.CALLNUM,.OK)
 I 'OK Q
 W !?5,"Call ID: ",CALLID
 I '$$ACCESS^FSCU(DUZ,"SPEC") D NEW^FSCELSNS(CALLID,CALLNUM) Q
 D NEW^FSCELS(SITE,CALLNUM)
 N CONALERT,CONTACT,CONTNAME
 S CONALERT=$$CONALERT^FSCUP
 S CONTACT=+$P(^FSCD("CALL",CALLNUM,0),U,6),CONTNAME=""
 I CONTACT S CONTNAME=$$VALUE^FSCGET(CONTACT,7100,2.1)
 I CONALERT="F" D
 .I 'CONTACT W !,"Contact person not filled in.",$C(7) H 2 D RECON^FSCELS(SITE,CALLNUM) Q
 .D ALERT(CONTACT,CALLNUM)
 I CONALERT="P" D
 .I 'CONTACT W !,"Contact person not filled in.",$C(7) H 2 D RECON^FSCELS(SITE,CALLNUM) Q
 .N DIR,X,Y K DIR
 .S DIR(0)="YAO",DIR("A")="Would "_CONTNAME_" like to automatically be alerted to edits? ",DIR("B")="NO"
 .S DIR("?",1)="Enter YES to have this contact person alerted whenever this call is edited."
 .S DIR("?",2)="Enter NO to not schedule this person for automatic alerts."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .D ^DIR K DIR
 .I Y'=1 D ALERT(CONTACT,CALLNUM)
 I $D(DTOUT) D OPEN(CALLID,CALLNUM) Q
 N DIR,X,Y K DIR
 S DIR(0)="SAMO^MAKE A NOTE:MAKE A NOTE;REFER:REFER;CLOSE:CLOSE;OPEN:OPEN",DIR("A")="Further action - (M)ake a Note, (R)efer, (C)lose, (O)pen: " S DIR("B")=$S($$CLOSE(DUZ):"CLOSE",1:"OPEN")
 S DIR("?",1)="Enter M to make a note.  The call will remain open."
 S DIR("?",2)="Enter R to change the status to Referred."
 S DIR("?",3)="Enter C to close this call."
 S DIR("?",4)="Enter O or '^' to leave this call open without making a note."
 S DIR("?",5)="Enter '??' for additional help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 S ACTION=Y
 I ACTION="OPEN"!$D(DIRUT) D OPEN(CALLID,CALLNUM)
 I ACTION="CLOSE" D
 .;D STATUS^FSCES(CALLNUM,"",1)
 .D NOTES("Make a Note (in addition to resolution summary)? ")
 .D UPDATE^FSCTASK(CALLNUM)
 .D CLOSE^FSCEC(CALLNUM,.OK) I 'OK Q
 .D STATUS^FSCES(CALLNUM,1,2)
 .D UPDATE^FSCTASK(CALLNUM)
 I ACTION="REFER" D
 .;D STATUS^FSCES(CALLNUM,"",1)
 .D UPDATE^FSCTASK(CALLNUM)
 .D STATUS^FSCES(CALLNUM,1,3)
 .D NOTES("Include a note with this status change? ")
 .D UPDATE^FSCTASK(CALLNUM)
 I ACTION="MAKE A NOTE" D
 .D NOTES("")
 .D OPEN(CALLID,CALLNUM)
 D WKLD^FSCEWKLD(CALLNUM,1)
 D LIST^FSCELL(CALLNUM)
 Q
 ;
CLOSE(USER) ; $$(user) -> 1 or 0 for default of prompt to close call
 I $P(^FSC("SPEC",USER,0),U,13) Q 1
 Q 0
 ;
NOTES(ASK) ; get notes
 N DIR,OK,OPER,X,Y K DIR
 I $L($G(ASK)) S OK=1 D  Q:'OK
 .S DIR(0)="YAO",DIR("A")=ASK,DIR("B")="NO"
 .S DIR("?",1)="Enter YES to make a note on this call."
 .S DIR("?",2)="Enter NO change the status without making a note."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .D ^DIR K DIR
 .I Y'=1 S OK=0 Q
 D DATA^FSCEN("ACTION",.OPER)
 I OPER="ACCEPT" D NOTE^FSCEF(CALLNUM,"ACTION")
 Q
 ;
ALERT(USER,CALL) ; schedule user for alert on call
 D SETUP^FSCNOT(CALL,,,USER_U_1,"ALERT","EDITED")
 Q
 ;
OPEN(CALLID,CALLNUM) ; from FSCELSNS
 ; msg if call is not closed or referred, status updated to open
 W !,"This call ("_CALLID_") will remain open."
 ;D STATUS^FSCES(CALLNUM,"",1)
 D UPDATE^FSCTASK(CALLNUM)
 H 1
 Q
