FBAAVP0 ;AISC/DMK-READJUST OBLIGATION BALANCE ;01JUN88
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 G:$D(FBVOID) VOID
 W !,?10,"Void payment for "_$E($S($D(^DPT(DFN,0)):$P(^(0),"^"),1:""),1,30),!,*7,"You must adjust control point accordingly through IFCAP!"
 Q
VOID W !,?10,"Cancel Voided payment for "_$E($S($D(^DPT(DFN,0)):$P(^(0),"^"),1:""),1,30),!,*7,"You must adjust control point accordingly through IFCAP!"
 Q
NOCL W !,"Vendor has no Payment data for this Patient!",! G RDV^FBAAVP
NVOID W !!,"There are no finalized payments for this vendor ",$S($D(FBVOID):"that have been voided.",1:"that may be voided.") G RDV^FBAAVP
