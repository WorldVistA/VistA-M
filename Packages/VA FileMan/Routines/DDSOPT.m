DDSOPT ;SFISC/MLH,MKO-SCREENMAN OPTIONS ;18JAN2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**MSC,1042**
 ;
0 S DIC="^DOPT(""DDS"","
 G OPT:$D(^DOPT("DDS",7)) S ^(0)="SCREENMAN OPTION^1.01" K ^("B")
 F X=1:1:7 S ^DOPT("DDS",X,0)=$P($T(@X),";;",2)
 S DIK=DIC D IXALL^DIK
OPT ;
 S DIC(0)="AEQIZ" D ^DIC G Q:Y<0 S DI=+Y D EN G 0
 ;
EN ;Entry point for all screenman options
 D @DI W !!
Q K %,DI,DIC,DIK,X,Y Q
 ;
1 ;;EDIT/CREATE A FORM
CREATE G ^DDGF
 ;
2 ;;RUN A FORM
 G ^DDSRUN
 ;
3 ;;DELETE A FORM
 G ^DDSDFRM
 ;
4 ;;PURGE UNUSED BLOCKS
 G ^DDSDBLK
 ;
5 ;;PRINT A FORM
 G PRINT^DDS
 ;
6 ;;CUSTOMIZE COLORS
 I $G(^XTV(8989.5,0))'?1"PARAM".E W !,"PARAMETERS SYSTEM IS NOT INSTALLED HERE" Q
 D EDITPAR^XPAREDIT("DI SCREENMAN COLORS") Q
  ;
7 ;;CLONE A FORM
 D ^DDSCLONE
