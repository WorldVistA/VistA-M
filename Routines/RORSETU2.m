RORSETU2 ;HCIOFO/SG - SETUP UTILITIES (REGISTRY) ; 1/23/06 10:35am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** DRAWS THE BOUNDARY BETWEEN HISTORICAL AND REGULAR EXTRACTIONS
 ;
 ; REGIEN        Registry IEN
 ; .BNDRYDT      Date that represents a boundary between historical
 ;               data extraction and regular data extracts is returned
 ;               via this parameter.
 ;
 ; Return Values:
 ;       <0  Error code
 ;      >=0  Statistics
 ;             ^1: Total number of processed records
 ;             ^2: Number of records processed with errors
 ;
 ; The function calculates a date that will be a boundary between
 ; historical data extraction and regular data extractions. This date
 ; is stored to all records of the registry. Moreover, the date is
 ; returned as a value of the second parameter.
 ;
BNDRYDT(REGIEN,BNDRYDT) ;
 N CNT,DATE,ECNT,IEN,IENS,LD1,PATIEN,RC,ROOT,RORFDA,RORMSG,TMP
 S ROOT=$$ROOT^DILFD(798,,1)
 ;--- Get the lag period
 S LD1=$$GET1^DIQ(798.1,REGIEN_",",15.1,,,"RORMSG")
 S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0 RC
 ;--- Calculate the date
 S BNDRYDT=$$FMADD^XLFDT($$DT^XLFDT,-$S(LD1>0:LD1,1:1)-1)
 ;--- Store the date into the records of the registry
 S IEN="",(CNT,ECNT)=0
 F  S IEN=$O(@ROOT@("AC",REGIEN,IEN))  Q:IEN=""  D
 . S CNT=CNT+1,IENS=IEN_",",DATE=BNDRYDT
 . ;--- Update the record
 . S RORFDA(798,IENS,9.1)=DATE
 . S RORFDA(798,IENS,9.2)=DATE
 . D FILE^DIE(,"RORFDA","RORMSG")
 . I $G(DIERR)  D  S ECNT=ECNT+1  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9)
 Q $S(RC<0:RC,1:CNT_U_ECNT)
 ;
 ;***** CHECKS THE LAB SEARCH CRITERION
 ;
 ; LSNAME        Name of the Lab search criterion
 ;
 ; This function uses the ^TMP("DILIST",$J) global node.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LABSRCH(LSNAME) ;
 N IEN,IENS,IR,LSICNT,RC,RORMSG,TMP
 ;--- Find the definition
 S IENS=$$FIND1^DIC(798.9,,"X",LSNAME,"B",,"RORMSG")_","
 S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0 RC
 Q:IENS'>0 $$ERROR^RORERR(-54,,,,LSNAME)
 ;--- Load the search indicators
 D LIST^DIC(798.92,","_IENS,"@;1I",,,,,"B",,,,"RORMSG")
 S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0 RC
 ;--- Check the search indicators
 S IR="",LSICNT=0
 F  S IR=$O(^TMP("DILIST",$J,"ID",IR))  Q:IR=""  D
 . S:$G(^TMP("DILIST",$J,"ID",IR,1))>0 LSICNT=LSICNT+1
 ;--- Process the errors (if any)
 Q:LSICNT'>0 $$ERROR^RORERR(-55,,,,LSNAME)
 Q 0
 ;
 ;***** PREPARES REGISTRY RECORDS
 ;
 ; RORREG        Registry IEN and registry name separated by the '^'
 ;               (RegistryIEN^RegistryName).
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PREPARE(RORREG) ;
 ;;Data extraction boundary (historical/regular) has been established.
 ;;Parameters of the historical data extraction have been updated.
 ;
 N DATE,RC,TMP
 ;--- Modify records of the registry
 S RC=$$BNDRYDT(+RORREG,.DATE)  Q:RC<0 RC
 S TMP="Processed records: "_+RC_", Errors: "_+$P(RC,U,2)
 D LOG^RORLOG(2,$P($T(PREPARE+1),";;",2),,TMP)
 ;--- Update the registry parameters of historical data extraction
 S RC=$$UPDHDTRP(+RORREG,DATE)  Q:RC<0 RC
 D LOG^RORLOG(2,$P($T(PREPARE+2),";;",2))
 Q 0
 ;
 ;***** UPDATES REGISTRY PARAMETERS OF THE HISTORICAL DATA EXTRACTION
 ;
 ; REGIEN        Registry IEN
 ; HDTEDT        Date that represents a boundary between historical
 ;               data extraction and regular data extracts
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
UPDHDTRP(REGIEN,HDTEDT) ;
 N IENS,RC,RORFDA,RORMSG
 S IENS=REGIEN_","
 ;--- Prepare the data
 S RORFDA(798.1,IENS,21.05)=$$NOW^XLFDT      ; Timestamp
 ;--- Update historical data extraction parameters
 D FILE^DIE(,"RORFDA","RORMSG")
 S RC=$$DBS^RORERR("RORMSG",-9)
 Q $S(RC<0:RC,1:0)
