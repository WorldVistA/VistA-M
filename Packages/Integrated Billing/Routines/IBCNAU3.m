IBCNAU3 ;ALB/KML/AWC - eIV USER EDIT REPORT (PRINT) ;6-APRIL-2015
 ;;2.0;INTEGRATED BILLING;**528,602,664**;21-MAR-94;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;  Required variable input:  ALLUSERS, ALLINS, PLANS, ALLPLANS, EXCEL, ALLPYRS, REPTYP,  
 ;  ^TMP("IBINC",$J) 
 ;  ^TMP("IBPYR",$J)  ;/vd-IB*2*664 - Added this array
 ;  ^TMP("IBUSER",$J) 
 ;  DATE("START") and DATE("END") required array elements if all dates not selected
 Q
 ;
 ;EN(ALLPLANS,PLANS) ;
 ;/vd-IB*2*664 - Replaced the above line with the line below
EN(ALLPLANS,PLANS,ALLPYRS,REPTYP) ;
 ; Print the report.
 ;                  
 ;I EXCEL D EXCEL(PLANS) Q
 ;/vd-IB*2*664 - Replaced the line above with the line below
 I +$G(EXCEL) D EXCEL(PLANS,ALLPYRS,REPTYP) Q
 N IBI,IBJ,IBK,IBL,IBM,IB01,IB02,IBQUIT,IBPAG,IBPD,IBHDT
 S (IB02,IBQUIT,IBPAG)=0
 S IBHDT=$$FMTE^XLFDT($$NOW^XLFDT())
 ;
 ;D HDR(ALLPLANS,PLANS)
 ;I '$D(^TMP("IBPR",$J)) W !!,"User Edits do not exist per the selected filters." D PAUSE Q
 ;
 ;F IB01=0,1 F  S IB02=$O(^TMP("IBPR",$J,IB01,IB02)) Q:'IB02  Q:IBQUIT  S IBPD=$G(^TMP("IBPR",$J,IB01,IB02)) D  Q:IBQUIT
 ;. I $Y>(IOSL-5) D PAUSE Q:IBQUIT  D HDR(ALLPLANS,PLANS)
 ;. D PLAN
 ;vd-IB*2*664 - Replaced the above lines with the lines below:
 ;/IB*2*664 - Beginning of new code
 I REPTYP'=2 D  Q:IBQUIT  ; report for ins cos/plans or both was selected
 . D HDR(ALLPLANS,PLANS)
 . I '$D(^TMP("IBPR",$J)) W !!,"User Edits do not exist per the selected filters.",! Q
 . ;
 . F IB01=0,1 F  S IB02=$O(^TMP("IBPR",$J,IB01,IB02)) Q:'IB02  Q:IBQUIT  S IBPD=$G(^TMP("IBPR",$J,IB01,IB02)) D  Q:IBQUIT
 . . I $Y>(IOSL-5) D PAUSE Q:IBQUIT  D HDR(ALLPLANS,PLANS)
 . . D PLAN
 I REPTYP=1,'$D(^TMP("IBPR",$J)) G ENX
 ;
 I REPTYP'=1 D  Q:IBQUIT  ; report for eIV payers or both was selected
 . I REPTYP=3 D PAUSE
 . D HDR2(ALLPYRS)
 . I '$D(^TMP("IBPR2",$J)) W !!,"User Edits do not exist per the selected filters.",! Q
 . ;
 . F IB01=0,1 F  S IB02=$O(^TMP("IBPR2",$J,IB01,IB02)) Q:'IB02  Q:IBQUIT  S IBPD=$G(^TMP("IBPR2",$J,IB01,IB02)) D  Q:IBQUIT
 . . I $Y>(IOSL-5) D PAUSE Q:IBQUIT  D HDR2(ALLPYRS)
 . . D PAYER
 I REPTYP=2,'$D(^TMP("IBPR",$J)) G ENX
 ;
ENX ;/vd-IB*2.0*664 - End of new code.
 W !,"END OF REPORT",! D PAUSE
 Q
 ;
 ;
HDR(ALLPLANS,PLANS) ; Print REPORT header - /vd-IB*2.0*664 Replaced the variable IOM with the new variable WIDTH
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"USER EDIT REPORT"
 W ?WIDTH-34,IBHDT,?WIDTH-10,"Page: ",IBPAG
 W !?5,"Insurance Company"
 I PLANS W ?42,"Group Name"
 W !!?5,"User",?25,"Date/Time of Change",?49,"Modified Field",?75,"Previous Value of Data",?100,"Modified Value of Data"
 W !,$TR($J(" ",WIDTH)," ","_"),!
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
 ;/vd-IB*2*664 - Beginning of new code
