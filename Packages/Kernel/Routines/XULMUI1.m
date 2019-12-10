XULMUI1 ;IRMFO-ALB/CJM/SWO/RGG - KERNEL LOCK MANAGER ;11/29/2012
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
 ;
INIT ; Build list for displaying a single lock = XULMLOCK
 N OWNER,LOCK,PID
 K @VALMAR
 S VALMCNT=0
 D ADD("Node: "_XULMNODE),CNTRL^VALM10(VALMCNT,1,5,IOINHI,IOINORM)
 D ADD("Lock:  "_XULMLOCK),CNTRL^VALM10(VALMCNT,1,5,IOINHI,IOINORM)
 D ADD("Full Reference: "_@LOCKS@(XULMLOCK,XULMNODE)),CNTRL^VALM10(VALMCNT,1,15,IOINHI,IOINORM)
 S PID=@LOCKS@(XULMLOCK,XULMNODE,"PID")
 D ADD("Process ID (decimal): "_PID),CNTRL^VALM10(VALMCNT,1,21,IOINHI,IOINORM)
 D ADD("Process ID (hex): "_$$HEX^XULMU(PID)),CNTRL^VALM10(VALMCNT,1,17,IOINHI,IOINORM)
 S OWNER=@LOCKS@(XULMLOCK,XULMNODE,"OWNER")
 I $P(OWNER,"^",2)="{?}" S $P(OWNER,"^",2)="unavailable"
 D ADD("User Name: "_$$LJ($P(OWNER,"^",2),40)_"   DUZ: "_$S(+OWNER:$P(OWNER,"^"),1:"")),CNTRL^VALM10(VALMCNT,1,10,IOINHI,IOINORM),CNTRL^VALM10(VALMCNT,55,4,IOINHI,IOINORM)
 D TASK(@LOCKS@(XULMLOCK,XULMNODE,"TASK"))
 D TEMPLATE($G(@LOCKS@(XULMLOCK,XULMNODE,"TEMPLATE")))
 D FILES(XULMLOCK)
 I @IDX@("PID",PID)<2 D
 .D ADD(" "),ADD("Other locks held by process:  none"),CNTRL^VALM10(VALMCNT,1,28,IOINHI,IOINORM),ADD(" ")
 E  D
 .D ADD("  "),ADD("Other locks held by process:"),CNTRL^VALM10(VALMCNT,1,28,IOINHI,IOINORM)
 .S LOCK=""
 .F  S LOCK=$O(@IDX@("PID",PID,LOCK)) Q:LOCK=""  I LOCK'=XULMLOCK D ADD("       "_LOCK)
 Q
FILES(XULMLOCK) ;
 N FILES,FILE,VARS,TEMPLATE
 S TEMPLATE=$G(@LOCKS@(XULMLOCK,XULMNODE,"TEMPLATE"))
 I 'TEMPLATE D ADD("File References: unavailable"),CNTRL^VALM10(VALMCNT,1,16,IOINHI,IOINORM) QUIT
 D ADD("File References:"),CNTRL^VALM10(VALMCNT,1,16,IOINHI,IOINORM)
 S FILE=0
 M VARS=@LOCKS@(XULMLOCK,XULMNODE,"VARIABLES"),FILES=@LOCKS@(XULMLOCK,XULMNODE,"FILES")
 D GETREFS^XULMLD(@LOCKS@(XULMLOCK,XULMNODE,"TEMPLATE"),.FILES,.VARS)
 F  S FILE=$O(FILES(FILE)) Q:'FILE  D
 .N LABEL,I
 .S LABEL=$P($G(^DIC(FILE,0)),"^")
 .Q:'$L(LABEL)
 .S LABEL="   "_LABEL_" FILE RECORD:"
 .D ADD(LABEL),CNTRL^VALM10(VALMCNT,4,($L(LABEL)-3),IOINHI,IOINORM)
 .S I=0
 .F  S I=$O(FILES(FILE,I)) Q:'I  D
 ..S LABEL=$P(FILES(FILE,I),":")_":"
 ..D ADD("      "_LABEL_"  "_$P(FILES(FILE,I),":",2,5))
 ..D CNTRL^VALM10(VALMCNT,7,$L(LABEL),IOINHI,IOINORM)
 Q
 ;
TEMPLATE(TEMPLATE,OFFSET) ;
 S OFFSET=$$RJ("",+$G(OFFSET))
 I 'TEMPLATE D ADD(OFFSET_"Lock Usage:  unavailable"),CNTRL^VALM10(VALMCNT,$L(OFFSET)+1,11,IOINHI,IOINORM) Q
 D ADD(OFFSET_"Lock Usage:"),CNTRL^VALM10(VALMCNT,1+$L(OFFSET),11,IOINHI,IOINORM)
 N NODE,SUB,FILE
 S SUB=0
 F  S SUB=$O(^XLM(8993,TEMPLATE,4,SUB)) Q:'SUB  D ADD(OFFSET_$G(^XLM(8993,TEMPLATE,4,SUB,0)))
 Q
 ;
