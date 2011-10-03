ONCMPC4A ;HINES CIOFO/GWB - 1999 Melanoma Study - Table IV (continued); 1/22/99
 ;;2.11;ONCOLOGY;**22**;Mar 07, 1995
SN W !," SENTINEL NODES",!
 W " --------------"
PL I $E(TOPCOD,1,3)="C69" D  G SNDB
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,23)=8
 .W !," 57. PRE-OP LYMPHOSCINTIGRAPHY.....: NA, ocular site"
 S DR="1122 57. PRE-OP LYMPHOSCINTIGRAPHY....." D ^DIE G:$D(Y) JUMP
SNDB S PL=$P($G(^ONCO(165.5,ONCONUM,"MEL1")),U,23)
 I (PL=0)!(PL=8) D  G SNP
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,24)=8
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,44)=8
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,25)=8
 .W !," 58. SENTINEL NODES DETECTED BY....: NA, not done, ocular site"
 .W !," 59. SENTINEL NODE BIOPSY..........: NA, not done, ocular site"
 .W !," 60. SENTINEL NODES EXAMINED.......: NA, not done, ocular site"
 I PL=9 D  G SNP
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,24)=9
 .S $P(^ONCO(165.5,ONCONUM,"BRE1"),U,44)=9
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,25)=9
 .W !," 58. SENTINEL NODES DETECTED BY....: Unknown"
 .W !," 59. SENTINEL NODE BIOPSY..........: Unknown"
 .W !," 60. SENTINEL NODES EXAMINED.......: Unknown"
 S DR="1123 58. SENTINEL NODES DETECTED BY...." D ^DIE G:$D(Y) JUMP
SNB S DR="943 59. SENTINEL NODE BIOPSY.........." D ^DIE G:$D(Y) JUMP
SNE S DR="1124 60. SENTINEL NODES EXAMINED......." D ^DIE G:$D(Y) JUMP
SNP S SNE=$P($G(^ONCO(165.5,ONCONUM,"MEL1")),U,25)
 I (SNE=0)!(SNE=8) D  G ISNP
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,26)=8
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,27)=8
 .W !," 61. SENTINEL NODES POSITIVE.......: NA, not done, no exam, ocular site"
 .W !," 62. HOW WAS SENTINEL NODE                                                           PATHOLOGICALLY EXAMINED.......: NA, not done, ocular site"
 I SNE=9 D  G ISNP
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,26)=9
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,27)=9
 .W !," 61. SENTINEL NODES POSITIVE.......: Unknown"
 .W !," 62. HOW WAS SENTINEL NODE                                                           PATHOLOGICALLY EXAMINED.......: NA, not done, ocular site"
 S DR="1125 61. SENTINEL NODES POSITIVE......." D ^DIE G:$D(Y) JUMP
SNPE S DR="1126 62. HOW WAS SENTINEL NODE                                                           PATHOLOGICALLY EXAMINED......." D ^DIE G:$D(Y) JUMP
ISNP W !!," 63. IF SENTINEL NODE(S) POSITIVE:",!
 S SNP=$P($G(^ONCO(165.5,ONCONUM,"MEL1")),U,26)
 I (SNP=0)!(SNP=8) D  G RT
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,28)=8
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,29)=8
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,30)=8
 .W !,"     WAS COMPLETE LYMPH NODE                                                         DISSECTION PERFORMED..........: NA, not done, no + nodes, ocular site"
 .W !,"     NUMBER OF BASINS DETECTED.....: NA, not done, no + nodes, ocular site"
 .W !,"     NUMBER OF BASINS POSITIVE.....: NA, not done, no basins dissected, ocular"
 I SNP=9 D  G RT
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,28)=9
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,29)=9
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,30)=9
 .W !,"     WAS COMPLETE LYMPH NODE                                                         DISSECTION PERFORMED..........: Unknown"
 .W !,"     NUMBER OF BASINS DETECTED.....: Unknown"
 .W !,"     NUMBER OF BASINS POSITIVE.....: Unknown"
WCLNDP S DR="1127     WAS COMPLETE LYMPH  NODE                                                        DISSECTION PERFORMED.........." D ^DIE G:$D(Y) JUMP
 I (X=0)!(X=8) D  G RT
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,29)=8
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,30)=8
 .W !,"     NUMBER OF BASINS DETECTED....: NA, not done, no + nodes, ocular site"
 .W !,"     NUMBER OF BASINS POSITIVE....: NA, not done, no basins dissected, ocular"
 I X=9 D  G RT
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,29)=9
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,30)=9
 .W !,"     NUMBER OF BASINS DETECTED....: Unknown"
 .W !,"     NUMBER OF BASINS POSITIVE....: Unknown"
NOBD S DR="1128     NUMBER OF BASINS DETECTED....." D ^DIE G:$D(Y) JUMP
 I (X=0)!(X=8) D  G RT
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,30)=8
 .W !,"     NUMBER OF BASINS POSITIVE....: NA, not done, no basins dissected, ocular"
 I X=9 D  G RT
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,30)=9
 .W !,"     NUMBER OF BASINS POSITIVE....: Unknown"
NOBP S DR="1129     NUMBER OF BASINS POSITIVE....." D ^DIE G:$D(Y) JUMP
RT W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT W @IOF D HEAD^ONCMPC0
 W !," RADIATION THERAPY"
 W !," -----------------"
DRS W !," 64. DATE RADIATION STARTED........: ",ONC(165.5,ONCONUM,51,"E")
 W !," 65. RADIATION THERAPY.............: ",ONC(165.5,ONCONUM,51.2,"E")
