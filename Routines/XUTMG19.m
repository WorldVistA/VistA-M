XUTMG19 ;SF/RWF - TaskMan Code For File 19.2 ;06/09/99  09:32
 ;;8.0;KERNEL;**20,67,118**;Jul 10, 1995
 ;
 Q
FIND ;subroutine--find scheduled task that will run this option
 ;Return XUTASK = task number, XUDTH = H3 time
 N %,OPT,X,X1,Y X ^%ZOSF("UCI") S XUTASK=0,Y=$P(Y,","),OPT=$$GET(19,$$GET(19.2,DA,.01),.01)
 S X=+$S($D(ZTMQDT):ZTMQDT,$D(^DIC(19.2,DA,0)):$$GET(19.2,DA,2),1:0) Q:'X
 S XUDTH=$$H3^%ZTM($$FMTH^XLFDT(X))
 S %=$$GET(19.2,DA,12) I %>0 D CHECK Q:XUTASK
 F  S %=$O(^%ZTSCH(XUDTH,%)) Q:%'>0  I $P($G(^%ZTSK(%,0)),"^",1,2)="ZTSK^XQ1" D CHECK Q:XUTASK
 Q
CHECK ;Check a task
 S X1=$G(^%ZTSK(%,0)) Q:$P(X1,"^",1,2)'="ZTSK^XQ1"  Q:$P(X1,"^",11)'=Y
 I $G(^%ZTSK(%,.03))'[OPT Q  ;Check for name in desc.
 S:$G(^%ZTSK(%,.3,"XQSCH"))=DA XUTASK=%
 Q
 ;
GET(FN,IEN,FE) ;
 N A,B,C
 S A=$G(^DD(FN,FE,0)),A=$P(A,"^",4)
 S B=$P(A,";"),C=$P(A,";",2)
 Q $P($G(^DIC(FN,IEN,B)),"^",C)
 ;--------------------------------------------------------------------
