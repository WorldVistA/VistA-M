SCAPMC17 ;ALB/REW - Team API's ; 12 Jan 99  9:09 AM
 ;;5.3;Scheduling;**41,174**;AUG 13, 1993
 ;;1.0
ACTPNM(SCTPNM,SCTMNM,SCFIELDA,SCMAINA,SCEFF,SCERR) ; -- change position status (add if need be)
 ; input:
 ;  SCTPNM  = External Value of Position Name
 ;  SCTMNM  = External Value of Team Name
 ;  SCFIELDA = similar to above -used for history entries (404.59)
 ;  SCMAINA = array of extra field entries - scfielda('fld#')=value
 ;     -Note: Only used if BRAND NEW POSITION - team fields (404.57)
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
 ;  Returned: Ok?^status^histien^actdt^inactdt^sctp
 N SCTM,SC,SCFLD,SCACTM
 N SCPTAIEN,SCESEQ,SCPARM,SCIEN
 S SCACTM=-1
 ;does entry exist? if not create
 G:'$$OKNMDATA QTNM ;check/setup variables
 S SCTM=$O(^SCTM(404.51,"B",SCTMNM,""))
 IF 'SCTM D  G QTNM
 . S SCPARM("TEAM")=$G(SCTM,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045100,.SCPARM,"",.SCERR)
 S SCTP=$O(^SCTM(404.57,"APRIMARY",SCTPNM,SCTM,""))
 IF 'SCTP D
 .S SC($J,404.57,"+1,",.01)=SCTPNM
 .S SC($J,404.57,"+1,",.02)=SCTM
 .IF $D(SCMAINA) D
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCMAINA@(SCFLD)) Q:'SCFLD  D
 ...S SC($J,404.57,"+1,",SCFLD)=@SCMAINA@(SCFLD)
 .D UPDATE^DIE("","SC($J)","SCIEN",SCERR)
 .I $D(@SCERR) K SCIEN
 .S SCTP=$G(SCIEN(1))
 S SCACTP=$$ACTP(SCTP,SCFIELDA,SCEFF,SCERR)
QTNM Q SCACTP_U_SCTP
 ;
ACTP(SCTP,SCFIELDA,SCEFF,SCERR) ; change position status using ien
 ; input:
 ;  SCTP  = Pointer to TEAM POSTION File (#404.57)
 ;  SCFIELDA= array of extra field entries - for history entries (404.59)
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
 ;            1      2      3      4      5
 ;  Returned:status^histien^actdt^inactdt^sctp
 ;
 N SCTPDTS,SCXX,SCOK,SCHIST,SCACTP,SCSTATUS,SCTM
 N SCPTAIEN,SCESEQ,SCPARM,SCIEN
 S SCTM=$P($G(^SCTM(404.57,+$G(SCTP),0)),U,2)
 G:'$$OKDATA() QT
 S SCSTATUS=$G(@SCFIELDA@(.03))
 S SCTPDTS("BEGIN")=SCEFF
 S SCTPDTS("END")=3990101
 ;for inactive check for any activity in future
 ;for active check for continuous activity in future
 S SCTPDTS("INCL")='SCSTATUS
 S SCOK=0
 IF "^1^0^"'[(U_SCSTATUS_U) D  G QT
 .S SCOK=-1
 .S SCPARM("TEAM")=$G(SCTM,"Undefined")
 .S SCPARM("MESSAGE")="Required Field: #.03"_SCSTATUS
 .D ERR^SCAPMCU1(.SCESEQ,4045100,.SCPARM,"",.SCERR)
 ;is position already active or will be in future?
 S SCHIST=$P($$ACTHIST^SCAPMCU2(404.59,SCTP,"SCTPDTS",.SCERR,"SCXX"),U,1,4)
 ;inactivation must be after activation date
 IF ('SCSTATUS)&($P(SCHIST,U,3)'<SCEFF) D  G QT
 . S SCPARM("POSITION")=$G(SCTP,"Undefined")
 . S SCPARM("MESSAGE")="Inactivation Date must not be equal to Inactivation Date"
 . D ERR^SCAPMCU1(.SCESEQ,4045700,.SCPARM,"",.SCERR)
 IF (+SCHIST+SCSTATUS)=1!('$D(^SCTM(404.59,"B",SCTP))) D  ;procede if not at state now
 .S SC($J,404.59,"+1,",.01)=SCTP
 .S SC($J,404.59,"+1,",.02)=SCEFF
 .IF $D(SCFIELDA) D
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ...S SC($J,404.59,"+1,",SCFLD)=@SCFIELDA@(SCFLD)
 .D UPDATE^DIE("","SC($J)","SCIEN","SCERR")
 .IF '$G(@SCERR@(0))<1 D
 .S:SCSTATUS SCHIST=SCSTATUS_U_SCIEN(1)_U_SCEFF_U
 .S:'SCSTATUS SCHIST=SCSTATUS_U_SCIEN(1)_U_$P(SCHIST,U,3)_U_SCEFF
 .S SCOK=1
QT Q SCOK_U_$G(SCHIST)
 ;
OKDATA() ;
 ;setup/check variables for acTP call
 N SCOK,SCFLD
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 S:'$G(SCEFF) SCEFF=DT
 IF '$D(^SCTM(404.57,+$G(SCTP),0)) D
 . S SCPARM("POSITION")=$G(SCTP,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045701,.SCPARM,"",.SCERR)
 F SCFLD=.03,.04 IF '($D(@SCFIELDA@(SCFLD))#2) D
 . S SCPARM("TEAM")=$G(SCTM,"Undefined")
 . S SCPARM("MESSAGE")="Undefined history fields"
 . D ERR^SCAPMCU1(.SCESEQ,4045100,.SCPARM,"",.SCERR)
 Q SCOK
OKNMDATA() ;
 ;setup/check variables for acTPnm call
 N SCOK,SCFLD
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 S:'$G(SCEFF) SCEFF=DT
 ; only check 404.57 fields if no entry already
 IF '$D(^SCTM(404.57,"B",SCTPNM)) D
 .F SCFLD=.03 IF '($D(@SCMAINA@(SCFLD))#2) D
 ..S SCPARM("TEAM")=$G(SCTM,"Undefined")
 ..S SCPARM("MESSAGE")="Required Field: #"_SCFLD
 ..D ERR^SCAPMCU1(.SCESEQ,4045100,.SCPARM,"",.SCERR)
 F SCFLD=.03,.04 IF '($D(@SCFIELDA@(SCFLD))#2) D
 . S SCPARM("TEAM")=$G(SCTM,"Undefined")
 . S SCPARM("MESSAGE")="Required Field: #"_SCFLD
 . D ERR^SCAPMCU1(.SCESEQ,4045100,.SCPARM,"",.SCERR)
 Q SCOK
