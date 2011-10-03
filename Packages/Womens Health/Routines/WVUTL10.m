WVUTL10 ;HCIOFO/FT-Women's Health Utility Routine ;1/12/01  14:41
 ;;1.0;WOMEN'S HEALTH;**14**;Sep 30, 1998
STOPCHK(FLAG) ; Does user want to stop background task?
 ; FLAG: 0 - Check is done before any output to the user.
 ;       1 - Check is done after output to user has begun.
 Q:'$D(ZTQUEUED)  ;not a background task
 I $$S^%ZTLOAD D
 .S ZTSTOP=1 ;set TaskMan variable equal to 1 to stop task
 .K ZTREQ ;keep record of task in task log
 .Q
 Q:+$G(ZTSTOP)=0  ;no request to stop task
 Q:'FLAG  ;don't send message to output device
 ; Print message to output device
 N WVSTOP
 S WVSTOP(1)="          *** OUTPUT STOPPED AT USER'S REQUEST ***"
 S WVSTOP(2)="               Option Name: "_$S($P($G(XQY0),"^")]"":$P($G(XQY0),"^"),1:"Unknown")
 S WVSTOP(3)="          Option Menu Text: "_$S($P($G(XQY0),"^",2)]"":$P($G(XQY0),"^",2),1:"Unknown")
 S WVSTOP(4)="                    Task #: "_$S(+$G(ZTSK)>0:+$G(ZTSK),1:"Unknown")
 D EN^DDIOL(.WVSTOP,"","!?10")
 Q
