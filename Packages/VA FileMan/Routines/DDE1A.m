DDE1A ;DOITFO/PLT - Entity Enter/Edit via FM ;AUG 1, 2018  12:37
 ;;22.2;VA FileMan;**9**;Jan 05, 2016;Build 73
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 QUIT
 ;
 ;entity look-up
EN ;
 N X,Y,DIC,DA,DDEIEN,DDSFILE,DDSPAGE,DR,DDSPARM
 S DIC="^DDE(",DIC(0)="AELMQZ"
 D ^DIC G END:(X="")!(X?1"^".E),EN:Y<1 S DDEIEN=+Y
 S DA=DDEIEN,DDSFILE=1.5,DDSPAGE=1,DR="[DDE ENTITY ENTER/EDIT]",DDSPARM="CS"
 D ^DDS
 G EN
 ;
END ;
 QUIT
