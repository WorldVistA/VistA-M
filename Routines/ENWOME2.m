ENWOME2 ;(WASH ISC)/SAB-WORK ORDER MULTIPLE ENTRY, PRINT NEW WO ;1.6.96
 ;;7.0;ENGINEERING;**35**;Aug 17, 1993
 ; Input Variables
 ; ENPRT("DEV") = selected output device
 ;   ENWODA  = ien of master work order (File #6920)
 ;   ^TMP($J,equip ien) selected equipment array
 ;       = work order ien^work order number
QUETSK ; queue task to print new work orders
 S ZTRTN="DQ^ENWOME2",ZTDESC="Multiple Work Order Hardcopy Print"
 S ZTDTH=$H,ZTIO=ENPRT("DEV")
 S ZTSAVE("ENWODA")="",ZTSAVE("^TMP($J,")=""
 D ^%ZTLOAD,HOME^%ZIS K ZTSK
 Q
DQ ; queued entry point
 ; get software setting for barcodes
 S ENBARCD=0
 S ENI=$O(^ENG(6910.2,"B","PRINT BAR CODES ON W.O.",0))
 I ENI,$P($G(^ENG(6920.2,ENI,0)),U,2)="Y" S ENBARCD=1
 ; get software setting for long/short format wo
 S ENI=$O(^ENG(6910.2,"B","AUTO PRINT NEW W.O.",0))
 S ENPRT("AUTO")=$S(ENI:$P($G(^ENG(6910.2,ENI,0)),U,2),1:"")
 ; print work orders in appropriate format
 S DA=ENWODA N IOINHI,IOINLOW D ZIS^ENUTL
 I ENPRT("AUTO")="S" D FDAT4^ENWOP3
 I ENPRT("AUTO")'="S" D PRT1^ENWOD W @$G(IOF)
 S ENI=0 F  S ENI=$O(^TMP($J,ENI)) Q:'ENI  S ENDA=$P($G(^(ENI)),U) D:ENDA
 . S DA=ENDA N IOINHI,IOINLOW D ZIS^ENUTL
 . I ENPRT("AUTO")="S" D FDAT4^ENWOP3
 . I ENPRT("AUTO")'="S" D PRT1^ENWOD W @$G(IOF)
 I $D(ZTQUEUED) S ZTREQ="@" K ^TMP($J)
 K DA,ENBARCD,ENDA,ENI,ENPRT,ENSHKEY,ENWODA
 Q
 ;ENWOME2
