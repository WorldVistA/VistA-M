YSGAFUTL ;DALCIOFO/MJD-GAF CLEANUP UTILITY ROUTINE ;02/17/99
 ;;5.01;MENTAL HEALTH;**49**;Dec 30, 1994
 ;
 ;This routine will perform the following:
 ;
 ;1) Identify the DIAGNOSTIC RESULTS - MENTAL HEALTH file (#627.8)
 ;records that contain no AXIS 5 (#65) data or DIAGNOSIS BY (#.04)
 ;data after the installation of patch YS*5.01*43.  Only records with
 ;a DATE/TIME OF DIAGNOSIS field (#.04) containing a fiscal year 1998
 ;or fiscal year 1999 date will be reviewed.
 ;2) Delete these records if they contain no other related data.
 ;3) Create a MAILMAN message that summarizes the status of the records.
 ;4) Verify that the PATIENT TYPE (#66) is correct by
 ;calling IN5^VADPT.  If the patient type is incorrect, the routine
 ;updates the field with the correct type (In-patient or Out-patient). 
 ;
 ;NOTE: PLEASE EXECUTE THIS ROUTINE BY CALLING LINE TAG "START^YSGAFUTL"
 ;
 Q
START ;Set up task
 ;
 I '$D(DUZ) D  Q
 .W !!,$C(7),"ERROR:  DUZ is not defined.  Use ^XUP or ask your "
 .W !,"IRM why you don't have a DUZ variable defined.",!!
 .D CLNUP
 S YSGFDATE="",YSSTD=2971001,YSSPD=2990930
 S ZTRTN="EN^YSGAFUTL"
 ;
 ;VARIABLES TO BE SAVED IN ZTSAVE
 S ZTSAVE("*")=""
 S ZTDESC="MENTAL HEALTH - YS GAF UTILITY"
 S ZTIO=""
 D ^%ZTLOAD
 I '$D(ZTSK) QUIT  ;-->
 W !!,"The Mental Health GAF Utility has been Tasked, job# ",ZTSK,"...",!
 Q
 ;
EN ; Main subroutine
 I $D(ZTQUEUED) S ZTREQ="@" K ZTSK
 K ^TMP("YSGAFUTL",$J),^TMP("YSGMM",$J)
 ; Date range will be from 10-01-97 to TODAY
 S:$G(U)="" U="^"
 S YSAOF=""
 S (YSIEN,YSPIEN,YSPATID,YSAPATID,YSADT,YSPTC,YSDDC,YSPTO,YSERC)=0
 S (YSTOT,YSGDC,YSNMC,YSDEL)=0
 F YSI="FY98","FY99" D
 .F YSJ="I","O" S YSTOT(YSI,YSJ)=0
 F  S YSIEN=$O(^YSD(627.8,YSIEN)) Q:YSIEN=""!('YSIEN)  D
 .S YSO=$G(^YSD(627.8,YSIEN,0)),YSYEAR="FY99"
 .S YSPATID=$P(YSO,U,2)   ; Patient ID
 .S YSGAFDT=$P(YSO,U,3)   ; Date/time of diagnosis
 .S MDFLG=0
 .I YSGAFDT="" D  Q       ; Count the number of records missing
 ..S MDFLG=1              ; the date/time of diagnosis and delete
 ..D DELCHK               ; if no other data is found.
 ..S YSDDC=YSDDC+1        ; Count both deleted/non-deleted in YSDDC
 .S YSGFDATE=$P($P(YSO,U,3),".",1)
 .I (YSGFDATE>(YSSTD-1))&(YSGFDATE<(YSSPD+1)) D
 ..S YSTOT=YSTOT+1    ; Count total records found in this date range
 ..S:YSGFDATE<2981001 YSYEAR="FY98"
 ..S YSTOT(YSYEAR)=$G(YSTOT(YSYEAR))+1
 ..S YSP=$G(^YSD(627.8,YSIEN,60)),YSPATYPE=$P(YSP,U,4)
 ..; Re-evaulate patient type indicator (In/Out patient)
 ..S DFN=YSPATID
 ..S VAIP("D")=YSGAFDT
 ..D IN5^VADPT
 ..S YSSTAT=$S(VAIP(1):"I",1:"O")
 ..; If patient types don't match, update the record
 ..I YSPATYPE'=YSSTAT D
 ...S YSPATYPE=YSSTAT
 ...S YSPTC=YSPTC+1
 ...S DIE="^YSD(627.8,",DA=YSIEN
 ...S DR="66////"_YSSTAT
 ...L +^YSD(627.8,DA):0
 ...D ^DIE
 ...L -^YSD(627.8,DA)
 ..S YSTOT(YSYEAR,YSPATYPE)=$G(YSTOT(YSYEAR,YSPATYPE))+1
 ..; Check for missing data (GAF or Provider)
 ..S YSAX5=$P(YSP,U,3),YSPROV=$P(YSO,U,4)
 ..I YSAX5=""!(YSPROV="") D
 ...; Verify that record is not entered in error
 ...S YSEFLG=0
 ...I $D(^YSD(627.8,YSIEN,80)) D
 ....S YSERN=0
 ....F  S YSERN=$O(^YSD(627.8,YSIEN,80,YSERN)) Q:YSERN'>0!(YSEFLG)  D
 .....I $G(^YSD(627.8,YSIEN,80,YSERN,0))["Error" S YSEFLG=1 Q
 ...I YSEFLG S YSERC=YSERC+1 Q
 ...; If outpatient, update totals and quit
 ...I YSPATYPE="O" D  Q
 ....D DELCHK  Q:FLGDEL
 ....S YSPTO=YSPTO+1
 ...D DELCHK  Q:FLGDEL
 ...S YSNMC=YSNMC+1 ; Inpatient
 ..E  S YSGDC=YSGDC+1   ; Currently contains both GAF and Provider
 D DELREC,TOTREP
 D MAILIT,CLNUP
 Q
DELREC ; Delete records
 Q:'$D(^TMP("YSGAFUTL",$J))
 S DIK="^YSD(627.8,",DA=""
 F  S DA=$O(^TMP("YSGAFUTL",$J,DA)) Q:DA=""  D ^DIK
 Q
TOTREP ;Write totals to ^TMP
 S YSLN=0
 S YSSUBT=YSGDC+YSERC+YSPTO+YSNMC+YSDEL
 S XTMP="GAF CLEANUP UTILITY TOTALS" D YSLN,SPC
 S XTMP="Total GAF Records:" D YSLN,SPC
 F YSI="FY98","FY99" D
 .F YSJ="I","O" D
 ..S XTMP=$J(+$G(YSTOT(YSI,YSJ)),8)_"  "
 ..S XTMP=XTMP_$S(YSJ="I":"In",1:"Out")_"-patient" D YSLN
 .D DSH
 .S XTMP=$J(+$G(YSTOT(YSI)),8)_"  Total "_YSI_" GAF Records" D YSLN,DSH
 S XTMP=$J(YSTOT,8)_"  Total GAF Records for Fiscal Years 98 and 99"
 D YSLN
 F YSI=1:1:2 D DSH
 D SPC
 S XTMP="GAF Record Summary:" D YSLN,SPC
 S XTMP=$J(YSGDC,8)_"  Record(s) currently contain Provider "
 S XTMP=XTMP_"and GAF data" D YSLN
 S XTMP=$J(YSERC,8)_"  Record(s) entered in error" D YSLN
 S XTMP=$J(YSPTO,8)_"  Outpatient record(s) missing data" D YSLN
 S XTMP=$J(YSNMC,8)_"  Inpatient record(s) missing data" D YSLN
 S XTMP=$J(YSDEL,8)_"  Record(s) deleted due to incomplete data"
 D YSLN,DSH
 S XTMP=$J(YSSUBT,8)_"  Total GAF Records"
 D YSLN,DSH,DSH,SPC
 S XTMP=$J((YSTOT-YSSUBT),8)_"  Difference" D YSLN,SPC
 I YSPTC D
 .S XTMP="The PATIENT TYPE field (#66) was updated for "_YSPTC
 .S XTMP=XTMP_" GAF record(s)." D YSLN
 I YSDDC D
 .S XTMP="DATE/TIME OF DIAGNOSIS field (#.04) was missing for "_YSDDC
 .S XTMP=XTMP_" GAF record(s)." D YSLN
 Q
SPC ;
 S XTMP=" " D YSLN
 Q
DSH ;
 S XTMP="--------" D YSLN
 Q
MAILIT ; Mail totals
 S DTIME=600
 S XMSUB="GAF Cleanup Utility"
 S XMTEXT="^TMP(""YSGMM"",$J,"
 S XMY(DUZ)=""
 S XMY("YOUNG,TIM@ISC-DALLAS.VA.GOV")=""
 S XMY("DEVLIN,MARK@ISC-DALLAS.VA.GOV")=""
 S XMDUZ="AUTOMATED MESSAGE"
 D ^XMD
 Q
YSLN ;Store to ^TMP for MAILMAN message
 S YSLN=YSLN+1
 S ^TMP("YSGMM",$J,YSLN)=XTMP
 Q
DELCHK ;Check records and flag for deletion if necessary
 S (FLGDEL,FLGDATA)=0
 F I=1,5,80 D  Q:FLGDATA
 .S:$D(^YSD(627.8,YSIEN,I)) FLGDATA=1
 I $D(^YSD(627.8,YSIEN,60)) D  Q:FLGDATA
 .I $P(^YSD(627.8,YSIEN,60),"^")'="" S FLGDATA=1 Q
 .I $P(^YSD(627.8,YSIEN,60),"^",2)'="" S FLGDATA=1
 ;No data was found so flag it for deletion and update counter
 S ^TMP("YSGAFUTL",$J,YSIEN)="",FLGDEL=1
 S:'MDFLG YSDEL=YSDEL+1
 Q
CLNUP ;Clean up variables
 K X,Y,YSADT,YSAOF,YSAPATID,YSGAFDT
 K YSGFDATE,YSIEN,YSO,YSPATID,YSPIEN,YSO,YSSPD,YSSTD,XTMP,VAIP
 K YSAX5,YSDDC,YSDEL,YSEFLG,YSERC,YSERN,YSGDC,YSLN,YSNMC,YSP,YSSUBT
 K YSPATYPE,YSPROV,YSPTC,YSPTO,YSSTAT,YSTOT
 K YSYEAR,YSI,YSJ,XMDUZ,XCNP,XMZ,VAERR,FLGDATA,FLGDEL,DFN
 K MDFLG,^TMP("YSGAFUTL",$J),^TMP("YSGMM",$J)
 Q
