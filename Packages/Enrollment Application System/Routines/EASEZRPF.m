EASEZRPF ;ALB/AMA - Print 1010EZR
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57**;Mar 15, 2001
 ;
 ; These routines print a version of the OMB approved VA10-10EZR form.
 ; No local modifications to these routines will be made.  Any changes
 ; will be provided through the National Patch Module release process.
 ;
 Q
EN ; Entry point to print 1010EZR
 N EALNE,EAINFO,EAADL,EAABRT,EAMULT
 ;
 D SETUP(.EALNE,.EAINFO,EASAPP,EASDFN)
 ;
 M ^TMP("EASEZR",$J)=^TMP("EASEZ",$J) K ^TMP("EASEZ",$J)
 M ^TMP("EZRDATA",$J)=^TMP("EZDATA",$J) K ^TMP("EZDATA",$J)
 M ^TMP("EZRINDEX",$J)=^TMP("EZINDEX",$J) K ^TMP("EZINDEX",$J)
 M ^TMP("EZRTEMP",$J)=^TMP("EZTEMP",$J) K ^TMP("EZTEMP",$J)
 M ^TMP("EZRDISP",$J)=^TMP("EZDISP",$J) K ^TMP("EZDISP",$J)
 ;
 D PAGE1^EASEZRPU
 D EN^EASEZRP1(.EALNE,.EAINFO)
 ;
 D PAGE2^EASEZRPP
 D EN^EASEZRP2(.EALNE,.EAINFO)
 ;
 D EN^EASEZRP3(.EALNE,.EAINFO)
 ;
 ;Print additional insurance pages if more than 1 insurance company
 F EAADL=1:1 D  Q:$G(EAABRT)
 . I '$D(^TMP("EZRTEMP",$J,"IA",EAADL)) S EAABRT=1 Q
 . S EAMULT=1
 . D PAGEI^EASEZRPU(EAADL)
 I $G(EAMULT) D EN^EASEZRPI(.EALNE,.EAINFO)
 ;
 ;Print additional dependent pages if more than 1 dependent
 S (EAABRT,EAMULT)=0 F EAADL=1:1 D  Q:$G(EAABRT)
 . I '$D(^TMP("EZRTEMP",$J,"IIB",EAADL)) S EAABRT=1 Q
 . S EAMULT=1
 . D PAGEN^EASEZRPU(EAADL)
 I EAMULT D EN^EASEZRPD(.EALNE,.EAINFO)
 ;
 ;Print additional dependent financial pages if more
 ;than 1 dependent, starting with the 2nd one
 ;(since Child 1 info already displayed on pages 2 & 3)
 S (EAABRT,EAMULT)=0 F EAADL=2:1 D  Q:$G(EAABRT)
 . I '$D(^TMP("EZRTEMP",$J,"IIF",EAADL)) S EAABRT=1 Q
 . S EAMULT=1
 . D PAGEDFF^EASEZRPP(EAADL)
 S EAABRT=0 F EAADL=2:1 D  Q:$G(EAABRT)
 . I '$D(^TMP("EZRTEMP",$J,"IIG",EAADL)) S EAABRT=1 Q
 . S EAMULT=1
 . D PAGEDFG^EASEZRPP(EAADL)
 I EAMULT D EN^EASEZRPM(.EALNE,.EAINFO)
 ;
ENQUIT ; Clean up temp globals after printing is complete
 K ^TMP("EASEZR",$J)
 K ^TMP("EZRDATA",$J)
 K ^TMP("EZRINDEX",$J)
 K ^TMP("EZRTEMP",$J)
 K ^TMP("EZRDISP",$J)
 Q
 ;
SETUP(EALNE,EAINFO,EASAPP,EASDFN) ; Set-up print variables
 ; Input
 ;   EALNE   - Line format array
 ;   EAINFO  - Misc Data
 ;      ("CLRK") - Clerk's initials
 ;      ("ID")   - Web ID from #712
 ;      ("PGE")  - Page number
 ;      ("VET" ) - Veteran's name submitting the application
 ;      ("SSN")  - Veteran's SSN
 ;      ("DISC") - Financial Disclosure status
 ;   EASAPP  - IEN of applicant on the 1010EZ HOLDING File, #712
 ;   EASDFN  - DFN of applicant in the PATIENT File, #2
 ;
 N X
 ;
 ; Build Line array for printout
 S EALNE("ULC")=$S('($D(IOST)#2):"-",IOST["C-":"-",1:"_")
 S EALNE("D")="",EALNE("DD")="",EALNE("UL")=""
 S $P(EALNE("D"),"-",133)="",$P(EALNE("DD"),"=",133)="",$P(EALNE("UL"),EALNE("ULC"),133)=""
 ;
 ; Set up information array & get clerk's initials
 S ZUSR=$G(ZUSR)
 I +ZUSR>0 D
 . S EAINFO("CLRK")=$$GET1^DIQ(200,ZUSR,1)
 . I EAINFO("CLRK")']"" D
 . . S X=$$GET1^DIQ(200,ZUSR,.01)
 . . S EAINFO("CLRK")=$E($P(X,",",2),1)_$E($P(X,","),1)
 E  D
 . S EAINFO("CLRK")="unk"
 ;
 ; Set data elements
 S EAINFO("PGE")=0
 S EAINFO("ID")=$$GET1^DIQ(712,EASAPP_",",.1)
 S EAINFO("PD")=$$FMTE^XLFDT($$NOW^XLFDT)
 S EAINFO("DISC")=$$GET1^DIQ(712,EASAPP_",",3.8)
 S EAINFO("EASAPP")=EASAPP
 S EAINFO("VET")=$$GET1^DIQ(712,EASAPP_",",1)
 S EAINFO("SSN")=$$GET1^DIQ(712,EASAPP_",",2)
 ;
 ; Retrieve application data from holding file, #712
 D EN^EASEZC1(EASAPP)
 D SORT^EASEZC3(EASAPP)
SETQ Q
 ;
HDRMAIN(EALNE) ; PRINT THE FIRST PAGE HEADER INFORMATION
 W @IOF
 W ?44,"OMB APPROVED NO. 2900-0091 / Estimated Burden Avg. 24 min. / Expiration Date: 6/30/2007",!,EALNE("DD")
 W !,"D E P A R T M E N T   O F   V E T E R A N S   A F F A I R S",?76,"HEALTH BENEFITS RENEWAL FORM",!,EALNE("DD")
 Q
 ;
HDR(EALNE,EAINFO) ; PRINT THE PAGE HEADER INFO FOR PAGES GREATER THAN 1
 W @IOF
 W "DEPARTMENT OF VETERANS AFFAIRS",?40,"| VETERAN'S NAME (Last, First, Middle)",?106,"| SOCIAL SECURITY NUMBER"
 W !?40,"| ",EAINFO("VET"),?106,"| ",EAINFO("SSN")
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 Q
 ;
FT(EALNE,EAINFO) ; PRINT THE PAGE FOOTER INFORMATION
 W !,EALNE("DD")
 W !,"VA FORM 10-10EZR FEB 2005",?40,"PRINTED: ",EAINFO("PD")
 W ?80,"Clerk: ",EAINFO("CLRK"),"/",EAINFO("ID")
 W ?120,"PAGE " S EAINFO("PGE")=EAINFO("PGE")+1 W EAINFO("PGE")
 Q
