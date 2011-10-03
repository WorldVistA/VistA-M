PSOUTLA2 ;BHAM ISC/GSN-Pharmacy utility program cont. ;6/6/05 12:19pm
 ;;7.0;OUTPATIENT PHARMACY;**210**;DEC 1997
 Q
 ;
WORDWRAP(STR,IEN,GL,LM) ;Wraps words at spaces normally and will breakup long
 ;               words at a delimiter & wrap at those break points
 ; Input: STR - a text string
 ;        IEN - ien of global
 ;        GL  - global root
 ;        LM  - left margin
 ; Output: Populated global  (usually in ^TMP)
 ;
 ; When a long word is encountered, i.e. text with no spaces, an
 ; attempt will be made to locate a delimiter & break the line there. 
 ; If it can't find a valid delimiter without a restricted scenario,
 ; i.e. a number like 1,000 , then it will be forced to break at the
 ; End of Line (EOL).
 ;
 ;    Delimiters searched for and order they are picked for use:
 ;        preferred:   ,    ;
 ;        alternate:   :    =
 ;        do not use:  -  .  )  (  /    (to critical, used in dosing)
 ;         example:  "TAKE 1/2-1 TAB(7.5MG) TABLET(S)"
 ;
 ; Key Variables: WORD  - current word from text string
 ;                WORD1 - 1st part of word that will fit
 ;                WORD2 - 2nd part of word for new line
 ;                WORD0 - remnant that won't fit on the new line
 ;
 N QQ,DL,DLM,WD,LL,TL,UL,MAXLN,LSTD,CURD,GWRD,LC,WORD0,WORD,WORD1,WORD2
 S IEN=+$G(IEN),@GL@(IEN,0)=$G(@GL@(IEN,0)),WORD0=""
 ;loop thru words, quit if no more words & no remnants - i.e. WORD0
 F QQ=1:1 S WORD=$P(STR," ",QQ) D  Q:(QQ'<$L(STR," "))&(WORD0="")
 . ;if remnant exists, prepend to next Word
 . S:WORD0]"" WORD=WORD0_WORD,WORD0=""
 . ;wrap short words at spaces, check if last char is already a space
 . S GWRD=@GL@(IEN,0)
 . S LC=$E(@GL@(IEN,0),$L(GWRD))
 . I LC=" ",$L(GWRD_WORD)<81 S @GL@(IEN,0)=@GL@(IEN,0)_WORD Q
 . I LC'=" ",$L(GWRD_" "_WORD)<81 S @GL@(IEN,0)=@GL@(IEN,0)_" "_WORD Q
 . I $L(WORD)<20,$L(LM+1+$L(WORD))<81 D  Q
 . . S WORD1="",WORD2=WORD,DLM="" D ADDWORDS S WORD0=WORD2 Q
 . ;
 . ;word>80, so wrap long words @ a specific delimiter, if found
 . S MAXLN=79-$L(@GL@(IEN,0))
 . ;search backwards & pick 1st dl  > 1 count of preferred delims
 . F DL=";","," S DL($L(WORD,DL))=DL
 . S DL=$O(DL(DL),-1) S DLM=$S(DL>1:DL(DL),1:"")
 . I DLM="" F DL="=",":" S DL($L(WORD,DL))=DL D  ;try these alt delims
 . . S DL=$O(DL(DL),-1) S DLM=$S(DL>1:DL(DL),1:"")
 . ;
 . ;no good delimiter, will have to break at end of line
 . I DLM="" D  Q
 . . S WORD1=$E(WORD,1,MAXLN),WORD2=$E(WORD,MAXLN+1,$L(WORD))
 . . D ADDWORDS S WORD0=WORD2
 . ;
 . ;good delimiter, will break at last dlm that fits within maxln
 . S (LSTD,LL)=0,CURD=1 F TL=0:0 S CURD=$F(WORD,DLM,CURD) Q:'CURD  D
 . . S TL=TL+1
 . . S WD(TL)=CURD_"^"_$E(WORD,CURD-2,CURD)
 . . S:CURD<MAXLN LSTD=CURD,LL=TL
 . ;special check of "," embedded in a number  e.g. 1,000
 . ;backup to previous delimiter if pattern match
 . I DLM="," F UL=LL:-1:0 Q:$P($G(WD(UL)),"^",2)'?1N1","1N
 . I DLM=",",+$G(WD(UL))<LSTD S LSTD=+$G(WD(UL))
 . ;
 . ;'LSTD usually means no valid Dlm's found in Word, but if line
 . ;found to have some valid Dlm's later in the Word, then go ahead
 . ;defer entire string to next line via Addwords Api
 . I 'LSTD,TL>LL,$P($G(WD(TL)),"^",2)'?1N1","1N D  Q
 . . S WORD1="",WORD2=WORD D ADDWORDS S WORD0=WORD2
 . ;
 . ;no valid Dlm's found in word, can't determine a word, break @EOL
 . I 'LSTD,$L(WORD)>(MAXLN) D  Q
 . . S WORD1=$E(WORD,1,MAXLN),WORD2=$E(WORD,MAXLN+1,$L(WORD))
 . . D ADDWORDS S WORD0=WORD2
 . ;no valid Dlm's found in word, and can add Word to curr line
 . I 'LSTD,$L(WORD)'>(MAXLN) S @GL@(IEN,0)=@GL@(IEN,0)_WORD Q
 . ;
 . ;valid Dlm's & location found indicated by SS
 . I LSTD D  Q
 . . S WORD1=$E(WORD,1,LSTD-1),WORD2=$E(WORD,LSTD,$L(WORD))
 . . D ADDWORDS S WORD0=WORD2
 Q
 ;
ADDWORDS ;Add words to curr line and to a new line
 N CH
 ;if last character is the DLM or a " ", then don't add a space when
 ;adding Word1 to current line
 S CH=$E(@GL@(IEN,0),$L(@GL@(IEN,0)))
 I (CH=DLM)!(CH=" ") D
 . S @GL@(IEN,0)=@GL@(IEN,0)_WORD1
 E  D
 . S @GL@(IEN,0)=@GL@(IEN,0)_" "_WORD1
 ;create new line to hold Word2
 S IEN=IEN+1,$P(@GL@(IEN,0)," ",LM+1)=" "
 S MAXLN=79-$L(@GL@(IEN,0))
 ;word2 won't fit, quit for further wrapping
 Q:$L(WORD2)>(80-LM)
 ;word2 will fit add it
 S @GL@(IEN,0)=@GL@(IEN,0)_WORD2,WORD2=""
 Q
