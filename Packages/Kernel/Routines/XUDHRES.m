XUDHRES ;ISCSF/RWF - Resource device utility. ;4/30/98  11:17
 ;;8.0;KERNEL;**49,69**;Dec 30, 1996
 W !,"No entry from the top.",! Q
 ;
RELALL ;Release all resource devices.  Used at startup.
 N ZISJ,ZISD0,ZISD1
 F ZISD0=0:0 S ZISD0=$O(^%ZISL(3.54,ZISD0)) Q:ZISD0'>0  D
 . F ZISD1=0:0 S ZISD1=$O(^%ZISL(3.54,ZISD0,1,ZISD1)) Q:ZISD1'>0  D
 . . D KILLRES^%ZISC(ZISD0,ZISD1)
 . . S X1=$P(^%ZISL(3.54,ZISD0,0),U),X2=$O(^%ZIS(1,"C",X1,0))
 . . S X1=$P($G(^%ZIS(1,+X2,1)),U,10) S:X1 $P(^%ZISL(3.54,ZISD0,0),U,2)=X1
 . Q
 Q
RELONE ;Option to release one
 N ZISD0,ZISD1,DIC,X,Y
 S DIC="^%ZISL(3.54,",DIC(0)="AEMQ" D ^DIC Q:$D(DUOUT)!(Y'>0)  S ZISD0=+Y
 I $O(^%ZISL(3.54,ZISD0,1,0))'>0 W !!,"No slots in use to release." Q
 S DIC=DIC_ZISD0_",1," D ^DIC Q:$D(DUOUT)!(Y'>0)  S ZISD1=+Y
 D KILLRES^%ZISC(ZISD0,ZISD1)
 Q
