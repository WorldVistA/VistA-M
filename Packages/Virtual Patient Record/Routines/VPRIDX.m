VPRIDX ;SLC/MKB -- Create AVPR index ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8**;Sep 01, 2011;Build 87
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; -- create index
 D GMRV
 ;
 Q
 ;
GMRV ; -- create AVPR index on GMRV Measurement file #120.5
 N VPRX,VPRY
 S VPRX("FILE")=120.5
 S VPRX("NAME")="AVPR"
 S VPRX("TYPE")="MU"
 S VPRX("USE")="A"
 S VPRX("EXECUTION")="R"
 S VPRX("ACTIVITY")=""
 S VPRX("SHORT DESCR")="Trigger updates to VPR"
 S VPRX("DESCR",1)="This is an action index that updates the Virtual Patient Record (VPR)"
 S VPRX("DESCR",2)="when any of the fields in this index are changed. No actual cross-"
 S VPRX("DESCR",3)="reference nodes are set or killed."
 S VPRX("SET")="D GMRV^VPREVNT(X(1),DA,$G(X(3)))"
 S VPRX("KILL")="Q"
 S VPRX("WHOLE KILL")="Q"
 S VPRX("VAL",1)=.02              ;Patient
 S VPRX("VAL",2)=1.2              ;Rate
 S VPRX("VAL",3)=2                ;Entered in Error
 D CREIXN^DDMOD(.VPRX,"kW",.VPRY) ;VPRY=ien^name of index
 Q
