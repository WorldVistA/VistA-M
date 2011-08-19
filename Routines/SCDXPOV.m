SCDXPOV ;ALB/SCK - VISIT REPORT BY NPCDB TRANSMISSION STATUS ; 05 Oct 98  8:37 PM
 ;;5.3;Scheduling;**73,118,123,159,173**;AUG 13, 1993
 ;
 Q
EN ;  Main entry point for the visit report.
 ;
 ;  Variables:
 ;     SCXBEG  - Beginning date for encounters
 ;     SCXEND  - Ending date for encounters
 ;     SCXMD   - Multi-divisional Flag, 1: Multi-divisional, 0: if not
 ;     SCXSITE - Site
 ;     SCXSN   - Site Number
 ;     SCDIV    - Division
 ;     SCHDIV   - Temporary division holder
 ;     SCXTFLG - Flag for show totals only
 ;     SCXOPT  - Report option, 1: transmission only, 2: visit only, 3: both
 ;     SCXABRT - Flag abort condition
 ;
 N SCXBEG,SCXEND,SCXMD,SCDIV,SCHDIV,SCXTFLG,SCXOPT,SCXABRT
 ;
 K ^TMP("SCDXPOV",$J),^TMP("SCDXV",$J)
 ;
 S SCXBEG=$$GETDATE^SCDXPOV2("From Date: ")
 G:SCXBEG<0 END
EN1 S SCXEND=$$GETDATE^SCDXPOV2("To Date: ")
 G:SCXEND<0 END
 I SCXEND<SCXBEG D  G EN1
 . W !!,"TO DATE CANNOT BE EARLIER THAN FROM DATE",!
 S SCXEND=SCXEND+.9
 S SCXMD=0 I $D(^DIC(4,+$$SITE^VASITE(SCXBEG),"DIV")),^("DIV")="Y" S SCXMD=1
 S SCXOPT=$$RPTOPT^SCDXPOV2 G:SCXOPT<0 END
 I SCXMD,SCXOPT'[2 S SCXTFLG=$$SHWTOT^SCDXPOV2 G:SCXTFLG<0 END
 S %ZIS="Q" D ^%ZIS  G:POP END
 I $D(IO("Q")) D QUE^SCDXPOV2 G END
 ;
START ;
 S SCXABRT=0
 S SCDIV=$P($$SITE^VASITE(SCXBEG),U,3)
 I SCXMD F SCDIV=0:0 S SCDIV=$O(^DG(40.8,SCDIV)) Q:'SCDIV  S SCHDIV=SCDIV,SCDIV=$P($$SITE^VASITE(SCXBEG,+SCDIV),U,3) D:SCDIV]"" INIT(SCDIV) S SCDIV=SCHDIV
 I 'SCXMD D INIT(SCDIV)
 ;
 D BUILD(SCXBEG,SCXEND)
 D:SCXOPT'[2 WRT^SCDXPOV1
 G:SCXABRT END
 D:SCXOPT'=1 WRT^SCDXPOV3
 ;
END ;
 D:'$D(ZTQUEUED) ^%ZISC
 K ^TMP("SCDXPOV",$J),^TMP("SCDXV",$J),ZTDESCR,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
BUILD(SCXB,SCXE) ; Order through the encounters in the selected date range and process.
 ;    Input:
 ;        SCXB  -  Beginnging date (SCXBEG)
 ;        SCXE  -  Ending date (SCXEND)
 ;
 ;    Variables
 ;        SDT   -  Date being checked
 ;        SCXOE -  Outpatient encounter being checked
 ; 
 N SDT,SCXOE
 ;
 S SDT=SCXB-.1
 F  S SDT=$O(^SCE("B",SDT)) Q:SDT'>0!(SDT>SCXE)  D
 . S SCXOE=0
 . F  S SCXOE=$O(^SCE("B",SDT,SCXOE)) Q:SCXOE'>0  D:$D(^SCE(SCXOE,0)) GOTIT(SCXOE)
 Q
 ;
