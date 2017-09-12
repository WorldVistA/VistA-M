PSN4P103 ;BIR/MHA-populating the service code field ;17 Feb 00 / 8:12 AM
 ;;4.0;NATIONAL DRUG FILE;**103**;13 May 05
 ;
 S DA=0 F  S DA=$O(^PSNDF(50.68,DA)) Q:'DA  D
 .S NA="0000"_DA,NA="6"_$E(NA,($L(NA)-4),$L(NA))
 .W "." S DIE="^PSNDF(50.68,",DR="2000////"_NA D ^DIE
 K DA,NA,DIE,DR Q
