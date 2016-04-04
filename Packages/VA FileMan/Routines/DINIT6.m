DINIT6 ;SFISC/XAK-INITIALIZE VA FILEMAN ;20SEP2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1033,1042**
 ;
 I $D(^DD("OS"))[0 D OS^DINIT
 W !!,"The following files have been installed:",!
 F X=0:0 S X=$O(^DIC(X)) Q:X>1.9999  Q:'X  W $E("   ",1,(3-$L($P(X,"."))))_X,?11,$P($G(^DIC(X,0)),U),! S ^DD(X,0,"VR")=VERSION
 S ^DD("VERSION")=VERSION,X=^DD("OS",^DD("OS"),0)
DINITOSX S:$G(DINITOSX) ^DD("ROU")=$P(X,U,4) K ^DD("SUB")
 D 1
 D ^DINITPST
E W !,"INITIALIZATION COMPLETED IN "_($P($H,",",2)-DIT)_" SECONDS."
 D KL Q
 ;
1 N DIT
 D KL,PKG,DIINIT
 D PARAM
 Q
 ;
KL K %,%H,%X,%Y,DD,DH,DIC,DIK,DIT,DITZS,D,DA,VERSION,DU,F,I,J,P,X,Y,DIRUT,DTOUT,DUOUT
 Q
 ;
 ;
 ;
 ;
PKG ;
 I $D(^DIC(9.4,0))#2,($P(^DIC(9.4,0),U,1)'="PACKAGE") D  Q
 . W !!,"You have a file #9.4 that is not the 'Package' file."
 . W !,"Therefore, the Package file will not be initialized on your system."
 . W !,"You cannot use VA FileMan's package export utility, DIFROM."
 . Q
 I $$ROUEXIST^DILIBF("XPDUTL"),$$VERSION^XPDUTL("XU")'<8 Q
 K ^DD(9.4,913.5,2),^DD(9.4,914.5,2),^DD(9.4,916.5,2),^DD(9.44,222.7,2),^DD(9.44,222.9,2),^DD(9.44,1909)
 W !!,"Your Package file will now be updated.",!!
 D EN^DIPKINIT
 Q
 ;
 ;
 ;
DIINIT ;Update VA FileMan package entry
 N DIDATE,DIERR,DINIEN,DINFDA,DINMSG,DIVERS,X,Y,%DT
 S DIVERS=$P($T(V^DINIT),";",3)
 S X=$P($T(V^DINIT),";",6),%DT="" D ^%DT S DIDATE=Y
 S DINFDA(9.4,"?+1,",.01)="VA FILEMAN"
 S DINFDA(9.4,"?+1,",1)="DI"
 S DINFDA(9.4,"?+1,",2)="FM INIT"
 S DINFDA(9.4,"?+1,",13)=DIVERS
 S DINFDA(9.49,"?+2,?+1,",.01)=DIVERS
 S:DIDATE>0 DINFDA(9.49,"?+2,?+1,",1)=DIDATE
 S DINFDA(9.49,"?+2,?+1,",2)=DT
 S:$G(DUZ) DINFDA(9.49,"?+2,?+1,",3)=DUZ
 D UPDATE^DIE("","DINFDA","DINIEN","DINMSG")
 I $G(DIERR),$D(DINMSG("DIERR","E",299)) D
 . W !!,$C(7),"WARNING: There is more than one 'VA FILEMAN' entry in the Package file (#9.4)."
 . W !,"         I am unable to determine which is the correct entry to update with"
 . W !,"         current installation data."
 . W !!,"         You can delete or edit erroneous entries and run DINIT again."
 . N DIR,DTOUT,DUOUT,DIRUT,DIROUT
 . S DIR(0)="E"
 . W ! D ^DIR
 ;
 ;Put PACKAGE pointer into FM DIALOG entries, re-index file
 N DIPKG,DIREC S DIPKG=$G(DINIEN(1))
 W !!,"Re-indexing entries in the DIALOG file."
 F DIREC=0:0 S DIREC=$O(^DI(.84,DIREC)) Q:'DIREC!(DIREC>10000)  D
 . S $P(^DI(.84,DIREC,0),U,4)=DIPKG
 K DA S DIK="^DI(.84," D IXALL^DIK
 Q
 ;
 ;
PARAM ;
 N DINFDA,DINDES
 Q:$G(^XTV(8989.51,0))'?1"PARAMETER DEFINITION".E
 S DINFDA(8989.51,"?+1,",.01)="DI SCREENMAN COLORS"
 S DINFDA(8989.51,"?+1,",1.2)="30:BLACK;31:RED;32:GREEN;33:YELLOW;34:BLUE;35:MAGENTA;36:CYAN;37:WHITE"
 S DINFDA(8989.51,"?+1,",1.3)="Enter the Screen Color"
 S DINFDA(8989.51,"?+1,",6.2)="1:REQUIRED CAPTION FG;2:DATA FG;3:CLICKABLE AREA FG;4:REQUIRED CAPTION BG;5:DATA BG;6:CLICK AREA BG"
 S DINFDA(8989.51,"?+1,",6.3)="PICK ONE OF THE 6 KINDS OF COLORS"
 S DINFDA(8989.51,"?+1,",.03)=1
 S DINFDA(8989.51,"?+1,",.02)="COLORS FOR SCREENMAN PRESENTATION"
 S DINFDA(8989.51,"?+1,",.04)="FUNCTIONALITY"
 S DINFDA(8989.51,"?+1,",.05)="COLOR"
 S DINFDA(8989.51,"?+1,",20)="DINDES"
 S DINFDA(8989.513,"?+2,?+1,",.01)=1
 S DINFDA(8989.513,"?+2,?+1,",.02)=200
 S DINFDA(8989.513,"?+3,?+1,",.01)=2
 S DINFDA(8989.513,"?+3,?+1,",.02)=4.2
 F I=1.1,6.1 S DINFDA(8989.51,"?+1,",I)="S"
 S DINDES(1)="Colors for Foreground (FG) or Background (BG) of Screen"
 S DINDES(2)=""
 D UPDATE^DIE("","DINFDA")
 ;
 S DINFDA(8989.51,"?+1,",.01)="DI SCREENMAN NO MOUSE"
 S DINFDA(8989.51,"?+1,",.03)=0
 S DINFDA(8989.51,"?+1,",1.3)="Enter 'YES' to disenable the Mouse for ScreenMan"
 S DINFDA(8989.51,"?+1,",.02)="DISENABLE MOUSE WITHIN SCREENMAN"
 S DINFDA(8989.51,"?+1,",1.1)="Y"
 S DINFDA(8989.51,"?+1,",20)="DINDES"
 S DINFDA(8989.513,"?+2,?+1,",.01)=1
 S DINFDA(8989.513,"?+2,?+1,",.02)=200
 S DINFDA(8989.513,"?+3,?+1,",.01)=2
 S DINFDA(8989.513,"?+3,?+1,",.02)=4.2
 S DINDES(1)="Use this Parameter to DISENABLE use of the mouse in ScreenMan"
 S DINDES(2)="system-wide, or for an individual user."
 D UPDATE^DIE("","DINFDA")
 Q
