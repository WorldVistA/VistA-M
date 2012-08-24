XUP569 ;ALB/CJM - post-install for XU*8*569 ;05/09/2011
 ;;8.0;KERNEL;**569**;Jul 10, 1995;Build 1
 ;
REBUILD ;rebuild all secondary menus
 N DUZ,XQDIC
 S DUZ=0
 F  S DUZ=$O(^VA(200,DUZ)) Q:'DUZ  D
 .S XQDIC="U"_DUZ
 .L +^XUTL("XQO",XQDIC):5
 .D SET^XQSET
 .L -^XUTL("XQO",XQDIC)
 Q
