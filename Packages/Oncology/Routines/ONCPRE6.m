ONCPRE6 ;HIRMFO/GWB-PRE-INSTALL ROUTINE FOR PATCH ONC*2.11*6  08/26/96
 ;;2.11;ONCOLOGY;**6**;Mar 07, 1995
 ;
 ;Kill the "C" cross-reference of the AJCC STAGE GROUP (#164.45) file
 ;This cross-reference will be rebuilt at installation time
 K ^ONCO(164.45,"C") 
 ;Delete GRADE (#164.43) file entries
 S DIK="^ONCO(164.43,"
 S DA=0 F  S DA=$O(^ONCO(164.43,DA)) Q:DA'>0   D ^DIK
 K DIK,DA
 ;Delete AJCC STAGE GROUP (#164.45) file entries - COMMENT OUT 11/22/96
 ; S DIK="^ONCO(164.45,"
 ; S DA=0 F  S DA=$O(^ONCO(164.45,DA)) Q:DA'>0   D ^DIK
 ; K DIK,DA
 ;
 ;1) Convert RADIATION THERAPY TO CNS DATE values
 ;2) Convert AJCC STAGE values of "0is" -> "0S" and "0a" -> "0A" (DELETE)
 S IEN=0 F  S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D
 .;1)
 .S SIT=$P(^ONCO(165.5,IEN,0),U,1)
 .S COC=$P(^ONCO(165.5,IEN,0),U,4)
 .S RTTCNS=$P($G(^ONCO(165.5,IEN,3)),U,10)
 .I COC'=8,RTTCNS=9 I ((SIT'=31)&(SIT'=66)&(SIT'=67)&(SIT'=68)&(SIT'=69)) S DIE="^ONCO(165.5,",DA=IEN,DR="52////2000000" D ^DIE
 .;2)
 .; I $P($G(^ONCO(165.5,IEN,2)),U,20)="0is" S DIE="^ONCO(165.5,",DA=IEN,DR="38///0S" D ^DIE
 .; I $P($G(^ONCO(165.5,IEN,2)),U,20)="0a" S DIE="^ONCO(165.5,",DA=IEN,DR="38///0A" D ^DIE
CONVSG ;Convert data in STAGE GROUP AJCC (#38.5) field.
 ; Field #38.5 set by Fields #38 (CSSG^ONCOCRC) and #88 (PSSG^ONCOCRC)
 ; This will convert existing data
 S IEN=0 F  S IEN=$O(^ONCO(165.5,IEN)) Q:IEN'>0  D
 .S PSG=$P($G(^ONCO(165.5,IEN,2.1)),"^",4) I PSG'="" S PSG=$E(PSG)
 .S PSGDS="" I PSG'="" S PSGDS=$S(PSG=0:0,PSG=1:"I",PSG=2:"II",PSG=3:"III",PSG=4:"IV",PSG=9:"U",PSG=8:"NA",1:"")
 .S CSG=$P($G(^ONCO(165.5,IEN,2)),"^",20) I CSG'="" S CSG=$E(CSG)
 .S CSGDS="" I CSG'="" S CSGDS=$S(CSG=0:0,CSG=1:"I",CSG=2:"II",CSG=3:"III",CSG=4:"IV",CSG=9:"U",CSG=8:"NA",1:"")
 .S SG=$S(PSG="":CSGDS,CSG="":PSGDS,PSG<7:PSGDS,PSG>7&(CSG<7):CSGDS,1:PSGDS) D KXR,SXR
 .Q
 K IEN,DIE,DA,DR,SIT,COC,RTTCNS Q
KXR ; KILL OFF THE OLD "ASG" X-REF
 N XSG
 S XSG=$S($D(^ONCO(165.5,IEN,2)):$P(^ONCO(165.5,IEN,2),"^",28),1:"") Q:XSG=""
 I $D(^ONCO(165.5,"ASG",XSG,IEN)) K ^ONCO(165.5,"ASG",XSG,IEN)
 Q
SXR ; STUFF STAGE FIELD (#38.5), SET NEW "ASG" X-REF
 N XSG
 Q:SG=""  S $P(^ONCO(165.5,IEN,2),"^",28)=SG,^ONCO(165.5,"ASG",SG,IEN)=""
 Q