RFNR W !," 66. REASON FOR NO RADIATION.......: ",ONC(165.5,ONCONUM,75,"E")
 W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT W @IOF D HEAD^ONCMPC0
C W !," CHEMOTHERAPY"
 W !," ------------"
DCS W !," 67. DATE CHEMOTHERAPY STARTED.....: ",ONC(165.5,ONCONUM,53,"E")
 W !," 68. CHEMOTHERAPY..................: ",ONC(165.5,ONCONUM,53.2,"E")
IT I ONC(165.5,ONCONUM,53.2,"I")=0 D  G HT
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,31)=8
 .W !," 69. INTRAVENOUS THERAPY...........: NA, chemotherapy not administered"
 I (ONC(165.5,ONCONUM,53.2,"I")=8)!(ONC(165.5,ONCONUM,53.2,"I")=9) D  G HT
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,31)=9
 .W !," 69. INTRAVENOUS THERAPY...........: Unknown if administered"
 S DR="1130 69. INTRAVENOUS THERAPY..........." D ^DIE G:$D(Y) JUMP
HT W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT W @IOF D HEAD^ONCMPC0
 W !," HORMONE THERAPY"
 W !," ---------------"
DHTS W !," 70. DATE HORMONE THERAPY STARTED..: ",ONC(165.5,ONCONUM,54,"E")
 W !," 71. HORMONE THERAPY...............: ",ONC(165.5,ONCONUM,54.2,"E")
 W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT W @IOF D HEAD^ONCMPC0
I W !," IMMUNOTHERAPY"
 W !," -------------"
DIS W !," 72. DATE IMMUNOTHERAPY STARTED....: ",ONC(165.5,ONCONUM,55,"E")
 W !," 73. IMMUNOTHERAPY.................: ",ONC(165.5,ONCONUM,55.2,"E")
IAA W !!," 74. IMMUNOTHERAPEUTIC AGENTS ADMINISTERED:",!
 S BRM=ONC(165.5,ONCONUM,55.2,"I")
 I (BRM=0)!(BRM=7) D  G OT
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,39)=8
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,32)=8
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,39)=8
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,38)=8
 .S $P(^ONCO(165.5,ONCONUM,"COL2"),U,40)=8
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,30)=8
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,40)=8
 .W !,"     VACCINE THERAPY...............: NA"
 .W !,"     GENE THERAPY..................: NA"
 .W !,"     INTERLEUKIN 2.................: NA"
 .W !,"     INTERFERON....................: NA"
 .W !,"     LEVAMISOLE....................: NA"
 .W !,"     COLONY STIMULATING FACTORS....: NA"
 .W !,"     OTHER GIVEN, TYPE UNKNOWN.....: NA"
 I (BRM=8)!(BRM=9) D  G OT
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,39)=9
 .S $P(^ONCO(165.5,ONCONUM,"MEL1"),U,32)=9
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,39)=9
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,38)=9
 .S $P(^ONCO(165.5,ONCONUM,"COL2"),U,40)=9
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,30)=9
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,40)=9
 .W !,"     VACCINE THERAPY...............: Unknown"
 .W !,"     GENE THERAPY..................: Unknown"
 .W !,"     INTERLEUKIN 2.................: Unknown"
 .W !,"     INTERFERON....................: Unknown"
 .W !,"     LEVAMISOLE....................: Unknown"
 .W !,"     COLONY STIMULATING FACTORS....: Unknown"
 .W !,"     OTHER GIVEN, TYPE UNKNOWN.....: Unknown"
 S DR="884     VACCINE THERAPY..............." D ^DIE G:$D(Y) JUMP
 S DR="1131     GENE THERAPY.................." D ^DIE G:$D(Y) JUMP
 S DR="385     INTERLEUKIN 2................." D ^DIE G:$D(Y) JUMP
 S DR="384     INTERFERON...................." D ^DIE G:$D(Y) JUMP
 S DR="791     LEVAMISOLE...................." D ^DIE G:$D(Y) JUMP
 S DR="559     COLONY STIMULATING FACTORS...." D ^DIE G:$D(Y) JUMP
 S DR="386     OTHER GIVEN, TYPE UNKNOWN....." D ^DIE G:$D(Y) JUMP
OT W ! K DIR S DIR(0)="E" D ^DIR G:$D(DIRUT) EXIT W @IOF D HEAD^ONCMPC0
 W !," OTHER THERAPY"
 W !," -------------"
DOTS W !," 75. DATE OTHER TREATMENT STARTED..: ",ONC(165.5,ONCONUM,57,"E")
 W !," 76. OTHER TREATMENT...............: ",ONC(165.5,ONCONUM,57.2,"E")
PRTC W ! K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
 G EXIT
JUMP ;Jump to prompts
 S XX="" R !!," GO TO ITEM: ",X:DTIME I (X="")!(X[U) S OUT="Y" G EXIT
 I X["?" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !," ",HTABLE(I)
 I '$D(TABLE(X)) S:X?1.2N X=X_"." S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !," CHOOSE FROM:" F I=1:1:CHOICES W !," ",HTABLE(I)
 S X=TABLE(X)
 G @X
EXIT S:$D(DIRUT) OUT="Y"
 K CHOICES,PIECE,HTABLE,TABLE
 K CDS,CDSOT,LOS,NCDS,NCDSOT,NOP,SURG,SURG1,SURG2,SURGDT,SA,SA1,SA2
 K SM,SM1,SM2,SOORS,SOORS1,SOORS2,PL,SNE
 K DA,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,XX,Y
 Q
