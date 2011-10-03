RORHL21 ;BPOIFO/ACS - HL7 PURCHASED CARE: ZIN,ZSV,ZRX ;8/23/10
 ;;1.5;CLINICAL CASE REGISTRIES;**14**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #5409         File 162.11 (controlled)
 ; #5107         Files 162.02, 162.03 (controlled)
 ; #5104         File 162.4 (controlled)
 ; #4533         DATA^PSS50 (supported)
 ; #XXXX         File 162.5 (private - approval in progress)
 ;
 Q
 ;
 ;***** SEARCH FOR PURCHASED CARE
 ;
 ; RORDFN        DFN of the patient in the PATIENT file (#2)
 ;.DXDTS         Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; Return Values:
 ;        0  Ok
 ;
EN1(RORDFN,DXDTS) ;DATA AREA = 20
 N IDX,RORSTDT,RORENDT
 S IDX=0
 F  S IDX=$O(DXDTS(20,IDX))  Q:IDX'>0  D
 . S RORSTDT=$P(DXDTS(20,IDX),U),RORENDT=$P(DXDTS(20,IDX),U,2)
 . D EN2(RORDFN,RORSTDT,RORENDT) ;get purchased care data for patient
 Q 0
 ;
 ;***** LOOP THROUGH PURCHASED CARE DATA
 ;Input
 ; RORDFN        DFN of the patient in the PATIENT file (#2)
 ; RORSTDT       Start date of CCR extract
 ; RORENDT       End date of CCR extract
 ;
EN2(RORDFN,RORSTDT,RORENDT) ;
 N CS D ECH^RORHL7(.CS) ;get component separator
 N SCS D ECH^RORHL7(,.SCS) ;get sub-component separator
 N RPS D ECH^RORHL7(,,.RPS) ;get repetition separator
 ;
 ;GET INPATIENT DATA FROM FEE BASIS INVOICE FILE #162.5
 ;Date Finalized is used to determine inclusion for HL7 message
 N RORIP,IPIEN,IENS,RORDATA,RORERR,DATA7078,ERR7078,FINALDT,PREPTR
 S IPIEN=0
 F  S IPIEN=$O(^FBAAI("D",RORDFN,IPIEN)) Q:'IPIEN  D  ;DFN x-ref
 . K RORIP ;clean out previous data
 . S RORIP("IEN")=IPIEN
 . S IENS=IPIEN_","
 . K RORDATA,RORERR D GETS^DIQ(162.5,IENS,"4;5;6;6.5;6.6;8;19;24;30;31;32;33;34;40;41;42;43;44;54","IE","RORDATA","RORERR")
 . S FINALDT=$G(RORDATA(162.5,IENS,19,"I")) ;Date finalized
 . Q:'FINALDT
 . Q:((FINALDT<RORSTDT)!(FINALDT>RORENDT))  ;quit if outside extract range
 . S RORIP("FINALDT")=$G(FINALDT)
 . S PREPTR=$G(RORDATA(162.5,IENS,4,"I")) ;Pre-authorization pointer
 . I $G(PREPTR)["FB7078" S PREPTR=+PREPTR I $G(PREPTR)>0 D
 .. N IENS7078 S IENS7078=PREPTR_","
 .. K DATA7078,ERR7078 D GETS^DIQ(162.4,IENS7078,"3.5;4.5","I","DATA7078","ERR7078") ;DBIA 5104 (controlled
 .. S RORIP("ADMDT")=$G(DATA7078(162.4,IENS7078,3.5,"I")) ;Date of admission
 .. S RORIP("DISDT")=$G(DATA7078(162.4,IENS7078,4.5,"I")) ;Date of discharge
 . S RORIP("TRFROMDT")=$G(RORDATA(162.5,IENS,5,"I")) ;Treatement 'from' date
 . S RORIP("TRTODT")=$G(RORDATA(162.5,IENS,6,"I")) ;Treatment 'to' date
 . S RORIP("DISTYPE")=$G(RORDATA(162.5,IENS,6.5,"I")) ;Discharge type code
 . S RORIP("PAID")=$G(RORDATA(162.5,IENS,8,"I")) ;Amount paid
 . S RORIP("BILLED")=$G(RORDATA(162.5,IENS,6.6,"I")) ;Billed charges
 . S RORIP("DISDRG")=$G(RORDATA(162.5,IENS,24,"E")) ;Discharge DRG
 . S RORIP("COVDAYS")=$G(RORDATA(162.5,IENS,54,"E")) ;covered days
 . S RORIP("ICD1")=$G(RORDATA(162.5,IENS,30,"E")) ;ICD 1
 . S RORIP("ICD2")=$G(RORDATA(162.5,IENS,31,"E")) ;ICD 2
 . S RORIP("ICD3")=$G(RORDATA(162.5,IENS,32,"E")) ;ICD 3
 . S RORIP("ICD4")=$G(RORDATA(162.5,IENS,33,"E")) ;ICD 4
 . S RORIP("ICD5")=$G(RORDATA(162.5,IENS,34,"E")) ;ICD 5
 . S RORIP("PROC1")=$G(RORDATA(162.5,IENS,40,"E")) ;Procedure 1
 . S RORIP("PROC2")=$G(RORDATA(162.5,IENS,41,"E")) ;Procedure 2
 . S RORIP("PROC3")=$G(RORDATA(162.5,IENS,42,"E")) ;Procedure 3
 . S RORIP("PROC4")=$G(RORDATA(162.5,IENS,43,"E")) ;Procedure 4
 . S RORIP("PROC5")=$G(RORDATA(162.5,IENS,44,"E")) ;Procedure 5
 . D ZIN(.RORIP)
 ;
 ;---GET OUTPATIENT DATA FROM FEE BASIS PAYMENT FILE #162
 ;Date Finalized is used to determine inclusion for HL7 message
 N RORVENDOR ;authorization vendor IEN
 N RORITDT ;initial treatment date IEN
 N RORSVC ;service IEN
 N IENS,FINALDT
 S RORVENDOR=0 F  S RORVENDOR=$O(^FBAAC(RORDFN,1,RORVENDOR)) Q:'RORVENDOR  D
 . ;go to 'initial treatment date' level and get requested data
 . S RORITDT=0 F  S RORITDT=$O(^FBAAC(RORDFN,1,RORVENDOR,1,RORITDT)) Q:'RORITDT  D
 .. N ROROP ;array to hold outpatient data
 .. K IENS S IENS=RORITDT_","_RORVENDOR_","_RORDFN_","
 .. K RORDATA,RORERR D GETS^DIQ(162.02,IENS,".01;1.5","IE","RORDATA","RORERR")
 .. S ROROP("TRDT")=$G(RORDATA(162.02,IENS,.01,"I")) ;initial treatment date
 .. S ROROP("FEEPGM")=$G(RORDATA(162.02,IENS,1.5,"I")) ;fee program
 .. ;go to 'service provided' level and get requested data
 .. S RORSVC=0 F  S RORSVC=$O(^FBAAC(RORDFN,1,RORVENDOR,1,RORITDT,1,RORSVC)) Q:'RORSVC  D
 ... N IENSVC S IENSVC=RORSVC_","_RORITDT_","_RORVENDOR_","_RORDFN_","
 ... K RORDATA,RORERR D GETS^DIQ(162.03,IENSVC,".01;5;16;28;30","IE","RORDATA","RORERR")
 ... S FINALDT=$G(RORDATA(162.03,IENSVC,5,"I")) ;date finalized
 ... Q:(($G(FINALDT)<RORSTDT)!($G(FINALDT)>(RORENDT)))  ;quit if outside date range
 ... S ROROP("FINALDT")=FINALDT
 ... S ROROP("SVC")=$G(RORDATA(162.03,IENSVC,.01,"E")) ;service provided
 ... S ROROP("POV")=$G(RORDATA(162.03,IENSVC,16,"E")) ;purpose of visit
 ... S ROROP("PDIAG")=$G(RORDATA(162.03,IENSVC,28,"E")) ;primary diagnosis
 ... S ROROP("POS")=$G(RORDATA(162.03,IENSVC,30,"E")) ;place of service
 ... S ROROP("IEN")=RORDFN_"-"_RORVENDOR_"-"_RORITDT_"-"_RORSVC
 ... D ZSV(.ROROP)
 ;
 ;
 ;---GET DRUG DATA FROM FEE BASIS PHARMACY INVOICE FILE #162.1
 ;Date Certified for Payment (RORDCP) is used to determine inclusion in HL7 message
 N RORRX,RORDCP,RXIEN0,RXIEN1
 S RORDCP=(RORSTDT-.01) F  S RORDCP=$O(^FBAA(162.1,"AA",RORDCP)) Q:'RORDCP  Q:(RORDCP>RORENDT)  D
 . S RXIEN0=0
 . F  S RXIEN0=$O(^FBAA(162.1,"AA",RORDCP,RORDFN,RXIEN0)) Q:'RXIEN0  D
 .. S RXIEN1=0 F  S RXIEN1=$O(^FBAA(162.1,"AA",RORDCP,RORDFN,RXIEN0,RXIEN1)) Q:'RXIEN1  D
 ... K RORRX ;clean out previous data
 ... S RORRX("NUM")=$P($G(^FBAA(162.1,RXIEN0,"RX",RXIEN1,0)),U,1) ;rx number
 ... S RORRX("NAME")=$P($G(^FBAA(162.1,RXIEN0,"RX",RXIEN1,0)),U,2) ;drug name
 ... Q:($G(RORRX("NAME"))="")  ;drug name is required
 ... S RORRX("FILLDT")=$P($G(^FBAA(162.1,RXIEN0,"RX",RXIEN1,0)),U,3) ;date filled
 ... S RORRX("GENIEN")=$P($G(^FBAA(162.1,RXIEN0,"RX",RXIEN1,0)),U,10) ;generic drug IEN
 ... I $G(RORRX("GENIEN")) D  ;get generic drug name
 .... D DATA^PSS50(RORRX("GENIEN"),,,,,"RORDRUG")
 .... S RORRX("GENERIC")=$G(^TMP($J,"RORDRUG",RORRX("GENIEN"),.01)) ;generic drug name
 .... K ^TMP($J,"RORDRUG")
 ... S RORRX("STRENGTH")=$P($G(^FBAA(162.1,RXIEN0,"RX",RXIEN1,0)),U,12) ;drug strength
 ... S RORRX("QUANTITY")=$P($G(^FBAA(162.1,RXIEN0,"RX",RXIEN1,0)),U,13) ;drug quantity
 ... S RORRX("IEN1")=$G(RXIEN0) S RORRX("IEN2")=$G(RXIEN1)
 ... D ZRX(.RORRX)
 Q
 ;
 ;
 ;***** ZIN SEGMENT BUILDER
 ;
 ;Input
 ;  RORIP     Array with inpatient data
 ;
ZIN(RORIP) ;
 ;--- Segment type
 N RORSEG S RORSEG(0)="ZIN"
 ;ZIN-1: Unique Key (IEN)
 S RORSEG(1)=$G(RORIP("IEN"))
 ;ZIN-2: Treatment 'from' date
 I $G(RORIP("TRFROMDT")) S RORSEG(2)=$$FM2HL^RORHL7(RORIP("TRFROMDT"))
 ;ZIN-3: Treatment 'to' date
 I $G(RORIP("TRTODT")) S RORSEG(3)=$$FM2HL^RORHL7(RORIP("TRTODT"))
 ;ZIN-4: Discharge Type code
 S RORSEG(4)=$G(RORIP("DISTYPE"))
 ;ZIN-5: Amount Billed
 S RORSEG(5)=$G(RORIP("BILLED"))
 ;ZIN-6: Amount Paid
 S RORSEG(6)=$G(RORIP("PAID"))
 ;ZIN-7: Date Finalized
 I $G(RORIP("FINALDT")) S RORSEG(7)=$$FM2HL^RORHL7(RORIP("FINALDT"))
 ;ZIN-8: Discharge DRG
 S RORSEG(8)=$G(RORIP("DISDRG"))
 ;ZIN-9: Date of Admission
 I $G(RORIP("ADMDT")) S RORSEG(9)=$$FM2HL^RORHL7(RORIP("ADMDT"))
 ;ZIN-10: Date of Discharge
 I $G(RORIP("DISDT")) S RORSEG(10)=$$FM2HL^RORHL7(RORIP("DISDT"))
 ;ZIN-11: Covered Days
 S RORSEG(11)=$G(RORIP("COVDAYS"))
 ;ZIN-12: ICD 1
 S RORSEG(12)=$G(RORIP("ICD1"))
 ;ZIN-13: ICD 2
 S RORSEG(13)=$G(RORIP("ICD2"))
 ;ZIN-14: ICD 3
 S RORSEG(14)=$G(RORIP("ICD3"))
 ;ZIN-15: ICD 4
 S RORSEG(15)=$G(RORIP("ICD4"))
 ;ZIN-16: ICD 5
 S RORSEG(16)=$G(RORIP("ICD5"))
 ;ZIN-17: Procedure 1
 S RORSEG(17)=$G(RORIP("PROC1"))
 ;ZIN-18: Procedure 2
 S RORSEG(18)=$G(RORIP("PROC2"))
 ;ZIN-19: Procedure 3
 S RORSEG(19)=$G(RORIP("PROC3"))
 ;ZIN-20: Procedure 4
 S RORSEG(20)=$G(RORIP("PROC4"))
 ;ZIN-21: Procedure 5
 S RORSEG(21)=$G(RORIP("PROC5"))
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
 ;
 ;***** ZSV SEGMENT BUILDER
 ;
 ;Input
 ;  ROROP     Array with outpatient data
 ;
ZSV(ROROP) ;
 ;--- Segment type
 N RORSEG S RORSEG(0)="ZSV"
 ;ZSV-1: Unique key (IEN)
 S RORSEG(1)=$G(ROROP("IEN"))
 ;ZSV-2: Initial Treatment Date
 I $G(ROROP("TRDT")) S RORSEG(2)=$$FM2HL^RORHL7(ROROP("TRDT"))
 ;ZSV-3: Fee Program IEN
 S RORSEG(3)=$G(ROROP("FEEPGM"))
 ;ZSV-4: Service Provided
 S RORSEG(4)=$G(ROROP("SVC"))
 ;ZSV-5: Purpose of Visit
 S RORSEG(5)=$G(ROROP("POV"))
 ;ZSV-6: Primary Diagnosis
 S RORSEG(6)=$G(ROROP("PDIAG"))
 ;ZSV-7: Place of Service
 S RORSEG(7)=$G(ROROP("POS"))
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
 ;
 ;***** ZRX SEGMENT BUILDER
 ;
 ;Input
 ;  RORRX     Array with drug data
 ;
ZRX(RORRX) ;
 ;--- Segment type
 N RORSEG S RORSEG(0)="ZRX"
 ;ZRX-1: Unique key (IEN)
 S RORSEG(1)=$G(RORRX("IEN1"))_"-"_$G(RORRX("IEN2"))
 ;ZRX-2: Rx Number
 S RORSEG(2)=$G(RORRX("NUM"))
 ;ZRX-3: Date Rx Filled
 I $G(RORRX("FILLDT")) S RORSEG(3)=$$FM2HL^RORHL7(RORRX("FILLDT"))
 ;ZRX-4: Drug Name
 S RORSEG(4)=$G(RORRX("NAME"))
 ;ZRX-5: Generic Drug Name
 S RORSEG(5)=$G(RORRX("GENERIC"))
 ;ZRX-6: Drug Strength
 S RORSEG(6)=$G(RORRX("STRENGTH"))
 ;ZRX-7: Drug Quantity
 S RORSEG(7)=$G(RORRX("QUANTITY"))
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
