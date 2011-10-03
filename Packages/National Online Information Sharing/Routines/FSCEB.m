FSCEB ;SLC/STAFF-NOIS List Edit Batch ;8/8/97  15:05
 ;;1.1;NOIS;;Sep 06, 1998
 ;
BLIST ; from FSCLMP
 N CHOICE S CHOICE=1_"-"_+$G(^TMP("FSC LIST CALLS",$J))
 D BATCH(CHOICE)
 Q
 ;
BVIEW ; from FSCLMP
 N CHOICE S CHOICE=$G(^TMP("FSC SELECT",$J,"VVALUES"))
 D BATCH(CHOICE)
 Q
 ;
BATCH(CHOICE) ;
 N ACTION,OK
 D ACTION(.ACTION,.OK) I 'OK Q
 D SELECT^FSCUL(CHOICE,"",CHOICE,"EVALUES",.OK)
 I '$G(^TMP("FSC SELECT",$J,"EVALUES")) Q
 I ACTION="NOTE" D NOTE("EVALUES") Q
 I ACTION="CLOSE" D CLOSE("EVALUES") Q
 Q
 ;
NOTE(LOCATION) ;
 N CALL,CALLLINE,OK,OPER,NUM
 D DATA^FSCEN("NOTE",.OPER)
 I OPER'="ACCEPT" Q
 S NUM=0 F  S NUM=$O(^TMP("FSC SELECT",$J,LOCATION,NUM)) Q:NUM<1  D
 .S CALLLINE=+$O(^TMP("FSC LIST CALLS",$J,"IDX",NUM,0))
 .S CALL=+$O(^TMP("FSC LIST CALLS",$J,"ICX",CALLLINE,0))
 .W !,$$SHORT^FSCGETS(CALL,NUM)
 .D CHECK^FSCLMPE1(CALL,.OK) I 'OK Q
 .N DIR,X,Y K DIR
 .S DIR(0)="YA0",DIR("A")="OK to add the note to this call? ",DIR("B")="YES"
 .S DIR("?",1)="Enter YES to add this note to the call."
 .S DIR("?",2)="Enter NO to skip this call without adding a note."
 .S DIR("?",3)="Enter '^' to stop processing or '??' for more help."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .D ^DIR K DIR
 .I Y'=1 Q
 .D NOTE^FSCEF(CALL,"NOTE")
 .D UPDATE^FSCAUDIT(CALL)
 .D UPDATE^FSCTASK(CALL)
 Q
 ;
CLOSE(LOCATION) ;
 N CALL,CALLLINE,CDATE,FROM,FUNC,OK,OPER,NUM,TASK
 D DATA^FSCEC("","SUMMARY",.CDATE,.FUNC,.TASK,.OPER)
 I OPER'="ACCEPT" Q
 S NUM=0 F  S NUM=$O(^TMP("FSC SELECT",$J,LOCATION,NUM)) Q:NUM<1  D
 .S CALLLINE=+$O(^TMP("FSC LIST CALLS",$J,"IDX",NUM,0))
 .S CALL=+$O(^TMP("FSC LIST CALLS",$J,"ICX",CALLLINE,0))
 .W !,$$SHORT^FSCGETS(CALL,NUM)
 .D CHECK^FSCLMPE1(CALL,.OK) I 'OK Q
 .N DIR,X,Y K DIR
 .S DIR(0)="YA0",DIR("A")="OK to close this call? ",DIR("B")="YES"
 .S DIR("?",1)="Enter YES to close this call with your entries."
 .S DIR("?",2)="Enter NO to skip this call without closing the call."
 .S DIR("?",3)="Enter '^' to stop processing or '??' for more help."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .D ^DIR K DIR
 .I Y'=1 Q
 .S FROM=+$$STATCALL^FSCESU(CALL)
 .D CLOSE^FSCEF(CALL,"SUMMARY",CDATE,FUNC,TASK)
 .D STATUS^FSCES(CALL,FROM,2)
 .D UPDATE^FSCTASK(CALL)
 Q
 ;
ACTION(ACTION,OK) ;
 N DIR,X,Y K DIR S OK=1
 S DIR(0)="SAMO^NOTE:NOTE;CLOSE:CLOSE",DIR("A")="(C)lose calls or make (N)otes on calls: "
 S DIR("?",1)="Enter CLOSE to make entries to close calls."
 S DIR("?",2)="Enter NOTE to add a note to calls."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I Y="NOTE" S ACTION="NOTE" Q
 I Y="CLOSE" S ACTION="CLOSE" Q
 S ACTION="",OK=0
 Q
