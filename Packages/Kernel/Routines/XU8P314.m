XU8P314 ;BP-OAK/BDT - CLEAN UP BAD "CUR" X-REF; [8/19/03 9:35am]
 ;;8.0;KERNEL;**314**; Jul 10, 1995
 ;
 N I,J S I=0
 F  S I=$O(^XUSEC(0,"CUR",I)) Q:I'>0  D
 . S J=0 F  S J=$O(^XUSEC(0,"CUR",I,J)) Q:'J>0  D
 . . K:'$D(^XUSEC(0,J,0)) ^XUSEC(0,"CUR",I,J)
 ;
 Q
