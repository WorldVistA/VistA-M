IBCNSUR3 ;WOIFO/AAT - MOVE SUBSCRIBERS (BULLETIN) ;09-SEP-96
 ;;2.0;INTEGRATED BILLING;**276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;add line to the bulletin
ADD(IBTAB,IBX1,IBX2,IBX3,IBX4,IBX5) ;
 N IBX
 S IBLN=IBLN+1
 S IBX="" S:$G(IBTAB)>1 $E(IBX,IBTAB-1)=" "
 S @REF@(IBLN)=IBX_$G(IBX1)_$G(IBX2)_$G(IBX3)_$G(IBX4)_$G(IBX5)
 Q
 ;
BHEAD ; Bulletin header
 D ADD(1,"MOVE SUBSCRIBERS OF ONE PLAN TO ANOTHER PLAN")
 D ADD()
 D ADD(1,"You selected to move ",IBSUB," subscribers")
 D ADD()
 D ADD(5,"FROM Insurance Company ",IBC1N)
 D ADD(10,"Plan Name ",IBP1N,"     Number ",IBP1X)
 D ADD(5,"TO Insurance Company ",IBC2N)
 D ADD(10,"Plan Name ",IBP2N,"     Number ",IBP2X)
 I IBSPLIT D
 . D ADD(5,"BY switching to the new Insurance/Plan")
 . D ADD(10,"with Effective Date ",$$DAT1^IBOUTL(IBEFFDT))
 D ADD()
 D ADD(1,"The old insurance group plan is ",$S(IBSPLIT:"set EXPIRED",1:"REPLACED")," in the patient profile."),ADD()
 D ADD(1,"Patient Name/ID             Whose    Employer              Effective   Expires")
 D ADD(1,"-------------------------------------------------------------------------------")
 Q
 ; Add subscriber to the bulletin
ADS(DFN,IBCDFN) ;
 N IBX,IBZ,IB2
 S IBZ=$G(^DPT(DFN,.312,IBCDFN,0))
 S IB2=$G(^DPT(DFN,.312,IBCDFN,2))
 S IBX=$E($P($G(^DPT(DFN,0)),U),1,22),$E(IBX,22)=" "
 S IBX=$E(IBX_$E($P($G(^DPT(DFN,0)),U,9),6,10),1,28),$E(IBX,28)=" "
 S IBX=$E(IBX_$$EXTERNAL^DILFD(2.312,6,,$P(IBZ,U,6)),1,36),$E(IBX,37)=" "
 S IBX=$E(IBX_$P(IB2,U,9),1,59),$E(IBX,59)=" "
 S IBX=$E(IBX_$$DAT1^IBOUTL($P(IBZ,U,8)),1,71),$E(IBX,71)=" "
 S IBX=$E(IBX_$$DAT1^IBOUTL($P(IBZ,U,4)),1,80)
 D ADD(1,IBX)
 Q
 ;
DONE ;
 N IBGRP,XMDUZ,XMTEXT,XMSUB,XMY,%
 ;
 D NOW^%DTC
 D ADD()
 D ADD(1,"THE PROCESS COMPLETED SUCCESSFULLY ON "_$$DAT1^IBOUTL(%,1))
 ;
 S XMSUB="SUBSCRIPTION LIST FOR INACTIVATED PLAN"
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="^TMP("_$J_",""IBCNSUR1"","
 S XMY(DUZ)=""
 S XMY("G.IB NEW INSURANCE")=""
 D ^XMD
 Q
