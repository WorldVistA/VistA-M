%ZTMS0 ;SEA/RDS-TaskMan: Submanager, Part 2 (Trap Functions) ;09/25/08  16:07
 ;;8.0;KERNEL;**24,118,275,446**;JUL 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ERROR2 ;ERROR--trap
 L +^%ZTSCH("ER"):99 H 1 S ZTH=$H
 S ^%ZTSCH("ER",+ZTH,$P(ZTH,",",2))=$$EC^%ZOSV
 S ^%ZTSCH("ER",+ZTH,$P(ZTH,",",2),1)="Caused by the submanager while trapping an error."
 L
 X "HALT  " ;HALT JOB
 ;
STATUS ;ERROR--update task's status in Task File, Call w/ ^%ZTSK locked
 S ZTE=$E(%ZTME,1,70)
 S ZTE=$TR(ZTE,"^","~")
 S $P(^%ZTSK(%ZTMETSK,.1),"^",1,3)=$S(ZTQUEUED>.5:"C^",1:"L^")_$H_"^"_ZTE
 S $P(^%ZTSK(%ZTMETSK,.12),"^",2,9)=%ZTMEH_"^"_%ZTME
 S ^%ZTSK(%ZTMETSK,.12,%ZTMEH)=%ZTME
 Q
 ;
DEVBAD ;ERROR--dequeue all entries for a bad device
 N ZT,ZT1,ZT2,ZT3,ZT4
 Q:'$$DEVLK^%ZTMS1(1,ZTDEVOK)
 L +^%ZTSCH("IO"):5 G DBX:'$T  S $P(^%ZTSCH("IO"),"^")=$$H3^%ZTM($H)
 S ZT2=ZTDEVOK,ZT3=""
 F  S ZT3=$O(^%ZTSCH("IO",ZT2,ZT3)),ZT4="" Q:ZT3=""  F  S ZT4=$O(^%ZTSCH("IO",ZT2,ZT3,ZT4)) Q:ZT4=""  L +^%ZTSK(ZT4):99 D DQ L -^%ZTSK(ZT4)
 K ^%ZTSCH("IO",ZTDEVOK)
 I $O(^%ZTSCH("IO",""))="" K ^%ZTSCH("IO")
 L -^%ZTSCH("IO")
DBX D DEVLK^%ZTMS1(-1,ZTDEVOK)
 Q
 ;
DQ ;DEVBAD--remove a task from the waiting list for a bad device
 K ^%ZTSCH("IO",ZT2,ZT3,ZT4)
 S $P(^%ZTSK(ZT4,.1),"^",1,3)="B^"_$H_"^BAD IO DEVICE "_ZT2
 K ^%ZTSK(ZT4,.26,ZT2)
 I $O(^%ZTSK(ZT4,.26,""))]"" Q
 K ^%ZTSK(ZT4,.26)
 Q
 ;
ERCLOZ ;ERROR--close device after error
 ;N %ZT1 S %ZT1=(IO=$G(^XUTL("XQ",$J,"IO")))
 I $L($G(IO)) S IO("C")="" D ^%ZISC ;Close the current device
 ;I $G(^XUTL("XQ",$J,"IO"))'=$I D ERC2
 I $L(IO),$D(IO(1,IO)) S IO("C")="" D ^%ZISC ;Close a second device open
 Q
 ;
ERC2 ;Close original Device
 N POP
 S POP=1 D RESETVAR^%ZIS Q:POP
 ;S IOS=$P(%ZTTV,"^",2),(IO,IO(0))=$P(%ZTTV,"^",5),IOT=$P(%ZTTV,"^",6),IOF=$P(%ZTTV,"^",11),IOST=$P(%ZTTV,"^",12),IO("C")=""
 I $D(IO(1,IO)) S IO("C")="" D ^%ZISC
 Q
 ;
XREF ;ERROR--cross-reference TaskMan Error file entry by context of error
 S ZTERROX=$S('%ZTMETSK:"an unknown task.",1:"Task # "_%ZTMETSK_".")
 S ZTQUEUED=$G(ZTQUEUED)
 I ZTQUEUED=0 S ZTERROX1="Caused by the submanager." Q
 I ZTQUEUED=.5 S ZTERROX1="Caused by the submanager while preparing "_ZTERROX Q
 I ZTQUEUED=.6 S ZTERROX1="Caused by submanager after "_ZTERROX Q
 S ZTERROX1="Caused by "_ZTERROX
 Q
 ;
