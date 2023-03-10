PSO441PI ;SLC/TDP - Post-intall for PSO*7*441 ;Dec 09, 2021@13:46
 ;;7.0;OUTPATIENT PHARMACY;**441**;DEC 1997;Build 208
 ;
 Q
 ;
POST ; Entry Point for post-install
 D MES^XPDUTL("  Starting post-install of PSO*7*441")
 N PSORDHM,PSOHA1,XQORM,I
 ; Remove ^XUTL entry for hidden action menu protocols
 ; Get the IEN for the PSO HIDDEN ACTIONS
 S PSOHA1=$O(^ORD(101,"B","PSO HIDDEN ACTIONS",0))
 ;
 F I=PSOHA1 S XQORM=I_";ORD(101," I $D(^XUTL("XQORM",XQORM)) D
 . D BMES^XPDUTL("    Removing cached hidden menu for "_$P(^ORD(101,I,0),U,1))
 . K ^XUTL("XQORM",XQORM)
 ;
 D DELDD,SETPKOFF,ENPROT
 ;
 D BMES^XPDUTL("  Finished post-install of PSO*7*441")
 Q
 ;
DELDD ;DELETE FIELD #2009 FROM FILE #59 IN DATA DICTIONARY
 I '$D(^DD(59,2009)) Q  ;no need to run again
 D BMES^XPDUTL("    Deleting Park Function (#2009) field from the Outpatient Site (#59) file")
 D MES^XPDUTL("      in Data Dictionary.")
 N PSOX
 S PSOX=0 F  S PSOX=$O(^PS(59,PSOX)) Q:'PSOX  I $P($G(^PS(59,PSOX,1)),"^",34)]"" S DR="2009////@",DIE="^PS(59,",DA=PSOX D ^DIE
 K DIE,DR
 S DIK="^DD(59,",DA=2009,DA(1)=59
 D ^DIK
 D BMES^XPDUTL("    Deletion from Data Dictionary complete.")
 K DA,DIK,DIE,DR
 Q
 ;
SETPKOFF ;Set Default PSO PARK ON parameter to NO
 N PSOERR
 ;S PARAM=$$GET^XPAR("PKG","PSO PARK ON",,"I")
 ;I PARAM=0 Q
 D EN^XPAR("PKG","PSO PARK ON",,"NO",.PSOERR)
 I PSOERR=0 D BMES^XPDUTL("    PSO PARK ON parameter set to ""NO"" at the Package level.")
 I PSOERR'=0 D
 . D BMES^XPDUTL("    Error setting PSO PARK ON parameter to ""NO"" at the Package level.")
 . D MES^XPDUTL("      Error: "_$P(PSOERR,U,2))
 Q
 ;
ENPROT ;Enable protocol PSO LM PAT PREG/LACT DISPLAY
 D OUT^XPDPROT("PSO LM PAT PREG/LACT DISPLAY","@")
 D BMES^XPDUTL("    Enabled the PSO LM PAT PREG/LACT DISPLAY protocol.")
 Q
