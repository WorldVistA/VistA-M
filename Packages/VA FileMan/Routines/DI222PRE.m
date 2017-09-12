DI222PRE ;HPE/MSC/STAFF - FM22E Preinstall Routine;3:07 AM  14 Aug 2015
V ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ; FM22E Preinstall routine
EN ;
 D MES^XPDUTL("Initializing FileMan version 22.2...")
 D NOASK^DINIT ;Initialize v22.2 with no user intervention
 D MES^XPDUTL("Initialization of FileMan version 22.2 has been completed.")
 ;
LANG ;Language Files Reset
 N DIU
 S DIU="^DI(.85,",DIU(0)="D" D EN^DIU2
 ;
STFIX ;Delete erroneous nodes in Sort Template File
 ;Sprint 10 only. DPC.
 K ^DD(.4014,20401,21,1,0)
 K ^DD(.4014,20402,21,1,0)
 ; 
 Q
