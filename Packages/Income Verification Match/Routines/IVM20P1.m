IVM20P1 ;ALB/CPM - IVM V2.0 POST INIT, SET HL7 PARAMETERS ; 24-JUN-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;
HL7 ; Set up all HL7 parameters
 Q:+$G(^DD(301.5,0,"VR"))'<2
 D HL7713,HL771,HL770
 K IVMAPP,IVMDIEN,IVMMIEN,IVMPRODL,IVMSEG
 Q
 ;
 ;
HL7713 ; Add HL7 segments
 W !!,">>> Adding 'Z' segments to HL7 SEGMENT NAME file (#771.3)..."
 S IVMFLG=0
 F IVMI=1:1 S IVMTXT=$P($T(SEG+IVMI),";;",2) Q:IVMTXT="QUIT"  D
 .S X=$P(IVMTXT,"^",1) I $O(^HL(771.3,"B",X,0)) Q
 .S (DIK,DIC)="^HL(771.3,",DIC(0)="L",DLAYGO=771.3
 .K DD,DO,DINUM D FILE^DICN S DA=+Y
 .L +^HL(771.3,DA) S ^HL(771.3,DA,0)=IVMTXT D IX1^DIK L -^HL(771.3,DA)
 .S IVMFLG=1 W !," >> ",$P(IVMTXT,"^",1)," (",$P(IVMTXT,"^",2),") segment added"
 I 'IVMFLG W !?3,"All segments already exist...none added"
HL7713Q K DA,DIC,DIK,DLAYGO,IVMFLG,IVMI,IVMTXT
 Q
 ;
 ;
