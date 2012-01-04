XUSPURGE ;SFISC/STAFF - PURGE ROUTINE FOR XUSEC ;03/18/10  07:10
 ;;8.0;KERNEL;**180,312,543**;Jul 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
SCPURG ;Purge sign-on log to 30 days
 N XU1,XU2,XUDT,DIK,DA,DIE,DR,XUNOW
 S XUDT=$$FMADD^XLFDT(DT,-30),XUNOW=$$NOW^XLFDT() ;Set the limit
 I $O(^XUSEC(0,0))'>0 Q
 F DA=0:0 S DA=$O(^XUSEC(0,DA)) Q:(DA'>0)!(DA>XUDT)  D
 . S XU1=$G(^XUSEC(0,DA,0)),XU2=+XU1
 . ;Enter a SIGN OFF time to clear the X-ref's p543
 . I $P(XU1,U,4)="" S DR="3////"_XUNOW,DIE="^XUSEC(0," D ^DIE
 . ;Now kill the record.
 . S DIK="^XUSEC(0," D ^DIK
 . ;Make sure the CUR X-ref is cleared.
 . I XU1 K ^XUSEC(0,"CUR",XU2,DA)
 . Q
 Q
 ;
AOLD ;
 N DIRUT,DIR,XUT,XUDAYS,XUDT,XUI,XUJ,XUK,X
 I $D(ZTQUEUED) D  Q
 . S X=$G(ZTQPARAM),X=$S(X<270:270,1:X) D A02(X),V02(X)
 . Q
 W !!,"This option will purge the log of inactive access and verify codes ",!,"older than the date specified to allow for their re-use."
 S DIR("A")="Do you wish to continue",DIR(0)="Y",DIR("B")="NO" D ^DIR G:$D(DIRUT)!(Y'=1) ENDA
DAYS K DIR S DIR("A")="How far back do you wish to retain codes",DIR("A",1)="VHA has set the minimum time to keep old codes at 270 days.",DIR("B")=270
 S DIR("?")="Enter the number of days indicating at what date codes should be purged.",DIR(0)="N^270:400"
 D ^DIR Q:$D(DIRUT)
 D A02(X),V02(X)
 Q
 ;
A02(XUDAYS) ;Purge old Access codes in the AOLD x-ref.
 N XUT,XUI,XUJ,XUK,XUDT
 S XUT=0,XUDT=$H-XUDAYS,XUI=""
 F  S XUI=$O(^VA(200,"AOLD",XUI)) Q:XUI=""  S XUJ=$O(^(XUI,0)) S XUK=^(XUJ) I XUK<XUDT K ^VA(200,"AOLD",XUI,XUJ) S XUT=XUT+1 W:'$D(ZTQUEUED) "."
 I '$D(ZTQUEUED) W !!,$S('XUT:"No",1:XUT)," old access codes have been purged."
 Q
 ;
V02(XUDAYS) ;Purge old Verify code from each users VOLD x-ref
 N XUT,XUI,XUJ,XUK,XUDT
 S XUT=0,XUDT=$H-XUDAYS,XUI=0
 F  S XUI=$O(^VA(200,XUI)) Q:XUI'>0  S XUK="" D
 . F  S XUK=$O(^VA(200,XUI,"VOLD",XUK)) Q:XUK=""  I ^(XUK)<XUDT K ^VA(200,XUI,"VOLD",XUK) S XUT=XUT+1 W:'$D(ZTQUEUED) "."
 I '$D(ZTQUEUED) W !!,$S('XUT:"No",1:XUT)," old verify codes have been purged."
 Q
ENDA K DIRUT,DIR,XUT,XUDAYS,XUDT,XUI,XUJ,XUK
 Q
