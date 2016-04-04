DITM2 ;SFISC/JCM(OHPRD)-DOES COMPARE AND MERGE ;11/18/94  15:42
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ; See DITMDOC for documentation
 ; Subfiles are not currently supported by the call to EN^DITM2
 ; until DITC can handle them.
 ;-------------------------------------------------------------------
START ;
EN ; Entry point
 L +@(DITM("DIC")_$P(DITM("DIT(1)"),",",1)_")")
 L +@(DITM("DIC")_$P(DITM("DIT(2)"),",",1)_")")
 K DMSG,DIRUT
 D:'$D(DITM("NON-INTERACTIVE")) DITC ; --->Sets up and calls DITC
 I $D(DMSG)!($D(DIRUT)) S DITM("QFLG")="" G END
 G:'$D(DITM("DIMERGE")) END
 D:'$D(DITM("SUB FILE")) DIT0 ; --->Sets up and calls DIT0
 D:$D(DITM("REPOINT"))&('$D(DITM("SUB FILE"))) REPOINT ;---->Merges
 ;---------------->other files that affect patient merge
 G:$D(DITM("QFLG")) END
 D:$D(DITM("DELETE")) DELETE ;----->Deletes MERGED entry
END L -@(DITM("DIC")_$P(DITM("DIT(1)"),",",1)_")")
 L -@(DITM("DIC")_$P(DITM("DIT(2)"),",",1)_")")
 D EOJ ;----------->Cleanup
 Q  ;-------------->End of routine
 ;----------------------------------------------------------------------
DITC ;
 ;***Will need to add set up for subfiles when it works******
 ;
 K DFF,DIT,DIMERGE,DDIF,DDEF,DDSP
 S DFF=DITM("DFF"),DIT(1)=DITM("DIT(1)"),DIT(2)=DITM("DIT(2)"),DIC=DITM("DIC")
 S:$D(DITM("DIMERGE")) DIMERGE=1
 S:$D(DITM("DDIF")) DDIF=DITM("DDIF")
 S:$D(DITM("DDEF")) DDEF=DITM("DDEF")
 S:$D(DITM("DDSP")) DDSP=1
 D EN^DITC
 K DFF,DIT,DIMERGE,DDIF,DDEF,DDSP
 Q
DIT0 ;
 W:'$D(DITM("NOTALK")) !!,"I will now merge all subfiles in this file ...",!,"This may take some time, please be patient."
 K DA
 S (DIT("T"),DIT("F"))=DITM("DIC")
 S (D0,DA("T"))=DITM("DIT(2)"),DA("F")=DITM("DIT(1)")
 D EN^DIT0 K D0,DA,DIC,DIK,DIT
 Q
REPOINT ;
 S DITMGMQF=0
 S:$D(DITM("NON-INTERACTIVE")) DITMGMRG("NOTALK")=1
 S:$D(DITM("PACKAGE")) DITMGMRG("PACKAGE")=DITM("PACKAGE")
 W:'$D(DITM("NOTALK")) !!,"I will now repoint all files that point to this entry ...",!,"This may take some time, please be patient."
 S DITMGMRG("FILE")=DITM("DFF"),DITMGMRG("FR")=DITM("DIT(1)"),DITMGMRG("TO")=DITM("DIT(2)")
 S:$D(DITM("NOTALK")) DITMGMRG("NOTALK")=""
 I $D(DITM("EXCLUDE")) F DITMI=0:0 S DITMI=$O(DITM("EXCLUDE",DITMI)) Q:'DITMI  S DITMGMRG("EXCLUDE",DITMI)=""
 D EN^DITMGMRG
 K DITMGMRG,DITMGMQF,DITMI
 Q
DELETE ;
 W:'$D(DITM("NOTALK")) !,"Deleting From entry"
 I $D(DITM("SUB FILE")) D DELSUB G DELETEX
 S DIK=DITM("DIC"),DA=DITM("DIT(1)") D ^DIK K DA,DIK
DELETEX Q
 ;
DELSUB ;
 S DA(1)=$P(DITM("DIT(1)"),",",1),DA=$P(DITM("DIT(1)"),",",2)
 S DIK=DITM("DIC")_DA(1)_","_DITM("DSUB1")_"," D ^DIK K DA,DIK
 Q
EOJ ;
 K DITM2,APMMD,DIC,X,Y
 Q
