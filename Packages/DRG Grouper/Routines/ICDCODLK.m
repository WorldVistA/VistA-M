ICDCODLK ;KUM - LOOK UP ICD-10 PROCEDURE CODE;12/07/2011
 ;;18.0;DRG Grouper;**64**;Oct 20, 2000;Build 103
 ;
 ; ICDDATE is EFFECTIVE DATE that passed from Calling Routine
 ;
EN ; Initialize variables
 W @IOF D LOOK
 G EXIT
LOOK ; Look-up term
 W !! K X S ICDPRC="" D ASK K DIC
AGAIN ; Try again?
 W !,"Try another" S %=$S(+($$X):1,1:2)
 D YN^DICN I %=-1!(%=2) Q
 I '% W !!,"You have searched for a string in the Lexicon, do you want to" G AGAIN
 I +($$X)&(%=1) G LOOK
 I '+($$X)&(%=1) G LOOK
 I (+($$X)&(%=2))!('+($$X)&(%=1)) Q
 G LOOK Q 
ASK ; Get user input
 N DUOUT,DTOUT,DIR,DIRUT,DIROUT,ICDDATE1,ICDT1,ICDX,ICDXX,ICDPRT
 I $G(ICDXX1) S ICDPRT="Enter Operation/Procedure (ICD 10):"
 I $G(ICDDATE)="" D EFFDATE^ICDDRGM G EXIT:$D(DUOUT),EXIT:$D(DTOUT)
 I $G(ICDDATE)'="" S ICDDATE1=ICDDATE
 S ICDRES=1
 I $G(ICDPRC)="" S ICDPRC="" D GICDPRC
 I ICDPRC="" S ICDX=0
 I ICDPRC'="" S ICDX=1
 I ICDPRC'["*" G ASKCONT1
 I ICDPRC["*" S ICDPRC=$P(ICDPRC,"*",1) ; D GICDPRC
 ;S ICDPRC="",ICDX=0
 F ICDT1=1:1 Q:($L($G(ICDPRC))>=7)!(ICDPRC["^")!(ICDRES=0)  D 
 . S ICDRES=$$PCSDIG^LEX10CS(ICDPRC,ICDDATE1)
 . I ICDRES=1 D
 . . D LOAD
 . . D PRCDESCB
 . . D PRCDESC
 . . S X=$$SEL^ICDSELPS(.ICDS,5)
 . . I X'=-1 S ICDPRC=ICDPRC_$P(X,"^",1)
 . . S ICDX=1
 . . D GICDPRC
 . I ICDRES'=1 W !,ICDPRC_" IS NOT A VALID ICD PROCEDURE CODE" G EXIT
 I $G(ICDXX1),ICDPRC["^^" S ICDPRC=$E(ICDPRC,1,$L(ICDPRC)-2)
 I '$G(ICDXX1),ICDPRC["^" G EXIT
ASKCONT1 ; Tag to continue when ICDPRC doesnt have *
 I $L($G(ICDPRC))=7&(ICDPRC'["^") D
 . S ICDRES=$$PCSDIG^LEX10CS(ICDPRC,ICDDATE1)
 . I ICDRES=1 D
 . . S ICDPDESC=LEXPCDAT("PCSDESC")
 . . S ICDPSTS=LEXPCDAT("STATUS")
 . . D PRCDESCB
 . . D PRCDESC
 . . W !!,ICDPRC,?15,ICDPDESC,!  ;add printing of descript disclaimer msg
 . . I $G(ICDXX1) S ICDXX=+$$CODEN^ICDEX(ICDPRC,80.1)
 . . I '$P(ICDPSTS,"^",1) W "   **CODE INACTIVE" I $P(ICDPSTS,"^",2)'="" S Y=$P(ICDPSTS,"^",2) D DD^%DT W " AS OF   ",Y," **",!
 . I ICDRES'=1 D
 . . W !,ICDPRC_" IS NOT A VALID PROCEDURE CODE."
 I $L($G(ICDPRC))=7&(ICDPRC'["^")&(ICDRES=1)&('$P($G(ICDPSTS),"^",1)) G ASKCNT2
 I $L($G(ICDPRC))'=7,ICDPRC'="",ICDPRC'["^" S ICDRES=0 W !,ICDPRC_" IS NOT A VALID ICD PROCEDURE CODE"_$S($G(ICDXX1):". IGNORING THE PROCEDURE CODE",1:".")
 S (X,Y)=""
 I ICDPRC["^" S X="^",Y=""
 S:$G(ICDXX) (X,Y)=ICDXX
 I $G(ICDXX1) D
 . I (ICDRES'=1)!(($L($G(ICDPRC))'=7)&(ICDPRC'="")&(ICDPRC'["^")) S X=0 R ICDQWE:300 K ICDQWE Q
 . I ICDPRC'="" D
 . . W !,"OK? (Yes/No) " S %=1
 . . D YN^DICN
 . . I %'=1 S X=0
ASKCNT2 K ICDDATE1,ICDRES,ICDPDESC,ICDPSTS,LEXPCDAT,ICDPRCT,ICDPRCX,ICDLEX
 Q
INPHLP ; Look-up help
 Q:X["^^" "^^"  Q:X["^" "^"
 W !,"      Enter a ""free text"" term.  Best results occur using one to "
 W !,"      three full or partial words without a suffix"
 W:$G(X)'["??" "."
 W:$G(X)["??" " (i.e., ""DIABETES"","
 W:$G(X)["??" !,"      ""DIAB MELL"",""DIAB MELL INSUL"")"
 W !,"  or  "
 W !,"      Enter a classification code (ICD/CPT etc) to find the single "
 W !,"      term associated with the code."
 W:$G(X)["??" "  Example, a lookup of code 239.0 "
 W:$G(X)["??" !,"      returns one and only one term, that is the preferred "
 W:$G(X)["??" !,"      term for the code 239.0, ""Neoplasm of unspecified nature "
 W:$G(X)["??" !,"      of digestive system"""
 W !,"  or  "
 W !,"      Enter a classification code (ICD/CPT etc) followed by a plus"
 W !,"      sign (+) to retrieve all terms associated with the code."
 W:$G(X)["??" "  Example,"
 W:$G(X)["??" !,"      a lookup of 239.0+ returns all terms that are linked to the "
 W:$G(X)["??" !,"      code 239.0."
 Q
EXIT ; Clean up environment and quit
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,ICDLEX,ICDPRCX,ICDPRCT
 Q
X(ICDLEX) ; Evaluate X
 Q:$L($G(X)) 1  Q 0
Y(ICDLEX) ; Evaluate Y
 Q:+($G(Y))>1 1  Q 0
LOAD ; Load data
 K ICDS
 S ICDLOAD1=1
 S ICDLOADP=""
 S ICDLOAD="" F  S ICDLOAD=$O(LEXPCDAT("NEXLEV",ICDLOAD)) Q:ICDLOAD=""  D
 . I ICDLOAD'=ICDLOADP D
 . . S ICDS(ICDLOAD1,0)=ICDLOAD
 . . S ICDS(ICDLOAD1,"LEX")=LEXPCDAT("NEXLEV",ICDLOAD,"DESC")
 . . S ICDLOAD1=ICDLOAD1+1
 . . S ICDLOADP=ICDLOAD
 K ICDLOAD1,ICDLOADP,ICDLOAD
 Q
PRCDESC ; Display Descriptions of each character
 S ICDPRCT=ICDPRC,ICDPRCT1="",ICDX=0
 F ICDTEMP=1:1 Q:ICDPRCT=""  D
 . S ICDC=$E(ICDPRCT,1,1)
 . S ICDRES=$$PCSDIG^LEX10CS(ICDPRCT1,ICDDATE1)
 . I ICDRES'=1 D
 . . S ICDPRCT=""
 . I ICDRES=1 D
 . . S ICDLOAD="" F  S ICDLOAD=$O(LEXPCDAT("NEXLEV",ICDLOAD)) Q:ICDLOAD=""!(ICDLOAD=ICDC)
 . . I ICDLOAD=ICDC W ICDC_" - "_LEXPCDAT("NEXLEV",ICDLOAD,"DESC") W !
 . . S ICDPRCT=$E(ICDPRCT,2,$L(ICDPRCT))
 . . S ICDPRCT1=ICDPRCT1_ICDC
 K ICDTEMP,ICDPRCT,ICDPRCT1,ICDC,ICDLOAD
 Q
GICDPRC ; Get ICDPRC from User
 S ICDPRCX="" S ICDPRCT=""
AA ; Read character by character
 W @IOF
 I $G(ICDX)=1 D PRCDESC  W !
 W "Press '*' to display available choices for next character or '^' to exit."
 I $G(ICDPRT)="" S ICDPRT="ICD-10 Procedure code:"
 W !,ICDPRT_ICDPRC S ICDREAD="R *ICDA:300 I '$T S ICDA=13"
 X ICDREAD
 ; Show choices on "*"
 I ICDA=42 G BB
 ; Exit when Enter and is full length else ignore 
 ;I ICDA=13 G:$L(ICDPRC)>6 BB S ICDX=1 G AA
 I ICDA=13,$G(ICDXX1) S:$L(ICDPRC)'=7 ICDPRC=ICDPRC_$C(94)_$C(94) G BB
 I ICDA=13,'$G(ICDXX1) G:$L(ICDPRC)>6 BB S ICDX=1 G AA
 ; If Backspace is entered, truncate last character and display the ICDPRC
 I ICDA=127 S ICDPRC=$E(ICDPRC,1,$L(ICDPRC)-1) S ICDX=1 G AA
 ; If ^ is entered, exit
 I ICDA=94 S ICDPRC=ICDPRC_$C(ICDA) G BB
 ; check for valid characters
 I ICDA<48!((ICDA>57)&(ICDA<65))!((ICDA>90)&(ICDA<97))!(ICDA>122) G AA
 ; Any character other than Enter or Backspace
 I ICDA'=127 D
 . S ICDPRC=ICDPRC_$C(ICDA)
 . S ICDX=1 G AA
BB ;Exit
 W !
 K ICDA,ICDREAD
 Q
PRCDESCB ; Call Before PRCDESC
 W @IOF
 W "Press '*' to display available choices for next character or '^' to exit."
 W !,"ICD-10 Procedure code:"_ICDPRC
 W !
 Q
