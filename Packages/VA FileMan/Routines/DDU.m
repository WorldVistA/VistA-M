DDU ;SFISC/DCM-DD UTILITES ;18JUN2009
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1039**
 ;
0 S DIC="^DOPT(""DDU"","
 G OPT:$D(^DOPT("DDU",4)) S ^(0)="DATA DICTIONARY UTILITY OPTION^1.01" K ^("B")
 F X=1:1:4 S ^DOPT("DDU",X,0)=$P($T(@X),";;",2)
 S DIK=DIC D IXALL^DIK
OPT ;
 S DIC(0)="AEQIZ" D ^DIC G Q:Y<0 S DI=+Y D EN G 0
 ;
EN ;
 D @DI W !!
Q K %,DIC,DIK,DI,DA,I,J,X,Y Q
 ;
1 ;;LIST FILE ATTRIBUTES
 G ^DID
 ;
2 ;;MAP POINTER RELATIONS
 G ^DDMAP
 ;
3 ;;CHECK/FIX DD STRUCTURE
 G ^DDUCHK
 ;
4 ;;FIND POINTERS INTO A FILE
 G ^DIDGFTPT
 ;
