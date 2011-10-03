XUS9 ;SF/RWF - Find a user ;01/21/2003  08:45
 ;;8.0;KERNEL;**258**;Jul 10, 1995
 N %,%H,DA,DIC,I,Y,X,XU1,XU2,XU3,XU4,XU5,XU6,XUSER,XUJOB,XUVOL,XUCI,XUDT
1 X ^%ZOSF("UCI") S XU1=$P(Y,",",1),XU2=^%ZOSF("VOL"),X="T-1",%DT="" D ^%DT S XU4=Y
A S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Find User: " D ^DIC G EXIT:Y'>0 S DA=+Y,XUSER=$P(Y,"^",2)
 W !!,"User: ",XUSER,$S($D(^XUSEC(0,"CUR",DA))=10:" is found on;",1:" isn't currently on the system")
 F XU5=0:0 S XU5=$O(^XUSEC(0,"CUR",DA,XU5)) Q:XU5'>0  D B
 W !,"DONE" G A
EXIT ;K %,%H,DA,DIC,I,Y,X
EX2 ;K XU1,XU2,XU3,XU4,XU5,XU6,XUSER,XUJOB,XUVOL,XUCI,XUDT
 Q
B ;Find
 G:XU5<XU4 REMOVE ;Sign-on more than 24 hours old.
 S XU3=$S($D(^XUSEC(0,XU5,0)):^(0),1:"") G REMOVE:'$L(XU3),REMOVE:$P(XU3,"^",4)
 S XUCI=$P(XU3,"^",8),XUVOL=$P(XU3,"^",5),Y=XU5,XUJOB=$P(XU3,"^",3),XU6=XUJOB D DD^%DT S XUDT=Y
 I XUJOB>2048 S X1=16,X=XUJOB D CNV^XTBASE S XU6=XUJOB_" ("_Y_")"
 W !,"Job: ",XU6," on ",XUCI,",",XUVOL,$S($P(XU3,"^",10)]"":":"_$P(XU3,"^",10),1:"")," from ",XUDT
 W !,"Device: ",$P(XU3,"^",2) W:$P(XU3,"^",9)]"" "  (",$P(XU3,"^",9),")"
 Q:XUCI'=XU1!(XUVOL'=XU2)  G:$S($D(^XUTL("XQ",XUJOB,"DUZ")):^("DUZ"),1:0)'=DA REMOVE
 W !?3,"Menu path:"
 I $D(^XUTL("XQ",XUJOB,"T")) F I=1:1:^XUTL("XQ",XUJOB,"T") Q:'$D(^XUTL("XQ",XUJOB,I))  S Y=^(I) W !,?I*3+2,$P(Y,"^",3)
 W !
 Q
REMOVE ;Questionable entry removed
 ;If we have a sign-off time just remove the "CUR" X-ref.
 I $P($G(^XUSEC(0,XU5,0)),"^",4) K ^XUSEC(0,"CUR",DA,XU5) Q
 N FDA
 S FDA(3.081,XU5_",",3)=$$NOW^XLFDT,FDA(3.081,XU5_",",16)=1
 D UPDATE^DIE("","FDA")
 Q
INQ Q:'$D(D0)  N DA X ^%ZOSF("UCI") S XU1=$P(Y,",",1),XU2=^%ZOSF("VOL"),DA=D0,XU4=DT-1
 F XU5=0:0 S XU5=$O(^XUSEC(0,"CUR",DA,XU5)) Q:XU5'>0  D B
 G EX2
