ONCTXSM ;Hines OIFO/GWB - Treatment Summary ;06/23/10
 ;;2.11;ONCOLOGY;**19,26,27,32,34,36,37,51**;Mar 07, 1995;Build 65
 ;
 N COC,DFCODE,DFSP,DFTXT,DIC,DR,DA,DIQ,LEN,RRDF,SCG,SITE,SUB,SURGPS,TPG
 S SAVEY=Y
 K ONC
 D CHECKCC
 D DEFAULT
 S DR="49:58.7;124;133;346;560"
 S DIC="^ONCO(165.5,"
 S DA=D0,DIQ="ONC(" D EN^DIQ1
 W !," Date of 1st course of tx....: ",$E(ONC(165.5,D0,49),1,6)_$E(ONC(165.5,D0,49),9,10)
 S DFSP=$$DS^ONCACDU2(D0)
 W !," Date of 1st Surgical Proc...: ",$E(DFSP,1,2)_"/"_$E(DFSP,3,4)_"/"_$E(DFSP,7,8)
 S TXT=ONC(165.5,D0,58.6),LEN=40 D TXT^ONCPTX
 W !," Surgery of primary site F...: ",$E(ONC(165.5,D0,50),1,6)_$E(ONC(165.5,D0,50),9,10),?40,TXT1
 W:TXT2'="" !,?43,TXT2
 S TXT=ONC(165.5,D0,58.7),LEN=40 D TXT^ONCPTX
 I DATEDX>2971231 D
 .W !," Surgery of primary site @fac F: ",$E(ONC(165.5,D0,50.3),1,6)_$E(ONC(165.5,D0,50.3),9,10),?40,TXT1
 .W:TXT2'="" !,?43,TXT2
 W !," Radiation...................: ",$E(ONC(165.5,D0,51),1,6)_$E(ONC(165.5,D0,51),9,10),?40,ONC(165.5,D0,51.2)
 W:DATEDX>2971231 !," Radiation @fac..............: ",$E(ONC(165.5,D0,51.5),1,6)_$E(ONC(165.5,D0,51.5),9,10),?40,ONC(165.5,DA,51.4)
 W:DATEDX<2960000 !," Radiation therapy to CNS....: ",$E(ONC(165.5,D0,52),1,6)_$E(ONC(165.5,D0,52),9,10),?40,ONC(165.5,D0,52.2)
 W !," Chemotherapy................: ",$E(ONC(165.5,D0,53),1,6)_$E(ONC(165.5,D0,53),9,10),?40,ONC(165.5,D0,53.2)
 W:DATEDX>2971231 !," Chemotherapy @fac...........: ",$E(ONC(165.5,D0,53.4),1,6)_$E(ONC(165.5,D0,53.4),9,10),?40,ONC(165.5,DA,53.3)
 W !," Hormone therapy.............: ",$E(ONC(165.5,D0,54),1,6)_$E(ONC(165.5,D0,54),9,10),?40,ONC(165.5,D0,54.2)
 W:DATEDX>2971231 !," Hormone therapy @fac........: ",$E(ONC(165.5,D0,54.4),1,6)_$E(ONC(165.5,D0,54.4),9,10),?40,ONC(165.5,DA,54.3)
 W !," Immunotherapy...............: ",$E(ONC(165.5,D0,55),1,6)_$E(ONC(165.5,D0,55),9,10),?40,ONC(165.5,D0,55.2)
 W:DATEDX>2971231 !," Immunotherapy @fac..........: ",$E(ONC(165.5,D0,55.4),1,6)_$E(ONC(165.5,D0,55.4),9,10),?40,ONC(165.5,DA,55.3)
 W !," Other treatment.............: ",$E(ONC(165.5,D0,57),1,6)_$E(ONC(165.5,D0,57),9,10),?40,ONC(165.5,D0,57.2)
 W:DATEDX>2971231 !," Other treatment @fac........: ",$E(ONC(165.5,D0,57.4),1,6)_$E(ONC(165.5,D0,57.4),9,10),?40,ONC(165.5,DA,57.3)
 W !,DASHES
 K TXT,TXT1,TXT2
 K DIR S DIR(0)="E" D ^DIR I Y=0 S Y="@0" K SAVEY Q
 S Y=SAVEY K SAVEY
 Q
 ;
