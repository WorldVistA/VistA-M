RMPREO ;HINES/HNC - SUSPENSE PROCESSING; Feb 01, 2024@08:51:20
 ;;3.0;PROSTHETICS;**45,55,83,182,191,212,215**;Feb 09, 1996;Build 3
 ;
 ;HNC #83, add free text ordering provider 3/10/05
 ;
 ;RMPR*3.0*182 Add Urgency flag to List Manager Suspense
 ;             List and print template RPMR VIEW REQUEST
 ;             for action 'View Request'
 ;             Also, adds check that will insure variable 
 ;             RMPRSITE is undefined rather than test for  
 ;             array RMPR defined as a viable site exists
 ;             in RMPRSITE.
 ;
 ;RMPR*3.0*191 Ensure array element RMPR("STA") is defined
 ;             before further processing.
 ;
 ;RMPR*3.0*212 Resorts List by SUSPENSE DATE (RMPREO NEW) 
 ;             rather than by IEN (RMPREO).
 ;
 ;RMPR*3.0*215 Include CANCELLED requests in suspense processing
 ;
 ;  Reference to CRNRSITE^VAFCCRNR supported by icr #7346
 ;
EN ; -- main entry point for RMPREO
 D ^%ZISC
 N STRING,CLREND,COLUMN,LINE,ON,OFF
 ;get patient to test with
 K ^TMP($J,"RMPREO")
 K ^TMP($J,"RMPREOEE")
 K ^TMP($J,"RMPREO NEW")
 ;ask station
 I '$D(RMPRSITE)!'$D(RMPR("STA")) D DIV4^RMPRSIT Q:$D(X)    ;RMPR*3.0*182, 191
 I '$D(RMPRDFN) D GETPAT^RMPRUTIL Q:'$D(RMPRDFN)
 D EN^VALM("RMPREO")
 Q
 ;
