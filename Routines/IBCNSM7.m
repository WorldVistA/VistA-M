IBCNSM7 ;ALB/NLR - INSURANCE MANAGEMENT WORKSHEET3 ; 9-AUG-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; -- print comments
 ;
 ;W !,$TR($J(" ",IOM)," ","-")
 ;W !?3,"COMMENTS",!?6,$P($G(IBCBUD1),U,8)
 ;W !!!!
 ;Q
 ;
R1Q ;
 Q
 ;
BL2 ; -- print inpatient & outpatient info, annual benefits
 ;
 W !,$TR($J(" ",IOM)," ","=")
 W !?66-($L("* ANNUAL BENEFITS *")\2),"* ANNUAL BENEFITS *"
 W !?5,$TR($J(" ",IOM-12)," ","-")
 W !?6,"3.",?33-($L("** INPATIENT ANNUAL BENEFITS **")\2),"** INPATIENT ANNUAL BENEFITS **"
 D VLINE W ?72,"4.",?99-($L("** OUTPATIENT ANNUAL BENEFITS **")\2),"** OUTPATIENT ANNUAL BENEFITS **"
 W !?3,$J("Annual Ded ($):",23),?28,$J($$DOL^IBCNSM6(355.4,5.01,$P($G(IBCABD5),"^"),IBLINE),10) D VLINE
 W ?83,$J("Annual Ded ($):",23),?108,$J($$DOL^IBCNSM6(355.4,2.01,$P($G(IBCABD2),"^"),IBLINE),10)
 W !?3,$J("Per Admis Ded ($):",23),?28,$J($$DOL^IBCNSM6(355.4,5.02,$P($G(IBCABD5),"^",2),IBLINE),10) D VLINE
 W ?83,$J("Per Visit Ded ($):",23),?108,$J($$DOL^IBCNSM6(355.4,2.02,$P($G(IBCABD2),"^",2),IBLINE),10)
 W !?3,$J("Inpt Lifet Max ($):",23),?28,$J($$DOL^IBCNSM6(355.4,5.03,$P($G(IBCABD5),"^",3),IBLINE),10) D VLINE
 W ?83,$J("Lifet Max ($):",23),?108,$J($$DOL^IBCNSM6(355.4,2.03,$P($G(IBCABD2),"^",3),IBLINE),10)
 W !?3,$J("Inpt Annual Max ($):",23),?28,$J($$DOL^IBCNSM6(355.4,5.04,$P($G(IBCABD5),"^",4),IBLINE),10),?60 D VLINE
 W ?83,$J("Annual Max ($):",23),?108,$J($$DOL^IBCNSM6(355.4,2.04,$P($G(IBCABD2),"^",4),IBLINE),10)
 W !?3,$J("Room & Board (%):",23),?28,$J($$DOL^IBCNSM6(355.4,5.09,$P($G(IBCABD5),"^",9),IBLINE),10),?60 D VLINE
 W ?83,$J("Visit (%):",23),?108,$J($$DOL^IBCNSM6(355.4,2.09,$P($G(IBCABD2),"^",9),IBLINE),10)
 W !?3,$J("Drug/Alc Lifet Max ($):",23),?28,$J($$DOL^IBCNSM6(355.4,5.07,$P($G(IBCABD5),"^",7),IBLINE),10) D VLINE
 W ?83,$J("Max Visits/Yr:",23),?108,$J($$DOL^IBCNSM6(355.4,2.15,$P($G(IBCABD2),"^",15),IBLINE),10)
 W !?3,$J("Drug/Alc An Max ($):",23),?28,$J($$DOL^IBCNSM6(355.4,5.08,$P($G(IBCABD5),"^",8),IBLINE),10) D VLINE
 W ?83,$J("Surgery (%):",23),?108,$J($$DOL^IBCNSM6(355.4,2.13,$P($G(IBCABD2),"^",13),IBLINE),10)
 W !?3,$J("Nursing Home (%):",23),?28,$J($$DOL^IBCNSM6(355.4,5.1,$P($G(IBCABD5),"^",10),IBLINE),10) D VLINE
 W ?83,$J("Emergency (%):",23),?108,$J($$DOL^IBCNSM6(355.4,2.10,$P($G(IBCABD2),"^",10),IBLINE),10)
 W !?3,$J("Other Inpt Charges (%):",23),?28,$J($$DOL^IBCNSM6(355.4,5.12,$P($G(IBCABD5),"^",12),IBLINE),10) D VLINE
 W ?83,$J("Prescription (%):",23),?108,$J($$DOL^IBCNSM6(355.4,2.12,$P($G(IBCABD2),"^",12),IBLINE),10)
 W ! D VLINE W ?83,$J("Adult Day Health Care?:",23),?108,$J($$DOL^IBCNSM6(355.4,2.17,$P($G(IBCABD2),"^",17),IBLINE),10)
 W ! D VLINE W ?67,$J("Dnt Cov Type (NONE/PER VIS $ / % AMT):",39)
 I $P($G(IBCABD2),"^",7)="" W ?108,$J($$DOL^IBCNSM6(355.4,2.07,$P($G(IBCABD2),"^",7),IBLINE),10) G DEN
 W ?(117-($L($$DOL^IBCNSM6(355.4,2.07,$P($G(IBCABD2),"^",7),IBLINE))\2)),$$DOL^IBCNSM6(355.4,2.07,$P($G(IBCABD2),"^",7),IBLINE)
 ;
DEN I $P(IBCABD2,"^",7)=0!('($G(IBLINE))&($P(IBCABD2,"^",7)="")) G IOQ
 N IBX
 S IBX=$S($P($G(IBCABD2),U,7)=1:"Dental Cov ($):",$P($G(IBCABD2),U,7)=2:"Dental Cov (%):",1:"Dental Cov $ Or %:")
 W ! D VLINE W ?$S($P($G(IBCABD2),U,7)=1!2:83,1:80),$J(IBX,23),?108,$J($$DOL^IBCNSM6(355.4,2.08,$P($G(IBCABD2),"^",8),IBLINE),10)
IOQ Q
VLINE ; create a vertical line between blocks
 W ?66,"|"
 Q
