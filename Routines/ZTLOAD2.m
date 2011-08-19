%ZTLOAD2 ;SEA/RDS-TaskMan:  Queue, Part 2 ;12/10/08  07:23
 ;;8.0;KERNEL;**1,67,118,275,339,446**;Jul 10, 1995;Build 35
 ;
REJECT(MSG) ;GET--reject bad task
 I '$D(ZTQUEUED) W !,"QUEUE INFORMATION MISSING - NOT QUEUED",!,MSG
 G EXIT
 ;
BADDEV(MSG) ;GET--Reject task because of device issue.
 I '$D(ZTQUEUED) W !,"Queueing not allowed to device -- NOT QUEUED",!,MSG
EXIT ;Report back to app.
 S %ZTLOAD("ERROR")=MSG
 Q
 ;
RESTRCT ;GET--flag tasks with output restricted from certain times; check.
 I $D(ZTQUEUED) Q
 S ZTNOGO=0
 I ZTDTH="@" Q
 I ZTDTH'?1.5N1","1.5N Q
 S X=$$HTFM^%ZTLOAD7(ZTDTH) D ^XQ92 I X="" S ZTDTH="" W !,"Sorry--that time is restricted!",!,$C(7)
 Q
 ;
ASK ;GET--ask for start time
 N %DT,Y
 I $D(ZTQUEUED) D:ZTDTH]""  Q
 . S %DT="FRS",X=ZTDTH D ^%DT
 . S ZTDTH=$$FMTH^%ZTLOAD7(+Y) I Y'>0 S ZTDTH=""
 . Q
 S ZTDTH="",%DT="AERSX",%DT("A")="Requested Start Time: ",%DT("B")="NOW",%DT(0)="NOW"
 I $D(ZTNOGO) D  I X="" Q
 . S Y=+XQY D NEXT^XQ92 I X="" W !,"Output is never allowed from this option!",$C(7),$C(7) Q
 . S %DT("B")=$$FMTE^%ZTLOAD7(X),%DT="AERSX"
 . Q
 I $D(ZTNOGO),'$D(XQNOGO) W !,"Output from this option is restricted during certain times."
 F ZT=0:0 D ^%DT Q:(Y<0)!'$D(ZTNOGO)  S ZT=Y,X=Y D ^XQ92 S Y=ZT Q:X]""  W !!,"That is a restricted time!",!,$C(7)
 S:Y>0 ZTDTH=$$FMTH^%ZTLOAD7(+Y)
 K %DT,%T,X5,ZT
 Q
 ;
OPTION ;GET--get option data
 S ZTA4=$G(ZTSAVE("XQY")) I 'ZTA4 S ZTA4=$G(XQY) I 'ZTA4 S ZTA4=""
 S ZTA1="O" I 'ZTA4 S ZTA1="" Q
 S ZTA5=$P($G(^DIC(19,ZTA4,0)),U)
 Q
 ;
ZTKIL ;GET--convert forget time
 S ZTKIL=$S(ZTKIL?5N:ZTKIL,ZTKIL?5N1","1.5N:ZTKIL,ZTKIL?7N.".".N:$$FMTH^%ZTLOAD7(ZTKIL),1:"")
 Q
 ;
SPOOL ;DEVICE--for predefined ZTIO spool device, pick up IO("DOC") if missing
 I $G(IO("DOC"))="" Q
 I ZTIO[IO("DOC") Q
 I $P(ZTIO,";",2)?.N D
 .S ZTIO=$P(ZTIO,";")_";"_IO("DOC")_";"_$P(ZTIO,";",2,999)
 E  I $P(ZTIO,";",2)?1.2A1"-"1.ANP,$P(ZTIO,";",3)?.N D
 .S ZTIO=$P(ZTIO,";",1,2)_";"_IO("DOC")_";"_$P(ZTIO,";",3,999)
 Q
 ;
ASKSTOP ;e.f. Called from ASKSTOP^%ZTLOAD
 ;Ask a task to stop. Unschedule if not started.
 N % S ZTSK=+$G(ZTSK) I ZTSK<1 Q "0^BAD TASK NUMBER"
 L +^%ZTSK(ZTSK):10 I '$T Q "0^Busy"
 S %=$$AKS
 L -^%ZTSK(ZTSK)
 Q %
 ;
AKS() ;Locked before called
 N ZT1,ZT2,ZTDTH,%ZTIO
 S ZTSK(0)=$G(^%ZTSK(ZTSK,0)),ZTSK(.1)=$G(^(.1))
 I ZTSK(0)="" Q "1^Task missing"
 S $P(^%ZTSK(ZTSK,.1),U,10)=$S($D(ZTNAME)#2:ZTNAME,1:$G(DUZ,.5))
 I +ZTSK(.1)=6 Q "1^Finished running"
 I +ZTSK(.1)=5 Q "2^Asked to stop"
 S ZTDTH=$$H3^%ZTM($P(ZTSK(0),U,6))
 K ^%ZTSCH(ZTDTH,ZTSK) ;Remove from schedule
 S %ZTIO=$O(^%ZTSK(ZTSK,.26,"")) I %ZTIO]"" D DQ^%ZTM4 ;Remove from device lists.
 Q "2^Unscheduled"