HDR ; -- header code
 N VA,VADM
 S DFN=RMPRDFN
 D DEM^VADPT
 ;S VALMHDR(1)="Suspense Processing"
 S VALMHDR(1)="Open/Pending/Closed Suspense for "_$$LOWER^VALM1(VADM(1))_"  ("_$P(VADM(2),U,2)_")    '!' = STAT"   ;RMPR*3.0*182
 D KVAR^VADPT
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP($J,"RMPREO"),^TMP($J,"RMPREOEE")
 D HDR
 N RMPRA,CDATE,LINE,X,RMPRSTAT     ;RMPR*3*182
 N SDATE                           ;RMPR*3*212
 ;start loop
 ;
 K ADATE,PDAY
 S RMPRA="",VALMCNT=0,RRX=""
 ;reverse order display
 F  S RMPRA=$O(^RMPR(668,"C",RMPRDFN,RMPRA),-1) Q:RMPRA=""  D
 . ;
 . ;  Included cancelled requests for converted sites.  p215 wtc 12/20/23, 2/1/24
 . ;
 . I $P(^RMPR(668,RMPRA,0),U,10)="X",'$$CRNRSITE^VAFCCRNR($P($$SITE^VASITE(),U,3)) Q  ;
 .S VALMCNT=VALMCNT+1,LINE=VALMCNT
 .S RRX=$$SETFLD^VALM1(LINE,RRX,"LINE")
 .S RMPRSTAT="" I $P($G(^RMPR(668,RMPRA,8)),U,5)["STAT" S RMPRSTAT="!"    ;RMPR*3*182
 .S CDATE=$P(^RMPR(668,RMPRA,0),U,1),CDATE=$$DAT1^RMPRUTL1(CDATE)_RMPRSTAT    ;RMPR*3*182
 .S SDATE=$P(^RMPR(668,RMPRA,0),U) ;RMPR*3*212
 .S RRX=$$SETFLD^VALM1(CDATE,RRX,"DATE")
 .S WHO1=""
 .I $P(^RMPR(668,RMPRA,0),U,11)'="" S WHO1=$$WHO^RMPREOU($P(^RMPR(668,RMPRA,0),U,11),12,RMPRA)
 .I $P($G(^RMPR(668,RMPRA,"IFC1")),U,3)'="" S WHO1=$$WHO^RMPREOU("",12,RMPRA)
 .;
 .S RRX=$$SETFLD^VALM1(WHO1,RRX,"WHO")
 .K WHO,WHO1
 .;type
 .S TYPE=$$TYPE^RMPREOU(RMPRA,8)
 .S RRX=$$SETFLD^VALM1(TYPE,RRX,"TYPE")
 .;display description if manual
 .;
 .S RRX=$$SETFLD^VALM1($$DES^RMPREOU(RMPRA,22),RRX,"DES")
 .;init activation date
 .S ADATE="",PDAY="",WRKDAY=""
 .S ADATE=$P(^RMPR(668,RMPRA,0),U,9)
 .I ADATE'="" S (PDAY,WRKDAY)=$$WRKDAY^RMPREOU(RMPRA)
 .I ADATE="" S (PDAY,WRKDAY)=$$CWRKDAY^RMPREOU(RMPRA)
 .S RRX=$$SETFLD^VALM1($$DAT1^RMPRUTL1(ADATE),RRX,"INITIAL ACTION DATE")
 .I ADATE'="" S CDAY=$$PDAY^RMPREOU(RMPRA) I CDAY>7 S PDAY="*"_WRKDAY
 .I ADATE=""&(WRKDAY>5) S PDAY="@"_WRKDAY
 .S RRX=$$SETFLD^VALM1(PDAY,RRX,"PDAY")
 .K ADATE,PDAY,WRKDAY,CDAY
 .;S R660=""
 .;F  S R660=$O(^RMPR(668,RMPRA,6,"B",R660)) Q:R660'>0  D
 .; .S RRX=$$SETFLD^VALM1($$ITEM^RMPREOU(R660,17),RRX,"ITEM")
 .S RRX=$$SETFLD^VALM1($$STATUS^RMPREOU(RMPRA,7),RRX,"STATUS")
 .S ^TMP($J,"RMPREO",LINE,0)=RRX
 .S ^TMP($J,"RMPREOEE",LINE,0)=RMPRA
 .S ^TMP($J,"RMPREO NEW",SDATE,LINE,RMPRA)=RRX ;resort array for RMPR*3*212
 ;resort RMPREO using RMPREO NEW;RMPR*3*212
 I $D(^TMP($J,"RMPREO NEW")),$$SORT(SDATE) K ^TMP($J,"RMPREO NEW")
 Q
 ;
SORT(SDATE) ;reorder RMPREO using RMPREO NEW;RMPR*3*212
 N NL,SD,LINE,X,RMPRN K ^TMP($J,"RMPREO"),^TMP($J,"RMPREOEE")
 S SD="",NL=1 F  S SD=$O(^TMP($J,"RMPREO NEW",SD),-1) Q:SD<1  D
 .S LINE=0 F  S LINE=$O(^TMP($J,"RMPREO NEW",SD,LINE)) Q:LINE<1  D
 ..S RMPRN=$O(^TMP($J,"RMPREO NEW",SD,LINE,0))
 ..S X=^TMP($J,"RMPREO NEW",SD,LINE,RMPRN),^TMP($J,"RMPREOEE",NL,0)=RMPRN
 ..S X=$$SETFLD^VALM1(NL,X,"LINE"),^TMP($J,"RMPREO",NL,0)=X,NL=NL+1
 Q 1
 ;
SET(STRING,LINE,COLUMN,CLREND,ON,OFF) ;set array
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLUMN,CLREND))
 I $G(ON)]""!($G(OFF)]"") D CNTRL^VALM10(LINE,COLUMN,$L(STRING),ON,OFF)
 Q
 ;
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 ;NOT XUSCLEAN
 K ^TMP($J,"RMPREO")
 K ^TMP($J,"RMPREOEE")
 K ^TMP($J,"RMPREO NEW")
 K RMPRDFN
 Q
 ;
EXPND ; -- expand code
 Q
 ;
