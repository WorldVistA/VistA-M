VPSRPC15  ;BPOIFO/KG - Patient Problems;07/31/14 13:07
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**4,14**;Jul 31, 2014;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #2741 - DETAIL^GMPLUTL2   (Controlled Sub)
 ; #2741 - LIST^GMPLUTL2     (Controlled Sub)
 ; #2977 - GETFLDS^GMPLEDT3  (Controlled Sub)
 QUIT
 ;
GETPRBLM(VPSARR,DFN) ;given DFN, returns the patient problems
 N ICDIEN,PRBIEN,PRBIENS,PRBINFO,GMPL
 ;
 ;--- Load a list of active problems
 N PLST D LIST^GMPLUTL2(.PLST,DFN,"A",0) ; Returns list of Prob for Pt.
 ;
 ;--- Browse through the problems
 N CNT S CNT=0
 N FILE S FILE=9000011
 N EXIST S EXIST=0
 ;
 F  S CNT=$O(PLST(CNT)) Q:CNT=""  D
 . S PRBIEN=$P(PLST(CNT),U)
 . Q:PRBIEN'>0
 . S EXIST=1
 . K GMPL D DETAIL^GMPLUTL2(PRBIEN,.GMPL)
 . D SET(.VPSARR,FILE,DFN_";"_PRBIEN,.01,$G(GMPL("DIAGNOSIS")),"DIAGNOSIS")
 . D SET(.VPSARR,FILE,DFN_";"_PRBIEN,.03,$G(GMPL("MODIFIED")),"DATE LAST MODIFIED")
 . D SET(.VPSARR,FILE,DFN_";"_PRBIEN,.05,$G(GMPL("NARRATIVE")),"PROVIDER NARRATIVE")
 . D SET(.VPSARR,FILE,DFN_";"_PRBIEN,.06,$P($G(GMPL("FACILITY")),U,2),"FACILITY")
 . D SET(.VPSARR,FILE,DFN_";"_PRBIEN,.08,$P($G(GMPL("ENTERED")),U),"DATE ENTERED")
 . D SET(.VPSARR,FILE,DFN_";"_PRBIEN,.12,$G(GMPL("STATUS")),"STATUS")
 . D SET(.VPSARR,FILE,DFN_";"_PRBIEN,1.02,$G(GMPL("CONDITION")),"CONDITION")
 . D SET(.VPSARR,FILE,DFN_";"_PRBIEN,1.03,$P($G(GMPL("ENTERED")),U,2),"ENTERED BY")
 . D SET(.VPSARR,FILE,DFN_";"_PRBIEN,1.04,$P($G(GMPL("RECORDED")),U,2),"RECORDING PROVIDER")
 . D SET(.VPSARR,FILE,DFN_";"_PRBIEN,1.05,$G(GMPL("PROVIDER")),"RESPONSIBLE PROVIDER")
 . D SETEXP(.VPSARR,FILE,DFN,PRBIEN) ;set expression
 ;
 I 'EXIST D SET(.VPSARR,"E",DFN,"","NO PROBLEM RECORDS FOUND FOR PATIENT","PROBLEM NOT FOUND")
 QUIT
 ;
SETEXP(VPSARR,FILE,DFN,PRBIEN) ;set expression
 N GMPVAMC S GMPVAMC=0
 N GMPROV S GMPROV=0
 N GMPORIG,GMPFLD
 D GETFLDS^GMPLEDT3(PRBIEN)
 D SET(.VPSARR,FILE,DFN_";"_PRBIEN,1.01,$P($G(GMPFLD(1.01)),U,2),"EXPRESSIONS")
 QUIT
 ;
SET(VPSARR,VPSFL,VPSIEN,VPSFLD,VPSDA,VPSDS) ;Set line item to output array
 I VPSDA'="" D SET^VPSRPC1(.VPSARR,VPSFL,VPSIEN,VPSFLD,VPSDA,$G(VPSDS),5) ;Set line item to output array
 QUIT
 ;
GETHF(VPSARR,DFN) ;given DFN, returns the patient health factors
 N IEN,DAT
 S IEN=""
 ; Look up health factors for the patient
 F  S IEN=$O(^AUPNVHF("C",DFN,IEN)) Q:'IEN  D
 . S DAT=$$GET1^DIQ(9000010.23,IEN_",",.01) ; retrieve the patient's health factor
 . D SET^VPSRPC1(.VPSARR,9000010.23,DFN_";"_IEN,.01,DAT,"HEALTH FACTOR",9)
 QUIT
 ;
GETADEM(VPSARR,DFN) ;given DFN, returns the patient demographics, insurance, and up-coming appointments.
 ; OUTPUT
 ;   VPSARR - passed in by reference; this is the output array to store patient demographics
 ; INPUT
 ;   DFN    - patient DFN (This value must be validated before calling this procedure)
 ;
 D ENR^VPSRPC16(.VPSARR,DFN) ; Store Patient Enrollment
 D OTH^VPSRPC26(.VPSARR,DFN) ; Store Other information not in KNOWN API
 D POW^VPSRPC26(.VPSARR,DFN) ; Store POW
 D PH^VPSRPC26(.VPSARR,DFN) ; Store Purple Heart
 D MP^VPSRPC26(.VPSARR,DFN) ; Store Missing Person
 D SVC^VPSRPC26(.VPSARR,DFN) ; Store Service Connected and Rated Disabilities
 D CHG^VPSRPC26(.VPSARR,DFN) ; Store Change DT/TM
 D BLPAT^VPSRPC26(.VPSARR,DFN) ; Store Billing Patient
 D PCT^VPSRPC26(.VPSARR,DFN) ; Primary Care Team
 Q
