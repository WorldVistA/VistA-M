YSGAFTR ;DALOI/MJE/MJD-GAF INT ENTRY BUILD ROUTINE ;09/01/98  16:17
 ;;5.01;MENTAL HEALTH;**43,49,59**;Dec 30, 1994
 ;
 ;This routine will be executed from option YS GAF TRANSMISSION.
 ;This routine will transmit GAF data for the dates entered.  This
 ;routine will also be used to re-transmit GAF data as needed.
 ;It will only transmit GAF records containing all necessary
 ;pieces of information.  A MAILMAN message for each GAF score
 ;transmitted will be sent to users enrolled in mail group
 ;YS GAF TRANSMISSION ACK.
 ;
 ;
 Q
START ;
 ; Date range will be from no less than 10-01-1997 to any time
 ; in the future.
 I '$D(DUZ) D  Q
 .W !!,$C(7),"ERROR:  DUZ is not defined.  Use ^XUP or ask your "
 .W !,"IRM why you don't have a DUZ variable defined.",!!
 .D CLNUP
 ;
 S YSGFDATE=""
 D DTRANGE Q:+Y<1
 K ^TMP("YSGAFTR",$J)
 S ZTRTN="GEN^YSGAFTR"
 ;
 ;VARIABLES TO BE SAVED IN ZTSAVE
 S ZTSAVE("*")=""
 ;
 S ZTDESC="MENTAL HEALTH - GAF TRANSMISSION"
 S ZTIO=""
 D ^%ZTLOAD
 I '$D(ZTSK) QUIT  ;-->
 W !!,"The Mental Health GAF Transmission has been Tasked, job# "
 W ZTSK,"...",!
 Q
 ;
DTRANGE ;
 W !
 S (YSSTD,YSSPD)=0
 S %DT("A")="Enter the Start date: ",%DT="AEQ",%DT(0)=2971001
 D ^%DT K %DT
 Q:+Y<1
 S YSSTD=+Y
 W !
 S %DT("A")="Enter the End date: ",%DT="AEQ"
 D ^%DT K %DT
 Q:+Y<1
 S YSSPD=+Y
 I YSSPD<YSSTD D  G DTRANGE
 .W !?5,"... Start date is after the Ending date ..."
 .W !?5,"... Please re-enter both the Start and Ending Dates ..."
 .H 2 W $C(7)
 Q
 ;
