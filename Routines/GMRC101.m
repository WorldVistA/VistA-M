GMRC101 ;SLC/DLT - Create Protocol entries for OE/RR ADD orders screens ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1,5**;DEC 27, 1997
EN ;Entry to build Consult types for Add menus
 W !,"There are 2 types of Protocols used by the Consult Package on 'Add Orders'",!,"menus in OE/RR."
EN1 K DIR,DA S GMRCEND=0,DIR(0)="SO^1:CONSULT TYPE;2:PROCEDURE REQUEST",DIR("A")="Select Protocol Type",DIR("??")="^D HELP^GMRC101"
 D ^DIR K DIR S GMRCEND=$S($D(DTOUT):1,$D(DUOUT):1,$D(DIROUT):1,1:0) I GMRCEND G END
 I Y=1 D CONSULT G:GMRCEND=2 EN1 D END Q
 I Y=2 D PROCDURE G:GMRCEND=2 EN1 D END Q
 Q
CONSULT ;entry to create a Consult Type
 S GMRCPFX="GMRCT ",GMRCDESC="Consult Type",GMRCDEFN="GMRCT SAMPLE CONSULT TYPE"
 W !!,"NOTE: All Consult Types in the Protocol file are prefixed with ""GMRCT "".",!,"For A Fast Lookup Of Consult Type Protocols, Type ""GMRCT"" At The Prompt.",!
 D SETDEF I GMRCEND Q
 D EN^GMRC101C
 Q
PROCDURE ;entry to create a Procedure Request
 S GMRCPFX="GMRCR ",GMRCDESC="Procedure Request",GMRCDEFN="GMRCR SAMPLE PROCEDURE"
 W !!,"NOTE: All Procedure/Requests in the Protocol file are prefixed with ""GMRCR "".",!,"For A Fast Look-up Of Procedures, Type 'GMRCR' At The Prompt.",!
 D SETDEF I GMRCEND Q
 D EN^GMRC101C
 Q
SETDEF ;Set GMRCDEF once to hold for filling in ORDEF for protocol processing.
 S GMRCDEF=$O(^ORD(101,"B",GMRCDEFN,"")) I 'GMRCDEF W !!,"Missing Sample Protocol "_GMRCDEFN,! S GMRCEND=1 Q
 Q
END K GMRCACT,GMRCEND,GMRCDEFN,GMRCDEF,GMRCDESC,GMRCPFX,GMRCPRF
 K ORPKG,DIROUT,DUOUT,DTOUT,Y
 Q
HELP ;?? help for DIR to define types of consults
 W @IOF
 W !,"Protocols defined in this option and Added to Add New Order menus, will have"
 W !,"orders created in OE/RR based on the protocols definition."
 W !,"(e.g. Item Text: TPN, and Related Consult Service/Specialty: Pharmacy Service"
 W !,"  creates a ""Pharmacy Service TPN"" order in OE/RR if the TPN protocol is"
 W !,"  selected from the Add New Orders menu in OE/RR"
 W !!,"CONSULT TYPES are names of consults which are very common, such as: "
 W !,"     ""TPN"" Consult for Hyperalimentation Pharmacy consult"
 W !,"     ""Physical Therapy"" Consult for RMS"
 W !,"  Once the commonly known consults are defined here, they may also be added"
 W !,"  to OE/RR Add New Orders menus for ease of ordering."
 W !,"  Consult Type protocols are always prefixed with ""GMRCT """
 W !!,"PROCEDURE REQUESTS are names of procedures, tests, or other requests"
 W !,"  which are very common, such as: "
 W !,"    ""EKG: Portable"""
 W !,"  Once the commonly known procedures which may be ordered without a consult"
 W !,"  are defined here, they may also be added to OE/RR Add New Orders menus for"
 W !,"  ease of ordering."
 W !,"  Procedure Request protocols are always prefixed with ""GMRCR """
 W !! R "Press RETURN to continue: ",X:$S($D(DTIME):DTIME,1:300)
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) D END S GMRCEND=1 Q
