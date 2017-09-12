PSN4P4 ;BIR/DMA-delete remote members from mail group NDF DATA ;20 Jan 99 / 12:30 PM
 ;;4.0; NATIONAL DRUG FILE;**4**; 30 Oct 98
 ;
 ;Reference to ^XMB(3.8 supported by DBIA #2061
 ;
 N DA,DIC,DIE,DR,PSN,PSN1,X,Y
 S DIC="^XMB(3.8,",X="NDF DATA" D ^DIC Q:Y<0  S PSN1=+Y
 F PSN="MONTALI,M","BARRON,LUANNE","TATUM,W" S X=PSN_"@ISC-BIRM.DOMAIN.EXT",DIC="^XMB(3.8,"_PSN1_",6,",DA(1)=PSN1 D ^DIC I Y S DA=+Y,DIE=DIC,DR=".01///@" D ^DIE
 Q
