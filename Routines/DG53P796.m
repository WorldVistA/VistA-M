DG53P796 ;ALB/RC - POST-INSTALL DG*5.3*796 ; 11/7/08 2:53pm
 ;;5.3;Registration;**796**;Aug 13, 1993;Build 6
 Q
EN ;Entry Point
 D INIT ;Initialize Variables
 D REPORT ;Run Report
 D CLEANUP ;Run Cleanup
 Q
INIT ;Setup XTMP variable
 K ^XTMP("DG53P796-"_$J)
 S ^XTMP("DG53P796-"_$J,0)=$$FMADD^XLFDT(""_DT_"",30)_U_DT_U_"Data for cleanup for DG*5.3*796" ;Array used to store records that need to be cleaned up.
 Q
REPORT ;Report of data to be cleaned up.
 N RECNUM,DDATE,FDATE,PTDFN
 N DIFROM,XMSUB,XMTEXT,XMY,MSGTXT,LINENUM
 I '$D(^XTMP("DG53P796-"_$J,0)) D INIT ;If called directly
 S XMY(DUZ)="" ;Send message to installer
 S XMSUB="List of records changed by DG*5.3*796"
 S XMTEXT="MSGTXT("
 ;W "DFN",?15,"PTF NUMBER",?30,"DISCHARGE MOVEMENT DATE",!
 ;F I=1:1:53 W "-"
 ;W !
 S LINENUM=1
 S MSGTXT(LINENUM)="The records listed below were cleaned up by DG*5.3*796",LINENUM=LINENUM+1
 S MSGTXT(LINENUM)="",LINENUM=LINENUM+1,MSGTXT(LINENUM)="",LINENUM=LINENUM+1
 S MSGTXT(LINENUM)="DFN            PTF NUMBER     DISCHARGE MVT DATE (501 MVT)",LINENUM=LINENUM+1
 S MSGTXT(LINENUM)="----------------------------------------------------------",LINENUM=LINENUM+1
 S RECNUM=0 ;start after the file header
 F  S RECNUM=$O(^DGPT(RECNUM)) Q:RECNUM'>0  D
 .S DDATE=$$GET1^DIQ(45,$$IENS^DILF(RECNUM),70) ;Discharge Date
 .S FDATE=$$GET1^DIQ(45.02,"1,"_RECNUM,10) ;501 Discharge Date
 .I DDATE'=FDATE,DDATE="" D
 ..S ^XTMP("DG53P796-"_$J,RECNUM)=FDATE ;Store Bad Records
 ..S PTDFN=$$GET1^DIQ(45,$$IENS^DILF(RECNUM),.01,"I")
 ..;W PTDFN,?15,RECNUM,?30,FDATE,!
 ..S MSGTXT(LINENUM)=$E(PTDFN_"               ",1,15)_$E(RECNUM_"               ",1,15)_FDATE
 ..S LINENUM=LINENUM+1
 D ^XMD
 Q
CLEANUP ;Perform clean up of records marked above.
 N RECNUM,DGFDA,I,TXTLINE,ERRFND
 N DIFROM,XMSUB,XMTEXT,XMY,MSGTXT,LINENUM
 S XMSUB="Errors encountered during post-install of DG*5.3*796"
 S XMY(DUZ)=""
 S XMTEXT="MSGTXT("
 S LINENUM=1
 S MSGTXT(LINENUM)="The following errors were encountered while running the post-install routine in DG*5.3*796"
 S MSGTXT(LINENUM)="",LINENUM=LINENUM+1,MSGTXT(LINENUM)="",LINENUM=LINENUM+1
 I '$D(^XTMP("DG53P796-"_$J,0)) D REPORT ;If called directly
 S RECNUM=0,DGFDA="",DGMSG="" ;Start at the first record. 
 F  S RECNUM=$O(^XTMP("DG53P796-"_$J,RECNUM)) Q:'RECNUM  D
 .S DGFDA(45.02,"1,"_$$IENS^DILF(RECNUM),10)="@" D FILE^DIE("","DGFDA")
 .I $D(DIERR) D  ;if we encounter an error, record it.
 ..S ERRFND=1 ;we encountered an error
 ..S MSGTXT(LINENUM)="The following errors were encountered with PTF record "_RECNUM_".",LINENUM=LINENUM+1
 ..F I=1:1:DIERR D
 ...S MSGTXT(LINENUM)="Error Number: "_^TMP("DIERR",$J,I),LINENUM=LINENUM+1
 ...S TXTLINE=""
 ...F  S TXTLINE=$O(^TMP("DIERR",$J,I,"TEXT",TXTLINE)) Q:'TXTLINE  D
 ....S MSGTXT(LINENUM)=^TMP("DIERR",$J,I,"TEXT",TXTLINE),LINENUM=LINENUM+1
 .K DGFDA ;Cleanup data
 I $G(ERRFND) D ^XMD ;only send if an error occurred.  
 Q
