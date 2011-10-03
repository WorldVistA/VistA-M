SPNLRU1 ;HISC/JWR-Report Printing utilities ;10/24/2001
 ;;2.0;Spinal Cord Dysfunction;**2,16,19**;01/02/1997
EN ;
 W !!
 S SPNLTRAM="ALL"
 Q
 K DIRUT
 S DIR(0)="SAO^T:Traumatic Injuries;N:Non-Traumatic Injuries;A:All Patients"
 S DIR("A")="Injury Type (T,N,A): "
 S DIR("A",.5)="Include patients with which of the following injury types:"
 S DIR("A",1)="   "
 S DIR("A",2)="   T - Include only patients with traumatic injuries"
 S DIR("A",3)="   N - Include only patients with non-traumatic injuries"
 S DIR("A",4)="   A - Include all patients with any type of injury"
 S DIR("A",5)="   "
 S DIR("B")="All Patients"
 S DIR("?",1)="   You may only select one item from the given list,"
 S DIR("?")="   Select by entering 'T' or 'N' or 'A'."
 D ^DIR W !!
 K DIR
 I $D(DIRUT) K DIRUT S ABORT=1 Q
 S:Y="T" SPNLTRAM="TRAUMATIC",SPNLTRM1="Patients with Traumatic Injuries"
 S:Y="N" SPNLTRAM="NON-TRAUMATIC",SPNLTRM1="Patients with Non-Traumatic Injuries"
 Q
TRAUMA(D0) ;Screen out traumatic/non-traumatic injuries
 S SPNTD=$$EN4^SPNLUTL0(D0)
 I SPNLTRAM="ALL" S SPNTD=1 G Q
 I $E(SPNTD,1,9)=SPNLTRAM S SPNTD=1 G Q
 I SPNLTRAM="NON-TRAUMATIC",SPNTD[SPNLTRAM S SPNTD=1 G Q
 S SPNTD=0
Q Q SPNTD
 Q
DIE ;This tag was placed in here to avoid adding another routine to 
 ;the *17 build.  Routine spnls has a call to this label and this label
 ;did not exist.  So now it does and we are once again happy
 Q
