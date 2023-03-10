SDESPATCHINFO ;ALB/KML - VISTA SCHEDULING RPCS GET CURRENT PATCH NUMBER ; FEB 2, 2022
 ;;5.3;Scheduling;**807**;Aug 13, 1993;Build 5
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q  ;No Direct Call
 ; RPC: SDES GET PATCH NUMBER
GETPATCHNUM(RETURN) ;
 ; This RPC returns the latest patch installed on the system
 ; Input/output:
 ; RETURN passed by reference/RETURN latest patch installed on system
 N X,ERR,SDARRAY
 S X=$P($$LAST^XPDUTL("SD"),U),ERR=""  ;supported reference IA 10141
 I X=-1 S SDARRAY("Error",1)="ERROR: the Scheduling software or version does not exist or no patches have been applied."
 E  S SDARRAY("Latest SD patch number")=X
 D ENCODE^SDESJSON(.SDARRAY,.RETURN,.ERR)
 Q
