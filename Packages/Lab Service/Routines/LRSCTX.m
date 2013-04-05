LRSCTX ;DALOI/FHS/JDB - FIND TERM OR ADD TO FILE ;04/10/12  15:41
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 Q
 ;
 ;
EN(LRFILE,LRTXT,LRSCT,LRHL7,LRERROR,CHECK) ;
 ; Main entry point for LRSCTX.
 ; Returns a matching entry for LRTXT in LRFILE or creates a new entry in LRFILE for LRTXT.
 ; Called by OBX^LA7VIN7
 ;
 ; Inputs
 ;   LRFILE: File # to search (61, 61.2, 62)
 ;    LRTXT: Text to find
 ;    LRSCT: <opt> SNOMED CT code
 ;    LRHL7: <byref><opt> HL7 info array
 ;           ("R4")=File #4 IEN
 ;           ("R6247")=File #62.47 IEN
 ;           ("FSEC")=HL7 Field separator and Encoding characters
 ;           ("MSH",3)=Sending Application
 ;           ("MSH",4)=Sending Facility
 ;           ("MSH",5)=Receiving Application
 ;           ("MSH",6)=Receiving Facility
 ;           ("MSH",11)=Message ID
 ;           ("OBX",3)=OBX-3 (raw)
 ;           ("OBX",5)=OBX-5 (raw)
 ;  LRERROR:<byref>  See Outputs
 ;    CHECK:<opt> 1=Check for match, dont add
 ;
 ; Outputs  (record # plus info)
 ;    problem: 0^error msg  -OR-  IEN or "IEN^1" (^1=new entry flag)
 ;  LRERROR array contains any error message associated.
 ;
 N DATA,DIERR,I,LR6247,LRDATA,LRFIEN,LRFSEC,LRLEXSCT,LRMSG,LRX,SCTP,NTEXT,X,Y
 N NODE,DIERR
 S LRFILE=$G(LRFILE)
 S LRTXT=$G(LRTXT)
 S LRSCT=$G(LRSCT)
 S CHECK=$G(CHECK)
 S LRFSEC=$G(LRHL7("FSEC"))
 S LR6247=$G(LRHL7("R6247"))
 I LRFILE'?1(1"61",1"61.2",1"62") Q "0^Unknown file #"_LRFILE
 ;
 S LRFIEN=0 ;IEN of matching/new file's entry
 ;
 ; If SCT code, use LEX data if valid SCT code
 I LRSCT'="" S LRFIEN=$$CHKSCT(LRFILE,LRSCT,.LRHL7,1)
 ;
 I LRFIEN Q LRFIEN
 I $TR(LRTXT," ","")="" Q "0^Text is empty"
 ;
 ; Didnt find a valid SCT code/text match so keep searching
 ; Search for the text passed in
 K NTEXT
 S LRFIEN=$$FIND(LRTXT,LRFILE,.NTEXT)
 I LRFIEN Q LRFIEN
 ;
 ; Check SCT database for a text match
 S LRX=$$TXT4CS^LRSCT($$TRIM^XLFSTR(LRTXT),"SCT",.DATA)
 ; Use SCT code from synonym only if just one SCT matches
 I LRX="1" D
 . N SCT
 . S SCT=$O(DATA(0))
 . Q:SCT=""
 . S X=$$CODE^LRSCT(SCT,"SCT")
 . Q:X'>0  ;valid SCT?
 . ; find IEN of associated SCT code in target file
 . S LRFIEN=$$SCT2IEN^LA7VHLU6(SCT,LRTXT,"",LRFILE,"","")
 . Q:LRFIEN
 . ; do a file search for this SCT
 . S LRFIEN=$$CHKSCT(LRFILE,SCT,.LRHL7,1)
 . Q:LRFIEN
 . ; file error
 . I 'LRFIEN S X=$P(LRFIEN,"^",2) I X'="" S LRFIEN="O^"_X Q
 . K NTEXT
 . ; Search for the text passed in (trimmed)
 . S LRFIEN=$$FIND($$TRIM^XLFSTR(LRTXT),LRFILE,.NTEXT)
 ;
 ; No matches so need to add new entry
 I 'LRFIEN,'CHECK D
 . N LRIN
 . K LRERROR
 . S LRIN(.01)=$$TRIM^XLFSTR(LRTXT)
 . ; new term so set as "refer to ETS"
 . S LRIN(21)="REFERRED"
 . S LRFIEN=$$FILE^LRSCTX1(LRFILE,.LRIN,.LRERROR,.LRHL7)
 . I LRFIEN S LRFIEN=LRFIEN_"^1" ;new entry created
 . I 'LRFIEN S X=$P($G(LRERROR),"^",2) I X'="" S LRFIEN="0^"_X
 ;
 Q LRFIEN
 ;
 ;
CHKSCT(LRFILE,LRSCT,HLINFO,ADD,INACTIVE) ;
 ; Private helper method
 ; Checks for an SCT match.  If no existing LRFILE entry is found using the LEX data, a new entry in LRFILE will be created automatically.
 ; Inputs
 ;    LRFILE: File number to search/add entry to (61, 61.2, 62)
 ;     LRSCT: SCT Code to use for search
 ;    HLINFO:<byref> (from EN^LRSCTX)
 ;       ADD:<opt> dflt=0  0=dont add new entry  1=add new entry
 ;  INACTIVE: <opt>0 or 1 <dflt=0>  1=use SCT even if inactive
 ; Outputs
 ;  The IEN of the entry found or created.
 ;  If a file error occurred, output=0 and the second "^" piece  contains error info.  ie  "0^Unknown file #"
 ;
 N DATA,I,LRERROR,LRFIEN,LRLEXSCT,LRIN,NODE,NTEXT,SCTP,X,Y
 S LRFILE=$G(LRFILE),LRSCT=$G(LRSCT),INACTIVE=$G(INACTIVE,0),ADD=$G(ADD,0)
 S LRFIEN=0
 ;
 ; SCT code in target file?
 I LRFILE,LRSCT'="" S LRFIEN=$$SCT2IEN^LA7VHLU6(LRSCT,"","",LRFILE,"","")
 ;
 ; Get SCT info from LEX
 I 'LRFIEN D
 . N DATA,LR6247,SCTHIER
 . S LRLEXSCT=$$CODE^LRSCT(LRSCT,"SCT","","DATA")
 . Q:LRLEXSCT=-1
 . I 'INACTIVE Q:LRLEXSCT'>0  ; dont use if invalid SCT code
 . I INACTIVE I LRLEXSCT'>0!(LRLEXSCT'=-2) Q
 . S SCTHIER=$P($G(DATA(0)),"^",2)
 . ; check for targ file matches on SCT main, preferred, & synonyms
 . S X=$G(DATA("F"))
 . I X'="" S LRFIEN=$$FIND(X,LRFILE,.NTEXT)
 . Q:LRFIEN
 . S (X,SCTP)=$G(DATA("P"))
 . S:SCTP="" SCTP=DATA("F")
 . I X'="" S LRFIEN=$$FIND(X,LRFILE,.NTEXT)
 . Q:LRFIEN
 . ; re-sort "S"YNonym array from longest $L to shortest this results in using abbreviations as last resort
 . K Y
 . S I=0
 . F  S I=$O(DATA("S",I)) Q:'I  D  ;
 . . S X=DATA("S",I)
 . . S Y(65536-$L(X),I)=X
 . I $D(Y) K DATA("S") M DATA("S")=Y K Y
 . ;
 . S NODE="DATA(""S"")"
 . F  S NODE=$Q(@NODE) Q:NODE=""  Q:$QS(NODE,1)'="S"  D  Q:LRFIEN  ;
 . . S X=@NODE
 . . I X'="" S LRFIEN=$$FIND(X,LRFILE,.NTEXT)
 . ;
 . Q:LRFIEN
 . I 'ADD S LRFIEN="0^Function CHKSCT auto-add disabled" Q
 . ;
 . ; add new entry into target file using LEX info and stop
 . K LRIN
 . S LRIN(.01)=$$DELHIER^LRSCT(SCTP) ; SCT Preferred term
 . I LRLEXSCT D  ; only set SCT info if valid SCT code
 . . S LRIN(20)=LRSCT
 . . S LRIN(21)="PREFERRED TERM"
 . . S X=SCTHIER
 . . I X'="" S X="SCT "_X
 . . I $D(^LAB(64.061,"C",$$UP^XLFSTR(X))) D  ;
 . . . S LRIN(22)=X
 . . ;
 . ;
 . S LR6247=$G(HLINFO("R6247"))
 . S LRFIEN=$$FILE^LRSCTX1(LRFILE,.LRIN,.LRERROR,.HLINFO)
 . I LRFIEN S LRFIEN=LRFIEN_"^1" ; indicates new entry
 . I 'LRFIEN S LRFIEN="0^"_$P($G(LRERROR),"^",2)
 ;
 Q LRFIEN
 ;
 ;