IT2 ;input transform for time (#2)
 N Y,% S %DT="ETRXF" D ^%DT S X=Y,%=$$NOW^XLFDT() I %+.0002>X K X
 I '$D(X),'$D(DDS) D CT^XUTMG19
 Q
 ;
CT ;IT2--show current time %=NOW
 W !,?5,"The current time is ",$E(%,9,10),":",$E(%,11,12)
 Q
 ;
S2 ;set logic for AZTM cross-reference on time (#2)
 N DV,ZTSK,ZTIO,ZTDTH,ZTDESC,ZTRTN,ZTCPU,X1
 S ZTDTH=X I 'ZTDTH G EXIT
 S ZTCPU=$$GET(19.2,DA,5) I ZTCPU']"" K ZTCPU
 S ZTRTN="ZTSK^XQ1"
 S ZTSAVE("XQSCH")=DA,X1=+^DIC(19.2,DA,0),ZTSAVE("XQY")=X1
 S ZTDESC=$P(^DIC(19,X1,0),U)_" - "_$P(^DIC(19,X1,0),U,2)
 S ZTIO=$$GET(19.2,DA,3)
 D ^%ZTLOAD S ^DIC(19.2,DA,1)=ZTSK
EXIT Q
 ;
K2 ;kill logic for AZTM cross-reference on time (#2)
 N XUTASK,XUDTH,XUTMT S ZTMQDT=X D FIND K ZTMQDT I XUTASK'>0 Q
 Q:XUTASK=$G(ZTQUEUED)
 S XUTMT=XUTASK,^DIC(19.2,DA,1)="" D ^XUTMTD
 Q
 ;
 ;--------------------------------------------------------------------
 ;
IT3 ;input transform for device (#3)
 N DIC,Y,XUTMG19
 I X[""""!($A(X)=45)!($L(X)>70) K X Q
 S DIC="^%ZIS(1,",DIC(0)="E",XUTMG19=X,X=$P(X,";") D ^DIC
 I Y=-1 K X Q
 S $P(XUTMG19,";")=$P(Y,U,2),IOP=XUTMG19,%ZIS="NQR" D ^%ZIS
 I POP K X
 E  S X=ION_";"_$S($D(IO("DOC"))#2:IO("DOC"),1:IOST_";"_IOM_";"_IOSL)
 D RESETVAR^%ZIS
 Q
 ;
S3 ;set logic for AZTIO cross-reference of device (#3)
 N XUTASK,XUDTH D FIND I XUTASK'>0 Q
 S $P(^%ZTSK(XUTASK,.2),U)=X
 Q
 ;
K3 ;kill logic for AZTIO cross-reference of device (#3)
 N XUTASK,XUDTH D FIND I XUTASK'>0 Q
 S $P(^%ZTSK(XUTASK,.2),U)=""
 Q
 ;
 ;--------------------------------------------------------------------
 ;
IT6 ;input transform for re-sch freq
 I $L(X)>15!($L(X)<2) K X Q
 I X?1.3N1"H" Q
 I X?1.4N1"S" Q
 I X?1.3N1"D" Q
 I X?1.2N1"M" Q
 I X?1.2N1"M(".E1")" Q
 I "MTWRFSUDE"[$E(X),"@,"[$E(X,2) Q
 K X
 Q
 ;
 ;-------------------------------------------------------------------
 ;
IT5 ;input transform for volume (#5)
 N X1,X2 S X1=$P(X,":"),X2=$P(X,":",2)
 I X[""""!($A(X)=45) K X Q
 I $L(X)>21!($L(X)<2) K X Q
 I '((X?1.8UN)!(X?1.8UN.1":".12UN)) K X Q
 I X'[":",'$D(^%ZIS(14.5,"B",X)) K X Q
 I X[":",'$D(^%ZIS(14.7,"B",X)) K X Q
 Q
 ;
S5 ;set logic for AZTVOL cross-reference of volume
 N XUCPU,XUTASK,XUDTH D FIND I XUTASK>0 D
 . S $P(^%ZTSK(XUTASK,0),U,14)=X
 N X S X=$$GET(19.2,DA,9) D S9 ;Trigger the startup X-ref
 Q
 ;
K5 ;kill logic for AZTVOL cross-reference on volume
 N XUCPU,XUTASK,XUDTH D FIND I XUTASK>0 D
 . S $P(^%ZTSK(XUTASK,0),U,14)=""
 D K9X(X) ;Trigger the startup X-ref
 Q
 ;
 ;--------------------------------------------------------------------
 ;
IT9 ;input transform for special queueing (#9)
 N Y S Y=$P(^DIC(19,+^DIC(19.2,DA,0),0),U,4)
 I Y="A"!(Y="R") Q
 K X W $C(7),"  ONLY FOR 'ROUTINE' OR 'ACTION' TYPES OF OPTIONS"
 Q
 ;
S9 ;set logic for ASTARTUP cross-reference on special queueing
 Q:X'["S"  ;Only for startup type
 N Y,Y1,XUCPU,XIO S XUCPU=$$GET(19.2,DA,5),Y1=$$GET(19.2,DA,.01)
 X ^%ZOSF("UCI") I XUCPU]"" S $P(Y,",",2)=XUCPU
 S ^%ZTSCH("STARTUP",Y,DA_"Q"_Y1)=$H_U_$$GET(19.2,DA,3)_U
 Q
 ;
K9 ;kill logic for ASTARTUP cross-reference on special queueing
 N Y,Y1,XUCPU S XUCPU=$$GET(19.2,DA,5),Y1=$$GET(19.2,DA,.01)
K9A X ^%ZOSF("UCI") I XUCPU]"" S $P(Y,",",2)=XUCPU
 K ^%ZTSCH("STARTUP",Y,Y1),^%ZTSCH("STARTUP",Y,DA_"Q"_Y1)
 Q
 ;
K9X(XUCPU,Y1) ;Kill logic called from other X-ref
 N Y S:'$D(XUCPU) XUCPU=$$GET(19.2,DA,5) S:'$D(Y1) Y1=$$GET(19.2,DA,.01)
 G K9A
 ;
XREF ;Reindex the STARTUP nodes
 N DIK,DA,X
 F DA=0:0 S DA=$O(^DIC(19.2,DA)) Q:DA'>0  S DIK="^DIC(19.2," D IX^DIK
 Q
