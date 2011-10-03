SCRPMTA ;ALB/REW/PDR - Team Reassignment APIs:APPTTM ; AUG 1998
 ;;5.3;scheduling;**148,157**;aug 13, 1993
 ; Reassign patient Team, called from RPC ='SC FILE PAT TM REASGN' (PTFILE^SCMRBK - PTFILE^SCMRBK)
 ;
 ;;1.0
 ; MAKE A SINGLE PATIENT TEAM REASSIGNMENT
ACPTTM(DFN,SCTMTO,SCFIELDA,SCACT,FASIEN,SCERR) ;add a patient to a team (pt tmassgn - #404.42)
 ; input:
 ;  DFN     = pointer to PATIENT file (#2)
 ;  SCTMTO  = pointer to TEAM file (#404.51) "TO" Team
 ;  SCFIELDA= array of additional fields to be added for 404.42
 ;  SCACT   = date to activate [default=DT]
 ;  FASIEN  = IEN of source team assignment
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  Returned = ien of 404.42 - 0 if none after^new?^Message
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 N SCPTTM,SCESEQ,SCPARM,SCIEN,SC,SCFLD,SCNEWTM,SCDTPAR,SCMESS
 ;
 ;
 I '$$OKDATA D  G APTTMQ ;check/setup variables
 . D ERROR("Failed initial data check","",10)
 ; 
 ; PROCESS REASSIGNMENT
 ; get destination team assignment parameters if already existing assignment
 I '$$GETTMPAR(DFN,SCTMTO,SCACT,.SCERR,.SCDTPAR,.SCPTTM) D  G APTTMQ ; BAIL if error 
 . D ERROR("Unable to get list of team assignments for patient",FASIEN,20)
 ; Make sure this reassignment doesn't set up more than 1 primary care team for PT
 I $$INVALMOV(SCPTTM,FASIEN,SCDTPAR) D  G APTTMQ ; BAIL if error 
 . D ERROR("Patient already has a primary care assignment",FASIEN,30)
 ;
 ; check for currently active destination assignment and discharge if so
 I $$ACTIVDES(SCDTPAR,SCACT) D  G:SCPTTM APTTMQ ; BAIL OUT if discharge unsuccessfull
 . I $$DISTMOK(DFN,SCPTTM,SCACT,DUZ,"Destination") S SCPTTM="" Q  ; going to create a new team
 . D ERROR("Unable to discharge current destination assignment",SCPTTM,40)
 ;
 ; discharge source team
 I '$$DISTMOK(DFN,FASIEN,SCACT,DUZ,"Source") D  G APTTMQ
 . ; error messages setup within call to DISTMOK
 . S SCPTTM=""
 ;
 ; Move the patient to destination team and create destination team if necessary
 I '$$MOVPATOK(DFN,SCACT,SCTMTO,SCFIELDA,SCDTPAR,.SCPTTM,DUZ) D  G APTTMQ
 . D ERROR("Unable to move patient to destination team",FASIEN,50)
 ;
APTTMQ ;
 ;B
 Q +$G(SCPTTM)_U_+$G(SCNEWTM)_U_$G(SCMESS)
 ;
 ;-------------------- SUBS -------------------------------
 ;
PTTMACT(DFN,SCTMTO,SCDT,SCERR) ;what is patient/team assignment on a given date-time into the future? Return 404.42 ien or 0
 N SCTMLST,SCOK,SCPTTMDT
 S SCOK=0
 S SCPTTMDT("BEGIN")=SCDT,SCPTTMDT("END")=3990101,SCPTTMDT("INCL")=0
 IF $$TMPT^SCAPMC3(DFN,"SCPTTMDT","","SCTMLST",.SCERR) S:$D(SCTMLST("SCTM",SCTMTO)) SCOK=$O(SCTMLST("SCTM",SCTMTO,0))
 Q SCOK
 ;
OKDATA()        ;setup/check variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 IF '$D(^DPT(DFN,0))!('$D(^SCTM(404.51,SCTMTO,0))) D  S SCOK=0
 . S SCPARM("PATIENT")=DFN
 . S SCPARM("TEAM")=SCTMTO
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",.SCERR)
 S:'$G(SCACT) SCACT=DT
 Q SCOK
 ;
DISTMOK(DFN,TMIEN,SCACT,SCDUZ,SD) ; Discharge patient from Team Assignment
 ; DFN = pointer to patient
 ; TMIEN = Ptr to Team Assignment File 404.42 for Team being discharged
 ; SCAT = Discharge Date
 ; SCDUZ = DUZ of user making reassignment
 ; SD = text indicating "source" or "destination" team
 N SC,SCTEC,DISDAT
 ;
 Q:TMIEN="" TMIEN  ; Don't try to update this record if don't get IEN
 S DISDAT=SCACT  ; init discharge date
 ; discharge for previous day if assignment date prior to today
 I $P($G(^SCPT(404.42,TMIEN,0)),U,2)'>$$PREVDAY(SCACT) S DISDAT=$$PREVDAY(SCACT)
 ; Discharge Position assignments first, to prevent posibility of orphan positions
 D DISCHPOS(DFN,TMIEN,DISDAT,SCERR,.SCTEC) ; Discharge from any position Assignments on this team
 I SCTEC S SCTEC=$$INPTTM^SCAPMC(DFN,TMIEN,DISDAT,SCERR) ; Discharge from team Assignments
 I 'SCTEC D ERROR("Unable to discharge "_SD_" team",FASIEN,500) Q 0 ; BAIL OUT
 Q SCTEC
 ;
DISCHPOS(DFN,TMASGN,SCAT,SCERR,SCTEC) ;Discharge positition assignments
 ; DFN = ptr to patient
 ; TMASGN = ptr to team assignment
 ; SCAT = discharge date
 N POSASGN,EM,GD,OK
 S (EM,GD)=""
 S OK=1
 S SCTEC=1 ; initialize successfull pos discharge since may not be any pos to discharge
 S POSASGN=0
 F  S POSASGN=$O(^SCPT(404.43,"B",TMASGN,POSASGN)) Q:POSASGN=""  D
 . S SCTEC=$$INPTTP^SCAPMC(DFN,POSASGN,SCAT,SCERR) ; discharge position
 . I SCTEC S GD=GD_POSASGN_","
 . I 'SCTEC D
 .. S EM=EM_POSASGN_","
 .. S OK=0
 I 'OK D
 . I GD'="" D ERROR("able to discharge these source positions: "_GD_" unable to discharge these: "_EM,POSASGN,300) Q
 . D ERROR("unable to discharge any of the team positions: "_EM,POSASGN,400)
 Q
 ;
PREVDAY(DAY) ; GET PREVIOUS DAY
 ; DAY = DATE IN FILEMAN FORMAT
 N X,X1,X2
 S X1=DAY,X2=-1
 D C^%DTC
 Q X
 ;
GETTMPAR(DFN,SCTMTO,SCDT,SCERR,SCTMPAR,SCPTTM) ; RETURN team parameters
 ; SCTMPAR is returned as:
 ;               Piece     Description
 ;                 1       IEN of TEAM file entry
 ;                 2       Name of team
 ;                 3       IEN of file #404.42 (Pt Tm Assignment)
 ;                 4       current effective date
 ;                 5       current inactivate date (if any)
 ;                 6       pointer to 403.47 (purpose)
 ;                 7       Name of Purpose
 ;                 8       Is this the pt's PC Team?
 ;                 9       IEN of PC team assignment - added to record -PDR
 N SCTMLST,SCPTTMDT,PCTM
 S (SCPTTM,SCTMPAR,PCTM)="" ; initialize dest team IEN and dest team parameters
 ; get a list of active or future active teams for this patient
 S SCPTTMDT("BEGIN")=SCDT,SCPTTMDT("END")=3990101,SCPTTMDT("INCL")=0
 I $$TMPT^SCAPMC3(DFN,"SCPTTMDT","","SCTMLST",.SCERR) D
 . S PCTM=$$GETPCTM(.SCTMLST)  ; get the PC team if any for this patient
 . S:$D(SCTMLST("SCTM",SCTMTO)) SCPTTM=$O(SCTMLST("SCTM",SCTMTO,0))
 . I SCPTTM D  ; get the team parameters
 .. S SCN=$O(SCTMLST("SCTM",SCTMTO,SCPTTM,"")) ; ordered list
 .. S SCTMPAR=$G(SCTMLST(SCN)) ; basic team parameters
 S $P(SCTMPAR,U,9)=+PCTM ; add ien of PC team as 9th piece
 Q '$D(@SCERR)
 ;
GETPCTM(TMLIST) ; FIND THE PC TEAM FOR THIS PATIENT
 N SN,PT
 S (PT,SN)=0
 F  S SN=$O(TMLIST(SN)) Q:'SN  D  Q:PT
 . I $P(TMLIST(SN),U,8) S PT=$P(TMLIST(SN),U,3)
 Q PT
 ;
FUASSN(SCDTPAR,SCDT) ; is there a future assignment?
 Q $P(SCTMPAR,U,4)>SCDT
 ;
FUDISCHG(SCTMPAR,SCDT) ;IS THERE A FUTURE DISCHARGE?
 Q $P(SCTMPAR,U,5)>SCDT
 ;
MOVPATOK(DFN,SCACT,SCTMTO,SCFIELDA,SCTMPAR,SCPTTM,SCDUZ) ; DID MOVE GO OK?
 N SCFLD,SCED
 S SCED=0
 I SCPTTM D  ; setup for edit of existing dest assignment record
 . S SCPTTM=SCPTTM_","  ; IENS format
 . I $$FUASSN(SCTMPAR,SCACT) S SCED=1 ; the new assign date wil be entered below
 . I $$FUDISCHG(SCTMPAR,SCACT) D  ; is there a future discharge for the dest team?
 .. S SCED=1
 .. S SC($J,404.42,SCPTTM,.09)="" ; remove discharge date
 . I SCED D  ; editing the existing assignment - setup edit documentation fields
 .. S SC($J,404.42,SCPTTM,.13)=@SCFIELDA@(.11) ; last edited by set to entered by
 .. S SC($J,404.42,SCPTTM,.14)=@SCFIELDA@(.12) ; last edit time set to enter date/time
 .. K @SCFIELDA@(.11) ; dispose of entered by (SCFIELDA array is set in SCMRBK)
 .. K @SCFIELDA@(.12) ; dispose of entry date/time
 ; 
 I '(+SCPTTM) S SCPTTM="+1," ; setup for new team
 ;
 S SCFLD=0 ; add additional fields from workstation if any
 F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 . S SC($J,404.42,SCPTTM,SCFLD)=@SCFIELDA@(SCFLD)
 ; core fields for new team assignment
 S SC($J,404.42,SCPTTM,.01)=DFN
 S SC($J,404.42,SCPTTM,.02)=SCACT
 S SC($J,404.42,SCPTTM,.03)=SCTMTO
 ;
 I 'SCED D UPDATE^DIE("","SC($J)","SCIEN","SCERR") ; new entry
 I SCED D FILE^DIE("","SC($J)","SCERR") ; edit existing entry
 ;
 IF $D(@SCERR) D
 . K SCIEN
 . S SCPTTM=""
 ELSE  D
 . I SCPTTM'="+1," Q  ; BAIL OUT - was edit to existing assignement record
 . S SCPTTM=$G(SCIEN(1))  ; new assignment record set up
 . S SCNEWTM=1
 . D AFTERTM^SCMCDD1(SCPTTM)
 Q '$D(@SCERR)
 ;
INVALMOV(DTMIEN,STMIEN,TMPAR) ; IS THIS A VALID REASSIGNMENT?
 ; can't have a pc team reassignment if patient has an existing PC team assignment
 ; and it is not 
 ; 1: the src team (move from src to dest discharges src, result only 1 pc team) OR 
 ; 2: the destination team (already existing assignment)
 I $$PCASSGN,$$OTHPCTM(DTMIEN,STMIEN,TMPAR) Q 1
 Q 0
 ;
PCASSGN() ; IS THE REASSIGNMENT DESTINATION TO BE PC?
 Q @SCFIELDA@(.08)=1
 ;
OTHPCTM(DTMIEN,STMIEN,TMPAR) ; IS THERE ALREADY PC TEAM ASSIGNMENT?
 I $P(TMPAR,U,9)=0 Q 0  ; no other primary care assignments
 I 'DTMIEN Q $P(TMPAR,U,9)'=STMIEN  ; true if PC team is not source team
 Q $P(TMPAR,U,9)'=DTMIEN  ; true if existing dest team assign is not pc team
 ;
ACTIVDES(SCDTPAR,SCACT) ; IS THE DESTINATION ASSIGNMENT ACTIVE?
 ; SCDTPAR = Destination Team assignment parameter string
 N DISDT,ASNDT
 S DISDT=$P(SCDTPAR,U,5)
 I DISDT="" S DISDT=9999999
 S ASNDT=$P(SCDTPAR,U,4)
 ; ACTIVE if assign date is not in future and 
 ; there is no discharge date, or the discharge date is in the future 
 I (ASNDT'>SCACT)&(DISDT>SCACT) Q 1
 Q 0
 ;
ERROR(TXT,ID,ERN) ; ERROR PROCESSOR
 S SCMESS=TXT_" IEN="_ID_" (ER#="_ERN_")"
 S SCPTTM=0 ; return no assignment ien
 ;S ^TMP("PDR",$J,$H,DFN)=SCMESS
 Q
