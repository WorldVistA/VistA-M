DGPREBJ1 ;ALB/SCK/EG/PC - PreRegistration Background job cont. ;Jul 25, 2019@14:53
 ;;5.3;Registration;**109,568,585,980**;Aug 13, 1993;Build 4
 Q
 ;
EN ; Interactive entry (from option)
 ; Variables
 ;    DGPTOD   - Todays date from DT  
 ;    DGPNL    - No. of lines in message array
 ;    DGPTXT   - Message array from ADDNEW procedure 
 ;    DGPP     - Default date to look for appointments
 ;    I1,X1-2  - Local variables  for counters and date manipulation
 ;
 I '$D(^XUSEC("DGPRE SUPV",DUZ)) D  G ENQ
 . W !!,"You do not have the DG PREREGISTRATION Key allocated, contact your MAS ADPAC."
 ;
 N DGPDT,DGPTOD,DGPNL,DGPTXT,DGPP,I1,X,X1,X2,Y
 S X1=$P($$NOW^XLFDT,"."),X2=$P($G(^DG(43,1,"DGPRE")),U,5) S:X2']"" X2=14
 S DGPP=$$FMADD^XLFDT(X1,X2)
 S DIR("B")=$$FMTE^XLFDT(DGPP,1)
 S DIR(0)="DA^::EX",DIR("A")="Enter Appointment date to search: "
 D ^DIR K DIR
 G:$D(DIRUT) ENQ
 S DGPNL=0,DGPTOD=DT,DGPDT1=Y
 D WAIT^DICD
 D SDAMAPI(1,DGPDT1)
 D ADDNEW(1,DGPDT1)
 I $D(DGPTXT) W !!,"Results of updating the Call List with new entries",!
 S I1=0 F  S I1=$O(DGPTXT(I1)) Q:'I1  W !,DGPTXT(I1)
ENQ K DIRUT,DUOUT,DTOUT,DIROUT,DGARRAY,SCDNT,^TMP($J,"SDAMA301")
 Q
 ;
