EASEC10E ;ALB/BRM,LBD - Print 1010EC LTC Enrollment form ; 9/20/01 1:46pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,40**;Mar 15, 2001
 ;
 ; The EASEC10* routines print a version of the OMB approved
 ; VA10-10EC form (Long Term Care).
 ;
 ; No Local modifications to these routines will be made.  Any changes
 ; will be provided through the National Patch Module release process.
 ;
 Q
OEN ;Entry point to print an LTC Co-Pay test from the menu option
 ;
 N DIC,DFN,DGMTI,ZTSK,DGMSGF
 S DGMSGF=1  ;this flag is set to suppress the financial query
 S DIC("S")="I $D(^DGMT(408.31,""AID"",3,+Y))"
 S DIC="^DPT(",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q:Y<0 S DFN=+Y
 S DIC("A")="Select DATE OF TEST: "
 I $D(^DGMT(408.31,+$$LST^EASECU(DFN,"",3),0)) S DIC("B")=$P(^(0),"^")
 S DIC("S")="I $P(^(0),U,2)=DFN,$P(^(0),U,19)=3"
 S DIC="^DGMT(408.31,",DIC(0)="EQZ" W ! D EN^DGMTLK K DIC G Q:Y<0
 S DGMTI=+Y
 S ZTSK=$$QUE(DFN,DGMTI)
Q Q
QUE(DFN,DGMTIEN) ; queue the 1010EC print job
 ; Input:
 ;       DFN - Internal entry number for the #2 (Patient) file
 ; Output:
 ;       ZTSK - Task Number returned from call to Task Manager
 ;
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZUSR,POP,X,ERR
 W !!?5,$C(7),"This output requires a 132 column printer."
 W !?5,"Output to SCREEN will be unreadable.",!
 K IOP,%ZIS
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  Q +$G(ZTSK)
 .S ZTSAVE("ZUSR")=+$G(DUZ)
 .S ZTRTN="EN^EASEC10E("_DFN_","_$G(DGMTIEN)_")",ZTDESC="1010EC PRINT"
 .D ^%ZTLOAD
 .D ^%ZISC,HOME^%ZIS
 .W !,$S($D(ZTSK):"REQUEST QUEUED!",1:"REQUEST CANCELLED!")
 D EN(DFN,$G(DGMTIEN))
EXIT D ^%ZISC,HOME^%ZIS
 Q +$G(ZTSK)
 ;
EN(EASDFN,DGMTIEN) ; Entry point to print the 1010EC form
 ; Input:
 ;    EASDFN  - Internal entry number for the #2 (Patient) file
 ;    DTMTDT  - Date of Long Term Care Test to print
 ;    DGMTIEN - IEN of the Long term Care test in the #408.31 file
 ;
 U IO
 Q:'$G(EASDFN)
 N EALNE,EAINFO
 S:$G(DGMTIEN) EAINFO("DGMTIEN")=DGMTIEN
 ; set-up print variables
 D SETUP(.EALNE,.EAINFO,EASDFN)
 ; get veteran data to be printed
 D GETDATA^EASEC100(EASDFN,.EAINFO)
 ; print page 1
 D PAGE1^EASEC101(.EALNE,.EAINFO,EASDFN)
 ; print pages 2 and 3
 I $G(EAINFO("FORM")) D  G ENQUIT
 .; new 10-10EC format (LTC Phase IV - EAS*1*40)
 .D PAGE2^EASEC10R(.EALNE,.EAINFO,EASDFN)
 .D PAGE3^EASEC10R(.EALNE,.EAINFO,EASDFN)
 E  D
 .; old 10-10EC format
 .D PAGE2^EASEC102(.EALNE,.EAINFO,EASDFN)
 .D PAGE3^EASEC103(.EALNE,.EAINFO,EASDFN)
 ;
ENQUIT ; cleanup temp globals after printing has completed
 K ^TMP("1010EC",$J,EASDFN)
 Q
 ;