FIND(LRTXT,LRFILE,NTEXT) ;
 ; Private helper method
 ; Tries to find a matching text entry in the file specified.
 ; Inputs
 ;   LRTXT: Text of term
 ;  LRFILE: File # to use
 ;   NTEXT:<byref> See Outputs
 ; Outputs
 ;   0 if no match, else the IEN of the matching record.
 ;   NTEXT: New text to use for .01 field
 ;
 ; Converts  ^  to  ~
 ; Looks for exact match in LRFILE on B & C xrefs.
 ; $$TRIMs LRTXT then looks for any match in xref B & xref C
 ; Passes an array of possible matches to $$FIND
 ; Strips off any SCT hierarchy text and tries again
 ; If no match returns 0
 ;
 N LRNIEN,DIERR,LRDATA,LRMSG,TXT2,X
 S LRTXT=$G(LRTXT)
 S LRFILE=$G(LRFILE)
 S LRNIEN=0
 S LRTXT=$TR(LRTXT,"^","~") ;also in FILE method
 ;exact text match?
 S LRNIEN=$$FIND1^DIC(LRFILE,,"OX",LRTXT,"B^C",,"LRMSG")
 I LRNIEN Q LRNIEN
 ;
 ; check B index first
 K LRDATA,LRMSG,DIERR
 D FIND^DIC(LRFILE,,"@;.01;20","M",$$TRIM^XLFSTR(LRTXT),,"B",,,"LRDATA","LRMSG")
 S LRNIEN=$$MATCH(LRTXT,.LRDATA)
 ;
 ; check C index (synonym)
 I 'LRNIEN D  ;
 . K LRDATA,LRMSG,DIERR
 . D FIND^DIC(LRFILE,,"@;.01;20","M",$$TRIM^XLFSTR(LRTXT),,"C",,,"LRDATA","LRMSG")
 . Q:'$D(LRDATA("DILIST",2))
 . S LRNIEN=$$MATCH(LRTXT,.LRDATA)
 ;
 ; strip SCT top level name off and try again ie: this is text (body structure)
 S X=$$TRIM^XLFSTR(LRTXT)
 ; last char = ) and also contains a (
 I 'LRNIEN I $E(X,$L(X),$L(X))=")" I X["(" D  ;
 . S TXT2=$$DELHIER^LRSCT(X)
 . Q:X=TXT2
 . K LRDATA,LRMSG,DIERR
 . D FIND^DIC(LRFILE,,"@;.01;20","M",TXT2,,"B",,,"LRDATA","LRMSG")
 . S LRNIEN=$$MATCH(TXT2,.LRDATA)
 . I LRNIEN D  Q  ;
 . . S NTEXT=TXT2
 . ;
 . Q:LRNIEN
 . ; check C index (synonym)
 . K LRDATA,LRMSG,DIERR
 . D FIND^DIC(LRFILE,,"@;.01;20","M",TXT2,,"C",,,"LRDATA","LRMSG")
 . I $D(LRDATA("DILIST",2)) D  ;
 . . S LRNIEN=$$MATCH(TXT2,.LRDATA)
 . . I LRNIEN S NTEXT=TXT2
 . ;
 ;
 Q LRNIEN
 ;
 ;
MATCH(TEXT,DATA) ;
 ; Private helper method
 ; Scan the DATA array for an entry that matches TEXT.
 ; Inputs
 ;  TEXT: The .01 text to match on
 ;  DATA: <byref> a DILIST array from FIND^DIC
 ; Outputs
 ;  0 = no match  or  the IEN of the matching record.
 ;
 ; Note: $$TRIMS and $$UPs for text comparisons.
 ; 1) Looks for entries in DATA that have an SCT code. If TEXT matches .01 text use that entry.
 ; 2) If no entries with SCT code match, check rest of DATA array.
 ;
 N I,LRIEN,REC,NM,SCT,TXT2
 S TEXT=$G(TEXT)
 S TXT2=$$TRIM^XLFSTR($$UP^XLFSTR(TEXT))
 S LRIEN=0
 ; find one with an SCT code first
 S I=0
 F  S I=$O(DATA("DILIST","ID",I)) Q:'I  D  Q:LRIEN  ;
 . S SCT=DATA("DILIST","ID",I,20)
 . Q:SCT=""
 . ; Should it only be a valid SCT code? does name match?
 . S REC=DATA("DILIST",2,I)
 . S NM=DATA("DILIST","ID",I,.01)
 . Q:$$TRIM^XLFSTR($$UP^XLFSTR(NM))'=TXT2
 . S LRIEN=REC
 ;
 I LRIEN Q LRIEN
 S I=0
 F  S I=$O(DATA("DILIST",2,I)) Q:'I  D  Q:LRIEN  ;
 . S REC=DATA("DILIST",2,I)
 . S NM=DATA("DILIST","ID",I,.01)
 . Q:$$TRIM^XLFSTR($$UP^XLFSTR(NM))'=TXT2
 . S LRIEN=REC
 Q LRIEN
