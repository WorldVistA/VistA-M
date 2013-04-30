LRSCT ;DALOI/STAFF - SNOMED SCT UTILITIES ;01/10/11  10:46
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;
 Q
 ;
CODE(LRCODE,LRSRC,LRDT,LRARR) ;
 ;
 ; Wrapper for LEX CODE API
 ; If LRARR not specified, the default LEX array is killed on exit
 ; Inputs
 ;  LRCODE : The SCT code
 ;   LRSRC : The code source
 ;    LRDT : <opt> The effective date
 ;   LRARR : <opt><byname> The output array (not byref)
 ; Outputs
 ;   The modified CODE^LEXTRAN return string:
 ;     1=valid  -1=not found  -2=inactive  -99=API error
 ;   The CODE^LEXTRAN output array (in LRARR)
 ;
 N STATUS,LRX,STOP,X
 N DIERR,LEX ; New LEX which is used/returned by Lexicon when return array not defined.
 S LRARR=$G(LRARR)
 I LRARR'="" K @LRARR
 I $G(LRDT)="" S LRDT=$$DT^XLFDT()
 S STOP=0
 S STATUS=$$CODE^LEXTRAN($G(LRCODE),$G(LRSRC),$G(LRDT),LRARR)
 ;
 I +STATUS=-2 D
 . S STOP=1
 . S $P(STATUS,"^",1)=-1
 ;
 I +STATUS=-4 D
 . S STOP=1,$P(STATUS,"^",1)=-2
 . S X=$P(STATUS,"not active for ",2)
 . I X?1(7N,7N1"."1.N) S $P(STATUS,"not active for ",2)=$$FMTE^XLFDT(X,"MZ")
 ;
 I +STATUS=-8 D
 . S STOP=1,$P(STATUS,"^",1)=-2
 . S X=+$P(STATUS," ",2)
 . I X?1(7N,7N1"."1.N) S $P(STATUS," ",2)=$$FMTE^XLFDT(X,"MZ")
 . I LRDT=DT Q
 . K:LRARR'="" @LRARR
 . S LRX=$$CODE^LEXTRAN(LRCODE,LRSRC,DT,LRARR)
 ;
 I 'STOP,+STATUS=-1 S $P(STATUS,"^",1)=-99
 ;
 Q STATUS
 ;
 ;
SCTOK(SCT,DATE,LROUT) ;
 ; Is this SCT code valid?
 ; Inputs
 ;  SCT  :  The SCT Code
 ; DATE  :<opt> The date to use for the lookup (defaults to today)
 ; LROUT :<opt><byref> Holds the SCT code info.  See Outputs.
 ;
 ; Outputs
 ;   Returns 0 if invalid or 1 if valid
 ;   Returns SCT info in the LROUT array
 ;
 N LRZ,STATUS
 N DIERR
 S SCT=$G(SCT)
 S DATE=$G(DATE)
 S LROUT=$G(LROUT)
 I 'DATE S DATE=$$DT^XLFDT()
 S STATUS=0
 S STATUS=+$$CODE(SCT,"SCT",DATE,"LRZ")
 M LROUT=LRZ
 I +STATUS'=1 S STATUS=0
 Q STATUS
 ;
 ;
GETSCT(LRFILE,LRIEN) ;
 ; Returns the SCT code for the File/record specified
 ;  Inputs
 ;   LRFILE: File # (61, 62, 61.2)
 ;    LRIEN: IEN of file entry
 N LRFLD
 N DIERR,LRTARG,LRMSG
 S LRFLD=""
 I LRFILE=61 S LRFLD=20
 I LRFILE=62 S LRFLD=20
 I LRFILE=61.2 S LRFLD=20
 I 'LRFLD Q 0
 Q $$GET1^DIQ(LRFILE,LRIEN_",",LRFLD,"I","LRTARG","LRMSG")
 ;
 ;
FINDSCT(LRFILE,LRSCT) ;
 ; Finds an SCT code in the specified file.
 ; Inputs
 ;  LRFILE: File number
 ;   LRSCT: The SCT code
 ; Outputs
 ;  "IEN^external value" of the entry from the specified file.
 ;
 N LRIEN,NAME,DATA
 S LRFILE=$G(LRFILE)
 S LRSCT=$G(LRSCT)
 I 'LRFILE Q 0
 I LRSCT="" Q 0
 S LRIEN=0
 S DATA=""
 I LRFILE=61 D  ;
 . S LRIEN=+$O(^LAB(61,"F",LRSCT,0))
 . I LRIEN S DATA=$G(^LAB(61,LRIEN,0))
 ;
 I LRFILE=61.2 D  ;
 . S LRIEN=+$O(^LAB(61.2,"F",LRSCT,0))
 . I LRIEN S DATA=$G(^LAB(61.2,LRIEN,0))
 ;
 I LRFILE=62 D  ;
 . S LRIEN=+$O(^LAB(62,"F",LRSCT,0))
 . I LRIEN S DATA=$G(^LAB(62,LRIEN,0))
 ;
 S NAME=$P(DATA,U,1)
 I LRIEN S LRIEN=LRIEN_"^"_NAME
 Q LRIEN
 ;
 ;
