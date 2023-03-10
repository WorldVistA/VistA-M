DGRP3 ;ALB/MRL,JAM,ARF - REGISTRATION SCREEN 3/CONTACT INFORMATION ;06 JUN 88@2300
 ;;5.3;Registration;**997,1067,1075**;Aug 13, 1993;Build 13
 ; 
 ; Patch DG*5.3*997 - Move address fields over 10 spaces and increase field widths by 10 to accomodate foreign address field display; jam
 ; Patch DG*5.3*1075 - Correct line 2 for SAC compliance
 ;
 S DGRPW=1,DGRPS=3 D H^DGRPU F I=.21,.211,.33,.331,.34 S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 ; DG*5.3*997 ; jam; expand width of the address fields 10 characters (from 24 and 27)
 S DGAD=.21,DGA1=3,DGA2=1 D:$P(DGRP(.21),"^",1)]"" AL^DGRPU(34) S DGAD=.211,DGA1=3,DGA2=2 D:$P(DGRP(.211),"^",1)]"" AL^DGRPU(37)
 F DGRPI=.21,.211 S DGRPI1=$S(DGRPI=".21":"X",1:"X1") D SET
 S Z=1 D WW^DGRPV W "       NOK: " S Z=$E($P(X,"^",1),1,22),Z1=28 D WW1^DGRPV S DGRPW=0,Z=2 D WW^DGRPV W " NOK-2: ",$E($P(X1,"^",1),1,25) D AW
 ; DG*5.3*997 ; jam; expand width of the address fields 10 characters (from 24 and 27)
 S DGRPW=1,DGAD=.33,DGA1=3,DGA2=1 D:$P(DGRP(.33),"^",1)]"" AL^DGRPU(34) S DGAD=.331,DGA1=3,DGA2=2 D:$P(DGRP(.331),"^",1)]"" AL^DGRPU(37)
 F DGRPI=.33,.331 S DGRPI1=$S(DGRPI=".33":"X",1:"X1") D SET
 ; DG*5.3*1067; arf; aligned colons
 S Z=3 D WW^DGRPV W "   E-Cont.: " S Z=$E($P(X,"^",1),1,25),Z1=25 D WW1^DGRPV S DGRPW=0,Z=4 D WW^DGRPV W " E2-Cont.: ",$E($P(X1,"^",1),1,25) D AW
 ; DG*5.3*997 ; jam; Designee address field width expanded to 37 characters (from 24)
 ; DG*5.3*1067; arf; moved Designee left one space and changed label to Relation Type
 K DGA S DGRPW=1,DGAD=.34,DGA1=3,DGA2=1 D:$P(DGRP(.34),"^",1)]"" AL^DGRPU(37) S DGRPI=.34,DGRPI1="X" D SET S Z=5 D WW^DGRPV W "  Designee: ",$E($P(X,"^",1),1,25),?39,"Relation Type: "
 W:$E($$GET1^DIQ(12.11,$P(DGRP(.34),"^",15),.02),1,25)="" "UNANSWERED" W:$E($$GET1^DIQ(12.11,$P(DGRP(.34),"^",15),.02),1,25)'="" $E($$GET1^DIQ(12.11,$P(DGRP(.34),"^",15),.02),1,25)
 ; DG*5.3*997 ; jam; move Designee address fields 10 characters to the left and expand width from 27 to 37 chars
 ;F I=0:0 S I=$O(DGA(I)) Q:'I  S Z="    "_$E(DGA(I),1,37) W !,Z
 ; DG*5.3*1067; arf; add Relation Note to screen when this field is not null
 F I=0:0 S I=$O(DGA(I)) Q:'I  S Z="    "_$E(DGA(I),1,37) W !,Z W:(I=1)&($E($P(X,"^",1),1,25)'="")&($P(X,"^",2)'="")&($P(X,"^",2)'="UNANSWERED") ?39,"Relation Note: ",$P(X,"^",2)
 ; DG*5.3*1067; arf; moved phone numbers to the right
 W !?8,"Phone: ",$P(X,"^",3),?42,"Work Phone: ",$P(X,"^",4)