ADDNEW(DGPREI,DGPDT1) ;  Searches for appointments to add to the Call List
 ;   Variables
 ;     Input:
 ;        DGPREI  -  Flag indicating how the procedure was called.
 ;                   0 - called by background job
 ;                   1 - called by option (interactive)
 ;        DGPDT1  -  Date to look for appointments, Required when
 ;                   DGPREI = 1
 ;
 ;     DGPDW   - Day of the week
 ;     DGPNDY  - Number of days ahead to look for appt.
 ;     DGPDT   - Date to look for appt. ( DT + DGPNDY)
 ;     DGPTOT  - Counter, total records scanned
 ;     DGPPT   - Pointer to patient file, #2
 ;     DGPTDTH - Counter for patient alias's found
 ;     DGPEXCL - Exclude flag
 ;     DGPTCE  - Counter of appts. excluded because of clinic
 ;     DGPTPE  - Counter of appts. excluded because of eligibility 
 ;     DGPINP  - counter of appts. excluded because of inpatient
 ;     DGPTNC  - Counter of appts. excluded because next appt. is within
 ;               DAYS BETWEEN CALLS entry in the MAS PARAMETER File
 ;     DGPADD  - Counter, entries added to call list
 ;     DGPAPT  - Date and time off appointment
 ;     DGPPRDT - Date pre-registration audit file last updated for patient
 ;     DGPNDTW - DAYS BETWEEN CALLS value
 ;     DGPSV   - Medical Service code
 ;     DGPPN   - Patients Name
 ;     DGPPH   - Patients Phone number
 ;     DGPSN   - Patients last four
 ;     DGPN1-5 - Temporary variables for $O
 ;
 ; Check for Appointment Database Availability
 ;if there is no lower level data from the 101 subscript, then it
 ;really is a valid error, otherwise, it could be a patient
 ;or clinic eg 01/20/2005
 I $D(^TMP($J,"SDAMA301")) I $D(^TMP($J,"SDAMA301",101))=1 D SETTEXT^DGPREBJ("SDAMAPI - Appointment Database is Unavailable."),SETTEXT^DGPREBJ("Unable to update Call List.") Q
 ;
 N DGPADD,DGPTOT,DGPTCE,DGPTPE,DGPTNC,DGPTDTH,DGPINP,DGPUPD,DGPN1,DGPAPT
 N DGPPH,DGPDW,DGPPT,DGPPRDT,DGPNDTW,DGPN5,DGPEXCL,CKAPDT
 S (DGPADD,DGPTOT,DGPTCE,DGPTPE,DGPTNC,DGPTDTH,DGPINP,DGPUPD)=0
 S DGPN1=0 F  S DGPN1=$O(^TMP($J,"SDAMA301",DGPN1)) Q:'DGPN1  D
 .S DGPPT=0 F  S DGPPT=$O(^TMP($J,"SDAMA301",DGPN1,DGPPT)) Q:'DGPPT  D
 ..S CKAPDT=+$O(^TMP($J,"SDAMA301",DGPN1,DGPPT,DGPDT1))
 ..Q:('CKAPDT!(CKAPDT>$$FMADD^XLFDT(DGPDT1,1)))
 ..S DGPTOT=DGPTOT+1
 ..I $P($G(^DPT(DGPPT,.35)),U)]"" S DGPTDTH=DGPTDTH+1 Q
 ..; ***  Check for clinic exclusions in MAS PARAMETER File
 ..S (DGPN5,DGPEXCL)=0
 ..F  S DGPN5=$O(^DG(43,1,"DGPREC",DGPN5)) Q:'DGPN5!(DGPEXCL)  D
 ...S:$P(^DG(43,1,"DGPREC",DGPN5,0),U)=DGPN1 DGPEXCL=1
 ..I DGPEXCL S DGPTCE=DGPTCE+1 Q
 ..; *** Check for eligibility exclusions inthe MAS PARAMETER File
 ..N DGPAELG S (DGPN5,DGPEXCL)=0
 ..F  S DGPN5=$O(^DG(43,1,"DGPREE",DGPN5)) Q:'DGPN5!(DGPEXCL)  D
 ...S DGPAELG=$P($G(^DPT(DGPPT,.36)),U)
 ...S:$P(^DG(43,1,"DGPREE",DGPN5,0),U)=DGPAELG DGPEXCL=1
 ..I DGPEXCL S DGPTPE=DGPTPE+1 Q
 ..; ***  Check for inpatient status
 ..K DFN S DFN=DGPPT D INP^VADPT
 ..I $G(VAIN(1))]"" S DGPINP=DGPINP+1 Q
 ..; *** Check for last update in Pre-Registration Audit file
 ..S DGPPRDT=DGPTOD+.9999,DGPPRDT=$O(^DGS(41.41,"ADC",DGPPT,DGPPRDT),-1)
 ..S DGPNDTW=$P($G(^DG(43,1,"DGPRE")),U,2)
 ..I DGPPRDT]""&(DGPNDTW]"") I $$FMDIFF^XLFDT(DGPDT,DGPPRDT,1)<DGPNDTW S DGPTNC=DGPTNC+1 Q 
 ..; *** Set up entries for adding to Pre-Registration Call List file
 ..K DFN S DFN=DGPPT D DEM^VADPT
 ..S DGPPH=$P($P($G(^DPT(DGPPT,.13)),U),"~")
 ..I DGPPH=""!(DGPPH["NO") D
 ...S DGPPH=$P($G(^DPT(DGPPT,.33)),U,9)
 ...I DGPPH]"" S DGPPH=$P(DGPPH,"~")_"(E)"
 ... E  S DGPPH="NO PHONE"
 ..;
 ..I '$D(^DGS(41.42,"B",DFN)) D
 ...K DD,DO S DIC="^DGS(41.42,",DIC(0)="ML"
 ...S X=DFN,DGPAPT=$O(^TMP($J,"SDAMA301",DGPN1,X,DGPDT1))
 ...S DIC("DR")=$P($T(FIELDS),";;",2)
 ...D FILE^DICN
 ...S DGPADD=DGPADD+1
 ..E  D
 ...S DA="",DA=$O(^DGS(41.42,"B",DFN,DA),-1)
 ...Q:$P($G(^DGS(41.42,DA,0)),U,6)="Y"
 ...S DIE="^DGS(41.42,"
 ...S DGPAPT=$O(^TMP($J,"SDAMA301",DGPN1,DGPPT,DGPDT1))
 ...S DR=$P($T(FIELDS),";;",2)
 ...D ^DIE
 ...S DGPUPD=DGPUPD+1
 ..K DA,DR,DIE,DIC,VADM,VA,DFN,VAERR,VAIN
 ;
 D SETTEXT^DGPREBJ("      Total Entries Scanned: "_DGPTOT)
 D SETTEXT^DGPREBJ("  Called within Time Window: "_DGPTNC)
 D SETTEXT^DGPREBJ("                 Inpatients: "_DGPINP)
 D SETTEXT^DGPREBJ("       Exclusions by Clinic: "_DGPTCE)
 D SETTEXT^DGPREBJ("  Exclusions by Eligibility: "_DGPTPE)
 D SETTEXT^DGPREBJ("        Exclusion for Death: "_DGPTDTH)
 D SETTEXT^DGPREBJ(" ")
 D SETTEXT^DGPREBJ("    Total Entries Added to Call List: "_DGPADD)
 D SETTEXT^DGPREBJ("Total Entries Updated with New Appt.: "_DGPUPD)
 D SETTEXT^DGPREBJ(" ")