CHECKCC ;Check CLASS OF CASE
 S DATEDX=$P($G(^ONCO(165.5,DA,0)),U,16) I DATEDX<2980000 Q
 S COC=$E($$GET1^DIQ(165.5,DA,.04),1,2)
 I (COC="00")!(COC=30)!(COC=31)!(COC=32)!(COC=33)!(COC=40)!(COC=41) D
 .S $P(^ONCO(165.5,DA,3.1),U,11)="00"
 .F PP=7,9,10 S $P(^ONCO(165.5,DA,3.1),U,PP)=1
 .F PP=12:2:20 S $P(^ONCO(165.5,DA,3.1),U,PP)=0
 .F PP=8,13:2:25 S $P(^ONCO(165.5,DA,3.1),U,PP)="0000000"
 I (COC=20)!(COC=21)!(COC=22)!(COC=30)!(COC=31)!(COC=32)!(COC=33)!(COC=36)!(COC=37) D
 .S $P(^ONCO(165.5,DA,3.1),U,5)="00"
 .S $P(^ONCO(165.5,DA,3.1),U,6)="0000000"
 K PP Q
 ;
DEFAULT ;RECONSTRUCTION/RESTORATION (165.5,23) default
 S RRDF="",SURGPS=$P($G(^ONCO(165.5,D0,3.1)),U,29),CONTFLG=0
 S SITE=$P($G(^ONCO(165.5,D0,0)),U,1)
 D SETVARS I TPG="" Q
 I (SITE=35)!($$LEUKEMIA^ONCOAIP2(D0))!((SITE>65)&(SITE<70)) D  Q
 .S RRDF="NA"
 I DATEDX<2980000,SURGPS="00" S CONTFLG=1
 I DATEDX>2971231,SURGPS=1 S CONTFLG=1
 I CONTFLG=0 Q
 S RRDF="No reconstruction/restoration"
 I SCG=67141!(SCG=67250)!(SCG=67422)!(SCG=67700)!(SCG=67739)!(SCG=67770) S RRDF="NA"
 Q
 ;
RRDEFIT ;Special default code for field #23 called from input transform
 I X="No reconstruction/restoration" S X=0 Q
 I X="NA"!(X["Unknown; not stated") S X=9 Q
 Q
SPSDFIT ;Special default code for field #50.2 called from input transform
 D SETVARS I TPG="" Q
 I X?1.2N Q
 F SUB=0:0 S SUB=$O(^ONCO(164,SCG,"SPS",SUB)) Q:SUB'>0!(DFCODE'="")  D
 .I DFTXT=$P($G(^ONCO(164,SCG,"SPS",SUB,0)),U,1) S DFCODE=SUB Q
 S X=DFCODE,SPSFLG=1 Q
SCPDFIT ;Special default code for field #138.1 called from input transform
 D SETVARS I TPG="" Q
 I X?1N Q
 F SUB=0:0 S SUB=$O(^ONCO(164,SCG,"SC5",SUB)) Q:SUB'>0!(DFCODE'="")  D
 .I DFTXT=$P($G(^ONCO(164,SCG,"SC5",SUB,0)),U,1) S DFCODE=SUB Q
 S X=DFCODE,SCPFLG=1 Q
 Q
NUMDFIT ;Special default code for field #140.1 called from input transform
 S X=+X
 Q
SOSDFIT ;Special default code for field #139.1 called from input transform
 D SETVARS I TPG="" Q
 I X?1.2N Q
 F SUB=0:0 S SUB=$O(^ONCO(164,SCG,"SO5",SUB)) Q:SUB'>0!(DFCODE'="")  D
 .I DFTXT=$P($G(^ONCO(164,SCG,"SO5",SUB,0)),U,1) S DFCODE=SUB Q
 S X=DFCODE,SOSFLG=1 Q
 Q
SETVARS ;
 S SCG="",TPG=$P($G(^ONCO(165.5,D0,2)),U,1) I TPG="" Q
 S SCG=$P($G(^ONCO(164,TPG,0)),U,16)
 S DFTXT=X,DFCODE=""
 Q
 ;
CLEANUP ;Cleanup
 K CONTFLG,D0,DASHES,DATEDX,SCPFLG,SOSFLG,SPSFLG,X,Y
