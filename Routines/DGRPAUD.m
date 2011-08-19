DGRPAUD ;BP/MJB - REGISTRATION CATASTROPHIC EDITS ;Compiled May 21, 2008 14:52:59
 ;;5.3;Registration;**750**;Aug 13, 1993;Build 6
 ;This routine will be called by DGRPECE if a change is made to patient name, ssn, dob, and sex.
 ;It will will get patient information from the audit file for comparisons.
 ;DGIEN-Audit file IEN(S) for patient
 ;DGAUDZRO-zero node of the audit file
 ;DGDT-date in audit file
 ;DGFLDNMR=field number of change
 ;DGOPTION-option used to make the update
 ;DGCHG=check to verify if a change was made
 ;
DGAUD(DFN,DGCNT) ;SET AUDITS FOR PATIENT
 N DGI,DGIEN,DGAUDIEN,DGAUDZRO,DGFLDNBR,DGOPTION,DGPTIEN,DGDT,DGCHG,DGTM,DGTODAY
 K ^TMP("DGRPAUD")
 S DGI=0,DGAUDZRO=0,U="^"
 S DGTODAY=$P($$NOW^XLFDT(),".")
 F  S DGI=$O(^DIA(2,"B",DFN,DGI)) Q:'DGI  D  ;Get all audit IENS for patient.
 .S DGIEN(DGI)=DGI
 .S DGAUDZRO=$G(^DIA(2,DGIEN(DGI),0))  ;get zero node for all audits
 .I 'DGAUDZRO Q
 .S DGDT=$P(DGAUDZRO,"^",2),DGTM=$P(DGDT,".",1)
 .I DGTODAY'=DGTM Q  ;only get todays audits
 .S DGFLDNBR=$P(DGAUDZRO,"^",3)
 .;get only NAME(.01),SEX(.02),DOB(.03),SSN(.09) for catastrophic edit checks
 .I DGFLDNBR'=".01"&(DGFLDNBR'=".02")&(DGFLDNBR'=".03")&(DGFLDNBR'=".09") Q
 .S DGOPTION=$P($G(^DIA(2,DGIEN(DGI),4.1)),U)
 .I 'DGOPTION Q
 .S DGCHG=$G(^DIA(2,DGIEN(DGI),2)) ;Check to see if change was made
 .I '$D(DGCHG)!(DGCHG="") Q
 .S DGPTIEN=$P(DGAUDZRO,U)
 .;set data into a temp global to be used by DGRPECE for changes
 .;this temp global will show changes that are currently in the audit file for this patient
 .;piece 1 - date and time of change
 .;piece 2 - changed field
 .;piece 3 - option used to change
 .;piece 4 - previous field value
 .;piece 5 - new field value
 .S ^TMP("DGRPAUD",$J,DFN,DGIEN(DGI))=$P(DGAUDZRO,U,2)_"^"_DGFLDNBR_"^"_DGOPTION_"^"_$G(^DIA(2,DGIEN(DGI),2))_"^"_$G(^DIA(2,DGIEN(DGI),3))_"^"_$P(DGAUDZRO,U,5)
 ;
 N DGAUDIEN
 S DGAUDIEN=0
 F   S DGAUDIEN=$O(^TMP("DGRPAUD",$J,DFN,DGAUDIEN)) Q:'DGAUDIEN  D
 .S DGCNT=DGCNT+1
 Q
