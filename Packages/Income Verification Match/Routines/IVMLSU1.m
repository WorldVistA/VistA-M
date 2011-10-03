IVMLSU1 ;ALB/MLI/KCL - IVM SSA/SSN UPLOAD DISPLAY LIST ; 07-JAN-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
INIT ; - Init variables and list array
 K ^TMP("IVMLST",$J)
 S IVMBL="",$P(IVMBL," ",30)="",IVMCT=0,IVMNM=""
 ;
 ; - sort by patient name
 F  S IVMNM=$O(^TMP("IVMUP",$J,IVMNM)) Q:IVMNM']""  S IVMSSN="" D
 .F  S IVMSSN=$O(^TMP("IVMUP",$J,IVMNM,IVMSSN)) Q:IVMSSN']""  S IVMI="" D
 ..F  S IVMI=$O(^TMP("IVMUP",$J,IVMNM,IVMSSN,IVMI)) Q:'IVMI  S IVMJ="" D
 ...F  S IVMJ=$O(^TMP("IVMUP",$J,IVMNM,IVMSSN,IVMI,IVMJ)) Q:'IVMJ  D
 ....S X=$G(^TMP("IVMUP",$J,IVMNM,IVMSSN,IVMI,IVMJ))
 ....S DFN=$P(X,"^",1),IVMSIEN=$P(X,"^",2)
 ....S IVMSTAR=$S($P(X,"^",3)]"":"*",1:" "),IVMLN=$P(X,"^",4,99)
 ....S IVMCT=IVMCT+1 D WRLINE(IVMLN,IVMCT)
 ....;
 ....; - set ^TMP("IVMLST" array for look-up
 ....S ^TMP("IVMLST",$J,"IDX",IVMCT,IVMCT)=IVMNM_"^"_IVMSSN_"^"_DFN_"^"_IVMSIEN_"^"_$P(X,"^",3)_"^"_IVMI_"^"_IVMJ
 ;
 S VALMCNT=IVMCT
 ;
INITQ K C,DFN,IVMBL,IVMCT,IVMI,IVMJ,IVMLN,IVMNM,IVMSIEN,IVMSSN,IVMSTAR
 Q
 ;
 ;
WRLINE(X,C) ; - Write line out
 ;
 ;  Input:  X as pt name^pt ssn^pt ssa ssn^sp name^sp ssn^sp ssa ssn
 ;          C as line number
 ; Output:  None
 ;
 N IVMLN
 ; - patient data
 S IVMLN=IVMSTAR_$E($P(X,"^",1)_IVMBL,1,14)_"  "_$E($P(X,"^",2)_IVMBL,1,11)_$E($P(X,"^",3)_IVMBL,1,11)
 ;
 ; - spouse data
 S IVMLN=IVMLN_$E($P(X,"^",4)_IVMBL,1,14)_"  "_$E($P(X,"^",5)_IVMBL,1,11)_$E($P(X,"^",6)_IVMBL,1,10)
 ;
 ; - highlight SSA/SSN for patient
 D CNTRL^VALM10(C,33,9,IOINHI,IOINORM)
 ; - highlight SSA/SSN for spouse
 D CNTRL^VALM10(C,71,9,IOINHI,IOINORM)
 ;
 ; - display list
 S @VALMAR@(C,0)=$E(C_"    ",1,4)_IVMLN
 Q
 ;
 ;
HDR ; - Header code
 S VALMHDR(1)="Income Verification Match                      Suggested SSA/SSNs for Uploading"
 S VALMHDR(2)="  (*) - Indicates Date of Death Reported"
 Q
