XUINTSK1 ;ISCSF/RWF - TASKMAN POST INIT ;01/03/95  09:29
 ;;8.0;KERNEL;;Jul 10, 1995
SCH ;Move and build new schedule
 N DIFROM
 F X19=0:0 S X19=$O(^DIC(19,X19)) Q:X19'>0  D
 . S XUTASK=0,XUNEW=0
 . I $G(^DIC(19,X19,200)) D SCH1
 . I $G(^DIC(19,X19,1916))["S" D SCH2
 . Q
 Q
SCH1 ;Move regular options
 N DUZ S DUZ=0,DUZ(0)="@"
 S DA=X19,XV19=^DIC(19,DA,200),X=+XV19 D K200 ;KILL OLD
 S:'$D(^DIC(19,X19,200.9))&($P(XV19,U,3)]"") ^DIC(19,X19,200.9)="y"
 K DD,DO
 S X=X19,DIC="^DIC(19.2,",DIC(0)="L",DLAYGO=19.2 D FILE^DICN
 S (DA,XUNEW)=+Y,X=X19_U_$P(XV19,U,1,2)_U_U_$P(XV19,U,4)_U_$P(XV19,U,3)
 S ^DIC(19.2,DA,0)=X,DIK=DIC,DIK(1)=2 I (+XV19)'<DT D EN1^DIK
 D MES^XPDUTL("Option: "_$P(^DIC(19,X19,0),U)_" move to new file.")
SCH1X K ^DIC(19,X19,200)
 Q
SCH2 ;Move Special queueing
 S DA=X19,XV19=$G(^DIC(19,DA,200)),XV1916=^DIC(19,DA,1916)
 S:'$D(^DIC(19,X19,200.9)) ^DIC(19,X19,200.9)="s"
 D K1916 K DD,DO,Y S Y=XUNEW
 I 'Y S X=X19,DIC="^DIC(19.2,",DIC(0)="L",DLAYGO=19.2 D FILE^DICN
 S DA=+Y,X=^DIC(19.2,DA,0),$P(X,U,5)=$P(XV19,U,4),$P(X,U,9)=$P(XV1916,U)
 S ^DIC(19.2,DA,0)=X,DIK=DIC,DIK(1)=9 D EN1^DIK
 D MES^XPDUTL("Option: "_$P(^DIC(19,X19,0),U)_" startup moved.")
 K ^DIC(19,X19,200),^DIC(19,X19,1916)
 Q
FIND ;subroutine--find scheduled task that will run this option
 N DV,X,X1,Y X ^%ZOSF("UCI") S %=0,XUTASK=0,Y=$P(Y,","),OPNM=$$GET(19,DA,.01)
 S X=+$S($D(ZTMQDT):ZTMQDT,$D(^DIC(19,DA,200)):$$GET(19,DA,200),1:0) I 'X Q
 D H^%DTC S X=%H_","_%T,%=0
 F  S %=$O(^%ZTSCH(X,%)) Q:%'>0  S X1=$G(^%ZTSK(%,0)) I $P(X1,"^",1,2)="ZTSK^XQ1" D  Q:XUTASK
 . Q:$P(X1,"^",11)'=Y  Q:$P(X1,"^",13)'[OPNM
 . S:$G(^%ZTSK(%,.3,"XQY"))=DA XUTASK=% Q
 Q
 ;
GET(FN,IEN,FE) ;
 N A,B,C S A=$G(^DD(19,FE,0)),A=$P(A,"^",4)
 S B=$P(A,";"),C=$P(A,";",2)
 Q $P($G(^DIC(19,IEN,B)),"^",C)
 ;--------------------------------------------------------------------
 ;
K200 ;kill logic for AZTM cross-reference on field 200
 S ZTMQDT=X D FIND K ZTMQDT I XUTASK'>0 Q
 S DUZ=+$P($G(^%ZTSK(XUTASK,0)),"^",3) ;Set DUZ to the old owner
 K ^%ZTSK(XUTASK),^%ZTSCH(X,XUTASK)
 Q
 ;
K1916 ;kill logic for ASTARTUP cross-reference of field 1916
 S ZTVOL=$$GET(19,DA,203)
 X ^%ZOSF("UCI") I ZTVOL]"" S $P(Y,",",2)=ZTVOL
 K ^%ZTSCH("STARTUP",Y,DA),ZTVOL
 Q
 ;
