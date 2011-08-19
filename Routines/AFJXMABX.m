AFJXMABX ;FO-OAKLAND/GMB-PRINT BY SECTION NETWORK HEALTH EX's ;03/17/2003  07:45
 ;;5.1;Network Health Exchange;**1,2,10,11,15,34,35**;Jan 23, 1996
 ; Totally rewritten 3/2003.  (Previously FJ/CWS.)
 ; Called from ^AFJXWCPM
ENTER ;
 N AXNHEDUZ,AXABORT
 S AXABORT=0
 S AXNHEDUZ=$$FIND1^DIC(200,"","X","NETWORK,HEALTH EXCHANGE","B")
 F  D  Q:AXABORT
 . N DIR,X,Y,AXLIST,AXCNT
 . W @IOF
 . S DIR(0)="SO^Y:Your Own;A:All"
 . S DIR("A")="Select the requests to list"
 . S DIR("B")="Your Own"
 . D ^DIR I $D(DIRUT) S AXABORT=1 Q
 . D LIST(AXNHEDUZ,Y,.AXLIST,.AXCNT) Q:'AXCNT
 . D CHOOSE(.AXLIST,AXCNT)
 Q
LIST(AXNHEDUZ,AXWHICH,AXLIST,AXCNT) ;
 N AXMZ,AXREC,AXSUBJ,AXABORT,AXLEN,AXDATE
 S (AXCNT,AXMZ,AXABORT)=0
 S AXLEN("#")=$L($$BMSGCT^XMXUTIL(AXNHEDUZ,1))
 S AXLEN("S")=79-14-AXLEN("#")-2-2+10
 D LHDR(AXWHICH,.AXLEN)
 F  S AXMZ=$O(^XMB(3.7,AXNHEDUZ,2,1,1,AXMZ)) Q:'AXMZ  D  Q:AXABORT
 . S AXREC=$G(^XMB(3.9,AXMZ,0))
 . S AXSUBJ=$P(AXREC,U,1) Q:$E(AXSUBJ,19,19)'?1A!(AXSUBJ'["<")
 . I AXWHICH="Y",$P($G(^XMB(3.9,AXMZ,2,1,0)),U,2)'=DUZ Q
 . I $Y+5>IOSL D  Q:AXABORT
 . . I $E(IOST,1,2)="C-" D PAGE^XMXUTIL(.AXABORT) Q:AXABORT
 . . D LHDR(AXWHICH,.AXLEN)
 . S AXDATE=$$DATE^XMXUTIL2(AXREC)
 . S AXCNT=AXCNT+1,AXLIST(AXCNT)=AXMZ
 . W !,$J(AXCNT,AXLEN("#")),"  ",AXDATE,"  ",$E(AXSUBJ,11,AXLEN("S"))
 Q
LHDR(AXWHICH,AXLEN) ;
 W @IOF,$S(AXWHICH="Y":"Your",1:"All")," NHE Results"
 W !," #",?AXLEN("#")+2,"Date Sent       Subject"
 W !,$$REPEAT^XLFSTR("=",79)
 Q
CHOOSE(AXLIST,AXCNT) ;
 N DIR,X,Y,AXMZ,DIC,D,AXCOMP,AXABORT
 S AXABORT=0
 W !
 S DIR(0)="NO^1:"_AXCNT
 S DIR("A")="Select the report you'd like to print"
 D ^DIR I $D(DIRUT) S AXABORT=1 Q
 S AXMZ=AXLIST(Y)
 F  D  Q:AXABORT
 . K DIC,X,Y,D
 . W !
 . S DIC("A")="Select Component: "
 . S DIC(0)="AEQZ",D="C" ; Lookup using only the C xref (upper-case)
 . S DIC="^AFJ(537015,"
 . D IX^DIC I Y<0 S AXABORT=1 Q
 . S AXCOMP=Y(0,0)
 . N AXSAVE,I,ZTSK
 . W !
 . F I="AXCOMP","AXMZ" S AXSAVE(I)=""
 . D EN^XUTMDEVQ("PRINT^AFJXMABX","AFJX Print Completed NHE Results by Component",.AXSAVE,,1)
 . I $D(ZTSK) W !,"Print queued.  Task number: ",ZTSK
 Q
PRINT ; We assume that there may be more than 1 of the same component,
 ; and that they are not necessarily consecutive.
 N AXI,AXTXT,AXPAGE,AXABORT,AXFOUND,AXDASH
 S (AXI,AXPAGE,AXABORT)=0,AXI=3,AXFOUND=0,AXDASH=$$REPEAT^XLFSTR("-",56)
 D PHDR(AXMZ,.AXPAGE) W !
 F  S AXI=$O(^XMB(3.9,AXMZ,2,AXI)) Q:'AXI  S AXTXT=$G(^(AXI,0)) D  Q:AXABORT
 . Q:AXTXT'[AXCOMP  Q:$E(AXTXT,71,78)'["------"
 . S AXFOUND=1
 . F  D  Q:'AXI!AXABORT  I $E(AXTXT,71,78)["------",AXTXT'[AXCOMP,AXTXT'[AXDASH Q
 . . I $Y+3+($E(IOST,1,2)="C-")>IOSL D  Q:AXABORT
 . . . I $E(IOST,1,2)="C-" W ! D PAGE^XMXUTIL(.AXABORT) Q:AXABORT
 . . . D PHDR(AXMZ,.AXPAGE) W !
 . . W !,AXTXT
 . . S AXI=$O(^XMB(3.9,AXMZ,2,AXI)),AXTXT=$G(^(+AXI,0))
 I 'AXFOUND W !,"Component '",AXCOMP,"' is not in this request."
 Q
 ; We assume that there may be more than 1 of the same component,
 ; and if so, that they are consecutive.
 ;N AXI,AXTXT,AXPAGE,AXABORT
 ;S (AXI,AXPAGE,AXABORT)=0,AXI=3
 ;D PHDR(AXMZ,.AXPAGE) W !
 ;F  S AXI=$O(^XMB(3.9,AXMZ,2,AXI)) Q:'AXI  S AXTXT=$G(^(AXI,0)) I AXTXT[AXCOMP,$E(AXTXT,71,78)["------" Q
 ;I 'AXI W !,"Component '",AXCOMP,"' is not in this request." Q
 ;W !,AXTXT
 ;F  S AXI=$O(^XMB(3.9,AXMZ,2,AXI)) Q:'AXI  S AXTXT=$G(^(AXI,0)) Q:AXTXT?10."-"1" "1.5E1" - ".E1" "10."-"&(AXTXT'[AXCOMP)  D  Q:AXABORT
 ;. I $Y+3+($E(IOST,1,2)="C-")>IOSL D  Q:AXABORT
 ;. . I $E(IOST,1,2)="C-" W ! D PAGE^XMXUTIL(.AXABORT) Q:AXABORT
 ;. . D PHDR(AXMZ,.AXPAGE) W !
 ;. W !,AXTXT
 ;Q
PHDR(AXMZ,AXPAGE) ;
 N AXI
 S AXPAGE=AXPAGE+1
 I $E(IOST,1,2)="C-"!$D(AXPAGE(0)) W @IOF
 E  D  ; Don't eject when printing first page to printer.
 . W $C(13)
 . S AXPAGE(0)=""
 W "NHE Results for ",$$NAME^XMXUTIL(DUZ),?70,$J("PAGE "_AXPAGE,9)
 F AXI=2,3 I $G(^XMB(3.9,AXMZ,2,AXI,0))'="" W !,^(0)
 W !,$$REPEAT^XLFSTR("=",79)
 Q