GETPREF(SCT) ;
 ; Returns the Preferred Name for an SCT code
 N PREF,DATA,X
 S PREF=""
 S X=$$CODE(SCT,"SCT",,"DATA")
 S PREF=$G(DATA("P"))
 Q PREF
 ;
 ;
 ;
GETFSN(SCT) ;
 ; Returns fully specified SCT term
 N FSN,DATA,X
 S FSN=""
 S X=$$CODE(SCT,"SCT",,"DATA")
 S FSN=$G(DATA("F"))
 Q FSN
 ;
 ;
TXT4CS(LRTXT,LRCS,LRARR,LRHIER) ;
 ;
 ; Inputs
 ;   LRTXT: Text to find in SCT codeset
 ;    LRCS: Codeset to search (dflt=SCT)
 ;   LRARR:<byref> See Outputs
 ;  LRHIER:<opt>
 ; Outputs
 ;   Returns # of matches"  or  "0^error message"
 ;   LRARR array will contain info about matches
 ;             LRARR(code)=hierarchy
 ;
 N X,LEX,DIERR
 S LRTXT=$G(LRTXT)
 S LRCS=$G(LRCS,"SCT")
 S LRHIER=$G(LRHIER)
 K LRARR
 S X=$$TXT4CS^LEXTRAN(LRTXT,LRCS,"",LRHIER)
 I X>0 S X=$P(X,"^",2)
 I X<0 S $P(X,"^",1)=0
 M LRARR=LEX
 Q X
 ;
 ;
DELHIER(TEXT) ;
 ; Removes any SCT Hierachy text from TEXT
 ; Inputs
 ;   TEXT:  The text to check
 ; Outputs -- The text less the SCT Hierarchy (if applicable)
 N STR,X
 S TEXT=$G(TEXT)
 S STR=TEXT
 S STR=$$TRIM^XLFSTR(STR)
 ; last char = ) and also contains a (
 I $E(STR,$L(STR),$L(STR))=")" I STR["(" D  ;
 . N TXT2,TXT3,STOP
 . S STOP=0
 . ; Text to use -- ie: this is the text
 . S TXT2=$RE(TEXT) S TXT2=$P(TXT2,"(",2,$L(TXT2)) S TXT2=$RE(TXT2)
 . S TXT2=$$TRIM^XLFSTR(TXT2)
 . ; get last ( piece  -- ie: (body structure)
 . S TXT3=$RE(TEXT) S TXT3=$P(TXT3,"(",1) S TXT3=$RE(TXT3) S TXT3=$P(TXT3,")",1)
 . S TXT3=$$TRIM^XLFSTR(TXT3)
 . Q:TXT3=""
 . S X="SCT "_TXT3
 . S STOP=1
 . ; dont remove non-SCT hierarchy phrases in paranthesis
 . I $D(^LAB(64.061,"B",X)) S STOP=0  ;valid SCT Hierachy?
 . I $D(^LAB(64.061,"C",$$UP^XLFSTR(X))) S STOP=0
 . Q:STOP
 . S STR=TXT2
 Q STR
 ;
 ;
LEX6247(R6247,LROUT) ;
 ; Gets SCT/LEX info for a File #62.47 entry
 ; Inputs
 ;   R6247: File #62.47 IEN
 ;   LROUT:<byref><opt>
 ; Outputs
 ;   Returns the #64.061 IEN of the #62.47 entry queried.
 ;   Also returns aditional info in the LROUT array:
 ;         LROUT("SCTIEN")
 ;         LROUT("SCTTOP")
 ;         LROUT("LEXABRV")
 ;
 N R64061,SCTIEN,DATA,X
 S R6247=+$G(R6247)
 K LROUT
 S LROUT("SCTIEN")=""
 S LROUT("SCTTOP")=""
 S LROUT("LEXABRV")=""
 I 'R6247 Q 0
 S DATA=$G(^LAB(62.47,R6247,0))
 S R64061=$P(DATA,U,3) ;fld .03
 I 'R64061 Q 0
 S DATA=$G(^LAB(64.061,R64061,63))
 S SCTIEN=$P(DATA,U,4) ;fld 63.3
 S LROUT("SCTIEN")=SCTIEN ;IEN
 S DATA=$G(^LAB(64.061,+SCTIEN,0))
 S X=$P(DATA,U,1)
 S LROUT("SCTTOP")=X
 ;S DATA=$G(^LAB(64.061,+SCTIEN,0))
 ;S X=$P(DATA,U,1)
 ;S LROUT("SCTHIER")=X
 S DATA=$G(^LAB(64.061,+SCTIEN,1))
 S X=$P(DATA,U,1) ;fld 12
 S LROUT("LEXABRV")=X
 Q R64061
