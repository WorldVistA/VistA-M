IBCNAU3 ;ALB/KML/AWC - eIV USER EDIT REPORT (PRINT) ;6-APRIL-2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;  Required variable input:  ALLUSERS, ALLINS, PLANS, ALLPLANS, EXCEL
 ;  ^TMP("IBINC",$J) 
 ;  ^TMP("IBUSER",$J) 
 ;  DATE("START") and DATE("END") required array elements if all dates not selected
 Q
 ;
EN(ALLPLANS,PLANS) ;
 ; Print the report.
 ;                  
 I EXCEL D EXCEL(PLANS) Q
 N IBI,IBJ,IBK,IBL,IBM,IB01,IB02,IBQUIT,IBPAG,IBPD,IBHDT
 S (IB02,IBQUIT,IBPAG)=0
 S IBHDT=$$FMTE^XLFDT($$NOW^XLFDT())
 ;
 D HDR(ALLPLANS,PLANS)
 I '$D(^TMP("IBPR",$J)) W !!,"User Edits do not exist per the selected filters." D PAUSE Q
 ;
 F IB01=0,1 F  S IB02=$O(^TMP("IBPR",$J,IB01,IB02)) Q:'IB02  Q:IBQUIT  S IBPD=$G(^TMP("IBPR",$J,IB01,IB02)) D  Q:IBQUIT
 . I $Y>(IOSL-5) D PAUSE Q:IBQUIT  D HDR(ALLPLANS,PLANS)
 . D PLAN
 W !!,"END OF REPORT" D PAUSE
 Q
 ;
 ;
HDR(ALLPLANS,PLANS) ; Print REPORT header
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"USER EDIT REPORT"
 W ?IOM-34,IBHDT,?IOM-10,"Page: ",IBPAG
 W !?5,"Insurance Company"
 I PLANS W ?42,"Group Name"
 W !!?5,"User",?25,"Date/Time of Change",?49,"Modified Field",?75,"Previous Value of Data",?100,"Modified Value of Data"
 W !,$TR($J(" ",IOM)," ","_"),!
 Q
 ;
PLAN ; Print plan information.
 N USER,DATE
 S USER=$$GET1^DIQ(200,$P(IBPD,U,3)_",",.01)
 S DATE=$$FMTE^XLFDT($P(IBPD,U,4),2),DATE=$TR(DATE,"@"," ")
 W !?5,$P(IBPD,U),?42,$S('IB01:"",1:$P(IBPD,U,2))
 W !?5,USER,?25,DATE,?49,$P(IBPD,U,7),?75,$S($P(IBPD,U,5)="":"<no previous value>",1:$P(IBPD,U,5)),?100,$P(IBPD,U,6),!!
 Q
 ;
PAUSE ; Pause for screen output.
 Q:$E(IOST,1,2)'["C-"
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
 ;
EXCEL(PLANS) ; user selected format that can be viewed in MS Excel
 N IBI,IBJ,IBK,IBL,IBM,IB01,IB02,USER,DATE
 S (IB01,IB02)=0
 W !,"USER EDIT REPORT",!
 ;
 I PLANS W !,"Insurance Company^Group Name^User^Date/Time of Change^Modified Field^Previous Value of Data^Modified Value of Data",!
 E  W !,"Insurance Company^User^Date/Time of Change^Modified Field^Previous Value of Data^Modified Value of Data",!
 ;
 F IB01=0,1 F  S IB02=$O(^TMP("IBPR",$J,IB01,IB02)) Q:'IB02  S IBPD=$G(^TMP("IBPR",$J,IB01,IB02)) D
 . S USER=$$GET1^DIQ(200,$P(IBPD,U,3)_",",.01)
 . S DATE=$$FMTE^XLFDT($P(IBPD,U,4),2)
 . I IB01=0 W $P(IBPD,U)_U_USER_U_DATE_U_$P(IBPD,U,7)_U_$S($P(IBPD,U,5)="":"<no previous value>",1:$P(IBPD,U,5))_U_$P(IBPD,U,6)
 . E  W $P(IBPD,U)_U_$P(IBPD,U,2)_U_USER_U_DATE_U_$P(IBPD,U,7)_U_$S($P(IBPD,U,5)="":"<no previous value>",1:$P(IBPD,U,5))_U_$P(IBPD,U,6)
 . W !
 ; -- write to screen
 I $E(IOST,1,2)["C-" W !,"[END OF REPORT]",! S DIR("A")="Press RETURN to continue" D PAUSE
 Q
