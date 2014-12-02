PSOOTMRX ;BIR/MFR - Titration/Maintenance Dose Prescription ;10/17/96
 ;;7.0;OUTPATIENT PHARMACY;**313**;DEC 1997;Build 76
 ;External reference to ULK^ORX2 supported by DBIA 867
 ;External reference to UL^PSSLOCK supported by DBIA 2789
 ;
TIMTRX ; Titration/Maintenance Dose Rx Hidden Action Entry Point
 N PSOMTFLG,PSOTITRX,PSORXIEN,LASTDOSE,BEFLST,DOSEINFO,DEA,LAB
 S PSORXIEN=$P(PSOLST(ORN),"^",2)
 ;
 ; - Rx already marked Maintenance
 I $$TITRX^PSOUTL(PSORXIEN)="m" D  Q
 . S VALMSG="Prescription already marked as 'Maintenance Rx'.",VALMBCK="R" W $C(7)
 ;
 ; - Rx already split into Maintenance Rx
 I $P($G(^PSRX(PSORXIEN,"TIT")),"^",2) D  Q
 . S VALMSG="A Maintenance Rx already exists for this Rx ("_$$GET1^DIQ(52,$P($G(^PSRX(PSORXIEN,"TIT")),"^",2),.01)_")"
 . S VALMBCK="R" W $C(7)
 ;
 ; - Rx was Digitally Signed
 I $$GET1^DIQ(52,PSORXIEN,310,"I") D  Q
 . S VALMSG="Rx was digitally signed and cannot be converted.",VALMBCK="R" W $C(7)
 ; 
 ; - No THEN conjunction for the last dose
 I '$$LTHEN^PSOUTL(PSORXIEN) D  Q
 . S VALMSG="A Titration Rx must have a THEN conjunction.",VALMBCK="R" W $C(7)
 ;
 ; - Rx is not ACTIVE
 I $$GET1^DIQ(52,PSORXIEN,100,"I")'=0 D  Q
 . S VALMSG="Prescription is not ACTIVE.",VALMBCK="R" W $C(7)
 ;
 ; - Rx NOT released
 I '$$RXRLDT^PSOBPSUT(PSORXIEN,0) D  Q
 . S VALMSG="Prescription must be RELEASED first.",VALMBCK="R" W $C(7)
 ;
 ; - Rx already has refills
 I $O(^PSRX(PSORXIEN,1,0)) D  Q
 . S VALMSG="Prescription has previously been refilled.",VALMBCK="R" W $C(7)
 ;
 ; - Rx already has refills
 I '$$GET1^DIQ(52,PSORXIEN,9) D  Q
 . S VALMSG="There are no refills available for this Rx.",VALMBCK="R" W $C(7)
 ;
 ; - Rx not been marked as Titration
 I '$P($G(^PSRX(PSORXIEN,"TIT")),"^",3) D  Q
 . S VALMSG="Rx has not been marked as Titration",VALMBCK="R" W $C(7)
 ;
 S PSOMTFLG=1,PSOTITRX=PSORXIEN
 D COPY^PSOORCPY K PSOMTFLG,PSOTITRX
 ;
 Q
 ;
MARKTIT ; Mark Rx as 'Titration' Hidden Action Entry Point
 N PSORXIEN,CHECK
 S PSORXIEN=$P(PSOLST(ORN),"^",2)
 S CHECK=$$CHECK(PSORXIEN)
 I 'CHECK D  Q
 . S VALMBCK="R",VALMSG=$P(CHECK,"^",2) W $C(7)
 ;
 I $G(PSORXIEN) D MARK(PSORXIEN,1)
 Q
 ;
END ;
 Q
 ;
MARK(PSORXIEN,REFRESH) ; Mark a non-refillable Rx as Titration
 N CHECK,DIR,PTLOCK,X,Y,DFN,COMM
 ;
 I '$$CHECK(PSORXIEN) Q
 ;
 D FULL^VALM1
 W !
 S DIR("A")="Do you want to "_$S($$TITRX^PSOUTL(PSORXIEN)="t":"UN",1:"")_"MARK this Rx as 'Titration'? "
 I $$TITRX^PSOUTL(PSORXIEN)'="t" S (DIR("?"),DIR("??"))="^D TITHLP^PSOOTMRX"
 S DIR(0)="YA" D ^DIR I Y'>0 D UNLK S VALMBCK="R" Q
 ;
 W !!,"Updating..."
 I '$P($G(^PSRX(PSORXIEN,"TIT")),"^",3) D
 . S $P(^PSRX(PSORXIEN,"TIT"),"^",3)=1,COMM="MARKED as Titration"
 E  D
 . S $P(^PSRX(PSORXIEN,"TIT"),"^",3)="",COMM="UNMARKED as Titration"
 . I ($D(^PSRX(PSORXIEN,"TIT"))=1),$TR($G(^PSRX(PSORXIEN,"TIT")),"^","")="" D
 . . K ^PSRX(PSORXIEN,"TIT")      ; Cleaning up the "TIT" subscript
 D RXACT^PSOBPSU2(PSORXIEN,,COMM,"E")
 H 1 W "OK"
 ;
 ; PSORXED is necessary to perform a REFRESH only
 I $G(REFRESH) N PSORXED S PSORXED=1 D ACT^PSOORNE2 S VALMBCK="R"
 ;
 Q
 ;
UNLK ; Unlocks the Patient/Rx
 S X=PSODFN_";DPT(" D ULK^ORX2
 D UL^PSSLOCK(PSODFN)
 Q
 ;
CHECK(PSORXIEN) ; Checks if Rx is eligible to be Marked as Titration/Maintenance
 N MSG
 S MSG=""
 ; - Rx already marked as  Maintenance
 I $$TITRX^PSOUTL(PSORXIEN)="m" D  Q ("0^"_MSG)
 . S MSG="Prescription already marked as 'Maintenance Rx'."
 ;
 ; - No THEN conjunction for the last dose
 I '$$LTHEN^PSOUTL(PSORXIEN) D  Q ("0^"_MSG)
 . S MSG="A TITRATION Rx must have a THEN conjunction."
 ;
 ;
 ; - Rx is not ACTIVE or SUSPENDED
 I $$GET1^DIQ(52,PSORXIEN,100,"I")'=0,$$GET1^DIQ(52,PSORXIEN,100,"I")'=5 D  Q ("0^"_MSG)
 . S MSG="Prescription must be ACTIVE or SUSPENDED."
 ;
 Q 1
 ;
TITHLP ; Help Text for Mark Rx as Titration/Maintenance prompt
 W !?5,"Answer YES if this is a Titration to Maintenance prescription."
 W !?5,"Actions such as Renewal (including from CPRS), Refill, and Copy"
 W !?5,"are not allowed on prescriptions marked as Titration."
 W !?5,"However, you will be able to create a Maintenance Rx from this Rx"
 W !?5,"upon refill request via the TR (Convert Titration Rx) hidden action."
 Q
