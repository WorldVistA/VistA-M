HLCS1 ;ALB/JRP - OPTIONS FOR BACKGROUND FILERS ;10/15/98  10:44
 ;;1.6;HEALTH LEVEL SEVEN;**19**;Oct 13, 1995
 ;
STARTDEF ;Entry point used by OPTION file to task default number of each filer
 N PTRMAIN,ONENODE,DEFCNT,CURCNT,LOOP
 ;Get entry in HL COMMUNICATION SERVER PARAMETER file (#869.3)
 S PTRMAIN=+$O(^HLCS(869.3,0))
 I ('PTRMAIN) D  Q
 .W $C(7)
 .W !!,"Entry in HL COMMUNICATION SERVER PARAMETER file (#869.3) has"
 .W !,"not been made.  Entry must be made in order to start execute"
 .W !,"this option.",!!
 ;Get zero node of parameter file
 S ONENODE=$G(^HLCS(869.3,PTRMAIN,1))
 ;Get default number of incoming filers (piece 1 of node 1)
 S DEFCNT=+$P(ONENODE,"^",1)
 I ('DEFCNT) D
 .;No default value found
 .S DEFCNT=1
 .W $C(7)
 .W !!,"Default number of incoming servers has not been entered into"
 .W !,"the HL COMMUNICATION SERVER PARAMETER file (#869.3).  Will use"
 .W !,"a value of ",DEFCNT,".",!!
 ;Get current number of incoming filers running
 S CURCNT=$$CNTFLR^HLCSUTL2("IN")
 I ((CURCNT>DEFCNT)!(CURCNT=DEFCNT)) D
 .;No more incoming filers needed
 .W $C(7)
 .W !!,"Default number of incoming servers is set to ",DEFCNT," and"
 .W !,CURCNT," incoming servers are currently running.  No more"
 .W !,"incoming servers will be started.",!!
 I (CURCNT<DEFCNT) D
 .;Start DEFCNT-CURCNT incoming filers
 .F LOOP=1:1:(DEFCNT-CURCNT) D STARTIN
 W !
 ;Get default number of outgoing filers (piece 2 of node 1)
 S DEFCNT=+$P(ONENODE,"^",2)
 I ('DEFCNT) D
 .;No default value found
 .S DEFCNT=1
 .W $C(7)
 .W !!,"Default number of outgoing servers has not been entered into"
 .W !,"the HL COMMUNICATION SERVER PARAMETER file (#869.3).  Will use"
 .W !,"a value of ",DEFCNT,".",!!
 ;Get current number of outgoing filers running
 S CURCNT=$$CNTFLR^HLCSUTL2("OUT")
 I ((CURCNT>DEFCNT)!(CURCNT=DEFCNT)) D
 .;No more outgoing filers needed
 .W $C(7)
 .W !!,"Default number of outgoing servers is set to ",DEFCNT," and"
 .W !,CURCNT," outgoing servers are currently running.  No more"
 .W !,"outgoing servers will be started.",!!
 I (CURCNT<DEFCNT) D
 .;Start DEFCNT-CURCNT outgoing filers
 .F LOOP=1:1:(DEFCNT-CURCNT) D STARTOUT
 W !
 Q
STARTIN ;Entry point used by OPTION file to task an incoming filer
 N TASKNUM
 S TASKNUM=$$TASKFLR("IN")
 W:(TASKNUM) !,"Incoming filer queued as task number ",TASKNUM
 W:('TASKNUM) $C(7),!!,"Unable to queue incoming filer"
 Q
STARTOUT ;Entry point used by OPTION file to task an outgoing filer
 N TASKNUM
 S TASKNUM=$$TASKFLR("OUT")
 W:(TASKNUM) !,"Outgoing filer queued as task number ",TASKNUM
 W:('TASKNUM) $C(7),!!,"Unable to queue outgoing filer"
 Q
STOPIN ;Entry point used by OPTION file to stop an incoming filer
 N PTRSUB,FLRLST
 ;Get list of filers
 D GETFLRS^HLCSUTL2("IN","FLRLST")
 ;No filers running
 I ('$D(FLRLST)) W $C(7),!!,"No incoming filers are running",!! Q
 ;Get first filer out of list
 S PTRSUB=+$O(FLRLST(0))
 I ('PTRSUB) W $C(7),!!,"No incoming filers are running",!! Q
 ;Stop incoming filer
 D STOPFLR^HLCSUTL1(PTRSUB,"IN")
 W !!,"Incoming filer queued as task number ",+FLRLST(PTRSUB)," has been asked to stop",!!
 Q
STOPOUT ;Entry point used by OPTION file to stop an outgoing filer
 N PTRSUB,FLRLST
 ;Get list of filers
 D GETFLRS^HLCSUTL2("OUT","FLRLST")
 ;No filers running
 I ('$D(FLRLST)) W $C(7),!!,"No outgoing filers are running",!! Q
 ;Get first filer out of list
 S PTRSUB=+$O(FLRLST(0))
 I ('PTRSUB) W $C(7),!!,"No outgoing filers are running",!! Q
 ;Stop filer
 D STOPFLR^HLCSUTL1(PTRSUB,"OUT")
 W !!,"Outgoing filer queued as task number ",+FLRLST(PTRSUB)," has been asked to stop",!!
 Q
STOPAIN ;Entry point used by OPTION file to stop all incoming filers
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;Make sure user wants to stop all filers
 S DIR(0)="YA"
 S DIR("A")="Are you sure you want to stop all incoming filers ? "
 S DIR("B")="NO"
 S DIR("?",1)="Stopping all incoming filers will prevent messages being"
 S DIR("?",2)="received through Logical Links from being passed to the"
 S DIR("?",3)="appropriate application.  Answer 'YES' if you really want"
 S DIR("?")="this to occur."
 W !!
 D ^DIR
 I (($D(DIRUT))!('$G(Y))) W !!,"Incoming filers will not be stopped",!! Q
 ;Stop all filers
 W !!,"Please wait while all incoming filers are asked to stop ..."
 D STOPALL("IN")
 W !,"All incoming filers have been asked to stop",!!
 Q
STOPAOUT ;Entry point used by OPTION file to stop all outgoing filers
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;Make sure user wants to stop all filers
 S DIR(0)="YA"
 S DIR("A")="Are you sure you want to stop all outgoing filers ? "
 S DIR("B")="NO"
 S DIR("?",1)="Stopping all outgoing filers will prevent messages from"
 S DIR("?",2)="being transmitted to external systems through Logical"
 S DIR("?")="Links.  Answer 'YES' if you really want this to occur."
 W !!
 D ^DIR
 I (($D(DIRUT))!('$G(Y))) W !!,"Outgoing filers will not be stopped",!! Q
 ;Stop all filers
 W !!,"Please wait while all outgoing filers are asked to stop ..."
 D STOPALL("OUT")
 W !,"All outgoing filers have been asked to stop",!!
 Q
TASKFLR(FLRTYPE) ;Task an incoming/outgoing filer
 ;INPUT  : FLRTYPE - Flag denote type of filer to start
 ;                   IN - Incoming filer (default)
 ;                   OUT - Outgoing filer
 ;OUTPUT : ZTSK (results of call to TaskMan)
 ;
 ;Check input
 S FLRTYPE=$G(FLRTYPE)
 ;Declare variables
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK,TMP
 S ZTIO=""
 S ZTDTH=$H
 ;Task incoming filer
 S ZTRTN="STARTIN^HLCSIN"
 S ZTDESC="HL7 Incoming Filer"
 ;Task outgoing filer
 I (FLRTYPE="OUT") D
 .S ZTRTN="STARTOUT^HLCSOUT"
 .S ZTDESC="HL7 Outgoing Filer"
 ;Call TaskMan
 S ZTSK=0
 D ^%ZTLOAD
 S ZTSK=+$G(ZTSK)
 ;Not tasked
 Q:('ZTSK)
 ;Create entry in HL COMMUNICATION SERVER PARAMETER file
 S TMP=$$CRTFLR^HLCSUTL1(ZTSK,FLRTYPE)
 ;Return task number
 Q ZTSK
STOPALL(FLRTYPE) ;Stop all incoming/outgoing filers
 ;INPUT  : FLRTYPE - Flag denote type of filer to start
 ;                   IN - Incoming filer (default)
 ;                   OUT - Outgoing filer
 ;OUTPUT : None
 ;
 ;Check input
 S FLRTYPE=$G(FLRTYPE)
 S:((FLRTYPE'="OUT")&(FLRTYPE'="IN")) FLRTYPE="IN"
 ;Declare variables
 N PTRSUB,FLRLST
 ;Get list of filers
 D GETFLRS^HLCSUTL2(FLRTYPE,"FLRLST")
 ;No filers running
 Q:('$D(FLRLST))
 ;Loop through list of filers, stopping each
 S PTRSUB=0
 F  S PTRSUB=+$O(FLRLST(PTRSUB)) Q:('PTRSUB)  D STOPFLR^HLCSUTL1(PTRSUB,FLRTYPE)
 Q
EDITPRAM ;Entry point used by OPTION file to edit file 869.3
 ;Declare variables
 N DIC,X,Y,DTOUT,DUOUT,DLAYGO,DIE,DA,DR
 ;Create/find entry HL COMMUNICATION SERVER PARAMETER file (#869.3)
 S DLAYGO=869.3
 S DIC="^HLCS(869.3,"
 S DIC(0)="L"
 S DIC("DR")="11///1;12///1"
 S X=1
 D ^DIC
 ;Error
 I (Y="-1") D  Q
 .W !!,"Unable to create/find entry in HL COMMUNICATION SERVER"
 .W !,"PARAMETER file (#869.3).  Entry must exist in order for"
 .W !,"the incoming & outgoing filers to run.  Use FileMan to"
 .W !,"create an initial entry for editing.",!!
 ;Entry created
 I ($P(Y,"^",3)) D
 .;Tell user entry was created
 .W !!,"Initial entry in HL COMMUNICATION SERVER PARAMETER file"
 .W !,"(#869.3) has been created.",!
 ;Edit parameters
 S DIE="^HLCS(869.3,"
 S DA=+Y
 S DR="11Default number of incoming filers;12Default number of outgoing filers"
 D ^DIE
 Q
