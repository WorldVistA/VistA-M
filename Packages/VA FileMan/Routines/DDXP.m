DDXP ;SFISC/DPC-EXPORT MENU DRIVER ;12:09 PM  16 Jun 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**9**
 ;
NOKL ;
 I ($G(^DIC(.44,0,"GL"))'="^DIST(.44,")!($G(^DIC(.81,0,"GL"))'="^DI(.81,") W !!,$C(7),"SORRY. You cannot use the Data Export options",!,"because you do not have the necessary files on your system." G Q^DII1
 S DIK="^DOPT(""DDXP"","
 I $D(^DOPT("DDXP",5)) G CHOOSE
 S ^DOPT("DDXP",0)="DATA EXPORT TO FOREIGN FORMAT OPTION^1.01^" K ^("B")
 F I=1:1:5 S ^DOPT("DDXP",I,0)=$P($T(@I),";;",2)
 K I D IXALL^DIK
CHOOSE ;
 W ! S DIC=DIK,DIC(0)="AEQI" D ^DIC K DIC,DIK
 I Y'<0 S X=+Y K Y D @X G NOKL
 W !
 G Q^DII1
 ;
1 ;;DEFINE FOREIGN FILE FORMAT
 S DDXP=1 D EN1^DDXP1
 D Q
 Q
 ;
2 ;;SELECT FIELDS FOR EXPORT
 S DDXP=2 D EN1^DDXP2
 D Q
 Q
 ;
3 ;;CREATE EXPORT TEMPLATE
 S DDXP=3 D EN1^DDXP3
 D Q
 Q
 ;
4 ;;EXPORT DATA
 S DDXP=4 D EN1^DDXP4
 D Q
 Q
 ;
5 ;;PRINT FORMAT DOCUMENTATION
 S DDXP=5 D EN1^DDXP5
 D Q
 Q
Q ;
 K DDXP,X,DIRUT,DUOUT,DTOUT Q
 ; Export API
EXPORT(DDXPFINO,DDXPXTNM,DDXPTMDL,DDXPBY,FR,TO,DIS,DISTOP,IOP,DQTIME) ;
 ; DDXPFINO = File Number or "1.1^<file number>"
 ; DDXPXTNM = Export Template Name
 ; DDXPTMDL = 0=Export Template SHOULD NOT Be Deleted
 ;            1=Export Template SHOULD Be Deleted
 ; DDXPBY = Sort Template Name
 ; [.]FR = FROM Values as Documentated in DIP
 ; [.]TO = TO Values as Documentated in DIP
 ; .DIS = DIS array as Documentated in DIP
 ; [.]DISTOP = DISTOP array as Documentated in DIP
 ; IOP = IOP as Documentated in DIP
 ; DQTIME = DQTIME as Documentated in DIP
 G EN2^DDXP4
