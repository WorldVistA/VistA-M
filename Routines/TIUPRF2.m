TIUPRF2 ; SLC/JMH - RPCs for Patient Record Flags ; 11/3/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**184**;Jun 20, 1997
 ;
 ; $$GETACT^DGPFAPI: IA# 3860
 ; $$GETHTIU^DGPFAPI1: IA# 4383
 ; $$STOTIU^DGPFAPI2: IA# 4384
 ; 
GETTITLE(TIUY,PTDFN,FLAGID) ; RPC Gets Note Title associated with FLAGID for PTDFN
 ;Receives TIUY by ref; passes back
 ; TIUY = TitleIEN^Title
 ;        0 if no title is associated or flg assignmt is not active
 ;Requires PTDFN
 ;Requires FLAGID - identifier for particular flag assignment
 ;   for patient PTDFN. Set as subscript in GETACT^DGPFAPI.
 ; See GETFLG^ORPRF.
 N PRFARR K TIUY S TIUY=0
 Q:'$G(PTDFN)  Q:'$G(FLAGID)
 S TIUY=$$GETACT^DGPFAPI(PTDFN,"PRFARR") ;Get ACTive flag info
 Q:'TIUY
 S TIUY=$G(PRFARR(FLAGID,"TIUTITLE"))
 I TIUY'>0 S TIUY=0
 Q
 ;
