RG1P55 ;ALB/MJB - POST-INSTALL RG*1*55 ; 11/7/08 2:53pm
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**55**;30 Apr 99;Build 11
 Q
EN ;Entry Point
 D INIT ;Initialize Variables
 D REPORT ;Run Report
 Q
INIT ;Setup XTMP variable
 K ^XTMP("RG1P55-"_$J)
 S ^XTMP("RG1P55-"_$J,0)=$$FMADD^XLFDT(""_DT_"",30)_U_DT_U_"Data for report for RG*1*55" ;Array used to store records that need to be reported.
 Q
REPORT ;Report of data to be cleaned up.
 N RECNUM,RGDFN,RGPHN
 N DIFROM,XMSUB,XMTEXT,XMY,MSGTXT,LINENUM
 I '$D(^XTMP("RG1P55-"_$J,0)) D INIT ;If called directly
 S XMY(DUZ)="" ;Send message to installer
 S XMSUB="List of records with invalid phone numbers"
 S XMTEXT="MSGTXT("
 ;W "DFN",?15,"PHONE NUMBER",?30,!
 ;F I=1:1:53 W "-"
 ;W !
 S LINENUM=1
 S MSGTXT(LINENUM)="The records listed below have invalid phone numbers",LINENUM=LINENUM+1
 S MSGTXT(LINENUM)="",LINENUM=LINENUM+1,MSGTXT(LINENUM)="",LINENUM=LINENUM+1
 S MSGTXT(LINENUM)="DFN            PHONE NUMBER                               ",LINENUM=LINENUM+1
 S MSGTXT(LINENUM)="----------------------------------------------------------",LINENUM=LINENUM+1
 S RECNUM=0 ;start after the file header
 F  S RECNUM=$O(^DPT(RECNUM)) Q:RECNUM'>0  D
 .S RGDFN=RECNUM
 .S RGPHN=$G(^DPT(RECNUM,.13)) Q:RGPHN'["~PH"  D
 ..S ^XTMP("RG1P55-"_$J,RECNUM)=RGPHN ;Store Bad Records
 ..;W PTDFN,?15,RECNUM,?30,FDATE,!
 ..S MSGTXT(LINENUM)=$E(RGDFN_"               ",1,15)_RGPHN
 ..S LINENUM=LINENUM+1
 D ^XMD
 Q
