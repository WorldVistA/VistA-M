PSUPRE ;BIR/PDW - PBM PRE-INIT ;25 AUG 1998
 ;;3.0;PHARMACY BENEFITS MANAGMENT;;Oct 15, 1998
EN ;EP CHANGE MENU OPTION NAMES
 ;     Menu Items
 ; "PSU DPPM MANUAL" to be "PSU PBM MANUAL"
 ; "PSU DPPM AUTO" to be "PSU PBM AUTO"
 ;
 K DIC
 S X="PSU DPPM MANUAL",DIC=19,DIC(0)="XM" D ^DIC
 I +Y>0 D
 . S Z="PSU PBM MANUAL"
 . S DIE=DIC,DR=".01///^S X=Z",DA=+Y D ^DIE
 K DIC
 S X="PSU DPPM AUTO",DIC=19,DIC(0)="XM" D ^DIC
 I +Y>0 D
 . S Z="PSU PBM AUTO"
 . S DIE=DIC,DR=".01///^S X=Z",DA=+Y D ^DIE
 ;
 ;     Mail Group
 ; "PSU DPPM" to be "PSU PBM"
 ;
 K DIC
 S X="PSU DPPM",DIC=3.8,DIC(0)="XM" D ^DIC
 I +Y>0 D
 . S Z="PSU PBM"
 . S DIE=DIC,DR=".01///^S X=Z",DA=+Y D ^DIE
 ;
PACKAGE ;EP update fields in the package file
 K DIC
 S DIC=9.4,DIC(0)="M",X="PSU" D ^DIC
 S DA=+Y
 Q:Y'>0
 K ^DIC(9.4,+Y,1)
 K Z,X F I=1:1 S Z=$T(DESC+I) Q:Z[";;END"  D
 . S X=$P(Z,";;",2),X(I,0)=Z
 S ^DIC(9.4,DA,1,0)="^^20^20^2980916^^^^"
 M ^DIC(9.4,DA,1)=X
 K DIE S DIE="^DIC(9.4,"
 S DEV="HOLLOWAY/WESLEY/BIRMINGHAM",NAME="PHARMACY BENEFITS MANAGEMENT"
 S DR="10///^S X=DEV;.01///^S X=NAME;2///^S X=NAME" D ^DIE
 ;    update synonyms
 S Y=DA
 K DIC,DA
 S DA(1)=Y
 S DIC("P")=$P(^DD(9.4,15007,0),"^",2)
 S DIC="^DIC(9.4,DA(1),15007,"
 S DIC(0)="XL"
 S X="PBM" D ^DIC
 S X="D&PPM" D ^DIC
 Q
DESC ; $T reference for package description
 ;;Pharmacy Benefits Management (PBM) software extracts statistics from
 ;;the following files on a monthly basis:
 ;;
 ;;File Name                                     File Number
 ;;---------------------------------------------------------
 ;;Pharmacy Patient IV Subfile......................55.01
 ;;Pharmacy Patient UD Subfile......................55.06
 ;;AR/WS STOCK Stats................................58.5
 ;;Prescription.....................................52
 ;;Procurement......................................442, 58.811, 58.81
 ;;Controlled Substances............................58.81
 ;;Laboratory.......................................60, 63
 ;;
 ;;This data is electronically exported via MailMan to the National
 ;;PBM Section. These messages are then passed through a translation
 ;;process to convert all local drug names to a common drug name and all
 ;;local dispensing units to a common dispensing unit. After translation
 ;;the information will be added to a national database. The PBM
 ;;Section will be able to provide information on facility, regional, and
 ;;national product use on a monthly, quarterly, and annual intervals.
 ;;END
