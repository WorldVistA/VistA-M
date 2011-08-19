XPARDDAC ;SLC/KCM - AC xref for Parameters (8989.5) ;5/19/95  8:36
 ;;7.3;TOOLKIT;**26**;Apr 25, 1995
 ;
 ; The AC cross-reference has the following format:
 ;
 ; ^XTV(8989.5,"AC",PARAMETER,ENTITY,INSTANCE)=VALUE
 ;
 ; PARAMETER is a pointer to PARAMETER DEFINITION file
 ; ENTITY is in variable pointer format
 ; INSTANCE is in the internal format defined for the specific parameter
 ; VALUE is in the internal format defined for the specific parameter
 ;
S01 ; set the AC cross-reference for field .01 (ENTITY)
 N X0
 S X0=$G(^XTV(8989.5,DA,0))
 I $L($P(X0,"^",2)),$L($P(X0,"^",3)) D
 . S ^XTV(8989.5,"AC",$P(X0,"^",2),X,$P(X0,"^",3))=$G(^XTV(8989.5,DA,1))
 . S ^XTV(8989.5,"AC",$P(X0,"^",2),X,$P(X0,"^",3),DA)=""
 Q
K01 ; kill the AC cross-reference for field .01 (ENTITY)
 N X0
 S X0=$G(^XTV(8989.5,DA,0))
 I $L($P(X0,"^",2)),$L($P(X0,"^",3)) D
 . K ^XTV(8989.5,"AC",$P(X0,"^",2),X,$P(X0,"^",3))
 . K ^XTV(8989.5,"AC",$P(X0,"^",2),X,$P(X0,"^",3),DA)
 Q
S02 ; set the AC cross-reference for field .02 (PARAMETER)
 N X0
 S X0=$G(^XTV(8989.5,DA,0))
 I $L($P(X0,"^",1)),$L($P(X0,"^",3)) D
 . S ^XTV(8989.5,"AC",X,$P(X0,"^",1),$P(X0,"^",3))=$G(^XTV(8989.5,DA,1))
 . S ^XTV(8989.5,"AC",X,$P(X0,"^",1),$P(X0,"^",3),DA)=""
 Q
K02 ; kill the AC cross-reference for field .02 (PARAMETER)
 N X0
 S X0=$G(^XTV(8989.5,DA,0))
 I $L($P(X0,"^",1)),$L($P(X0,"^",3)) D
 . K ^XTV(8989.5,"AC",X,$P(X0,"^",1),$P(X0,"^",3))
 . K ^XTV(8989.5,"AC",X,$P(X0,"^",1),$P(X0,"^",3),DA)
 Q
S03 ; set the AC cross-reference for field .03 (INSTANCE)
 N X0
 S X0=$G(^XTV(8989.5,DA,0))
 I $L($P(X0,"^",1)),$L($P(X0,"^",2)) D
 . S ^XTV(8989.5,"AC",$P(X0,"^",2),$P(X0,"^",1),X)=$G(^XTV(8989.5,DA,1))
 . S ^XTV(8989.5,"AC",$P(X0,"^",2),$P(X0,"^",1),X,DA)=""
 Q
K03 ; kill the AC cross-reference for field .03 (INSTANCE)
 N X0
 S X0=$G(^XTV(8989.5,DA,0))
 I $L($P(X0,"^",1)),$L($P(X0,"^",2)) D
 . K ^XTV(8989.5,"AC",$P(X0,"^",2),$P(X0,"^",1),X)
 . K ^XTV(8989.5,"AC",$P(X0,"^",2),$P(X0,"^",1),X,DA)
 Q
S1 ; set the AC cross-reference for field 1 (VALUE)
 N X0
 S X0=$G(^XTV(8989.5,DA,0))
 I $L($P(X0,"^",1)),$L($P(X0,"^",2)),$L($P(X0,"^",3)) D
 . S ^XTV(8989.5,"AC",$P(X0,"^",2),$P(X0,"^",1),$P(X0,"^",3))=X
 . S ^XTV(8989.5,"AC",$P(X0,"^",2),$P(X0,"^",1),$P(X0,"^",3),DA)=""
 Q
K1 ; null the AC cross-reference value for field 1 (VALUE)
 N X0
 S X0=$G(^XTV(8989.5,DA,0))
 I $L($P(X0,"^",1)),$L($P(X0,"^",2)),$L($P(X0,"^",3)) D
 . I $D(^XTV(8989.5,"AC",$P(X0,"^",2),$P(X0,"^",1),$P(X0,"^",3))) D
 . . S ^XTV(8989.5,"AC",$P(X0,"^",2),$P(X0,"^",1),$P(X0,"^",3))=""
 Q
