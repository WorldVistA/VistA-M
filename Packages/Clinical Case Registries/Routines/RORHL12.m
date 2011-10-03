RORHL12 ;HOIFO/BH,SG - HL7 MICROBIOLOGY DATA: OBR ;3/13/06 9:24am
 ;;1.5;CLINICAL CASE REGISTRIES;**1,10**;Feb 17, 2006;Build 32
 ;
 ; This routine uses the following IAs:
 ;
 ; #4335         $$GETDATA^LA7UTL1A (controlled)
 ; #10000        C^%DTC (supported)
 ; #10103        FMTHL7^XLFDT (supported)
 ; #2056         GET1^DIQ (supported)
 ;
 Q
 ;
 ;***** SEARCH FOR MICROBIOLOGY DATA
 ;
 ; RORDFN        IEN of the patient in the PATIENT file (#2)
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; RORMODE       The type of extract to be performed:
 ;                 0  Nightly extract
 ;                 1  Historical extract
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;       
 ;-----------------------------------------------------------------------------
 ; NIGHTLY EXTRACT FOR A PATIENT THAT HAS NOT BEEN INCLUDED IN A PREVIOUS
 ; EXTRACT:
 ; This will consist of 1 call to the Lab API to retrieve all micro data
 ; collected during the extraction date range.
 ; 
 ;     st                                      end
 ;     |----------------------------------------| 
 ;     <========================================> collection date
 ;
 ;-----------------------------------------------------------------------------
 ; NIGHTLY EXTRACT FOR A PATIENT THAT HAS BEEN INCLUDED IN A PREVIOUS EXTRACT:
 ; This will consist of 3 calls to the Lab API.   It will pull micro data with
 ; a completion date in the date range, and it also pulls micro data that was 
 ; collected exactly 60 days before the start date but has no completion date.
 ; 
 ; 1. Call using a COMPLETION date in the original date range, but only
 ; include records in the extract from this call that have a collection date
 ; on or after the start date minus 60 days.
 ; 
 ;       st-60 days             st   end
 ;          |--------------------|----| 
 ;          <=========================> collection date
 ;                               <====> completion date
 ; 
 ; 2. Call using a COMPLETION date range of 60 days prior to the extraction
 ; start date through the original end date.  Records returned from this call
 ; are completed, and will be compared to the records returned in the next call.
 ; 
 ; 3. Call again to get all records COLLECTED exactly 60 days from the 
 ; extraction date range.  Only send the records from call #3 that were NOT
 ; returned from call #2.  This sends all records that were collected at
 ; exactly 60 days before the extraction date range, but have not yet been
 ; completed.
 ; 
 ;       st-60      end-60      st   end
 ;          |-----------|--------|----| 
 ;          ==============              collection date 60 days prior to date range
 ;                                      no completion date
 ; 
 ;-----------------------------------------------------------------------------
 ; HISTORICAL EXTRACT:
 ; This will consist of 1 call to the Lab API to retrieve all micro data
 ; collected during the extraction date range.
 ; 
 ;     st                                      end
 ;     |----------------------------------------| 
 ;     <========================================> collection date
 ;
 ;-----------------------------------------------------------------------------
EN1(RORDFN,DXDTS,RORMODE) ;
 N ERRCNT,IDX,LRDFN,RC,RCL,RORENDT,RORMIIEN,RORREF,RORSTDT,RORTMP,TMP
 S (ERRCNT,RC)=0
 ;--- Which is being requested - historical or nightly extract?
 S RORMODE=$S($G(RORMODE):"HIST",1:"NIGHT")
 ;
 S LRDFN=+$$LABREF^RORUTL18(RORDFN)  Q:LRDFN'>0 0
 S RORTMP=$$ALLOC^RORTMP()
 ;
 S IDX=0
 F  S IDX=$O(DXDTS(11,IDX))  Q:IDX'>0  D  Q:RC<0
 . S RORSTDT=$P(DXDTS(11,IDX),U),RORENDT=$P(DXDTS(11,IDX),U,2)
 . K @RORTMP
 . ;---NIGHTLY EXTRACTION---
 . I RORMODE="NIGHT" D
 .. ;get 798 IEN (ROR REGISTRY RECORD)
 .. N ROR798 S ROR798=$O(^RORDATA(798,"B",RORDFN,0))
 .. Q:'$G(ROR798)
 .. ;get DATA ACKNOWLEDGED UNTIL field (#9.1) in 798
 .. N RORACK K RORMSG S RORACK=$$GET1^DIQ(798,ROR798_",",9.1,,,"RORMSG")
 .. Q:$D(RORMSG("DIERR"))
 .. ;--------------------------------------------------------------------------
 .. I $G(RORACK)="" D  Q  ;patient has not been included in a previous extract
 ... ;call lab api using 'collection date' mode
 ... S RCL=$$GETDATA^LA7UTL1A(LRDFN,RORSTDT,RORENDT,"CD",RORTMP)
 ... I RCL<0  D  Q
 .... S TMP="$$GETDATA^LA7UTL1A"
 .... S RC=$$ERROR^RORERR(-56,,$P(RCL,U,2),RORDFN,+RCL,TMP)
 ... ;--- Process the returned data and build the message segments
 ... S RORMIIEN=""  F  S RORMIIEN=$O(@RORTMP@(LRDFN,RORMIIEN))  Q:RORMIIEN=""  D
 .... S RORREF=$NA(@RORTMP@(LRDFN,RORMIIEN))
 .... S TMP=$$OBR(RORREF)
 .... I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 .... S TMP=$$OBX^RORHL121(RORREF)
 .... I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 .... Q
 ... Q
 .. ;--------------------------------------------------------------------------
 .. I $L(RORACK)>0 D  Q  ;patient has been included in a previous extract
 ... N X,X1,X2,RORST60
 ... ;subtract 60 from start date
 ... S X1=RORSTDT,X2=-60 D C^%DTC S RORST60=X K X,X1,X2
 ... ;subtract 60 from end date
 ... N X,X1,X2,ROREND60
 ... S X1=RORENDT,X2=-60 D C^%DTC S ROREND60=X K X,X1,X2
 ... K @RORTMP
 ... ;CALL #1 using 'completion date' mode
 ... S RCL=$$GETDATA^LA7UTL1A(LRDFN,RORSTDT,RORENDT,"RAD",RORTMP)
 ... I RCL<0  D  Q
 .... S TMP="$$GETDATA^LA7UTL1A"
 .... S RC=$$ERROR^RORERR(-56,,$P(RCL,U,2),RORDFN,+RCL,TMP)
 ... ;--- Process the returned data and get the collection date
 ... S RORMIIEN=""
 ... F  S RORMIIEN=$O(@RORTMP@(LRDFN,RORMIIEN))  Q:RORMIIEN=""  D
 .... S RORREF=$NA(@RORTMP@(LRDFN,RORMIIEN))
 .... N RORCOLLDT S RORCOLLDT=$G(@RORREF@(0,.01,"I")) ;collection date
 .... Q:$G(RORCOLLDT)'>0  ;quit if collection date is null
 .... ;If the collection date was in the 60 days prior to the extraction start
 .... ;date, build the segments.
 .... I RORCOLLDT'<RORST60 D  Q
 ..... S TMP=$$OBR(RORREF)
 ..... I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ..... S TMP=$$OBX^RORHL121(RORREF)
 ..... I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ..... Q
 .... Q
 ... N RORTMP2,RCL2
 ... S RORTMP2=$$ALLOC^RORTMP() K @RORTMP2
 ... ;CALL #2 using 'completion date' mode.  Will be used further down.
 ... S RCL2=$$GETDATA^LA7UTL1A(LRDFN,RORST60,RORENDT,"RAD",RORTMP2)
 ... I RCL2<0  D  Q
 .... S TMP="$$GETDATA^LA7UTL1A"
 .... S RC=$$ERROR^RORERR(-56,,$P(RCL2,U,2),RORDFN,+RCL2,TMP)
 ... N RORTMP3,RCL3
 ... S RORTMP3=$$ALLOC^RORTMP() K @RORTMP3
 ... ;CALL #3 using 'collection date' mode - 60 days prior to range
 ... S RCL3=$$GETDATA^LA7UTL1A(LRDFN,RORST60,ROREND60,"CD",RORTMP3)
 ... I RCL3<0  D  Q
 .... S TMP="$$GETDATA^LA7UTL1A"
 .... S RC=$$ERROR^RORERR(-56,,$P(RCL2,U,2),RORDFN,+RCL2,TMP)
 ... ;--- Process the returned records from call #3 and compare them
 ... ;to the records returned from call #2
 ... S RORMIIEN=""
 ... F  S RORMIIEN=$O(@RORTMP3@(LRDFN,RORMIIEN))  Q:RORMIIEN=""  D
 .... S RORREF=$NA(@RORTMP3@(LRDFN,RORMIIEN))
 .... N RORCOLLDT
 .... S RORCOLLDT=$G(@RORREF@(0,.01,"I")) ;collection date
 .... ;quit if the record is on the "completed" output from call #2
 .... Q:$D(@RORTMP2@(LRDFN,RORMIIEN))
 .... ;otherwise, build message segments
 .... S TMP=$$OBR(RORREF)
 .... I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 .... S TMP=$$OBX^RORHL121(RORREF)
 .... I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 .... D FREE^RORTMP(RORTMP2)
 .... D FREE^RORTMP(RORTMP3)
 ... Q
 . ;--------------------------------------------------------------------------
 . I RORMODE="HIST" D  ;historical extract
 .. ;call lab api using 'collection date' mode
 .. S RCL=$$GETDATA^LA7UTL1A(LRDFN,RORSTDT,RORENDT,"CD",RORTMP)
 .. ;--- Process the returned data and build the message segments
 .. S RORMIIEN=""
 .. F  S RORMIIEN=$O(@RORTMP@(LRDFN,RORMIIEN))  Q:RORMIIEN=""  D
 ... S RORREF=$NA(@RORTMP@(LRDFN,RORMIIEN))
 ... S TMP=$$OBR(RORREF) ;build OBR segment
 ... I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ... S TMP=$$OBX^RORHL121(RORREF) ;build OBX segment
 ... I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 .. Q
 . Q
 ;
 D FREE^RORTMP(RORTMP)
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** MICROBIOLOGY OBR SEGMENT BUILDER
 ;
 ; RORREF        Global reference for MI entry
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBR(RORREF) ;
 N CS,ERRCNT,RC,RORSEG
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - Accession Number
 S TMP=$G(@RORREF@(0,.06,"I"))
 I TMP=""  D  Q RC
 . S RC=$$ERROR^RORERR(-100,,,,"No accession #","$$GETDATA^LA7UTL1A")
 S RORSEG(3)=TMP
 ;
 ;--- OBR-4 - Universal Service ID
 S RORSEG(4)="87999"_CS_"MICROBIOLOGY"_CS_"C4"
 ;
 ;--- OBR-7 - Accession Date
 S TMP=$$FMTHL7^XLFDT($G(@RORREF@(0,.01,"I")))
 I TMP'>0  D  Q RC
 . S RC=$$ERROR^RORERR(-100,,,,"No accession date","$$GETDATA^LA7UTL1A")
 S RORSEG(7)=TMP
 ;
 ;--- OBR-11 - Urine Screen
 S RORSEG(11)=$G(@RORREF@(0,11.57,"I"))
 ;
 ;--- OBR-13 - Site/Specimen
 S RORSEG(13)=$$ESCAPE^RORHL7($G(@RORREF@(0,.05,"E")))
 ;
 ;--- OBR-20 - Collection Sample
 S RORSEG(20)=$$ESCAPE^RORHL7($G(@RORREF@(0,.055,"E")))
 ;
 ;--- OBR-21 - Sputum Screen
 S RORSEG(21)=$$ESCAPE^RORHL7($G(@RORREF@(0,11.58,"E")))
 ;
 ;--- OBR-24 - Diagnostic Service ID
 S RORSEG(24)="MB"
 ;
 ;--- OBR-25 - Sterility Control
 S TMP=$G(@RORREF@(0,11.51,"I"))
 S RORSEG(25)=$S(TMP="P":"F",TMP="N":"R",1:"")
 ;
 ;--- OBR-44 - Division
 S RORSEG(44)=$$SITE^RORUTL03(CS)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
