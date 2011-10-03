SPNPATUL ;HIRMFO/WAA - Patinet Select utility ;3/27/98  08:35
 ;;2.0;Spinal Cord Dysfunction;**4,5**;01/02/1997
PAT(DFN) ;Select a patient
 S SPNLEXIT=+$G(SPNLEXIT)
 Q:SPNLEXIT
 N DIR,Y
 ;Do a dir call on a free text data test for "all,ALL"
SELECT K DIR,Y
 S DIR(0)="FAO^2:35",DIR("A")="Select a patient: "
 S DIR("?")="^D HELP^SPNPATUL"
 D ^DIR
 I Y="" Q
 I $D(DIRUT) S SPNLEXIT=1 Q
 S SPNSTR=Y
 I $$UP^XLFSTR(SPNSTR)="ALL" D  Q:SPNLEXIT  Q:'DFN
 .N DIR,Y
 .S DIR(0)="YAO",DIR("A")="Do you mean ""ALL"" Patients? ",DIR("B")="YES"
 .D ^DIR
 .I $G(DIRUT) S SPNLEXIT=1 Q
 .I Y D
 ..W !,"All patients selected..." K DFN S DFN=0,DFN("ALL")="" Q
 ..Q
 .Q
 I $E(SPNSTR,1)="-" D
 .D DELETE
 .Q
 E  D
 .D ADD
 .Q
 Q:SPNLEXIT
 G SELECT
HELP ;This will print out all the help for the user
 N IEN S IEN=0
 W !,"The following is a list of selected patients:"
 I DFN<1 W !,"No patients have been selected yet."
 E  F  S IEN=$O(DFN(IEN)) Q:IEN<1  D
 .W !,$$GET^DDSVAL(2,IEN,.01,"","E") ; Name
 .W ?40,$$GET^DDSVAL(2,IEN,.09,"","E") ; SSN
 .;**MOD,SD/AB,1/29/98, Changed DOB output to show 4-digit year
 .W ?60,$$FMTE^XLFDT($$GET^DDSVAL(2,IEN,.03,"","I"),"1D") ; DOB
 .Q
 W !,"Enter the patient name or SSN to add a patient to the list."
 W !,"Enter a minus ""-"" before a patient name to remove him from the list."
 W !,"Enter ""ALL"" to select all patients and have the system use filters."
 Q
ADD ;Put a patient in the select list
 N Y
 D LOOKUP(SPNSTR) Q:SPNLEXIT
 Q:Y=-1
 I $D(DFN(Y)) W !,"Patient is already in list." Q
 S DFN=DFN+1
 S DFN(+Y)=""
 Q
DELETE ;Remove a patient from the select list
 N Y
 D LOOKUP($E(SPNSTR,2,$L(SPNSTR))) Q:SPNLEXIT
 Q:Y=-1
 I '$D(DFN(+Y)) W !,"Patient is not in list." Q
 S DFN=DFN-1
 K DFN(+Y)
 Q
LOOKUP(SPNSTR) ;Look-up a patient
 S DIC=2,X=SPNSTR,DIC(0)="QEZ" D ^DIC
 I $D(DTOUT)!($D(DUOUT)) S SPNLEXIT=1
 Q