GEN ;
 I $D(ZTQUEUED) S ZTREQ="@" K ZTSK
 S (YSIEN,YSTOT,YSINC,YSTRMT,YSSUBT)=0
 F YSJ="I","O" D
 .S (YSTOT(YSJ),YSTRMT(YSJ),YSINC(YSJ))=0
 F  S YSIEN=$O(^YSD(627.8,YSIEN)) Q:YSIEN=""!('YSIEN)  D
 .S YSGFDATE=$P($P($G(^YSD(627.8,YSIEN,0)),"^",1),".",1)
 .S YSO=$G(^YSD(627.8,YSIEN,0))
 .S YSPATID=$P(YSO,U,2)   ; Patient ID
 .S YSGAFDT=$P(YSO,U,3)   ; Date/time of diagnosis
 .Q:YSGAFDT=""
 .S YSGFDATE=$P($P(YSO,U,3),".",1)
 .I (YSGFDATE>(YSSTD-1))&(YSGFDATE<(YSSPD+1)) D
 ..S YSTOT=YSTOT+1    ; Count total records found in this date range
 ..S YSP=$G(^YSD(627.8,YSIEN,60)),YSPATYPE=$P(YSP,U,4)
 ..I YSPATYPE="" D  Q:YSPATYPE=""
 ...Q:YSPATID=""
 ...S DFN=YSPATID
 ...D PATSTAT^YSDX3B
 ...I '$D(DFN) D  QUIT  ;--->
 ....D EN^YSGAFOBX(YSIEN)
 ...S YSPATYPE=YSSTAT
 ..S YSTOT(YSPATYPE)=YSTOT(YSPATYPE)+1
 ..S YSAX5=$P(YSP,U,3),YSPROV=$P(YSO,U,4)
 ..I YSAX5=""!(YSPROV="") D  Q
 ...S YSINC=YSINC+1
 ...S YSINC(YSPATYPE)=YSINC(YSPATYPE)+1
 ..S YSTRMT=YSTRMT+1
 ..S YSTRMT(YSPATYPE)=YSTRMT(YSPATYPE)+1
 ..D EN^YSGAFOBX(YSIEN)
 D REPORT,MAILIT,CLNUP
 Q
REPORT ;
 S YSSUBT=YSINC+YSTRMT,YSLN=0
 S XTMP="GAF TRANSMISSION TOTALS" D YSLN,SPC
 S XTMP="Total GAF Records:" D YSLN,SPC
 F YSJ="I","O" D
 .S XTMP=$J(+YSTOT(YSJ),8)_"  "
 .S XTMP=XTMP_$S(YSJ="I":"In",1:"Out")_"-patient" D YSLN
 S XTMP=$J(YSTOT,8)_"  Total GAF Records"
 D YSLN,DSH,DSH,SPC
 S XTMP="GAF Records Transmitted:" D YSLN,SPC
 F YSJ="I","O" D
 .S XTMP=$J(+YSTRMT(YSJ),8)_"  "
 .S XTMP=XTMP_$S(YSJ="I":"In",1:"Out")_"-patient" D YSLN
 S XTMP=$J(YSTRMT,8)_"  GAF Record(s) transmitted" D YSLN,SPC
 S XTMP="GAF Records Not Transmitted:" D YSLN,SPC
 F YSJ="I","O" D
 .S XTMP=$J(+YSINC(YSJ),8)_"  "
 .S XTMP=XTMP_$S(YSJ="I":"In",1:"Out")_"-patient" D YSLN
 S XTMP=$J(YSINC,8)_"  GAF Record(s) not transmitted" D YSLN,DSH,SPC
 S XTMP=$J(YSSUBT,8)_"  Total GAF Records" D YSLN,DSH,DSH,SPC
 S XTMP=$J((YSTOT-YSSUBT),8)_"  Difference" D YSLN
 Q
SPC ;
 S XTMP=" " D YSLN
 Q
DSH ;
 S XTMP="--------" D YSLN
 Q
YSLN ;Store to ^TMP for MAILMAN message
 S YSLN=YSLN+1
 S ^TMP("YSGAFTR",$J,YSLN)=XTMP
 Q
MAILIT ; Mail totals
 S DTIME=600
 S XMSUB="GAF Transmission"
 S XMTEXT="^TMP(""YSGAFTR"",$J,"
 S XMY(DUZ)=""
 S XMY("YOUNG,TIM@ISC-DALLAS.VA.GOV")=""
 S XMY("DEVLIN,MARK@ISC-DALLAS.VA.GOV")=""
 S XMDUZ="AUTOMATED MESSAGE"
 D ^XMD
 S DTIME=$$DTIME^XUP(DUZ)
 Q
CLNUP ;This section for clean up of variables
 K X,Y,YSDIROUT,YSDIRUT,YSDUOUT,YSDTOUT,YSGFDATE,YSIEN,YSSPD,YSSTD
 K YSANIMA,YSHH,YSSTAT,YSAX5,YSGAFDT,YSINC,YSLN,YSO,YSP,YSPATID
 K YSPATYPE,YSPROV,YSSUBT,YSTOT,YSTRMT,ZTDESC,ZTIO,ZTRTN,ZTSAVE
 K XTMP,XMDUZ,XMSUB,XMTEXT,XMSUB,XMY,XCNP,XMZ,YSYEAR,YSJ,YSI
 K ^TMP("YSGAFTR",$J)
 Q
