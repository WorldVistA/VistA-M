DGPWPOST ;ALB/CM POST INIT FOR WRISTBAND ; 12/4/95
 ;;5.3;Registration;**62**;Aug 13, 1993
 ;
 ;This post init will add the Wristband entry to the EMBOSSED CARD
 ;TYPE file #39.1.  The entry is added via the post init due to the
 ;pointer values that are included in the entry, they could be different
 ;values from site to site.
 ;
EN ;
 ;Add WRISTBAND entry to the file
 W !!,"Post Init...."
 S DIC="^DIC(39.1,",DIC(0)="LZM",DLAYGO=39.1,X="WRISTBAND"
 D ^DIC
 K DIC,DLAYGO,X
 I +Y<0 W !,"Unable to add WRISTBAND entry to file 39.1",!,"Contact your IRMFO for assistance.",! Q
 I $P(Y,U,3)'=1 W !,"An entry already exists for WRISTBAND in EMBOSSED CARD file (#39.1)." Q
 N ENTRY
 S ENTRY=+Y
 W !,"Adding WRISTBAND entry to EMBOSSED CARD TYPE file (#39.1)...",!
 ;
 ;look up data items in Embossing Data file #39.2 to be added to the
 ;WRISTBAND entry
 ;
 N WARD,PID,BIRTH,BLANK,ALL,REL,NAME
 ;
 F X="WARD LOCATION","PID","NAME","DOB","RELIGION","BLANK","ALLERGY" D
 .S DIC="^DIC(39.2,",DIC(0)="ZMOX",DLAYGO=39.2
 .D ^DIC
 .I +Y<0 W !,"Unable to find "_X_" in file 39.2.",!,"Contact your IRMFO for assistance.",! Q
 .I X="WARD LOCATION" S WARD=+Y
 .I X="PID" S PID=+Y
 .I X="NAME" S NAME=+Y
 .I X="DOB" S BIRTH=+Y
 .I X="RELIGION" S REL=+Y
 .I X="BLANK" S BLANK=+Y
 .I X="ALLERGY" S ALL=+Y
 .K Y,X,DIC
 ;
 ;Hard set the global entry
 ;
 S ^DIC(39.1,ENTRY,0)="WRISTBAND^^^1^^"_ENTRY
 S ^DIC(39.1,ENTRY,1,0)="^39.11^^4"
 S ^DIC(39.1,ENTRY,1,1,0)=1
 S ^DIC(39.1,ENTRY,1,1,1,0)="^39.12P^2^2"
 S ^DIC(39.1,ENTRY,1,1,1,1,0)=NAME_"^1^30"
 S ^DIC(39.1,ENTRY,1,1,1,2,0)=WARD_"^32^30"
 S ^DIC(39.1,ENTRY,1,2,0)=2
 S ^DIC(39.1,ENTRY,1,2,1,0)="^39.12P^3^3"
 S ^DIC(39.1,ENTRY,1,2,1,1,0)=PID_"^1^14"
 S ^DIC(39.1,ENTRY,1,2,1,2,0)=BIRTH_"^17^12"
 S ^DIC(39.1,ENTRY,1,2,1,3,0)=REL_"^35^2"
 S ^DIC(39.1,ENTRY,1,3,0)=3
 S ^DIC(39.1,ENTRY,1,3,1,0)="^39.12P^1^1"
 S ^DIC(39.1,ENTRY,1,3,1,1,0)=BLANK_"^1"
 S ^DIC(39.1,ENTRY,1,4,0)=4
 S ^DIC(39.1,ENTRY,1,4,1,0)="^39.12P^1^1"
 S ^DIC(39.1,ENTRY,1,4,1,1,0)=ALL_"^1^40"
 ;
 ;Re-index "C" cross reference
 S DIK="^DIC(39.1,",DA=ENTRY,DIK(1)="5^C"
 D EN^DIK
 K DIK,DA
 ;
 W !,"Post Init completed."
 Q
