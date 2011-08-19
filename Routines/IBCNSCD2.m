IBCNSCD2 ;ALB/CPM - DELETE INSURANCE COMPANY (CON'T) ; 03-FEB-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28,46**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; 
MAIL ; Send results out.
 S XMSUB="Insurance Company Deletion Clean-up Completion"
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="^TMP($J,""IBT"",",XMY(DUZ)=""
 ;
 K ^TMP($J,"IBT") S IBC=0
 D SET("The final clean-up for deleted Insurance Company(s) has completed.")
 D SET(" ")
 S Y=IBBDT D D^DIQ D SET("Job Start Time: "_Y)
 S Y=IBEDT D D^DIQ D SET("  Job End Time: "_Y)
 ;
 D SET(" ")
 D SET("DELETED COMPANY"_$J("",24)_"REPOINTED TO")
 D SET($TR($J("",79)," ","="))
 S IBX=0 F  S IBX=$O(^TMP($J,"IBCNSCD",IBX)) Q:'IBX  S IBX1=+$G(^(IBX)) D
 .S X=$E($P($G(^DIC(36,IBX,0)),"^")_" (#"_IBX_")"_$J("",39),1,39)
 .S X=X_$S(IBX1:$P($G(^DIC(36,IBX1,0)),"^")_" (#"_IBX1_")",1:"not repointed")
 .D SET(X)
 ;
 D SET(" ")
 D SET(" ")
 D SET("1. Correction of the Disposition (sub-file #2.101) field")
 D SET("   'INJURING PARTIES INSURANCE' (#25)")
 D SET("     Number of Disposition records updated: "_+$G(IBCT("DIS")))
 I $O(IBCT("DIS",0)) D
 .D SET($J("",8)_"The following dispositions had this field deleted and not merged:")
 .S DFN=0 F  S DFN=$O(IBCT("DIS",DFN)) Q:'DFN  D
 ..S IBNAM=$$PT^IBEFUNC(DFN),IBH=0
 ..S IBX=$J("",10)_$E($P(IBNAM,"^"),1,25)_" ("_$P(IBNAM,"^",3)_")"
 ..S IBDAT="" F  S IBDAT=$O(IBCT("DIS",DFN,IBDAT)) Q:IBDAT=""  D
 ...S IBDAT1="Date/Time: "_$$DAT2^IBOUTL(9999999-IBDAT)
 ...I 'IBH D SET($E(IBX_$J("",45),1,45)_IBDAT1)
 ...E  D SET($J("",45)_IBDAT1)
 ...S IBH=1
 ;
 ; - insurance companies
 S IBINS(0)="REPOINT PATIENTS TO^.16"
 S IBINS(.12)="CLAIMS (INPT) COMPANY NAME^.127"
 S IBINS(.13)="PRECERT COMPANY NAME^.139"
 S IBINS(.14)="APPEALS COMPANY NAME^.147"
 S IBINS(.16)="CLAIMS (OPT) COMPANY NAME^.167"
 S IBINS(.18)="CLAIMS (RX) COMPANY NAME^.187"
 D SET(" ")
 D SET("2. Correction of other Insurance Company (file #36) records:")
 S IBX="" F  S IBX=$O(IBINS(IBX)) Q:IBX=""  S IBS=IBINS(IBX) D
 .D SET("     Number of records with '"_$P(IBS,"^")_"' (#"_$P(IBS,"^",2)_") updated: "_+$G(IBCT("INS",IBX)))
 .I $O(IBCT("INS",IBX,0)) D
 ..D SET($J("",8)_"The following companies had this field deleted and not merged:")
 ..S IBCO=0 F  S IBCO=$O(IBCT("INS",IBX,IBCO)) Q:'IBCO  D
 ...D SET($J("",10)_$P($G(^DIC(36,IBCO,0)),"^")_"  (ien "_IBCO_")")
 ;
 ; - insurance reviews
 D SET(" ")
 D SET("3. Correction of the Insurance Review (file #356.2) field")
 D SET("   'INSURANCE COMPANY CONTACTED' (#.08)")
 D SET("     Number of Insurance Review records updated: "_+$G(IBCT("IR")))
 I $O(IBCT("IR",0)) D
 .D SET($J("",8)_"The following Insurance reviews had this field deleted and not merged:")
 .S DFN=0 F  S DFN=$O(IBCT("IR",DFN)) Q:'DFN  D
 ..S IBNAM=$$PT^IBEFUNC(DFN),IBH=0
 ..S IBX=$J("",10)_$E($P(IBNAM,"^"),1,25)_" ("_$P(IBNAM,"^",3)_")"
 ..S IBDAT="" F  S IBDAT=$O(IBCT("IR",DFN,IBDAT)) Q:IBDAT=""  D
 ...S IBDAT1="Review Date/Time: "_$$DAT2^IBOUTL(IBDAT)
 ...I 'IBH D SET($E(IBX_$J("",45),1,45)_IBDAT1)
 ...E  D SET($J("",45)_IBDAT1)
 ...S IBH=1
 ;
 ; - bills
 K IBINS
 S IBINS(1)="PRIMARY INSURANCE CARRIER^101"
 S IBINS(2)="SECONDARY INSURANCE CARRIER^102"
 S IBINS(3)="TERTIARY INSURANCE CARRIER^103"
 D SET(" ")
 D SET("4. Correction of Bill/Claims (file #399) records:")
 S IBX="" F  S IBX=$O(IBINS(IBX)) Q:IBX=""  S IBS=IBINS(IBX) D
 .D SET("     Number of records with '"_$P(IBS,"^")_"' (#"_$P(IBS,"^",2)_") updated: "_+$G(IBCT("BL",IBX)))
 .I $O(IBCT("BL",IBX,0)) D
 ..D SET($J("",8)_"The following bills had this field deleted and not merged:")
 ..S IBCO=0 F  S IBCO=$O(IBCT("BL",IBX,IBCO)) Q:'IBCO  D
 ...S IBS=$G(^DGCR(399,IBCO,0))
 ...S IBNAM=$$PT^IBEFUNC(+$P(IBS,"^",2))
 ...D SET($J("",10)_$E($E($P(IBNAM,"^"),1,25)_" ("_$P(IBNAM,"^",3)_")"_$J("",35),1,35)_"Bill #: "_$P(IBS,"^"))
 ;
 ; - receivables in AR
 D SET(" ")
 D SET("5. Number of updated secondary and tertiary carriers of AR receivables: "_+$G(IBCTAR))
 ;
 D ^XMD
 K ^TMP($J,"IBT")
 Q
 ;
SET(X) ; Set Message Text Array
 S IBC=IBC+1,^TMP($J,"IBT",IBC)=X
 Q
