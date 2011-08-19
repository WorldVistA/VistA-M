SCAPMC19 ;ALB/REW - Team API's ; 12 Jan 99  9:10 AM
 ;;5.3;Scheduling;**41,174**;AUG 13, 1993
 ;;1.0
ACPRTP(SC200,SCTP,SCFIELDA,SCEFF,SCERR) ; assign practitioner to position
 ; input:
 ;  SC200   = New Person File (#200) Pointer
 ;  SCTP    = Pointer To Team Position File (#404.57)
 ;  SCFIELDA= array of extra field entries - scfielda('fld#')=value
 ;     -Note: Only used if BRAND NEW POSITION - team fields (404.57)
 ;  SCEFF   = date to activate/inactivate [default=DT]
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;
 ;              1      2      3      4      5
 ;  Returned: status^histien^actdt^inactdt^sctm
 ;
 ;
 N SCTPDTS,SCXX,SCOK,SCHIST,SCACTP,SCSTATUS
 N SCPTAIEN,SCESEQ,SCPARM,SCIEN
 G:'$$OKDATA() QT
 S SCSTATUS=$G(@SCFIELDA@(.04))
 S SCTPDTS("BEGIN")=SCEFF
 S SCTPDTS("END")=3990101
 ;for inactive check for any activity in future
 ;for active check for continuous activity in future
 S SCTPDTS("INCL")='SCSTATUS
 S SCOK=0
 IF "^1^0^"'[(U_SCSTATUS_U) D  G QT
 .S SCOK=-1
 .S SCPARM("POSITION")=$G(SCTP,"Undefined")
 .S SCPARM("PRACTITIONER")=$G(SC200,"Undefined")
 .S SCPARM("MESSAGE")="Required Field: #.04 = "_SCSTATUS
 .D ERR^SCAPMCU1(.SCESEQ,4045200,.SCPARM,"",.SCERR)
 ;is position already active or will be in future?
 S SCHIST=$P($$ACTHIST^SCAPMCU2(404.52,SCTP,"SCTPDTS",.SCERR,"SCXX"),U,1,4)
 ;inactivation must be after activation date
 IF ('SCSTATUS)&($P(SCHIST,U,3)'<SCEFF) D  G QT
 . S SCPARM("PRACTITIONER")=$G(SC200,"Undefined")
 . S SCPARM("POSITION")=$G(SCTP,"Undefined")
 . S SCPARM("MESSAGE")="Inactivation Date must not be equal to Inactivation Date"
 . D ERR^SCAPMCU1(.SCESEQ,4045200,.SCPARM,"",.SCERR)
 ;must inactivate same practitioner who was last activated
 S SCOLD200=$P($G(^SCTM(404.52,+$P(SCHIST,U,2),0)),U,3)
 IF ('SCSTATUS)&(SCOLD200&(SCOLD200'=SC200)) D  G QT
 . S SCOK=-1
 . S SCPARM("PRACTITIONER")=$G(SC200,"Undefined")
 . S SCPARM("MESSAGE")="Inactivation must be for same practitioner who was last activated"
 . D ERR^SCAPMCU1(.SCESEQ,4045200,.SCPARM,"",.SCERR)
 IF (+SCHIST+SCSTATUS)=1!('$D(^SCTM(404.52,"B",SCTP))) D  ;procede if not at state now
 .S SC($J,404.52,"+1,",.01)=SCTP
 .S SC($J,404.52,"+1,",.02)=SCEFF
 .S SC($J,404.52,"+1,",.03)=SC200
 .IF $D(SCFIELDA) D
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ...S SC($J,404.52,"+1,",SCFLD)=@SCFIELDA@(SCFLD)
 .D UPDATE^DIE("","SC($J)","SCIEN",.SCERR)
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
 IF '$D(^VA(200,+$G(SC200),0)) D
 . S SCPARM("PRACTITIONER")=$G(SC200,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045201,.SCPARM,"",.SCERR)
 IF '$D(^SCTM(404.57,+$G(SCTP),0)) D
 . S SCPARM("POSITION")=$G(SCTP,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045701,.SCPARM,"",.SCERR)
 F SCFLD=.04,.05 IF '($D(@SCFIELDA@(SCFLD))#2) D
 . S SCPARM("PRACTITIONER")=$G(SC200,"Undefined")
 . S SCPARM("MESSAGE")="Undefined history fields"
 . D ERR^SCAPMCU1(.SCESEQ,4045200,.SCPARM,"",.SCERR)
 Q SCOK
