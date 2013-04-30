EDP2ENV ;SLC/BWF - Environment check ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
EN ;
 N VER
 S VER=$$VERSION^XPDUTL("EDP")
 I VER'=1.0 D  Q
 .I VER<1 S XPDABORT=1 D MSG Q
 Q
MSG ;
 W !!,"Version 1.0 is required and must be installed to continue."
 W !,"Please install and configure version 1.0 before continuing.",!
 Q
