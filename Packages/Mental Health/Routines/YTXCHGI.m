YTXCHGI ;SLC/KCM - Instrument Specification Import ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**121**;Dec 30, 1994;Build 61
 ;
 ;Reference to TIUFLF7 APIs supported by DBIA #5352
 Q
IMPTREE(TREE,YTXDRY) ; updates database from object tree source
 ;  TREE  : name of array containing object tree
 ; .YTXLOG: array of log info (count, errors)
 ;  YTXDRY: 1 if just doing a dry run of the install
 ;
 ; get map file:field to array nodes
 ;   MAP(file,field)=node subscripts for value
 ;   MAP("store",seq,"file")=sequence for processing file entries
 ;   MAP("store",seq,"loop")=name of subscript(s) if array
 N MAP,FILESEQ,FILE,LOOP,DONE,TSTIEN,YTXERRS,YTXNOTE
 K ^TMP("YTXCHGI",$J,"ENTRY")
 ; TSTIEN may change if instrument doesn't exist yet
 S TSTIEN=$O(^YTT(601.71,"B",@TREE@("info","name"),0))
 ; build list of all entries, leftovers are delete candidates
 I TSTIEN D BLDTEST^YTXCHGV(TSTIEN,$NA(^TMP("YTXCHGI",$J,"ENTRY")))
 S YTXNOTE=$$CHKNOTE(@TREE@("info","name"))
 D BLDMAP^YTXCHGM(.MAP)
 S FILESEQ=0 F  S FILESEQ=$O(MAP("store",FILESEQ)) Q:'FILESEQ  D
 . N ARRAY
 . S ARRAY=0
 . S FILE=MAP("store",FILESEQ,"file")
 . S LOOP=MAP("store",FILESEQ,"loop")
 . I $L(LOOP) F I=1:1:$L(LOOP,":") S ARRAY(I)=$P(LOOP,":",I),ARRAY=ARRAY+1
 . I ARRAY=0 D PROCESS(FILE)         ; top level value
 . I ARRAY=1 D DEPTH1(FILE,.ARRAY)   ; one array deep
 . I ARRAY=2 D DEPTH2(FILE,.ARRAY)   ; two arrays deep
 . I ARRAY=3 D DEPTH3(FILE,.ARRAY)   ; three arrays deep
 D DELETES(TSTIEN)
 I YTXNOTE D ADDNOTE(@TREE@("info","name"))
 K ^TMP("YTXCHGI",$J,"ENTRY")
 Q
DEPTH1(FILE,ARRAY) ; loop 1 level deep in .ARRAY(1) to save in FILE
 ;     FILE: file number
 ; ARRAY(n): subscript name for level n 
 N I  ;array of current index values
 S I(1)=0
 F  S I(1)=$O(@TREE@(ARRAY(1),I(1))) Q:'I(1)  D PROCESS(FILE,.I)
 Q
DEPTH2(FILE,ARRAY) ; loop 2 levels deep in .ARRAY to save in FILE
 ;     FILE: file number
 ; ARRAY(n): subscript name for level n
 N I  ;array of current index values
 S I(1)=0 F  S I(1)=$O(@TREE@(ARRAY(1),I(1))) Q:'I(1)  D
 . S I(2)=0 F  S I(2)=$O(@TREE@(ARRAY(1),I(1),ARRAY(2),I(2))) Q:'I(2)  D PROCESS(FILE,.I)
 Q
DEPTH3(FILE,ARRAY) ; loop 3 levels deep in .ARRAY to save in FILE
 ;     FILE: file number
 ; ARRAY(n): subscript name for level n
 N I  ;array of current index values
 S I(1)=0 F  S I(1)=$O(@TREE@(ARRAY(1),I(1))) Q:'I(1)  D
 . S I(2)=0 F  S I(2)=$O(@TREE@(ARRAY(1),I(1),ARRAY(2),I(2))) Q:'I(2)  D
 . . S I(3)=0 F  S I(3)=$O(@TREE@(ARRAY(1),I(1),ARRAY(2),I(2),ARRAY(3),I(3))) Q:'I(3)  D PROCESS(FILE,.I)
 Q
