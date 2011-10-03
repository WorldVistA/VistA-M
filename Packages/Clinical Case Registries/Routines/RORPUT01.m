RORPUT01 ;HCIOFO/SG - EDIT LOINC AND DRUG CODE MULTIPLES ; 5/19/06 11:48am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 Q
 ;
 ;***** ADDS THE RECORDS TO THE MULTIPLE
 ;
 ; REGIEN        Registry IEN
 ; SUBFILE       Subfile number
 ; LSTREF        Reference to a list or the list itself (see the
 ;               $$COMPNEXT^RORPUT01 function for more details).
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
ADD(REGIEN,SUBFILE,LSTREF) ;
 N BUF,IENS,ITEM,LI,NEXT,RC,RORFDA,RORMSG,TLI
 S NEXT=$$COMPNEXT(LSTREF)  Q:NEXT<0 NEXT
 S IENS="?+1,"_(+REGIEN)_",",RC=0
 F TLI=1:1  X NEXT  Q:$G(BUF)'[";;"  D  Q:RC<0
 . S BUF=$P(BUF,";;",2)
 . D MES^RORKIDS(BUF)
 . S BUF=$TR(BUF," ")
 . F LI=1:1  S ITEM=$P(BUF,",",LI)  Q:ITEM=""  D  Q:RC<0
 . . S RORFDA(SUBFILE,IENS,.01)=ITEM
 . . D UPDATE^DIE(,"RORFDA",,"RORMSG")
 . . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,SUBFILE,IENS)
 Q RC
 ;
 ;***** RESTORES THE CDC DEFINITION
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
CDCDEF() ;
 N RC,RESULTS,RORBUF
 D BMES^RORKIDS("Restoring the CDC definition...")
 ;--- Restore the definition from the transport global
 M RORBUF=@XPDGREF@("RORCDCDEF")
 S RORBUF="HIV CDC Form Template"
 D SETPARM^RORRP038(.RESULTS,"ICRCDCDEF","PKG",.RORBUF)
 Q:$G(RESULTS(0))<0 +RESULTS(0)
 ;--- Success
 D MES^RORKIDS("The definition has been restored successfully.")
 Q 0
 ;
 ;***** COMPILES THE 'NEXT' LOGIC
 ;
 ; PARAM         Parameter defining the list of codes. It should be
 ;               either a list of codes separated by commas or a full
 ;               reference (TAG^ROUTINE) to a routine label after
 ;               which the list is located. In the latter case, the
 ;               list itself should look like this:
 ;
 ;                         ;
 ;                         ;***** SHORT DESCRIPTION OF THE LIST
 ;                 LABEL   ;
 ;                         ;;  Code1, Code2, ...
 ;                         ;;  CodeN, ...
 ;                         ;
 ;
 ;               There should be at least one line that does not
 ;               contain ";;" after the list (or no lines at all).
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  The list is empty
 ;     '=""  A string that should be XECUTE'd to get the next
 ;           buffer with the list data
 ;
