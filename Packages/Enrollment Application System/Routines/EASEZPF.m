EASEZPF ;ALB/SCK/GAH - Print 1010EZ Enrollment form ; 10/19/2000
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**44,51,84**;Sep 5, 2006;Build 2
 ;
 ; These routines print a version of the OMB approved VA10-10EZ form.
 ; No local modifications to these routines will be made.  Any changes
 ; will be provided through the National Patch Module  release process.
 ;
QUE(EASAPP,EASDFN) ; Queue the 1010EZ print
 ;  Input
 ;      EASAPP - Internal entry number in the 1010EZ HOLDING File, #712
 ;      EASDFN - [Optionla] Patient DFN
 ;
 ;  Output
 ;      ZTSK   - Task Number returned from call to Task Manager
 ;
 ;  
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZUSR,POP,X,ERR
 ;
 ; Check for conditions to print form.  If conditions not met, quit
 G:$$CHECKS(EASAPP) EXIT
 ;
 W !!?5,*7,"Do not select a slave device for output."
 W !?5,"This output requires a 132 column output printer."
 W !?5,"Output to SCREEN will be unreadable.",!
 ;
 S EASAPP=$G(EASAPP),EASDFN=$G(EASDFN)
 ; Can't be a slave
 S %ZIS="Q",%ZIS("S")="I $P($G(^(1)),U)'[""SLAVE""&($P($G(^(0)),U)'[""SLAVE"")"
 D ^%ZIS
 ;
 G:POP EXIT
 ;EAS*1*51 -- if version # 6 or greater, use new print format
 S ZTRTN="EN^EASEZPF"
 I '$G(EASVRSN) S EASVRSN=$$VERSION^EASEZU4(EASAPP)
 I '(EASVRSN<6) S ZTRTN="EN^EASEZP6F"
 ; Either queue for print or print manually by user choice (EAS*1.0*84)
 I $D(IO("Q")) D  G EXIT ;Queued print chosen
 . S ZUSR=DUZ,ZTDESC="1010EZ PRINT"
 . F X="ZUSR","EASAPP","EASDFN" S ZTSAVE(X)=""
 . D ^%ZTLOAD
 . D HOME^%ZIS
 ;
 ;Manual print chosen
 D @ZTRTN
 D ^%ZISC
 G EXIT
 ;
EXIT Q +$G(ZTSK)
 ;
CHECKS(EASAPP) ; Check for quit conditions
 ;
 Q 0
 N RSLT
 ;
 S X=$$GET1^DIQ(712,EASAPP_",",3.4,"I") D
 . I +X'>0 S ERR(3.4)="The applicant has not been linked to the PATIENT File, #2"
 ;
 S X=$$GET1^DIQ(712,EASAPP_",",5.1,"I") D
 . I +X'>0 S ERR(5.1)="This application has not been reviewed"
 ;
 S X=$$GET1^DIQ(712,EASAPP_",",9.1,"I") D
 . I X>0 S ERR(9.1)="This application has already been closed, thE VA10-10EZ cannot be printed"
 ;
 I $D(ERR)>0 D
 . W !!?3,*7,"The VA10-10EZ for "
 . W $$GET1^DIQ(712,EASAPP_",",1),", ",$$GET1^DIQ(712,EASAPP_",",2),", "
 . W !?3,"WEB submission ID: ",$$GET1^DIQ(712,EASAPP_",",.1)
 . W !?3,"could not be printed for the following reason(s): "
 . S X=0
 . F  S X=$O(ERR(X)) Q:'X  D
 . . W !?5,">> ",ERR(X)
 . S RSLT=1
 ;
 Q $G(RSLT)
 ;
EN ; Entry point to print 1010EZ
 N EALNE,EAINFO,EAABRT,EAADL,ERR
 ;
 D SETUP(.EALNE,.EAINFO,EASAPP,EASDFN)
 ;
 D PAGE1^EASEZPU
 D EN^EASEZPF1(.EALNE,.EAINFO)
 ;
 D PAGE2^EASEZPU
 D EN^EASEZPF2(.EALNE,.EAINFO)
 ;
 D EN^EASEZPF3(.EALNE,.EAINFO)
 ;
 ; Print additional second pages if more than 1 dependent.
 F EAADL=1:1 D  Q:$G(EAABRT)
 . I '$D(^TMP("EZTEMP",$J,"IIB",EAADL)) S EAABRT=1 Q
 . D PAGEN^EASEZPU(EAADL)
 . D EN^EASEZPF2(.EALNE,.EAINFO)
 ;
ENQUIT ; Cleanup temp globals after printing is complete
 K ^TMP("EASEZ",$J)
 K ^TMP("EZDATA",$J)
 K ^TMP("EZINDEX",$J)
 K ^TMP("EZTEMP",$J)
 K ^TMP("EZDISP",$J)
 Q
 ;
SETUP(EALNE,EAINFO,EASAPP,EASDFN) ; Set-up print variables
 ; Input
 ;   EALNE   - Line format array
 ;   EAINFO  - Misc Data
 ;      ("CLRK") - Clerk's intials
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
 S $P(EALNE("D"),"-",131)="",$P(EALNE("DD"),"=",131)="",$P(EALNE("UL"),EALNE("ULC"),131)=""
 ;
 ; Setup information array
 ; Get clerk's initals
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
 ; Retrieve applciation data from holding file, #712
 D EN^EASEZC1(EASAPP)
 D SORT^EASEZC3(EASAPP)
SETQ Q
 ;
HDRMAIN(EALNE) ;
 W @IOF
 W ?75,"OMB APPROVED NO. 2900-0091 / Est. Burden Avg. 20 min.",!,EALNE("DD")
 W !,"D E P A R T M E N T   O F   V E T E R A N S   A F F A I R S",?96,"APPLICATION FOR HEALTH BENEFITS",!,EALNE("DD")
 W !?50,"SECTION I - GENERAL INFORMATION",!,EALNE("D")
 Q
 ;
HDR(EALNE,EAINFO) ;
 W @IOF
 W !,"APPLICATION FOR HEALTH BENEFITS, Continued",?65,"| ",EAINFO("VET"),?100,"| ",EAINFO("SSN")
 W !,EALNE("DD")
 Q
 ;
FT(EALNE,EAINFO) ;
 N %,Y
 ;
 W !,EALNE("DD")
 W !,"AUTOMATED VA FORM 10-10EZ APR 1998",?40,"PRINTED: ",EAINFO("PD")
 W ?80,"Clerk: ",EAINFO("CLRK"),"/",EAINFO("ID")
 W ?120,"Page " S EAINFO("PGE")=EAINFO("PGE")+1 W EAINFO("PGE")
 Q
