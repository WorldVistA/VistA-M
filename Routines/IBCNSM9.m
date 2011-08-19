IBCNSM9 ;ALB/NLR - INSURANCE MANAGEMENT WORKSHEET7 ; 15-NOV-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BL5 ; -- print rehab & iv mgmt info
 W !?5,$TR($J(" ",IOM-12)," ","-")
 W !?6,"9.",?33-($L("** REHABILITATION **")\2),"** REHABILITATION **" D VLINE^IBCNSM7
 W ?71,"10.",?99-($L("** IV MANAGEMENT **")\2),"** IV MANAGEMENT **"
 W !?3,$J("OT Visits/Yr:",23),?28,$J($$DOL^IBCNSM6(355.4,3.06,$P($G(IBCABD3),"^",6),IBLINE),10) D VLINE^IBCNSM7
 W ?83,$J("IV Infusion Opt?:",23),?108,$J($$DOL^IBCNSM6(355.4,4.06,$P($G(IBCABD4),"^",6),IBLINE),10)
 W !?3,$J("PT Visits/Yr:",23),?28,$J($$DOL^IBCNSM6(355.4,3.07,$P($G(IBCABD3),"^",7),IBLINE),10) D VLINE^IBCNSM7
 W ?83,$J("IV Infusion Inpt?:",23),?108,$J($$DOL^IBCNSM6(355.4,4.07,$P($G(IBCABD4),"^",7),IBLINE),10)
 W !?3,$J("ST Visits/Yr:",23),?28,$J($$DOL^IBCNSM6(355.4,3.08,$P($G(IBCABD3),"^",8),IBLINE),10) D VLINE^IBCNSM7
 W ?83,$J("IV Antibiotics Opt?:",23),?108,$J($$DOL^IBCNSM6(355.4,4.08,$P($G(IBCABD4),"^",8),IBLINE),10)
 W !?3,$J("Med Cnslg Visits/Yr:",23),?28,$J($$DOL^IBCNSM6(355.4,3.09,$P($G(IBCABD3),"^",9),IBLINE),10) D VLINE^IBCNSM7
 W ?83,$J("IV Antibiotics Inpt?:",23),?108,$J($$DOL^IBCNSM6(355.4,4.09,$P($G(IBCABD4),"^",9),IBLINE),10)
 W !?5,$TR($J(" ",IOM-12)," ","-")
 Q
BL6 ; -- print rider info
 ;
 D HDR^IBCNSM5
 W !?5,$TR($J(" ",IOM-12)," ","-")
 D GETRDRS
 Q
