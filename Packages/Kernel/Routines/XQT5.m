XQT5 ;SEA/MJM - Menu Template Utilities ;11/17/94  08:53
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
NO1 ;Check 1st menu to see if the tree is still good
 S XQPM=^XUTL("XQ",$J,"XQM"),XQMA=$P(^VA(200,DUZ,19.8,XQN,1,1,0),",",2),XQSIB=+$P(^(0),U,2),XQCO=$O(^DIC(19,"B","XUCOMMAND",0)),XQNO1=1
 I XQMA["U" N XQDIC S XQDIC="U"_DUZ,XQNO1=0 D SETU I '$D(^XUTL("XQO",XQMA,"^",XQSIB)) S XQY=-1
 I XQNO1,XQMA=XQCO N XQDIC S XQDIC=XQCO,XQNO1=0 D SET I '$D(^XUTL("XQO",XQMA,"^",XQSIB)) S XQY=-1
 I XQNO1 S:XQPM'=XQMA XQY=-1 N XQDIC S XQDIC=XQPM D SET I '$D(^XUTL("XQO",XQPM,"^",XQSIB)) S XQY=-1
 I XQMA=XQPM N XQDIC S XQDIC=XQPM D SET
 I XQY=-1 W !!,*7,"==> Your menu structure has changed.  Sorry,",!?4,"you will have to recreate this template." K ^XUTL("XQT",$J,XQUR)
 Q
 ;
SET ;Build the ^XUTL("XQO",+XQDIC [ or "U"_DUZ]) nodes if need be
 L +^XUTL("XQO",XQDIC):5 D:$S('$D(^XUTL("XQO",XQDIC,0)):1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET L -^XUTL("XQO",XQDIC)
 Q
 ;
SETU ;Build the ^XUTL("XQO","U"_DUZ) nodes if need be
 D:$S('$D(^XUTL("XQO","U"_DUZ)):1,'$D(^VA(200,DUZ,203.1)):1,1:^VA(200,DUZ,203.1)'=$P(^XUTL("XQO","U"_DUZ,0),U,2)) ^XQSET
 Q
