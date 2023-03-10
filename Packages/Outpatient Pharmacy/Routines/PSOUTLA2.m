PSOUTLA2 ;BHAM ISC/GSN-Pharmacy utility program cont. ;6/6/05 12:19pm
 ;;7.0;OUTPATIENT PHARMACY;**210,410,507,694**;DEC 1997;Build 12
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
 . . S:CURD'>MAXLN LSTD=CURD,LL=TL
 . ;special check of "," embedded in a number  e.g. 1,000
 . ;backup to previous delimiter if pattern match
 . I DLM="," F UL=LL:-1:0 Q:$P($G(WD(UL)),"^",2)'?1N1","1N
 . I DLM=",",+$G(WD(UL))<LSTD S LSTD=+$G(WD(UL))
 . ;
 . ;*410
 . ;if WORD is longer than 60 characters and a valid delimiter is 
 . ;found after character position 57 (58 or later), ignore the 
 . ;delimiter and break at end of line since entire word will not
 . ;fit on one line
 . N WORDLN S WORDLN=$L(WORD) I DLM]"",DLM'="," S WORDLN=$F(WORD,DLM,1)-1
 . S WORD1=$E(WORD,1,WORDLN),WORD2=$E(WORD,WORDLN+1,$L(WORD))
 . I (LM+1+$L(WORD1))>80 S WORD1=$E(WORD,1,MAXLN),WORD2=$E(WORD,MAXLN+1,$L(WORD))
 . I DLM]"",($F(WORD,DLM,1)-1)>57,$L(WORD)'<60 D  Q
 . . D ADDWORDS S WORD0=WORD2
 . ;
 . ;'LSTD usually means no valid Dlm's found in Word, but if line
 . ;found to have some valid Dlm's later in the Word, then go ahead
 . ;defer entire string to next line via Addwords Api
 . I 'LSTD,TL>LL,$P($G(WD(TL)),"^",2)'?1N1","1N D  Q
 . . D ADDWORDS S WORD0=WORD2
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
 ;
DMACTN ;Entry point for DM hidden action from backdoor OE  *507
 D FULL^VALM1
 N IFN S IFN=+$G(PSODRUG("IEN")) D SHOWDR
 S VALMBCK="R"
 Q
 ;
PICKDR ;Entry point for Selecting a diff Drug
 N IFN,Y
 W ! K DIC S DIC="^PSDRUG(",DIC(0)="AEQMVTN",DIC("T")="" W "Return to continue or" D ^DIC K DIC I Y<0 Q
 S IFN=+Y
 ;
SHOWDR ;Entry point to Display Drug hidden action info (defaulted IFN via DM actn)
 N DIR,OIPTR
 I 'IFN W !!,"** NO Dispense Drug entered for this order",! G PICKDR
 W #,!,"DRUG NAME: ",$$GET1^DIQ(50,IFN_",","GENERIC NAME")," (IEN: "_IFN_")"
 S OIPTR=^PSDRUG(IFN,2) S:$P(OIPTR,"^",1)]"" OIPTR=$P(OIPTR,"^",1)
 I OIPTR]"" W !," ORDERABLE ITEM TEXT: ",! D DMOITXT
 W !," MESSAGE: ",$$GET1^DIQ(50,IFN_",","MESSAGE") D FULL
 W !," QTY DISP MESSAGE: ",$$GET1^DIQ(50,IFN_",","QUANTITY DISPENSE MESSAGE"),! D FULL
 K Y
 G PICKDR
 ;
DMOITXT ;Get Pharmacy Orderable Item drug text fields
 N DDD,QUIT,TXT,TEXT,TEXTPTR
 I $D(^PS(50.7,OIPTR,1,0)) F TXT=0:0 S TXT=$O(^PS(50.7,OIPTR,1,TXT)) Q:'TXT  D
 . S TEXTPTR=^PS(50.7,OIPTR,1,TXT,0)
 . F DDD=0:0 S DDD=$O(^PS(51.7,TEXTPTR,2,DDD)) Q:'DDD  I '$$INACDATE S TEXT=^PS(51.7,TEXTPTR,2,DDD,0) D FULL Q:$G(QUIT)  W "  ",TEXT,!
 Q
 ;
