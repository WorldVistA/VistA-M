IBDFC ;ALB/CJM - ENCOUNTER FORM - CONVERSION UTILTY ;FEB 30,1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
FORMLIST ;
 N IBDEVICE
 N IBFASTXT ;set to 1 for fast exit from system
 S IBFASTXT=0
 D DEVICE^IBDFUA(1,.IBDEVICE)
 K XQORS,VALMEVL
 D VALMSG
 D EN^VALM("IBDFC CONVERSION UTILITY")
 Q
ONENTRY ;
 S VALMCNT=0 K @VALMAR
 Q
ONEXIT ;
 D KILL^%ZISS
 K ^TMP("IB",$J),^TMP("IBDF",$J),VALMY,IBQUIT,VALMBCK,X,Y,I,DA,D0
 Q
 ;
HDR ;
 S VALMHDR(1)="             ***  LIST OF FORMS TO CONVERT FOR SCANNING  ***"
 I $O(^IBD(359,0)) S VALMHDR(2)=" Converted Forms Exist, Use'View Conversion Log' to view converted forms"
 Q
REMOVE ;allows user to select a form, then deletes it
 N SEL,FORM,LAST
 K DIR
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL=$O(VALMY(""))
 I SEL K @VALMAR@(SEL),@VALMAR@("IDX",SEL)
 ;fill in the hole with the last form on the list
 S LAST=$S(VALMCNT<2:0,SEL=VALMCNT:0,1:VALMCNT)
 I LAST D
 .S FORM=@VALMAR@("IDX",LAST,LAST)
 .K @VALMAR@(LAST),@VALMAR@("IDX",LAST)
 .S VALMCNT=VALMCNT-1
 .D DISPLAY(SEL,FORM)
 S VALMCNT=VALMCNT-1
 D VALMSG
 S VALMBCK="R"
 Q
 ;
ADDONE ;adds a single form to the list for conversion
 N FORM,NODE,CNV,CNVNM,PREV,IBQUIT
 S NODE="",IBQUIT=0
 S VALMBCK="R"
 S FORM=$$SLCTFORM^IBDFU4("",.NODE) Q:'FORM
 I +$P(NODE,"^",17)>2 W !,"This form is already a version "_$P(NODE,"^",17)_" form!" D PAUSE^IBDFU5,VALMSG Q
 ;
 ; -- see if form already converted
 S CNV=0 F  S CNV=$O(^IBD(359,"AORIG",FORM,CNV)) Q:'CNV  D
 .S PREV=+$G(^IBD(359,CNV,0))
 .I PREV W !,"This form previously converted, new form name = "_$P($G(^IBE(357,PREV,0)),"^") S IBQUIT=1
 I $O(^IBE(357,"B","CNV."_$E($P(NODE,"^"),1,41),0)) W !!,"Form Name "_"CNV."_$E($P(NODE,"^"),1,41)_" already exists.  Form must be renamed first!" D PAUSE^IBDFU5 Q
 D VALMSG
 I IBQUIT D PAUSE^IBDFU5
 ;
 D DISPLAY(VALMCNT+1,FORM)
 D VALMSG
 Q
 ;
DISPLAY(IDX,FORM) ;
 N NODE
 S NODE=$G(^IBE(357,FORM,0)) Q:NODE=""
 S VALMCNT=VALMCNT+1
 S @VALMAR@(IDX,0)=$J(IDX,3)_"  "_$$PADRIGHT^IBDFU($P(NODE,"^"),30)_"  "_$E($P(NODE,"^",3),1,80),@VALMAR@("IDX",IDX,IDX)=FORM D FLDCTRL^VALM10(IDX)
 Q
 ;
CNVTLIST ;
 N IBFORM,IDX,QUIT,PRINT,DIR,DIRUT,DUOUT,DTOUT
 S (QUIT,PRINT)=0
 S VALMBCK="R"
 D FULL^VALM1
 ;
 I $O(@VALMAR@("IDX",0))="" W !!,"No forms on List to convert!"  D PAUSE^IBDFU5,VALMSG Q
 ;
 W !!,"Each form on the list will be made scannable.  However, the results should be",!,"carefully reviewed before putting the form into use.",!
 K DIR S DIR(0)="Y",DIR("A")="Do you want to print the form(s) after they have been converted",DIR("B")="YES"
 D ^DIR Q:(Y<0)!($D(DIRUT))  K DIR I Y=1 D  Q:QUIT
 .S PRINT=1
 .D DEVICE
 ;
 S IBDASK("ADDOTHER")=$$ASKOTH^IBDFC2B Q:IBDASK("ADDOTHER")<0
 S IBDASK("AUTOCHG")=$$ASKAUTO^IBDFC2B Q:IBDASK("AUTOCHG")<0
 ;
 S IDX=0 F  S IDX=$O(@VALMAR@("IDX",IDX)) Q:'IDX  S IBFORM=$G(@VALMAR@("IDX",IDX,IDX)) Q:'IDX  S IBFORM=$$CONVERT^IBDFC2(IBFORM) D:PRINT QUEUE
 I PRINT D ^%ZISC
 K @VALMAR
 D VALMSG
 Q
 ;
DEVICE ;
 W !,"** You must queue the form to print. **"
 W !,$C(7),"** Forms require 132 columns and a page length of 80 lines. **",!
 ;
 ;queuing is automatic - the device is not opened
 K %IS,%ZIS,IOP S %ZIS="N0Q",%ZIS("A")="Printer to queue to: ",%ZIS("B")="",%ZIS("S")="I $E($P($G(^%ZIS(2,+$G(^%ZIS(1,Y,""SUBTYPE"")),0)),U),1,2)=""P-""" D ^%ZIS
 I POP S QUIT=1
 Q
 ;
QUEUE S ZTRTN="PRINT^IBDFC",ZTSAVE("IBFORM")="",ZTDESC="ENCOUNTER FORM - FROM CONVERSION",ZTDTH=$H D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued Task="_ZTSK,1:"Request Canceled")
 Q
 ;
PRINT ;
 D FORM^IBDF2A(IBFORM,0)
 Q
 ;
VALMSG ;
 I $O(^IBD(359,0)) S VALMSG="Use 'View Conversion Log' to view converted forms."
 I '$O(^IBD(359,0)) S VALMSG="Use 'Add Form to List' to convert a form"
 Q
 ;
HELP ;
 D FULL^VALM1
 W !!,"To convert a form follow the following steps:"
 W !,"   1.  Use 'Add Form to List' to select the form.   Add all the forms to"
 W !,"       the list you wish to at this time."
 W !,"   2.  Use 'Convert List' to convert the forms."
 W !,"   3.  Use 'View Conversion Log' to review the conversion process and "
 W !,"       assign the converted form to a clinic.",!
 W !,"Hint:  The conversion creates a new copy of your form with the same name"
 W !,"       as the original but prefixed with 'CNV.'.  (i.e. form PRIM CARE"
 W !,"        would be renamed CNV.PRIM CARE)"
 S X="?" D DISP^XQORM1 W !
