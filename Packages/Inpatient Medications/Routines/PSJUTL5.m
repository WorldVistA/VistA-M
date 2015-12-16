PSJUTL5 ;BIR/MLM-UTILITY TO HANDLE NATURE OF ORDER FOR OE/RR ; 3/22/10 1:53pm
 ;;5.0;INPATIENT MEDICATIONS;**40,218,260,217**;16 DEC 97;Build 25
 ;
ENNOO(X) ; nature of order (for oe/rr)
 ; X - Action taken on order.
 N Y S Y="W" I 'PSJSYSU Q Y
 K Y N DA,DIR,ACT S ACT=X
 K:$G(PSJNOO)=-1 PSJNOO  ;Prevents nature of order -1
 D FULL^VALM1
 I $G(ACT)]"" D @ACT
 E  S Y=-1 Q Y
 Q:$D(Y) Y
 S DIR("A")="NATURE OF ORDER: ",DIR("B")="WRITTEN"
 S DIR("?",1)="This specifies the nature of the order, how it originated, or how any",DIR("?",2)="action performed on the order originated."
 S DIR("?",3)="Nature of order controls whether CPRS will ask for a provider's signature",DIR("?",4)="for the order and whether a chart copy will be printed."
 S DIR("?")="Nature of order MUST be entered, but if the package sees the user as a ward clerk or pharmacy technician, the nature of order may only be written."
 S DIR("??")="^D HELP^PSJUTL5"
 D ^DIR I $D(DIRUT) K DIRUT S Y=-1 Q Y
 Q Y
 ;Sets DIR(0) based on action being taken.
N I $T(NA^ORX1)]"" S Y=$$NA^ORX1("W",0,"B","NATURE OF ORDER",0,"WVPSXDIE") S:Y'="^" Y=$P(Y,"^",3) S:Y="^" Y=-1 Q
 I $T(NA^ORX1)="" S DIR(0)="SA^W:WRITTEN;V:VERBAL;P:TELEPHONED;S:SERVICE CORRECTION;X:REJECTED;D:DUPLICATE;I:POLICY;E:PHYSICIAN ENTERED;" Q
E I $T(NA^ORX1)]"" S Y=$$NA^ORX1("S",0,"B","NATURE OF ORDER",0,"WVPSXDIE") S:Y'="^" Y=$P(Y,"^",3) S:Y="^" Y=-1 Q
 I $T(NA^ORX1)="" S DIR(0)="SA^W:WRITTEN;V:VERBAL;P:TELEPHONED;S:SERVICE CORRECTION;X:REJECTED;D:DUPLICATE;I:POLICY;E:PHYSICIAN ENTERED;" Q
R I $T(NA^ORX1)]"" S Y=$$NA^ORX1("W",0,"B","NATURE OF ORDER",0,"WVPSXDIE") S:Y'="^" Y=$P(Y,"^",3) S:Y="^" Y=-1 Q
 I $T(NA^ORX1)="" S DIR(0)="SA^W:WRITTEN;V:VERBAL;P:TELEPHONED;S:SERVICE CORRECTION;X:REJECTED;D:DUPLICATE;I:POLICY;E:PHYSICIAN ENTERED;" Q
 ;*218 Added R to DC
D I $T(NA^ORX1)]"" S Y=$$NA^ORX1("W",0,"B","NATURE OF ORDER",0,"WVPSXDIER") S:Y'="^" Y=$P(Y,"^",3) S:Y="^" Y=-1 Q
 I $T(NA^ORX1)="" S DIR(0)="SA^W:WRITTEN;V:VERBAL;P:TELEPHONED;S:SERVICE CORRECTION;X:REJECTED;D:DUPLICATE;I:POLICY;E:PHYSICIAN ENTERED;R:SERVICE REJECT;" Q
H I $T(NA^ORX1)]"" S Y=$$NA^ORX1("W",0,"B","NATURE OF ORDER",0,"WVPSDIE") S:Y'="^" Y=$P(Y,"^",3) S:Y="^" Y=-1 Q
 I $T(NA^ORX1)="" S DIR(0)="SA^W:WRITTEN;V:VERBAL;P:TELEPHONED;S:SERVICE CORRECTION;D:DUPLICATE;I:POLICY;E:PHYSICIAN ENTERED;" Q
V I $T(NA^ORX1)]"" S Y=$$NA^ORX1("W",0,"B","NATURE OF ORDER",0,"WVPSXDIER") S:Y'="^" Y=$P(Y,"^",3) S:Y="^" Y=-1 Q
 I $T(NA^ORX1)="" S DIR(0)="SA^W:WRITTEN;V:VERBAL;P:TELEPHONED;S:SERVICE CORRECTION;X:REJECTED;D:DUPLICATE;I:POLICY;E:PHYSICIAN ENTERED;R:SERVICE REJECT;" Q
 ;
HELP ;Extended Help
 W !?55,"Prompted for   Chart Copy",!?55,"Signature in   Printed?",!?55,"CPRS?",!
 D @$S("N^E^R^D"[ACT:"WH,VH,PH,SH,XH,DH,IH,EH",1:"WH,VH,PH,SH,DH,IH,EH") Q
WH W !?2,"Written",?12," - The source of the order is a written",?59,"No",?74,"No",!?15,"doctor's order." Q
VH W !?2,"Verbal",?12," - A doctor verbally requested the order.",?59,"Yes",?74,"Yes" Q
PH W !?2,"Telephoned",?12," - A doctor phoned the service to request",?59,"Yes",?74,"Yes",!?15,"the order." Q
SH W !?2,"Service",?12," - The service is discontinuing or adding",?59,"No",?74,"No",!?2,"Correction",?15,"new orders to carry out the intent of",!?15,"an order already received." Q
XH W !?2,"Rejected",?12," - The service discontinued the order",?59,"No",?74,"No",!?15,"because it was unable to perform the",!?15,"task." Q
DH W !?2,"Duplicate",?12," - This applies to orders that are",?59,"No",?74,"Yes",!?15,"discontinued because they are a",!?15,"duplicate of another order." Q
IH W !?2,"Policy",?12," - These are orders that are created as",?59,"No",?74,"Yes",!?15,"a matter of hospital policy." Q
EH W !?2,"Physician",?12," - These are orders that are entered by",?59,"Yes",?74,"Yes",!?2,"Entered",?15,"the ordering provider." Q
