MAGNAU03 ;WOIFO/NST - Utilities for RPC calls ; 29 Jun 2017 4:16 PM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 92;Aug 02, 2012
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ; ****  Get a record from a file by IEN 
 ; 
 ; Input parameters
 ; ================
 ; 
 ; FILE = FileMan number of the file (e.g. 2005.003)
 ; PK = IEN in the file
 ; FLAGS
 ;    D - exclude deleted annotations 
 ;    U - include all user's annotations
 ;    W - include word processing fields
 ; CNT = First node in output array
 ;
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = Failure status^Error getting values
 ; if success
 ;   MAGRY(0) =  Success status^^Total lines
 ;   MAGRY(1) = header with name of the fields
 ;   MAGRY(3) = "^" delimited pairs with internal and external values of the fields listed in MAGRY(1) 
 ;   MAGRY(n) = "WordProcesingFieldxxx^line value"
 ;   MAGRY(m) = "MultipleField000^fields header"
 ;   MAGRY(m..m+1) = "MultipleField001^fields values listed in MAGRY(m)" 
 ;   
GRECBYPK(MAGRY,FILE,PK,FLAGS,CNT) ;
 N FIELDS,FLDSARR,FLDSARRW
 N OUT,ERR,TMPOUT,IENS,CNTSTART
 N I,J,WPTYPE,SUBFILE
 N RESDEL
 S RESDEL=$$RESDEL^MAGNU002()
 S FIELDS=$$GETFLDS^MAGNU001(.FLDSARR,.FLDSARRW,FILE,"") ; file fields names
 S IENS=PK_","
 D GETS^DIQ(FILE,PK_",","**","IE","OUT","ERR")
 ;
 I $$ISERROR^MAGNU002(.MAGRY,.ERR) Q   ; Set MAGOUT and quit if error exists
 ;
 ; Output the data
 S CNT=CNT+2 ; 1 is for the header, 2 is the first record with values
 S CNTSTART=CNT
 S MAGRY(CNT)=PK
 S J=""
 F  S J=$O(FLDSARR(J)) Q:J=""  D
 . S MAGRY(CNT)=MAGRY(CNT)_RESDEL_OUT(FILE,IENS,J,"I")_RESDEL_OUT(FILE,IENS,J,"E")
 . Q
 ; Now get the word-processing and multiple fields
 S J=""
 F  S J=$O(FLDSARRW(J)) Q:J=""  D
 . I $$ISFLDWP^MAGNU001(.WPTYPE,FILE,J) D  Q
 . . Q:'$F(FLAGS,"W")  ; Exclude word-processing fields 
 . . K TMPOUT
 . . M TMPOUT=OUT(FILE,IENS,J)
 . . D WORDPROC(.MAGRY,.CNT,.TMPOUT,FLDSARRW(J))  ; get word-processing field value
 . . Q
 . ; multi field
 . D MULTI(.MAGRY,.CNT,.OUT,FILE,FLDSARRW(J),FLAGS)
 . Q
 ;
 ; write the header
 S MAGRY(CNTSTART-1)="IEN"
 S I=""
 F  S I=$O(FLDSARR(I)) Q:I=""  S MAGRY(CNTSTART-1)=MAGRY(CNTSTART-1)_RESDEL_FLDSARR(I)
 S MAGRY(0)=$$SETOKVAL^MAGNU002(CNT)
 Q
 ;
WORDPROC(MAGRY,CNT,WP,FLDNAME)  ; add word-processing field values to the result
 N L,RESDEL
 S RESDEL=$$RESDEL^MAGNU002()
 S L=""
 F  S L=$O(WP(L)) Q:'L  D
 . S CNT=CNT+1,MAGRY(CNT)=FLDNAME_$TR($J(L,3)," ",0)_RESDEL_WP(L)
 . Q
 Q
 ;
MULTI(MAGRY,CNT,OUT,FILE,FLDNAME,FLAGS)  ; add word-processing field values to the result
 N IEN,J,L,RESDEL
 N SUBFILE,FIELDS,FLDSARR,FLDSARRW
 ;
 S RESDEL=$$RESDEL^MAGNU002()
 S SUBFILE=$$GSUBFILE^MAGNU001(FILE,FLDNAME)  ; get sub-file number
 S FIELDS=$$GETFLDS^MAGNU001(.FLDSARR,.FLDSARRW,SUBFILE,"")
 ; write header of multiple record
 S CNT=CNT+1,MAGRY(CNT)=FLDNAME_"000"_RESDEL_"IEN"
 S J=""
 F  S J=$O(FLDSARR(J)) Q:J=""  S MAGRY(CNT)=MAGRY(CNT)_RESDEL_FLDSARR(J)
 ;
 ; write the values of the multiple record
 S L=""
 F  S L=$O(OUT(SUBFILE,L)) Q:L=""  D
 . I '$F(FLAGS,"D") Q:$G(OUT(SUBFILE,L,5,"I"))  ; Skip deleted annotations
 . I '$F(FLAGS,"U") Q:OUT(SUBFILE,L,1,"I")'=DUZ  ; Skip deleted annotations
 . S IEN=$P(L,",")  ; IEN of the mutliple record
 . S CNT=CNT+1,MAGRY(CNT)=FLDNAME_$TR($J(IEN,3)," ",0)_RESDEL_IEN
 . S J=""
 . F  S J=$O(FLDSARR(J)) Q:J=""  D
 . . S MAGRY(CNT)=MAGRY(CNT)_RESDEL_OUT(SUBFILE,L,J,"I")_RESDEL_OUT(SUBFILE,L,J,"E")
 . . Q
 . S J=""
 . F  S J=$O(FLDSARRW(J)) Q:J=""  D
 . . I $$ISFLDWP^MAGNU001(.WPTYPE,SUBFILE,J) D  Q
 . . . Q:'$F(FLAGS,"W")  ; skip word processing field 
 . . . K TMPOUT
 . . . M TMPOUT=OUT(SUBFILE,L,J)
 . . . D WORDPROC(.MAGRY,.CNT,.TMPOUT,FLDSARRW(J))  ; get word-processing field value
 . . . Q
 . . ; multi field
 . . D MULTI(.MAGRY,.CNT,.OUT,SUBFILE,FLDSARRW(J),FLAGS)
 . . Q
 . Q
 Q