GETNOTES(TIUY,PTDFN,TIUTTL,REVERSE) ; RPC gets SIGNED, LINKED PRF
 ;notes titled TIUTTL for patient PTDFN
 ; Excludes Notes linked to Entered in Error (EIE) actions and
 ;notes linked to Erroneous actions (actions taken prior to
 ;EIE actions).
 ; Receives TIUY by ref; passes back
 ;  TIUY = # of notes
 ;  TIUY([Reverse][Incremented]InternalNoteDate) =
 ;      NoteIEN^ActionName^ExternalNoteDate^AuthorName
 ; Requires PTDFN,TIUTTL
 ; Includes status Uncosigned, Completed, & Amended only.
 ; Optional REVERSE - Boolean Flag:
 ;     1 - Sort notes by reverse chronological order
 ;     0 (default) - Sort notes by chronological order
 N TIUDG,ACTID,TIUIDATE,TIUEDATE,TIUIEN,TIUACT,STATUS
 N TIUAUTH,DTARRAY,HASERR,ARRAYNM
 K TIUY ; Initialize array in case caller hasn't done so.
 S (TIUY,ACTID)=0
 ; -- Get Assgn Hist info (GETHTIU initializes array
 ;    so we don't need to):
 S ARRAYNM="^TMP(""TIUPRFH"",$J)"
 S TIUDG=$$GETHTIU^DGPFAPI1(PTDFN,TIUTTL,ARRAYNM)
 G:'TIUDG GETNOTEX
 S HASERR=$$HASERR^TIUPRFL(ARRAYNM)
 F  S ACTID=$O(@ARRAYNM@("HISTORY",ACTID)) Q:'ACTID  D
 . I ACTID=+HASERR Q  ;Entered in Error
 . I HASERR>0,$$ISERR^TIUPRFL(ARRAYNM,ACTID,$P(HASERR,U,2)) Q  ;erroneous
 . S TIUIEN=+@ARRAYNM@("HISTORY",ACTID,"TIUIEN")
 . Q:TIUIEN'>0  ;TMP node may be just ^
 . ; -- Include only complete or amended or uncosigned notes:
 . S STATUS=$P($G(^TIU(8925,TIUIEN,0)),U,5) I '((STATUS=6)!(STATUS=7)!(STATUS=8)) Q
 . S TIUACT=$P(@ARRAYNM@("HISTORY",ACTID,"ACTION"),U,2)
 . N TIUFLDS,TIUERR D GETS^DIQ(8925,TIUIEN_",","1202;1301","IE","TIUFLDS","TIUERR")
 . S TIUIDATE=TIUFLDS(8925,TIUIEN_",",1301,"I")
 . ; -- Increment date if there are multiple notes w/ same exact date:
 . F  S:$D(DTARRAY(TIUIDATE)) TIUIDATE=TIUIDATE+.0000001 I '$D(DTARRAY(TIUIDATE)) S DTARRAY(TIUIDATE)="" Q
 . I $G(REVERSE) S TIUIDATE=9999999-TIUIDATE
 . S TIUEDATE=$E(TIUFLDS(8925,TIUIEN_",",1301,"E"),1,18)
 . I TIUEDATE="" S TIUEDATE="No Ref Date"
 . S TIUAUTH=TIUFLDS(8925,TIUIEN_",",1202,"E")
 . I TIUAUTH="" S TIUAUTH="No Author"
 . S TIUY=TIUY+1
 . S TIUY(TIUIDATE)=TIUIEN_U_TIUACT_U_TIUEDATE_U_TIUAUTH
GETNOTEX ;
 K ^TMP("TIUPRFH",$J)
 Q
 ;
GETACTS(TIUY,TIUTTL,DFN) ;RPC Gets PRF Action info
 ;"Action" is shorthand for Assignment History entry
 ;Returns data in the following format for each Action:
 ;TIUY(ACTID) =
 ; FLAGNAME^ASSGNIEN^ACTIONNAME^ACTIONIEN^ACTIONDATEI^ACTIONDATEE^TIUIEN
 ;  where Integer ACTID = subscript after "HISTORY" in array returned
 ;   by GETHTIU^DGPFAPI1
 ;Returns linkable actions (whether linked or not) for Patient DFN
 ; and flag assoc w/ TIUTTL.
 ;Excludes UNLINKABLE actions = Entered in Error actions (EIE) or
 ; actions taken prior to an EIE action.
 ;Erroneous and EIE actions may be for the wrong patient, etc.
 N TIUDG,ACTID,TIUFLAG,UNLINKBL,ARRAYNM
 S TIUY=1,ARRAYNM="^TMP(""TIUPRFH"",$J)"
 S TIUDG=$$GETHTIU^DGPFAPI1(DFN,TIUTTL,ARRAYNM)
 I 'TIUDG S TIUY="0^"_$P(TIUDG,U,2) G GETACTX
 ; -- If no unlinked, linkable actions exist, say so but go on:
 I '$$AVAILACT^TIUPRFL("^TMP(""TIUPRFH"",$J)",,.UNLINKBL) S TIUY="0^All linkable Flag actions are already linked"
 ; -- Return ALL linkable actions (linked or not):
 S TIUFLAG=$P(^TMP("TIUPRFH",$J,"FLAG"),U,2)_U_$P(^TMP("TIUPRFH",$J,"ASSIGNIEN"),U)
 S ACTID=0
 F  S ACTID=$O(^TMP("TIUPRFH",$J,"HISTORY",ACTID)) Q:'+ACTID  D
 . Q:$G(UNLINKBL(ACTID))
 . S TIUY(ACTID)=TIUFLAG
 . S TIUY(ACTID)=TIUY(ACTID)_U_$P(^TMP("TIUPRFH",$J,"HISTORY",ACTID,"ACTION"),U,2)
 . S TIUY(ACTID)=TIUY(ACTID)_U_$P(^TMP("TIUPRFH",$J,"HISTORY",ACTID,"HISTIEN"),U,1)
 . S TIUY(ACTID)=TIUY(ACTID)_U_$P(^TMP("TIUPRFH",$J,"HISTORY",ACTID,"DATETIME"),U,1)
 . S TIUY(ACTID)=TIUY(ACTID)_U_$P(^TMP("TIUPRFH",$J,"HISTORY",ACTID,"DATETIME"),U,2)
 . S TIUY(ACTID)=TIUY(ACTID)_U_$P(^TMP("TIUPRFH",$J,"HISTORY",ACTID,"TIUIEN"),U,1)
GETACTX ;
 K ^TMP("TIUPRFH",$J)
 Q
 ;
LINK(TIUY,TIUIEN,ASSGNDA,ACTIEN,DFN) ;RPC Link TIU Doc TIUIEN to
 ; the PRF action
 N TIUTTL
 S TIUTTL=+$G(^TIU(8925,TIUIEN,0))
 I 'TIUTTL S TIUY="0^Document does not exist" Q
 ; Remove any links before making new link
 D UNLINK^TIUPRF1(TIUIEN)
 S TIUY=$$STOTIU^DGPFAPI2(DFN,ASSGNDA,ACTIEN,TIUIEN)
 Q
GETSTAT(TIUY,TIUIEN) ;RPC Gets the status of TIU Doc TIUIEN
 ;Returns STATIEN^STATNAME
 N TIUTTL
 S TIUTTL=+$G(^TIU(8925,TIUIEN,0))
 I 'TIUTTL S TIUY="0^Document does not exist" Q
 S TIUY=$P(^TIU(8925,TIUIEN,0),U,5)
 S TIUY=TIUY_U_$P($G(^TIU(8925.6,TIUY,0)),U,1)
 Q
ISPRFTTL(TIUY,TIUDA) ;RPC Takes as input 8925.1 IEN
 ; and checks if it is a PRF title
 ; Cf ISPFTTL^TIUPRFL. which is a FUNCTION
 N TIUCAT1,TIUCAT2,TIUD1
 S TIUY=0,TIUD1=""
 S TIUCAT1=+$$DDEFIEN^TIUFLF7("PATIENT RECORD FLAG CAT I","DC")
 S TIUCAT2=+$$DDEFIEN^TIUFLF7("PATIENT RECORD FLAG CAT II","DC")
 S TIUD1=$O(^TIU(8925.1,"AD",TIUDA,TIUD1))
 I TIUD1=TIUCAT1!(TIUD1=TIUCAT2) S TIUY=1
 Q
