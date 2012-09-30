XLFNENV ;SFISC/MKO-ENVIRONMENT CHECK FOR XU*8.0*134 ;10:09 AM  29 Feb 2000
 ;;8.0;KERNEL;**134**;Jul 10, 1995
ENV ;The Environment check
 N XUNAM
 Q:'$D(^DD(20))!($P($G(^DIC(20,0)),U)="NAME COMPONENTS")
 S XPDQUIT=2
 ;
 S XUNAM=$P($G(^DIC(20,0)),U) S:XUNAM="" XUNAM=$O(^DD(20,0,"NM",XUNAM))
 W !!,"This patch brings in a new NAME COMPONENTS file (#20),"
 W !,"but file #20, "_XUNAM_", already exists on this system."
 ;
 I XUNAM="EMPLOYEE" D
 . W !!,"Note that the Big Bang patch A4A7*1.01*11, released 17-Dec-1998,"
 . W !,"deletes the DD for file #20, but step 5 of that patch, ""D K^A4A7KILL"","
 . W !,"may not have been performed in this account."
 Q
