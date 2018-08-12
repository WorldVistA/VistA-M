ONCUPLPR ;Hines OIFO/GWB - PRE-INSTALL ROUTINE FOR NAACCR UPLOAD
 ;;2.2;ONCOLOGY;**6,9**;Jul 31, 2013;Build 3
 ;
 ;Kill ONCOLOGY DATA EXTRACT FORMAT (160.16) data
 ;K ^ONCO(160.1600)
 ;
 ;Kill ICD-O-3 MORPHOLOGY (169.3) data
 ; data will be brought in with patch install
 K ^ONCO(169.3)
 ;delete an entry in file #160.16
 N DIK,DA,ONCI
 F ONCI=804,805,806 D
 .S DA(1)=2,DA=ONCI
 .S DIK="^ONCO(160.16,"_DA(1)_",""FIELD""," D ^DIK
 ;delete bad entry
 K ^ONCO(160.16,2,"FIELD","C","State/Requestor Items",541)
 K ^ONCO(160.16,2,"FIELD","B",2370,807)
 ;
DIK ;update entries in state
 N DA,DIE
 S DIC(0)="EL"
 S DA(1)=2,DA=807
 S DIE="^ONCO(160.16,"_DA(1)_",""FIELD"","
 S DR=".01///^S X=2340;1///^S X=1000;3///^S X=""State/Requestor Items""" D ^DIE
 ;
 Q
