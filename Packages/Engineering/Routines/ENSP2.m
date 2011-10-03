ENSP2 ;(WCIOFO)/WDS@CHARLESTON,SAB-DISPLAY ROOM DATA ;7/8/1999
 ;;7.0;ENGINEERING;**62**;Aug 17, 1993
 ;
HDR W @IOF,!,?15,"ENGINEERING SPACE INVENTORY REPORT MENU",!!
 Q
ENT ;DISPLAY ROOM/SPACE DATA
 S DIC="^ENG(""SP"",",DIE=DIC,DIC(0)="AEQM",J=0
 D ^DIC S DA=+Y G:DA<1 EXIT W @IOF
START F X=1:1:28 S EN(X)=""
 S (EN(18,1),EN(18,2),EN(18,3))=""
 S EN("SYN")=""
 K EN("OKEY")
 ;
FDAT I $D(^ENG("SP",DA,0))>0 S EN(1)=$P(^(0),"^",1),EN(2)=$P(^(0),"^",2),EN(3)=$P(^(0),"^",3),EN(4)=$P(^(0),"^",4),EN(5)=$P(^(0),"^",5),EN(6)=$P(^(0),"^",6),EN(7)=$P(^(0),"^",7),EN(8)=$P(^(0),"^",8),EN(9)=$P(^(0),"^",9) D SSER D:EN(5)'="" SKEY
FDAT1 I $D(^ENG("SP",DA,0))>0 S EN(15)=$P(^(0),"^",11),EN(16)=$P(^(0),"^",12),EN(17)=$P(^(0),"^",13),EN(22)=$P(^(0),"^",16),EN(25)=$P(^(0),"^",18)
FDAT2 I $D(^ENG("SP",DA,2))>0 S EN(10)=$P(^(2),"^",2),EN(11)=$P(^(2),"^",3),EN(12)=$P(^(2),"^",4),EN(13)=$P(^(2),"^",5),EN(14)=$P(^(2),"^",6),EN(21)=$P(^(2),"^",8),EN(23)=$P(^(2),"^",9),EN(24)=$P(^(2),"^",10)
FDAT21 I $D(^ENG("SP",DA,2))>0 S EN(26)=$P(^(2),"^",13)
MLITE I $D(^ENG("SP",DA,6,0)) S ENXT=0 D MLITE1
 ;
MUTL I $D(^ENG("SP",DA,1,0)) S J=27,ENTNX=0 D MUTIL
 ;
SYN I $D(^ENG("SP",DA,8,0)) D
 . F I=0:0 S I=$O(^ENG("SP",DA,8,I)) Q:I'>0  D
 .. S:EN("SYN")]"" EN("SYN")=EN("SYN")_"; "
 .. S EN("SYN")=EN("SYN")_$P(^ENG("SP",DA,8,I,0),U)
OKEY ;get other keys (I = ien of other key, ENJ = last output line # used)
 ; loop thru other keys multiple
 S (I,ENJ)=0 F  S I=$O(^ENG("SP",DA,5,I)) Q:'I  D
 . N ENX
 . S ENX=$P($G(^ENG("SP",DA,5,I,0)),U) Q:ENX=""
 . ; if no values stored yet then initialize first line
 . I ENJ=0 S ENJ=1,EN("OKEY",ENJ)=""
 . ; if value won't fit on this line then add another line
 . I $L(EN("OKEY",ENJ))+$L(ENX)>60 D
 . . S EN("OKEY",ENJ)=EN("OKEY",ENJ)_";"
 . . S ENJ=ENJ+1,EN("OKEY",ENJ)=""
 . ; add value to line
 . S EN("OKEY",ENJ)=EN("OKEY",ENJ)_$S(EN("OKEY",ENJ)]"":"; ",1:"")_ENX
 ;
 G ^ENSP3
SSER I EN(4)'="" S:$D(^DIC(49,EN(4),0))>0 EN(4)=$P(^DIC(49,EN(4),0),"^",1)
 Q
SKEY I $D(^ENG("LK",EN(5),0))>0 S EN(5)=$P(^ENG("LK",EN(5),0),"^",1)
 Q
 ;
MUTIL S ENTNX=$O(^ENG("SP",DA,1,ENTNX)) Q:ENTNX=""  S ENTEMP=$P(^ENG("SP",DA,1,ENTNX,0),"^",1),EN(J)=^ENG(6928.2,ENTEMP,0),J=J+1 G MUTIL
MLITE1 F J=18:1:20 S ENXT=$O(^ENG("SP",DA,6,ENXT)) Q:ENXT=""  F ENML=1:1:3 S EN(J,ENML)=$P(^ENG("SP",DA,6,ENXT,0),"^",ENML)
 Q
EXIT K DIC,DIE,ENML,ENTEMP,ENXT,ENTNX,I,J,K,O,S,X,Y Q
 ;ENSP2
