ONCNPI ;Hines OIFO/GWB - National Provider Identifier ;02/16/07
 ;;2.11;ONCOLOGY;**48,49,50**;Mar 07, 1995;Build 29
 ;
FNPI ;Check FACILITY (160.19) for NPI (National Provider Identifier)
 N Y
 I FACPNT="" G FEXIT
 D DTDXCK I DTDXCK="N" G FEXIT
 S FAC=$P($G(^ONCO(160.19,FACPNT,0)),U,1)
 S FACNAM=$P($G(^ONCO(160.19,FACPNT,0)),U,2)
 I (FAC="00000000")!(FAC=9999999) G FEXIT
 S NPI=$P($G(^ONCO(160.19,FACPNT,0)),U,6)
 I NPI="" D ADDFNPI
FEXIT K DTDXCK,NPI,FACIEN,FAC,FACNAM,FACPNT
 Q
 ;
DTDXCK ;Check for 2007+ DATE DX (165.5,3)
 N PRI
 I '$D(ONCOD0) S DTDXCK="Y" Q
 S DTDXCK="N"
 S PRI=0 F  S PRI=$O(^ONCO(165.5,"C",ONCOD0,PRI)) Q:PRI'>0  I $P($G(^ONCO(165.5,PRI,0)),U,16)>3069999 S DTDXCK="Y" Q
 Q
 ;
ADDFNPI ;Enter Organizational Provider NPI value
 W !
 W !,"  This facility needs to be associated with"
 W !,"  an NPI (National Provider Identifier) code."
 W !
FNPIR K DIR
 S DIR("A")="  Select method of NPI entry: "
 S DIR(0)="SAO^1:Get NPI from INSTITUTION file;2:Enter NPI code manually"
 S DIR("??")="^D FNPIHLP^ONCNPI"
 D ^DIR
 I $D(DIRUT) S OUT=1 K DIRUT G FNPIEX
 I Y<1 S OUT=1 G FNPIEX
 S NPIANS=Y
 I NPIANS=2 W ! R "  Enter 10-digit NPI: ",NPI:60 G FNPICHK
DIC4 N DIC,DTOUT,DUOUT,INSTIEN
 S DIC="^DIC(4,"
 S DIC("A")="  Select INSTITUTION: "
 S DIC(0)="AEQM"
 S DIC("S")="I $P($G(^(""NPI"")),U,1)'="""""
 D ^DIC
 G:($D(DUOUT))!($D(DTOUT))!(Y=-1) FNPIEX
 S INSTIEN=+Y
 K DIR
 S DIR("A")="  Is this the correct institution",DIR("B")="Y",DIR(0)="Y"
 D ^DIR
 G SETFNPI:Y,DIC4:Y=0 Q
SETFNPI S NPI=$P(^DIC(4,INSTIEN,"NPI"),U,1)
FNPICHK I (NPI="")!(NPI=U) W ! G FNPIEX
 I NPI'?10N W !!,"The NPI code must be 10 digits.",!! G FNPIR
 I $D(^ONCO(160.19,"F",NPI)) D  G FNPIR
 .S FACIEN=$O(^ONCO(160.19,"F",NPI,0))
 .S FAC=$P(^ONCO(160.19,FACIEN,0),U,2)
 .W !!,"  This NPI is already being used by ",FAC,".",!
 W !!,"  NPI code ",NPI," has been added for:"
 W !,"   ",FACNAM
 S $P(^ONCO(160.19,FACPNT,0),U,6)=NPI
 S ^ONCO(160.19,"F",NPI,FACPNT)=""
FNPIEX W !
 K NPIANS Q
 ;
FNPIIT ;NPI (160.19,101) INPUT TRANSFORM
 I $D(^ONCO(160.19,"F",X)) D
 .S FACIEN=$O(^ONCO(160.19,"F",X,0))
 .I FACIEN'=DA D  K X
 ..S FAC=$P(^ONCO(160.19,FACIEN,0),U,2)
 ..W !!,"  This NPI code is already being used by ",FAC,".",!
 K FACIEN,FAC
 Q
 ;
PNPI ;Check ONCOLOGY CONTACT (165) for NPI (National Provider Identifier)
 N Y,DATEDX
 I PHYPNT="" G PEXIT
 S DATEDX=$$GET1^DIQ(165.5,D0,3,"I")
 I (DATEDX<3070000)&(DATEDX'="") G PEXIT
 S PHY=$P($G(^ONCO(165,PHYPNT,0)),U,1)
 I (PHY="00000000")!(PHY=88888888)!(PHY=99999999) G PEXIT
 S NPI=$P($G(^ONCO(165,PHYPNT,0)),U,5)
 I NPI="" D ADDPNPI
PEXIT K NPI,FACIEN,FAC,FACPNT,PHY,PHYPNT
 Q
 ;
ADDPNPI ;Enter Individual Provider NPI value
 W !
 W !,"  This provider needs to be associated with"
 W !,"  an NPI (National Provider Identifier) code."
 W !
 ;
PNPIR K DIR
 S DIR("A")="  Select method of NPI entry: "
 S DIR(0)="SAO^1:Get NPI from NEW PERSON file;2:Enter NPI code manually"
 S DIR("??")="^D PNPIHLP^ONCNPI"
 D ^DIR
 I $D(DIRUT) S OUT=1 K DIRUT G PNPIEX
 I Y<1 S OUT=1 G PNPIEX
 S NPIANS=Y
 I NPIANS=2 W ! R "  Enter 10-digit NPI: ",NPI:60 G PNPICHK
DIC200 N DTOUT,DUOUT,VAIEN
 S DIC="^VA(200,"
 S DIC("A")="  Select PROVIDER: "
 S DIC(0)="AEQM"
 S DIC("S")="I $P($G(^(""NPI"")),U,1)'="""""
 D ^DIC
 G:($D(DUOUT))!($D(DTOUT))!(Y=-1) PNPIEX
 S VAIEN=+Y
 K DIR
 S DIR("A")="  Is this the correct provider",DIR("B")="Y",DIR(0)="Y"
 D ^DIR
 G SETPNPI:Y,DIC200:Y=0 Q
