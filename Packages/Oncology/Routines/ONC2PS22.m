ONC2PS22 ;HINES OIFO/RTK - Post-Install Routine for Patch ONC*2.2*22 ;04/30/25
 ;;2.2;ONCOLOGY;**22**;Jul 31, 2013;Build 6
 ;
 D SET11132,SET18,CNVEOD,DELRAD
 Q
 ;
SET11132 ;set new (#165.5,#11132) field to "XX" for all 2025+ cases
 ;
 D BMES^XPDUTL("Set Pediatric ID value to 'XX' for 2025+ cases...")
 N IEN,ONCDXVP,ONC3800,ONC5000
 S ONCDXVP=3241231 F  S ONCDXVP=$O(^ONCO(165.5,"ADX",ONCDXVP)) Q:ONCDXVP'>0  D
 .S IEN=0 F  S IEN=$O(^ONCO(165.5,"ADX",ONCDXVP,IEN)) Q:IEN'>0  D
 ..S $P(^ONCO(165.5,IEN,"SSD5"),"^",18)="XX"
 ..Q
 .Q
 Q
 ;
SET18 ;set PRIMARY PAYER AT DX (#165.5,#18) field to 67 (VA) for all
 ; cases EXCEPT if PRIMARY PAYER AT DX = 65,66 or 67 - leave those as-is
 ;
 Q
 D BMES^XPDUTL("Set Primary Payer at DX value to '67^Veterans Affairs' for ALL")
 D MES^XPDUTL(" cases EXCEPT '65^TRICARE' and '66^Military' cases...")
 N IEN,ONCDXVP
 S ONCDXVP=2451231 F  S ONCDXVP=$O(^ONCO(165.5,"ADX",ONCDXVP)) Q:ONCDXVP'>0  D
 .S IEN=0 F  S IEN=$O(^ONCO(165.5,"ADX",ONCDXVP,IEN)) Q:IEN'>0  D
 ..I $P($G(^ONCO(165.5,IEN,1)),"^",11)=26 Q
 ..I $P($G(^ONCO(165.5,IEN,1)),"^",11)=27 Q
 ..I $P($G(^ONCO(165.5,IEN,1)),"^",11)=28 Q
 ..S $P(^ONCO(165.5,IEN,1),"^",11)=28
 ..Q
 .Q
 Q
CNVEOD ;convert Schema ID 00190/09190 EOD PRIMARY TUMOR/METS (#165.5,#1772)
 ;          (#165.5,#1776) fields
 D BMES^XPDUTL("Convert EOD Primary Tumor for Schema 00190/09190 cases...")
 N IEN,ONCDXVP
 S ONCDXVP=3171231 F  S ONCDXVP=$O(^ONCO(165.5,"ADX",ONCDXVP)) Q:ONCDXVP'>0  D
 .S IEN=0 F  S IEN=$O(^ONCO(165.5,"ADX",ONCDXVP,IEN)) Q:IEN'>0  D
 ..S ONC3800=$P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)
 ..S ONC1772=$P($G(^ONCO(165.5,IEN,"EOD")),"^",1)
 ..S ONC1776=$P($G(^ONCO(165.5,IEN,"EOD")),"^",3)
 ..I ((ONC3800="00190")!(ONC3800="09190")) D
 ...I ONC1772=600 S $P(^ONCO(165.5,IEN,"EOD"),"^",1)=500
 ...I ((ONC1776="00")!(ONC1776=10)) S $P(^ONCO(165.5,IEN,"EOD"),"^",3)=30
 ..Q
 .Q
 Q
DELRAD ;delete the RADIATION (#165.5,#51.2) field from all 2018+ abstracts
 D BMES^XPDUTL("Set Radiation field to NULL for all 2018+ cases...")
 N IEN,ONCDXVP
 S ONCDXVP=3171231 F  S ONCDXVP=$O(^ONCO(165.5,"ADX",ONCDXVP)) Q:ONCDXVP'>0  D
 .S IEN=0 F  S IEN=$O(^ONCO(165.5,"ADX",ONCDXVP,IEN)) Q:IEN'>0  D
 ..S $P(^ONCO(165.5,IEN,3),"^",6)=""
 ..Q
 .Q
 Q
