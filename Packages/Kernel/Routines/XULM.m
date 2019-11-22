XULM ;IRMFO-ALB/CJM/SWO/RGG - KERNEL LOCK MANAGER ;12/09/2012
 ;;8.0;KERNEL;**608**;JUL 10, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 ;  ******************************************************************
 ;  *                                                                *
 ;  *  The Kernel Lock Manager is based on the VistA Lock Manager    *
 ;  *        developed by Tommy Martin.                              *
 ;  *                                                                *
 ;  ******************************************************************
 ;
 ;
MAIN ;Main Program
 N XUPARMS,ERROR,NODE,WHERETO,RESULT,VALMIOXY,VALMSGR,VALMWD,XWBCRLFL,NIO
 ;
 N $ETRAP,$ESTACK S $ETRAP="G ERROR^XULM"
 ;
 I $$VERSION^%ZOSV(1)'["Cache" W !,"This application is for Cache systems only!" D PAUSE^XULMU QUIT
 ;
 ;Automatic update of HOSTS IP addresses
 ;D GETIP^XULMU
 ;
 I '$$GETPARMS^XULMP(.XUPARMS,.ERROR) W:$L($G(ERROR)) !,ERROR Q
 I 'XUPARMS("ON?") W "This application has been disabled. Please contact the application manager.",!! D PAUSE^XULMU Q
 S XUPARMS("LOCKS")=$NA(^XTMP("XULM",$J,"LOCKS",0)) ;location where lock table is placed
 S XUPARMS("LOCK INDICES")=$NA(^XTMP("XULM",$J,"LOCK IDX",0)) ;indices on @XUPARMS@(LOCKS)
 I (XUPARMS("NODES")>1)!'$D(XUPARMS("NODES",$$NODE^XULMU)) D  Q:ERROR
 .N LOGIN
 .I '$$LOGIN(.LOGIN,.ERROR) W:$L(ERROR) !,ERROR S ERROR=1 Q
 .S XUPARMS("LOGIN")=LOGIN
 Q:'$$GETLOCKS(.XUPARMS)
 W !!,"Building the display screen...."
 D
 .N IDX,LOCKS,XUENTRY,XULMEXIT,XUTOPIC
 .S XULMEXIT=0
 .S LOCKS=XUPARMS("LOCKS"),IDX=XUPARMS("LOCK INDICES")
 .D EN^VALM("XULM LOCK MANAGER")
 ;
 K ^XTMP("XULM",$J)
 D FULL^VALM1
 Q
 ;
GETLOCKS(PARMS) ; query each & every node for its lock table
 N NODE,QUIT,IDX,LOCKS
 S LOCKS=PARMS("LOCKS"),IDX=PARMS("LOCK INDICES")
 K @LOCKS,@IDX,PARMS("REPORTING NODES")
 W !!,"Compiling the locks..."
 S NODE="",QUIT=0
 F  S NODE=$O(PARMS("NODES",NODE)) Q:NODE=""  D  Q:QUIT
 .I $$SAMENODE^XULMU(NODE) D
 ..;
 ..;Don't need the M-to-M broker to run RPC on this node!
 ..I $$LOCKS^XULMRPC("",LOCKS,,0) S PARMS("REPORTING NODES",$$NODE^XULMU)=""
 .E  D
 ..;
 ..;need to use the broker
 ..N CONNECT,ERROR,RPTNODE
 ..N $ETRAP,$ESTACK S $ETRAP="G ERROR2^XULM"
 ..S CONNECT=0
 ..L +@LOCKS@("XULM REPORTED NODE"):1 L -@LOCKS@("XULM REPORTED NODE")
 ..K @LOCKS@("XULM REPORTED NODE")
 ..L +@LOCKS@("XULM REPORTED NODE"):1 L -@LOCKS@("XULM REPORTED NODE")
 ..D
 ...S CONNECT=$$LOCKRPC(NODE,PARMS("NODES",NODE,"IP ADDRESS"),PARMS("NODES",NODE,"PORT"),PARMS("LOGIN"),LOCKS,.ERROR)
 ...I CONNECT D
 ....L +@LOCKS@("XULM REPORTED NODE"):1 L -@LOCKS@("XULM REPORTED NODE")
 ....I '$L($G(@LOCKS@("XULM REPORTED NODE"))) D
 .....N I F I=1:1:5 Q:$L($G(@LOCKS@("XULM REPORTED NODE")))
 ....S RPTNODE=$G(@LOCKS@("XULM REPORTED NODE"))
 ....Q:'$L(RPTNODE)
 ....I NODE'=RPTNODE,'$D(PARMS("REPORTING NODES",RPTNODE)) D
 .....N DA,DATA
 .....S DA(1)=1,DA=PARMS("NODES",NODE)
 .....S DATA(.01)=RPTNODE
 .....D UPD^XULMU(8993.11,.DA,.DATA)
 .....M PARMS("NODES",RPTNODE)=PARMS("NODES",NODE)
 .....K PARMS("NODES",NODE)
 ....S PARMS("REPORTING NODES",RPTNODE)=""
 ..I 'CONNECT,'$D(PARMS("REPORTING NODES",NODE)) W !,"Failed to connect to node '"_NODE_"': ",ERROR I '$$ASKYESNO^XULMU("Continue with lock display","YES") S QUIT=1 Q
 ;
 ;
 ;match against the LOCK DICTIONARY and set indices
 D:'QUIT
 .N LOCK,OWNER,PID,NODE
 .S LOCK=""
 .L +@LOCKS:5 L -@LOCKS
 .F  S LOCK=$O(@LOCKS@(LOCK)) Q:LOCK=""  D
 ..;
 ..S NODE=""
 ..F  S NODE=$O(@LOCKS@(LOCK,NODE)) Q:NODE=""  D
 ...;set the OWNER and PID index
 ...S OWNER=$P(@LOCKS@(LOCK,NODE,"OWNER"),"^",2)
 ...S:$L(OWNER) @IDX@("OWNER",OWNER_"^"_+@LOCKS@(LOCK,NODE,"OWNER"),LOCK,NODE)=""
 ...S PID=@LOCKS@(LOCK,NODE,"PID")
 ...S:$L(PID) @IDX@("PID",PID,LOCK,NODE)="",@IDX@("PID",PID)=1+$G(@IDX@("PID",PID))
 ...;
 ...N TEMPLATE,FILES,VARS
 ...S TEMPLATE=$$FIND^XULMLD(LOCK,.FILES,.VARS)
 ...I TEMPLATE D
 ....S @LOCKS@(LOCK,NODE,"TEMPLATE")=TEMPLATE
 ....M @LOCKS@(LOCK,NODE,"FILES")=FILES,@LOCKS@(LOCK,NODE,"VARIABLES")=VARS
 ....;
 ....;set index on the file references
 ....S FILES="" F  S FILES=$O(FILES(FILES)) Q:'FILES  S @IDX@("FILE",FILES,LOCK,NODE)=""
 Q 'QUIT
 ;
