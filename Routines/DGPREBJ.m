DGPREBJ ;Boise/WRL/ALB/SCK/EG-PreRegistration Night Task Job ; 1/20/05 1:08pm
 ;;5.3;Registration;**109,581,568,585**;Aug 13, 1993
 Q
 ;
EN ;  Main entry point for the Pre-Registration Background Job.
 ;  Variables
 ;     DGPTOD  -  Current date
 ;     DGPNL   -  Message line count for mail message 
 ;     DGPFNC  -  Job function
 ;     DGPNDAY -  Number of days to keep entries in the call list
 ;     DGPTXT  -  Message array
 ;     DGPDT   -  Last date to keep entries in call list for, uses DGPNDAY
 ;     DGPN1-2 -  Temporary Var's for $ORDER
 ;     DGPCLD  -  Count of call log entries purged 
 ;
 N DGPTXT,DGPTOD,DGPFNC,DGPNL,DGPCLD,DGPDT,DGPN1,DGPN2,DGPNDAY
 ;
 S DGPTOD=$$DT^XLFDT()
 ;
 S DGPNL=1
 ;
 S DGPFNC=$P($G(^DG(43,1,"DGPRE")),U,3)
 I DGPFNC']""!(DGPFNC="N") D MES("MES1") G EXIT
 ;
 ; Get Appointment Information
 D SDAMAPI^DGPREBJ1(0)
 ;
 ; Check for Appointment Database Availability
 ;if there is no lower level data from the 101 subscript, then it is
 ;an error, otherwise it could be a valid patient or clinic
 ;eg 01/20/2005
 I $D(^TMP($J,"SDAMA301")) I $D(^TMP($J,"SDAMA301",101))=1 D SETTEXT^DGPREBJ("SDAMAPI - Appointment Database is Unavailable."),SETTEXT^DGPREBJ("Unable to update Call List."),SEND K ^TMP($J,"SDAMA301") Q
 ;
 ; DG/581 - delete certain entries in DGS(41.42
 N DGTDAY,DGIEN,DGOLD,DGZERO,DGDFN,DGAPDT,DGKFLAG,DGCLN,DGSTAT
 D NOW^%DTC S DGTDAY=%
 S (DGIEN,DGOLD)=0
 F  S DGIEN=$O(^DGS(41.42,DGIEN)) Q:'DGIEN  D
 .S DGZERO=$G(^DGS(41.42,DGIEN,0)) Q:DGZERO=""
 .S DGDFN=$P(DGZERO,U),DGAPDT=$P(DGZERO,U,8),DGCLN=$P(DGZERO,U,7)
 .Q:('DGDFN)!('DGAPDT)
 .S DGKFLAG=0
 .; delete if appt date less than NOW
 .I DGAPDT<DGTDAY S DGKFLAG=1
 .; check status of appt - delete if no-show, cancelled...
 .S DGSTAT=$P($P($G(^TMP($J,"SDAMA301",DGCLN,DGDFN,DGAPDT)),U,3),";")
 .I DGSTAT'="",DGSTAT'="R" S DGKFLAG=1
 .I DGKFLAG S DIK="^DGS(41.42,",DA=DGIEN D ^DIK K DIK S DGOLD=DGOLD+1
 D SETTEXT("Number of old or cancelled records deleted from the Call List: "_DGOLD)
 D SETTEXT("")
 ;
 I DGPFNC="D" D KILLALL
 I DGPFNC="P" D PURGECP
 I DGPFNC="DA" D KILLALL,ADDNEW^DGPREBJ1(0,DGPDT)
 I DGPFNC="PA" D ADDNEW^DGPREBJ1(0,DGPDT),PURGECP
 I DGPFNC="AO" D ADDNEW^DGPREBJ1(0,DGPDT)
 ;
 ; Purge call log entries beyond Days to Keep limit
 S DGPNDAY=$P($G(^DG(43,1,"DGPRE")),U,4)
 G:DGPNDAY']"" EXIT
 ;
 D SETTEXT("Running: Purge Call Log.")
 ;
 S DGPDT=$$FMADD^XLFDT(DGPTOD,-DGPNDAY)
 S DGPCLD=0
 S DGPN1=0 F  S DGPN1=$O(^DGS(41.43,"B",DGPN1)) Q:'DGPN1!(DGPN1>DGPDT)  D
 . S DGPN2=0 F  S DGPN2=$O(^DGS(41.43,"B",DGPN1,DGPN2)) Q:'DGPN2  D
 .. S DGPCLD=DGPCLD+1
 .. S DIK="^DGS(41.43,"
 .. S DA=DGPN2
 .. D ^DIK K DIC
 ;
 D SETTEXT("Number of Entries Deleted From Call History: "_DGPCLD)
 D SETTEXT(" ")
 ;
EXIT ;
 D SEND
 Q
 ;
SEND ;  Send notification of actions taken to mailgroup
 S XMY("G.DGPRE PRE-REG STAFF")=""
 S XMDUZ=$S($G(DUZ)>0:DUZ,1:.5)
 S XMTEXT="DGPTXT("
 S XMSUB="PRE-REGISTRATION NIGHTLY JOB REPORT"
 D XMZ^XMA2
 D:XMZ>0 ^XMD
 K XMY,XMDUZ,XMTEXT,XMSUB
 Q
 ;
SETTEXT(DGLINE) ;  Add text line to message array
 S DGPTXT(DGPNL)=DGLINE
 S DGPNL=DGPNL+1
 Q
 ;
PURGECP ;  Purge called patients from the Pre-registration call list
 ;  Variables
 ;     DGPDEL - Counter of records deleted
 ;
 N DGPDEL
 S DGPDEL=0
 ;
 D PRGLST^DGPREP4(0,.DGPDEL)
 ;
 D SETTEXT(DGPDEL_" Called Patients Purged.")
 D SETTEXT(" ")
 Q
 ;
KILLALL ;  Clear all entries from the pre-registration call list.
 ;   Variables
 ;    DGPTOT  - Counter if entries deleted
 ;
 N DGPTOT
 S DGPTOT=0
 ;
 D CLRLST^DGPREP4(0,.DGPTOT)
 ;
 D SETTEXT(DGPTOT_" Entries Deleted from the Call List.")
 D SETTEXT(" ")
 Q
 ;
MES(TAG) ; Build message for missing parameters
 N DGMES,I
 ;
 F I=1:1 S DGMES=$P($T(@TAG+I),";;",2,99) Q:DGMES="$$END"  D SETTEXT(DGMES)
 D SETTEXT(" ")
 Q
 ;
MES1 ; 
 ;;There is either no entry or a 'No Action' entry in the 'CALL LIST NIGHT JOB
 ;;FUNCTION' field in the site parameter file. No action will be taken on the
 ;;Call List.
 ;;$$END
