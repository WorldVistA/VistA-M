RAMAGU03 ;HCIOFO/SG - ORDERS/EXAMS API (PROCEDURE UTILITIES) ; 2/24/09 3:44pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** CHECKS RADIOLOGY PROCEDURE AND MODIFIERS
 ;
 ; RAPROC        Radiology procedure and modifiers
 ;                 ^01: Procedure IEN in file #71
 ;                 ^02: Optional procedure modifiers (IENs in
 ;                 ...  the PROCEDURE MODIFIERS file (#71.2))
 ;                 ^nn:
 ;
 ; RAIMGTYI      Imaging type IEN (file #79.2) of the order/exam.
 ;
 ; RADTE         Date for procedure status check (active/inactive).
 ;
 ; [PROCTYPE]    If this parameter is defined and has a non-empty
 ;               value, then only referenced types of procedures
 ;               are allowed (see the TYPE OF PROCEDURE field (6)
 ;               of the RAD/NUC MED PROCEDURES file (#71) for more
 ;               details).
 ;
 ;                 B  Broad
 ;                 D  Detailed
 ;                 P  Parent
 ;                 S  Series
 ;
 ;               For example, "BD" will allow 'broad' or 'detailed'
 ;               procedures but exclude 'series' and 'parent' ones.
 ;
 ;               By default ($G(PROCTYPE)=""), all procedures are
 ;               allowed.
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Procedure and modifiers are valid
 ;
CHKPROC(RAPROC,RAIMGTYI,RADTE,PROCTYPE) ;
 N ERRCNT,I,IENS,L,RABUF,RAMSG,RAINFO,RAMINFO,RC,TMP
 S ERRCNT=0,RAINFO="Procedure IEN: "_(+RAPROC)
 ;
 ;=== Radiology procedure IEN
 I RAPROC>0  S RC=0  D  S:RC<0 ERRCNT=ERRCNT+1
 . S IENS=(+RAPROC)_","
 . D GETS^DIQ(71,IENS,".01;6;12;100","I","RABUF","RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,71,IENS)  Q
 . S TMP=$G(RABUF(71,IENS,.01,"I"))
 . S:TMP'="" RAINFO="Procedure: '"_TMP_"' (IEN="_(+RAPROC)_")"
 . ;--- Imaging type IEN
 . S TMP=+$G(RABUF(71,IENS,12,"I"))
 . I TMP'>0  S RC=$$ERROR^RAERR(-19,,71,IENS,12)  Q
 . ;--- Check if the procedure has required imaging type
 . I TMP'=RAIMGTYI  S RC=$$ERROR^RAERR(-12)  Q
 . ;--- Check if the procedure is/was active on requested date
 . S TMP=$G(RABUF(71,IENS,100,"I"))\1
 . I TMP>0,TMP<(RADTE\1)  D  Q
 . . S RC=$$ERROR^RAERR(-17,,$$FMTE^XLFDT(RADTE))
 . ;--- Check the procedure type if necessary
 . D:$G(PROCTYPE)'=""
 . . S TMP=$G(RABUF(71,IENS,6,"I"))
 . . I TMP'=""  Q:PROCTYPE[TMP
 . . S RC=$$ERROR^RAERR(-18,,TMP)
 E  D ERROR^RAERR(-21,,$P(RAPROC,U))  S ERRCNT=ERRCNT+1
 ;
 ;=== Procedure modifier IENs
 S L=$L(RAPROC,U)
 F I=2:1:L  S TMP=$P(RAPROC,U,I),RC=0  D  S:RC<0 ERRCNT=ERRCNT+1
 . Q:TMP=""
 . I TMP'>0  S RC=$$ERROR^RAERR(-22,,TMP)  Q
 . S IENS=(+TMP)_",",TMP=$$GET1^DIQ(71.2,IENS,.01,,,"RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,71.2,IENS)  Q
 . I TMP=""  S RC=$$ERROR^RAERR(-19,,71.2,IENS,.01)  Q
 . S RAMINFO="Procedure modifier: '"_TMP_"' (IEN="_(+IENS)_")"
 . ;--- Check the imaging type
 . I $O(^RAMIS(71.2,"AB",RAIMGTYI,+IENS,0))'>0  D  Q
 . . S RC=$$ERROR^RAERR(-39,RAMINFO)
 ;
 ;===
 Q $S(ERRCNT>0:$$ERROR^RAERR(-20,RAINFO),1:0)
 ;
 ;***** TRANSLATES A PARENT PROCEDURE INTO THE LIST OF DESCENDENTS
 ;
 ; RAPIEN        IEN of a Radiology procedure in file #71
 ;
 ; .RAPLST       Reference to a local array where IENs and names
 ;               of descendent procedures are returned to:
 ;                 RAPLST(Seq#)=IEN^Name
 ;
 ; [.SNGLRPT]    Reference to a local variable that will reflect the
 ;               value of the SINGLE REPORT field (18) of the parent
 ;               procedure (1 for YES, 0 otherwise).
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Procedure defined by the RAPIEN is not a parent one
 ;       >0  Number of descendents in the RAPLST array
 ;
DESCPLST(RAPIEN,RAPLST,SNGLRPT) ;
 N CNT,IENS,RABUF,RAMSG,RC,TMP
 K RAPLST  S SNGLRPT=0
 ;--- Get the procedure data
 S IENS=RAPIEN_","
 D GETS^DIQ(71,IENS,"6;18;300*","IE","RABUF","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,71,IENS)
 ;--- Quit if not a "parent" procedure
 Q:$G(RABUF(71,IENS,6,"I"))'="P" 0
 ;--- Single report
 S:$G(RABUF(71,IENS,18,"I"))="Y" SNGLRPT=1
 ;--- Compile the list of descendents
 S IENS="",CNT=0
 F  S IENS=$O(RABUF(71.05,IENS))  Q:IENS=""  D
 . S TMP=+$G(RABUF(71.05,IENS,.01,"I"))
 . I TMP'>0  S RC=$$ERROR^RAERR(-19,,71.05,IENS,.01)  Q
 . S CNT=CNT+1
 . S RAPLST(CNT)=TMP_U_$G(RABUF(71.05,IENS,.01,"E"))
 ;---
 Q CNT
