FBUTL5 ;WOIFO/SAB-FEE BASIS UTILITY ;7/6/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 Q
FPPSC(FBEDIT,FBFPPSC) ; Prompt EDI Claim and FPPS Claim ID Extrinsic Function
 ; Input
 ;   FBEDIT  - optional, true (=1) when editing an existing item
 ;   FBFPPSC - optional, current value of FPPS CLAIM ID
 ;             only passed when editing an existing item
 ; Return value (FBRET)
 ;   = FPPS CLAIM ID if EDI Claim
 ;   = null if not EDI Claim
 ;   = -1 if time-out or '^'
 ;
 N FBEDI,FBRET
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S FBRET=""
 ;
ASKEDI ; ask if claim is an EDI claim
 S DIR(0)="Y"
 S DIR("A")="Is this an EDI Claim from the FPPS system"
 I $G(FBEDIT) S DIR("B")=$S($G(FBFPPSC)]"":"YES",1:"NO")
 D ^DIR K DIR I $D(DIRUT) S FBRET=-1 G FPPSCX
 S FBEDI=Y
 ;
ASKID ; If EDI then ask claim ID
 I FBEDI D  I $D(DTOUT)!$D(DUOUT) S FBRET=-1 G FPPSCX
 . N DA
 . S DIR(0)="162.7,32"
 . I $G(FBFPPSC)]"" S DIR("B")=FBFPPSC
 . D ^DIR K DIR Q:$D(DIRUT)
 . S FBRET=Y
 ;
 ; If EDI and claim ID not entered then reask
 I FBEDI,FBRET="" D  G ASKEDI
 . W $C(7),!,"  The FPPS CLAIM ID must be entered for EDI claims!"
 ;
FPPSCX ; FPPSC Exit
 Q FBRET
 ;
FPPSL(FBFPPSL,FBALL,FBNOOUT) ; Prompt FPPS Line Item Extrinsic Function
 ; Input
 ;   FBFPPSL -  optional, current value of FPPS LINE ITEM
 ;              only passed when editing an existing item
 ;   FBALL   -  optional, true (=1) if ALL allowed as input value,
 ;              default is false
 ;   FBNOOUT -  optional, boolean value, default 0, set =1 if user
 ;              should not be allowed to exit using an uparrow
 ; Return value (FBRET)
 ;   = FPPS LINE ITEM
 ;   = -1 if time-out or '^'
 ;
 N FBRET
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S FBRET=""
 S FBNOOUT=$G(FBNOOUT,0)
 S FBALL=$G(FBALL,0)
 ;
ASKLI ; ask line item
 I FBALL D  G:FBRET]"" FPPSLX I $D(DIRUT) S FBRET=-1 G FPPSLX
 . S FBRET=""
 . S DIR(0)="Y"
 . S DIR("A")="Does this VistA invoice cover all line items on the FPPS Claim"
 . I $G(FBFPPSL)]"" S DIR("B")=$S(FBFPPSL="ALL":"YES",1:"NO")
 . D ^DIR K DIR Q:$D(DIRUT)
 . I Y S FBRET="ALL"
 ;
 S DIR(0)="LCA^1:999:0"
 S DIR("A")="FPPS LINE ITEM: "
 S DIR("?")="This response must be a number or a list or range, e.g., 1,3,5 or 2-4,8."
 S DIR("??")="^D LIHLP^FBUTL5"
 I $G(FBFPPSL)]"",FBFPPSL'="ALL" S DIR("B")=FBFPPSL
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S FBRET=-1 G FPPSLX
 S FBRET=Y
 ;
FPPSLX ; FPPSL Exit
 I FBNOOUT,FBRET=-1 D  G ASKLI
 . W !,"'^' NOT ALLOWED"
 ; strip trailing comma if any
 I $E(FBRET,$L(FBRET))="," S FBRET=$E(FBRET,1,$L(FBRET)-1)
 Q FBRET
 ;
LIHLP ; Line Item ?? Help
 W !,"Enter the line item sequence number associated with this charge.  Each"
 W !,"charge on the FPPS invoice document will have a line item sequence number"
 W !,"associated with it.  A line item can be entered individually or a group of"
 W !,"charges from multiple lines can be entered.  If all line items in a group"
 W !,"are in numerical sequence, you may enter the first line item sequence"
 W !,"number followed by a hyphen and the last line item sequence number.  If"
 W !,"the grouped charges are not in sequential order, each line item must be"
 W !,"entered individually, followed by a comma."
 W !
 Q
ASKPAN() ; Ask Patient Account Number Extrinsic Function
 ; Return value (FBRET)
 ;   = PATIENT ACCOUNT NUMBER (if entered)
 ;   = null if value not entered
 ;   = '^' if time-out or '^'
 N FBRET
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S FBRET=""
 S DIR(0)="162.03,49"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S FBRET="^"
 I '$D(DIRUT) S FBRET=Y
 Q FBRET
 ;
ASKREVC() ; Ask Revenue Code Extrinsic Function
 ; Return value (FBRET)
 ;   = REVENUE CODE, internal pointer value (if entered)
 ;   = null if value not entered
 ;   = '^' if time-out or '^'
 N FBRET
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S FBRET=""
 S DIR(0)="162.03,48"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S FBRET="^"
 I '$D(DIRUT) S FBRET=+Y
 Q FBRET
 ;
ASKUNITS() ; Ask Units Paid Extrinsic Function
 ; Return value (FBRET)
 ;   = UNITS PAID (if entered)
 ;   = null if value not entered
 ;   = '^' if time-out or '^'
 N FBRET
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S FBRET=""
 S DIR(0)="162.03,47"
 S DIR("B")=1
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S FBRET="^"
 I '$D(DIRUT) S FBRET=Y
 Q FBRET
 ;
ASKPCN() ; Ask Patient Control Number Extrinsic Function
 ; Return value (FBRET)
 ;   = PATIENT ACCOUNT NUMBER (if entered)
 ;   = null if value not entered
 ;   = '^' if time-out or '^'
 N FBRET
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S FBRET=""
 S DIR(0)="162.5,55"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S FBRET="^"
 I '$D(DIRUT) S FBRET=Y
 Q FBRET
 ;
 ;FBUTL5
