RORHL20 ;BPOIFO/ACS - HL7 NON-VA MEDS: ORC,RXE ;8/23/10
 ;;1.5;CLINICAL CASE REGISTRIES;**13**;Feb 17, 2006;Build 27
 ;
 ; This routine uses the following IAs:
 ;
 ; #330          ^PSOHCSUM (controlled)
 ; #10104        TRIM^XLFSTR (supported)
 ;
 Q
 ;
 ;***** SEARCH FOR NON-VA MEDS
 ;
 ; DFN           DFN of the patient in the PATIENT file (#2)
 ;.DXDTS         Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; Return Values:
 ;        0  Ok
 ;
EN1(RORDFN,DXDTS) ;DATA AREA = 19
 N IDX,RORSTDT,RORENDT
 S IDX=0
 F  S IDX=$O(DXDTS(19,IDX))  Q:IDX'>0  D
 . S RORSTDT=$P(DXDTS(19,IDX),U),RORENDT=$P(DXDTS(19,IDX),U,2)
 . D EN2(RORDFN,RORSTDT,RORENDT) ;get Non-VA meds for patient
 Q 0
 ;
 ;***** GET NON-VA MEDS
 ;Input
 ; RORDFN        DFN of the patient in the PATIENT file (#2)
 ; RORSTDT       Start date of extract
 ; RORENDT       End date of extract
 ;
 ; Return Values:
 ;        0  Ok
 ;
EN2(RORDFN,RORSTDT,RORENDT) ;
 N CS D ECH^RORHL7(.CS) ;component separator
 N SCS D ECH^RORHL7(,.SCS) ;sub-component separator
 N DFN S DFN=$G(RORDFN) ;must be set for call to ^PSOHCSUM
 ;^PSOHCSUM will return all Non-VA meds, regardless of what date is passed in.
 ;To minimize the number of other meds returned, set start = current date
 N PSOBEGIN S PSOBEGIN=DT D ^PSOHCSUM
 N COUNT,RORNVA,RORKEEP,I,DATA10,DATA0,RORTEXT
 S COUNT=0 F  S COUNT=$O(^TMP("PSOO",$J,"NVA",COUNT)) Q:'COUNT  D
 . K RORNVA
 . S RORNVA("DOCDT")=$P($G(^TMP("PSOO",$J,"NVA",COUNT,0)),U,5) ;documented date
 . S RORNVA("DISDT")=$P($G(^TMP("PSOO",$J,"NVA",COUNT,0)),U,7) ;discontinued date
 . S RORKEEP=0
 . ;Documented date or discontinued date must be in the extract range
 . I $G(RORNVA("DOCDT")),RORNVA("DOCDT")\1'<RORSTDT\1,RORNVA("DOCDT")'>RORENDT\1 S RORKEEP=1
 . I $G(RORNVA("DISDT")),RORNVA("DISDT")\1'<RORSTDT\1,RORNVA("DISDT")'>RORENDT\1 S RORKEEP=1
 . I 'RORKEEP Q  ;quit if not in range
 . ;Populate RORNVA with data
 . S RORNVA("ORDNUM")=$P($G(^TMP("PSOO",$J,"NVA",COUNT,0)),U,4) ;CPRS order#
 . S RORNVA("IEN522")=COUNT ;Non-VA med IEN in sub-file 52.2
 . S DATA10=$G(^TMP("PSOO",$J,"NVA",COUNT,1,0)) ;1,0 node
 . S DATA0=$G(^TMP("PSOO",$J,"NVA",COUNT,0)) ;0 node
 . S RORNVA("DOSE")=$P($G(DATA10),U,1) ;dosage
 . S RORNVA("MEDROUTE")=$P($G(DATA10),U,2) ;med route
 . S RORNVA("SCHED")=$P($G(DATA10),U,3) ;schedule
 . S RORNVA("DRUGINFO")=$P($G(DATA10),U,4) ;drug IEN;name
 . S RORNVA("DRUGIEN")=$P($G(RORNVA("DRUGINFO")),";",1) ;drug IEN
 . S RORNVA("DRUGNAME")=$P($G(RORNVA("DRUGINFO")),";",2) ;drug name
 . S RORNVA("CLINICINFO")=$P($G(DATA10),U,5) ;clinic IEN;name
 . S RORNVA("CLIEN")=$P($G(RORNVA("CLINICINFO")),";",1) ;clinic IEN
 . S RORNVA("CLNAME")=$P($G(RORNVA("CLINICINFO")),";",2) ;clinic name
 . S RORNVA("OIDF")=$P($G(DATA0),U,1) ;orderable item + dose form
 . S RORNVA("STATUS")=$P($G(DATA0),U,2) ;status
 . S RORNVA("STATUS")=$$UPCASE($G(RORNVA("STATUS")))
 . S RORNVA("START")=$P($G(DATA0),U,3) ;start date
 . S RORNVA("DOCBY")=$P($G(DATA0),U,6) ;doc by IEN;name
 . S RORNVA("DBIEN")=$P($G(RORNVA("DOCBY")),";",1) ;doc by IEN
 . S RORNVA("DBNAME")=$P($G(RORNVA("DOCBY")),";",2) ;doc by name
 . S RORNVA("STOPCD")=$$STOPCODE^RORUTL18($G(RORNVA("CLIEN"))) ;clinic stop
 . K RORNVA("DISCL") S I=0 F  S I=$O(^TMP("PSOO",$J,"NVA",COUNT,"DSC",I)) Q:'I  D
 . . S RORTEXT=$G(^TMP("PSOO",$J,"NVA",COUNT,"DSC",I,0))
 . . I $L($G(RORNVA("DISCL")))>0 S RORNVA("DISCL")=RORNVA("DISCL")_" "_$$TRIM^XLFSTR($G(RORTEXT))
 . . I $L($G(RORNVA("DISCL")))'>0 S RORNVA("DISCL")=$$TRIM^XLFSTR($G(RORTEXT))
 . D ORC(CS,SCS,.RORNVA)
 . D RXE(CS,SCS,.RORNVA)
 K RORNVA,^TMP("PSOO",$J)
 Q 0
 ;
 ;***** NON-VA MEDS ORC SEGMENT BUILDER
 ;
 ;Input
 ;  CS        Component separator
 ;  SCS       Sub-component separator
 ;  RORNVA    Array containing Non-VA medication information:
 ;     RORNVA("IEN522")    Non-VA med IEN in sub-file 52.2
 ;     RORNVA("ORDNUM")    CPRS Order Number
 ;     RORNVA("DOCDT")     Documented Date
 ;     RORNVA("DISDT")     Discontinued Date
 ;     RORNVA("DOSE")      Dosage
 ;     RORNVA("MEDROUTE")  Medication Route
 ;     RORNVA("SCHED")     Schedule
 ;     RORNVA("DRUGIEN")   Drug IEN
 ;     RORNVA("DRUGNAME")  Drug name
 ;     RORNVA("STOPCD")    Clinic Stop Code
 ;     RORNVA("CLIEN")     Clinic IEN
 ;     RORNVA("CLNAME")    Clinic Name
 ;     RORNVA("OIDF")      Orderable Item + Dose Form
 ;     RORNVA("STATUS")    Status
 ;     RORNVA("START")     Start Date
 ;     RORNVA("DBIEN")     Documented by IEN
 ;     RORNVA("DBNAME")    Documented by Name
 ;     RORNVA("DISCL")     Disclaimer text
 ; 
ORC(CS,SCS,RORNVA) ;
 ;--- Initialize the segment
 N RORSEG S RORSEG(0)="ORC"
 ;
 ;--- ORC-1 - Order Control
 S RORSEG(1)="NW"
 ;
 ;--- ORC-2 - Placer Order #
 S RORSEG(2)=$G(RORNVA("IEN522"))_CS_"NVA"
 ;
 ;--- ORC-5 - Order Status: IP for active, DC for discontinued
 S RORSEG(5)=$S($G(RORNVA("STATUS"))="ACTIVE":"IP",$G(RORNVA("STATUS"))="DISCONTINUED":"DC",1:"")
 ;
 ;--- ORC-9 - Date/Time of Transaction: Documented Date/Time
 I $G(RORNVA("DOCDT")) S RORSEG(9)=$$FM2HL^RORHL7(RORNVA("DOCDT"))
 ;
 ;--- ORC-12 - Documented By IEN ^^^^^^^^^^^^ Provider Class
 S RORSEG(12)=$G(RORNVA("DBIEN"))
 I $G(RORSEG(12))>0  D
 . S $P(RORSEG(12),CS,13)=$$GET1^DIQ(200,+RORSEG(12)_",",53.5,"E",,"RORMSG")
 ;
 ;--- ORC-16 - Control Code Reason
 S RORSEG(16)=CS_CS_CS_CS_"NEW"
 ;
 ;--- ORC-17 - Enterer's Organization: Division= Station Number ^ Station Name ^ 99VA4
 S RORSEG(17)=$$SITE^RORUTL03(CS)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
 ;
 ;***** NON-VA MEDS RXE SEGMENT BUILDER
 ;
 ;Input
 ;  CS        component separator
 ;  SCS       sub-component separator
 ;  RORNVA    Array containing Non-VA medication information:
 ;     RORNVA("IEN522")    Non-VA med IEN in sub-file 52.2
 ;     RORNVA("ORDNUM")    CPRS Order Number
 ;     RORNVA("DOCDT")     Documented Date
 ;     RORNVA("DISDT")     Discontinued Date
 ;     RORNVA("DOSE")      Dosage
 ;     RORNVA("MEDROUTE")  Medication Route
 ;     RORNVA("SCHED")     Schedule
 ;     RORNVA("DRUGIEN")   Drug IEN
 ;     RORNVA("DRUGNAME")  Drug name
 ;     RORNVA("STOPCD")    Clinic Stop Code
 ;     RORNVA("CLIEN")     Clinic IEN
 ;     RORNVA("CLNAME")    Clinic Name
 ;     RORNVA("OIDF")      Orderable Item + Dose Form
 ;     RORNVA("STATUS")    Status
 ;     RORNVA("START")     Start Date
 ;     RORNVA("DBIEN")     Documented by IEN
 ;     RORNVA("DBNAME")    Documented by Name
 ;     RORNVA("DISCL")     Disclaimer text
 ;
RXE(CS,SCS,RORNVA) ;
 ;--- Initialize the segment
 N RORSEG S RORSEG(0)="RXE"
 ;
 ;--- RXE-1 - Quantity/Timing: Dosage ^ Schedule ^^ Start Date ^ Discontinue Date ^^^ Medication Route
 N START I $G(RORNVA("START")) S START=$$FM2HL^RORHL7(RORNVA("START"))
 N END I $G(RORNVA("DISDT")) S END=$$FM2HL^RORHL7(RORNVA("DISDT"))
 S RORSEG(1)=$G(RORNVA("DOSE"))_CS_$G(RORNVA("SCHED"))_CS_CS_$G(START)_CS_$G(END)_CS_CS_CS_$G(RORNVA("MEDROUTE"))
 ;
 ;--- RXE-2 - Give Code: NDC code^VA Product Name^PSNDF^ NDF IEN + VA drug class code^Generic name^99PSD
 ;                   or: ^^^^ orderable item + dose form
 N DRUGIEN,DRUGINFO,INDF,TMP S DRUGIEN=$G(RORNVA("DRUGIEN"))
 I $G(DRUGIEN) S DRUGINFO="",TMP=$$RXE2^RORHL031(DRUGIEN,CS,.DRUGINFO,.INDF)
 I '$G(DRUGIEN) S $P(DRUGINFO,CS,5)=$G(RORNVA("OIDF"))
 S RORSEG(2)=$G(DRUGINFO)
 ;
 ;--- RXE-7 - Provider's Administration Instructions: Disclaimer text
 I $L($G(RORNVA("DISCL")))>0 S RORSEG(7)=CS_$$TRIM^XLFSTR($G(RORNVA("DISCL")))
 I $L($G(RORSEG(7)))>4001 S RORSEG(7)=$E(RORSEG(7),1,4001) ;CS + 4000 characters
 ;
 ;--- RXE-15 - Prescription Number: CPRS Order Number
 S RORSEG(15)=$G(RORNVA("ORDNUM"))
 ;
 ;--- RXE-21 - Stop Code
 S RORSEG(21)=$G(RORNVA("STOPCD"))
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
 ;
UPCASE(DATA) ;
 Q $TR(DATA,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ; 
