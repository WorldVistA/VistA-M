ONCPSD ;Hines OIFO/GWB - STAGE OF DISEASE AT DIAGNOSIS PRINT ;10/05/11
 ;;2.11;ONCOLOGY;**15,19,22,28,34,36,40,45,47,52,54**;Mar 07, 1995;Build 10
 ;
PRT N DIC,DR,DA,DIQ,I,LEN,LOS,NOP,ONC,TXT,TXT1,TXT2,X
 S DIC="^ONCO(165.5,"
 S DR="34;34.1;34.2;35;37;89.1;38;88;19;89;39;149;151;29;30;31;32;33;65;66;25;44;241;242;280"
 S DA=D0,DIQ="ONC" D EN^DIQ1
 F I=34,34.1,34.2,35,38,88,19,89,39,149,151,29,30,31,32,33,280 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 W !," Tumor Size...................: ",ONC(165.5,D0,29)
 S TXT=ONC(165.5,D0,30),LEN=46 D TXT
 W !," Extension....................: ",TXT1 W:TXT2'="" !,?32,TXT2
 W !," Lymph Nodes..................: ",ONC(165.5,D0,31)
 W !," Regional Lymph Nodes Examined: ",ONC(165.5,D0,33)
 W !," Regional Lymph Nodes Positive: ",ONC(165.5,D0,32)
 W !," SEER Summary Stage 2000......: ",ONC(165.5,D0,35)
 W !," Site of Distant Metastasis #1: ",ONC(165.5,D0,34)
 W !," Site of Distant Metastasis #2: ",ONC(165.5,D0,34.1)
 W !," Site of Distant Metastasis #3: ",ONC(165.5,D0,34.2)
 W !," Clinical Stage Discussion....: ",ONC(165.5,D0,280)
 W !
 W !," Clinical Staging",?22,"TNM edition: ",$$TNMED^ONCOU55(D0),?41,"Pathologic Staging"
 W !," ----------------",?41,"------------------"
 W !," TNM........: ",ONC(165.5,D0,37)," ",$P($G(^ONCO(165.5,D0,24)),U,5),?41,"TNM........: ",ONC(165.5,D0,89.1)," ",$P($G(^ONCO(165.5,D0,24)),U,5)
 W !," Stage Group: ",ONC(165.5,D0,38),$P(ONC(165.5,D0,241),"(",1),?41,"Stage Group: ",ONC(165.5,D0,88),$P(ONC(165.5,D0,242),"(",1)
 W !," Staged By..: ",ONC(165.5,D0,19),?41,"Staged By..: ",ONC(165.5,D0,89)
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
