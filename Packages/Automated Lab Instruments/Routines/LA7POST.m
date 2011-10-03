LA7POST ;;DALISC/KAT - POST INIT TO POPULATE DHCP HL7 FILE 771
 ;;5.2;LAB MESSAGING;**17**;Feb 29, 1996
 ; Add entry to HL7 DHCP APPLICATION PARAMETER file
 ;
 S LA7DIEN=$O(^HL(771,"B","LA AUTO INST",0)) I $D(^HL(771,+LA7DIEN,0)) W !!,">>>LA AUTO INST entry already exist..." G QUIT
 W !!,">>>Adding HL7 DHCP APPLICATION file entry for LA AUTO INST..."
 K DINUM,DD,DO
 S X="LA AUTO INST",DIC="^HL(771,",DIC(0)="L",DLAYGO=771 D FILE^DICN S (DA,LA7DIEN)=+Y
 S ^HL(771,DA,0)="LA AUTO INST^a"
 S ^HL(771,DA,"EC")="^~\&",^("FS")="|"
 S ^HL(771,DA,"MSG",0)="^771.06P^2^2"
 S ^HL(771,DA,"MSG",1,0)=$O(^HL(771.2,"B","ORU",0)),^("R")="ORU^LA7HL7"
 S ^HL(771,DA,"MSG",2,0)=$O(^HL(771.2,"B","ORM",0)),^("R")="NONE"
 S ^HL(771,DA,"SEG",0)="^771.05P^10^10"
 S ^HL(771,DA,"SEG",1,0)=$$IEN("OBR"),^("F")="4,7,8,9,14.22"
 S ^HL(771,DA,"SEG",2,0)=$$IEN("OBX"),^("F")="2,3,4,5,6,7,8"
 S ^HL(771,DA,"SEG",3,0)=$$IEN("MSH"),^("F")="1,2,3,4,5,6,7,8,9,10,11,12"
 S ^HL(771,DA,"SEG",4,0)=$$IEN("PID"),^("F")="3,5,7,8,19"
 S ^HL(771,DA,"SEG",5,0)=$$IEN("ORC"),^("F")="1,2,3"
 S ^HL(771,DA,"SEG",6,0)=$$IEN("NTE"),^("F")="3"
 S DIK=DIC D IX1^DIK
QUIT K DA,DIC,DIK,DLAYGO,X,Y
 Q
 ;
 ;
IEN(LA7SEG) ; get ien for segment from hl7 segment file
 Q $O(^HL(771.3,"B",LA7SEG,0))
 Q
