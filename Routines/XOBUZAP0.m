XOBUZAP0 ;; mjk/alb - Terminate Jobs Utility ; 08/4/2005  13:00
 ;;1.6;Foundations;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; ------------------- ^XTMP Related Utilities -------------------------
 ; 
GETREF(SUB,XOBJOB) ; -- get ^XTMP reference of $JOB or passed in job #
 QUIT $NAME(^XTMP(SUB_" "_$$BOXVOL^XOBUZAP()_" "_$GET(XOBJOB,$JOB)))
 ;
KILL(XOBREF) ; -- kill @ ref
 KILL @XOBREF
 QUIT
 ; 
SETVI(XOBREF,XOBDUZ,XOBIP,XOBDESC) ; -- Set VistA Info node
 NEW XOBDT
 SET XOBDT=$$DT^XLFDT()
 SET @XOBREF@(0)=$$FMADD^XLFDT(XOBDT,7)_U_XOBDT_U_XOBDESC_" [$JOB ="_$JOB_"]"
 SET @XOBREF@(1)=$GET(XOBDUZ)_U_$GET(XOBIP)
 QUIT
 ;
GETDUZ(XOBREF) ; -- Get DUZ from VistA Info node
 QUIT +$GET(@XOBREF@(1))
 ;
GETIP(XOBREF) ; -- Get Client IP from VistA Info node
 QUIT $PIECE($GET(@XOBREF@(1)),U,2)
 ;
 ; --------------------------------------------------------------------
 ; 
GETSTATE(CODE) ; -- get state
 QUIT $TEXT(STATE+CODE)
 ;
 ; Note: 'State' table below derived from Cache documentation on $ZUTIL(67,4) function.
 ;       Codes 19-21 are present in Cache v5+ but not applicable to version 4.1.
STATE ; -- get process STATE text
 ;;1;LOCK :: Job is in the lock code.
 ;;2;OPEN :: Job is opening a device.
 ;;3;CLOS :: Job is closing a device.
 ;;4;USE :: Job is in the USE command.
 ;;5;READ :: Job is reading from a device.
 ;;6;WRT :: Job is writing to a device.
 ;;7;GGET :: Job is in gget.
 ;;8;GSET :: Job is in gset.
 ;;9;GKILL :: Job is in gkill.
 ;;10;GORD :: Job is in gorder for $ORDER.
 ;;11;GQRY :: Job is in gorder for $QUERY.
 ;;12;GDEF :: Job is in gdefval.
 ;;13;ZF :: Job is in a $ZF function call.
 ;;14;HANG :: Job is in the HANG command.
 ;;15;JOB :: Job is jobbing a job.
 ;;16;EXAM :: Job is doing ^JOBEXAM.
 ;;17;BRD :: Job is in $ZUTIL(9) or $ZUTIL(94), broadcasting a message.
 ;;18;SUSP :: Job is suspended.
 ;;19;INCR :: Job is in a $INCREMENT function call.
 ;;20;BSET :: Job is setting a bit using the $BIT functions. 
 ;;21;BGET :: Job is getting a bit using the $BIT functions.