SETUP(EALNE,EAINFO,EASDFN) ;setup print variables
 ; Input:
 ;   EALNE - Line format array
 ;   EAINFO - Misc data array
 ;      ("CLRK")    - Clerk's Initials
 ;      ("PGE")     - Page number
 ;      ("PD")      - Print Date
 ;      ("VET")     - Veteran's Name
 ;      ("SSN")     - Veteran's SSN
 ;      ("MTDT")    - Long Term Care Test date
 ;      ("DGMTIEN") - ien of LTC Test in 408.31 
 ;   EASDFN - DFN of applicant in the Patient file (#2)
 ;
 N X,SSN
 ;
 ;Build Line array for printout
 S EALNE("ULC")=$S('($D(IOST)#2):"-",IOST["C-":"-",1:"_")
 S EALNE("D")="",EALNE("DD")="",EALNE("UL")=""
 S $P(EALNE("D"),"-",131)="",$P(EALNE("DD"),"=",131)="",$P(EALNE("UL"),EALNE("ULC"),131)=""
 S EAINFO("L")="W !,EALNE(""UL"")"
 S:EALNE("ULC")'="-" EAINFO("L")=$TR(EAINFO("L"),"!,")
 ;
 ;Get clerk's initials
 S ZUSR=$G(ZUSR)
 S:$G(ZUSR)="" ZUSR=$G(DUZ)
 I +ZUSR>0 D
 .S EAINFO("CLRK")=$$GET1^DIQ(200,ZUSR,1)
 .I EAINFO("CLRK")']"" D
 ..S X=$$GET1^DIQ(200,ZUSR,.01)
 ..S EAINFO("CLRK")=$E($P(X,",",2),1)_$E($P(X,","),1)
 E  D
 .S EAINFO("CLRK")="unk"
 ;
 ;Get LTC Test date (if it is not passed, use latest LTC test date)
 I $G(EAINFO("DGMTIEN")) S EAINFO("MTDT")=$$GET1^DIQ(408.31,EAINFO("DGMTIEN"),.01,"I")
 E  D  ;
 .N MTDTNEG
 .S MTDTNEG=+$O(^DGMT(408.31,"AID",3,EASDFN,""))
 .S EAINFO("MTDT")=$TR(MTDTNEG,"-")
 .S EAINFO("DGMTIEN")=$O(^DGMT(408.31,"AID",3,EASDFN,MTDTNEG,""))
 ;
 ;Set data elements
 S EAINFO("PGE")=0
 S EAINFO("PD")=$$FMTE^XLFDT($$NOW^XLFDT)
 S EAINFO("VET")=$$GET1^DIQ(2,EASDFN_",",.01)
 S SSN=$$GET1^DIQ(2,EASDFN_",",.09)
 S EAINFO("SSN")=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 ;Line added to set new variable to indicate which version of the
 ;10-10EC form is to be printed.  LTC Phase IV (EAS*1*40)
 S EAINFO("FORM")=$$FORM^EASECU(EAINFO("DGMTIEN"))
 Q
 ;
HDRMAIN(EALNE) ;
 W @IOF
 W !,EALNE("DD")
 W !,"D E P A R T M E N T   O F   V E T E R A N S   A F F A I R S",?90,"APPLICATION FOR EXTENDED CARE SERVICES",!,EALNE("DD")
 W !?50,"SECTION I - GENERAL INFORMATION",!,EALNE("D")
 Q
 ;
HDR(EALNE,EAINFO) ;
 W @IOF
 W EALNE("DD")
 W !,"APPLICATION FOR EXTENDED CARE SERVICES, Continued"
 W ?65,"| Veteran's Name",?100,"| Social Security Number"
 W !?65,"| ",EAINFO("VET"),?100,"| ",EAINFO("SSN")
 W !,EALNE("DD")
 Q
 ;
FT(EALNE,EAINFO) ;
 N %,Y
 W !,EALNE("DD")
 ;Modified date printed on form if new 10-10EC format.
 ;Added for LTC Phase IV (EAS*1*40).
 W !,"VA FORM 10-10EC DEC "_$S(EAINFO("FORM"):"2002",1:"2000"),?40,"PRINTED: ",EAINFO("PD")
 W ?80,"Clerk: ",EAINFO("CLRK")
 S EAINFO("PGE")=EAINFO("PGE")+1
 W ?120,"Page ",EAINFO("PGE"),?131,$C(13)
 Q
