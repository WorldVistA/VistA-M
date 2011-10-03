RAPSAPI3 ;HOIFO/SG - INPUT TEMPLATE UTILS FOR PHARM. POINTERS ; 4/13/07 10:45am
 ;;5.0;Radiology/Nuclear Medicine;**65**;Mar 16, 1998;Build 8
 ;
 ; This routine uses the following IAs:
 ; 
 ; #2056         GET1^DIQ
 ; #2052         FIELD^DID
 ; #2055         ROOT^DILFD
 ; #10007        DO^DIC1
 ; #4551         DIC^PSSDI  looks up & screens records from file #50
 ;
 Q
 ;
 ;***** RETURNS IEN OF THE DEFAULT RECORD OF THE MULTIPLE
 ;
 ; Note: This is an internal function. Do not call it from outside
 ;       of this routine.
 ;
DFLTREC() ;
 Q $S($G(RADESCR("SELCNT"))'>1:+$O(@(RADESCR("ROOT"))@(" "),-1),1:0)
 ;
 ;***** EDITS RADIOLOGY SCREENED POINTER TO THE DRUG FILE (#50)
 ;
 ; RADESCR       Flags that control execution
 ;                 "P"  Medications
 ;                 "R"  Radiopharms
 ;
 ; RAIENS        IENS of the edited record (e.g. "1,")
 ;
 ; RAFILE        Radiology file number (e.g. 71.9)
 ;
 ; RAFIELD       Field number of the pointer to the file #50 (e.g. 5)
 ;
 ; [RADATE]      Date for screening medications
 ;
 ; Return values:
 ;       ""  Field was empty and the value has not changed
 ;      "@"  Clear the field
 ;      "^"  Exit the record editing
 ;   ^Field  "^"-jump to other field (e.g. "^KIT")
 ;     `IEN  Pointer to the record of the file #50 (e.g. "`234")
 ;
RXEDIT(RADESCR,RAIENS,RAFILE,RAFIELD,RADATE) ;
 N PSSDIY,RA50IEN,RABUF,RADIC,RAENTRY,RALABEL,RAMSG,RARC,RAVACL,TMP
 ;=== Validate and parse parameters
 S RADESCR=$G(RADESCR)
 S:(RADESCR'["P")&(RADESCR'["R") RADESCR=RADESCR_"P"
 S:$G(RADATE)'>0 RADATE=""
 ;
 ;=== Get field info from the data dictionary
 D FIELD^DID(RAFILE,RAFIELD,,"LABEL;MULTIPLE-VALUED","RABUF","RAMSG")
 I $G(RABUF("MULTIPLE-VALUED"))  S TMP=$T(+0)  D  Q "^"
 . W !!,"$$RXEDIT^"_TMP_" cannot be used for multiples!"
 . W !,"Use $$RXMEDIT^"_TMP_" instead.",!
 S RALABEL=RABUF("LABEL")_": "
 K RABUF
 ;
 ;===
 F  D  Q:$D(RARC)
 . ;--- Get the current internal value of the field
 . S RA50IEN=+$$GET1^DIQ(RAFILE,RAIENS,RAFIELD,"I",,"RAMSG")
 . ;--- Get the external value of the field
 . I RA50IEN>0  D
 . . S TMP=$$EN1^RAPSAPI(RA50IEN,.01)
 . . S:TMP="" TMP=RA50IEN
 . E  S TMP=""
 . ;--- Display the prompt and get a user response
 . W !,RALABEL_$S(TMP'="":TMP_"// ",1:"")
 . R RAENTRY:DTIME  E  S RARC="^"  Q
 . ;--- Keep the current value
 . I RAENTRY=""  S RARC=$S(RA50IEN>0:"`"_RA50IEN,1:"")  Q
 . ;--- Exit or "^"-jump
 . I RAENTRY?1"^".E  S RARC=RAENTRY  Q
 . ;--- @ entered
 . I RAENTRY="@"  S:$$DELCONF^RAPSAPI2(+RAIENS,RA50IEN) RARC="@"  Q
 . ;--- ? or ?? entered
 . D:RAENTRY?1"?".1"?" HELP^RAPSAPI2(RAENTRY,RAFILE,RAFIELD)
 . ;--- Something else entered
 . S RADIC="^PSDRUG(",RADIC(0)="EQMZ",RADIC("A")=RALABEL
 . D SETVACL^RAPSAPI2(RADESCR)
 . D DIC^PSSDI(50,"RA",.RADIC,RAENTRY,,RADATE,,.RAVACL)
 . S:Y>0 RARC="`"_(+Y)
 ;
 ;===
 Q RARC
 ;
 ;***** EDITS .01 POINTER (MULTIPLE) TO THE DRUG FILE (#50)
 ;
 ; .RADESCR(     Flags that control execution
 ;                 "P"  Medications
 ;                 "R"  Radiopharms
 ;
 ;               When this function finishes editing the multiple,
 ;               this parameter is KILL'ed automatically.
 ;
 ;               Subscripts of this parameter store the state between
 ;               calls. Do not access them outside of this function!
 ;               The only exception is the RADESCR("RESULT") that
 ;               stores the latest value returned by the function.
 ;
 ;   "EDITONLY") The function is in "edit-only" mode of the .01 field 
 ;               of the multiple.
 ;
 ;   "FLDNAME")  Name of the .01 field of the multiple
 ;   "MLTNAME")  Name of the multiple
 ;   "RESULT")   The latest result returned by this function
 ;   "ROOT")     Closed root of the multiple's sub-file
 ;   "SCRDATE")  Date for screening meds (value of the RADATE param.)
 ;
 ;   "SELCNT")   Number of times the function was called in selection 
 ;               mode ($G("EDITONLY")=0) without resetting the state. 
 ;
 ;   "SUBFILE")  Number of the multiple's sub-file
 ;
 ; RAIENS        IENS of a multiple/subfile (e.g. ",1,") or IENS
 ;               of a record of the multiple (e.g. "2,3,"). In the
 ;               latter case, the function switches to "edit-only"
 ;               mode.
 ;
 ; [RAFILE]      Radiology file number (e.g. 70.2)
 ;
 ; [RAMULT]      Field number of the multiple (e.g. 100)
 ;
 ; [RADATE]      Date for screening medications
 ;
 ; Return values:
 ;       ""  Exit the multiple
 ;      "@"  Delete the value of the .01 field
 ;      "^"  Exit the record editing
 ;   ^Field  "^"-jump to other field (e.g. "^KIT")
 ;     `IEN  Pointer to the record of the file #50 or IEN of
 ;           an existing record of the multiple (e.g. "`234")
 ;
