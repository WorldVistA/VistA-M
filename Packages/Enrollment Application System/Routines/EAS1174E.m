EAS1174E ;ALB/HM - ENVIRONMENT CHECK FOR PATCH EAS*1.0*174 FILE 714.1 HAS <13 OR >13 ENTRIES IN IT ;15-DEC-1997
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**174**;Aug 13, 1993;Build 26
 ;
 ;
EN ; This routine contains environmental checks which get executed
 ; before the EAS*1.0*174 is allowed to run.
 ;
 ;  Input: Variables set by KIDS during environment check
 ;
 ; Output:  XPDABORT - KIDS variable set to abort installation
 ;
 I 'XPDENV D CHK Q  ; Loading Distribution
 ;
START ; Starting here
 W !!,">>> Beginning the Environment Checker"
 ;
 D CHK ;  check for patches that will be backed out that they are installed here
 ;
 I $D(XPDABORT) W !!,">>> EAS*1.0*174 Aborted in Environment Checker" Q
 W !!,">>> Environment Checker Successful",!!
 Q
 ;
 ;
CHK ; Check for correct number of file entries in LTC CO-PAY EXEMPTION file (#714.1).
 W !,"*****"
 W !,"Checking for entries in LTC CO-PAY EXEMPTION file (#714.1)."
 N EASINST,EASCNT,ERROR
 S EASINST=$$INSTALDT^XPDUTL("EAS*1.0*174"),ERROR=0
 S EASCNT=$$GETCNT
 I 'EASINST D
 .I EASCNT'=13 S ERROR=1
 .I $D(^EAS(714.1,14,0)) S ERROR=1
 I EASINST D
 .I EASCNT'=14 S ERROR=1
 I ERROR D 
 .; file entries have been added or missing
 .W !,"It looks like you don't have the right entries in LTC CO-PAY "
 .W !,"EXEMPTION file (#714.1) installed."
 .W !,"Please enter a YOUR IT Services ticket with the Enterprise "
 .W !,"Service Desk (ESD) for assistance with getting "
 .W !,"the correct number of entries into the LTC CO-PAY EXEMPTION "
 .W !,"file (#714.1)."
 .W !,"*****"
 .S XPDABORT=1
 I 'ERROR D
 .W !,"*****"
 .W !,"The correct number of entries in LTC CO-PAY EXEMPTION file "
 .W !,"(#714.1) are installed."
 .W !,"*****"
 ;
 Q
GETCNT() ; Get count of entries in LTC CO-PAY EXEMPTION file (#714.1)
 N EASDATA,EASIEN,EASECNT
 S EASDATA=0,EASECNT=0
 F  S EASDATA=$O(^EAS(714.1,"B",EASDATA)) Q:EASDATA=""  D
 .S EASIEN=$O(^EAS(714.1,"B",EASDATA,"")) Q:'EASIEN  D
 ..S EASECNT=EASECNT+1
 Q EASECNT
