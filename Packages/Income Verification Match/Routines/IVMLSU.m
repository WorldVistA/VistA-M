IVMLSU ;ALB/MLI/KCL - IVM SSA/SSN UPLOAD ; 28-MAY-93
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;**2**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will be used to upload SSN's for a veteran and/or
 ; the veteran's spouse.  These SSN's were suggested by SSA after
 ; checking the date of birth, sex, and name of the person.  They
 ; are not automatically uploaded, but allow the user to upload
 ; or purge them if they so choose.
 ;
EN ; - Main entry point for IVML SSN UPDATE
 D BLD
 ;
 ; - if no entries exist in "ASEG" x-ref Quit
 I IVMCT=0 G EXIT
 D EN^VALM("IVM SSN UPDATE")
 Q
 ;
 ;
BLD ; - Build array of patients with suggested SSN's for uploading
 N IVMI,IVMJ
 S IVMCT=0
 K ^TMP("IVMUP",$J)
 W !,"Building list for display..."
 ;
 ; - change if HL7 seg sep ever changes!
 S HLFS="^"
 ;
 ; - get records from 'ASEG' x-ref
 S IVMI=0 F  S IVMI=$O(^IVM(301.5,"ASEG","ZIV",IVMI)) Q:'IVMI  D
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,"ASEG","ZIV",IVMI,IVMJ)) Q:'IVMJ  D
 ..S IVMSP="",IVMCT=IVMCT+1 W:'(IVMCT#15) "."
 ..S IVM0ND=$G(^IVM(301.5,IVMI,0)) I IVM0ND']"" Q
 ..S IVMSEG=$G(^IVM(301.5,IVMI,"IN",IVMJ,"ST")) I IVMSEG']"" Q
 ..S DFN=+IVM0ND,IVMDPT0=$G(^DPT(+DFN,0)) I IVMDPT0']"" Q
 ..;
 ..; - check for 'date of death' in Patient (#2) file or ZIV segment
 ..S IVMDOD=$S($P($G(^DPT(+DFN,.35)),"^")]"":"D"_$P($G(^DPT(+DFN,.35)),"^"),$P(IVMSEG,HLFS,12)]"":"I"_$$FMDATE^HLFNC($P(IVMSEG,HLFS,12)),1:"")
 ..;
 ..; - patient name and SSN in Patient (#2) file
 ..S IVMNM=$P(IVMDPT0,"^",1),IVMSSN=$P(IVMDPT0,"^",9)
 ..;
 ..; - if new spouse SSN and Patient Relation IEN, get Patient or
 ..;   Income person zeroth node
 ..I $P(IVMSEG,HLFS,6),$P(IVMSEG,HLFS,7) S IVMSP=$$DEM^DGMTU1(+$P(IVMSEG,HLFS,7))
 ..; - build line for display
 ..D BLDLN
 ;
 I IVMCT=0 W !!,"There is no IVM patient data to be uploaded at this time.",!,*7
 ;
BLDQ K DFN,IVM0ND,IVMBL,IVMDOD,IVMDPT0,IVMSEG,IVMSP
 Q
 ;
 ;
BLDLN ; - Build storage array with data for view in list man (called from BLD)
 N X
 ; - if DHCP SSN is does not equal IVM SSA/SSN do
 I $P(IVMDPT0,"^",9)'=$P(IVMSEG,"^",4) D
 .;
 .; - X = vet name, dhcp/ssn, ssa/ssn
 .S X=IVMNM_"^"_IVMSSN_"^"_$P(IVMSEG,"^",4)
 .;
 .; - if spouse DHCP SSN does not equal IVM SSA/SSN set ^TMP array
 .I IVMSP]"",$P(IVMSP,"^",9)'=$P(IVMSEG,"^",6) D  ; get spouse name, dhcp/ssn, ssa/ssn
 ..;
 ..; - patient data_spouse data
 ..S X=X_"^"_$P(IVMSP,"^",1)_"^"_$P(IVMSP,"^",9)_"^"_$P(IVMSEG,"^",6)
 .;
 .; - ^tmp("ivmup",$j,pt name,pt ssn,ivm ien)=dfn^spien^display elements
 .S ^TMP("IVMUP",$J,IVMNM,IVMSSN,IVMI,IVMJ)=DFN_"^"_+$P(IVMSEG,HLFS,7)_"^"_IVMDOD_"^"_X
 ;
 ;
 ; - if patient DHCP SSN equals IVM SSA/SSN and spouse DHCP SSN does not
 ;   equal IVM SSA/SSN set ^TMP array
 I $P(IVMDPT0,"^",9)=$P(IVMSEG,"^",4),IVMSP]"",($P(IVMSP,"^",9)'=$P(IVMSEG,"^",6)) D
 .;
 .; - vet name, DHCP/SSN - SSA/SSN is not displayed
 .S X=IVMNM_"^"_IVMSSN_"^"
 .;
 .; - spouse name, DHCP/SSN, IVM SSA/SSN 
 .S X=X_"^"_$P(IVMSP,"^",1)_"^"_$P(IVMSP,"^",9)_"^"_$P(IVMSEG,"^",6)
 .;
 .; - ^tmp("ivmup",$j,pt name,pt ssn,ivm ien)=dfn^spien^display elements
 .S ^TMP("IVMUP",$J,IVMNM,IVMSSN,IVMI,IVMJ)=DFN_"^"_+$P(IVMSEG,HLFS,7)_"^"_IVMDOD_"^"_X
 Q
 ;
 ;
EXIT ; - Exit code - kill temporary arrays
 K ^TMP("IVMLST",$J),^TMP("IVMUP",$J),IVMCT
 Q
