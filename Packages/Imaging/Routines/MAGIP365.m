MAGIP365 ;HIE/ZEB - MAG*3.0*365 post-install routine ; 11 JUL 2024@13:06
 ;;3.0;IMAGING;**365**;July 11, 2024;Build 19
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
POST ;post-install actions for MAG*3.0*365
 ;register protocols
 D ADD^XPDPROT("OR EVSEND RA","MAG PRECACHE ORDER SIGNED")
 D ADD^XPDPROT("RA EVSEND OR","MAG PRECACHE ORDER SIGNED")
 ;configure MAGCACHECFG mail group to invoke MAG CACHE SETTINGS UPDATE option
 N DO,DD,DA,DLAYGO,DIC,X,RCSITE,RUNDT,ENDT,MNTHFRST,MNTHLAST
 S RCSITE=$G(^XMB("NETNAME"))  Q:RCSITE=""  ;SITE DOMAIN NAME
 S X="S.MAG CACHE SETTINGS UPDATE@"_RCSITE ;SERVER NAME WITH SITE DOMAIN NAME
 S DA(1)=$O(^XMB(3.8,"B","MAGCACHECFG",0)) ;MAIL GROUP IEN
 I $D(^XMB(3.8,DA(1),6,"B",$E(X,1,30))) Q  ;abort if mail address already present
 S DLAYGO=3.812,DIC(0)="L",DIC="^XMB(3.8,"_DA(1)_",6,"
 D FILE^DICN ;
 D RPCS
 ;rerun Imaging Site Utilitzation report extract that would have run from 1/1/26 to the beginning of the current month
 D RESTASK^MAGQE4
 S RUNDT=3260101
 S ENDT=$$DT^XLFDT()
 S $E(ENDT,6,7)="01" ;go back to first day of month
 F  D  S RUNDT=$$FMADD2(RUNDT,,1) Q:$$FMDIFF^XLFDT(ENDT,RUNDT,1)<0
 . D PREVMNTH(RUNDT,.MNTHFRST,.MNTHLAST)
 . D AHISU^MAGQE2(MNTHFRST,MNTHLAST)
 Q
BACKOUT ;restore (backout) actions for MAG*3.0*365
 ;unregister protocols
 D DELETE^XPDPROT("OR EVSEND RA","MAG PRECACHE ORDER SIGNED")
 D DELETE^XPDPROT("RA EVSEND OR","MAG PRECACHE ORDER SIGNED")
 Q
RPCS ;register RPCs in OR CPRS GUI CHART
 N RPC,I,D0,DIC,DA,X
 S RPC(0)=6
 S RPC(1)=$O(^XWB(8994,"B","VAFCTFU GET TREATING LIST",""))
 S RPC(2)=$O(^XWB(8994,"B","VAFCTFU CONVERT DFN TO ICN",""))
 S RPC(3)=$O(^XWB(8994,"B","VAFC LOCAL GETCORRESPONDINGIDS",""))
 S RPC(4)=$O(^XWB(8994,"B","ORRCQLPT PTDEMOS",""))
 S RPC(5)=$O(^XWB(8994,"B","DDR FILER",""))
 S RPC(6)=$O(^XWB(8994,"B","DSIC DPT GET ICN",""))
 ;find IEN for OR CPRS GUI CHART
 S D0=$O(^DIC(19,"B","OR CPRS GUI CHART",""))
 Q:D0=""  ;abort iff OR CPRS GUI CHART doesn't exist
 ;add RPCS to context
 F I=1:1:RPC(0) D
 . Q:RPC(I)=""  ;abort if RPC doesn't exist
 . Q:$O(^DIC(19,D0,"RPC","B",RPC(I),""))]""  ;abort if RPC in context already
 . S DIC="^DIC(19,"_D0_",""RPC"","
 . S DIC(0)="FL"
 . S DA(1)=D0
 . S X=RPC(I)
 . K DO
 . D FILE^DICN
 Q
FMADD2(INDT,YEARS,MONTHS,DAYS,HOURS,MINS,SECS) ;manipulate a FileMan D/T
 Q:$G(INDT)="" -1 ;INDT (REQ) - FileMan format D/T to manipulate
 S YEARS=$G(YEARS,0) ;YEARS (OPT) - number of years to add (or subtract if negative)
 S MONTHS=$G(MONTHS,0) ;MONTHS (OPT) - number of months to add (or subtract if negative)
 S DAYS=$G(DAYS,0) ;DAYS (OPT) - number of days to add (or subtract if negative)
 S HOURS=$G(HOURS,0) ;HOURS (OPT) - number of hours to add (or subtract if negative)
 S MINS=$G(MINS,0) ;MINS (OPT) - number of minutes to add (or subtract if negative)
 S SECS=$G(SECS,0) ;SECS (OPT) - number of seconds to add (or subtract if negative)
 Q:(INDT<1410102)!(INDT>4141015.235959) -1 ;invalid FileMan DT
 N DTCENTURY,DTYEAR,DTMONTH,OUTDT
 ;do year and month operations that aren't supported by FMADD^XLFDT
 S DTCENTURY=$E(INDT,1,1)
 S DTYEAR=$E(INDT,2,3)
 S DTMONTH=$E(INDT,4,5)
 S DTMONTH=DTMONTH+MONTHS
 I DTMONTH<1 D
 . S YEARS=YEARS-1
 . S DTMONTH=12+DTMONTH
 I DTMONTH>12 D
 . S YEARS=YEARS+1
 . S DTMONTH=DTMONTH-12
 S DTYEAR=DTYEAR+YEARS
 I DTYEAR<1 D
 . S DTCENTURY=DTCENTURY-1
 . S DTYEAR=100+DTYEAR
 I DTYEAR>99 D
 . S DTCENTURY=DTCENTURY+1
 . S DTYEAR=DTYEAR-100
 ;reassemble the date and proceed to existing code
 S OUTDT=DTCENTURY_$$RJ^XLFSTR(DTYEAR,2,"0")_$$RJ^XLFSTR(DTMONTH,2,"0")_$E(INDT,6,7)
 S:INDT["." OUTDT=OUTDT_"."_$P(INDT,".",2)
 Q $$FMADD^XLFDT(OUTDT,DAYS,HOURS,MINS,SECS)
PREVMNTH(INDT,FIRST,LAST) ;get first and last days of previous month
 I $G(INDT)="" S (FIRST,LAST)=-1 Q  ;INDT (REQ) - FileMan format D/T to get dates from previous month
 ;FIRST (OUT) - FileMan format D/T of first of previous month
 ;LAST (OUT) - FileMan format D/T of last of previous month
 N TMPDT
 S TMPDT=INDT
 S $E(TMPDT,6,7)="01"
 S LAST=$$FMADD^XLFDT(TMPDT,-1)
 S FIRST=LAST
 S $E(FIRST,6,7)="01"
 Q