LOGIN(LOGIN,ERROR) ;
 S ERROR=""
 D
 .N OPTION
 .I '$D(DUZ)#2 S ERROR="Your DUZ is not defined." Q
 .I '$D(^XUSEC("XULM LOCKS",DUZ)) S ERROR="You do not hold the XULM LOCKS security key." Q
 .; 
 .; Check for user having context option
 .S OPTION=$O(^DIC(19,"B","XULM RPC BROKER CONTEXT",0))
 .I 'OPTION S ERROR="The application XULM RPC BROKER CONTEXT option was not found." Q
 .I '$D(^VA(200,DUZ,203,"B",OPTION)) S ERROR="You do not have access to the XULM RPC BROKER CONTEXT option." Q
 .;
 Q:$L(ERROR) 0
 Q $$ASKAV(.LOGIN)
 ;
ASKAV(LOGIN) ; Ask user for access and verify code, return in LOGIN
 N OK,CNT,XUF,XUSTMP
 D
 .S (OK,XUF)=0
 .S XUSTMP(51)="ACCESS CODE:",XUSTMP(52)="VERIFY CODE:"
 .F CNT=1:1:3 D  Q:OK
 ..W !!,"Please enter your VistA access and verify codes.",!
 ..X ^%ZOSF("EOFF") S LOGIN=$$ASKAV^XUS() X ^%ZOSF("EON")
 ..Q:LOGIN="^;^"
 ..S OK=$$CHECKAV^XUS(LOGIN)
 ..I OK=0 D  Q
 ...W !,"Invalid access/verify code pair"
 ...I CNT<3,'$$ASKYESNO^XULMU("Try again","YES") S CNT=4
 ..;S ACCESS=$$ENCRYP^XUSRB1($P(LOGIN,";")),VERIFY=$$ENCRYP^XUSRB1($P(LOGIN,";",2))
 Q OK
 ;
