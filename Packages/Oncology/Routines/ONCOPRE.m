ONCOPRE ;HIRMFO/GWB-PRE-INSTALL ROUTINE FOR PATCH ONC*2.11*5  04/29/96
 ;;2.11;ONCOLOGY;**1,5**;Mar 07, 1995
 ;
 ;Delete CANCER-DIRECTED SURGERY (165.5,58.2) to remove ALGORITHM code 
 S DIK="^DD(165.5,",DA=58.2,DA(1)=165.5 D ^DIK
 K DIK,DA
 ;Delete BLADDER PHYSICIAN SPECIALTY (#166.12) entries
 S DIK="^ONCO(166.12," F DA=1:1:11 D ^DIK  
 K DIK,DA
 ;Delete BLADDER REGIONAL TREATMENT MODALITY (#166.13) entries
 S DIK="^ONCO(166.13," F DA=1:1:19 D ^DIK  
 K DIK,DA
 ;Edit THAI entry in RACE CODE FOR ONCOLOGY (#164.46) file to change
 ;to lowercase
 S DIE="^ONCO(164.46,",DA=14,DR=".01///Thai" D ^DIE
 K DIE,DA 
SEX ;Edit SEX CODE FOR ONCOLOGY (#164.47) entries to change to lowercase
 S DIE="^ONCO(164.47,",DA=1,DR=".01///Male" D ^DIE 
 S DIE="^ONCO(164.47,",DA=2,DR=".01///Female" D ^DIE 
 S DIE="^ONCO(164.47,",DA=3,DR=".01///Other (hermaphrodite)" D ^DIE 
 S DIE="^ONCO(164.47,",DA=4,DR=".01///Transsexual" D ^DIE 
 S DIE="^ONCO(164.47,",DA=9,DR=".01///Not stated" D ^DIE 
