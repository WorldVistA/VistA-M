PSOTPPRE ;BIR/RTR-Patch 146 Pre Install routine ;07/27/03
 ;;7.0;OUTPATIENT PHARMACY;**146**;DEC 1997
 ;
 I $$PATCH^XPDUTL("PSO*7.0*146") Q
 N X,Y,DA,DIC
 N PSOTPLLX
 S PSOTPLLX="" F  S PSOTPLLX=$O(^PS(53,"B",PSOTPLLX)) Q:PSOTPLLX=""!($G(XPDABORT)=2)  D
 .I $$UP^XLFSTR(PSOTPLLX)="NON-VA" S XPDABORT=2 D
 ..D BMES^XPDUTL("Aborting install, NON-VA entry found in RX PATIENT STATUS File (#53).") S XPDABORT=2
 I $G(XPDABORT)=2 Q
START ;Add entry to file
 K DIC S DIC="^PS(53,",DIC(0)="",X="NON-VA",DIC("DR")="2////"_"NVA"_";3////"_30_";4////"_11_";5////"_1_";15////"_0_";16////"_0 K DD,DO D FILE^DICN K DA,DIC,X,DD,DO
 I Y<1 D BMES^XPDUTL("Aborting Install, cannot add NON-VA Rx Patient Status entry to File #53.") S XPDABORT=2
 Q
