XDRDEFLG ;SF-IRMFO/TKW -  SILENT API TO UPDATE THE SUPPRESS NEW DUP EMAIL FLAG ;9/19/08  16:57
 ;;7.3;TOOLKIT;**113**;Apr 25, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified
EN(XDRSLT,XDRFL,XDRVAL) ; Update the SUPPRESS NEW DUP EMAIL field on record in file #15.1
 ; Called from REMOTE PROCEDURE - XDR UPD EMAIL FLAG
 ;  XDRSLT = OUTPUT results.
 ;    set to 0 if update was successful, -1^ERRMSG if error
 ;  XDRFL = 'FILE TO BE CHECKED' field value in file 15.1, defaults to PATIENT file.
 ;  XDRVAL = 0 or 1 (value to set into field)
 ;
 K XDRSLT
 N XDRGBL,XDRFDA
 ; Default file is PATIENT file.
 S XDRFL=+$G(XDRFL)
 S:'XDRFL XDRFL=2
 ; Check file number input parameter
 S XDRGBL=$G(^DIC(XDRFL,0,"GL"))
 I (XDRGBL="")!($G(^VA(15.1,XDRFL,0))="") D  Q
 . S XDRSLT="-1^File number parameter missing or invalid" Q
 ; Make sure XDRVAL is set to 0 or 1
 S XDRVAL=$G(XDRVAL)
 I XDRVAL'=0,XDRVAL'=1 D  Q
 . S XDRSLT="-1^Value parameter is invalid, must be set to 0 or 1" Q
 ; Update SUPPRESS NEW DUP EMAIL field.
 S XDRFDA(15.1,XDRFL_",",99)=XDRVAL
 D FILE^DIE("","XDRFDA")
 I $D(^TMP("DIERR",$J)) D  Q
 . S XDRSLT="-1^Error updating FIELD 99, FILE 15.1, REC: "_XDRFL_" - "_$G(^TMP("DIERR",$J,1,"TEXT",1))
 . Q
 ; Success
 S XDRSLT=0
 Q
 ;
 ;
