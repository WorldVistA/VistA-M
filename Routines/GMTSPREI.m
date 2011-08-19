GMTSPREI ;SLC/SBW - GMTS* Preinit ;4/18/95
 ;;2.7;Health Summary;;Oct 20, 1995
MAIN ; Controls branching
 N GMI
 W !!,"First I need to run a pre-init...."
 W !,"Starting pre-init now...."
 S GMTSIST=$$NOW
 D APPGRP,RENMED
 D DELFLD ;Entry point to delete obsolete fields in file #142
 W !,"Pre-init successfully completed!"
 Q
APPGRP ; Add "GMTS" Application Group to file 60, 71, 120.51, 9999999.64,
 ; 9001017, and 811.9. Done only if not there already.
 N GMI
 F GMI=60,71,120.51,9999999.64,9001017,811.9 I '$D(^DIC(GMI,"%","B","GMTS")) K DD,DO S DIC="^DIC("_GMI_",""%"",",DIC(0)="L",DA(1)=GMI,X="GMTS" D FILE^DICN K DIC,DA W:+Y>0 !!,"Adding ""GMTS"" Application Group to ^DIC("_GMI_",",!
 Q
RENMED ; Rename medicine summary comp. abbreviation
 N GMDA,DA,DIE,DR
 Q:+$D(^GMT(142.1))'>0
 F X="MEDICINE SUMMARY" D
 . S DIC=142.1,DIC(0)="X" D ^DIC I +Y'>0  Q
 . S DIE=142.1,DR="3///MEDS",DA=+Y D ^DIE
 . W !!,"** Renaming Medicine Summary Abbreviation from MED to MEDS **"
 Q
DELFLD ; Deletes obsolete fields in Health Summary Type (#142) file
 N DIK,DA,GMX,DIU
 Q:+$D(^GMT(142))'>0
 F GMX=2,3,4,5,6 D
 . S DA=GMX,DIK="^DD(142,"
 . D ^DIK W !,"Deleting field # ",GMX," in the Health Summary Type (#142) file."
 F DIU=142.02,142.05,142.06 S DIU(0)="S" D EN^DIU2
 Q
NOW() ; Extrinsic special variable to return current date/time
 N %,%H,%I,X
 D NOW^%DTC
 Q +$G(%)