HDR2(ALLPYRS) ; Print REPORT header - /vd-IB*2.0*664 Replaced the variable IOM with the new variable WIDTH
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"USER EDIT REPORT"
 W ?WIDTH-34,IBHDT,?WIDTH-10,"Page: ",IBPAG
 W !?5,"eIV Payer"
 W !!?5,"User",?25,"Date/Time of Change",?49,"Modified Field",?75,"Previous Value of Data",?100,"Modified Value of Data"
 W !,$TR($J(" ",WIDTH)," ","_"),!
 Q
 ;
PAYER ; Print plan information.
 N USER,DATE
 S USER=$$GET1^DIQ(200,$P(IBPD,U,2)_",",.01)
 S DATE=$$FMTE^XLFDT($P(IBPD,U,3),2),DATE=$TR(DATE,"@"," ")
 W !?5,$P(IBPD,U),?42,$S('IB01:"",1:$P(IBPD,U,2))
 W !?5,USER,?25,DATE,?49,$P(IBPD,U,6),?75,$S($P(IBPD,U,4)="":"<no previous value>",1:$P(IBPD,U,4)),?100,$P(IBPD,U,5),!!
 Q
 ;/vd-IB*2*664 - End of new code.
 ;
PAUSE ; Pause for screen output.
 Q:$E(IOST,1,2)'["C-"
 W !
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
 ;
 ;EXCEL(PLANS) ; user selected format that can be viewed in MS Excel
 ;/vd-IB*2*664 - Replaced the above line with the following line
EXCEL(PLANS,ALLPYRS,REPTYP) ; user selected format that can be viewed in MS Excel
 N IBI,IBJ,IBK,IBL,IBM,IB01,IB02,USER,DATE
 S (IB01,IB02)=0
 ; IB*602/HN ; Add report headers to Excel Spreadsheets 
 W !,"USER EDIT REPORT^"_$$FMTE^XLFDT($$NOW^XLFDT,1)
 ; IB*602/HN end  
 ;/vd-IB*2*664 - Beginning of new code.
 I REPTYP=1 W !,"For Insurance Companies/Plans"
 I REPTYP=2 W !,"For eIV Payers"
 I REPTYP=3 W !,"For Both Insurance Companies/Plans and eIV Payers"
 ;/vd-IB*2*664 - End of new code.
 ; 
 I REPTYP'=2 D
 . I PLANS W !,"Insurance Company^Group Name^User^Date/Time of Change^Modified Field^Previous Value of Data^Modified Value of Data",!
 . E  W !,"Insurance Company^User^Date/Time of Change^Modified Field^Previous Value of Data^Modified Value of Data",!
 ;
 F IB01=0,1 F  S IB02=$O(^TMP("IBPR",$J,IB01,IB02)) Q:'IB02  S IBPD=$G(^TMP("IBPR",$J,IB01,IB02)) D
 . S USER=$$GET1^DIQ(200,$P(IBPD,U,3)_",",.01)
 . S DATE=$$FMTE^XLFDT($P(IBPD,U,4),2)
 . I IB01=0 W $P(IBPD,U)_U_USER_U_DATE_U_$P(IBPD,U,7)_U_$S($P(IBPD,U,5)="":"<no previous value>",1:$P(IBPD,U,5))_U_$P(IBPD,U,6)
 . E  W $P(IBPD,U)_U_$P(IBPD,U,2)_U_USER_U_DATE_U_$P(IBPD,U,7)_U_$S($P(IBPD,U,5)="":"<no previous value>",1:$P(IBPD,U,5))_U_$P(IBPD,U,6)
 . W !
 ;
 ;/vd-IB*2.0*664 - Beginning of new code for Payer data.
 I REPTYP'=1 D
 . W !,"eIV Payer^User^Date/Time of Change^Modified Field^Previous Value of Data^Modified Value of Data",!
 . F IB01=0,1 F  S IB02=$O(^TMP("IBPR2",$J,IB01,IB02)) Q:'IB02  S IBPD=$G(^TMP("IBPR2",$J,IB01,IB02)) D
 . . S USER=$$GET1^DIQ(200,$P(IBPD,U,2)_",",.01)
 . . S DATE=$$FMTE^XLFDT($P(IBPD,U,3),2)
 . . W $P(IBPD,U)_U_USER_U_DATE_U_$P(IBPD,U,6)_U_$S($P(IBPD,U,4)="":"<no previous value>",1:$P(IBPD,U,4))_U_$P(IBPD,U,5)
 . . W !
 ;/vd-IB*2.0*664 - End of new code for Payer data.
 ;
 ; -- write to screen
 I $E(IOST,1,2)["C-" W !,"[END OF REPORT]",! S DIR("A")="Press RETURN to continue" D PAUSE
 Q
