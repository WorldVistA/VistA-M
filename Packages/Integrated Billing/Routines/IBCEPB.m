IBCEPB ;ALB/WCJ - Insurance company ID parameters ;22-DEC-2005
 ;;2.0;INTEGRATED BILLING;**320,348,349,400,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
EN ; -- main entry point for IBCE INSCO ID MAINT
 D EN^VALM("IBCE INSCO ID MAINT")
 Q
 ;
HDR ; -- header code
 N PCF,PCDISP
 I '$D(IBCNS) N IBCNS S IBCNS=IBINS
 S PCF=$P($G(^DIC(36,+IBCNS,3)),U,13),PCDISP=$S(PCF="P":"(Parent)",1:"")
 S VALMHDR(1)="Insurance Co: "_$P($G(^DIC(36,+IBCNS,0)),U)_PCDISP
 Q
 ;
INIT ; Initialize
 D CLEAN^VALM10
 I '$D(IBCNS) N IBCNS S IBCNS=IBINS
 N IBLCT
 S IBLCT=0
 ; Display the list
 D SET1(.IBLCT,"Attending/Rendering Provider Secondary ID")
 D SET1(.IBLCT,"Default ID (1500) : "_$$GET1^DIQ(36,IBCNS,4.01))
 D SET1(.IBLCT,"Default ID (UB-04): "_$$GET1^DIQ(36,IBCNS,4.02))
 D SET1(.IBLCT,"Require ID on Claim: "_$$GET1^DIQ(36,IBCNS,4.03))
 D SET1(.IBLCT," ")
 D SET1(.IBLCT,"Referring Provider Secondary ID")
 D SET1(.IBLCT,"Default ID (1500): "_$$GET1^DIQ(36,IBCNS,4.04))
 D SET1(.IBLCT,"Require ID on Claim: "_$$GET1^DIQ(36,IBCNS,4.05))
 D SET1(.IBLCT," ")
 D SET1(.IBLCT,"Billing Provider Secondary IDs")
 D SET1(.IBLCT,"Use Att/Rend ID as Billing Provider Sec. ID (1500)? : "_$$GET1^DIQ(36,IBCNS,4.06))
 D SET1(.IBLCT,"Use Att/Rend ID as Billing Provider Sec. ID (UB-04)?: "_$$GET1^DIQ(36,IBCNS,4.08))
 D SET1(.IBLCT,"Transmit no Billing Provider Sec ID for the following Electronic Plan Types:")
 D LIST^DIC(36.013,","_IBCNS_",",".01",,10,,,,,,"TAR","ERR")
 F I=1:1:+$G(TAR("DILIST",0)) D
 . D SET1(.IBLCT,TAR("DILIST",1,I))
 D SET1(.IBLCT," ")
 D SET1(.IBLCT,"Billing Provider/Service Facility")
 ;
 S IBCNS4=$G(^DIC(36,+IBCNS,4))
 ; MRD;IB*2.0*516 - Marked fields 4.07, 4.11, 4.12 and 4.13 for
 ; deletion and removed all references to them.
 ;D SET1(.IBLCT,"Always use main VAMC as Billing Provider (1500)?: "_$$EXPAND^IBTRE(36,4.11,+$P(IBCNS4,U,11)))
 ;D SET1(.IBLCT,"Always use main VAMC as Billing Provider (UB-04)?: "_$$EXPAND^IBTRE(36,4.12,+$P(IBCNS4,U,12)))
 ;I $P(IBCNS4,U,11)!($P(IBCNS4,U,12)) D
 ;.D SET1(.IBLCT,"Send VA Lab/Facility IDs or Facility Data for VAMC?: "_$$EXPAND^IBTRE(36,4.07,+$P(IBCNS4,U,7)))
 ;.D SET1(.IBLCT,"Use the Billing Prov (VAMC) Name and Street Address?: "_$$EXPAND^IBTRE(36,4.13,+$P(IBCNS4,U,13)))
 ;.Q
 ;
 S VALMBG=1,VALMCNT=IBLCT
 Q
 ;
SET1(IBLCT,TEXT,IBCT) ;
 S IBLCT=IBLCT+1 D SET^VALM10(IBLCT,TEXT)
 Q
 ;
EXPND ;
 Q
HELP ;
 Q
EXIT ;
 D CLEAN^VALM10
 Q
 ;
IDPARAM ;
 D FULL^VALM1
 N DIE,DA,DR
 I '$D(IBCNS) N IBCNS S IBCNS=IBINS
 S DIE="^DIC(36,",(DA,Y)=IBCNS,DR="[IBEDIT INS CO1]"
 I '$D(IBY) N IBY S IBY=",12,"
 D ^DIE K DIE
 K ^TMP("IBCE_PRVFAC_MAINT",$J)
 D INIT
 S VALMBCK="R"
 Q
 ;
BILLPRVP ;
 D FULL^VALM1
 D EN^IBCEPC
 D INIT
 K ^TMP("IBCE_PRVFAC_MAINT",$J)
 S VALMBCK="R"
 Q
