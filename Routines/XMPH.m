XMPH ;(WASH ISC)/THM/CAP-PackMan Load Routines/Print Msg ;12/04/2002  13:48
 ;;8.0;MailMan;**10**;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; LOAD   XMPROU - Load routines
 ;USER ENTRY LIST OF ROUTINES
 Q
DEV ;GET OUTPUT DEVICE / QUEUE PACKMAN PRINT
 N I,ZTSAVE
 F I="DIE","XMZ","XMDUZ","XMV(","XMP2","XMR","XCF" S ZTSAVE(I)=""
 D EN^XUTMDEVQ("ZTSK^XMPH","MailMan: PackMan Print",.ZTSAVE)
 Q
ZTSK ;QUEUED PRINT COMES HERE
 N XMSUBJ,XMZSTR
 I XCF=3 D
 . D TOP^XMPC
 E  I $E($G(IOST),1,2)'="C-" D
 . N XMPARM,XMZREC
 . S XMZREC=$G(^XMB(3.9,XMZ,0))
 . W $$EZBLD^DIALOG($S($P(XMZREC,U,7)["K":34076,1:34077)) ; KIDS Build / PackMan message
 . W $S(XMP2="T":" text print for ",1:" print for "),XMV("NAME")
 . S XMPARM(1)=^XMB("NETNAME"),XMPARM(2)=$$MMDT^XMXUTIL1($$NOW^XLFDT)
 . W !,$$EZBLD^DIALOG(34503,.XMPARM) ; Printed at |1| |2|
 . Q:XMP2="S"
 . S XMSUBJ=$$EZBLD^DIALOG(34536,$$SUBJ^XMXUTIL2(XMZREC)) ; Subj: |1|
 . S XMZSTR=$$EZBLD^DIALOG(34537,XMZ) ; [#|1|]
 . W !,XMSUBJ
 . D W^XMJMP1("  ",XMZSTR)
 . D W^XMJMP1(" ",$$DATE^XMXUTIL2(XMZREC))
 . D WL^XMJMP1($$EZBLD^DIALOG(34538,$$NAME^XMXUTIL($P(XMZREC,U,2),1))) ; From:
 . D W^XMJMP1(" ",$$EZBLD^DIALOG(34541)) ; Page 1
 . D LINE^XMJMP1
 . W !
 D S^XMP2
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
LOAD ;LOAD ROUTINE FROM <X> INTO GLOBAL <DIF>_I_",0)"
 ;
 ;DIFROM NEEDS A MESSAGE NUMBER
 ;
 S (DIE,DIF)="^XMB(3.9,XMZ,2,"
 I $D(DIFROM) W !!,"Please enter the names of the routines you wish to load into this message.",!!,"Only routines will be loaded."
 I  W !!,"INITs, will be sent automatically.",!!
 ;K ^UTILITY($J#256)
 X ^%ZOSF("RSEL") Q:$O(^UTILITY($J,0))=""
 S X=0 S:'$D(XCNP) XCNP=0
 F  S X=$O(^UTILITY($J,X)) Q:X=""  D LL
 K ^UTILITY($J)
 Q
LL N XMHOLD S XMHOLD=XCNP
 W !,"Loading ",X S DIF=DIE,XCNP=XCNP+1,@(DIF_XCNP_",0)")="$ROU "_X
 X ^%ZOSF("LOAD") S $P(@(DIF_"0)"),U,3,4)=XCNP_U_XCNP
 S @(DIF_XCNP_",0)")="$END ROU "_X
 ;
 ;Check for control characters in text
 F XMHOLD=XMHOLD:1:XCNP I $G(@(DIF_XMHOLD_",0)"))?.E1C.E D  S XQCH="HALT" G H^XUS
 . W !!,$C(7),"Errored out loading routine ",X," - control character in text."
 . W !,"Use ^XINDEX to identify it, then remove from routine and try again.",!!
 . D KILLMSG^XMXUTIL(XMZ)
 Q
 ;
PACK ;LOAD ENTIRE PACKAGE (ROUTINES ONLY)
 ;
 S:'$D(XCNP) XCNP=0
 I '$D(DIFROM) S DIC="^DIC(9.4,",DIC(0)="AEQM" D ^DIC Q:Y<0  S DA=+Y
 S XMROU="^DIC(9.4,"_DA_",2,""B"","
P S (XMA0,XMB0)="",(DIE,DIF)="^XMB(3.9,"_XMZ_",2,"
 G P9:'$D(^%ZOSF("TEST")) S XMB=^("TEST")
P1 S XMA0=$O(@(XMROU_"XMA0)")) I $L(XMA0) D TST G P1
 G ER:XMB0
P9 S XMA0=$O(@(XMROU_"XMA0)")) G Q:XMA0="" S X=XMA0 D LL G P9
 ;
XMROU ;LOAD ROUTINES (FROM XMD)
 ;
 S XCNP=XCNP+1,$P(^XMB(3.9,XMZ,2,0),U,3,4)=XCNP_U_XCNP,^(XCNP,0)="$END TXT"
 S XMROU="XMROU(" G P
 ;
TST S X=XMA0 X XMB Q:$T  S XMB0=1 W !,"Program ",X," does not exist." Q
ER W !!,"<< Correct the errors listed above.",!,"Then you may try again.",!
Q K XMA0,XMB0,XMB,XMROU,DIE,DIF Q
