DGICP ;AL/AAS/PLT KUM,WIOFO/PMK - LOOK UP ICD-10 PROCEDURE CODE ;04/15/2015 1:17 PM
 ;;5.3;Registration;**850,884**;Aug 13, 1993;Build 31
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;This routine does not conform to Standard & Conventions routine naming
 ;conventions since package routine names of DG_I* (with the exceptions
 ;of Kernel, VA FileMan, and routines created to support the INIT 
 ;process) should not be used.  The SACC has granted an exemption for
 ;this routine.
 ;
 ;copied from ICDCODLK 
 ;
 ; ICDDATE is EFFDATE variable that is passed in from Calling Routine
 ;
EN ; Initialize variables
 W ! ;@IOF
 D LOOK
 G EXIT
LOOK ; Look-up term
 N X
 W !! S X="" D ASK K DIC
AGAIN ; Try again?
 Q
 ;
ASK ; Get user input
 N DIR,DIRUT,DIROUT,ICDDATE,ICDDATE1,ICDT1,ICDX,DGXX
 Q:X="?BAD"!(X["^")
 I X["?" D  K X,Y Q  ; - added here for calls that bypass ^DGICDGT
 . N TAG,FORMAT
 . S TAG=$S(X["???":"P3^DGICDGT",X["??":"P2^DGICDGT",X["?":"P1^DGICDGT",1:"P1^DGICDGT")
 . D @TAG
 . Q
 S ICDDATE=$G(EFFDATE)
 I $G(ICDDATE)'="" S ICDDATE1=ICDDATE
 S ICDPRC=$G(X),ICDX=0
 S ICDPRC=$$TR(X)
 S ICDRES=1
 F ICDT1=1:1 Q:($L($G(ICDPRC))>6)!(ICDPRC["^")!(ICDRES=0)  D
 . S ICDRES=$$PCSDIG^LEX10CS(ICDPRC,$G(ICDDATE1))
 . I ICDRES=1 D
 . . D LOAD
 . . D PRCDESCB
 . . D PRCDESC
 . . S X=$$SEL^DGICPL(.ICDS,5)
 . . I X'=-1 S ICDPRC=ICDPRC_$P(X,"^",1)
 . . S ICDX=1
 . . D GICDPRC
 . I ICDRES'=1 W !,ICDPRC_" IS NOT A VALID ICD PROCEDURE CODE" G EXIT
 I ICDPRC["^" G EXIT
 I $L($G(ICDPRC))=7 D
 . S ICDRES=$$PCSDIG^LEX10CS(ICDPRC,$G(ICDDATE1))
 . I ICDRES=1 D
 . . S ICDPDESC=LEXPCDAT("PCSDESC")
 . . S ICDPSTS=LEXPCDAT("STATUS")
 . . D PRCDESCB
 . . D PRCDESC
 . . W !,"   ",ICDPDESC
 . . S DGXX=+$$CODEN^ICDEX(ICDPRC,80.1)
 . . I '$P(ICDPSTS,"^",1) W "   **CODE INACTIVE" I $P(ICDPSTS,"^",2)'="" S Y=$P(ICDPSTS,"^",2) D DD^%DT W " AS OF   ",Y," **",!
 . I ICDRES'=1 D
 . . W !,ICDPRC_" IS NOT VALID"
 I $L($G(ICDPRC))>7 W !,ICDPRC_" IS NOT A VALID ICD PROCEDURE CODE"
 K X,Y
 S:$G(DGXX) (X,Y)=DGXX
 K ICDDATE1,ICDPRC,ICDRES,ICDPDESC,ICDPSTS,LEXPCDAT
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
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEX,X,Y,ICDLEX
 Q
X(ICDLEX) ; Evaluate X
 Q:$L($G(X)) 1  Q 0
Y(ICDLEX) ; Evaluate Y
 Q:+($G(Y))>1 1  Q 0
LOAD ; Load dummy data
 K ICDS
 S ICDLOAD1=1
 S PICDLOAD=""
 S ICDLOAD="" F  S ICDLOAD=$O(LEXPCDAT("NEXLEV",ICDLOAD)) Q:ICDLOAD=""  D
 . I ICDLOAD'=PICDLOAD D
 . . S ICDS(ICDLOAD1,0)=ICDLOAD
 . . S ICDS(ICDLOAD1,"LEX")=LEXPCDAT("NEXLEV",ICDLOAD,"DESC")
 . . S ICDLOAD1=ICDLOAD1+1
 . . S PICDLOAD=ICDLOAD
 K ICDLOAD1,PICDLOAD,ICDLOAD
 Q
PRCDESC ; Display Descriptions of each character
 S ICDPRCT=ICDPRC,ICDPRCT1="",ICDX=0
 F ICDTEMP=1:1 Q:ICDPRCT=""  D
 . S ICDC=$E(ICDPRCT,1,1)
 . S ICDRES=$$PCSDIG^LEX10CS(ICDPRCT1,$G(ICDDATE1))
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
AA ; Read character by character
 W !
 I $G(ICDX)=1 D PRCDESC  W !
 W "Press '*' to display available choices for next character or '^' to exit."
 W !,"ICD-10 Procedure code:"_ICDPRC
 I $L(ICDPRC)>6 G BB
 S ICDA=$$READ^XGF(1,300) S ICDA=$S($G(DTOUT):13,1:$A(ICDA))
 ; show choices on "*"
 I ICDA=42 G BB
 ; Exit when Enter and is full length else ignore
 I ICDA=13 G:$L(ICDPRC)>6 BB G AA
 ; If Backspace is entered, truncate last character and display the ICDPRC 
 I ICDA=127 S ICDPRC=$E(ICDPRC,1,$L(ICDPRC)-1) S ICDX=1 G AA
 ; If ^ is entered, exit
 I ICDA=94 S ICDPRC=ICDPRC_$C(ICDA) G BB
 ;
 ; check for valid characters
 I ICDA<48!((ICDA>57)&(ICDA<65))!((ICDA>90)&(ICDA<97))!(ICDA>122) G AA
 ;
 ; Any character other than Enter or Backspace
 I ICDA'=127 D  G:$L(ICDPRC)>6 BB G AA
 . S ICDPRC=ICDPRC_$$TR($C(ICDA))
 . S ICDX=1
BB ;Exit
 W !
 K ICDA
 Q
PRCDESCB ; Call Before PRCDESC
 W !,"ICD-10 Procedure code:"_ICDPRC
 W !
 Q
 ;
TR(X) ;
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q X