HL771 ; Update HL7 DHCP application
 S (DA,IVMDIEN)=$O(^HL(771,"B","IVM",0))
 W !!,">>> ",$S('DA:"Adding",1:"Updating")," HL7 DHCP APPLICATION PARAMETER file entry for IVM..."
 I 'DA D  I DA<1 G HL771Q
 .S DIC="^HL(771,",DIC(0)="L",DLAYGO=771,X="IVM"
 .K DD,DO D FILE^DICN S (DA,IVMDIEN)=+Y
 S ^HL(771,DA,0)="IVM^a"
 S ^HL(771,DA,"EC")="~|\&",^("FS")="^"
 S ^HL(771,DA,"MSG",0)="^771.06P^3^3"
 S ^HL(771,DA,"MSG",1,0)=$O(^HL(771.2,"B","ORU",0)),^("R")="ORU^IVMPREC2"
 S ^HL(771,DA,"MSG",2,0)=$O(^HL(771.2,"B","QRY",0)),^("R")="QRY^IVMPREC"
 S ^HL(771,DA,"MSG",3,0)=$O(^HL(771.2,"B","ACK",0)),^("R")="ACK^IVMPREC1"
 S ^HL(771,DA,"SEG",0)="^771.05P^15^15"
 S ^HL(771,DA,"SEG",1,0)=$$IEN("PID"),^("F")="1,3,5,7,8,11,12,13,14,19"
 S ^HL(771,DA,"SEG",2,0)=$$IEN("ZCT"),^("F")="1,2,3,4,5,6,7"
 S ^HL(771,DA,"SEG",3,0)=$$IEN("ZDP"),^("F")="1,2,3,4,5,6,7,8,9"
 S ^HL(771,DA,"SEG",4,0)=$$IEN("ZEL"),^("F")="1,2,6,7,10,11,13"
 S ^HL(771,DA,"SEG",5,0)=$$IEN("ZEM"),^("F")="1,2,3"
 S ^HL(771,DA,"SEG",6,0)=$$IEN("ZGD"),^("F")="1,2,3,4,5,6,7,8"
 S ^HL(771,DA,"SEG",7,0)=$$IEN("ZIC"),^("F")="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20"
 S ^HL(771,DA,"SEG",8,0)=$$IEN("ZMT"),^("F")="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21"
 S ^HL(771,DA,"SEG",9,0)=$$IEN("ZPD"),^("F")="1,8,9,11,12,13"
 S ^HL(771,DA,"SEG",10,0)=$$IEN("ZTA"),^("F")="1,3,4,5,6,7"
 S ^HL(771,DA,"SEG",11,0)=$$IEN("ZIO"),^("F")="1,2,3,4"
 S ^HL(771,DA,"SEG",12,0)=$$IEN("ZIR"),^("F")="1,2,3,4,5,6,7,8,9,10"
 S ^HL(771,DA,"SEG",13,0)=$$IEN("NTE"),^("F")="1,3"
 S ^HL(771,DA,"SEG",14,0)=$$IEN("FT1"),^("F")="1,4,6,7,9,11"
 S ^HL(771,DA,"SEG",15,0)=$$IEN("IN1"),^("F")="1,4,5,7,8,9,12,13,15,16,17,28,36"
 S ^HL(771,DA,"SEG",16,0)=$$IEN("ZIV"),^("F")="1,2,3,4,5,6,7,8,9,10,11,12"
 S DIK="^HL(771," D IX1^DIK
HL771Q K DA,DIC,DIK,DLAYGO,X,Y
 Q
 ;
 ;
HL770 ; Add HL7 non-DHCP app entry
 S X=$O(^HL(770,"B","IVM CENTER",0)) I $D(^HL(770,+X,0)) G HL770Q
 W !!,">>> Adding HL7 NON-DHCP APPLICATION entry for IVM CENTER..."
 S DIC="^HL(770,",DIC(0)="L",DLAYGO=770,X="IVM CENTER"
 K DD,DO D FILE^DICN S DA=+Y I DA<1 G HL770Q
 S ^HL(770,DA,0)="IVM CENTER^"_+$P($$SITE^VASITE,"^",3)_"^724^245^^^1^"_IVMDIEN_"^^"_IVMMIEN_"^^^^P"
 S DIK=DIC D IX1^DIK
HL770Q K DA,DIC,DIK,DLAYGO,X,Y
 Q
 ;
 ;
SEG ; list of segments for HL7 SEGMENT file
 ;;ZCT^VA Emergency Contact^1
 ;;ZDP^VA Dependent Information^1
 ;;ZEL^VA Patient Eligibility^1
 ;;ZEM^VA Employment Information^1
 ;;ZGD^VA Guardian^1
 ;;ZIC^VA Patient Income^1
 ;;ZIV^VA IVM Message Processing^1
 ;;ZMT^VA Means Test Information^1
 ;;ZPD^VA Patient Information^1
 ;;ZTA^VA Temporary Address^1
 ;;ZIO^VA Patient Care Statistics^1
 ;;ZIR^VA Specific Income Information^1
 ;;QUIT
 ;
 ;
IEN(IVMSEG) ; get ien for segment from hl7 segment file
 Q $O(^HL(771.3,"B",IVMSEG,0))
 ;
 ;
BULL ; Send notification to the IVM Center once the facility has installed v2.0.
 Q:+$G(^DD(301.5,0,"VR"))'<2
 Q:'$G(IVMPROD)  ; don't send notice when installing in Test
 N DIFROM
 W !!,">>> Sending a 'completed installation' notice to the IVM Center... "
 S XMSUB="IVM VERSION 2.0 INSTALLATION"
 S XMDUZ="IVM PACKAGE"
 S XMY("WEATHERLY@IVM.VA.GOV")="",XMY(DUZ)="",XMY(.5)=""
 S XMTEXT="IVMTEXT("
 S IVMX=$$SITE^VASITE
 S IVMTEXT(1)="  Facility:                     "_$P(IVMX,"^",2)
 S IVMTEXT(2)="  Station Number:               "_$P(IVMX,"^",3)
 ;
 D NOW^%DTC S Y=% D DD^%DT
 S IVMTEXT(3)="  Installed IVM Version 2.0 on: "_Y
 D ^XMD
 K IVMTEXT,IVMX,XMDUZ,XMSUB,XMTEXT,XMY,%
 Q
