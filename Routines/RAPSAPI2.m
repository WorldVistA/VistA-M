RAPSAPI2 ;HOIFO/SG - INPUT TEMPLATE UTILS FOR PHARM. POINTERS ; 4/6/07 3:43pm
 ;;5.0;Radiology/Nuclear Medicine;**65**;Mar 16, 1998;Build 8
 ;
 ;Supported IA #2053 reference to FILE^DIE
 ;Supported IA #2052 reference to FIELD^DID and GET1^DID
 ;Supported IA #2055 reference to ROOT^DILFD and OREF^DILFD
 ;Supported IA #10007 reference to DO^DIC1
 ;Supported IA #4551 reference to DIC^PSSDI
 ;Supported IA #10029 reference to ^DIWW
 ;
 Q
 ;
 ;***** DISPLAYS RECORD DELETE PROMPT AND GETS USER RESPONSE
 ;
 ; RAIEN         IEN of the record of the multiple
 ;
 ; IEN50         Internal value of the .01 field
 ;
 ; Return values:
 ;        0  Keep the record or there is nothing to delete
 ;        1  Delete the record
 ;
 ; Note: This is an internal function. Do not call it from outside
 ;       of the RAPSAPI3 routine.
 ;
DELCONF(RAIEN,IEN50) ;
 I (RAIEN'>0)!(IEN50'>0)  W "??"  Q 0
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,TMP,X,Y
 S DIR(0)="YAO"
 S DIR("A")="   SURE YOU WANT TO DELETE",TMP=$G(RADESCR("FLDNAME"))
 S DIR("A")=DIR("A")_$S(TMP'="":" THE ENTIRE "_TMP,1:"")_"? "
 D ^DIR
 W:Y'=1 "  <NOTHING DELETED>"
 Q (Y=1)
 ;
 ;***** DELETES A (SUB)FILE RECORD
 ;
 ; FILE          File/subfile number
 ; IENS          IENS of the record
 ;
DELETE(FILE,IENS) ;
 N RAFDA,RAMSG
 S RAFDA(FILE,IENS,.01)="@"
 D FILE^DIE(,"RAFDA","RAMSG")
 Q
 ;
 ;***** DISPLAYS HELP (? and ??)
 ;
 ; VAL           User input ("?" or "??")
 ;
 ; FILE          File number
 ;
 ; FIELD         Field number
 ;
 ; [IENS]        IENS of the multiple defined by the FIELD parameter
 ;               (1st comma piece should be empty). Specify this
 ;               parameter if help information for a "Select..."
 ;               prompt is needed.
 ;
HELP(VAL,FILE,FIELD,IENS) ;
 Q:'($G(VAL)?1"?".1"?")
 N LM,RABUF,RAMSG,TMP
 S TMP="LABEL;MULTIPLE-VALUED;SPECIFIER"
 D FIELD^DID(FILE,FIELD,,TMP,"RABUF","RAMSG")
 Q:$G(RABUF("LABEL"))=""
 ;---
 I $G(RABUF("MULTIPLE-VALUED"))  D  S LM=9
 . S FILE=+$G(RABUF("SPECIFIER")),FIELD=.01
 . S TMP=$$ROOT^DILFD(FILE,$G(IENS),1)
 . D:TMP'="" HLPMULT(VAL,TMP,RABUF("LABEL"))
 E  S LM=5
 ;---
 I VAL="?"  D
 . D HLPROMPT(LM,FILE,FIELD)
 E  D HLPDESCR(9,FILE,FIELD)
 ;---
 W !
 Q
 ;
 ;***** DISPLAYS FIELD DESCRIPTION
 ;
 ; LM            Left margin for the output
 ;
 ; FILE          File number
 ;
 ; FIELD         Field number
 ;
HLPDESCR(LM,FILE,FIELD) ;
 N I,RAHLP,RAMSG
 S I=$$GET1^DID(FILE,FIELD,,"DESCRIPTION","RAHLP","RAMSG")
 D:$D(RAHLP)>1 HLPWR(LM,.RAHLP)
 Q
 ;
 ;***** DISPLAYS CONTENT OF THE MULTIPLE AND RELATED PROMPTS
 ;
 ; VAL           User input ("?" or "??")
 ;
 ; LM            Left margin for the output
 ;
 ; RAROOT        Closed root of the multiple's sub-file
 ;
 ; MLTNAME       Name of the multiple
 ;
HLPMULT(VAL,RAROOT,MLTNAME) ;
 N DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DO,DUOUT,RA50IEN,RAI,RARC,RAY,TMP,X,Y
 S RARC=0
 I $O(@RAROOT@(0))>0  D  Q:RARC
 . ;--- Get confirmation if the multiple contains more than 10 records
 . S DIC=$$OREF^DILF(RAROOT),DIC(0)=""
 . D DO^DIC1
 . I VAL'="??",$P(DO,U,4)>10  D  I 'Y  S RARC=1  Q
 . . K DIR  S DIR(0)="YAO"
 . . S DIR("A")="Do you want the entire "_$P(DO,U,4)_"-Entry "_MLTNAME_" List? "
 . . D ^DIR
 . ;--- Write related prompts
 . S RAY=$Y-1
 . W !?4,$S(VAL="?":"Answer with "_MLTNAME,1:"")
 . W !?3,"Choose from:"
 . ;--- Write content of the multiple
 . S RAI=0
 . F  S RAI=$O(@RAROOT@(RAI))  Q:RAI'>0  D  Q:'RAI
 . . S RA50IEN=+$P($G(@RAROOT@(RAI,0)),U)
 . . I ($Y-RAY)'<IOSL  D  S RAY=$Y-1  I 'Y  S RAI=0  Q
 . . . K DIR  S DIR(0)="EOA"
 . . . S DIR("A")="   '^' TO STOP: "
 . . . D ^DIR
 . . S TMP=$$EN1^RAPSAPI(RA50IEN,.01)
 . . W !?3,$S(TMP'="":TMP,1:RA50IEN)
 . W !
 ;===
 W !?8,"You may enter a new "_MLTNAME_", if you wish"
 Q
 ;
 ;***** DISPLAYS HELP PROMPT AND SCREEN DESCRIPTION
 ;
 ; LM            Left margin for the output
 ;
 ; FILE          File number
 ;
 ; FIELD         Field number
 ;
HLPROMPT(LM,FILE,FIELD) ;
 ;;70.15^.01^Only pharmaceuticals that are active on this exam date are allowed.
 ;;70.21^.01^Enter only active radiopharmaceuticals with an appropriate drug classification.
 ;;71.055^.01^Only active non-radiopharmaceuticals may be selected.
 ;;71.08^.01^Only active radiopharmaceuticals are valid.
 ;;71.9^5^Only active radiopharmaceuticals are valid.
 ;
 N RAI,RAMSG,TMP
 ;--- Help prompt
 S TMP=$$GET1^DID(FILE,FIELD,,"HELP-PROMPT",,"RAMSG")
 D:TMP'="" HLPWR(LM,TMP)
 ;--- Optional screen description
 F RAI=1:1  S TMP=$P($T(HLPROMPT+RAI),";;",2)  Q:TMP=""  D  Q:TMP=""
 . I +TMP=FILE,$P(TMP,U,2)=FIELD  D HLPWR(LM,$P(TMP,U,3))  S TMP=""
 Q
 ;
 ;***** FORMATS THE TEXT AND WRITES IT TO THE CURRRENT DEVICE
 ;
 ; DIWL          Left margin for the text
 ;
 ; [.]TEXT       Either a string or a reference to a local array
 ;               that contains the text
 ;
 ; Note: This function uses the ^UTILITY($J,"W") global node.
 ;
HLPWR(DIWL,TEXT) ;
 N DIWF,DIWR,RAI,X
 K ^UTILITY($J,"W")
 S DIWF="W",DIWR=IOM-3
 I $D(TEXT)>1  S RAI=""  D
 . F  S RAI=$O(TEXT(RAI))  Q:RAI=""  S X=TEXT(RAI)  D ^DIWP
 E  S X=$G(TEXT)  D ^DIWP
 D ^DIWW
 K ^UTILITY($J,"W")
 Q
 ;
 ;***** VALIDATES DIRECT IEN INPUT (i.e. `IEN)
 ;
 ; .VAL          User input (`IEN)
 ;
 ; Return values:
 ;        0  Ignore the input
 ;        1  Process the input
 ;
 ; Note: This is an internal function. Do not call it from outside
 ;       of the RAPSAPI3 routine.
 ;
IEN(VAL) ;
 N IEN,RADIC,PSSDIY
 S IEN=+$P(VAL,"`",2,$L(VAL))
 I IEN'>0  W "??"  Q 0
 S VAL="`"_IEN
 ;--- Check the multiple
 Q:$D(@(RADESCR("ROOT"))@(IEN)) 1
 ;--- Check the DRUG file (#50)
 S RADIC="^PSDRUG(",RADIC(0)=""
 D SETVACL(RADESCR)
 D DIC^PSSDI(50,"RA",.RADIC,VAL,,RADESCR("SCRDATE"),,.RAVACL)
 W:Y'>0 "??"
 Q (Y>0)
 ;
 ;***** SELECTS A RECORD FROM THE MULTIPLE
 ;
 ; NODE          Node of the cross-reference
 ; MLTNAME       Name of the multiple
 ; DRUGNAME      Drug name
 ;
 ; Return values:
 ;        0  No selection
 ;       >0  IEN of a multiple's record
 ;
MULTSEL(NODE,MLTNAME,DRUGNAME) ;
 N CNT,DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,RAI,RATMP,RC,TMP,X,Y
 S RATMP=$NA(^TMP($J,$T(+0)_"-MULTSEL"))  K @RATMP
 ;===
 S (CNT,IEN,RC)=0
 F  D  Q:RC!(IEN'>0)
 . ;--- Display the next portion of records
 . F RAI=1:1:5  S IEN=$O(@NODE@(IEN))  Q:IEN'>0  D
 . . S CNT=CNT+1,@RATMP@(CNT)=IEN
 . . W !?5,CNT,?9,DRUGNAME
 . Q:CNT'>0
 . ;--- Ask the user
 . K DIR  S DIR(0)="NAO^1:"_CNT_":0"
 . S DIR("A")="CHOOSE 1-"_CNT_": "
 . I IEN>0  D:$O(@NODE@(IEN))>0
 . . S DIR("A",1)="Press <RETURN> to see more, '^' to exit this list, OR"
 . S DIR("?")="Select a record of the "_MLTNAME_" multivalued field."
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT)  S RC=-1  Q
 . S:X'="" IEN=+@RATMP@(+Y),RC=1
 ;=== Cleanup
 K @RATMP
 Q $S(RC>0:IEN,1:0)
 ;
 ;***** INITIALIZES THE RAVACL ARRAY FOR SCREENING MEDS
 ;
 ; FLAGS         Mode flags
 ;
SETVACL(FLAGS) ;
 N I
 F I="DX200","DX201","DX202"  S RAVACL(I)=""
 S:FLAGS["P" RAVACL("P")=""
 S:FLAGS["R" RAVACL("R")=""
 Q
