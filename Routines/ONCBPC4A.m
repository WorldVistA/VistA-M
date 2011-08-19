ONCBPC4A ;HIRMFO/GWB - PCE Study of Cancers of the Urinary Bladder Table IV;6/19/96
 ;;2.11;ONCOLOGY;**6,16**;Mar 07, 1995
RAD W !!,"RADIATION THERAPY:",!
 S RAD=ONC(165.5,ONCONUM,51.2,"I"),RADOT=ONC(165.5,ONCONUM,51.2,"E")
 W !,"  RADIATION THERAPY.................: ",RADOT
 S RADDT=$P($G(^ONCO(165.5,ONCONUM,3)),U,4)
 S Y=RADDT D DATEOT^ONCOPCE S RADDT=Y
 W !,"  DATE RADIATION THERAPY STARTED....: ",RADDT
 I (RAD=0)!(RAD=7) D  G:(Y=0)!(Y="") EXIT W @IOF G CHEMO
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,16)="0000000" ; 2/2/98 WAA
 .W !,"  DATE RADIATION THERAPY ENDED......: 00/00/0000"
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,17)=0
 .W !,"  TOTAL RAD (cGy/rad) DOSE..........: 00000"
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,18)=1
 .W !,"  REGIONAL TREATMENT MODALITY.......: No radiation therapy"
 .W !!,"  RADIATION COMPLICATIONS:",!
 .F PIECE=19:1:21 S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,PIECE)=8
 .W !,"    URINARY INCONTINENCE............: Not applicable"
 .W !,"    HEMATURIA.......................: Not applicable"
 .W !,"    RADIATION BOWEL INJURY..........: Not applicable"
 .W ! K DIR S DIR(0)="E" D ^DIR
 I (RAD=8)!(RAD=9) D  G:(Y=0)!(Y="") EXIT W @IOF G CHEMO
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,16)=9999999 ; 2/2/98 WAA
 .W !,"  DATE RADIATION THERAPY ENDED......: 99/99/9999"
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,17)=99999
 .W !,"  TOTAL RAD (cGy/rad) DOSE..........: 99999"
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,18)=19
 .W !,"  REGIONAL TREATMENT MODALITY.......: Unknown"
 .W !!,"  RADIATION COMPLICATIONS:",!
 .F PIECE=19:1:21 S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,PIECE)=9
 .W !,"    URINARY INCONTINENCE............: Unknown"
 .W !,"    HEMATURIA.......................: Unknown"
 .W !,"    RADIATION BOWEL INJURY..........: Unknown"
 .W ! K DIR S DIR(0)="E" D ^DIR
 S DR="361  DATE RADIATION THERAPY ENDED......" D ^DIE G:$D(Y) JUMP
 S DR="362  TOTAL RAD (cGy/rad) DOSE.........." D ^DIE G:$D(Y) JUMP
 S DR="363  REGIONAL TREATMENT MODALITY......." D ^DIE G:$D(Y) JUMP
 W !!,"  RADIATION COMPLICATIONS:",!
 S DR="364    URINARY INCONTINENCE............" D ^DIE G:$D(Y) JUMP
 S DR="365    HEMATURIA......................." D ^DIE G:$D(Y) JUMP
 S DR="366    RADIATION BOWEL INJURY.........." D ^DIE G:$D(Y) JUMP
