ROREXT02 ;HCIOFO/SG - DEFAULT MESSAGE BUILDER ;12/7/05 10:44am
 ;;1.5;CLINICAL CASE REGISTRIES;**10,13,14**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #2056    $$GET1^DIQ (supported)
 Q
 ;
 ;***** CHECKS IF DEMOGRAPHIC DATA HAS BEEN UPDATED
 ;
 ; .RGIENLST     Reference to a local array containing registry
 ;               IENs as subscripts and IENs of the corresponding
 ;               patient's registry records as values.
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Demographic data is unchanged
 ;       >0  Demographic data has been updated
 ;
DEMCHK(RGIENLST) ;
 N DEM,IENS,RC,REGIEN,RORMSG
 S (DEM,RC,REGIEN)=0
 F  S REGIEN=$O(RGIENLST(REGIEN))  Q:REGIEN'>0  D  Q:DEM!(RC<0)
 . S IENS=+RGIENLST(REGIEN)_","  Q:IENS'>0
 . S DEM=+$$GET1^DIQ(798,IENS,4,"I",,"RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798,IENS)
 Q $S(RC<0:RC,1:DEM)
 ;
 ;***** EXTRACTS AND PREPARES LABORATORY DATA
 ;
 ; PTIEN         Patient IEN
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; [HDTMODE]     If this parameter is defined and non-zero, start and
 ;               end dates are specimen collection dates (historical
 ;               extraction). Otherwise, they are dates of the results
 ;               (nightly extraction).
 ;
 ; The function uses node ^TMP("RORTMP",$J) as a temporary storage.
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
LABDATA(PTIEN,DXDTS,HDTMODE) ;
 N ENDT,IDX,RC,RORTMP,STDT,TMP
 S RORTMP=$$ALLOC^RORTMP()
 S (IDX,RC)=0
 F  S IDX=$O(DXDTS(1,IDX))  Q:IDX'>0  D  Q:RC<0
 . S STDT=$P(DXDTS(1,IDX),U),ENDT=$P(DXDTS(1,IDX),U,2)
 . ;--- Get the Lab results
 . K @RORTMP  S TMP=$S($G(HDTMODE):"^CD",1:"^RAD")
 . S RC=$$LABRSLTS^RORUTL02(PTIEN,STDT_TMP,ENDT_TMP,RORTMP)
 . Q:RC<0
 . ;--- Call the Lab data post-processor
 . S RC=$$LABPROC(RORTMP,PTIEN)
 . ;---
 D FREE^RORTMP(RORTMP)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** LABORATORY DATA POST-PROCESSOR
 ;
 ; ROR8TMP       Closed root of the array (local or global), which
 ;               contains the data loaded by the $$GCPR^LA7QRY
 ;
 ; PTIEN         Patient IEN
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
LABPROC(ROR8TMP,PTIEN) ;
 N BUF,CS,DFLTSITE,FS,I,J,LABC,SEG,TMP
 ;--- Extract separators from the MSH segment
 S BUF=$G(@ROR8TMP@(1))
 S:$E(BUF,1,3)="MSH" CS=$E(BUF,5)
 S:$G(CS)="" CS="^"
 ;--- Initialize constants and variables
 S LABC="LABC"_CS_"Lab Comment"_CS_"VA080"
 ;--- Get the default station number and name
 S DFLTSITE=$$SITE^RORUTL03(CS)
 ;
 ;--- Add the results to the message
 S I=0
 F  S I=$O(@ROR8TMP@(I))  Q:I=""  D
 . ;--- Load the full segment
 . D LOADSEG^RORHL7A(.SEG,$NA(@ROR8TMP@(I)))  Q:$G(SEG(0))=""
 . D
 . . ;--- Use the default station if the local one is missing
 . . I SEG(0)="OBX"  D  Q
 . . . S:$P($G(SEG(15)),CS)="" SEG(15)=DFLTSITE
 . . ;--- Leave only the code of the Provider
 . . I SEG(0)="OBR"  D  Q
 . . . S SEG(16)=+$G(SEG(16)),SEG(24)="LAB"
 . . ;--- Replace NTE's with OBX's
 . . I SEG(0)="NTE"  D  Q
 . . . K TMP  M TMP=SEG(3)  K SEG
 . . . S SEG(0)="OBX"
 . . . S SEG(2)="ST",SEG(3)=LABC,SEG(4)="LCOMM"
 . . . M SEG(5)=TMP
 . . . S SEG(11)="F"
 . . ;--- Skip all other segments
 . . K SEG
 . ;--- Store the segment
 . D:$D(SEG)>1 ADDSEG^RORHL7(.SEG)
 . ;check for Lab HCV LOINC during nightly extract
 . I $G(SEG(0))="OBX",'$G(HDTMODE) D HCV(.SEG,$G(PTIEN),$G(CS))
 Q 0
 ;
 ;***** EXTRACTS PATIENT'S DATA AND CREATES THE MESSAGE BODY
 ;
 ; PTIEN         Patient IEN
 ;
 ; .RGIENLST     Reference to a local array containing registry
 ;               IENs as subscripts and IENs of the corresponding
 ;               patient's registry records as values.
 ;
 ; .DXDTS        Either a single time frame in StartDate^EndDate
 ;               format or a reference to a local variable containing
 ;               the list of data extraction time frames. The main
 ;               time frame should be stored in the root node:
 ;
 ;  DXDTS(         MainStartDate^MainEndDate  (FileMan)
 ;    DataArea,
 ;      i)         StartDate^EndDate          (FileMan)
 ;
 ;               See the $$DXPERIOD^ROREXTUT function for details.
 ;
 ; [HDTMODE]     This parameter is defined and non-zero during the
 ;               historical data extraction.
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Nothing to send
 ;
MESSAGE(PTIEN,RGIENLST,DXDTS,HDTMODE) ;
 N RORDEM        ; Update demographics
 ;
 N CLINPTR,CSRPTR,DEMPTR,PV1PTR,RC,REGIEN,RORMSG,RORPTR,TMP
 S HDTMODE=+$G(HDTMODE)
 ;--- If only the main time frame is provided then
 ;--- generate the data-specific ones automatically
 I $D(DXDTS)<10  D  D DXMERGE^ROREXTUT(.DXDTS)
 . D DXADD^ROREXTUT(.DXDTS,$P(DXDTS,U),$P(DXDTS,U,2),0,1)
 ;--- Initialize variables
 S RC=$$INIT^RORHL7()  Q:RC<0 RC
 S RORDEM=$$DEMCHK(.RGIENLST)
 ;
 ;=== Demographic data segments
 S DEMPTR=$$PTR^RORHL7
 S RC=$$PID^RORHL01(PTIEN)  Q:RC<0 RC
 ;--- Period of Service
 S RC=$$ZSP^RORHL01(PTIEN)  Q:RC<0 RC
 ;--- Rated Disabilities
 S RC=$$ZRD^RORHL01(PTIEN)  Q:RC<0 RC
 ;
 ;=== Inpatient and Outpatient Encounter Data
 S PV1PTR=$$PTR^RORHL7
 ;--- Inpatient
 S RC=$$EN1^RORHL08(PTIEN,.DXDTS,"PV1")  Q:RC<0 RC
 ;--- Outpatient
 S RC=$$EN1^RORHL09(PTIEN,.DXDTS,"PV1")  Q:RC<0 RC
 ;
 ;=== Required CSR segment (dummy)
 S CSRPTR=$$PTR^RORHL7
 S RC=$$CSR^RORHL02(,PTIEN)  Q:RC<0 RC
 ;
 ;=== Add other encounter data segments
 S CLINPTR=$$PTR^RORHL7
 ;---Inpatient
 S RC=$$EN1^RORHL08(PTIEN,.DXDTS,"OBR")    Q:RC<0 RC
 ;--- Outpatient
 S RC=$$EN1^RORHL09(PTIEN,.DXDTS,"OBR")    Q:RC<0 RC
 ;--- Radiology
 S RC=$$EN1^RORHL04(PTIEN,.DXDTS)          Q:RC<0 RC
 ;--- Autopsy
 S RC=$$EN1^RORHL05(PTIEN,.DXDTS)          Q:RC<0 RC
 ;--- Surgical Pathology
 S RC=$$EN1^RORHL10(PTIEN,.DXDTS,HDTMODE)  Q:RC<0 RC
 ;--- Cytopathology
 S RC=$$EN1^RORHL11(PTIEN,.DXDTS,HDTMODE)  Q:RC<0 RC
 ;--- Microbiology
 S RC=$$EN1^RORHL12(PTIEN,.DXDTS,HDTMODE)  Q:RC<0 RC
 ;--- EKG (Medical Procedures)
 S RC=$$EN1^RORHL13(PTIEN,.DXDTS)          Q:RC<0 RC
 ;--- Allergy
 S RC=$$EN1^RORHL14(PTIEN,.DXDTS)          Q:RC<0 RC
 ;--- IV
 S RC=$$EN1^RORHL15(PTIEN,.DXDTS)          Q:RC<0 RC
 ;--- Vitals
 S RC=$$EN1^RORHL16(PTIEN,.DXDTS)          Q:RC<0 RC
 ;--- Problem List
 S RC=$$EN1^RORHL17(PTIEN,.DXDTS)          Q:RC<0 RC
 ;--- Lab data
 S RC=$$LABDATA(PTIEN,.DXDTS,HDTMODE)      Q:RC<0 RC
 ;--- Pharmacy
 S RC=$$EN1^RORHL03(PTIEN,.DXDTS)          Q:RC<0 RC
 ;--- Immunization
 S RC=$$EN1^RORHL18(PTIEN,.DXDTS)          Q:RC<0 RC
 ;--- Skin Test Results
 S RC=$$EN1^RORHL19(PTIEN,.DXDTS)          Q:RC<0 RC
 ;--- Non-VA Meds
 S RC=$$EN1^RORHL20(PTIEN,.DXDTS)          Q:RC<0 RC
 ;--- Purchased Care
 S RC=$$EN1^RORHL21(PTIEN,.DXDTS)          Q:RC<0 RC
 ;
 ;=== Analyze the structure of the message
 S RORPTR=$$PTR^RORHL7
 ;--- If the demographic data has not changed since the previous
 ;    data extraction and no clinical data has been added to the
 ;--- message, then remove the demographic section completely.
 I 'RORDEM,RORPTR'>CLINPTR,CSRPTR'>PV1PTR  D
 . D ROLLBACK^RORHL7(DEMPTR,1)  S CLINPTR=0
 ;
 ;=== Registry Data
 N IEN
 S REGIEN=0
 F  S REGIEN=$O(RGIENLST(REGIEN)),RC=0  Q:REGIEN'>0  D  Q:RC<0
 . S IEN=+RGIENLST(REGIEN)  Q:IEN'>0
 . ;--- If no clinical or demographics data is sent and the local
 . ;    registry data has not been modified since the last data
 . ;--- extraction, then do not include the registry data section.
 . I 'CLINPTR  D  Q:RC
 . . S RC='$$GET1^DIQ(798,IEN_",",5,"I",,"RORMSG")
 . . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,PTIEN,798,IEN_",")
 . ;---
 . I $G(ROREXT("MSGBLD",REGIEN))'=""  D
 . . X "S RC="_ROREXT("MSGBLD",REGIEN)_"(IEN,PTIEN,.DXDTS)"
 . E  S RC=$$REGDATA(IEN,PTIEN,.DXDTS)
 ;
 ;=== Analyze the structure of the message
 S RORPTR=$$PTR^RORHL7
 Q (RORPTR'>DEMPTR)
 ;
 ;***** EXTRACTS REGISTRY-SPECIFIC DATA
 ;
 ; RORIEN        IEN of the patient record in the registry
 ;
 ; PTIEN         Patient IEN
 ;
 ; .DXDTS        Data extraction time frames
 ;
 ; [HDTMODE]     This parameter is defined and non-zero during the
 ;               historical data extraction.
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Nothing to send
 ;
REGDATA(RORIEN,PTIEN,DXDTS,HDTMODE) ;
 N IENS,RC
 S IENS=RORIEN_","
 S RC=$$PID^RORHL01(PTIEN)       Q:RC<0 RC
 S RC=$$CSR^RORHL02(IENS,PTIEN)  Q:RC<0 RC
 S RC=$$CSP^RORHL02(IENS,DXDTS)  Q:RC<0 RC
 Q 0
 ;
 ;***** CHANGE STATUS FROM PENDING TO CONFIRMED IF POSITIVE LAB HCV TEST RESULT
 ;Pending patients in the HEPC registry will be confirmed during the nightly
 ;extract job if they have a positive HCV test result during the extract date range
 ;
 ;Input
 ;  SEG      Array with Lab HL7 segment "OBX"
 ;  DFN      Patient DFN
 ;  CS       HL7 Component separator
 ;
HCV(SEG,DFN,CS) ;
 Q:'DFN
 I $G(CS)="" S CS="^"
 N SEG3 S SEG3=$P($G(SEG(3)),CS,1) I $G(SEG3)="" Q  ;Lab LOINC
 N SEG5 S SEG5=$G(SEG(5)) I $G(SEG5)="" Q  ;test result value
 S SEG5=$TR($G(SEG(5)),"""","") ;get rid of any double quotes around test result
 I $E($G(SEG5),1,1)=">" D  ;if positive test result
 . N HEPCIEN S HEPCIEN=$O(^ROR(798.1,"B","VA HEPC",0)) Q:'HEPCIEN  ;HEPC registry IEN
 . N IEN S IEN=$O(^RORDATA(798,"KEY",DFN,HEPCIEN,0)) Q:(IEN'>0)  ;patient IEN in HEPC registry
 . D HCVLOAD^RORUPD01 ;load temp ROR HCV LIST array with HVC LOINCs
 . I $D(^TMP("ROR HCV LIST",$J,SEG3))>0 D  ;patient has HCV LOINC
 .. ;if status is pending, change to confirmed
 .. I $P($G(^RORDATA(798,IEN,0)),U,5)=4 D
 ... N RORFDA,IENS,RORMSG
 ... S IENS=IEN_","
 ... S RORFDA(798,IENS,3)=0 ;status=confirmed
 ... S RORFDA(798,IENS,12)="" ;remove pending comment
 ... D FILE^DIE(,"RORFDA","RORMSG")
 K ^TMP("ROR HCV LIST")
 Q
