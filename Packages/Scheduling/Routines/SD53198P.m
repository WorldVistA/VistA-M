SD53198P ;BP-CIOFO/NDH - POST INSTALL SD*5.3*198 ; 20 Aug 99  09:00 AM
 ;;5.3;Scheduling;**198**;Aug 13 1993
 ;
SEED ;Seed NPCD ENCOUNTER MONTH multiple (#404.9171) of the SCHEDULING
 ; PARAMETER file (#404.91) with workload close-out dates for FY2000
 ;
 ;Declare variables
 N XPDIDTOT,LINE,DATES,WLMONTH,DBCLOSE,WLCLOSE,TMP
 ;Print header
 D BMES^XPDUTL(">>> Storing revised close-out dates for Fiscal Year 1999")
 S TMP=$$INSERT^SCDXUTL1("Workload","",7)
 S TMP=$$INSERT^SCDXUTL1("Database",TMP,27)
 S TMP=$$INSERT^SCDXUTL1("Workload",TMP,47)
 D BMES^XPDUTL(TMP)
 S TMP=$$INSERT^SCDXUTL1("Occured In","",6)
 S TMP=$$INSERT^SCDXUTL1("Close-Out",TMP,27)
 S TMP=$$INSERT^SCDXUTL1("Close-Out",TMP,47)
 D MES^XPDUTL(TMP)
 S TMP=$$INSERT^SCDXUTL1("------------","",5)
 S TMP=$$INSERT^SCDXUTL1("------------",TMP,25)
 S TMP=$$INSERT^SCDXUTL1("------------",TMP,45)
 D MES^XPDUTL(TMP)
 ;Loop through list of dates
 S XPDIDTOT=6
 F LINE=2:1:7 S TMP=$T(FY99+LINE),DATES=$P(TMP,";",3) Q:(DATES="")  D
 .;Break out info
 .S WLMONTH=$P(DATES,"^",1)
 .S DBCLOSE=$P(DATES,"^",2)
 .S WLCLOSE=$P(DATES,"^",3)
 .;Print close-out info
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(WLMONTH,"1D"),"",7)
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(DBCLOSE,"1D"),TMP,25)
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(WLCLOSE,"1D"),TMP,45)
 .D MES^XPDUTL(TMP)
 .;Store close-out info
 .S TMP=$$AECLOSE^SCDXFU04(WLMONTH,DBCLOSE,WLCLOSE)
 .;Write error message if datebase or workload dates not updated
 .I TMP<0 D MES^XPDUTL("       >>>>Could not update closeout dates for above month.")
 .;If KIDS install, show progress through status bar
 .D:($G(XPDNM)'="") UPDATE^XPDID(LINE-1)
 D BMES^XPDUTL("")
 ;Print header
 D BMES^XPDUTL(">>> Storing close-out dates for Fiscal Year 2000")
 S TMP=$$INSERT^SCDXUTL1("Workload","",7)
 S TMP=$$INSERT^SCDXUTL1("Database",TMP,27)
 S TMP=$$INSERT^SCDXUTL1("Workload",TMP,47)
 D BMES^XPDUTL(TMP)
 S TMP=$$INSERT^SCDXUTL1("Occured In","",6)
 S TMP=$$INSERT^SCDXUTL1("Close-Out",TMP,27)
 S TMP=$$INSERT^SCDXUTL1("Close-Out",TMP,47)
 D MES^XPDUTL(TMP)
 S TMP=$$INSERT^SCDXUTL1("------------","",5)
 S TMP=$$INSERT^SCDXUTL1("------------",TMP,25)
 S TMP=$$INSERT^SCDXUTL1("------------",TMP,45)
 D MES^XPDUTL(TMP)
 ;Loop through list of dates
 S XPDIDTOT=12
 F LINE=2:1:13 S TMP=$T(FY00+LINE),DATES=$P(TMP,";",3) Q:(DATES="")  D
 .;Break out info
 .S WLMONTH=$P(DATES,"^",1)
 .S DBCLOSE=$P(DATES,"^",2)
 .S WLCLOSE=$P(DATES,"^",3)
 .;Print close-out info
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(WLMONTH,"1D"),"",7)
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(DBCLOSE,"1D"),TMP,25)
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(WLCLOSE,"1D"),TMP,45)
 .D MES^XPDUTL(TMP)
 .;Store close-out info
 .S TMP=$$AECLOSE^SCDXFU04(WLMONTH,DBCLOSE,WLCLOSE)
 .;Write error message if datebase or workload dates not updated
 .I TMP<0 D MES^XPDUTL("       >>>>Could not update closeout dates for above month.")
 .;If KIDS install, show progress through status bar
 .D:($G(XPDNM)'="") UPDATE^XPDID(LINE-1)
 D BMES^XPDUTL("")
 Q
 ;
FY99 ;Revised Close-out dates for fiscal year 2000
 ;  Month ^ Database Close-Out ^ Workload Close-Out
 ;;2981000^2991015^2981106
 ;;2981100^2991015^2981211
 ;;2981200^2991015^2990108
 ;;2990100^2991015^2990212
 ;;2990200^2991015^2990312
 ;;2990300^2991015^2990409
 ;
FY00 ;Revised Close-out dates for fiscal year 2000
 ;  Month ^ Database Close-Out ^ Workload Close-Out
 ;;2991000^3000414^2991112
 ;;2991100^3000414^2991210
 ;;2991200^3000414^3000107
 ;;3000100^3000414^3000211
 ;;3000200^3000414^3000310
 ;;3000300^3000414^3000407
 ;;3000400^3001013^3000512
 ;;3000500^3001013^3000609
 ;;3000600^3001013^3000707
 ;;3000700^3001013^3000811
 ;;3000800^3001013^3000908
 ;;3000900^3001013^3001006
 ;
 Q  ; End Part One - 
 ; Mark unsent FY1999 Q1 & Q2 NPCDB activity for transmission
EN I DT>2991015 W !!,$C(7),"It is too late to run this utility!" Q
 S SDSTAT=$O(^SD(409.63,"B","CHECKED OUT",0)) I 'SDSTAT W !!,"CHECKED OUT encounter status could not be identified!" K SDSTAT Q
 N ZTSAVE S ZTSAVE("SDSTAT")="",ZTSAVE("SDFORCE")=""
 W ! D EN^XUTMDEVQ("START^SD53198P","Re-flag NPCDB activity",.ZTSAVE) Q
 ;
START ;Search for activity to re-flag for transmission
 K ^TMP("SD198",$J)
 S SDLINE="",$P(SDLINE,"-",(IOM+1))=""
 S SDTIT="<*>  RE-FLAG UNSENT FY1999 Q1 & Q2 NPCDB ACTIVITY FOR TRANSMISSION  <*>"
 S SDPAGE=1 D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=Y
 S SDDT=2981000
 F  S SDDT=$O(^SCE("B",SDDT)) Q:'SDDT!(SDDT>2990399)  S SDOE=0 F  S SDOE=$O(^SCE("B",SDDT,SDOE)) Q:'SDOE  D
 .S SDOE0=$G(^SCE(SDOE,0)) Q:'$L(SDOE0)
 .I $P(SDOE0,U),$P(SDOE0,U,2),$P(SDOE0,U,4),$P(SDOE0,U,12)=SDSTAT,'$P(SDOE0,U,6),"2^3^6"[$P($$STX^SCRPW8(SDOE,SDOE0),U) D
 ..S ^TMP("SD198",$J,SDOE)=SDOE0
 ..Q
 .Q
 S (SDOE,SDCT)=0 F  S SDOE=$O(^TMP("SD198",$J,SDOE)) Q:'SDOE  S SDCT=SDCT+1
 ;
 ;Too many to send!
 I '$G(SDFORCE),SDCT>3000 D  G EXIT
 .D HDR N C S C=(IOM-80\2) S:C<0 C=0
 .W !!?(C),"This process found ",SDCT," encounters that appear not to have been",!?(C),"transmitted.  This may be due to transmission data being purgedat this site"
 .W !?(C),"through the use of the 'Purge Ambulatory Care Reporting files' [SCDX AMBCAR",!?(C),"PURGE ACRP FILES] option.",!!?(C),"If the purge has beenperformed for this date range, there is no way to"
 .W !?(C),"identify encounters that were not transmitted due to the workload closeout",!?(C),"date.",!!?(C),"If this count exceeds 3000 and you do notbelieve that the purge has been"
 .W !?(C),"performed at your site, please contact National VistA Support (NVS) for",!?(C),"assistance in retransmitting the encounters at your site."
 .Q
 ;
 ;Re-flag encounters for transmission
 S SDOE=0 F  S SDOE=$O(^TMP("SD198",$J,SDOE)) Q:'SDOE  D
 .S SDDT=+^TMP("SD198",$J,SDOE)
 .S SDXP=$$CRTXMIT^SCDXFU01(SDOE,,SDDT)
 .Q:SDXP'>0
 .D STREEVNT^SCDXFU01(SDXP,0)
 .D XMITFLAG^SCDXFU01(SDXP,0)
 .Q
 ;
 ;Report the results
 D HDR S SDTIT1="This process re-flagged "_SDCT_" encounter"_$S(SDCT=1:"",1:"s")_" for transmission." W !!?(IOM-$L(SDTIT1)\2),SDTIT1
 ;
EXIT K %,%H,%I,SDCT,SDDT,SDFORCE,SDLINE,SDOE,SDOE0,SDPAGE,SDPNOW,SDSTAT,SDTIT,SDTIT1,SDXP,X,Y,^TMP("SD198",$J) Q
 ;
FORCE ;Force the reflagging of all applicable encounters
 ;
 ;  CAUTION!!!  Do not use this entry point unless you are SURE that
 ;              the site has not purged transmission data for this
 ;              date range!
 ;
 S SDFORCE=1 G EN
 ;
HDR ;Print report header
 W:SDPAGE>1 @IOF
 W SDLINE,!?(IOM-$L(SDTIT)\2),SDTIT,!,SDLINE,!,"Date printed:",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1 Q