RXMEDIT(RADESCR,RAIENS,RAFILE,RAMULT,RADATE) ;
 N RASUBIEN      ; IEN of the record of the multiple
 ;
 N PSSDIY,RA50IEN,RADEFDIS,RADEFVAL,RADIC,RADUP,RAENTRY,RAMIEN,RAMSG,RARC,RAVACL,RAXNODE,TMP
 ;=== Validate and parse parameters
 S RADESCR=$G(RADESCR)
 S:(RADESCR'["P")&(RADESCR'["R") RADESCR=RADESCR_"P"
 S RASUBIEN=+$P(RAIENS,","),$P(RAIENS,",")=""
 ;
 ;=== Get file/field info from the data dictionary
 I '$G(RADESCR("SELCNT"))  D  I $D(RARC)  K RADESCR  Q RARC
 . N RABUF,SUBFILE
 . S TMP="LABEL;MULTIPLE-VALUED;SPECIFIER"
 . D FIELD^DID(RAFILE,RAMULT,,TMP,"RABUF","RAMSG")
 . ;---
 . I '$G(RABUF("MULTIPLE-VALUED"))  S TMP=$T(+0)  D  S RARC="^"  Q
 . . W !!,"$$RXMEDIT^"_TMP_" cannot be used for single-value fields!"
 . . W !,"Use $$RXEDIT^"_TMP_" instead.",!
 . ;---
 . S RADESCR("MLTNAME")=RABUF("LABEL")
 . S (RADESCR("SUBFILE"),SUBFILE)=+RABUF("SPECIFIER")
 . S RADESCR("FLDNAME")=$$GET1^DID(SUBFILE,.01,,"LABEL",,"RAMSG")
 . S RADESCR("ROOT")=$$ROOT^DILFD(SUBFILE,RAIENS,1)
 . S RADESCR("SCRDATE")=$S($G(RADATE)>0:+RADATE,1:"")
 ;
 ;=== Determine the execution mode
 I RASUBIEN'>0  D  K RADESCR("EDITONLY")
 . S RADESCR("SELCNT")=$G(RADESCR("SELCNT"))+1
 . S RASUBIEN=$$DFLTREC()
 E  S RADESCR("EDITONLY")=1
 ;
 ;===
 F  D  Q:$D(RARC)
 . ;--- Get the current internal value of the .01 field
 . I RASUBIEN>0  D
 . . S TMP=RASUBIEN_RAIENS
 . . S RA50IEN=+$$GET1^DIQ(RADESCR("SUBFILE"),TMP,.01,"I",,"RAMSG")
 . E  S RA50IEN=0
 . ;--- Get the external value of the .01 field
 . I RA50IEN>0  D
 . . S RADEFVAL=$$EN1^RAPSAPI(RA50IEN,.01)
 . . S:RADEFVAL="" RADEFVAL=RA50IEN
 . E  S RADEFVAL=""
 . S RADEFDIS=": "_$S(RADEFVAL'="":RADEFVAL_"// ",1:"")
 . ;--- Display the prompt and get a user response
 . W !  W:'$G(RADESCR("EDITONLY")) "Select "
 . W RADESCR("FLDNAME")_RADEFDIS
 . R RAENTRY:DTIME  E  S RARC="^"  Q
 . ;--- Keep the current value or exit if there is no current record
 . I RAENTRY=""  D   Q
 . . I RASUBIEN'>0  S RARC=""  Q
 . . ;--- If selecting a record, return IEN in the multiple
 . . I '$G(RADESCR("EDITONLY"))  S RARC="`"_RASUBIEN  Q
 . . ;--- If just editing the .01 field, return IEN in the DRUG file
 . . S RARC=$S(RA50IEN>0:"`"_RA50IEN,1:"")
 . ;--- Exit or "^"-jump
 . I RAENTRY?1"^".E  S RARC=RAENTRY  Q
 . ;--- @ entered
 . I RAENTRY="@"  D:$$DELCONF^RAPSAPI2(RASUBIEN,RA50IEN)  Q
 . . ;--- Let the FileMan delete the value of the .01 field
 . . I $G(RADESCR("EDITONLY"))  S RARC="@"  Q
 . . ;--- Delete the record at "Select ..." prompt
 . . D DELETE^RAPSAPI2(RADESCR("SUBFILE"),RASUBIEN_RAIENS)
 . . S RASUBIEN=$$DFLTREC()
 . ;--- Record IEN entered
 . I RAENTRY?1"`"1.N  S:$$IEN^RAPSAPI2(.RAENTRY) RARC=RAENTRY  Q
 . ;--- Add duplicate entry (value in double quotes)
 . I RAENTRY?1""""1.E1""""  D  S RADUP=1
 . . S RAENTRY=$E(RAENTRY,2,$L(RAENTRY)-1)  ; Remove quotes
 . E  S RADUP=0
 . ;--- ? or ?? entered
 . I RAENTRY?1"?".1"?"  D  S RADUP=0
 . . I $G(RADESCR("EDITONLY"))  D  Q
 . . . D HELP^RAPSAPI2(RAENTRY,RADESCR("SUBFILE"),.01)
 . . D HELP^RAPSAPI2(RAENTRY,RAFILE,RAMULT,RAIENS)
 . ;--- Everything else
 . S RADIC="^PSDRUG(",RADIC(0)="EQMZ"
 . S RADIC("A")=RADESCR("FLDNAME")_": "
 . D SETVACL^RAPSAPI2(RADESCR)
 . D DIC^PSSDI(50,"RA",.RADIC,RAENTRY,,RADESCR("SCRDATE"),,.RAVACL)
 . Q:Y'>0
 . ;--- If just editing the .01 field, return IEN in the DRUG file
 . I $G(RADESCR("EDITONLY"))  S RARC="`"_(+Y)  Q
 . ;--- Try to find the drug in the multiple.
 . ;--- If not found or duplication is forced, add the drug.
 . S RAXNODE=$NA(@(RADESCR("ROOT"))@("B",+Y))
 . S RAMIEN=+$O(@RAXNODE@(0))
 . I (RAMIEN'>0)!RADUP  S RARC="""`"_(+Y)_""""  Q
 . ;--- Otherwise, select a record from the multiple.
 . I $O(@RAXNODE@(RAMIEN))>0  D  Q:RAMIEN'>0
 . . S RAMIEN=$$MULTSEL^RAPSAPI2(RAXNODE,RADESCR("MLTNAME"),$P(Y,U,2))
 . S RARC="`"_RAMIEN
 ;
 ;=== Cleanup
 S RADESCR("RESULT")=RARC
 D:'$G(RADESCR("EDITONLY"))
 . K:(RARC="^")!((RARC="")&(RA50IEN'>0)) RADESCR
 Q RARC
