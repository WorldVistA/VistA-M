XUINP348 ;ISF/RWF - Patch XU*8*348 POST-INIT ;12/22/2004  09:29
 ;;8.0;KERNEL;**348**;Jul 10, 1995
 W !,"Patch XU*8*348 Post install"
 Q
 ;
POST ;
 N I,X
 D F2,F3
 Q
 ;
F2 ;Search the Terminal type file
 S I=0
 F  S I=$O(^%ZIS(2,I)) Q:I'>0  S X=$P($G(^%ZIS(2,I,1)),U,3) I X>65500 D
 . S $P(^%ZIS(2,I,1),U,3)=65500
 . Q
 Q
 ;
F3 ;Search the Device file
 S I=0
 F  S I=$O(^%ZIS(1,I)) Q:I'>0  S X=$G(^%ZIS(1,I,91)) I $L(X) D
 . S ^%ZIS(1,I,91)=$P(X,U,1)_"^^"_$S($P(X,U,3)>65500:65500,1:$P(X,U,3))
 . Q
 Q
