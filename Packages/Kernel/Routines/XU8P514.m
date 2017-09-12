XU8P514 ;ISF/RWF - Patch XU*8*514 post-init ;07/29/09  14:54
 ;;8.0;KERNEL;**514**;;Build 8
 Q
 ;
POST ;See that node 3 just has 3 values to match the DD.
 N X
 S X=$G(^XTV(8989.3,1,3))
 I $L($P(X,U,4)),"01"'[$P(X,U,4) S $P(^XTV(8989.3,1,3),U,4,6)=""
 Q