GETRDRS ; -- get personal riders
 N IBPR,IBPRD,I,J
 S I=0
 I '$G(IBCDFN)!('$G(DFN)) G DISPRQ
 W !?5,"11.",?33-($L("** CURRENT PERSONAL RIDERS **")\2),"** CURRENT PERSONAL RIDERS **" D VLINE^IBCNSM7
 F  S I=$O(^IBA(355.7,"APP",DFN,IBCDFN,I)) Q:'I  S J=$O(^(I,0)),IBPR=$G(^IBA(355.7,+J,0)) D
 .S IBPRD=$$EXPAND^IBTRE(355.7,.01,+IBPR)
 .W !?9,IBPRD D VLINE^IBCNSM7
 I 'IBLINE,('$D(IBPRD)) W !?9,"None Indicated" D VLINE^IBCNSM7
 I IBLINE,('$D(IBPRD)) W !!?10,$TR($J(" ",(IOM-20))," ","_") W !!?10,$TR($J(" ",(IOM-20))," ","_") W !!?10,$TR($J(" ",(IOM-20))," ","_")
DISPRQ Q
BL7 ; -- print benefits used
 ;
 ; -- policy and opt deductibles
 ;
 W !,$TR($J(" ",IOM)," ","=")
 W !?66-($L("* BENEFITS USED *")\2),"* BENEFITS USED *"
 W !?5,$TR($J(" ",IOM-12)," ","-")
 W !?5,"12.",?33-($L("** POLICY **")\2),"** POLICY **" D VLINE^IBCNSM7
 W ?71,"13.",?99-($L("** OPT DEDUCTIBLES **")\2),"** OPT DEDUCTIBLES **"
 W !?3,$J("Ded Met?:",23),?28,$E($$DOL^IBCNSM6(355.5,.04,$$YN^IBCNSM($P($G(IBCBUD),"^",4),1),IBLINE),1,22) D VLINE^IBCNSM7
 W ?83,$J("Ded Met?:",23),?108,$E($$DOL^IBCNSM6(355.5,.08,$$YN^IBCNSM($P($G(IBCBUD),"^",8),1),IBLINE),1,22)
 W !?3,$J("Amt of Ded Met ($):",23),?28,$E($$DOL^IBCNSM6(355.5,.05,$P($G(IBCBUD),"^",5),IBLINE),1,22) D VLINE^IBCNSM7
 W ?83,$J("Amt of Ded Met ($):",23),?108,$E($$DOL^IBCNSM6(355.5,.09,$P($G(IBCBUD),"^",9),IBLINE),1,22)
 W !?3,$J("Pre-exist Cond:",23),?28,$E($$DOL^IBCNSM6(355.5,.15,$P($G(IBCBUD),"^",15),IBLINE),1,22) D VLINE^IBCNSM7
 W ?83,$J("MH Ded (Opt) Met?:",23),?108,$E($$DOL^IBCNSM6(355.5,.13,$$YN^IBCNSM($P($G(IBCBUD),"^",13),1),IBLINE),1,22)
 W !?3,$J("Coord of Ben Data:",23),?28,$E($$DOL^IBCNSM6(355.5,.16,$P($G(IBCBUD),"^",16),IBLINE),1,22) D VLINE^IBCNSM7
 W ?83,$J("Amt of MH Ded Met ($):",23),?108,$E($$DOL^IBCNSM6(355.5,.14,$P($G(IBCBUD),"^",14),IBLINE),1,22)
 W ! D VLINE^IBCNSM7 W ?83,$J("Amt Lifet Max Used ($):",23),?108,$E($$DOL^IBCNSM6(355.5,.1,$P($G(IBCBUD),"^",10),IBLINE),1,22)
 W ! D VLINE^IBCNSM7 W ?80,"Amt MH Lifet Max Used ($):",?108,$E($$DOL^IBCNSM6(355.5,.2,$P($G(IBCBUD),"^",20),IBLINE),1,22)
 ;
 ; inpt deductibles
 ; 
 W !?5,$TR($J(" ",IOM-12)," ","-")
 W !?5,"14.",?33-($L("** INPT DEDUCTIBLES **")\2),"** INPT DEDUCTIBLES **" D VLINE^IBCNSM7
 W !?3,$J("Ded Met?:",23),?28,$E($$DOL^IBCNSM6(355.5,.11,$$YN^IBCNSM($P($G(IBCBUD),"^",6),1),IBLINE),1,22) D VLINE^IBCNSM7
 W !?3,$J("Amt of Ded Met ($):",23),?28,$$DOL^IBCNSM6(355.5,.07,$P($G(IBCBUD),"^",7),IBLINE) D VLINE^IBCNSM7
 W !?3,$J("MH Ded (Inpt) Met?:",23),?28,$E($$DOL^IBCNSM6(355.5,.11,$$YN^IBCNSM($P($G(IBCBUD),"^",11),1),IBLINE),1,22) D VLINE^IBCNSM7
 W !?3,$J("Amt of MH Ded Met ($):",23),?28,$E($$DOL^IBCNSM6(355.5,.12,$P($G(IBCBUD),"^",12),IBLINE),1,22) D VLINE^IBCNSM7
 W !?3,$J("Amt Lifet Max Used ($):",23),?28,$E($$DOL^IBCNSM6(355.5,.19,$P($G(IBCBUD),"^",19),IBLINE),1,22) D VLINE^IBCNSM7
 W !,"Amt MH Lifet Max Used ($):",?28,$E($$DOL^IBCNSM6(355.5,.18,$P($G(IBCBUD),"^",18),IBLINE),1,22) D VLINE^IBCNSM7
 W !,$TR($J(" ",IOM)," ","=")
 Q
 ;