TASK(TASK) ;
 N NODE
 I 'TASK D ADD("Task Information: unavailable"),CNTRL^VALM10(VALMCNT,1,17,IOINHI,IOINORM) Q
 S NODE=$G(^%ZTSK(TASK,0))
 D ADD("Task Information:"),CNTRL^VALM10(VALMCNT,1,17,IOINHI,IOINORM)
 D ADD("    Task#: "_$$LJ(TASK,30)),CNTRL^VALM10(VALMCNT,5,6,IOINHI,IOINORM)
 D ADD("    Started: "_$$HTE^XLFDT($P(NODE,"^",5))),CNTRL^VALM10(VALMCNT,5,8,IOINHI,IOINORM)
 D ADD("    Option: "_$P(NODE,"^",9)),CNTRL^VALM10(VALMCNT,5,7,IOINHI,IOINORM)
 D ADD("    Description: "_$G(^%ZTSK(TASK,.03))),CNTRL^VALM10(VALMCNT,5,13,IOINHI,IOINORM)
 Q
 ;
KILLPROC ;
 N PID,RETURN,ERROR
 D FULL^VALM1
 S RETURN=0
 S PID=$G(@LOCKS@(XULMLOCK,XULMNODE,"PID"))
 I PID=$J D PAUSE^XULMU("You cannot kill your own process!") Q
 I $G(@LOCKS@(XULMLOCK,XULMNODE,"SYSTEM")) W !,"You selected a system lock! Releasing a systems lock can have a",!,"widespread affect!"
 I '$$ASKYESNO^XULMU("Are you sure you want to terminate this process","NO") S VALMBCK="R" Q
 ;
 ;
 S XUPARMS("KILL")=1
 I $$SAMENODE^XULMU(XULMNODE) D
 .S RETURN=$$KILLPROC^XULMRPC(.RETURN,PID)
 E  D
 .N $ETRAP,$ESTACK S $ETRAP="G ERROR2^XULM"
 .N IP,PORT
 .S IP=$G(XUPARMS("NODES",XULMNODE,"IP ADDRESS"))
 .S PORT=$G(XUPARMS("NODES",XULMNODE,"PORT"))
 .S RETURN=0
 .I (IP="")!(PORT="") D  Q
 ..S RETURN=-1
 ..W !,"Unable to execute the KILL RPC!"
 ..W !,"The XULM LOCK MANAGER PARAMETERS file is missing the IP address/port"
 ..D PAUSE^XULMU("for "_XULMNODE_".")
 .S RETURN=$$KILLRPC^XULM(XUPARMS("NODES",XULMNODE,"IP ADDRESS"),XUPARMS("NODES",XULMNODE,"PORT"),XUPARMS("LOGIN"),PID,.ERROR)
 ;
 S VALMBCK="Q"
 I RETURN>0 D
 .;clean task from TaskMan
 .K:@LOCKS@(XULMLOCK,XULMNODE,"TASK") ^%ZTSCH("TASK",@LOCKS@(XULMLOCK,XULMNODE,"TASK"))
 .;
 .;log the process termination event
 .N LOG,DATA
 .S DATA(.01)=$$NOW^XLFDT,DATA(.02)=$G(DUZ)
 .S LOG=$$ADD^XULMU(8993.2,,.DATA) I LOG M ^XLM(8993.2,LOG,1)=@VALMAR
 .;
 .;check that the lock really is gone
 .L +@XULMLOCK:2
 .I $T D
 ..L -@XULMLOCK
 ..I $$ASKYESNO^XULMU("Process TERMINATED! Do you want to quit Lock Manager","YES") S XULMEXIT=1
 .E  D
 ..S XUPARMS("KILL")=0
 ..W !,"The RPC to terminate the process was executed."
 ..D PAUSE^XULMU("However, it appears there may still be a lock blocking access.")
 .; 
 I RETURN=0 D
 .L +@XULMLOCK:0
 .I $T D
 ..L -@XULMLOCK
 ..I $$ASKYESNO^XULMU("The lock was released! Do you want to quit Lock Manager","YES") S XULMEXIT=1
 .E  D
 ..N CNT
 ..S VALMBCK="R"
 ..S XUPARMS("KILL")=0
 ..I $D(ERROR) W !,ERROR,!,$G(ERROR(1))
 ..W !,"The RPC to terminate the process was called, but its return value"
 ..D PAUSE^XULMU("indicates failure!")
 Q
 ;
 ;
HELP ; -- help code
 N COUNT,LINE
 D CLEAR^VALM1
 F COUNT=1:1:24 S LINE=$P($T(HELPTEXT+COUNT),";;",2) Q:LINE="END"  W !,LINE
 D PAUSE^XULMU
 D RE^VALM4
 Q
 ;
EXIT ; -- exit code
 S VALMBCK="R"
 Q
ADD(LINE) ;
 S @VALMAR@($$I,0)=LINE
 S:$G(XUENTRY) @VALMAR@("IDX1",VALMCNT)=XUENTRY
 Q
 ;
LJ(STRING,LEN) ;
 Q $$LJ^XLFSTR(STRING,LEN)
RJ(STRING,LEN) ;
 Q $$RJ^XLFSTR(STRING,LEN)
 ;
I() ;
 S VALMCNT=VALMCNT+1
 Q VALMCNT
 ;
 ;
HELPTEXT ;
 ;; ** USE EXTREME CAUTION **
 ;;
 ;;You can terminate a process and release all of its locks by selecting the
 ;;KILL action.  Do NOT do so unless you are sure that the process is not for
 ;;an active user.
 ;;
 ;;Additionally, you need to exercise extreme caution if terminating a
 ;;system process, such as MailMan or TaskManager, because doing so could
 ;;impact multiple users. 
 ;;
 ;;If you do terminate the process, an entry will be made in the 
 ;;XULM LOCK MANAGER LOG file.
 ;;
HLPEND ;;END
