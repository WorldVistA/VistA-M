IBQLPOST ;LEB/MRY - CREATE IBQ ROLLUP MAILGROUP POST INT ;5-JUL-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
% N X,Y,I,J,DA,DR,DIC,DIE,DIK,IB,DIFROM,DLAYGO
 D DT^DICRW
 D INDEX,MAILGRP
 W !,"<<< Post init completed!"
 G END
 ;
INDEX ; -- Index field #1.17 ACUTE CARE DISCHARGE DATE of File 356.1.
 W !!,"Indexing field #1.17 ACUTE CARE DISCHARGE DATE of File #356.1."
 W !,"working...."
 S DIK="^IBT(356.1,",DIK(1)="1.17" D ENALL^DIK
 W !,"<<< Re-indexing complete!"
 Q
 ;
MAILGRP ; -- Stuff in new mail group
 W !!,"Creating new Mailgroup IBQ ROLLUP"
 W !!,*7,"<<<  Please add members to IBQ ROLLUP after install!  >>>"
 N A,B,C,D,E,F
 S A="IBQ ROLLUP",B=0,C=.5,D=0,G=1
 I $D(^XMB(3.8,"B",A)) G END
 S E(DUZ)=""
 S F(1)="This mail group will automatically alert UR persons that entries"
 S F(2)="are ready for/or received transmition."
 S X="XMBGRP" X ^%ZOSF("TEST") S IBT=$T
 W !!,"<<<  Adding mail group "_A,!
 I IBT S X=$$MG^XMBGRP(A,B,C,D,.E,.F,G)
 I 'IBT D
 .; -- environment pre-init check for Mailman 7.1 should not allow the
 .;    following lines to display.
 .W !,"<<<   Earlier version then Mailman 7.1 on your system!   >>>"
 .W !,"<<< create a mailgroup named IBQ ROLLUP and add members! >>>"
 Q
 ;
END K DLAYGO
 Q
