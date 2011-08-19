DGRUDD01 ;ALB/SCK - Data Dictionary Utilities MDS COTS update ;8-10-99
 ;;5.3;Registration;**190**;Aug 13, 1993
 ;
ADGRU(DFN) ; ADGRU* cross reference for Patient File (#2)
 ;
 ;  Input  : DFN   - Pointer to entry in PATIENT File (#2)
 ;
 ;  Output : None
 ;
 ;  Note:  The ADGRU* cross references are used to remember that changes
 ;         were made to the PATIENT File(#2) outside of the Registration
 ;         Process.  Execution of this cross reference will mark an entry
 ;         in the ADT/HL7 PIVOT file (#391.71) and mark it as requiring
 ;         transmission on an HL7 ADT-A08 message.
 ;
 ;         Execution of this cross reference can be prevented by setting
 ;         the local variable DGRUGA08 equal to 1
 ;
 ;         This cross reference is intended for notifing the Resident
 ;         Assessment Instrument COTS database of a demographic change
 ;         to a patients data.
 ;
 ; Check Input
 I +$G(DFN),$D(^DPT(DFN,0))
 E  Q
 ;
 N VARPTR,PIVOTNUM,DGRU,VAFHDT,VAROOT
 ;
 ; Check for flag
 Q:$G(DGRUGA08)
 ; Test for HL7 ADT on/off parameter
 Q:'$P($$SEND^VAFHUTL(),"^",2)
 ; Test for Inpatient status on TODAY, if patient is not an inpatient today
 ; then quit any further processing.
 S VAROOT="DGRU",VAFHDT=$$DT^XLFDT
 D INP^VADPT
 ; check admission date and ward location for inpatient status
 I '(+DGRU(1)),'(+DGRU(4)) Q
 ; check for ward flagged as RAI/MDS ward.
 Q:'$$CHKWARD^DGRUUTL(+DGRU(4))
 ; All checks passed
 ; Check for change to SSN.  If the SSN has changed, then we need to  process
 ; the SSN change differently through the RAI MONITOR file rather than using
 ; the pivot file.
 ;
 N DGOK
 S DGSNOLD=$P($G(D),"^",9)
 S DGSNNEW=$P($G(DV),"^",9)
 I +DGSNNEW>0&(+DGSNOLD>0) D  Q:$G(DGOK)
 . I DGSNOLD'=DGSNNEW D  Q
 .. N DGX S DGX=$O(^DGRU(46.11,"B",DGSNNEW,0))
 .. Q:$G(DGX)>0
 .. N FDA
 .. S FDA(1,46.11,"+1,",.01)=DGSNNEW
 .. S FDA(1,46.11,"+1,",.02)=DGSNOLD
 .. S FDA(1,46.11,"+1,",.03)=2
 .. S FDA(1,46.11,"+1,",.04)=DFN
 .. D UPDATE^DIE("E","FDA(1)")
 .. S DGOK=1
 ;
 ; Create entry in pivot file
 D PVT4A08(DFN)
 ;
 I PIVOTNUM<0 Q
 D XMITFLAG^VAFCDD01(0,PIVOTNUM)
 ;
 Q
 ;
PVT4A08(DFN) ; Create an entry in the ADT/HL7 PIVOT file for a patient demographic
 ; update event and mark it for transmission
 ;
 ;  Input   :  DFN - pointer to entry in PATIENT File (#2)
 ;
 ;  Output  :  None
 ;
 ; Check input
 I +$G(DFN),$D(^DPT(DFN,0))
 E  Q
 ;
 S VARPTR=DFN_";DPT("
 ;
 S PIVOTNUM=+$$PIVNW^VAFHPIVT(DFN,$P(DT,"."),6,VARPTR)
 Q:(PIVOTNUM<0)
 ;
 ; Mark entry as requires transmission
 I $G(DGRUGA08),$P($$SEND^VAFHUTL(),"^",2) D XMITFLAG^VAFCDD01(0,PIVOTNUM)
 ; Mark entry as transmitted field YES
 ;I $G(DGRUGA08),$$SEND^VAFHUTL() S SETFLAG^VAFCDD01(0,PIVOTNUM)
 Q