EXIT ;
 Q
SDAMAPI(DGPREI,DGPDT1) ;
 ; Input: DGPDT1 - Date to look for appointments
 ;
 N DGPNDY S DGPNDY=$P($G(^DG(43,1,"DGPRE")),U,5)
 I DGPNDY']"" D  G EXIT
 . W:DGPREI !!,$P($T(MSG1),";;",2)
 . D:'DGPREI SETTEXT^DGPREBJ($P($T(MSG1),";;",2)),SETTEXT^DGPREBJ("  ")
 ;
 I DGPREI S DGPDT=DGPDT1
 E  S DGPDT=$$FMADD^XLFDT(DT,DGPNDY)
 ;eg 01/18/2005 if coming from night job tax ('DGPREI)
 ;and end date (DGPDT) is on a weekend, and the parameter
 ;says to not run on weekend, it will never go find appointments
 S DGPDW=$S(DGPREI:$$DOW^XLFDT(DGPDT),1:$$DOW^XLFDT(DT))
 I $P($G(^DG(43,1,"DGPRE")),U,6)'=1&((DGPDW=6)!(DGPDW=0)) D  G EXIT
 . W:DGPREI !!,$P($T(MSG2),";;",2)
 . D:'DGPREI SETTEXT^DGPREBJ($P($T(MSG2),";;",2)),SETTEXT^DGPREBJ("  ")
 D SETTEXT^DGPREBJ("Running: Add New Patients to Call List for "_$$FMTE^XLFDT(DGPDT,2)),SETTEXT^DGPREBJ(" ")
 ;
 N DGARRAY,SDCNT
 S:DGPREI DGARRAY(1)=DGPDT1_";"_DGPDT1
 S:'DGPREI DGARRAY(1)=DT_";"_DGPDT
 S DGARRAY("FLDS")=3,SDCNT=$$SDAPI^SDAMA301(.DGARRAY)
 Q
 ; VSR patch DG*5.3.980 change four slashes to three slashes for validation.  Changed field 5
FIELDS ;;.1///^S X=$P($G(^SC(DGPN1,0)),U,15);1///^S X=$E(VADM(1))_VA("BID");2///^S X=DGPPH;3///^S X=$G(DGPPRDT);5///^S X=DGPN1;6///^S X=DGPAPT;7///^S X=$P(^SC(DGPN1,0),U,8)
 ;
MSG1 ;;The 'DAYS TO PULL' is not filled in, unable to determine appointment date.
MSG2 ;;The call list is currently not being generated for weekends.