SETPNPI S NPI=$P(^VA(200,VAIEN,"NPI"),U,1)
PNPICHK I (NPI="")!(NPI=U) W ! G PNPIEX
 I NPI'?10N W !!,"The NPI code must be 10 digits.",!! G PNPIR
 ;I $D(^ONCO(165,"F",NPI)) D  G PNPIR
 ;.S PHYIEN=$O(^ONCO(165,"F",NPI,0))
 ;.S PHY=$P(^ONCO(165,PHYIEN,0),U,1)
 ;.W !!,"  This NPI code is already being used by ",PHY,".",!!
 W !!,"  NPI code ",NPI," has been added for ",PHY,"."
 S $P(^ONCO(165,PHYPNT,0),U,5)=NPI
 S ^ONCO(165,"F",NPI,PHYPNT)=""
PNPIEX W !
 K NPIANS,PHY Q
 ;
PNPIIT ;NPI (165,101) INPUT TRANSFORM
 ;I $D(^ONCO(165,"F",X)) D
 ;.S PHYIEN=$O(^ONCO(165,"F",X,0))
 ;.I PHYIEN'=DA D  K X
 ;..S PHY=$P(^ONCO(165,PHYIEN,0),U,1)
 ;..W !!,"  This NPI code is already being used by ",PHY,".",!
 ;K PHYIEN,PHY
 Q
 ;
FNPIHLP ;"??" NPI help
 W !,"  Select 'Get NPI from INSTITUTION file' if you wish to"
 W !,"  extract the Organizational Provider NPI code from the"
 W !,"  INSTITUTION file."
 W !
 W !,"  Select 'Enter NPI code manually' if you wish to enter"
 W !,"  the 10-digit NPI code manually."
 W !
 W !,"  NPI codes for Organizational Providers can be found by"
 W !,"  searching the NPI Registry at the following websites:"
 W !
 W !,"  https://nppes.cms.hhs.gov"
 W !,"  Click on ""Search the NPI Registry""."
 W !
 W !,"  http://www.npinumberlookup.org/"
 Q
 ;
PNPIHLP ;"??" NPI help
 W !,"  Select 'Get NPI from NEW PERSON file' if you wish to"
 W !,"  extract the Individual Provider NPI code from the"
 W !,"  NEW PERSON file."
 W !
 W !,"  Select 'Enter NPI code manually' if you wish to enter"
 W !,"  the 10-digit NPI code manually."
 W !
 W !,"  NPI codes for Individual Providers can be found by searching"
 W !,"  the NPI Registry at the following websites:"
 W !
 W !,"  https://nppes.cms.hhs.gov"
 W !,"  Click on ""Search the NPI Registry""."
 W !
 W !,"  http://www.npinumberlookup.org/"
 Q
