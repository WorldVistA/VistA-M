DVBAPST3 ;ALB/JLU;post init to set up hl7 files ;05/03/93
 ;;2.7;AMIE;;Apr 10, 1995
EN ;main entry point
 I +$$VERSION^XPDUTL("HL")<1.5 W !,"HL7 Version 1.5 not installed, I will not attempt to set up the AMIE/Kurzweil entries." Q
 ;check for DVBA AMIE entry in file 771
 K DIC,X,Y
 S DIC="^HL(771,",X="DVBA AMIE",DIC(0)="MO" D ^DIC
 I Y>0 W *7,!!,"The HL7 DHCP Application Parameter file (771) already ",!,"has a DVBA AMIE  entry!  No updating of this file." K DIC,X,Y G EN1
 K DO,DD
 S DIC="^HL(771,",DIC(0)="AELMQ",DIC("DR")="2///ACTIVE",X="DVBA AMIE"
 W !!,"."
 W !,"Setting up the entry in the HL7 DHCP Application Parameter file (771)."
 S DLAYGO=771
 D FILE^DICN
 K DLAYGO
 I Y<0 W !!,*7,"An error has occurred entering the entry into file 771. This file must be checked and set up properly.  Continuing on to 770."
 I Y>0 D ENTRY1
 ;
EN1 K DIC,DIE,DD,DO
 ;check for AMIE entry in file 770
 K DIC,X,Y
 S DIC="^HL(770,",X="AMIE",DIC(0)="MO" D ^DIC
 I Y>0 W *7,!!,"The HL7 Non-DHCP Application Parameter file (770) already",!,"has an  AMIE  entry.  No updating of this file." K DIC,X,Y Q
 S DIC="^HL(770,",DIC(0)="AELMQ",X="AMIE"
 S DIC("DR")="3///KURZWEIL;4///245;5///3;7///2.1;8///DVBA AMIE;9///30;14///P"
 W !!,"Now setting up the entry in the HL7 Non-DHCP Application Parameter file (770).",!!
 S DLAYGO=770
 D FILE^DICN
 K DLAYGO
 ;
 I Y<0 W !!,*7,"An error has occurred entering the necessary entry in file 770.  This entry must be set up before use." Q
 ;
 ;ask for Station Number and HL7 Device (site specific fields in 770)
 K DA,DIE,DR
 S DA=$P(Y,"^"),DIE="^HL(770,",DR="2;6"
 D ^DIE
 ;
WR1 W !!!,"The post init has finished!"
 ;
EXIT K DIC,DIE,DVBA,DVBVAR,DR,DA,Y,X
 Q
 ;
ENTRY1 K DIC,DIE,DR
 S DIC(0)="LMQ"
 S DA=+Y
 S DIE="^HL(771,"
 S DR="5///QRD"
 S DR(2,771.05)=".01///QRD;2///1"
 S DLAYGO=771
 D ^DIE K DLAYGO
 I '$D(DA) D WR Q
 S DIC(0)="LMQ",DIE="^HL(771,"
 F DVBA=1:1:6 D SET,^DIE K DLAYGO I '$D(DA) D WR Q
 Q
 ;
WR W !,*7,"An error has occurred entering the message or segment types into file 771.  Please check"
 W !,"this file to make sure all the necessary file entries exists."
 Q
 ;
TYPE ;these are the hl7 message types and routines
 ;;ORU^DVBCHLR
 ;;ORM^DVBCHLOR
 ;;QRY^DVBCHLQ
 ;;ORR^NONE
 ;;ORF^NONE
 ;;ACK^NONE
 Q
 ;
SET ;
 K DR
 S DVBVAR=$E($T(TYPE+DVBA),4,99)
 S DR="6///"_$P(DVBVAR,U,1)
 S DR(2,771.06)=".01///"_$P(DVBVAR,U,1)_";1///"_$P(DVBVAR,U,2)
 S DLAYGO=771
 Q
