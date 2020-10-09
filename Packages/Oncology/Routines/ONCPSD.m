ONCPSD ;Hines OIFO/GWB - STAGE OF DISEASE AT DIAGNOSIS PRINT ;10/05/11
 ;;2.2;ONCOLOGY;**1,6,9,10,12**;Jul 31, 2013;Build 8
 ;
PRT N DIC,DR,DA,DIQ,I,LEN,LOS,NOP,ONC,TXT,TXT1,TXT2,X
 S DIC="^ONCO(165.5,"
 S DR="34:35;37;89.1;38;88;19;89;39;149;151;29;29.3;29.4;29.5;30;31;32;33;65;66;25;44;241;242;280;1764"
 S DA=D0,DIQ="ONC" D EN^DIQ1
 F I=34,34.1,34.2,34.31,34.32,34.33,34.34,34.35,34.36,35,38,88,19,89,39,149,151,29,29.3,29.4,29.5,30,31,32,33,280,1764 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 I $P($G(^ONCO(165.5,D0,0)),U,16)<3160000 W !," Tumor Size...................: ",ONC(165.5,D0,29)
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3151231 D
 .W !," Tumor Size Clinical..........: ",$E(ONC(165.5,D0,29.4),1,48)
 .W !," Tumor Size Pathologic........: ",$E(ONC(165.5,D0,29.5),1,48)
 .W !," Tumor Size Summary...........: ",$E(ONC(165.5,D0,29.3),1,48)
 .Q
 S TXT=ONC(165.5,D0,30),LEN=46 D TXT
 I $P($G(^ONCO(165.5,D0,0)),U,16)<3180000 W !," Extension....................: ",TXT1 W:TXT2'="" !,?32,TXT2
 I $P($G(^ONCO(165.5,D0,0)),U,16)<3180000 W !," Lymph Nodes..................: ",ONC(165.5,D0,31)
 W !," Regional Lymph Nodes Examined: ",ONC(165.5,D0,33)
 W !," Regional Lymph Nodes Positive: ",ONC(165.5,D0,32)
 I $P($G(^ONCO(165.5,D0,0)),U,16)<3180000 W !," SEER Summary Stage 2000......: ",ONC(165.5,D0,35)
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3171231 W !," SEER Summary Stage 2018......: ",ONC(165.5,D0,1764)
 I $P($G(^ONCO(165.5,D0,0)),U,16)<3160000 W !," Site of Distant Metastasis #1: ",ONC(165.5,D0,34)
 I $P($G(^ONCO(165.5,D0,0)),U,16)<3160000 W !," Site of Distant Metastasis #2: ",ONC(165.5,D0,34.1)
 I $P($G(^ONCO(165.5,D0,0)),U,16)<3160000 W !," Site of Distant Metastasis #3: ",ONC(165.5,D0,34.2)
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3151231 W !," METS AT DX-BONE......: ",ONC(165.5,D0,34.31)
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3151231 W !," METS AT DX-BRAIN.....: ",ONC(165.5,D0,34.32)
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3151231 W !," METS AT DX-LIVER.....: ",ONC(165.5,D0,34.33)
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3151231 W !," METS AT DX-LUNG......: ",ONC(165.5,D0,34.34)
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3151231 W !," METS AT DX-DISTANT LN: ",ONC(165.5,D0,34.35)
 I $P($G(^ONCO(165.5,D0,0)),U,16)>3151231 W !," METS AT DX-OTHER.....: ",ONC(165.5,D0,34.36)
 W !," Clinical Stage Discussion....: ",ONC(165.5,D0,280)
 W !
 I $P($G(^ONCO(165.5,D0,0)),"^",16)>3171231 D
 .W !," Extent of Disease (EOD) Data",!," ----------------------------"
 .W !?1,"Primary Tumor: ",$P($G(^ONCO(165.5,D0,"EOD")),"^",1),?22,"Regional Nodes: ",$P($G(^ONCO(165.5,D0,"EOD")),"^",2),?44,"METS: ",$P($G(^ONCO(165.5,D0,"EOD")),"^",3),!
 W !," Clinical Staging",?22,"TNM edition: ",$$TNMED^ONCOU55(D0),?41,"Pathologic Staging"
 W !," ----------------"
 I $P($G(^ONCO(165.5,D0,0)),"^",16)>3171231 D GTAJIEN^ONCSCHMG W ?22,"AJCC ID:    ",$P($G(^ONCO(165.5,D0,"AJCC8")),"^",1)
 W ?41,"------------------"
 ;
 I $P($G(^ONCO(165.5,D0,0)),"^",16)<3180101 D
 .W !," TNM........: ",ONC(165.5,D0,37)," ",$P($G(^ONCO(165.5,D0,24)),U,5),?41,"TNM........: ",ONC(165.5,D0,89.1)," ",$P($G(^ONCO(165.5,D0,24)),U,5)
 .W !," Stage Group: ",ONC(165.5,D0,38)," ",$E($P(ONC(165.5,D0,241),"(",1),1,19),?41,"Stage Group: ",ONC(165.5,D0,88)," ",$E($P(ONC(165.5,D0,242),"(",1),1,19)
 ;
 I $P($G(^ONCO(165.5,D0,0)),"^",16)>3171231 D
 .N IEN S IEN=D0
 .W !," TNM........: " S STGIND="C" D TNMDSP^ONCSGA8U W ?41,"TNM........: " S STGIND="P" D TNMDSP^ONCSGA8U
 .W !," Stage Group: ",$P($G(^ONCO(165.5,D0,"AJCC8")),"^",5),?41,"Stage Group: ",$P($G(^ONCO(165.5,D0,"AJCC8")),"^",9)
 .W !?22,"Post-Therapy Staging",!?22,"--------------------"
 .W !?22,"TNM........: " S STGIND="T" D TNMDSP^ONCSGA8U
 .W !?22,"Stage Group: ",$P($G(^ONCO(165.5,D0,"AJCC8")),"^",13)
 .Q
 ;
 W !," Staged By..: ",$E(ONC(165.5,D0,19),1,25),?41,"Staged By..: ",$E(ONC(165.5,D0,89),1,25)
 W !
 W !," Other Staging System: ",ONC(165.5,D0,39),?41,"TNM Form Assigned..: ",ONC(165.5,D0,25)
 W !," Physician's Stage...: ",ONC(165.5,D0,65),?41,"TNM Form Completed.: ",ONC(165.5,D0,44)
 W !,DASHES
 Q
TXT S (TXT1,TXT2)="",LOS=$L(TXT) I LOS<LEN S TXT1=TXT Q
 S NOP=$L($E(TXT,1,LEN)," ")
 S TXT1=$P(TXT," ",1,NOP-1),TXT2=$P(TXT," ",NOP,999)
 Q
 ;
UCASE S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
 ;
CLEANUP ;Cleanup
 K D0,DASHES
