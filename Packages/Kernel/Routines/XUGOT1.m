XUGOT1 ; BT/OAK-BP - COMPARE LOCAL/NATIONAL CHECKSUMS REPORT ;10/20/2006
 ;;8.0;KERNEL;**369**;Jul 10, 1995;Build 27
 Q
REPORT ;
 W !!,">>> This processing will take about thirty minutes."
 W !,"    It will save your time if you send this report"
 W !,"    to a printer.",!
 S %ZIS="Q" D ^%ZIS I POP D ^%ZISC,END Q
 ; Queue report via Taskman
 I $D(IO("Q")) D  G END
 . N ZTDESC,ZTSK,ZTRTN,ZTIO,ZTSAVE
 . S ZTRTN="ENT^XUGOT1",ZTDESC="Compare local/national checksums report"
 . D ^%ZTLOAD,^%ZISC
 . W !,"Task ",$S($G(ZTSK):ZTSK,1:"NOT")," Queued"
 . K IO("Q")
ENT ;
 K ^TMP($J)
 N CKRTP F CKRTP=1:1:9 S CKRTP(CKRTP)=0
 N SLX,SL S U="^",SLX="ZL @RTN S SL=$T(@RTN+1)"
 ;Use SUMB in XPDRSUM
 N XUIEN S XUIEN=0 F  S XUIEN=$O(^DIC(9.8,XUIEN)) Q:XUIEN'>0  D
 . N RTN,X S (RTN,X)=$P($G(^DIC(9.8,XUIEN,0)),U) I $L(RTN)=0 Q
 . I $P($G(^DIC(9.8,XUIEN,0)),U,2)'="R" Q
 . S CKRTP(1)=CKRTP(1)+1 ;Total count of routines reviewed (#1)
 . N TRACK S TRACK=$$TRACK(XUIEN) I TRACK'>0 S CKRTP(3)=CKRTP(3)+1 Q  ; routine isn't being tracked (#3)
 . I $L(RTN)>8 S ^TMP($J,8,RTN)="",CKRTP(8)=CKRTP(8)+1 Q
 . N NSUM,NLPATCH S NSUM=$$NSUM(XUIEN),NLPATCH=$$NLPATCH(XUIEN)
 . I NSUM="",TRACK'=1 Q  ; check for national checksum is empty, and not Local Track
 . I TRACK>2 Q  ; Quit if routine is marked as "National - Deleted or NOT tracked"
 . X ^%ZOSF("TEST") I '$T S CKRTP(2)=CKRTP(2)+1,^TMP($J,2,RTN)=NSUM_"^"_NLPATCH Q  ;routine is not found on the system (#2)
 . X SLX  ; get the second line
 . I SL="" S SL=$$GETSL^XUGOT(X)
 . N LSUM S LSUM=$$LSUM(RTN) I $E(LSUM,2,10)'>0 S CKRTP(2)=CKRTP(2)+1,^TMP($J,2,RTN)=NSUM_"^"_NLPATCH Q  ;routine is not found on the system (#2)
 . I NSUM=LSUM S CKRTP(4)=CKRTP(4)+1 Q  ;national and local checksums match (#4)
 . I TRACK=1 S ^TMP($J,5,RTN)=NSUM_"^"_LSUM,CKRTP(5)=CKRTP(5)+1 Q  ; Local tracked (#5)
 . ;--------- national and local checksums don't match
 . N XUN1,XUN2,XUN3,XUN4,XUL1,XUL2,XUL3,XUA,XUP,XULM,XUPN S XULM="Yes",XUPN="No"
 . S XUP=$$PACK^XUGOT(RTN,SL) ;Patch and version AAA*Z.Z*
 . N NPL2 S NPL2=$$NPL2^XUGOT(XUIEN) I +$P(SL,";",3)=$P(NPL2,"*",2) S $P(XUP,"*",2)=$P(NPL2,"*",2)
 . S XUL2=$$LPLIST(SL)
 . S XUL2=$$LPATCH(XUL2) ;Last patch number from the second line
 . S XUL3=XUP_XUL2 ;Latest local patch base on second line
 . S XUN1=$$NPL1(XUIEN,LSUM,XUL2) ;Number national patch list and patch that matches LSUM.
 . S XUN3=$$NLPATCH(XUIEN) ;Last patch name from Patch multiple fields
 . S XUN2=$P(XUN3,"*",3) ;Last patch number from the last patch name
 . S XUN4=$$XUN4^XUGOT(XUN3) ;Last Version from the last patch name
 . I $P(XUN1,"^",3)'="" S XULM="Unknown"
 . I $P(XUN1,"^",2)'="" S XULM="No"
 . I XUL2'="",XUL2'=XUN2,$$LPLIST(SL)[XUN2 S XUPN="Testing "_XUP_XUL2,XULM="Unknown"
 . I XUL2'="" S XUA=$P($P(XUN1,"^"),XUL2_",",2) I XUA'="" S XUPN=XUP_XUA I $P(NPL2,"*")'="",$P(NPL2,"*",2)'="" S XUPN=NPL2_"*"_XUA ; Missing patches
 . I +XUL2'="",XUL2=XUN2 S ^TMP($J,6,RTN)=NSUM_"^"_LSUM_"^"_XUL3_"^Yes^No",CKRTP(6)=CKRTP(6)+1 Q
 . I XUL2'="",XUL2'=+XUL2 S ^TMP($J,6,RTN)=NSUM_"^"_LSUM_"^"_XUL3_"^Yes^Unknown",CKRTP(6)=CKRTP(6)+1 Q
 . I XUL2'="",XUL2'=XUN2,$$LPLIST(SL)'[XUN2,$P(XUN1,"^")'[XUL2 S ^TMP($J,6,RTN)=NSUM_"^"_LSUM_"^"_XUL3_"^Unknown^"_XUN3,CKRTP(6)=CKRTP(6)+1 Q
 . I XUL2="" S XULM="Unknown"
 . I XUL2="",XUN2="" S XUPN=XUN3
 . I XUL2="",XUN2'="" S XUPN=XUP_$P(XUN1,"^")
 . N XUNV,XULV S XULV=+$P(SL,";",3),XUNV=$$RT^XUGOT(RTN)
 . I XUN4'>0 S XUN4=+$P(XUNV,"^",3)
 . I $P(XUNV,"^")="",$$SL^XUGOT(SL)="" S ^TMP($J,9,RTN)="",CKRTP(9)=CKRTP(9)+1 Q
 . N XUK S XUK=0
 . I $P(XUNV,"^")="" D
 . . N XUL3A S XUL3A=$$SL^XUGOT(SL)_"*"_XULV_"*",XULM="Unknown",XUPN="Unknown"
 . . I $$SL^XUGOT(SL)="" S XUL3A=$P(XUN3,"*",1,2)_"*"
 . . I XUL3A="*" S XUL3A=NPL2_"*"
 . . S XUL3=XUL3A_XUL2
 . . I XUL2'="",XUL2'=XUN2,$$LPLIST(SL)[XUN2 S XUPN="Testing "_XUL3,XULM="Unknown"
 . . I XUL2'="" S XUA=$P($P(XUN1,"^"),XUL2_",",2) I XUA'="" S XUPN=XUP_XUA I $P(NPL2,"*")'="",$P(NPL2,"*",2)'="" S XUPN=NPL2_"*"_XUA ; Missing patches
 . . S ^TMP($J,6,RTN)=NSUM_"^"_LSUM_"^"_XUL3_"^"_XULM_"^"_XUPN,CKRTP(6)=CKRTP(6)+1,XUK=1
 . I XUK=1 Q
 . ; version off
 . N XUK S XUK=0
 . I XULV>0,XULV'=XUN4 D
 . . N XUL3A S XUL3A=$$SL^XUGOT(SL)_"*"_XULV_"*",XULM="Unknown",XUPN="Unknown"
 . . I $$SL^XUGOT(SL)="" S XUL3A=$P(XUN3,"*",1,2)_"*"
 . . I XUL3A="*" S XUL3A=NPL2_"*"
 . . S XUL3=XUL3A_XUL2
 . . I XUL2'="",XUL2'=XUN2,$$LPLIST(SL)[XUN2 S XUPN="Testing "_XUL3,XULM="Unknown"
 . . I XUL2'="" S XUA=$P($P(XUN1,"^"),XUL2_",",2) I XUA'="" S XUPN=XUP_XUA I $P(NPL2,"*")'="",$P(NPL2,"*",2)'="" S XUPN=NPL2_"*"_XUA ; Missing patches
 . . S ^TMP($J,6,RTN)=NSUM_"^"_LSUM_"^"_XUL3_"^"_XULM_"^"_XUPN,CKRTP(6)=CKRTP(6)+1,XUK=1
 . I XUK=1 Q
 . S ^TMP($J,6,RTN)=NSUM_"^"_LSUM_"^"_XUL3_"^"_XULM_"^"_XUPN,CKRTP(6)=CKRTP(6)+1 Q
 D PRT
 Q
 ;
PRT N ST,Y4 S ST=0,Y4=1
 N IOC,IOC1 S IOC=(IO=IO(0)),IOC1=$E(IOST,1,2)["C-"
 U IO W:IOC1 @IOF
 W !,$$PG(Y4)
 N HDR1,HDR2,RPTYP
 F RPTYP=5,6,7,2,9,8,3,4,1 Q:ST  D
 . I RPTYP=1 W !,"ROUTINE FILE TOTAL ENTRIES COUNT (",CKRTP(1),")",!
 . I RPTYP=2,CKRTP(2)>0 W !,"ROUTINES NOT FOUND IN THE SYSTEM (",CKRTP(2),")" D CN W ! D CN I CKRTP(2) D HEADER
 . I RPTYP=3,CKRTP(3)>0 W !,"ROUTINES NOT MARKED FOR TRACKING (",CKRTP(3),")",!
 . I RPTYP=4,CKRTP(4)>0 W !,"ROUTINES WITH MATCHING CHECKSUMS (",CKRTP(4),")",!
 . I RPTYP=5,CKRTP(5)>0 W "ROUTINES MARKED FOR LOCAL TRACKING (",CKRTP(5),")",! I CKRTP(5) D HEADER
 . I RPTYP=6,CKRTP(6)>0 W !,"ROUTINES WITH THE CHECKSUM OFF(",CKRTP(6),")" D CN W ! D CN I CKRTP(6) D HEADER
 . ;I RPTYP=7,CKRTP(7)>0 W !,"ROUTINES WITH VERSION OFF(",CKRTP(7),")" D CN W ! D CN I CKRTP(7) D HEADER
 . I RPTYP=8,CKRTP(8)>0 W !,"ROUTINES WITH MORE THAN 8 CHARACTERS NAME(",CKRTP(8),")" D CN W ! D CN I CKRTP(8) D HEADER
 . ;I RPTYP=9,CKRTP(9)>0 W !,"ROUTINES WITH NO PACKAGE ASSOCIATED WITH(",CKRTP(9),")" D CN W ! D CN I CKRTP(9) D HEADER
 . ;
 . S RTN="" F  S RTN=$O(^TMP($J,RPTYP,RTN)) Q:(RTN="")!(ST)  D
 . . D CN I ST Q
 . . N Y3 S Y3=$G(^TMP($J,RPTYP,RTN))
 . . I RPTYP=5 W " ",RTN,?11,$P(Y3,"^",1),?23,$P(Y3,"^",2),!
 . . I RPTYP=6 W " ",RTN,?11,$P(Y3,"^",1),?23,$P(Y3,"^",2),?35,$E($P(Y3,"^",3),1,11),?48,$P(Y3,"^",4),?57,$E($P(Y3,"^",5),1,23),!
 . . I RPTYP=7 W " ",RTN,?11,$P(Y3,"^",1),?24,$P(Y3,"^",2),?37,$P(Y3,"^",3),!
 . . I RPTYP=2 W " ",RTN,?11,$P(Y3,"^",1),?23,$P(Y3,"^",2),!
 . . I RPTYP=8 W " ",RTN,!
 . . ;I RPTYP=9 W " ",RTN,!
 . . Q
 . Q
 ;--------------------------
END D ^%ZISC K ^TMP($J),%DT,%ZIS
 Q
 ;--------------------------
PG(XUN) ;
 W #,$$FMTE^XLFDT(DT),?(IOM\2),"Page: ",XUN,!!
 Q ""
 ;--------------------------
HEADER ;
 S HDR1=" Routine   Nat CHKSUM  ",HDR2=" =======   ==========  "
 I RPTYP=2 S HDR1=HDR1_"Nat Last Patch",HDR2=HDR2_"============="
 I RPTYP=6 S HDR1=HDR1_"Our CHKSUM  Our Patch    Loc Mod  Patches Needed",HDR2=HDR2_"==========  ===========  =======  =============="
 I RPTYP=5 S HDR1=" Routine   CHKSUM Base  Our CHKSUM",HDR2=HDR2_"==========="
 I RPTYP=7 S HDR1=" Routine   Nat Version  Loc Version  Latest Nat Patch",HDR2=" =======   ===========  ===========  =============="
 I RPTYP=8 S HDR1=" Routine  ",HDR2=" ======="
 ;I RPTYP=9 S HDR1=" Routine",HDR2=" ======="
 W HDR1,!
 W HDR2,!
 Q
 ;---------------------------
%Z1 R "Enter RETURN to continue or '^' to exit: ",ST:60 S ST=$S(ST["^":1,1:0) S:'$T ST=1 W @IOF
 Q
 ;---------------------------
CN I (($Y+2)=IOSL)!(($Y+3)=IOSL) S Y4=Y4+1 D:IOC&IOC1 %Z1 Q:ST  W $$PG(Y4) D HEADER
 Q
 ;--------------------------------------------------------------------------
LSUM(RTN) ;Get the new Checksum LOCAL
 I $G(RTN)="" Q ""
 N DIF,RTNL,X,XCNP,Y
 S X=RTN,DIF="RTNL(",XCNP=0 X ^%ZOSF("LOAD")
 S Y=$$SUMB^XPDRSUM($NA(RTNL))
 Q "B"_Y
 ;
NSUM(IEN) ; get national checksum
 I +$G(IEN)'>0 Q ""
 N XUI,XUSUM
 S XUI=$G(^DIC(9.8,IEN,4)),XUSUM=$P(XUI,U,2)
 I XUSUM["/" S XUSUM=$P(XUSUM,"/",2)
 I XUSUM'="",XUSUM'["B" S XUSUM="B"_XUSUM ;get checksum from field #7.2
 Q XUSUM
 ;------------------------------
NPLIST(IEN) ; get list patches from the field #7.3
 I +$G(IEN)'>0 Q ""
 N XUPLIST
 S XUPLIST=$P($G(^DIC(9.8,+IEN,4)),"^",3)
 S XUPLIST=$P(XUPLIST,"**",2)
 Q $$TRIM^XLFSTR(XUPLIST)
 ;
NPL(IEN) ; get list patches from Patch multiple
 I '$D(^DIC(9.8,IEN,8,0)) Q ""
 N XUIEN,XUPC,XULP,XUFLP S (XULP,XUPC,XUFLP)="",XUIEN=0
 F  S XUIEN=$O(^DIC(9.8,IEN,8,XUIEN)) Q:XUIEN'>0  D
 . I XULP'="" S XUPC=XUPC_","
 . S XUFLP=$P($G(^DIC(9.8,IEN,8,XUIEN,0)),"^"),XULP=$P(XUFLP,"*",3)
 . S XUPC=XUPC_XULP
 Q XUPC
 ;
NPL1(IEN,SUM,LPN) ; get list patches from Patch multiple
 I '$D(^DIC(9.8,IEN,8,0)) Q ""
 N XUIEN,XUPC,XULP,XUFLP,XUA,XUB,XUC S (XULP,XUPC,XUFLP)="",(XUB,XUIEN,XUC)=0
 F  S XUIEN=$O(^DIC(9.8,IEN,8,XUIEN)) Q:XUIEN'>0  D
 . I XULP'="" S XUPC=XUPC_","
 . S XUA=$G(^DIC(9.8,IEN,8,XUIEN,0)),XUFLP=$P(XUA,"^"),XULP=$P(XUFLP,"*",3)
 . I XULP=LPN S XUC="" I SUM'=$P(XUA,"^",2) S XUB=""
 . S XUPC=XUPC_XULP
 Q XUPC_"^"_XUB_"^"_XUC
 ;
LPLIST(SL) ; get list of patch Number from the second line
 I $G(SL)="" Q ""
 N XUPLIST
 S XUPLIST=$P(SL,"**",2) ;XUPLIST=$P(XUPLIST,"**",2)
 S XUPLIST=$$TRIM^XLFSTR(XUPLIST)
 Q XUPLIST
 ;
LPATCH(PLIST) ; get the last patch number of the patch list from the second line
 I $G(PLIST)="" Q ""
 N XUI,PLIST1
 S PLIST1=$TR(PLIST,","),XUI=$L(PLIST)-$L(PLIST1)
 Q $P(PLIST,",",XUI+1)
 ;
NLPATCH(IEN) ;get national last patch name
 I +$G(IEN)'>0 Q ""
 N XUA
 S XUA=$O(^DIC(9.8,IEN,8,"A"),-1) I XUA'>0 Q ""
 S XUA=$G(^DIC(9.8,IEN,8,XUA,0)),XUA=$P(XUA,"^")
 Q XUA
 ;--------------------------------
TRACK(IEN) ; get national information
 N XUA
 S XUA=$P($G(^DIC(9.8,IEN,6)),"^")
 I (XUA="")!(XUA="Local - don't report") S XUA=0
 I XUA="Local - report" S XUA=1
 I XUA="National - report" S XUA=2
 Q XUA
 ;
