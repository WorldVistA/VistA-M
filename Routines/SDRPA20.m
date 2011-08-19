SDRPA20 ;BPOI/ESW - Determine Admission Type for PAIT ;
 ;;5.3;Scheduling;**446**;Aug 13, 1993;Build 77
 ;
 ; This routine returns element Admission Type for appointment sent
 ; with PAIT - see TABLE SD009 - Purpose of Visit & Appointment Type
 ; SEQUENCE PV1.4. The same table is used with ACRP HL7 transmission.
 ; 
 ;
POV(DFN,SDATE,CLINIC,CRDATE) ; - Determine Purpose of Visit for encounter
 ;
 ;   Input:  DFN = Patient IEN
 ;          SDATE = Appointment Date/Time
 ;        CLINIC = Clinic
 ;        CRDATE = Creation date
 ;        
 ;  Identified from the Outpatient Encounter of the Appointment
 ;  subfile (# 2.98)
 ;  
 ;         APTYP = Appointment Type
 ;
 ;  Output:  Purpose of Visit value (combination of Purpose of Visit
 ;           and Appointment Type)
 ;
 ;
 N SDARRAY,SCDXPOV,SDAPPT,POV,APTYP,SDENC
 S SDARRAY(1)=SDATE_";"_SDATE
 S SDARRAY(4)=DFN
 S SDARRAY("FLDS")="2;10;12;16;18"
 ; fields: 2- clinic
 ;        10- appointment type
 ;        12- outpatient encounter
 ;        16 - date appt made        
 N SDCOUNT S SDCOUNT=$$SDAPI^SDAMA301(.SDARRAY)
 I '$D(^TMP($J,"SDAMA301",DFN,CLINIC,SDATE)) Q $G(SCDXPOV)
 S SDAPPT=^TMP($J,"SDAMA301",DFN,CLINIC,SDATE)
 N SDCRC S SDCRC=+$P(SDAPPT,U,16) I SDCRC'=CRDATE Q $G(SCDXPOV)
 N POV,SCDXPOV
 S POV=+$P(SDAPPT,U,18),POV=$S($L(POV)=1:"0"_POV,1:POV)
 S APTYP=+$P(SDAPPT,U,10) S SDENC=+$P(SDAPPT,U,12) I +SDENC>0 D  I 'APTYP Q $G(SCDXPOV)
 .S APTYP=$P($G(^SCE(SDENC,0)),U,10)
 S APTYP=$S($L(APTYP)=1:"0"_APTYP,1:APTYP)
 S SCDXPOV=POV_APTYP
POVQ Q $G(SCDXPOV)
 ;