PROCESS(FILE,IDX) ; using instances identified in IDX to save values to FILE
 ; expects: MAP,DONE,TSTIEN
 ;    FILE: file number
 ;     IDX: index values used to replace ?n subscripts
 ;
 ; build REC array for compare and Fileman calls
 ;   REC(fieldNum)=value
 ;   REC(fieldNum)=^TMP("YTXCHG",$J,"WP",field) -- for word processing field
 ;
 ; get values from nodes in M array representation
 K ^TMP("YTXCHG",$J,"WP")
 N FIELD,SUBS,REF,REC,IEN,UPDTYPE
 S FIELD=0 F  S FIELD=$O(MAP(FILE,FIELD)) Q:'FIELD  D
 . S SUBS=$$MKSUBS^YTXCHGU(FILE,FIELD,.IDX)
 . S REF=$E(TREE,1,$L(TREE)-1)_","_SUBS_")"
 . I $G(MAP(FILE,FIELD,"type"))["e" Q                                           ; skip
 . I $G(MAP(FILE,FIELD,"type"))["w" D WP2REC(REF,FIELD,.REC) Q                  ; wp
 . I $D(@REF) D
 . . I @REF="null" S REC(FIELD)="" Q                                            ; empty
 . . I $G(MAP(FILE,FIELD,"type"))["t" S REC(FIELD)=$$ISO2FM^YTXCHGU(@REF) Q     ; date
 . . I $G(MAP(FILE,FIELD,"type"))["y" S REC(FIELD)=$S(@REF="true":"Y",1:"N") Q  ; bool
 . . S REC(FIELD)=@REF                                                          ; other
 Q:'$D(REC)  ; nothing for this record
 ;
 ; figure out IEN (.001 for cases where file is not DINUM'd)
 S IEN=$S($D(REC(.001)):REC(.001),1:REC(.01))
 K REC(.001)
 Q:'IEN                     ; IEN is absent for empty pointer fields
 Q:$D(DONE(FILE,IEN))       ; already dealt with this record
 ;
 ; compare with current record, do nothing if same (UPDTYPE=0)
 S UPDTYPE=$$DIFFREC(FILE,IEN,.REC)
 D FMSAVE(UPDTYPE,FILE,.REC,IEN)
 S DONE(FILE,IEN)=""
 K ^TMP("YTXCHGI",$J,"ENTRY",FILE,IEN)
 K ^TMP("YTXCHG",$J,"WP")
 Q
FMSAVE(UPDTYPE,FILE,REC,IEN) ; add/update file
 N UPDOK
 I UPDTYPE=0 QUIT                              ; no changes so quit
 D LOG^YTXCHGU("prog",".")
 D LOG^YTXCHGU($S(UPDTYPE=1:"updated",UPDTYPE=2:"added",1:"unknown"))
 I UPDTYPE=1 S UPDOK='$$COLLIDE^YTXCHGV(FILE,IEN)
 ; show change if verbose and not doing verify pass
 I $G(YTXVRB),($G(YTXDRY)'=2) D SHOWREC(UPDTYPE,FILE,.REC,IEN)
 I $G(YTXDRY) QUIT                             ; dry run so quit
 ;
 ; update entry
 I UPDTYPE=1,UPDOK D FMUPD^YTXCHGU(FILE,.REC,IEN)
 ; add new entry
 I UPDTYPE=2 D
 . D FMADD^YTXCHGU(FILE,.REC,.IEN)
 . I FILE=601.71 S TSTIEN=IEN         ; in case instrument just added
 . D ADDIDX^YTXCHGV(FILE,IEN,TSTIEN)
 Q
DIFFREC(FILE,IEN,REC) ; return 0 if identical, 1 if changed, 2 if absent
 ; expects MAP
 ; will modify .REC to remove empty fields that need no update
 ;
 ; new entry, so remove empty fields in .REC and return 2 (absent)
 I '$D(^YTT(FILE,IEN)) D  QUIT 2
 . S FLD=0 F  S FLD=$O(REC(FLD)) Q:'FLD  I '$L(REC(FLD)) K REC(FLD)
 ;
 N FLD,LN,OLD,NEW,FLDS,IENS,VALS,WPREF,ERRS
 S IENS=IEN_",",FLDS="",OLD="",NEW=""
 ;
 ; build string OLD using current database values
 S FLD=0 F  S FLD=$O(REC(FLD)) Q:'FLD  S FLDS=FLDS_FLD_";"
 D GETS^DIQ(FILE,IENS,FLDS,"IN","VALS","ERRS")  ; "IN"=internal, no nulls
 S FLD=0 F  S FLD=$O(VALS(FILE,IENS,FLD)) Q:'FLD  D
 . Q:'$D(MAP(FILE,FLD))
 . S OLD=OLD_FLD_":"
 . I $O(VALS(FILE,IENS,FLD,0)) D  ; word processing
 . . S LN=0 F  S LN=$O(VALS(FILE,IENS,FLD,LN)) Q:'LN  S OLD=OLD_VALS(FILE,IENS,FLD,LN)
 . E  S OLD=OLD_VALS(FILE,IENS,FLD,"I")
 . S OLD=OLD_$C(9)
 ;
 ; remove empty values from .REC if not present in VALS
 S FLD=0 F  S FLD=$O(REC(FLD)) Q:'FLD  I '$L(REC(FLD)) D
 . I '$D(VALS(FILE,IENS,FLD)) K REC(FLD) ; nothing to remove
 ;
 ; build string NEW using REC array
 S FLD=0 F  S FLD=$O(REC(FLD)) Q:'FLD  D
 . S NEW=NEW_FLD_":"
 . I $E(REC(FLD),1,5)="^TMP(" D  ; word processing
 . . S WPREF=$NA(^TMP("YTXCHG",$J,"WP",FLD))
 . . S LN=0 F  S LN=$O(@WPREF@(LN)) Q:'LN  S NEW=NEW_@WPREF@(LN,0)
 . E  S NEW=NEW_REC(FLD)
 . S NEW=NEW_$C(9)
 ;
 I NEW=OLD Q 0                 ; return same
 Q 1                           ; return different
 ;
WP2REC(TREEREF,FIELD,REC) ; parse CRLF delimited JSON TREE text into ^TMP
 I '$D(@TREEREF) QUIT  ; nothing in WP field
 ;
 K ^TMP("YTXCHG",$J,"WP",FIELD)
 D TR2WP^YTXCHGT(TREEREF,$NA(^TMP("YTXCHG",$J,"WP",FIELD)))
 S REC(FIELD)=$NA(^TMP("YTXCHG",$J,"WP",FIELD))
 Q
 ;
SHOWREC(UPDTYPE,FILE,REC,IEN) ; show record
 N FLD,X
 S FLD=0,X="" F  S FLD=$O(REC(FLD)) Q:'FLD  D
 . I $L(X) S X=X_", "
 . S X=X_FLD_"="
 . I $E(REC(FLD))="^" S X=X_$E($G(^TMP("YTXCHG",$J,"WP",FLD,1)),1,30)_"..." I 1
 . E  S X=X_REC(FLD)
 W !,$S(UPDTYPE=0:"Nop ",UPDTYPE=1:"Upd ",UPDTYPE=2:"Add ",1:"??? "),FILE,":",IEN,?20
 W X
 Q
DELETES(TSTIEN) ; delete records no longer used by instrument
 ; expects YTXDRY,YTXVRB (if defined)
 ; uses "leftover" entries in ^TMP("YTXCHGI",$J,"ENTRY",file,ien)
 N FILE,IEN,OWNED
 ; F FILE=601.76,601.79,601.81,601.83,601.86,601.93 S OWNED(FILE)=""
 S FILE=0 F  S FILE=$O(^TMP("YTXCHGI",$J,"ENTRY",FILE)) Q:'FILE  D
 . S IEN=0 F  S IEN=$O(^TMP("YTXCHGI",$J,"ENTRY",FILE,IEN)) Q:'IEN  D
 . . D DELIDX^YTXCHGV(FILE,IEN,$G(TSTIEN))
 . . ; only remove entry if no other instrument is referencing it
 . . I $$ISONLY^YTXCHGV(FILE,IEN,TSTIEN) D
 . . . D LOG^YTXCHGU("deleted")              ; increment deleted count
 . . . I $G(YTXVRB),($G(YTXDRY)'=2) W !,"Del ",FILE,":",IEN
 . . . I $G(YTXDRY) QUIT                     ; if dry run don't delete
 . . . D FMDEL^YTXCHGU(FILE,IEN)
 . . E  I $G(YTXVRB),($G(YTXDRY)'=2) W !,"Old ",FILE,":",IEN
 Q
CHKNOTE(NAME) ; Return 1 if a default note should be added
 N IEN
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN 1  ; new instrument, so add
 Q:$P($G(^YTT(601.71,IEN,2)),U,2)="U" 1      ; moving from under development
 Q 0
 ;
ADDNOTE(NAME) ; Add default note for this instrument
 N IEN,NOTE,CSLT,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 Q:$P($G(^YTT(601.71,IEN,2)),U,2)'="Y"       ; must be operational
 Q:$P($G(^YTT(601.71,IEN,8)),U,9)>0          ; note title already there
 S NOTE=+$$DDEFIEN^TIUFLF7("MENTAL HEALTH DIAGNOSTIC STUDY NOTE","TL")
 S CSLT=+$$DDEFIEN^TIUFLF7("MENTAL HEALTH CONSULT NOTE","TL")
 I 'NOTE,'CSLT QUIT                          ; neither title found
 S REC(28)="Y"
 S REC(29)=NOTE
 S REC(30)=CSLT
 D FMSAVE(1,601.71,.REC,IEN)                 ; FMSAVE in case dry run
 D LOG^YTXCHGU("info","Linked note title.")
 Q
