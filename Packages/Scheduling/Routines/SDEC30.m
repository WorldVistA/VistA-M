SDEC30 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
SPACEBAR(SDECY,SDECDIC,SDECVAL) ;Update ^DISV with most recent lookup value SDECVAL from file SDECDIC
 ;SPACEBAR(SDECY,SDECDIC,SDECVAL)  external parameter tag is in SDEC
 ;SDECDIC is the data global in the form GLOBAL(
 ;SDECVAL is the entry number (IEN) in the file
 ;
 ;Return Status = 1 if success, 0 if fail
 ;
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 N SDEC1,SDECRES
 S SDECI=0
 I (SDECDIC="")!('+$G(SDECVAL)) D ERR(SDECI+1,99) Q
 S SDECDIC="^"_SDECDIC
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 I $D(@(SDECDIC_"SDECVAL,0)")),'$D(^(-9)) D     ;Note:  Naked reference is immediately preceded by the full global reference per SAC 2.2.2.8
 . S ^DISV(DUZ,SDECDIC)=SDECVAL
 . S SDECRES=1
 E  S SDECRES=0
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECRES_$C(30)_$C(31)
 Q
 ;
ERR(SDECI,SDECERR) ;Error processing
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECERR_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
ETRAP ;EP Error trap entry
 I '$D(SDECI) N SDECI S SDECI=999
 S SDECI=SDECI+1
 D ERR(99,0)
 Q
 ;
EHRPT(SDECY,SDECWID,SDECDFN) ;Raise patient selection event to CLIENT
 ;EHRPT(SDECY,SDECWID,SDECDFN)  external parameter tag is in SDEC
 ;Return Status = 1 if success, 0 if error
 ;
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 N SDEC1,SDECRES
 S SDECI=0,SDECRES=1
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 I '+SDECDFN D ERR(SDECI+1,0) Q
 ;
 D PEVENT(SDECWID,SDECDFN) ;Raise patient selected event
 ;
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECRES_$C(30)_$C(31)
 Q
 ;
PEVENT(SDECWID,DFN) ;EP - Raise patient selection event to CLIENT
 ;
 ;Change patient context to patient DFN
 ;on all CLIENT client sessions associated with user DUZ
 ;and workstation SDECWID.
 ;
 ;If SDECWID is "", the context change is sent to
 ;all CLIENT client sessions belonging to user DUZ.
 ;
 Q:'$G(DUZ)
 ;N UID,BRET
 ;S BRET=0,UID=0
 ;F  S BRET=$$NXTUID^CIANBUTL(.UID,1) Q:'UID  D
 ;. Q:DUZ'=$$GETVAR^CIANBUTL("DUZ",,,UID)
 ;. I SDECWID'="" Q:SDECWID'=$TR($$GETVAR^CIANBUTL("WID",,,UID),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;. D QUEUE^CIANBEVT("CONTEXT.PATIENT",+DFN,UID)
 Q