CHEMO W !!,"CHEMOTHERAPY:",!
 S CHEMO=ONC(165.5,ONCONUM,53.2,"I"),CHEMOT=ONC(165.5,ONCONUM,53.2,"E")
 W !,"  CHEMOTHERAPY......................: ",CHEMOT
 S CHEDT=$P($G(^ONCO(165.5,ONCONUM,3)),U,11)
 S Y=CHEDT D DATEOT^ONCOPCE S CHEDT=Y
 W !,"  DATE CHEMOTHERAPY STARTED.........: ",CHEDT
 I (CHEMO=0)!(CHEMO=7) D  G:(Y=0)!(Y="") EXIT W @IOF G BRM
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,22)="0000000" ; 2/2/98 WAA
 .W !,"  DATE CHEMOTHERAPY ENDED...........: 00/00/0000"
 .F PIECE=23:1:36 S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,PIECE)=0
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,41)=0
 .W !,"  ROUTE CHEMOTHERAPY ADMINISTERED...: No chemotherapy"
 .W !!,"  TYPES OF AGENTS ADMINISTERED:",!
 .W !,"    ADRIAMYCIN......: None      IFOSFAMIDE......: None"
 .W !,"    CARBOPLATINUM...: None      METHOTREXATE....: None"
 .W !,"    CISPLATIN.......: None      TAXOL...........: None"
 .W !,"    CYCLOPHOSPHAMIDE: None      THIOTEPA........: None"
 .W !,"    5-FLUOROURACIL..: None      VINBLASTINE.....: None"
 .W !,"    GALLIUM NITRATE.: None      OTHER...........: None"
 .W !!,"  INDICATION FOR ADMIN OF AGENTS....: No agents administered, NA"
 .W !!,"  REASON CHEMOTHERAPY STOPPED.......: Treatment completed, NA"
 .W ! K DIR S DIR(0)="E" D ^DIR
 I (CHEMO=8)!(CHEMO=9) D  G:(Y=0)!(Y="") EXIT W @IOF G BRM
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,22)=9999999 ; 2/2/98 WAA
 .W !,"  DATE CHEMOTHERAPY ENDED...........: 99/99/9999"
 .F PIECE=23:1:36 S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,PIECE)=9
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,41)=9
 .W !,"  ROUTE CHEMOTHERAPY ADMINISTERED...: Unknown"
 .W !!,"  TYPES OF AGENTS ADMINISTERED:",!
 .W !,"    ADRIAMYCIN......: Unknown   IFOSFAMIDE......: Unknown"
 .W !,"    CARBOPLATINUM...: Unknown   METHOTREXATE....: Unknown"
 .W !,"    CISPLATIN.......: Unknown   TAXOL...........: Unknown"
 .W !,"    CYCLOPHOSPHAMIDE: Unknown   THIOTEPA........: Unknown"
 .W !,"    5-FLUOROURACIL..: Unknown   VINBLASTINE.....: Unknown"
 .W !,"    GALLIUM NITRATE.: Unknown   OTHER...........: Unknown"
 .W !!,"  INDICATION FOR ADMIN OF AGENTS....: Unknown"
 .W !!,"  REASON CHEMOTHERAPY STOPPED.......: Unknown"
 .W ! K DIR S DIR(0)="E" D ^DIR
 S DR="367  DATE CHEMOTHERAPY ENDED..........." D ^DIE G:$D(Y) JUMP
 S DR="368  ROUTE CHEMOTHERAPY ADMINISTERED..." D ^DIE G:$D(Y) JUMP
 W !!,"  TYPES OF AGENTS ADMINISTERED:",!
 S DR="369    ADRIAMYCIN......................" D ^DIE G:$D(Y) JUMP
 S DR="370    CARBOPLATINUM..................." D ^DIE G:$D(Y) JUMP
 S DR="371    CISPLATIN......................." D ^DIE G:$D(Y) JUMP
 S DR="372    CYCLOPHOSPHAMIDE................" D ^DIE G:$D(Y) JUMP
 S DR="373    5-FLUOROURACIL.................." D ^DIE G:$D(Y) JUMP
 S DR="374    GALLIUM NITRATE................." D ^DIE G:$D(Y) JUMP
 S DR="375    IFOSFAMIDE......................" D ^DIE G:$D(Y) JUMP
 S DR="376    METHOTREXATE...................." D ^DIE G:$D(Y) JUMP
 S DR="377    TAXOL..........................." D ^DIE G:$D(Y) JUMP
 S DR="378    THIOTEPA........................" D ^DIE G:$D(Y) JUMP
 S DR="379    VINBLASTINE....................." D ^DIE G:$D(Y) JUMP
 S DR="380    OTHER AGENT....................." D ^DIE G:$D(Y) JUMP
 W !
 S DR="381  INDICATION FOR ADMIN OF AGENTS...." D ^DIE G:$D(Y) JUMP
 S DR="382  REASON CHEMOTHERAPY STOPPED......." D ^DIE G:$D(Y) JUMP
BRM W !!,"IMMUNOTHERAPY:",!
 S BRM=ONC(165.5,ONCONUM,55.2,"I"),BRMOT=ONC(165.5,ONCONUM,55.2,"E")
 W !,"  IMMUNOTHERAPY (BRM)...............: ",BRMOT
 W !!,"  TYPE OF IMMUNOTHERAPY (BRM):",!
 I (BRM=6)!(BRM=7) D  W ! K DIR S DIR(0)="E" D ^DIR G EXIT
 .F PIECE=37:1:40 S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,PIECE)=0
 .W !,"    BCG......................: None"
 .W !,"    INTERFERON...............: None"
 .W !,"    INTERLEUKIN-II...........: None"
 .W !,"    OTHER....................: None"
 I (BRM=8)!(BRM=9) D  W ! K DIR S DIR(0)="E" D ^DIR G EXIT
 .F PIECE=37:1:40 S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,PIECE)=9
 .W !,"    BCG......................: Unknown"
 .W !,"    INTERFERON...............: Unknown"
 .W !,"    INTERLEUKIN-II...........: Unknown"
 .W !,"    OTHER....................: Unknown"
 S DR="383    BCG............................." D ^DIE G:$D(Y) JUMP
 S DR="384    INTERFERON......................" D ^DIE G:$D(Y) JUMP
 S DR="385    INTERLEUKIN-II.................." D ^DIE G:$D(Y) JUMP
 S DR="386    OTHER..........................." D ^DIE G:$D(Y) JUMP
 W ! K DIR S DIR(0)="E" D ^DIR
 G EXIT
JUMP ;Jump to prompts
 S XX="" R !!,"GO TO: ",X:DTIME G:(X="")!(X[U) EXIT
 I X["?" D  G JUMP
 .W !,"CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 I '$D(TABLE(X)) S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !,"CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 S X=TABLE(X)
 G @X
EXIT K CHOICES,HTABLE,TABLE
 K BRM,CDS,CDSOT,CHEDT,CHEMO,DOIT,LOS,NCDS,NCDSOT,NOP,PIECE,RAD,RADDT
 K SURG,SURG1,SURG2,SURGDT,Z
 K DIC
 Q
