VPSRPC1  ;BPOIFO/EL,WOIFO/BT - Patient Demographic and Clinic RPC;08/14/14 09:28
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**1,2,4**;Aug 8, 2014;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #10035 - ^DPT( references      (Supported)
 ; #10040 - ^SC( references       (Supported)
 ; #2052  - DID call              (Supported)
 ; #2056  - DIQ call              (Supported)
 ; #2701  - MPIF001 call          (Supported)
 ; #10104 - XLFSTR call           (Supported)
 ; #5888  - RPCVIC^DPTLK          (Controlled Sub)
 QUIT
 ;
GETCLN(VPSARR,CLNAM) ; RPC: VPS GET CLINIC - CLINIC NAME ENTRY
 ; Called by Vetlink Kiosk system.     
 ; The RPC will accept 2 parameters.  The first parameter represents the 
 ; return value as required by RPC Broker, and the 2nd parameter is
 ; single input value representing the name of the clinic (full or partial 
 ; name).  The output produced will be an array that returns all the 
 ; possible matches for the clinic (one to many clinics).  Values returned 
 ; will be the name of the clinic and the ien of the clinic.
 ;
 ; OUTPUT
 ;   VPSARR - passed in by reference; return array of clinics that **contains** input string (CLNAM)
 ; INPUT
 ;   CLNAM  - partial or full name of clinic; 
 ;
 K VPSARR
 I $G(CLNAM)="" S VPSARR(1)="-1^CLINIC NAME NOT SENT" QUIT
 ;
 N VPSCLN,VPSIEN,LOCATION
 N VPSUPNAM S VPSUPNAM=$$UP^XLFSTR(CLNAM)
 N VPSCNAM S VPSCNAM=""
 N VPSFL S VPSFL=44
 ;
 F  S VPSCNAM=$O(^SC("B",VPSCNAM)) QUIT:$G(VPSCNAM)=""  I VPSCNAM[VPSUPNAM D
 . S VPSCLN=""
 . F   S VPSCLN=$O(^SC("B",VPSCNAM,VPSCLN)) QUIT:$G(VPSCLN)=""  D
 . . S VPSIEN=VPSCLN
 . . D SET(.VPSARR,VPSFL,VPSIEN,".001",VPSCLN,"CLINIC NUMBER") ;Clinic IEN
 . . D SET(.VPSARR,VPSFL,VPSIEN,".01",VPSCNAM) ;Clinic Name
 . . S LOCATION=$$GET1^DIQ(VPSFL,VPSCLN_",",10,"E") ;Physical Location
 . . D SET(.VPSARR,VPSFL,VPSIEN,10,LOCATION)
 ;
 I '$D(VPSARR) S VPSARR(1)="-1^CLINIC COULD NOT BE FOUND." QUIT
 ;
 QUIT
 ;
GETDATA(VPSARR,SSN) ; RPC: VPS GET PATIENT DEMOGRAPHIC
 ; This RPC is called  by the Vetlink Kiosk (point of service) system.  
 ; Given Patient SSN, this RPC returns the patient demographics,insurance,and up-coming appointments, etc.
 ;
 ; INPUT
 ;   SSN    - patient SSN 
 ; OUTPUT
 ;   VPSARR - passed in by reference; return array of patient demographics
 ;
 D GETDATA2(.VPSARR,$G(SSN),"SSN")
 QUIT
 ;
GETDATA2(VPSARR,VPSNUM,VPSTYP) ; RPC: VPS GET2 PATIENT DEMOGRAPHIC
 ; This RPC is called  by the Vetlink Kiosk (point of service) system.  
 ; Given Patient SSN or DFN or ICN or VIC/CAC, this RPC returns the patient demographics,insurance,and up-coming appointments, etc.
 ;
 ; OUTPUT
 ;   VPSARR  - passed in by reference; return array of patient demographics,appts
 ; INPUT
 ;   VPSNUM  - Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSTYP  - Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ;
 ; Return all categories
 N CATEGORY,ICAT F ICAT=1:1:6 S CATEGORY(ICAT)=ICAT
 D GETDATA3(.VPSARR,$G(VPSNUM),$G(VPSTYP),.CATEGORY) ; RPC: VPS GET2 PATIENT DEMOGRAPHIC
 QUIT
 ;
GETDATA3(VPSARR,VPSNUM,VPSTYP,VPSCAT) ; RPC: VPS ENHANCED GET PATIENT DEMOGRAPHIC
 ; This RPC is called  by the Vetlink Kiosk (point of service) system.  
 ; Given Patient SSN or DFN or ICN or VIC/CAC, this RPC returns the patient demographics,insurance,and up-coming appointments, etc
 ; for selected categories
 ;
 ; OUTPUT
 ;   VPSARR  - passed in by reference; return array of patient demographics,appts
 ; INPUT
 ;   VPSNUM  - Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSTYP  - Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSCAT  - List of Category to print (REQUIRED)
 ;             VPSCAT(1..N)=CATEGORY;FROMDATE:THROUGHDATE
 ;             Example input parameter : 
 ;                 VPSCAT(1)=6                 - Patient demographics
 ;                 VPSCAT(2)=1;3140101:3141231 - Appointments start from 1/1/2014 through 12/31/2014
 ;                 VPSCAT(3)=2;3140601:3140630 - Lab Orders start from 6/1/2014 through 6/30/2014
 ;             Valid Category:
 ;                 1 - Appointment (With Date Range option)
 ;                 2 - Lab Orders (With Date Range option)
 ;                 3 - Consults
 ;                 4 - Radiology (With Date Range option)
 ;                 5 - Problem
 ;                 6 - Patient demographics
 ;
 K VPSARR
 S VPSARR(1)=$$VALIDATE($G(VPSTYP),$G(VPSNUM))
 QUIT:+VPSARR(1)=-1
 ;
 N DFN S DFN=VPSARR(1)
 K VPSARR
 N CAT,DTRANGE,SEQ S SEQ=0
 ;
 F  S SEQ=$O(VPSCAT(SEQ)) QUIT:'SEQ  D
 . S CAT=$P(VPSCAT(SEQ),";")
 . S DTRANGE=$P(VPSCAT(SEQ),";",2)
 . I CAT=1 D GETAPPT^VPSRPC11(.VPSARR,DFN,DTRANGE) ;Appointments
 . I CAT=2 D GETLAB^VPSRPC12(.VPSARR,DFN,DTRANGE) ;Lab Orders
 . I CAT=3 D GETCNSLT^VPSRPC13(.VPSARR,DFN) ;Consult
 . I CAT=4 D GETRAD^VPSRPC14(.VPSARR,DFN,DTRANGE) ;Radiology
 . I CAT=5 D GETPRBLM^VPSRPC15(.VPSARR,DFN) ;Problem
 . I CAT=6 D GETDEM^VPSRPC16(.VPSARR,DFN) ;Demographics
 QUIT
 ;
VALIDATE(VPSTYP,VPSNUM) ;validate patient-id type and patient id value
 ; INPUT
 ;   VPSTYP  - Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSNUM  - Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ; RETURN
 ;   DFN if patient-type/id pair is valid otherwise return -1^Errormessage 
 ;
 N CM S CM=","
 ;
 QUIT:$G(VPSTYP)="" "-1^TYPE IS REQUIRED (VALID TYPE: SSN, DFN, ICN OR VIC/CAC)"
 QUIT:'$F(",SSN,DFN,ICN,VIC/CAC,",CM_VPSTYP_CM) "-1^INVALID TYPE (VALID TYPE: SSN, DFN, ICN OR VIC/CAC)"
 QUIT:$G(VPSNUM)="" "-1^"_VPSTYP_" IS REQUIRED"
 ; 
 N DFN S DFN=0
 ;
 I VPSTYP="SSN" D
 . N SSN S SSN=$TR(VPSNUM,"- ")
 . I SSN'?1.N S DFN="-1"_U_"SSN SHOULD BE NUMERIC: "_VPSNUM QUIT
 . S DFN=$O(^DPT("SSN",SSN,0))
 . I +DFN'>0 S DFN="-1"_U_"NO PATIENT FOUND WITH SSN: "_VPSNUM
 QUIT:DFN DFN
 ;
 I VPSTYP="DFN" D
 . S DFN=VPSNUM
 . I '$D(^DPT(DFN)) S DFN="-1"_U_"NO PATIENT FOUND WITH DFN: "_DFN
 QUIT:DFN DFN
 ;
 I VPSTYP="VIC/CAC" D
 . D RPCVIC^DPTLK(.DFN,VPSNUM) ; get DFN given VIC/CAC number - IA 5888
 . S:DFN=-1 DFN="-1^INVALID VIC/CAC NUMBER "_VPSNUM
 QUIT:DFN DFN
 ;
 I VPSTYP="ICN" D
 . S DFN=$$GETDFN^MPIF001(VPSNUM) ; get DFN given ICN in the Patient file  - IA 2701
 ;
 QUIT DFN
 ;
SET(VPSARR,VPSFL,VPSIEN,VPSFLD,VPSDA,VPSDS,VPSCAT) ;Set line item to output array
 ; OUTPUT
 ;   VPSARR - passed in by reference; This is the Array of clinics contains the line item
 ; INPUT
 ;   VPSFL  - File Number
 ;   VPSIEN - File IEN
 ;   VPSFLD - File Field Number
 ;   VPSDA  - Field Value
 ;   VPSDS  - (optional) User defined Field Name - default is the Fileman fieldname
 ;   VPSCAT - Category: 1 - Appointment, 2 - Lab Orders, 3 - Consults, 4 - Radiology, 5 - Problem, 6 - Patient demographics
 ;
 N CNT S CNT=$O(VPSARR(""),-1)+1
 I $G(VPSDS)="",$G(VPSFL),$G(VPSFLD) N VPSOUT D FIELD^DID(VPSFL,VPSFLD,"","LABEL","VPSOUT") S VPSDS=VPSOUT("LABEL")
 S VPSARR(CNT)=$G(VPSFL)_U_$G(VPSIEN)_U_$G(VPSFLD)_U_$G(VPSDA)_U_$G(VPSDS)_U_$G(VPSCAT)
 QUIT
