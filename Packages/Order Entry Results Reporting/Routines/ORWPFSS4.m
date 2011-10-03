ORWPFSS4 ;SLC-GDU CPRS HL7 PROCESSING FOR RAD PRE-CERT;[08/29/05];
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**228**;Dec 17, 1997
 ;Determine if the order is to have an PFSS Account Reference
 ;associated with it. This is for orders that are not event delayed
 ;
 ;DBIA References for external calls
 ; $$GETS^DIQ         - DBIA 2056 
 ; $$GETS1^DIQ        - DBIA 2056
 ; $$PKGTYP^ORWPFSS   - Internal to CPRS PFSS
 ; PFSSACTV^ORWPFSS   - Internal to CPRS PFSS
 ; $$ACCTREF^ORWPFSS1 - Internal to CPRS PFSS
 ; $$GETARN^SDPFSS2   - DBIA 4668
 ; INP^VADPT          - DBIA 10061
 ; ^VSIT              - DBIA 1900-A
 ;
EN(ORIEN) ;Primary entry point of this routine
 ;Input Variable
 ; ORIEN    The Order Internal Entry Number
 ;Local Variables
 ; ORAR        Order Account Reference (PFSS AR)
 ; ORDFN       Order Patient's DFN (IEN)
 ; ORPFSS      Order PFSS Active Indicator
 ; ORUPDT      Order Update Indicator from record update
 ; ORVS        Order Visit String
 ;
 N ORAR,ORDFN,ORPFSS,ORUPDT,ORVS,X,Y
 S (ORAR,ORPFSS)=""
 ;If PFSS is inactive goto exit
 D PFSSACTV^ORWPFSS(.ORPFSS) I ORPFSS=0 G EXIT
 ;If Order already has PFSS Account Reference goto exit
 S ORAR=$$GET1^DIQ(100,ORIEN,97) I ORAR'="" G EXIT
 ;If Order package is not one of the currently supported goto exit
 I $$PKGTYP^ORWPFSS(ORIEN)=0 G EXIT
 ;If Visit String not found goto EXIT.
 S ORVS=$$GETVS(ORIEN) I ORVS="" G EXIT
 ;Get Patient's DFN from the Order
 S ORDFN=+$$GET1^DIQ(100,ORIEN,.02,"I")
 ;If Historical set PFSS Account Reference to null and goto Save
 I $P(ORVS,";",3)="E" S ORAR="" G SAVE
 ;If Scheduled Appointment get PFSS Account Reference and goto Save
 I $P(ORVS,";",3)="A" S ORAR=$$SAAR(ORVS,ORDFN) I ORAR'="" G SAVE
 ;If Hospital Admission get PFSS Account Reference and goto Save
 I $P(ORVS,";",3)="H" S ORAR=$$HAAR(ORDFN) I ORAR'="" G SAVE
 ;Check PCE for PFSS Account Reference
 S ORAR=$$PCEAR(ORVS,ORDFN)
SAVE ;Save PFSS Account Reference or null value to the Order record
 S ORUPDT=$$ACCTREF^ORWPFSS1(ORIEN,ORAR)
EXIT ;Exit point for this routine
 Q
GETVS(X1) ;Get Order Visit String
 ;Get the data from the Order's Responses multi-valued field.
 ;Look for Prompt text of OR GTX VISITSTR
 ;If Prompt text found get the Visit String
 ;If Prompt text not found return a null value
 ;Input variable required, if missing this will return a null value
 ;Input Variable for this function
 ; X1    The Order IEN
 ;Return Variable for this function
 ; VS    The Order Visit String
 ;Local Variable for this function
 ; IENS  Index variable for REC array
 ; PT    Prompt Text being searched for
 ; REC   Output variable for GETS^DIQ that will contain the Order
 ;       Responses data.
 N IENS,PT,REC,VS
 I X1="" S VS="" Q VS
 S (IENS,VS)=""
 S PT=$P($T(VSPT),";",3)
 D GETS^DIQ(100,X1,"4.5*","E","REC")
 F  S IENS=$O(REC(100.045,IENS)) Q:IENS=""  D
 . I $G(REC(100.045,IENS,.02,"E"))=PT S VS=$G(REC(100.045,IENS,1,"E"))
 Q VS
VSPT ;Visit String Prompt Text;OR GTX VISITSTR
 ;
SAAR(X1,X2) ;Scheduled Appointment Account Reference for PFSS
 ;Get the PFSS Account Reference for scheduled appointments
 ;All inputs required, any missing this will return a null value
 ;Input Variables
 ; X1    The Visit String from the Order 
 ; X2    The Patient's IEN
 ;Output Variable
 ; AR    PFSS Account Reference returned by $$GETARN^SDPFSS2
 ;       Set to null in any input is missing
 ;
 N AR
 I X1=""!(X2="") S AR="" Q AR
 ;Get the PFSS Account Reference from Scheduling
 S AR=+$$GETARN^SDPFSS2($P(X1,";",2),X2,$P(X1,";"))
 I AR>0 Q AR      ;If found return Account Reference
 S AR="" Q AR     ;If not found return null for Account Reference
 ;
HAAR(X1) ;Hospital Admission Account Reference for PFSS
 ;Returns the PFSS Account Reference for the Hospital Admission
 ;Input is required. If missing null value returned.
 ;Returns PFSS Account Reference returned if found.
 ;Returns null if PFSS Account Reference not found null.
 ;Input Variable for this function
 ; X1    The Patient's DFN
 ;Output Variables for this function
 ; ER    Set to null and returned if missing input
 ; VAIN("NR") The node of VAIN that contains the PFSS Account Reference
 ;Internal Variables for this function
 ; DFN   VADPT input variable, Patient's record number
 ; VAHOW VADPT input variable, sends output to array variable VAIN
 ; VAIN  Output array variable with results of INP^VAIN
 ;
 N ER,DFN,VAHOW,VAIN
 I X1="" S ER="" Q ER
 S DFN=X1
 S VAHOW=1
 D INP^VADPT
 Q $G(VAIN("NR"))
 ;
PCEAR(X1,X2) ;PCE Account Reference for PFSS
 ;Returns the PFSS Account Reference from PCE
 ;All input required, if any missing this will a null.
 ;Returns PFSS Account Reference returned if found.
 ;Returns null if PFSS Account Reference not found null.
 ;Input Variable for this function
 ; X1    The Visit String from the Order
 ; X2    The Patient's IEN
 ; VSIT  The input and output array variable for ^VSIT
 ;Output Variables for this function
 ; ER    Set to null and returned if missing input
 ; VSIT("ACT") The node of array variable VSIT that contains
 ;       the PFSS Account Reference returned by ^VSIT
 ;Local Variable for this function
 ; VSIT  The input and output array variable for ^VSIT
 ;
 N ER,VSIT
 I X1=""!(X2="") S ER="" Q ER
 S VSIT(0)="D0EM"
 S VSIT("VDT")=$P(X1,";",2)
 S VSIT("LOC")=$P(X1,";")
 S VSIT("PKG")="OR"
 S VSIT("PAT")=X2
 D ^VSIT
 I $G(VSIT("IEN"))<0 S ER="" Q ER
 Q $G(VSIT("ACT"))
