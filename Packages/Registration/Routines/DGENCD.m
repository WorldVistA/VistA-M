DGENCD ;ALB/CJM,Zoltan,ISA/KWP,JAN,BRM,DJS - Catastrophic Disability Enter/Edit Option;May 24, 1999,Nov 14, 2001 ; 8/4/03 3:01pm
 ;;5.3;Registration;**121,122,232,237,302,387,451,894**;Aug 13,1993;Build 48
 ;
 ; DG*5.3*894 - Enhance Catastrophic Disability to use Descriptors rather than Diagnoses/Procedures/Conditions.
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
 S DIR(0)="EA",DIR("A")="Press return to continue..." D ^DIR
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
 N SUB,OK,RESPONSE,FLST,EXIT,SUBEXIT,ITEM,FILENUM,FLDNUM,REQ,VAL
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
 S FLST="DESCR" D
 . N LOOKUP
 . S ITEM="",SUB=FLST
 . F  S ITEM=$O(DGCDIS(SUB,ITEM)) Q:ITEM=""  S LOOKUP(DGCDIS(SUB,ITEM))=ITEM
 . S EXIT=0
 . S ITEM=1
 . W !
 . F  D  Q:EXIT
 . . S FILENUM=$$FILE^DGENCDU(SUB)
 . . S FLDNUM=$$FLD^DGENCDU(SUB)
 . . W !
 . . I '$$PROMPT^DGENU(FILENUM,FLDNUM,$G(DGCDIS(SUB,ITEM)),.RESPONSE,0),X="^" S RESPONSE=X
 . . I X="@",$G(DGCDIS(SUB,ITEM)) K DGCDIS(SUB,ITEM) S EXIT=0,OK=1 D QEXIT Q
 . . I RESPONSE="" N HIT S HIT=1 D  I HIT W !!,"Must enter at least one CD Descriptor or ""^"" to exit" S EXIT=0,OK=1 D QEXIT Q
 . . . N I F I=ITEM:-1:1 I $G(DGCDIS(SUB,I))'="" S HIT=0 Q
 . . I SUB="DESCR",RESPONSE'="^",RESPONSE'="",$P(^DGEN(27.17,RESPONSE,0),U,4)=5,'$D(LOOKUP(RESPONSE)) I '$$CKDOAD S RESPONSE="",EXIT=0,OK=1 D QEXIT Q
 . . I SUB="DESCR",$D(DGCDIS("DESCR")),$G(DGCDIS("DESCR",ITEM))'=RESPONSE N EXIT1,ENTRY S EXIT1=0 D  I EXIT1 Q
 . . . S ENTRY=0 F  S ENTRY=$O(DGCDIS("DESCR",ENTRY)) Q:ENTRY=""  D  Q:EXIT1
 . . . . I DGCDIS("DESCR",ENTRY)=RESPONSE D
 . . . . . W !!,"CD Descriptor previously selected, cannot select same CD Descriptor twice"
 . . . . . S RESPONSE="",EXIT=0,OK=1,EXIT1=1
 . . . I EXIT1 D QEXIT
 . . I RESPONSE="^"!(RESPONSE=""&$D(DGCDIS(SUB))) N ITEM,CNT D  D:'CNT DELETE^DGENCDA1(DFN) Q
 . . . S EXIT=1,OK=0
 . . . S (ITEM,CNT)=""
 . . . F  S ITEM=$O(DGCDIS(SUB,ITEM)) Q:ITEM=""  D
 . . . . I DGCDIS(SUB,ITEM)'=""&(DGCDIS(SUB,ITEM)'="^") S CNT=1 Q
 . . . . I DGCDIS(SUB,ITEM)="" K DGCDIS(SUB,ITEM) Q
 . . . . I DGCDIS(SUB,ITEM)="^" K DGCDIS(SUB,ITEM)
 . . I RESPONSE'="",$D(LOOKUP(RESPONSE)) S ITEM=LOOKUP(RESPONSE)
 . . E  S ITEM=$O(DGCDIS(SUB,""),-1)+1,LOOKUP(RESPONSE)=ITEM
 . . S DGCDIS(SUB,ITEM)=RESPONSE
 . . S SUBEXIT=0
 . . S ITEM=ITEM+'SUBEXIT
 I $D(DGCDIS("DESCR")) S DGCDIS("VCD")="Y",OK=1 W !!,"VETERAN IS CATASTROPHICALLY DISABLED",!
 E  I '$D(DGCDIS("DESCR")) D
 . S DGCDIS("VCD")="N",OK=1
 . N I F I="BY","DATE","DTFACIRV","FACDET","METDET","REVDTE","VETREQDT" S DGCDIS(I)=""
 . W !!,"VETERAN IS NOT CATASTROPHICALLY DISABLED",!
 Q OK
 ; 
CKDOAD()  ; Ask qualifying question if descriptor is AMPUTATION, DISARTICULATION OR DETACHMENT
 N CK
 F  D  Q:CK'=""
 . W !,"Has the Amputation, Disarticulation or Detachment occurred on more "
 . W !,"than one limb? "
 . R CK:120
 . I CK["?" W !!,"Enter 'YES' or 'NO'.",! S CK="" Q
 . S CK=$S($E(CK)="Y":1,$E(CK)="y":1,$E(CK)="N":0,$E(CK)="n":0,1:"")
 I CK=0 W !!,"The Descriptor does not meet the criteria to be added."
 Q CK
 ;
QEXIT()  ; sets an empty DGCDIS entry before exiting
 S ITEM=$O(DGCDIS(SUB,ITEM))
 I ITEM="" S ITEM=$O(DGCDIS(SUB,""),-1)+1,DGCDIS(SUB,ITEM)=""
 Q 
 ;
DBPROC()  ; replaces input transform for CD Procedure
 Q ($P(^DGEN(27.17,+Y,0),U,3)["ICPT")!($P(^DGEN(27.17,+Y,0),U,9)=$$ICDVER^DGENA5("P"))
