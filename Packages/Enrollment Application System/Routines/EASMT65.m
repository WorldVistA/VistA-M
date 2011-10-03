EASMT65 ; ALB/SCK - MEANS TEST LETTER PRINT FOR USER ENROLLEE STATUS ; 25-JUL-2007
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**65**;MAR 15,2001;Build 1
 ;
QUE ;
 N UES,LTRGRP,ZTSAVE,RETZTSK,ZTSK
 ;
 I '$D(^XUSEC("EAS MT UES OVERRIDE",DUZ)) D  Q
 . W !!,"You have not been assigned the required key to use this option."
 . W !,"Please contact IRM or the Means Test Coordinator at your site"
 . W !,"for assistance.",!!
 ;
 W:$D(IOF) @IOF
 S UES=$$GETSITE Q:'UES
 S LTRGRP=$$LTRS Q:LTRGRP=0
 ;
 S RETZTSK=1
 S ZTSAVE("UES")="",ZTSAVE("LTRGRP")=""
 D EN^XUTMDEVQ("EN^EASMT65","MT letters, UES print",.ZTSAVE)
 W !,"Job has been tasked: ",$G(ZTSK)
 Q
 ;
EN ;
 N LTRCNT,EAX
 ;
 Q:'$G(UES)
 Q:'$G(LTRGRP)
 ;
 K ^TMP("EASUE",$J)
 F EAX=1,2,4 S LTRCNT(EAX)=0
 ;
 D BUILD(UES,LTRGRP)
 D PRINT(LTRGRP)
 D FINAL(UES,LTRGRP)
 ;
 K ^TMP("EASUE",$J)
 D ^%ZISC
 Q
 ;
GETSITE() ;  Select User Enrollee Site
 N DIR,X,Y,DIRUT,DTOUT,DUOUT,RSLT
 ;
 W !,"This option will allow the override of the current filters on the User"
 W !,"Enrollee site.  By selecting a site, letters for veterans that are"
 W !,"listed as a User Enrollee of that site can be printed."
 W !,"This option should be used with care!",!
 ;
 S DIR(0)="PAO^4:EMZ"
 S DIR("A")="Select the User Enrollee site to print letters for: "
 D ^DIR K DIR
 S RSLT=+Y
 I $D(DIRUT) S RSLT=0
 Q $G(RSLT)
 ;
LTRS() ; Select letter group to print
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 ;
 S DIR(0)="SO^1:60-Day Letters;2:30-Day Letters;4:0-Day Letters;ALL:All Letters"
 S DIR("L",1)="Select the group of Letters to print:"
 S DIR("L",2)=""
 S DIR("L",3)="    1: 60-Day   2: 30-Day Letters   4: 0-Day Letters"
 S DIR("L")="    ALL: All Letters"
 S DIR("?",1)=""
 S DIR("?",2)="Select the group of letters to print: enter 1 for 60 day letters, "
 S DIR("?",3)="enter 2 for 30 day lettes, or enter 4 for 0 day letters."
 S DIR("?")="Entering 'All' will print all pending letters for 60, 30, and 0 days."
 D ^DIR K DIR
 I $D(DIRUT) S Y=0
 I Y="ALL" S Y=5
 Q $G(Y)
 ;
