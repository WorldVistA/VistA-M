ONC2PS21 ;HINES OIFO/RTK - Post-Install Routine for Patch ONC*2.2*21 ;11/05/24
 ;;2.2;ONCOLOGY;**21**;Jul 31, 2013;Build 6
 ;
 N ONCVER S ONCVER=$$PATCH^XPDUTL("ONC*2.2*21") I ONCVER=1 Q
 D XTMP ;initialize XTMP zero node
 D CNV3700
 D CNV5000
 D CNVTORS
 Q
 ;
CNV3700 ;Convert any cases with SEER Site Specific Fact 1 (Field #3700)
 ;HPV Status field changed from Set of Codes to Pointer to File #167.7
 ;
 D BMES^XPDUTL("Convert cases with SEER Site Specific Fact 1 HPV Status...")
 I $E($P(^XTMP("ONC*2.2*21",0),U,4),1)="C" D  Q
 .D BMES^XPDUTL("SEER Conversion completed.")
 N IEN,ONCDXVP,ONC3700,ONC3800,ONC3927
 S ONCDXVP=3171231 F  S ONCDXVP=$O(^ONCO(165.5,"ADX",ONCDXVP)) Q:ONCDXVP'>0  D
 .S IEN=0 F  S IEN=$O(^ONCO(165.5,"ADX",ONCDXVP,IEN)) Q:IEN'>0  D
 ..Q:$D(^XTMP("ONC*2.2*21",4,IEN))  ;already converted
 ..S ONC3700=$P($G(^ONCO(165.5,IEN,"SSD4")),"^",33) I ONC3700="" Q
 ..S ONC3800=$P($G(^ONCO(165.5,IEN,"SSD1")),"^",1)
 ..S ONC3927=$P($G(^ONCO(165.5,IEN,"SSD4")),"^",22)
 ..I ONC3700=0 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=3   ;new code 20
 ..I ONC3700=1 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=4   ;new code 21
 ..I ONC3700=2 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=5   ;new code 30
 ..I ONC3700=3 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=6   ;new code 31
 ..I ONC3700=4 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=7   ;new code 40
 ..I ONC3700=5 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=8   ;new code 41
 ..I ONC3700=6 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=9   ;new code 50
 ..I ONC3700=7 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=10  ;new code 51
 ..I "00071^00072^00073^00074^00075^00076^00077^00112"[ONC3800 D
 ...I ONC3700=8 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=13  ;new code 97
 ...I ONC3700=9 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=14  ;new code 99
 ..I ONC3800="00100" D
 ...I ONC3700=8 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=2  ;new code 11
 ...I ONC3700=9 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=2  ;new code 11
 ..I ONC3800="00111",ONC3927=1 D
 ...I ONC3700=8 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=1  ;new code 10
 ...I ONC3700=9 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=1  ;new code 10
 ..I ONC3800="00111",ONC3927=9 D
 ...I ONC3700=8 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=13  ;new code 97
 ...I ONC3700=9 S $P(^ONCO(165.5,IEN,"SSD4"),"^",33)=14  ;new code 99
 ..S ^XTMP("ONC*2.2*21",4,IEN)=""
 ..Q
 .Q
 S $P(^XTMP("ONC*2.2*21",0),U,4)="Completed"
 D BMES^XPDUTL("Conversion completed...")
 Q
 ;
CNV5000 ;Convert AJCC ID for 9th Edition cases (Field #5000)
 ; New 9th Edition using 4 digit AJCC ID (9000-9999 range)
 ;
 D BMES^XPDUTL("Convert AJCC ID for v9 protocols...")
 N IEN,ONCDXVP,ONC3800,ONC5000
 S ONCDXVP=3201231 F  S ONCDXVP=$O(^ONCO(165.5,"ADX",ONCDXVP)) Q:ONCDXVP'>0  D
 .S IEN=0 F  S IEN=$O(^ONCO(165.5,"ADX",ONCDXVP,IEN)) Q:IEN'>0  D
 ..S ONC5000=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",1) I ONC5000="" Q
 ..S ONC3800=$P($G(^ONCO(165.5,IEN,"SSD1")),U,1) I ONC3800="" Q
 ..I ONC5000=52,ONC3800="09520" D
 ...S $P(^ONCO(165.5,IEN,"AJCC8"),"^",1)=9001   ;Cervix/9001
 ..I ONC5000=19,ONC3800="09190" D
 ...S $P(^ONCO(165.5,IEN,"AJCC8"),"^",1)=9002   ;Appendix/9002
 ..I ONC5000=21,ONC3800="09210" D
 ...S $P(^ONCO(165.5,IEN,"AJCC8"),"^",1)=9003   ;Anus/9003
 ..I ((ONC5000=72)!(ONC5000="72.1"))&("09721^09722^09723^09724"[ONC3800) D
 ...I ONCDXVP<3230000 Q
 ...S $P(^ONCO(165.5,IEN,"AJCC8"),"^",1)=9004   ;Brain & SC Other/9004
 ..I ONC5000="72.2",ONC3800="09724" D
 ...I ONCDXVP<3230000 Q
 ...S $P(^ONCO(165.5,IEN,"AJCC8"),"^",1)=9005   ;Brain & SC Medulloblastoma/9005
 ..Q
 .Q
 Q
 ;
CNVTORS ;Convert Type of Reporting Source (field #1.2) for ALL cases to 1
 S ONCDXVP=2791231 F  S ONCDXVP=$O(^ONCO(165.5,"ADX",ONCDXVP)) Q:ONCDXVP'>0  D
 .S IEN=0 F  S IEN=$O(^ONCO(165.5,"ADX",ONCDXVP,IEN)) Q:IEN'>0  D
 ..S $P(^ONCO(165.5,IEN,0),"^",10)=1
 Q
 ;
XTMP ;initialize XTMP zero node
 ;format: ^XTMP(namespace,0)=purge date(FM)^create date(FM)^description(optional)
 N ONCPURGEDT
 S ONCPURGEDT=$$FMADD^XLFDT(DT,90) ;purge date = DT + 90 days
 S ^XTMP("ONC*2.2*21",0)=ONCPURGEDT_U_DT_U_"data conversion"
 ;4th piece of zero node is set to "Completed" when CNV3700 conversion is finished.
 ;set ^XTMP("ONC*2.2*21",4,IEN)="" when each CNV3700 entry is converted.
 Q
