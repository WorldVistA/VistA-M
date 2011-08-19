DGYUPOST ;ALB/LD - Post Init for Patch DG*5.3*58 ; 7/11/95
 ;;5.3;Registration;**58**;Aug 13, 1993
 ;
 ;
 ;-- correct misspelled station type names from STATION TYPE file #45.81
 ;
 N DGI,I,TEXT
 W !!,">>> Correcting misspelled Station Type names from STATION TYPE file (#45.81)...",!
 F I=1:1 S TEXT=$P($T(LIST+I),";;",2) Q:TEXT="QUIT"  D
 .S DGI="",DGI=$O(^DIC(45.81,"C",$P(TEXT,"^"),DGI)) Q:DGI']""
 .S DIE="^DIC(45.81,",DA=+DGI,DR="2///"_$P(TEXT,"^",2) D ^DIE
 .W !?3,"Name "_$P(TEXT,"^")_" changed to "_$P(TEXT,"^",2)_"."
 W !!?1,"...done.",!
 K DA,DIE,DR,X,Y
 Q
 ;
LIST ; - correct station type names
 ;;DOMICILLARY RESTORATION CARE^DOMICILIARY RESTORATION CARE
 ;;STATE DOMICILLARY^STATE DOMICILIARY
 ;;QUIT