FULL ;Screen is full, pause
 D:($Y+3)>IOSL&('$G(QUIT)) FSCRN
 Q
 ;
FSCRN ;User Wait as screen if full
 Q:$G(QUIT)  K DIR S DIR(0)="E",DIR("A")="Press Return to continue,'^' to exit" D ^DIR W @IOF S:Y'=1 QUIT=1
 Q
 ;
INACDATE() ;Check Inactive date
 Q $P($G(^PS(51.7,TEXTPTR,0)),"^",2)
 ;
VPACTN  ;Entry point for VP hidden action from backdoor OE  *507
 D FULL^VALM1
 N IFN
 S IFN=+$G(PSONEW("PROVIDER")) D SHOWVP
 S VALMBCK="R"
 Q
 ;
PICKVP  ;Entry Point For Selecting a diff provider
 N IFN,Y
 W ! K DIC S DIC="^VA(200,",DIC(0)="AEQMVTN",DIC("T")="" W !,"Return to continue or" D ^DIC K DIC I Y<0 Q
 S IFN=+Y
 ;
SHOWVP  ;Entry point to Display Provider hidden action info (via defaulted IFN)
 N DIR
 I 'IFN W !,"No provider entered for this order",! G PICKVP
 W #,"PROVIDER TITLE:    ",$$GET1^DIQ(200,IFN_",","TITLE")
 W !!,"PROVIDER REMARKS:  ",$$GET1^DIQ(200,IFN_",","REMARKS")
 W !!,"PROVIDER SPECIALTY:  ",$$GET1^DIQ(200,IFN_",","PROVIDER CLASS"),!,"                     "_$$GET1^DIQ(200,IFN_",","SERVICE/SECTION")
 K Y
 G PICKVP
 Q
 ;
SUSPDAYS(IEN) ; Return correct suspense days parameter value per Rx IEN in Suspense file  *694
 ; IEN = Internal entry number for the RX SUSPENSE file
 N RTN,PIEN,MAIL,LOCTST,CS,LCSV,LNCSV,CCSV,CNCSV
 S RTN=""
 S PIEN=$$GET1^DIQ(52.5,IEN,.03,"I"),MAIL=$$GET1^DIQ(55,PIEN,.03,"I")
 S LOCTST=$S(MAIL<2&'$$CKCMOP(IEN):"LOCAL",MAIL>2:"LOCAL",1:"")
 S CS=$$CHKCS(IEN)
 ;pull ahead Days params for - Local CS, Local Non=CS, CMOP CS, CMOP Non-CS
 S LCSV=$P(PSOPAR,U,34),LNCSV=$P(PSOPAR,U,27),CCSV=$P(PSOPAR,U,9),CNCSV=$P(PSOPAR,U,35)
 S RTN=$S(LOCTST="LOCAL"&(CS):LCSV,LOCTST="LOCAL"&('CS):LNCSV,$$CKCMOP(IEN)&(CS):CCSV,$$CKCMOP(IEN)&('CS):CNCSV,1:0)
 Q RTN
 ;
CKCMOP(IEN) ; See if CMOP dispenable by Rx drug setting *694
 ; IEN = Internal entry number for the RX SUSPENSE file
 N RXIEN,DGIEN,RTN
 S RXIEN=$$GET1^DIQ(52.5,IEN,.01,"I")
 S DGIEN=$$GET1^DIQ(52,RXIEN,6,"I")
 S RTN=+$$GET1^DIQ(50,DGIEN,213,"I")
 Q RTN
 ;
CHKCS(IEN) ; See if Rx drug is contolled substance (CS)  *694
 ; IEN = Internal entry number for the RX SUSPENSE file
 N RXIEN,DGIEN,DEA,RTN
 S RXIEN=$$GET1^DIQ(52.5,IEN,.01,"I")
 S DGIEN=$$GET1^DIQ(52,RXIEN,6,"I")
 S DEA=$$GET1^DIQ(50,DGIEN,3)
 S RTN=$S((DEA>1)&(DEA<6):1,1:0)
 Q RTN
 ;
HLPTXT33 ;HELP TEXT FOR FIELD 3.3 FILE #59
 N PSOHLP
 S PSOHLP(1)="This parameter defines the number of days to pull ahead (bundle) for"
 S PSOHLP(2)="prescriptions suspended for local dispensing of controlled substances."
 S PSOHLP(3)="Enter the value in days between 0 and 15."
 D EN^DDIOL(.PSOHLP)
 Q
 ;
HLPTXT3 ;HELP TEXT FOR FIELD 3 FILE #59
 N PSOHLP
 S PSOHLP(1)="This parameter defines the number of days to pull ahead (bundle) for"
 S PSOHLP(2)="prescriptions suspended for local dispensing of non-controlled substances."
 S PSOHLP(3)="Enter the value in days between 0 and 15."
 D EN^DDIOL(.PSOHLP)
 Q
 ;
HLPTXT31 ;HELP TEXT FOR FIELD 3.1 FILE #59
 N PSOHLP
 S PSOHLP(1)="This parameter defines the number of days to pull ahead (bundle) in"
 S PSOHLP(2)="addition to the CS DAYS TO TRANSMIT parameter for controlled substance"
 S PSOHLP(3)="prescriptions suspended for CMOP mail. Enter the value in days between 0"
 S PSOHLP(4)="and 15."
 D EN^DDIOL(.PSOHLP)
 Q
 ;
HLPTXT34 ;HELP TEXT FOR FIELD 3.4 FILE #59
 N PSOHLP
 S PSOHLP(1)="This parameter defines the number of days to pull ahead (bundle) in"
 S PSOHLP(2)="addition to the NON-CS DAYS TO TRANSMIT parameter for non-controlled"
 S PSOHLP(3)="substance prescriptions suspended for CMOP mail. Enter the value in days"
 S PSOHLP(4)="between 0 and 15."
 D EN^DDIOL(.PSOHLP)
 Q
 ;