GOTIT(SCXOE) ;  Process line of data in the OUTPATIENT ENCOUNTER FILE
 ;    Input:
 ;        SCXOE  -  IEN of entry in the OUTPATIENT ENCOUNTER File, #409.73
 ;    Variables
 ;        SCX    - 0 node of the OUTPATIENT ENCOUNTER entry
 ;        SCX1   - 0 node of the TRANSMITTED OUTPATIENT ENCOUNTER entry
 ;        SCX2   - 1 node of the TRANSMITTED OUTPATIENT ENCOUNTER entry
 ;        SCXI   - IEN of the associated entry (SCX) in the TRANSMITTED OUTPATIENT ENCOUNTER File
 ;        SCXEL  - Eligibility of the encounter
 ;        SCXCV  - Originating process for the encounter
 ;        SCXCP  - 1 if appt. type is C&P, 0 if not
 ;        SCXDV  - Division where the encounter took place
 ;        SCXACK - Acknowledgement status of TRANSMITTED OUTPATIENT ENCOUNTER entry  
 ;                 0 - No information
 ;                 1 - Waiting Transmission 
 ;                 2 - Transmitted
 ;                 3 - Acknowledged
 ;
 N SCX,SCX1,SCX2,SCXI,SCXEL,SCXCV,SCXCP,SCXDV,SCXACK
 ;
 Q:'$D(^SD(409.73,"AENC",SCXOE))
 S SCX=^SCE(SCXOE,0)
 S SCXI=0,SCXI=$O(^SD(409.73,"AENC",SCXOE,SCXI))
 S SCX1=^SD(409.73,SCXI,0),SCX2=$G(^(1))
 ;
 S SCXEL=$P(SCX,U,13)
 Q:SCXEL']""  Q:'$D(^DIC(8,SCXEL,0))
 S SCXCV=$P(SCX,U,8) Q:SCXCV=4  S SCXCV=$$SCH(SCXCV)
 S SCXCP=$S($P(SCX,U,10)=1:1,1:0)
 S SCXDV=$P($$SITE^VASITE(SCXBEG,$P(SCX,U,11)),U,3)
 ;
 ;if division was inactive as of report start date, but division
 ;  was active as of the date of this encounter, be sure an array entry
 ;  exists to be able to count it. 
 I SCXDV']"" D  Q:SCXDV']""
 .D ECDT^SCDXUTL2(SCXI) S X=$P(X," ",1,3) D ^%DT
 .S SCXDV=$P($$SITE^VASITE(Y,$P(SCX,U,11)),U,3)
 .I SCXDV]"" D
 ..D:'$D(^TMP("SCDXPOV",$J,SCXDV)) INIT(SCXDV)
 ;
 S SCXACK=0
 ;
 I $P(SCX1,U,4)=1&($P(SCX2,U,1)']"")&($P(SCX2,U,4)']"") S SCXACK=1
 I $P(SCX1,U,4)=0&($P(SCX2,U,1)]"")&($P(SCX2,U,4)']"") S SCXACK=2
 I $P(SCX1,U,4)=0&($P(SCX2,U,1)]"")&($P(SCX2,U,4)]"") S SCXACK=3
 ;
 Q:SCXACK=0
 ;
 ;I '$D(^TMP("SCDXPOV",$J,SCXDV)) D INIT(SCXDV)
 Q:'$D(^TMP("SCDXPOV",$J,SCXDV))
 ;
 I SCXEL]"",$P(^DIC(8,SCXEL,0),U,5)="N" D
 . S $P(^TMP("SCDXPOV",$J,SCXDV,"NVELIG",SCXEL),U,SCXACK)=+$P($G(^TMP("SCDXPOV",$J,SCXDV,"NVELIG",SCXEL)),U,SCXACK)+1
 . S $P(^TMP("SCDXPOV",$J,"TOT","NVELIG",SCXEL),U,SCXACK)=+$P($G(^TMP("SCDXPOV",$J,"TOT","NVELIG",SCXEL)),U,SCXACK)+1
 ;
 I SCXEL]"",$P(^DIC(8,SCXEL,0),U,5)="Y" D
 . S $P(^TMP("SCDXPOV",$J,SCXDV,"VELIG",SCXEL),U,SCXACK)=+$P($G(^TMP("SCDXPOV",$J,SCXDV,"VELIG",SCXEL)),U,SCXACK)+1
 . S $P(^TMP("SCDXPOV",$J,"TOT","VELIG",SCXEL),U,SCXACK)=+$P($G(^TMP("SCDXPOV",$J,"TOT","VELIG",SCXEL)),U,SCXACK)+1
 ;
 I SCXCV]"",$D(^TMP("SCDXPOV",$J,SCXDV,"COV",SCXCV)) D
 . S $P(^TMP("SCDXPOV",$J,SCXDV,"COV",SCXCV),U,SCXACK)=+$P(^TMP("SCDXPOV",$J,SCXDV,"COV",SCXCV),U,SCXACK)+1
 . S $P(^TMP("SCDXPOV",$J,"TOT","COV",SCXCV),U,SCXACK)=+$P(^TMP("SCDXPOV",$J,"TOT","COV",SCXCV),U,SCXACK)+1
 ;
 I SCXCP,$D(^TMP("SCDXPOV",$J,SCXDV,"CP")) D
 . S $P(^TMP("SCDXPOV",$J,SCXDV,"CP"),U,SCXACK)=+$P(^TMP("SCDXPOV",$J,SCXDV,"CP"),U,SCXACK)+1
 . S $P(^TMP("SCDXPOV",$J,"TOT","CP"),U,SCXACK)=+$P(^TMP("SCDXPOV",$J,"TOT","CP"),U,SCXACK)+1
 ;
 ;  Removed D:SCXACK, all encounters will now count towards visit
 D VISIT^SCDXPOV3($P($P(SCX,U),"."),$P(SCX,U,2),SCXEL,$P(^DIC(8,SCXEL,0),U,5),SCXCV,SCXCP)
 ;
 Q
 ;