LOCKRPC(NODE,IP,PORT,LOGIN,GLOBAL,XULMERR) ;
 ;Run the XULM LOCKS RPC on the specified system
 ;
 N TMP,DIVISION,XURESULT
 K XULMERR S XULMERR=""
 K ^TMP("XWBM2ME",$J,"ERROR")
 ;before trying to logon, check if port can be opened
 I '$$TEST(NODE,IP,PORT) S XULMERR="RPC Server appears to not be running" Q 0
 D
 .I '$$CONNECT^XWBM2MC(PORT,IP,LOGIN) S XULMERR="Connection error: Port, IP or server logon error." Q
 .I '$$SETCONTX^XWBM2MC("XULM RPC BROKER CONTEXT") S XULMERR="Type 'B' option does not exist on the VistA server." Q
 .I '$$GETDIV^XWBM2MC("DIVISION") S XULMERR="Division error: Could not find the user's division." Q
 .I '$$SETDIV^XWBM2MC(DIVISION(1)) S XULMERR="Division error: Could not setup the user's division." Q
 .D
 ..S XULMERR="Unable to execute the remote procedure = 'XULM GET LOCK TABLE'!"
 ..S TMP($J,"TYPE")="STRING",TMP($J,"VALUE")=GLOBAL
 ..Q:'$$PARAM^XWBM2MC(1,$NA(TMP($J)))
 ..;
 ..S XURESULT=$NA(^XTMP("XULM",$J,"RPC RESULT",0)) ;@XURESULT is where the RPCs place a return value
 ..S TMP($J,"TYPE")="STRING",TMP($J,"VALUE")=XURESULT
 ..Q:'$$PARAM^XWBM2MC(2,$NA(TMP($J)))
 ..;
 ..Q:'$$CALLRPC^XWBM2MC("XULM GET LOCK TABLE",,1)
 ..S XULMERR=""
 ;
 D CLOSE^XWBM2MC()
 U $PRINCIPAL
 D HOME^%ZIS
 Q:$L(XULMERR) 0
 Q 1
 ;
KILLRPC(IP,PORT,LOGIN,PID,ERROR) ;
 ;Run the XULM KILL PROCESS RPC on the specified system
 ;
 N TMP,DIVISION,XURESULT
 S XURESULT=$NA(^XTMP("XULM",$J,"RPC RESULT",0)) ;@XURESULT is where the RPCs place a return value
 K ERROR S ERROR=""
 D
 .N ERRCNT S ERRCNT=0
 .I '$$CONNECT^XWBM2MC(PORT,IP,LOGIN) S ERROR="Connection error: Port, IP or server logon error." Q
 .I '$$SETCONTX^XWBM2MC("XULM RPC BROKER CONTEXT") S ERROR="Type 'B' option does not exist on the VistA server." Q
 .I '$$GETDIV^XWBM2MC("DIVISION") S ERROR="Division error: Could not find the user's division." Q
 .I '$$SETDIV^XWBM2MC(DIVISION(1)) S ERROR="Division error: Could not setup the user's division." Q
 .D
 ..S TMP($J,"TYPE")="STRING",TMP($J,"VALUE")=PID
 ..I '$$PARAM^XWBM2MC(1,$NA(TMP($J))) S ERROR="Call to PARAM^XQBM2MC filed while trying to execute the remote procedure XULM KILL PROCESS,",ERROR(1)="PID="_PID Q
 ..;
 ..S TMP($J,"TYPE")="STRING",TMP($J,"VALUE")=XURESULT
 ..I '$$PARAM^XWBM2MC(2,$NA(TMP($J))) S ERROR="Call to PARAM^XQBM2MC failed while trying to execute the remote procedure XULM KILL PROCESS,",ERROR(1)="XURESULT="_XURESULT Q
 ..;
 ..I '$$CALLRPC^XWBM2MC("XULM KILL PROCESS",,1) S ERROR="Call to CALLRPC^XQBM2MC failed while trying to execute the remote procedure",ERROR(1)="XULM KILL PROCESS, PID="_PID_" ,XURESULT="_XURESULT Q
 ..S ERROR=""
 ;
 D CLOSE^XWBM2MC()
 U $PRINCIPAL
 D HOME^%ZIS
 Q:$L(ERROR) 0
 Q 1
 ;
ERROR ;
 S $ETRAP="Q:$QUIT """"  Q"
 K XUPARMS("LOGIN"),LOGIN,PARMS("LOGIN")
 Q:$QUIT ""
 Q
 ;
ERROR2 ;
 S $ETRAP="Q:$QUIT """"  Q"
 S ERROR=$ZE
 S $ECODE=""
 S CONNECT=0
 U $PRINCIPAL
 Q:$QUIT "" Q
 Q
TEST(NODE,IP,SOCK) ;Tests if the port can be opened - waits only 2 seconds.
 ;If not, asks user if  he wants to try to connect anyway - can take
 ;60 seconds.
 ;
 N POP,TO,OK
 S TO=2
 D CONT^%ZISTCP
 S OK='POP
 D CLOSE^%ZISTCP
 U $PRINCIPAL
 I 'OK D
 .W !,"Node '"_NODE_"' does not appear to be a valid system name, please correct"
 .W !,"if necessary. This node will not be included in the Lockmanager list."
 .S OK=$$ASKYESNO^XULMU("Would you like to try to connect anyway (could take a long while)?","NO")
 .I OK=0 K PARMS("NODE",NODE)
 Q OK
EXIT ;clean up and exit
 K ^XTMP("XULM",$J)
 Q
