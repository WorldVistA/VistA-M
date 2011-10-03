IBCNSM8 ;ALB/NLR - INSURANCE MANAGEMENT WORKHSEET5 ; 9-AUG-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BL3 ; -- print mental health info, annual benefits
 ;
 W !?5,$TR($J(" ",IOM-12)," ","-")
 W !?6,"5.",?33-($L("** MENTAL HEALTH INPATIENT **")\2),"** MENTAL HEALTH INPATIENT **" D VLINE^IBCNSM7
 W ?72,"6.",?99-($L("** MENTAL HEALTH OUTPATIENT **")\2),"** MENTAL HEALTH OUTPATIENT **"
 W !?3,$J("MH Inpt Max Days/Year:",23),?28,$J($$DOL^IBCNSM6(355.4,5.14,$P($G(IBCABD5),"^",14),IBLINE),10) D VLINE^IBCNSM7
 W ?83,$J("MH Opt Max Days/Year:",23),?108,$J($$DOL^IBCNSM6(355.4,2.14,$P($G(IBCABD2),"^",14),IBLINE),10)
 W !?3,$J("MH Lifet Inpt Max ($):",23),?28,$J($$DOL^IBCNSM6(355.4,5.05,$P($G(IBCABD5),"^",5),IBLINE),10) D VLINE^IBCNSM7
 W ?83,$J("MH Lifet Opt Max ($):",23),?108,$J($$DOL^IBCNSM6(355.4,2.05,$P($G(IBCABD2),"^",5),IBLINE),10)
 W !?3,$J("MH Annual Inpt Max ($):",23),?28,$J($$DOL^IBCNSM6(355.4,5.06,$P($G(IBCABD5),"^",6),IBLINE),10) D VLINE^IBCNSM7
 W ?83,$J("MH Annual Opt Max ($):",23),?108,$J($$DOL^IBCNSM6(355.4,5.06,$P($G(IBCABD5),"^",6),IBLINE),10)
 W !?3,$J("MH Inpt (%):",23),?28,$J($$DOL^IBCNSM6(355.4,5.11,$P($G(IBCABD5),"^",11),IBLINE),10) D VLINE^IBCNSM7
 W ?83,$J("MH Opt (%):",23),?108,$J($$DOL^IBCNSM6(355.4,2.11,$P($G(IBCABD2),"^",11),IBLINE),10)
 ;W !?83,$J("Max Visits/Yr:",23),?108,$J($$DOL^IBCNSM6(355.4,2.16,$P($G(IBCABD2),"^",16),IBLINE),10)
 ;W !?83,$J("Adult Day Health Care?:",23),?108,$J($$DOL^IBCNSM6(355.4,2.17,$P($G(IBCABD2),"^",17),IBLINE),10)
 Q
 ;
BL4 ; -- print home health care & hospice info, annual benefits
 ;
 W !?5,$TR($J(" ",IOM-12)," ","-")
 W !?6,"7.",?33-($L("** HOME HEALTH CARE **")\2),"** HOME HEALTH CARE **"
 D VLINE^IBCNSM7 W ?72,"8.",?99-($L("** HOSPICE **")\2),"** HOSPICE **"
 W !?3,$J("Care Level:",23)
 I $P($G(IBCABD3),"^")="" W ?28,$J($$DOL^IBCNSM6(355.4,3.01,$P($G(IBCABD3),"^"),IBLINE),10) G ANDED
 W ?(37-($L($$DOL^IBCNSM6(355.4,3.01,$P($G(IBCABD3),"^"),IBLINE))\2)),$$DOL^IBCNSM6(355.4,3.01,$P($G(IBCABD3),"^"),IBLINE)
 ;
ANDED D VLINE^IBCNSM7 W ?83,$J("Annual Ded ($):",23),?108,$J($$DOL^IBCNSM6(355.4,4.01,$P($G(IBCABD4),"^"),IBLINE),10)
 W !?3,$J("Visits/Year:",23),?28,$J($$DOL^IBCNSM6(355.4,3.02,$P($G(IBCABD3),"^",2),IBLINE),10) D VLINE^IBCNSM7
 W ?83,$J("Inpt Annual Max ($):",23),?108,$J($$DOL^IBCNSM6(355.4,4.02,$P($G(IBCABD4),"^",2),IBLINE),10)
 W !?3,$J("Max Days/Year:",23),?28,$J($$DOL^IBCNSM6(355.4,3.03,$P($G(IBCABD3),"^",3),IBLINE),10) D VLINE^IBCNSM7
 W ?83,$J("Inpt Lifet Max ($):",23),?108,$J($$DOL^IBCNSM6(355.4,4.03,$P($G(IBCABD4),"^",3),IBLINE),10)
 W !?3,$J("Med Equipment (%):",23),?28,$J($$DOL^IBCNSM6(355.4,3.04,$P($G(IBCABD3),"^",4),IBLINE),10) D VLINE^IBCNSM7
 W ?83,$J("Room & Board (%):",23),?108,$J($$DOL^IBCNSM6(355.4,4.04,$P($G(IBCABD4),"^",4),IBLINE),10)
 S IBLE=$$DOL^IBCNSM6(355.4,3.05,$P($G(IBCABD3),"^",5),IBLINE)
 W !?3,$J("Visit Definition:",23),?28,$$DOL^IBCNSM6(355.4,3.05,$P($G(IBCABD3),"^",5),IBLINE) D VLINE^IBCNSM7
 ;W $S("?"_37-($L(IBLE))\2:$L(IBLE)'>19,1:?28)_","_"that's right"
 W ?83,$J("Other Inpt Charges (%):",23),?108,$J($$DOL^IBCNSM6(355.4,4.05,$P($G(IBCABD4),"^",5),IBLINE),10)
 Q
