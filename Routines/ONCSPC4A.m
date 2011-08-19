ONCSPC4A ;HIRMFO/GWB - PCE Study of Soft Tissue Sarcoma Table IV;6/19/96
 ;;2.11;ONCOLOGY;**6**;Mar 07, 1995
C W !!,"CHEMOTHERAPY:",!
 S CHEMO=ONC(165.5,ONCONUM,53.2,"I"),CHEMOT=ONC(165.5,ONCONUM,53.2,"E")
 W !,"  CHEMOTHERAPY....................: ",CHEMOT
 S CHEDT=ONC(165.5,ONCONUM,53,"I"),Y=CHEDT D DATEOT^ONCOPCE S CHEDT=Y
 W !,"  DATE OF CHEMOTHERAPY............: ",CHEDT
 W !!,"AGENTS ADMINISTERED, METHODS OF DELIVERY AND LOCATIONS:",!
 I CHEMO=0 D  G CSF
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,26)=0
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,18)=8
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,24)=8
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,14)=0
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,19)=8
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,25)=8
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,15)=0
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,20)=8
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,26)=8
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,16)=0
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,21)=8
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,27)=8
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,17)=0
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,22)=8
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,28)=8
 .S $P(^ONCO(165.5,ONCONUM,"BLA2"),U,30)=0
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,23)=8
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,29)=8
 .W !,"  CISPLATIN.........: No                 DOXORUBICIN.......: No"
 .W !,"  METHOD OF DELIVERY: Not applicable     METHOD OF DELIVERY: Not applicable"
 .W !,"  LOCATION..........: Not applicable     LOCATION..........: Not applicable"
 .W !!,"  CYTOXAN...........: No                 ETOPOSIDE.........: No"
 .W !,"  METHOD OF DELIVERY: Not applicable     METHOD OF DELIVERY: Not applicable"
 .W !,"  LOCATION..........: Not applicable     LOCATION..........: Not applicable"
 .W !!,"  DTIC..............: No                 IFOSFAMIDE........: No"
 .W !,"  METHOD OF DELIVERY: Not applicable     METHOD OF DELIVERY: Not applicable"
 .W !,"  LOCATION..........: Not applicable     LOCATION..........: Not applicable"
CIS S DR="371  CISPLATIN......................." D ^DIE G:$D(Y) JUMP
 I X=0 D  G CYT
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,18)=8
 .W !,"  METHOD OF DELIVERY..............: Not applicable"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,24)=8
 .W !,"  LOCATION........................: Not applicable"
 I X=9 D  G CYT
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,18)=9
 .W !,"  METHOD OF DELIVERY..............: Unknown"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,24)=9
 .W !,"  LOCATION........................: Unknown"
 S DR="547  METHOD OF DELIVERY.............." D ^DIE G:$D(Y) JUMP
 S DR="553  LOCATION........................" D ^DIE G:$D(Y) JUMP
CYT W !
 S DR="543  CYTOXAN........................." D ^DIE G:$D(Y) JUMP
 I X=0 D  G DTIC
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,19)=8
 .W !,"  METHOD OF DELIVERY..............: Not applicable"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,25)=8
 .W !,"  LOCATION........................: Not applicable"
 I X=9 D  G DTIC
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,19)=9
 .W !,"  METHOD OF DELIVERY..............: Unknown"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,25)=9
 .W !,"  LOCATION........................: Unknown"
 S DR="548  METHOD OF DELIVERY.............." D ^DIE G:$D(Y) JUMP
 S DR="554  LOCATION........................" D ^DIE G:$D(Y) JUMP
DTIC W !
 S DR="544  DTIC............................" D ^DIE G:$D(Y) JUMP
 I X=0 D  G DOX
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,20)=8
 .W !,"  METHOD OF DELIVERY..............: Not applicable"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,26)=8
 .W !,"  LOCATION........................: Not applicable"
 I X=9 D  G DOX
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,20)=9
 .W !,"  METHOD OF DELIVERY..............: Unknown"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,26)=9
 .W !,"  LOCATION........................: Unknown"
 S DR="549  METHOD OF DELIVERY.............." D ^DIE G:$D(Y) JUMP
 S DR="555  LOCATION........................" D ^DIE G:$D(Y) JUMP
