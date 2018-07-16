DGBT1P17 ;RLS/MJB - BENE TRAVEL UPDATE POST-INIT ; 10/14/08 10:45
 ;;1.0;Beneficiary Travel;**17**;September 25, 2001;Build 6
 ;
 Q
EN ;
 D START,UPDATE,FINISH
 Q
 ;
START D BMES^XPDUTL(" Post-Install Starting")
 Q
 ;
FINISH D BMES^XPDUTL(" Post-Install Complete")
 Q
 ;
UPDATE ;Insert new rate/deductible record
 ;ESTABLISH THE RECORD
 N DO,DIC,DIE,X,Y,DINUM,DR,DA
 S DIC="^DG(43.1,",DIC(0)="E",X=3090109,DINUM=9999999.9999-X
 I $D(^DG(43.1,DINUM,0)) D  Q  ;9'S INVERSE OF EFFECTIVE DATE
 . D BMES^XPDUTL("Record already exists, exiting")
 D FILE^DICN
 ;
 ;NOW EDIT THE REST OF THE FIELDS
 S DIE=DIC,DR="30.01///6;30.02///18;30.03///.415;30.05///.415"
 S DA=+Y
 D ^DIE
 D BMES^XPDUTL("New record added to MAS EVENT RATES file")
 Q
 ;