COMPNEXT(PARAM) ;
 N I,N,NEXT,RC  Q:PARAM?." " ""
 ;--- Reference to a routine label
 I PARAM?1.8UN1"^"1.8UN  D  Q NEXT
 . S NEXT="S BUF=$T("_$P(PARAM,U)_"+TLI"_U_$P(PARAM,U,2)_")"
 ;--- List of codes separated by commas
 S N=$L(PARAM,","),RC=0
 F I=1:1:N  I '($P(PARAM,",",I)?." "1.N." ")  S RC=-88  Q
 I RC<0,I=N  S:$P(PARAM,",",N)?." " RC=0,N=N-1
 I N>0,RC'<0  D  Q NEXT
 . S NEXT="S BUF=$P("""_";;"_$P(PARAM,",",1,N)_""",U,TLI)"
 ;--- Invalid parameter
 Q $$ERROR^RORERR(-88,,,,"List of Codes",PARAM)
 ;
 ;***** ADDS ITEMS TO 'EXTRACTED RESULT' MULTIPLE OF FILE #798.1
 ;
 ; [RORREG]      Registry IEN and registry name separated by the '^'
 ;               (RegistryIEN^RegistryName).
 ;
 ; [RORLNCAD]    Either a list of LOINC codes (without check digits)
 ;               separated by commas or a full reference (TAG^ROUTINE)
 ;               to a routine label after which the list is located.
 ;
 ;               All spaces are removed from the lines of the list.
 ;               See the $$COMPNEXT^RORPUT01 function for more
 ;               details.
 ;
 ; If some of these parameters are omitted or equal to an empty
 ; strings, their values must be defined as the RORPARM("KIDS")
 ; sub-nodes of the same name.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOINCADD(RORREG,RORLNCAD) ;
 N RC
 D BMES^RORKIDS("Adding new LOINC codes to the EXTRACTED RESULT multiple...")
 ;--- Get the parameters
 S:'$G(RORREG) RORREG=$$PARAM^RORKIDS("RORREG")
 S:$G(RORLNCAD)="" RORLNCAD=$$PARAM^RORKIDS("RORLNCAD")
 ;--- Add new LOINC codes
 S RC=$$ADD(+RORREG,798.112,RORLNCAD)  Q:RC<0 RC
 ;--- Success
 D MES^RORKIDS("The LOINC list has been updated successfully.")
 Q 0
 ;
 ;***** REMOVES ITEMS FROM 'EXTRACTED RESULT' MULTIPLE OF FILE #798.1
 ;
 ; [RORREG]      Registry IEN and registry name separated by the '^'
 ;               (RegistryIEN^RegistryName).
 ;
 ; [RORLNCRM]    Either a list of LOINC codes (without check digits)
 ;               separated by commas or a full reference (TAG^ROUTINE)
 ;               to a routine label after which the list is located.
 ;
 ;               All spaces are removed from the lines of the list.
 ;               See the $$COMPNEXT^RORPUT01 function for more
 ;               details.
 ;
 ; If some of these parameters are omitted or equal to an empty
 ; strings, their values must be defined as the RORPARM("KIDS")
 ; sub-nodes of the same name.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOINCREM(RORREG,RORLNCRM) ;
 N BUF,DA,DIK,IENS,IR,LCI,LOINC,NEXT,RC,RORBUF,RORMSG,TLI
 D BMES^RORKIDS("Removing obsolete codes from the EXTRACTED RESULT multiple...")
 ;--- Get the parameters
 S:'$G(RORREG) RORREG=$$PARAM^RORKIDS("RORREG")
 S:$G(RORLNCRM)="" RORLNCRM=$$PARAM^RORKIDS("RORLNCRM")
 ;--- Delete unnecessary LOINC codes
 S RC=$$REMOVE(+RORREG,798.112,RORLNCRM)  Q:RC<0 RC
 ;--- Success
 D MES^RORKIDS("The LOINC list has been updated successfully.")
 Q 0
 ;
 ;***** REMOVES THE RECORDS FROM THE MULTIPLE
 ;
 ; REGIEN        Registry IEN
 ; SUBFILE       Subfile number
 ; LSTREF        Reference to a list or the list itself (see the
 ;               $$COMPNEXT^RORPUT01 function for more details).
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
REMOVE(REGIEN,SUBFILE,LSTREF) ;
 N BUF,DA,DIK,IENS,IR,ITEM,LI,NEXT,RC,RORBUF,RORMSG,TLI
 S NEXT=$$COMPNEXT(LSTREF)  Q:NEXT<0 NEXT
 S IENS=","_(+REGIEN)_",",RC=0
 F TLI=1:1  X NEXT  Q:$G(BUF)'[";;"  D  Q:RC<0
 . S BUF=$P(BUF,";;",2)
 . D MES^RORKIDS(BUF)
 . S BUF=$TR(BUF," ")
 . F LI=1:1  S ITEM=$P(BUF,",",LI)  Q:ITEM=""  D  Q:RC<0
 . . K RORBUF
 . . D FIND^DIC(SUBFILE,IENS,"@","QX",ITEM,,"B",,,"RORBUF","RORMSG")
 . . I $G(DIERR)  S RC=$$DBS^RORERR("RORMSG",-9,,,SUBFILE,IENS)  Q
 . . S IR="",DIK=$$ROOT^DILFD(SUBFILE,IENS),DA(1)=+REGIEN
 . . F  S IR=$O(RORBUF("DILIST",2,IR))  Q:IR=""  D
 . . . S DA=RORBUF("DILIST",2,IR)  D ^DIK
 Q RC
 ;
 ;***** UPDATES (POPULATES) THE LOCAL REGISTRY
 ;
 ; [RORREG]      Registry IEN and registry name separated by the '^'
 ;               (RegistryIEN^RegistryName).
 ; [MAXNTSK]     Maximum number of registry update subtasks
 ; [SUSPEND]     Suspend update (sub)tasks during the peak hours
 ;               (StartTime^EndTime)
 ;
 ; If some of these parameters are omitted or equal to an empty
 ; strings, their values must be defined as the RORPARM("KIDS")
 ; sub-nodes of the same name.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
UPDATE(RORREG,MAXNTSK,SUSPEND) ;
 N EC,REGLST
 D BMES^RORKIDS("Updating the local registry...")
 ;--- Get the parameters
 S:'$G(RORREG) RORREG=$$PARAM^RORKIDS("RORREG")
 S:RORREG REGLST($P(RORREG,U,2))=+RORREG
 S:$G(MAXNTSK)="" MAXNTSK=$$PARAM^RORKIDS("MAXNTSK")
 S:$G(SUSPEND)="" SUSPEND=$$PARAM^RORKIDS("SUSPEND")
 ;--- Update the registry
 S RC=$$UPDATE^RORUPD(.REGLST,,MAXNTSK,SUSPEND)  Q:RC<0 RC
 ;--- Success
 D MES^RORKIDS("Registry update completed.")
 Q 0
