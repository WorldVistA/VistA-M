DGENCD ;ALB/CJM,Zoltan,ISA/KWP,JAN,BRM - Catastrophic Disability Enter/Edit Option;May 24, 1999,Nov 14, 2001 ; 8/4/03 3:01pm
 ;;5.3;Registration;**121,122,232,237,302,387,451**;Aug 13,1993
 ;
EN ;
 ;Description: Entry point used for enter/edit catastrophic disability
 ;  information.
 ;
 N DFN,QUIT,ERROR
 S QUIT=0
 S DFN=$$PATIENT
 D:DFN EN^DGENLCD(DFN)
 Q
 ;
EDITCD(DFN) ;
 ;Description: For a given patient, used for enter/edit catastrophic 
 ; disability information.
 ;
 Q:'$G(DFN)
 N QUIT,ERROR
 S QUIT=0
 I $$GET^DGENCDA(DFN,.DGCDIS) D  ; If GET CD succeeds ...
 . ; Set up default values.
 . S DGCDIS("FACDET")=$$INST^DGENU()
 . I 'DGCDIS("DATE") S DGCDIS("DATE")=$G(DT)
 . I 'DGCDIS("REVDTE") S DGCDIS("REVDTE")=DGCDIS("DATE")
 . I DGCDIS("METDET")="" S DGCDIS("METDET")=""
 . ; Keep editing until storage succeeds or user gives up ...
 . F  D  Q:QUIT
 . . ; Quit if the editing process isn't completed.
 . . I '$$EDIT(.DGCDIS) S QUIT=1 Q
 . . ; Quit if storage is successful.
 . . I $$STORE^DGENCDA2(DFN,.DGCDIS,.ERROR) S QUIT=1 Q
 . . ; Quit if the user elects not to try again.
 . . I '$$AGAIN(.ERROR) S QUIT=1
 Q
 ;
AGAIN(ERROR) ;
 ;Description: Asks user whether to try again.
 ;
 N DIR,Y
 W !!,$S(('$L($G(ERROR))):">>> Catastrophic disability information not valid.<<< ",1:">>> "_ERROR_" <<<")
 S DIR(0)="Y",DIR("A")="Try again",DIR("B")="YES"
 D ^DIR
 Q $S(Y=1:1,1:0)
 ;
PATIENT() ;
 ;Description: Asks user to select a patient.
 ;
 N DFN,QUIT
 S (DFN,QUIT)=""
 F  D  Q:(QUIT!DFN)
 . D GETPAT^DGRPTU(,,.DFN)
 . I '(DFN>0) S DFN="",QUIT=1 Q
 . I DFN,'$$VET^DGENPTA(DFN) D
 . . W !!,"Catastrophic disability can only be entered for eligible veterans!"
 . . S DFN=""
 Q DFN
 ;
EDIT(DGCDIS) ;
 ;Description: Allows user to enter values in DGCDIS array
 ; which is passed by reference.
 N SUB,OK,RESPONSE,FLST,EXIT,SUBEXIT,ITEM,FILENUM,FLDNUM,GETOUT,REQ,VAL
 S OK=1
 F VAL="BY^1","DATE^1","REVDTE^1","METDET^1" D  Q:'OK
 . S SUB=$P(VAL,"^",1)
 . S REQ=$P(VAL,"^",2)
 . S FILENUM=$$FILE^DGENCDU(SUB)
 . S FLDNUM=$$FLD^DGENCDU(SUB)
 . I '$$PROMPT^DGENU(FILENUM,FLDNUM,DGCDIS(SUB),.RESPONSE,REQ) S OK=0
 . E  D
 . . I $P(VAL,"^",1)="BY" S RESPONSE=$$UPPER^DGUTL(RESPONSE)
 . . S DGCDIS(SUB)=RESPONSE
 I 'OK Q OK
 S GETOUT=0
 F FLST="DIAG","PROC;EXT","COND;SCORE;PERM" D  Q:'OK!GETOUT
 . N LOOKUP
 . S ITEM="",SUB=$P(FLST,";")
 . F  S ITEM=$O(DGCDIS(SUB,ITEM)) Q:ITEM=""  S LOOKUP(DGCDIS(SUB,ITEM))=ITEM
 . S EXIT=0
 . S ITEM=1
 . W !
 . F  D  Q:EXIT
 . . N PC
 . . S SUB=$P(FLST,";")
 . . S FILENUM=$$FILE^DGENCDU(SUB)
 . . S FLDNUM=$$FLD^DGENCDU(SUB)
 . . W !
 . . I '$$PROMPT^DGENU(FILENUM,FLDNUM,$G(DGCDIS(SUB,ITEM)),.RESPONSE,0) S (EXIT,GETOUT)=1 Q
 . . I RESPONSE="" D  Q
 . . . F PC=1:1:$L(FLST,";") K DGCDIS($P(FLST,";",PC),ITEM)
 . . . S ITEM=$O(DGCDIS(SUB,ITEM))
 . . . I ITEM="" S EXIT=1
 . . I $G(LOOKUP(RESPONSE)) S ITEM=LOOKUP(RESPONSE)
 . . E  S ITEM=$O(DGCDIS(SUB,""),-1)+1,LOOKUP(RESPONSE)=ITEM
 . . S DGCDIS(SUB,ITEM)=RESPONSE
 . . S SUBEXIT=0
 . . F PC=2:1:$L(FLST,";") D  Q:SUBEXIT
 . . . S SUB=$P(FLST,";",PC)
 . . . S FLDNUM=$$FLD^DGENCDU(SUB)
 . . . I '$$PROMPT^DGENU(FILENUM,FLDNUM,$G(DGCDIS(SUB,ITEM)),.RESPONSE,1) S SUBEXIT=1 Q
 . . . I RESPONSE="" S (EXIT,SUBEXIT)=1 Q
 . . . I SUB="EXT" D  Q
 . . . . I '$D(DGCDIS(SUB,ITEM,1)) S DGCDIS(SUB,ITEM,1)=RESPONSE
 . . . . E  S:DGCDIS(SUB,ITEM,1)'=RESPONSE DGCDIS(SUB,ITEM,2)=RESPONSE
 . . . I SUB="SCORE",'$$VALID^DGENA5(DGCDIS("COND",ITEM),RESPONSE) D  Q
 . . . . W !,"ERROR: This is not a valid test score.",!
 . . . . Q:$G(DGCDIS("SCORE",ITEM))
 . . . . K LOOKUP(DGCDIS("COND",ITEM))
 . . . . F PC=1:1:$L(FLST,";") K DGCDIS($P(FLST,";",PC),ITEM)
 . . . . S PC=$L(FLST,";")
 . . . I SUB="SCORE",'$$RANGEMET^DGENA5(DGCDIS("COND",ITEM),RESPONSE,1) D  Q
 . . . . S PC=$L(FLST,";")
 . . . . S DGCDIS("SCORE",ITEM)=RESPONSE
 . . . . S DGCDIS("PERM",ITEM)=""
 . . . S DGCDIS(SUB,ITEM)=RESPONSE
 . . S ITEM=ITEM+'SUBEXIT
 S DGCDIS("VCD")="Y"
 S DGCDIS("VCD")=$S($$ISCD^DGENCDA1(.DGCDIS):"Y",1:"N")
 S OK=$$PROMPT^DGENU(2,.39,DGCDIS("VCD"),.RESPONSE,0) ; Is Veteran CD?
 I OK S DGCDIS("VCD")=RESPONSE
 Q OK
