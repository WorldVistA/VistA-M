XULMRPC ;IRMFO-ALB/CJM/SWO/RGG - KERNEL LOCK MANAGER ;10/15/2012
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
LOCKS(RETURN,LOCKS,RESULT,SCREEN) ; Compile lock table
 ;
 ;Inputs:
 ;  LOCKS - the global location to set the data, referenced by indirection
 ;  SCREEN = 1 if system locks should be screened out, 0 otherwise
 ;  RESULT - global location to store the result
 ;Outputs:
 ;    @LOCKS will contain the locks obtained from the lock table
 ;    RETURN - return variable required for a RPC (doesn't seem to work)
 ;    @RESULT - global location where result is placed  1 if success, 0 otherwise
 ;
 D GETLOCKS^XULMU(LOCKS)
 S:$L($G(RESULT)) @RESULT=1
 S RETURN=1
 Q RETURN
 ;
 ;
KILLPROC(RETURN,PID,RESULT) ;
 ;Description:
 ;  Kills the process identified to OS by PID
 ;Inputs:
 ;  PID - 
 ;  RESULT - global location to store the result
 ;Outputs:
 ;    RETURN - return variable required for a RPC (doesn't seem to work)
 ;    @RESULT - global location where result is placed - 1 if success, 0 otherwise
 ;
 D
 .N $ETRAP S $ETRAP="G ERROR^XULMRPC"
 .S RETURN=$$KILL^%ZLMLIB(PID)
 S:$L($G(RESULT)) @RESULT=RETURN
 I RETURN D CLEANUP^XULMU(PID)
 Q RETURN
 ;
ERROR ;
 S $ETRAP="Q:$QUIT """"  Q"
 S $ECODE=""
 Q:$QUIT ""
 Q
