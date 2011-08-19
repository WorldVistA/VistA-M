PRCHITX1 ;WOIFO/LKG-WRITING ITEM DATA FOR NIF TO DAT FILES ;12/27/04  17:58
 ;;5.1;IFCAP;**75**;OCT 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;Writes .dat file of vendor and item information to host file
 D EN^DDIOL("This option writes item information to the .dat file.")
 D EN^DDIOL("It is recommended to queue this extract for a time of low user activity.",,"!!")
 N %ZIS,ZTRTN,ZTDESC,PRCPHYS
 K Y,DIR S DIR(0)="Y",DIR("A")="Include physical inventory count transactions in the analysis",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' if you have a large number of items that have recently been"
 S DIR("?",2)="added to your GIP inventory, but have not yet been received or issued."
 S DIR("?")="Answer 'NO' to exclude slow moving stock from NIF processing."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) G ITX
 S PRCPHYS=$S(Y=1:"Y",1:"N") K Y
 S %ZIS="Q",%ZIS("A")="Host File Device: ",%ZIS("B")="PRC_WIDE_HOST_FILE"
 D ^%ZIS G:POP ITX
 I $D(IO("Q")) D  Q
 . S ZTRTN="COMPILE^PRCHITX1",ZTDESC="Item Extraction for NIF",ZTSAVE("PRCPHYS")=""
 . D ^%ZTLOAD,HOME^%ZIS
 . D EN^DDIOL("Task #"_ZTSK) K IO("Q"),ZTSK
COMPILE ;invoke the item and vendor compile
 N X,Y,PRCSTA,PRCV,PRCW,PRCX,PRCY,PRCZ
 D IN^PRCHITX
 S PRCSTA=$$GETSTATN^PRCHITX
 U IO
VENDOR ;Write vendor data
 S PRCX=""
 F  S PRCX=$O(^TMP($J,"V",PRCX)) Q:PRCX=""  D
 . S PRCY=$G(^TMP($J,"V",PRCX)) Q:PRCY=""
 . S PRCZ="6^9^"_PRCSTA_"^"_PRCX_"^"_$P(PRCY,"^")_"^"_$P(PRCY,"^",4)_"^"_$P(PRCY,"^",3)_"^"_$P(PRCY,"^",2)_"^"_$P(PRCY,"^",5)
 . W PRCZ,!
ITEM ;Write item data
 S PRCX=""
 F  S PRCX=$O(^TMP($J,"I",PRCX)) Q:PRCX=""  D
 . S PRCY=$G(^TMP($J,"I",PRCX,0)) Q:PRCY=""
 . S PRCZ="6^0^"_PRCSTA_"^"_$P(PRCY,"^",8)_"^"_PRCX_"^"_$$GETSDESC^PRCHITX(PRCX)_"^"
 . W PRCZ
 . S X=0,Y=1
 . F  S X=$O(^PRC(441,PRCX,1,X)) Q:X=""  D
 . . S PRCZ=$G(^PRC(441,PRCX,1,X,0)),PRCZ=$TR(PRCZ,"^") Q:PRCZ=""
 . . W:Y>1 " " W PRCZ S Y=Y+1
 . S PRCZ="^^"_$P(PRCY,"^",6)_"^"_$P(PRCY,"^",4)_"^" W PRCZ
 . S PRCW=$G(^TMP($J,"I",PRCX,1)),PRCV=$P(PRCW,"^")
 . S PRCZ=$P(PRCY,"^",5)_"^^"_PRCV_"^^^^"_$P(PRCW,"^",4)_"^0^"_$P(PRCW,"^",2)_"^"_$P(PRCW,"^",3)_"^"
 . W PRCZ
 . S PRCZ=$P(PRCY,"^",3)_"^"_$P(PRCW,"^",6)_"^^"_$P(PRCW,"^",5)
 . W PRCZ,!
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 D:'$D(ZTQUEUED) EN^DDIOL("<DONE>")
 K PRCW,PRCX,PRCY,PRCZ S PRCW=$$KSP^XUPARAM("WHERE")
 K XMZ,XMMG,XMDUZ,XMY,XMSUB,XMTEXT
 S PRCX(1)="Record counts for NIF Item Extract File from Station "_PRCSTA
 S PRCX(2)=" "
 S PRCX(3)="    Number of items: "_$G(^TMP($J,"I"),0)
 S PRCX(4)="  Number of vendors: "_$G(^TMP($J,"V"),0)
 S PRCX(5)=" ",PRCX(6)="Physical count transactions were "_$S(PRCPHYS="Y":"",1:"not ")_"included in the analysis."
 X ^%ZOSF("UCI") S PRCY=^%ZOSF("PROD") S:PRCY'["," Y=$P(Y,",")
 I Y=PRCY,PRCW'["FO-",PRCW'["ISC-" S XMY("prchitem@va.gov")=""
 I $G(DUZ)>0,$D(^VA(200,DUZ)) D
 . N PRCNAME
 . S XMY(DUZ)=""
 . S PRCNAME("FILE")=200,PRCNAME("IENS")=DUZ_",",PRCNAME("FIELD")=.01
 . S PRCX(7)=" ",PRCX(8)="The extraction process was run by "_$$NAMEFMT^XLFNAME(.PRCNAME,"G","M")_"."
 S XMSUB="NIF Item Extract Statistics for Station "_PRCSTA
 S XMDUZ="NIF ITEM EXTRACTOR"
 S XMTEXT="PRCX(" D ^XMD
 I $G(XMZ),'$D(ZTQUEUED) D EN^DDIOL("MailMan message #"_$G(XMZ)_" with extract statistics was sent.")
 K XMZ,XMMG,XMDUZ,XMY,XMSUB,XMTEXT,PRCPHYS
ITX ;EXIT
 K POP,^TMP($J),DTOUT,DUOUT,DIRUT,DIROUT,Y
 Q