BUILD(UES,LTRGRP) ; Build list of letters to print
 N IEN,DFN,EAX,PFLAGS,ABRT
 ;
 I '$D(ZTQUEUED) W !,"Collecting "_$S(LTRGRP=1:"60-Day",LTRGRP=2:"30-Day",LTRGRP=4:"0-Day",1:"All ")_" letters"
 S IEN=0
 F  S IEN=$O(^EAS(713.2,"AC",0,IEN)) Q:'IEN  D
 . S EAX=$$GET1^DIQ(713.2,IEN,2,"I")
 . S DFN=$$GET1^DIQ(713.1,EAX,.01,"I")
 . Q:'$$UESITE(UES,DFN)  ; Check if UE Site matches selected site to print letters for
 . I $D(^EAS(713.1,"AP",1,EAX)) D  Q  ; Check for Prohibit flag
 . . D CLRFLG^EASMTUTL(0,IEN)
 . . S ^TMP("EASUE",$J,"ERR",$$GET1^DIQ(2,DFN,.01))=IEN_"^"_DFN_"^1~Prohibit Flag is set for the Veteran"
 . I $$DECEASED^EASMTUTL(IEN) D  Q  ; Check if veteran is deceased
 . . D CLRFLG^EASMTUTL(0,IEN)
 . . S ^TMP("EASUE",$J,"ERR",$$GET1^DIQ(2,DFN,.01))=IEN_"^"_DFN_"^2~Veteran is deceased"
 . I $$FUTMT^EASMTUTL(IEN) D  Q  ; Check if a future dated MT is in place
 . . D CLRFLG^EASMTUTL(0,IEN)
 . . S ^TMP("EASUE",$J,"ERR",$$GET1^DIQ(2,DFN,.01))=IEN_"^"_DFN_"^3~Veteran has a future dated Means Test"
 . I $$CHKADR^EASMTL6A(EAX) D  Q  ; Check for a valid address
 . . S ^TMP("EASUE",$J,"ERR",$$GET1^DIQ(2,DFN,.01))=IEN_"^"_DFN_"^4~Invalid address or Bad Address Flag"
 . S PFLAGS=$$LGROUP(IEN,LTRGRP)
 . S ^TMP("EASUE",$J,"PRNT",$$GET1^DIQ(2,DFN,.01))=IEN_"^"_DFN_"^"_PFLAGS
 Q
 ;
UESITE(UES,DFN) ; Determine UE Status
 ; Input
 ;       UES - Selected User Enrollee Site
 ;       DFN - Patient DFN
 ;       
 ;  Returns a '1' if UE Status is 'Diff. Site' and USER ENROLLEE SITE, Field #.3618, File #2
 ;  matches the UE Site passed in. otherwise returns a '0'
 ;  
 N RSLT
 ;
 I $$UESTAT^EASUER(DFN)=2 D
 . S:$$GET1^DIQ(2,DFN,.3618,"I")=UES RSLT=1
 Q $G(RSLT)
 ;
LGROUP(IEN,LTRGRP) ; Check whether the letter group has a pending letter or not. 
 ; Input - Ien in 713.2
 ;       - LTRGRP - Letter group selected: 60/30/0/All
 ; 
 ; Output - Returns a '1' it there is a pending letter for that letter group and
 ;                  a '0' if there is not.  Format is: 60-Day~30-Day~0-Day~All
 ;         
 N NODE6,NODE4,NODEZ,RSLT
 ;
 S NODE6=$G(^EAS(713.2,IEN,6))
 S NODE4=$G(^EAS(713.2,IEN,4))
 S NODEZ=$G(^EAS(713.2,IEN,"Z"))
 ;
 S $P(RSLT,"~",1)=+$P(NODE6,U,2)
 S $P(RSLT,"~",2)=+$P(NODE4,U,2)
 S $P(RSLT,"~",4)=+$P(NODEZ,U,2)
 S $P(RSLT,"~",5)=$S(LTRGRP=5:1,1:0)
 ;
 Q $G(RSLT)
 ;
