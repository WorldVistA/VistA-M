DII1 ;SFISC/XAK-OTHER OPTIONS ;7/25/96  14:15
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
0 S DIC="^DOPT(""DII1"","
 G OPT:$D(^DOPT("DII1",9)) S ^(0)="OTHER OPTION^1.01" K ^("B")
 F X=1:1:9 S ^DOPT("DII1",X,0)=$P($T(@X),";;",2)
 S DIK=DIC D IXALL^DIK
OPT ;
 S DIC(0)="AEQIZ" D ^DIC G Q:Y<0 S DI=+Y D EN G 0
 ;
EN ;
 D @DI W !!
Q K %,DIC,DIK,DI,DA,I,J,X,Y Q
 ;
1 ;;FILEGRAMS
 G ^DIFGO
 ;
2 ;;ARCHIVING
 G NOKL^DIAR
 ;
3 ;;AUDITING
 G ^DIAU
 ;
4 ;;SCREENMAN
 G ^DDSOPT
 ;
5 ;;STATISTICS
 G ^DIX
 ;
6 ;;EXTRACT DATA TO FILEMAN FILE
 G ^DIAX
 ;
7 ;;DATA EXPORT TO FOREIGN FORMAT
 G NOKL^DDXP
 ;
8 ;;IMPORT DATA
 G EN^DDMPU
 ;
9 ;;BROWSER
 G ^DDBR
