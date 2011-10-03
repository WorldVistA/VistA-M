ONCPCS ;Hines OIFO/GWB - Collaborative Staging display ;06/23/10
 ;;2.11;ONCOLOGY;**40,48,51**;Mar 07, 1995;Build 65
 ;
 Q:$G(TOP)=""
 N DISCRIM,HIST,MO,SCHNAME,SITE
 S MO=$$HIST^ONCFUNC(D0)
 S SITE=$TR($$GET1^DIQ(164,TOP,1,"I"),".","")
 S HIST=$E(MO,1,4)
 S DISCRIM=$$GET1^DIQ(165.5,D0,240)
 S SCHEMA=+$$SCHEMA^ONCSAPIS(.ONCSAPI,SITE,HIST,DISCRIM)
 I SCHEMA<0 S SCHNAME="Unable to compute schema"
 S SCHEMA=SCHNAME
 N I,NUM,ONC,SECTION,SSFCNT,SSFLIST
 K DASHES S $P(DASHES,"-",80)="-"
 S SECTION="Collaborative Staging" D SECTION^ONCOAIP
 N DI,DIC,DR,DA,DIQ,ONC
 K ONC
 S DIC="^ONCO(165.5,"
 S DR="29.2;30.2;29.1;31.1;32.1;32;33;34.3;34.4;44.1:44.999;160;161;162;163;164;165;166;167;168;169;160.7;161.7;162.7;163.7;164.7;165.7;166.7"
 S DA=D0,DIQ="ONC",DIQ(0)="IE" D EN^DIQ1
 I $L(ONC(165.5,D0,32,"I"))=1 S ONC(165.5,D0,32,"I")="0"_ONC(165.5,D0,32,"I")
 I $L(ONC(165.5,D0,33,"I"))=1 S ONC(165.5,D0,33,"I")="0"_ONC(165.5,D0,33,"I")
 S SSFLIST="",SSFCNT=0
 F I=44.1,44.2,44.3,44.4,44.5,44.6,44.7,44.8,44.9,44.101,44.11,44.12,44.13,44.14,44.15,44.16,44.17,44.18,44.19,44.201,44.21,44.22,44.23,44.24,44.25 D
 .I ONC(165.5,D0,I,"I")'="",ONC(165.5,D0,I,"I")'=988 S SSFCNT=SSFCNT+1,SSFLIST(SSFCNT)=I
 W !," Schema name: ",SCHEMA
 W !,DASHES
 W !," Tumor Size (CS).........: ",ONC(165.5,D0,29.2,"I"),?35,"AJCC-6 T...........: ",ONC(165.5,D0,160,"E")
 W !," Extension (CS)..........: ",ONC(165.5,D0,30.2,"I"),?35,"AJCC-6 T Descriptor: ",ONC(165.5,D0,161,"E")
 W !," Tumor Size/Ext Eval (CS): ",ONC(165.5,D0,29.1,"I"),?35,"AJCC-6 N...........: ",ONC(165.5,D0,162,"E")
 W !," Lymph Nodes (CS)........: ",ONC(165.5,D0,31.1,"I"),?35,"AJCC-6 N Descriptor: ",ONC(165.5,D0,163,"E")
 W !," Lymph Nodes Eval (CS)...: ",ONC(165.5,D0,32.1,"I"),?35,"AJCC-6 M...........: ",ONC(165.5,D0,164,"E")
 W !," Regional Nodes Examined.: ",ONC(165.5,D0,33,"I"),?35,"AJCC-6 M Descriptor: ",ONC(165.5,D0,165,"E")
 W !," Regional Nodes Positive.: ",ONC(165.5,D0,32,"I"),?35,"AJCC-6 Stage Group.: ",ONC(165.5,D0,166,"E")
 W !," Mets at DX (CS).........: ",ONC(165.5,D0,34.3,"I"),?35,"AJCC-7 T...........: ",ONC(165.5,D0,160.7,"E")
 W !," Mets Eval (CS)..........: ",ONC(165.5,D0,34.4,"I"),?35,"AJCC-7 T Descriptor: ",ONC(165.5,D0,161.7,"E")
 ;
 S NUM=1 D SSF
 W ?35,"AJCC-7 N...........: ",ONC(165.5,D0,162.7,"E")
 S NUM=2 D SSF
 W ?35,"AJCC-7 N Descriptor: ",ONC(165.5,D0,163.7,"E")
 S NUM=3 D SSF
 W ?35,"AJCC-7 M...........: ",ONC(165.5,D0,164.7,"E")
 S NUM=4 D SSF
 W ?35,"AJCC-7 M Descriptor: ",ONC(165.5,D0,165.7,"E")
 S NUM=5 D SSF
 W ?35,"AJCC-7 Stage Group.: ",ONC(165.5,D0,166.7,"E")
 S NUM=6 D SSF
 W ?35,"SS1977.............: ",ONC(165.5,D0,167,"E")
 S NUM=7 D SSF
 W ?35,"SS2000.............: ",ONC(165.5,D0,168,"E")
 S NUM=8 D SSF
 W ?35,"CS version.........: ",ONC(165.5,D0,169,"E")
 S NUM=9 D SSF
 S NUM=10 D SSF
 S NUM=11 D SSF
 S NUM=12 D SSF
 S NUM=13 D SSF
 S NUM=14 D SSF
 S NUM=15 D SSF
 S NUM=16 D SSF
 S NUM=17 D SSF
 S NUM=18 D SSF
 S NUM=19 D SSF
 S NUM=20 D SSF
 S NUM=21 D SSF
 S NUM=22 D SSF
 S NUM=23 D SSF
 S NUM=24 D SSF
 S NUM=25 D SSF
 W !,DASHES
 Q
 ;
SSF ;SSF LIST
 N DOTS,SSFNUM
 I $G(SSFLIST(NUM)) D
 .S SSFNUM=$E($P(^DD(165.5,SSFLIST(NUM),0),U,1),4,5)
 .S DOTS=$S($L(SSFNUM)=1:"....................: ",1:"...................: ")
 .W !," SSF",SSFNUM,DOTS,ONC(165.5,D0,SSFLIST(NUM),"I")
 E  I NUM<9 W !
 Q
 ;
CLEANUP ;Cleanup
 K D0,SCHEMA,TOP
