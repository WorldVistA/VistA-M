%ZTMS4 ;SEA/RDS-TaskMan: Submanager, Part 6 (Setup, Cleanup) ;10 Feb 2003 3:01 pm
 ;;8.0;KERNEL;**136,275,425**;JUL 10, 1995;Build 18
 ;
RESTORE ;RUN--restore saved variables
 ;prepare for restore, Call w/ task locked.
 N %ZTTV,DT,IO,IOBS,IOHG,IOM,ION,IOPAR,IOS,IOSL,IOST,IOT,IOUPAR,IOXY,POP,U,XY,ZTDTH,ZTIO,ZTQUEUED,ZTRTN
 ;
 ;restore from old node
 ;K ^%ZTSK(ZTSK,0,"ZTSK"),^("ZT3")
 ;S ZT3=""
 ;F ZT=0:0 S ZT3=$O(^%ZTSK(ZTSK,0,ZT3)) Q:ZT3=""  I +ZT3'=ZT3 S:$D(^(ZT3))#2 @ZT3=^(ZT3) I $D(^(ZT3))>9 S %X="^%ZTSK(ZTSK,0,ZT3,",%Y=ZT3_$E("(",ZT3'["(") D %XY^%RCR
 ;
A ;restore from new node
 K ^%ZTSK(ZTSK,.3,"ZTSK"),^("ZT3")
 S ZT3=""
 ;F  S ZT3=$O(^%ZTSK(ZTSK,.3,ZT3)) Q:ZT3=""  I +ZT3'=ZT3 S:$D(^(ZT3))#2 @ZT3=^(ZT3) I $D(^(ZT3))>9 S %X="^%ZTSK(ZTSK,.3,ZT3,",%Y=ZT3_$E("(",ZT3'["(") D %XY^%RCR
 F  S ZT3=$O(^%ZTSK(ZTSK,.3,ZT3)) Q:ZT3=""  D:+ZT3'=ZT3
 . I ZT3'["(" M:$D(^(ZT3)) @ZT3=^(ZT3) Q
 . S ZT4=$L(ZT3)
 . I $E(ZT3,ZT4)="(" M @($E(ZT3,1,ZT4-1))=^(ZT3) Q
 . M @($E(ZT3,1,ZT4-1)_")")=^(ZT3)
 . Q
 ;
 ;cleanup
 K %A,%B,%C,%X,%Y,%Z,ZT,ZT3
 Q
 ;
POST ;RUN--post-execution commands, Call w/ task locked.
 I $G(ZTSTOP)=1 D TSKSTAT^%ZTMS3("D","Job asked to stop") Q
 S X=^%ZTSK(ZTSK,.1) ;Get keep till.
 I $S($P(X,U,8)>$H:0,$D(^%ZTSK(ZTSK,0))[0:1,$G(ZTREQ)="@":1,1:0) D KILL^%ZTM4 Q
 N ZTUCI,ZTCPU,ZTNODE,ZTPAIR,ZTYPE,ZTRTN,ZTDESC,ZTIO,ZTDTH ;Protect current values.
 I $D(ZTREQ)#2 S ZTDTH=$P(ZTREQ,U),ZTIO=$P(ZTREQ,U,2),ZTDESC=$P(ZTREQ,U,3),ZTRTN=$P(ZTREQ,U,4,5),ZTIO(1)=$P(ZTREQ,U,6) S:$P(ZTRTN,U,2)="" ZTRTN=$P(ZTRTN,U) D REQ^%ZTLOAD Q
 Q
 ;
 ;
LOGIN ;RUN--enter task in signon log
 I '$L($T(SLOG^XUS1)) Q  ;No Sign-on Log
 N XL1
 S XL1=$$SLOG^XUS1($P(%ZTTV,U,7),1,IOS,$P($P(%ZTTV,U),","),$P(%ZTTV,U,8))
 S $P(%ZTTV,U,10)=XL1
 Q
 ;
LOGOUT ;RUN--set signoff time for task in signon log
 N ZT
 S ZT=$P(%ZTTV,"^",10) Q:ZT'>0  D LOUT^XUSCLEAN(ZT)
 Q
 ;
ALERT ;Send a alert for rejected tasks.
 I $G(DUZ)>.9,$D(^DD(8992,.01,0)) D
 . D SETUP^XQALERT
 ;S ZTREQ="@"
 Q
