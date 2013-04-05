DGBT1P14 ;RLS/RRA - BENE TRAVEL RATES UPDATE DGBT*1*14 PRE-INIT ; 01/15/08 14:30
 ;;1.0;Beneficiary Travel;**14**;September 25, 2001;Build 7
 ;
 Q
EN ;
 D START,UPDATE,FINISH
 Q
 ;
START D BMES^XPDUTL("Insert Bene Travel 2008 rates, Post-Install Starting")
 Q
 ;
FINISH D BMES^XPDUTL("Insert Bene Travel 2008 rates, Post-Install Complete")
 Q
 ;
UPDATE ;Insert 02012008 record
 ;ESTABLISH THE RECORD
 N DO,DIC,DIE,X,Y,DINUM,DR,DA
 I $D(^DG(43.1,6919798.9999,0)) D  Q
 . D BMES^XPDUTL("Rate record already exists, exiting")
 S DIC="^DG(43.1,",DIC(0)="E",X=3080201,DINUM=9999999.9999-X
 D FILE^DICN
 ;
 ;NOW EDIT THE REST OF THE FIELDS
 S DIE=DIC,DR="30.01///15.54;30.02///46.62;30.03///.285;30.05///.285"
 S DA=+Y
 D ^DIE
 D BMES^XPDUTL("Added 02012008 RATES record to MAS EVENT RATES file")
 Q
 ;