Q K DGRPI,DGRPI1
 G ^DGRPP
 ;
 ;DG*5.3*1067 - add the RELATION TYPE field, piece 15 of the DGRP array, to output string in the 5th piece
SET S DGRPX=DGRPU_"^"_DGRPU_"^"_DGRPU_"^"_DGRPU
 F DGRPX1=1,2,9,11,15 I $P(DGRP(DGRPI),"^",DGRPX1)]"" S $P(DGRPX,"^",$S(DGRPX1=1:1,DGRPX1=2:2,DGRPX1=9:3,DGRPX1=15:5,1:4))=$P(DGRP(DGRPI),"^",DGRPX1)
 S @DGRPI1=DGRPX
 K DGRPX,DGRPX1
 Q
AW ;W !?4,"Relation: ",$E($P(X,"^",2),1,25),?43,"Relation: ",$E($P(X1,"^",2),1,25) F I=0:0 S I=$O(DGA(I)) Q:'I  S Z=$E(DGA(I),1,27) S:(I#2) Z="              "_Z W:(I#2)!($X>50) ! W:(I#2) Z I '(I#2) W ?53,Z
 ; DG*5.3*997;jam; address fields have been expanded 10 chars - move the address lines output over 10 spaces to accommodate this  
 ; DG*5.3*1067;arf; adding Type to Relation field and shifted left and alignged colons for Work Phone and Phone numbers
 ;W !?4,"Relation: ",$E($P(X,"^",2),1,25),?43,"Relation: ",$E($P(X1,"^",2),1,25) F I=0:0 S I=$O(DGA(I)) Q:'I  S Z=$E(DGA(I),1,37) S:(I#2) Z="    "_Z W:(I#2)!($X>40) ! W:(I#2) Z I '(I#2) W ?43,Z
 ;dg*5.3*1067 begin
 ;Display Relation Type; if NULL display UNANSWERED
 W !,"Relation Type: "
 I $P(X,U,5)'="" D
 . W $E($$GET1^DIQ(12.11,$P(X,U,5),.02),1,25)
 E  D
 . W "UNANSWERED"
 W ?39,"Relation Type: "
 I $E($$GET1^DIQ(12.11,$P(X1,"^",5),.02),1,25)'="" D
 . W $E($$GET1^DIQ(12.11,$P(X1,U,5),.02),1,25)
 E  D
 . W "UNANSWERED"
 ;Display the Relation Note fields only if they are populated
 I (($E($P(X,"^",2),1,25)'="UNANSWERED")&($E($P(X,"^",2),1,25)'="")) D
 . W !,"Relation Note: ",$E($P(X,"^",2),1,25)
 I ($E($P(X,"^",2),1,25)="UNANSWERED")&($E($P(X1,"^",2),1,25)'="UNANSWERED") W !
 I $P(X1,"^",2)'="UNANSWERED" W ?38," Relation Note: ",$E($P(X1,"^",2),1,25)
 ;dg*5.3*1067 end
 F I=0:0 S I=$O(DGA(I)) Q:'I  S Z=$E(DGA(I),1,37) S:(I#2) Z="    "_Z W:(I#2)!($X>40) ! W:(I#2) Z I '(I#2) W ?43,Z
 W !?8,"Phone: ",$P(X,"^",3),?47,"Phone: ",$P(X1,"^",3)
 W !?3,"Work Phone: ",$P(X,"^",4),?42,"Work Phone: ",$P(X1,"^",4)
 K DGA
 Q
DR300(DGEC,DGTYPEFN,DGNOTEFN) ;DG*5.3*1067 - EMERGENCY CONTACT SCREEN <3> - Relation Type and Relation Note prompts processing 
 ; Inputs:
 ;   DGEC     - Type of Contact ("K","K2","E","E2" or "D")
 ;   DGTYPEFN - Contact's RELATION TYPE field number
 ;   DGNOTEFN - Contact's RELATIONSHIP TO PATIENT field number (referred to as Relation Note)
 ;
 ; Returns: 0 if user times out or quits with ^
 ; 
 ; For all 5 contact types, handle user input of the patient relationship data. (Called from DGRPE)
 ; The relationship to patient is a standardized list and stored in new Relation Type fields in the patient file.
 ; The previous Relationship to Patient (free text) will now be used store any miscellaneous notes the user wishes to add
 ; The prompt on the screen for this field is "Relation Note:"
 ;
 N DA,DIR,DGFDA,DGERR,X,Y,DTOUT,DUOUT,DGTYPENAME,DGTYPENEWNM,DGNOTEVAL
 ; Get the current contact RELATION TYPE value (external) from the patient record
 S DGTYPENAME=$$GET1^DIQ(12.11,$$GET1^DIQ(2,DFN_",",DGTYPEFN),.02)
 ; prompt user
 S:DGTYPENAME'="" DIR("B")=DGTYPENAME
 S DIR(0)="2,"_DGTYPEFN,DA=DFN,DIR("A")=DGEC_"-RELATION TYPE"
RELTYPE ; Prompt for RELATION TYPE 
 D ^DIR
 ; quit on ^ or timeout (set DGTMOT for timeout)
 I $D(DUOUT) Q 0
 I $D(DTOUT) S DGTMOT=1 Q 0
 I Y="" W !,"This is a required field." G RELTYPE ;required response redisplay prompt
 S DGFDA(2,+DFN_",",DGTYPEFN)=+Y
 D FILE^DIE("","DGFDA","DGERR")
 ; Get the new RELATION TYPE value (external) that was filed
 S DGTYPENEWNM=$$GET1^DIQ(12.11,$$GET1^DIQ(2,DFN_",",DGTYPEFN),.02)
 ; If the RELATION TYPE name has changed, copy it into the Relation Note field
 I (DGTYPENEWNM'=DGTYPENAME) D 
 . ; Get the current text stored in the Relation Note field
 . S DGNOTEVAL=$$GET1^DIQ(2,DFN_",",DGNOTEFN,"E")
 . ; If the Relation Note is the same as the new RELATION TYPE name, no copy needed - quit
 . I DGTYPENEWNM=DGNOTEVAL Q
 . ; Otherwise copy the RELATION TYPE name to the Relation Note field
 . K DGFDA
 . S DGFDA(2,+DFN_",",DGNOTEFN)=DGTYPENEWNM
 . D FILE^DIE("","DGFDA","DGERR")
 . ; If the Relation Note field was not null, notify the user of the old and new value prior to prompting them for that field
 . I DGNOTEVAL'="" W !,"**The "_DGEC_"-RELATION NOTE field is changed from "_DGNOTEVAL_" to "_DGTYPENEWNM_"**"
 ; Prompt user for Relation Note value
 K DIR
 S DIR(0)="2,"_DGNOTEFN,DA=DFN,DIR("A")=DGEC_"-RELATION NOTE"
 S:$$GET1^DIQ(2,DFN_",",DGNOTEFN,"E")'="" DIR("B")=$$GET1^DIQ(2,DFN_",",DGNOTEFN,"E")
RELNOTE ; Tag for re-prompting 
 D ^DIR
 ; quit on ^ or timeout (set DGTMOT for timeout)
 I $D(DUOUT) Q 0
 I $D(DTOUT) S DGTMOT=1 Q 0
 I X="@" W !,"The field may not be deleted." G RELNOTE
 I Y="" Q 1
 K DGFDA
 S DGFDA(2,+DFN_",",DGNOTEFN)=Y
 D FILE^DIE("","DGFDA","DGERR")
 Q 1
