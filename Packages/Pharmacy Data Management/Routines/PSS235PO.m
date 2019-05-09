PSS235PO ;BIR/SJA - Post install routine for patch PSS*1*235 ; 23 Jan 2019  10:20 AM
 ;;1.0;PHARMACY DATA MANAGEMENT;**235**;9/30/97;Build 3
 ;
 Q
POST D BMES^XPDUTL("Re-indexing the 'VAC' cross-reference of the NATIONAL DRUG CLASS field (#25) of the DRUG file (#50)...")
 K ^PSDRUG("VAC") K DIK S DIK="^PSDRUG(",DIK(1)="25^VAC" D ENALL^DIK K DIK
 Q
