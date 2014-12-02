VPSRPC4 ;DALOI/KML - VPS Check In RPC ;4/26/2012
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**2**;Oct 21, 2011;Build 41
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
CHK(VPSRES,VPSAPPT) ;
 ;VPS PATIENT CHECK-IN rpc - entry point
 ; patient can be checked-in for one to many appointments via the KIOSK
 ;VPSAPPTS - Input: string that represents the appt(s) to be checked in.  
 ;Since more than one appt can be checked-in, each appt consists of the DFN, CLINIC ien, and appt date/timestamp.  
 ;Each appt is delimited by ";" and the 3 pieces of data are separated by "-".   All 3 data elements in the appt 
 ;representation are required input.
 ; Syntax: 
 ;         DFN_"-"_clinic IEN_"-"_date/timestamp of scheduled appt_";"
 ;
 ; example of data string (represents 2 appts):
 ;         "308165-1218-3120420.1215;308165-4569-3120420.1030"
 ;
 ;VPSRES - Output:  single-dimensional array that represents the results for each appointment that was checked in.  
 ;Each data element in the array represents the result of an appt check-in transaction; and the data 
 ;in the 4-pieced string is  delimited by "-".
 ; return value = 1 if check-in successful or '99' if appointment was not checked in
 ;  Syntax: 
 ; DFN_"-"_clinicIEN_"-"_date/timestamp of appt_"-"_return value_";"
 ; example of data output (example represents the result of 2 checked in appts):
 ;                   VPSRES(0)="308165-1218-3120420.1215-1
 ;                   VPSRES(1)="308165-4569-3120420.1030-99"
 ; ICR 5792 call to FIND^SDAM2
 ; ICR 5838 call to HDLKILL, BEFORE, HANDLE, AFTER, EVT routine in SDAMEVT
 N VPSCIEN,VPSI,DFN,VPSDT,VPSCLIN,RESULT,VPSREC
 I '+$G(VPSAPPT) S VPSRES(0)="---99-appt record not sent" Q
 F VPSI=1:1 S VPSREC=$P(VPSAPPT,";",VPSI) Q:VPSREC']""  D
 . S DFN=$P(VPSREC,"-"),VPSCLIN=$P(VPSREC,"-",2),VPSDT=$P(VPSREC,"-",3)
 . I '+DFN S VPSRES(VPSI)=VPSREC_"-99-patient DFN not sent" Q
 . I '+VPSDT S VPSRES(VPSI)=VPSREC_"-99-date/timestamp not sent" Q
 . I '+VPSCLIN S VPSRES(VPSI)=VPSREC_"-99-clinic identifier not sent" Q
 . D DT^DILF("T",VPSDT,.VPSDT)
 . I $P(VPSDT,".")>DT!($P(VPSDT,".")<DT) S VPSRES(VPSI)=VPSREC_"-99-Only appointments scheduled for today's date are allowed to be checked-in" Q
 . S VPSCIEN=$$FIND^SDAM2(DFN,VPSDT,VPSCLIN)
 . I +VPSCIEN'>0 S VPSRES(VPSI)=VPSREC_"-99-Appt not found." Q
 . D HDLKILL^SDAMEVT  ;CLEAR PRE-EXISTING HANDLES
 . N SDATA,SDCIHDL S SDATA=VPSCIEN_U_DFN_U_VPSDT_U_VPSCLIN,SDCIHDL=$$HANDLE^SDAMEVT(1) ;CALL TO EVENT HANDLER
 . D BEFORE^SDAMEVT(.SDATA,DFN,VPSDT,VPSCLIN,VPSCIEN,SDCIHDL)  ;CAPTURE CURRENT APT DATA IN ^TMP("SDAMEVT",$J
 . S RESULT=$$CHECKIN(VPSCLIN,VPSDT,VPSCIEN)
 . D AFTER^SDAMEVT(.SDATA,DFN,VPSDT,VPSCLIN,VPSCIEN,SDCIHDL) ;CAPTURE CHECK-IN DATA IN ^TMP("SDAMEVT",$J
 . D EVT^SDAMEVT(.SDATA,4,1,SDCIHDL) ; 4 := ci evt ,  1:= computer monlogue   ;CALL EVT HANDLER
 . D HDLKILL^SDAMEVT ;CLEAR HANDLES
 . S VPSRES(VPSI)=VPSREC_"-"_RESULT
 Q
 ;
CHECKIN(CLIN,DTM,CIEN) ;update appropriate fields for check-in (HOSPITAL LOCATION file (#44)
 ;DIE call to actually check patient in
 ; ICR 5791 - update to 44.003,309
 ;Input:
 ; CLIN - clinic ien
 ; DTM - DATE/TIME of appt
 ; CIEN - entry to update with checkin time
 N VPSFDA,VERR,VPSRET
 N %,VPSNOW D NOW^%DTC S VPSNOW=%
 L +^SC(CLIN_",""S"","_DTM):3
 S VPSFDA(44.003,CIEN_","_DTM_","_CLIN_",",309)=VPSNOW  ; PATIENT multiple/APPOINTMENT multiple of HOSPITAL LOCATION file 
 D FILE^DIE("","VPSFDA","VERR")
 L -^SC(CLIN_",""S"","_DTM)
 I $D(VERR) S VPSRET="99-Appt could not be checked in"
 E  S VPSRET=1
 K VPSFDA,VERR
 Q VPSRET
 ;
