SCAPMC15 ;ALB/REW - Team API's ; December 1, 1995
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1.0
ACTMNM(SCTMNM,SCFIELDA,SCMAINA,SCEFF,SCERR) ; -- activate a team (add if need be)
 ; input:
 ;  SCTMNM  = External Value of Team Name
 ;  SCFIELDA= similar to above -used for history entries (404.58)
 ;  SCMAINA = array of extra field entries - scfielda('fld#')=value
 ;     -Note: Only used if BRAND NEW TEAM - team fields (404.51)
 ;  SCEFF   = date to activate [default=DT]
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCPTAIEN    = ien if entry made to file 404.43, 0 ow
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;
 ;            1      2      3      4      5      6
 ;  Returned: Ok?^status^histien^actdt^inactdt^sctm
 N SCTM,SC,SCFLD,SCACTM
 N SCPTAIEN,SCESEQ,SCPARM,SCIEN
 S SCACTM=-1
 ;does entry exist? if not create
 G:'$$OKNMDATA QTNM ;check/setup variables
 S SCTM=$O(^SCTM(404.51,"B",SCTMNM,""))
 IF 'SCTM D
 .S SC($J,404.51,"+1,",.01)=SCTMNM
 .IF $D(SCMAINA) D
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCMAINA@(SCFLD)) Q:'SCFLD  D
 ...S SC($J,404.51,"+1,",SCFLD)=@SCMAINA@(SCFLD)
 .D UPDATE^DIE("","SC($J)","SCIEN","SCERR")
 .I $D(@SCERR) K SCIEN
 .S SCTM=$G(SCIEN(1))
 S SCACTM=$$ACTM(SCTM,SCFIELDA,SCEFF,SCERR)
QTNM Q SCACTM_U_SCTM
 ;
ACTM(SCTM,SCFIELDA,SCEFF,SCERR) ; activate team from internal entry#
 ; input:
 ;  SCTM    = Pointer to Team File (#404.51)
 ;  SCFIELDA= array of extra field entries for history entries (404.58)
 ;  SCEFF   = date to activate [default=DT]
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCPTAIEN    = ien if entry made to file 404.43, 0 ow
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;            1      2           3      4
 ; Returned: status^history ien^actdt^inactdt
 ;
 N SCTMDTS,SCXX,SCOK,SCHIST,SCACTM,SCSTATUS
 N SCPTAIEN,SCESEQ,SCPARM,SCIEN
 G:'$$OKDATA() QT
 S SCSTATUS=$G(@SCFIELDA@(.03))
 S SCTMDTS("BEGIN")=SCEFF
 S SCTMDTS("END")=3990101
 ;for inactive check for any activity in future
 ;for active check for continuous activity in future
 S SCTMDTS("INCL")='SCSTATUS
 S SCOK=0
 IF "^1^0^"'[(U_SCSTATUS_U) D  G QT
 .S SCOK=-1
 .S SCPARM("TEAM")=$G(SCTM,"Undefined")
 .S SCPARM("MESSAGE")="Required Field: #.03"_SCSTATUS
 .D ERR^SCAPMCU1(.SCESEQ,4045100,.SCPARM,"",.SCERR)
 ;is team already active or will be in future?
 S SCHIST=$P($$ACTHIST^SCAPMCU2(404.58,SCTM,"SCTMDTS",.SCERR,"SCXX"),U,1,4)
 IF ('SCSTATUS)&($P(SCHIST,U,3)'<SCEFF) D  G QT
 . S SCPARM("TEAM")=$G(SCTM,"Undefined")
 . S SCPARM("MESSAGE")="Inactivation Date must not be equal to Inactivation Date"
 . D ERR^SCAPMCU1(.SCESEQ,4045100,.SCPARM,"",.SCERR)
 IF (+SCHIST+SCSTATUS)=1!('$D(^SCTM(404.58,"B",SCTM))) D  ;procede if not at state now
 .S SC($J,404.58,"+1,",.01)=SCTM
 .S SC($J,404.58,"+1,",.02)=SCEFF
 .IF $D(SCFIELDA) D
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ...S SC($J,404.58,"+1,",SCFLD)=@SCFIELDA@(SCFLD)
 .D UPDATE^DIE("","SC($J)","SCIEN","SCERR")
 .IF '$G(@SCERR@(0))<1 D
 .S:SCSTATUS SCHIST=SCSTATUS_U_SCIEN(1)_U_SCEFF_U
 .S:'SCSTATUS SCHIST=SCSTATUS_U_SCIEN(1)_U_$P(SCHIST,U,3)_U_SCEFF
 .S SCOK=1
QT Q SCOK_U_$G(SCHIST)
 ;
OKDATA() ;
 ;setup/check variables for actm call
 N SCOK,SCFLD
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 S:'$G(SCEFF) SCEFF=DT
 F SCFLD=.03,.04 IF '($D(@SCFIELDA@(SCFLD))#2) D
 . S SCPARM("TEAM")=$G(SCTM,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045100,.SCPARM,"",.SCERR)
 Q SCOK
OKNMDATA() ;
 ;setup/check variables for actmnm call
 N SCOK,SCFLD
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 S:'$G(SCEFF) SCEFF=DT
 ; only check 404.51 fields if no entry already
 IF '$D(^SCTM(404.51,"B",SCTMNM)) D
 .F SCFLD=.03,.06,.07 IF '($D(@SCMAINA@(SCFLD))#2) D
 ..S SCPARM("TEAM")=$G(SCTM,"Undefined")
 ..S SCPARM("MESSAGE")="Required Field: #"_SCFLD
 ..D ERR^SCAPMCU1(.SCESEQ,4045100,.SCPARM,"",.SCERR)
 F SCFLD=.03,.04 IF '($D(@SCFIELDA@(SCFLD))#2) D
 . S SCPARM("TEAM")=$G(SCTM,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045100,.SCPARM,"",.SCERR)
 Q SCOK
