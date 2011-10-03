PSDHLY ;BIR/LTL-HL7 inteface setup invoked by PSDHL7 for X3.28 ; 21 Feb 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
X328 N DIE,DA,DR,PSD
 S DIE="^HLCS(869.2,",(DA,PSD(1))=$O(^HLCS(869.2,"B","PSD-NDES X3.28",0))
 D MES^XPDUTL("  Updating device for PSD-NDES X3.28 entry in file #869.2.")
 S DR="300.01////"_+$G(XPDQUES("POS3")) D ^DIE K DIE,DR,DA
 D MES^XPDUTL("Updating Clients with your X3.28 logical link:")
 S PSD="PSD",DIE="^ORD(101,"
 F  S PSD=$O(^ORD(101,"B",PSD)) Q:PSD']""!($E(PSD,1,3)'="PSD")  D:PSD["C"
 .S DR="770.7////"_PSD(1) D MES^XPDUTL(PSD)
 .S DA=$O(^ORD(101,"B",PSD,0)) D ^DIE
END Q
