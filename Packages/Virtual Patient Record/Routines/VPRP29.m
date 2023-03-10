VPRP29 ;SLC/MKB -- Patch 29 postinit ;3/4/20  12:07
 ;;1.0;VIRTUAL PATIENT RECORD;**29**;Sep 01, 2011;Build 11
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
POST ; -- post-init [add AVPR index to #230]
 N VPRX,VPRY
 S VPRX("FILE")=230
 S VPRX("NAME")="AVPR"
 S VPRX("TYPE")="MU"
 S VPRX("USE")="A"
 S VPRX("EXECUTION")="F"
 S VPRX("ACTIVITY")=""
 S VPRX("SHORT DESCR")="Trigger updates to VPR"
 S VPRX("DESCR",1)="This is an action index that updates the Virtual Patient Record (VPR)"
 S VPRX("DESCR",2)="when this record is updated. No actual cross-reference nodes are set"
 S VPRX("DESCR",3)="or killed."
 S VPRX("SET")="D:$L($T(EDP^VPRENC)) EDP^VPRENC(DA)"
 S VPRX("KILL")="Q"
 S VPRX("WHOLE KILL")="Q"
 S VPRX("VAL",1)=.07              ;Closed
 S VPRX("VAL",2)=1.2              ;Disposition
 D CREIXN^DDMOD(.VPRX,"kW",.VPRY) ;VPRY=ien^name of index
 Q
