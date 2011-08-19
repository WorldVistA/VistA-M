TIUCNFIX ; SLC/MAM - Resolve Upload Filing Errors for Consults ;05/06/02
 ;;1.0;TEXT INTEGRATION UTILITIES;**131**;Jun 20, 1997
CNFIX ; Consults Filing Error Resolution Code
 ; Requires: TIUEVNT - 8925.4 Upload Log Event IEN
 ; Requires: TIUTYPE - IEN of Docmt Def whose Filing Error
 ;                     Resolution Code is being invoked.
 ;                     Taken from alert or filing error.
 ;Modeled on PNFIX^TIUPNFIX, with optional change to PN added
 ;                     
 N TIUFLDS,TIUBUF,SUCCESS,OLDTYPE,DFN,TITLDA,TIU
 S SUCCESS=0
 I '$D(^TIU(8925.1,+$G(TIUTYPE),0)) S SUCCESS="0^Document type is missing or invalid." G CNFIXX
 I '$D(^TIU(8925.4,+$G(TIUEVNT),0)) S SUCCESS="0^Upload Log event is missing or invalid." G CNFIXX
 S TIUBUF=$$BUFFER^TIUFIX2(TIUEVNT) I +TIUBUF'>0 S SUCCESS=TIUBUF G CNFIXX
 I '$D(TIUPRM0) D SETPARM^TIULE ; Sets TIUPRM0 with hdr signal, etc
 ; -- Load hdr data from buffer into array TIUFLDS:
 D LOADHDR^TIUFIX2(.TIUFLDS,TIUBUF,TIUPRM0,TIUTYPE)
 ; -- Get from user all data needed to create a new document
 ;    of the given type. Cross-check user data for consistency.
 S OLDTYPE=TIUTYPE
 D GETCHECK(.SUCCESS,.TIUTYPE,.TIUFLDS,.DFN,.TITLDA,.TIU)
 ; -- If all is NOT in order to create a consult,
 ;    and type is still consults, exit w/o creating docmt:
 I 'SUCCESS,TIUTYPE=OLDTYPE G CNFIXX
 ; -- If user chose to create a progress note instead
 ;    of a consult, kill REQUESTING PACKAGE node of array
 ;    and get progress note title:
 I TIUTYPE'=OLDTYPE D  G:'SUCCESS CNFIXX
 . K TIUFLDS(1405)
 . ; -- Get progress notes title
 . ;    (Screen out consult titles)
 . ;    (Don't ASK if user wants to change to PN;
 . ;    user is already changing to PN):
 . S BADTYPES=+$$CLASS^TIUCNSLT,ASK=0
 . W !!,"  OK, changing document to a progress note..."
 . D GETTITLE^TIUFIX(.SUCCESS,.TIUTYPE,.TIUFLDS,.TITLDA,BADTYPES,ASK)
 ; -- If all is in order to create a consult,
 ;    or if type has changed to progress note,
 ;    then continue and create consult/progress note,
 ;    file fields remaining in TIUFLDS, execute post-file code, etc.:
 D MAKE^TIUFIX1(.SUCCESS,TIUEVNT,TIUBUF,.TIUTYPE,.TIUFLDS,.DFN,.TITLDA,.TIU,TIUPRM0)
 ; -- If docmt filed successfully, set flag to stop - don't go
 ;    on and try to resolve error by editing buffer and refiling. 
CNFIXX I +SUCCESS S TIUDONE=1
 ; -- If error successfully resolved, and type changed,
 ;    update type in event log entry:
 I $G(TIUDONE),TIUTYPE'=OLDTYPE D
 . N DIE,DR,DA,TYPE
 . S TYPE="PROGRESS NOTES"
 . S DIE=8925.4,DR=".03////"_TYPE,DA=+TIUEVNT
 . D ^DIE
 Q:$G(TIUDONE)
 W !!,"Filing error could not be resolved."
 I $P(SUCCESS,U,2)]"" W !,$P(SUCCESS,U,2)
 W !,"If you wish to try a different approach, edit the buffered data directly",!,"and refile it, or simply exit and try again later.",!
 Q
 ;
GETCHECK(SUCCESS,TIUTYPE,TIUFLDS,DFN,TITLDA,TIU) ; Get and check data
 ; Get from user: Patient, Visit, Document Title, Consult
 ;Request Number.  Check that data are consistent.  Reset Request
 ;Number into array TIUFLDS. Ask user if they want to change
 ;document type to Progress Note.
 ;Modeled on GETCHECK^TIUPNFIX, with optional change to PN added
 ; -- Get patient and visit
PAT S DFN=+$$PATIENT^TIULA
 N TIUCNNBR,CHANGEPT,ASK,BADTYPES
 S SUCCESS="0^Patient and Visit are Required."
 Q:DFN'>0
 D ENPN^TIUVSIT(.TIU,+DFN,1)
 I '$D(TIU) Q
 I '$$CHEKPN^TIUCHLP(.TIU) K TIU Q
 ; -- Get title
 ;    (No need to limit title beyond
 ;    making sure it has type TIUTYPE.)
 ;    (ASK if user wants to change to PN):
 S BADTYPES="",ASK=1
 D GETTITLE^TIUFIX(.SUCCESS,.TIUTYPE,.TIUFLDS,.TITLDA,BADTYPES,ASK)
 ; -- If user didn't select title or wants to change to
 ;    Progress Note, quit:
 I TITLDA'>0 Q
 I TIUTYPE=3 Q
 ; -- Get consult request:
 D GETCNSLT(.SUCCESS,.TIUTYPE,.TIUFLDS,.CHANGEPT,.TIUCNNBR)
 I $G(CHANGEPT) G PAT
 I TIUCNNBR'>0 Q
 ; -- We now have a valid request number, consistent with DFN.
 ;    Transform Consult Request # into form C.# and reset
 ;    request node:
 S TIUCNNBR=$P(TIUCNNBR,";") ; was #;GMR(123,
 S TIUFLDS(1405)=$$TRNSFRM^TIUPEFIX(TIUTYPE,1405,TIUCNNBR)
 S SUCCESS=1
 Q
 ;
GETCNSLT(SUCCESS,TIUTYPE,TIUFLDS,CHANGEPT,TIUCNNBR) ; Get consult
 ;request from user
 N CLINPROC,TIUOVR,DOCNUM,Y
 S SUCCESS="0^Consult Request is Required."
 S CLINPROC=0,TIUOVR=1,DOCNUM=0 ;Don't have a docmt yet
 S TIUCNNBR=$$GETCNSLT^TIUCNSLT(DFN,CLINPROC,DOCNUM,TIUOVR)
 ; -- Pt has no requests:
 I +TIUCNNBR=-1 D  Q
 . W !!,"This patient has no consult requests; please make sure you have the"
 . W !,"correct patient."
 . S Y=$$READ^TIUU("YO","  Want to change the patient","YES")
 . I Y S CHANGEPT=1 Q
 . I $D(DIRUT) Q
 . ; -- Ask user if want to change to PN:
 . S Y=$$ASKCHNG^TIUFIX(2,.TIUTYPE)
 ; -- User did not select request:
 I +TIUCNNBR=0 D
 . W !!,"To upload into a consult title, you must select a request."
 . S Y=$$ASKCHNG^TIUFIX(2,.TIUTYPE)
 Q
 ;
