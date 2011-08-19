TIUFIX2 ; SLC/JER,MAM - Resolve Upload Filing Errors Library Two ;05/06/02
 ;;1.0;TEXT INTEGRATION UTILITIES;**131**;Jun 20, 1997
 ;
BUFFER(TIUEVNT) ; Return 8925.2 Upload Buffer IEN
 ; Gets Buffer for UNRESOLVED upload errors. (Returns error msg
 ;for resolved filing errors, where buffer is 0.)
 ; Requires [TIUEVNT] - Upload Log Event IEN (8925.4)
 N TIUBUF
 I '$D(^TIU(8925.4,TIUEVNT,0)) S TIUBUF="0^Invalid Upload Log event." G BUFX
 S TIUBUF=+$P($G(^TIU(8925.4,TIUEVNT,0)),U,5)
 I TIUBUF'>0 S TIUBUF="0^Upload Buffer record is missing from Upload Log event." G BUFX
 I '$D(^TIU(8925.2,TIUBUF,0)) S TIUBUF="0^Upload Log event references an invalid Upload Buffer record."
BUFX Q TIUBUF
 ;
LOADHDR(TIUARR,TIUBUF,TIUPRM0,TIUTYPE) ; Load array with header data
 ;from upload buffer
 ; Requires [TIUARR] - Array of header data.  Loaded and passed back
 ;          [TIUBUF] - 8925.2 Upload Buffer IEN
 ;          [TIUPRM0] - Header signal, etc.  See SETPARM^TIULE
 ;          [TIUTYPE] - IEN of Docmt Def whose Filing Error
 ;                      Resolution Code is being invoked
 ;NOTE: LOADHDR does NOT kill ANY nodes of TIUARR.
 ;      (LOADTIUX^TIUPEFIX does kill certain nodes.)
 ;      See warning in MAKE^TIUFIX1 concerning possible
 ;      need to kill nodes of array.
 N TIUI,TIUHSIG,TIUBGN,TIULINE
 S TIUHSIG=$P(TIUPRM0,U,10),TIUBGN=$P(TIUPRM0,U,12)
 S TIUI=0 F  S TIUI=$O(^TIU(8925.2,+TIUBUF,"TEXT",TIUI)) Q:+TIUI'>0  D
 . S TIULINE=$G(^TIU(8925.2,+TIUBUF,"TEXT",TIUI,0))
 . I TIULINE[TIUHSIG D
 . . F  D  Q:TIULINE[TIUBGN!(+TIUI'>0)
 . . . N TIUN,TIUCAP,TIUFLD,TIUREQ S TIUREQ=0
 . . . S TIUI=$O(^TIU(8925.2,+TIUBUF,"TEXT",TIUI)) Q:+TIUI'>0
 . . . S TIULINE=$G(^TIU(8925.2,+TIUBUF,"TEXT",TIUI,0)) Q:TIULINE[TIUBGN
 . . . S TIUCAP=$P(TIULINE,":") Q:TIUCAP']""
 . . . ; -- Get upload header definition data for transcribed
 . . . ;    caption:
 . . . S TIUN=$O(^TIU(8925.1,TIUTYPE,"HEAD","B",TIUCAP,0))
 . . . Q:+TIUN'>0
 . . . S TIUFLD=$P(^TIU(8925.1,TIUTYPE,"HEAD",+TIUN,0),U,3)
 . . . ; -- Ignore caption if hdr def does not associate a
 . . . ;    field number with it:
 . . . Q:TIUFLD']""
 . . . S TIUREQ=$P(^TIU(8925.1,TIUTYPE,"HEAD",+TIUN,0),U,7)
 . . . S TIUARR(TIUFLD)=$$STRIP^TIULS($P(TIULINE,":",2,99))
 . . . S TIUARR(TIUFLD)=$$TRNSFRM(TIUTYPE,TIUFLD,TIUARR(TIUFLD))
 . . . ; -- If caption has no data, and hdr def requires data,
 . . . ;    set node to create missing field msg in FILE^TIUFIX1.
 . . . ;    For most fields, "** REQUIRED FIELD MISSING FROM
 . . . ;    UPLOAD**" will be invalid data and will not file.
 . . . ;    If field is free text so that it does file, at
 . . . ;    least it's intelligible.
 . . . I +TIUREQ,TIUARR(TIUFLD)="" S TIUARR(TIUFLD)="** REQUIRED FIELD MISSING FROM UPLOAD **"
 ; -- Leave missing captions fix til later; TIUPUTC1?? needs
 ;    same change 4/21/02:
 ; -- Set nodes for any captions required in upload hdr
 ;    def but missing from buffer.  Check only captions that
 ;    do NOT have Lookup variables, since that info is supplied
 ;    by user and is not a missing field.  Even if set here,
 ;    message will be created only for nodes not killed before
 ;    filing.
 ;N TIUCAP,TIUREQ,TIUFLD,LOOKV
 ;S TIUCAP=""
 ;S TIUCAP=$O(^TIU(8925.1,TIUTYPE,"HEAD","B",TIUCAP)) Q:TIUCAP=""  D
 ;. S TIUN=$O(^TIU(8925.1,TIUTYPE,"HEAD","B",TIUCAP,0))
 ;. S TIUREQ=$P(^TIU(8925.1,TIUTYPE,"HEAD",+TIUN,0),U,7)
 ;. Q:'TIUREQ
 ;. S TIUFLD=$P(^TIU(8925.1,TIUTYPE,"HEAD",+TIUN,0),U,3)
 ;. Q:'TIUFLD
 ;. S LOOKV=$P(^TIU(8925.1,TIUTYPE,"HEAD",+TIUN,0),U,4)
 ;. Q:LOOKV]""
 ;. I '$D(TIUARR(TIUFLD)) S TIUARR(TIUFLD)="** REQUIRED CAPTION MISSING FROM UPLOAD **"
 Q
TRNSFRM(RTYPE,FLD,X) ; Executes Transform code for a given header field
 N XFORM
 S FLD=$O(^TIU(8925.1,+RTYPE,"HEAD","D",+FLD,0))
 I +FLD'>0 G TRNSFRMX
 S XFORM=$G(^TIU(8925.1,+RTYPE,"HEAD",+FLD,1))
 I XFORM']"" G TRNSFRMX
 X XFORM
TRNSFRMX Q X