SCH(SCXCV) ;Determine scheduled/unscheduled status for appointment type encounters
 ;Output: if SCXCV=2 or 3, SCXCV; if SCXCV=1, then 1 if appointment was pre-scheduled or 2 if appointment was a walk-in
 Q:SCXCV'=1 SCXCV
 N SCXAP S SCXAP=$G(^DPT(+$P(SCX,U,2),"S",+SCX,0))
 Q:$P(SCXAP,U,20)'=SCXOE SCXCV
 Q:$P(SCXAP,U,7)=4 2
 Q 1
 ;
INIT(SDIV) ;  Build TMP globals for encounter status count
 ;   Ignores any entry beginning with "DOM" or "ZZ"
 ;
 ;   Input:
 ;       SDIV   -  Medical Center Division
 ;
 ;   Variables
 ;       SCXELG  - IEN from ELIGIBILITY CODE File, File #8
 ;       SCXN    - 0 node for ELIGIBILITY CODE IEN
 ;
 N SCXELG,SCXN,LL
 S SCXELG=0
 ;
 F  S SCXELG=$O(^DIC(8,SCXELG)) Q:'SCXELG  D
 . S SCXN=$G(^DIC(8,SCXELG,0))
 . Q:$$CHKELG^SCDXPOV2(SCXELG)
 . I $P($G(^DIC(8,SCXELG,0)),U,5)="N" D
 .. S ^TMP("SCDXPOV",$J,SDIV,"NVELIG",SCXELG)="0^0^0"
 .. S:'$D(^TMP("SCDXPOV",$J,"TOT","NVELIG",SCXELG)) ^TMP("SCDXPOV",$J,"TOT","NVELIG",SCXELG)="0^0^0"
 . I $P($G(^DIC(8,SCXELG,0)),U,5)="Y" D
 .. S ^TMP("SCDXPOV",$J,SDIV,"VELIG",SCXELG)="0^0^0"
 .. S:'$D(^TMP("SCDXPOV",$J,"TOT","VELIG",SCXELG)) ^TMP("SCDXPOV",$J,"TOT","VELIG",SCXELG)="0^0^0"
 ;
 F LL=1:1:3 D
 . S ^TMP("SCDXPOV",$J,SDIV,"COV",LL)="0^0^0"
 . S:'$D(^TMP("SCDXPOV",$J,"TOT","COV",LL)) ^TMP("SCDXPOV",$J,"TOT","COV",LL)="0^0^0"
 ;
 S ^TMP("SCDXPOV",$J,SDIV,"CP")="0^0^0"
 S:'$D(^TMP("SCDXPOV",$J,"TOT","CP")) ^TMP("SCDXPOV",$J,"TOT","CP")="0^0^0"
 Q