DOX W !
 S DR="545  DOXURUBICIN....................." D ^DIE G:$D(Y) JUMP
 I X=0 D  G ETO
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,21)=8
 .W !,"  METHOD OF DELIVERY..............: Not applicable"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,27)=8
 .W !,"  LOCATION........................: Not applicable"
 I X=9 D  G ETO
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,21)=9
 .W !,"  METHOD OF DELIVERY..............: Unknown"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,27)=9
 .W !,"  LOCATION........................: Unknown"
 S DR="550  METHOD OF DELIVERY.............." D ^DIE G:$D(Y) JUMP
 S DR="556  LOCATION........................" D ^DIE G:$D(Y) JUMP
ETO W !
 S DR="546  ETOPOSIDE......................." D ^DIE G:$D(Y) JUMP
 I X=0 D  G IFO
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,22)=8
 .W !,"  METHOD OF DELIVERY..............: Not applicable"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,28)=8
 .W !,"  LOCATION........................: Not applicable"
 I X=9 D  G IFO
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,22)=9
 .W !,"  METHOD OF DELIVERY..............: Unknown"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,28)=9
 .W !,"  LOCATION........................: Unknown"
 S DR="551  METHOD OF DELIVERY.............." D ^DIE G:$D(Y) JUMP
 S DR="557  LOCATION........................" D ^DIE G:$D(Y) JUMP
IFO W !
 S DR="375  IFOSFAMIDE......................" D ^DIE G:$D(Y) JUMP
 I X=0 D  G CSF
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,23)=8
 .W !,"  METHOD OF DELIVERY..............: Not applicable"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,29)=8
 .W !,"  LOCATION........................: Not applicable"
 I X=9 D  G CSF
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,23)=9
 .W !,"  METHOD OF DELIVERY..............: Unknown"
 .S $P(^ONCO(165.5,ONCONUM,"STS2"),U,29)=9
 .W !,"  LOCATION........................: Unknown"
 S DR="552  METHOD OF DELIVERY.............." D ^DIE G:$D(Y) JUMP
 S DR="558  LOCATION........................" D ^DIE G:$D(Y) JUMP
CSF W ! S DR="559  COLONY STIMULATING FACTORS......" D ^DIE G:$D(Y) JUMP
 S DR="560  NATIONAL TREATMENT PROTOCOL....." D ^DIE G:$D(Y) JUMP
 S DR="561  OTHER PROTOCOL.................." D ^DIE G:$D(Y) JUMP
 S DR="562  REFERRED TO REHAB SERVICES......" D ^DIE G:$D(Y) JUMP
 S DR="563  CONSULT W PHYSICAL THERAPY/REHAB" D ^DIE G:$D(Y) JUMP
 S DR="564  TRANSFERRED TO REHAB FACILITY..." D ^DIE G:$D(Y) JUMP
 S DR="565  NO OF HOSPITALIZATIONS W/I 6 MO." D ^DIE G:$D(Y) JUMP
 S DR="566  TOTAL LENGTH OF STAYS..........." D ^DIE G:$D(Y) JUMP
 G EXIT
JUMP ;Jump to prompts
 S XX="" R !!,"GO TO: ",X:DTIME I (X="")!(X[U) S OUT="Y" G EXIT
 I X["?" D  G JUMP
 .W !,"CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 I '$D(TABLE(X)) S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !,"CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 S X=TABLE(X)
 G @X
EXIT K CHOICES,HTABLE,TABLE
 K CDS,CDS1,CDS2,CDSDT,CHEMO,DOFCT,HT,LOS,NCDS,NCDS1,NCDS2,NCDSDT,NOP,RAD
 K RADDT
 Q
