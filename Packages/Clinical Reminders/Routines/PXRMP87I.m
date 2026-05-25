PXRMP87I ;ISP/AGP - PATCH 87 INSTALLATION ;Mar 31, 2025@15:37:48
 ;;2.0;CLINICAL REMINDERS;**87**;Feb 04, 2005;Build 35
 ;
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="CPRS INFO PANEL"
 I MODE["I" S ARRAY(LN,2)="02/20/2025@13:55:09"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 Q
 ;
PRE ;Pre-init
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP87I")
 Q
 ;
POST ;Post-init
 ;Install Exchange File entries.
 N PXRMEXCH
 S PXRMEXCH=1
 D SETCOVID
 D SETTERMUSAGE
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP87I")
 Q
 ;
SETCOVID ;
 D BMES^XPDUTL("Updating VA-COVID-19 CPRS STATUS usage value")
 N DA,DIE,DR,PXRMINST,Y
 S PXRMINST=1
 S DA=+$O(^PXD(811.9,"B","VA-COVID-19 CPRS STATUS",""))
 I DA=0 D BMES^XPDUTL("  Could not find entry in file 811.9")
 S DIE="^PXD(811.9,"
 S DR="103///RI"
 D ^DIE
 D BMES^XPDUTL("  Done")
 Q
 ;
SETTERMUSAGE ;
 D BMES^XPDUTL("Setting reminder terms usage field value")
 N DA,DIE,DR,PXRMINST,Y
 S PXRMINST=1
 S DIE="^PXRMD(811.5,"
 S DR="103///*"
 S DA=0 F  S DA=$O(^PXRMD(811.5,DA)) Q:DA'>0  D
 .I $P($G(^PXRMD(811.5,DA,100)),U,4)'="" Q
 .K Y D ^DIE
 D BMES^XPDUTL("  Done")
 Q
 ;