PRINT(LTRGRP) ; Print Letter
 N NAME,IEN,DFN,PFLAGS,EAX,EATYP
 ;
 S NAME="",LTRCNT=0
 F  S NAME=$O(^TMP("EASUE",$J,"PRNT",NAME)) Q:NAME']""  D
 . K IEN,DFN,PFLAGS
 . S IEN=$P(^TMP("EASUE",$J,"PRNT",NAME),U,1)
 . S DFN=$P(^TMP("EASUE",$J,"PRNT",NAME),U,2)
 . S PFLAGS=$P(^TMP("EASUE",$J,"PRNT",NAME),U,3)
 . I LTRGRP=5 D
 . . F EAX=1,2,4 D
 . . . I $P(PFLAGS,"~",EAX) D
 . . . . D LETTER^EASMTL6A(IEN,EAX)
 . . . . S LTRCNT(EAX)=LTRCNT(EAX)+1
 . . . . D UPDSTAT^EASMTL6(IEN,EAX)
 . E  D
 . . I $P(PFLAGS,"~",LTRGRP) D 
 . . . D LETTER^EASMTL6A(IEN,LTRGRP)
 . . . S LTRCNT(LTRGRP)=LTRCNT(LTRGRP)+1
 . . . D UPDSTAT^EASMTL6(IEN,LTRGRP)
 Q
 ;
FINAL(UES,LTRGRP) ; Final wrap up
 N MSG,LINECNT,XMSUB,XMTEXT,XMY,XMDUZ,TOT
 ;
 I $D(^TMP("EASUE",$J,"ERR")) D ERRPT(UES,LTRGRP)
 ;
 S MSG(1)="Count of Means Test letters printed for a User Enrollee Site"
 S MSG(2)=""
 S MSG(5)="User Enrollee Site: "_$$GET1^DIQ(4,UES,.01)
 S MSG(10)="      Letter Group: "_$S(LTRGRP=1:"60-Day",LTRGRP=2:"30-Day",LTRGRP=4:"0-Day",1:"All")_" letters."
 S MSG(15)=""
 S MSG(20)=" 60-day letters printed: "_+$G(LTRCNT(1))
 S MSG(22)=" 30-day letters printed: "_+$G(LTRCNT(2))
 S MSG(24)="  0-day letters printed: "_+$G(LTRCNT(4))
 S TOT=$G(LTRCNT(1))+$G(LTRCNT(2))+$G(LTRCNT(4))
 S MSG(26)="                  Total: "_TOT
 ;
 S XMSUB="EAS LETTER RESULTS BY UE SITE "
 S XMTEXT="MSG("
 S XMY("G.EAS MTLETTERS")=""
 S XMDUZ="EAS MT LETTERS"
 D ^XMD
 Q
 ;
ERRPT(UES,LTRGRP) ; send error report to MT letters mail group
 N MSG,NAME,DFN,IEN,ERROR,LINE,LINECNT,VA,SPACE,XMSUB,XMTEXT,XMY,XMDUZ
 ;
 S NAME="",LINECNT=100
 F  S NAME=$O(^TMP("EASUE",$J,"ERR",NAME)) Q:NAME']""  D
 . S IEN=$P(^TMP("EASUE",$J,"ERR",NAME),U,1)
 . S DFN=$P(^TMP("EASUE",$J,"ERR",NAME),U,2)
 . S ERROR=$P(^TMP("EASUE",$J,"ERR",NAME),U,3)
 . S LINE=$E(NAME,1,25)
 . D PID^VADPT6 S LINE=LINE_" ("_VA("BID")_")" K VA
 . S SPACE="",$P(SPACE," ",32-$L(LINE))=""
 . S LINE=LINE_SPACE_$P(ERROR,"~",2)
 . S MSG(LINECNT)=LINE,LINECNT=LINECNT+1
 ;
 S MSG(1)="The following errors were encountered during the processing of "
 S MSG(2)="the Means Test Letters for the "_$$GET1^DIQ(4,UES,.01)_" User Enrollee Site."
 S MSG(4)=""
 S MSG(10)="Letter Group: "_$S(LTRGRP=1:"60-Day",LTRGRP=2:"30-Day",LTRGRP=4:"0-Day",1:"All")_" letters."
 S MSG(30)=""
 ;
 S XMSUB="EAS PRINT LETTERS BY UE SITE"
 S XMTEXT="MSG("
 S XMY("G.EAS MTLETTERS")=""
 S XMDUZ="EAS MT LETTERS"
 D ^XMD
 Q
