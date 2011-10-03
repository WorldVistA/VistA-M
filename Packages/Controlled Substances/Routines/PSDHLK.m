PSDHLK ;BIR/LTL-HL7 inteface for Control Subs invoked by post init ; 21 Feb 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
CHECK ;check for Narcotic Dispensing Equipment System/HL7 interface
 N DA,DIC,DIE,DLAYGO,DR,PSD,PSDC,PSDN,X,Y
 D:XPDQUES("POS1")=1  G:XPDQUES("POS1")'=1 END
 .D MES^XPDUTL("  Updating FACILITY NAME for PSD-CS entry in file #771.")
 .S DIC="^DIC(4,",DR=99,DA=+$P($G(^XMB(1,1,"XUS")),U,17),DIQ="PSD"
 .D EN^DIQ1 S PSD=PSD(4,DA,99) K DIC,DR,DIQ,DA
 .S DIE="^HL(771,",DA=$O(^HL(771,"B","PSD-CS",0))
 .S DR="3////"_PSD
 .D ^DIE K DIE,DR,DA,PSD
PROTO ;Picked HLLP or X3.28 protocol
 G:XPDQUES("POS2")="X" ^PSDHLY
HLLP D:XPDQUES("POS2")="H"
 .S DIE="^HLCS(869.2,",DA=$O(^HLCS(869.2,"B","PSD-NDES HLLP",0))
 .D MES^XPDUTL("  Updating DEVICE for PSD-NDES HLLP entry in file #869.2.")
 .S DR="200.01////"_+$G(XPDQUES("POS4")) D ^DIE
 K DA,DIE,DR
END Q
