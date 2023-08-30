IBCNAU3 ;ALB/KML/AWC - USER EDIT REPORT (PRINT) ;6-APRIL-2015
 ;;2.0;INTEGRATED BILLING;**528,602,664,737**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;  Required variable input:  ALLUSERS, ALLINS, PLANS, ALLPLANS, EXCEL, ALLPYRS, REPTYP,  
 ;  ^TMP("IBINC",$J) 
 ;  ^TMP("IBPYR",$J)  ;/vd-IB*2*664 - Added this array
 ;  ^TMP("IBUSER",$J) 
 ;  DATE("START") and DATE("END") required array elements if all dates not selected
 ;
 ; REPTYP (1=Ins. Company/Plans only; 2=Payers only; 3=both, Ins. Company/Plans & Payers)
 ;
 ;IB*732/CKB - references to 'eIV Payer' should be changed to 'Payer' in order
 ; to include 'IIU payers'
 Q
 ;
 ;EN(ALLPLANS,PLANS) ;
 ;/vd-IB*2*664 - Replaced the above line with the line below
EN(ALLPLANS,PLANS,ALLPYRS,REPTYP) ;
 ; Print the report.
 ;                  
 ;I EXCEL D EXCEL(PLANS) Q
 ;/vd-IB*2*664 - Replaced the line above with the line below
 ;I +$G(EXCEL) D EXCEL(PLANS,ALLPYRS,REPTYP) Q
 I +$G(EXCEL) D EXCEL(PLANS,ALLPYRS,REPTYP) G ENOUT  ; IB*737/DTG new exit point for cleanup
 N IBI,IBJ,IBK,IBL,IBM,IB01,IB02,IBQUIT,IBPAG,IBPD,IBHDT
 S (IB02,IBQUIT,IBPAG)=0
 S IBHDT=$$FMTE^XLFDT($$NOW^XLFDT())
 D PRINT G ENOUT:IBQUIT  ; IB*737/DTG added tag to better control the quit.
 G ENX
 ;
PRINT ; IB*737/DTG new tag for better control of quits
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
 . I '$D(^TMP("IBPR",$J)) W !!,"User Edits do not exist per the selected filters.",!! Q  ;IB*737/DTG added additional line feed at end
 . ;
 . F IB01=0,1 F  S IB02=$O(^TMP("IBPR",$J,IB01,IB02)) Q:'IB02  Q:IBQUIT  S IBPD=$G(^TMP("IBPR",$J,IB01,IB02)) D  Q:IBQUIT
 . . I $Y>(IOSL-5) D PAUSE Q:IBQUIT  D HDR(ALLPLANS,PLANS)
 . . D PLAN
 ;I REPTYP=1,'$D(^TMP("IBPR",$J)) G ENX
 I REPTYP=1,'$D(^TMP("IBPR",$J)) Q  ; IB*737/DTG quit back
 ;
 ;IB*737/CKB
 I REPTYP'=1 D  Q:IBQUIT  ; report for payers or both was selected
 . I REPTYP=3 D PAUSE
 . D HDR2(ALLPYRS)
 . I '$D(^TMP("IBPR2",$J)) W !!,"User Edits do not exist per the selected filters.",!! Q  ;IB*737/DTG added additional line feed at end
 . ;
 . F IB01=0,1 F  S IB02=$O(^TMP("IBPR2",$J,IB01,IB02)) Q:'IB02  Q:IBQUIT  S IBPD=$G(^TMP("IBPR2",$J,IB01,IB02)) D  Q:IBQUIT
 . . I $Y>(IOSL-5) D PAUSE Q:IBQUIT  D HDR2(ALLPYRS)
 . . D PAYER
 ;I REPTYP=2,'$D(^TMP("IBPR",$J)) G ENX
 I REPTYP=2,'$D(^TMP("IBPR",$J)) Q  ; IB*737/DTG quit back
 ;
 Q  ; IB*737/DTG quit back
 ;
ENX ;/vd-IB*2.0*664 - End of new code.
 W "END OF REPORT" D PAUSE
 ;Q
 G ENOUT  ; IB*737/DTG new exit point for cleanup
 ;
 ;
HDR(ALLPLANS,PLANS) ; Print REPORT header - /vd-IB*2.0*664 Replaced the variable IOM with the new variable WIDTH
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"USER EDIT REPORT"
 W ?WIDTH-34,IBHDT,?WIDTH-10,"Page: ",IBPAG
 ;IB*737/DTG reduce indent by 5 for ins line, 3 for user line
 ;W !?5,"Insurance Company"
 W !,"Insurance Company"
 ;I PLANS W ?42,"Group Name"
 I PLANS W ?37,"Group Name"
 ;W !!?5,"User",?25,"Date/Time of Change",?49,"Modified Field",?75,"Previous Value of Data",?100,"Modified Value of Data"
 W !!,?2,"User",?22,"Date/Time of Change",?46,"Modified Field",?72,"Previous Value of Data"
 W ?103,"Modified Value of Data"
 W !,$TR($J(" ",WIDTH)," ","_"),!
 Q
 ;
PLAN ; Print plan information.
 N USER,DATE
 S USER=$$GET1^DIQ(200,$P(IBPD,U,3)_",",.01)
 S DATE=$$FMTE^XLFDT($P(IBPD,U,4),2),DATE=$TR(DATE,"@"," ")
 ;IB*737/DTG reduce indent by 5 for ins line, 3 for user line
 ;W !?5,$P(IBPD,U),?42,$S('IB01:"",1:$P(IBPD,U,2))
 W !,$P(IBPD,U)
 I PLANS W ?37,$S($P(IBPD,U,8)=36:"INS CO EDITS",'IB01:"",1:$P(IBPD,U,2))  ; IB*737/DTG co. level if file 36 flag
 ;W !?5,USER,?25,DATE,?49,$P(IBPD,U,7),?75,$S($P(IBPD,U,5)="":"<no previous value>",1:$P(IBPD,U,5)),?100,$P(IBPD,U,6),!!
 W !,?2,USER,?22,DATE,?46,$P(IBPD,U,7),?72,$S($P(IBPD,U,5)="":"<no previous value>",1:$E($P(IBPD,U,5),1,29))
 W ?103,$E($P(IBPD,U,6),1,29),!!
 Q
 ;
 ;/vd-IB*2*664 - Beginning of new code
HDR2(ALLPYRS) ; Print REPORT header - /vd-IB*2.0*664 Replaced the variable IOM with the new variable WIDTH
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"USER EDIT REPORT"
 W ?WIDTH-34,IBHDT,?WIDTH-10,"Page: ",IBPAG
 ;IB*737/DTG reduce indent by 5 for ins line, 3 for user line
 ;W !?5,"Payer"
 W !,"Payer"
 ;W !!?5,"User",?25,"Date/Time of Change",?49,"Modified Field",?75,"Previous Value of Data",?100,"Modified Value of Data"
 W !!,?2,"User",?22,"Date/Time of Change",?46,"Modified Field"
 W ?72,"Previous Value of Data",?103,"Modified Value of Data"
 W !,$TR($J(" ",WIDTH)," ","_"),!
 Q
 ;
PAYER ; Print plan information.
 N USER,DATE
 S USER=$$GET1^DIQ(200,$P(IBPD,U,2)_",",.01)
 S DATE=$$FMTE^XLFDT($P(IBPD,U,3),2),DATE=$TR(DATE,"@"," ")
 ;IB*737/DTG reduce indent by 5 for ins line, 3 for user line
 ;W !?5,$P(IBPD,U),?42,$S('IB01:"",1:$P(IBPD,U,2))
 W !,$P(IBPD,U)
 I PLANS W ?37,$S($P(IBPD,U,8)=36:"INS CO EDITS",'IB01:"",1:$P(IBPD,U,2))
 ;W !?5,USER,?25,DATE,?49,$P(IBPD,U,6),?75,$S($P(IBPD,U,4)="":"<no previous value>",1:$P(IBPD,U,4)),?100,$P(IBPD,U,5),!!
 W !,?2,USER,?22,DATE,?46,$P(IBPD,U,6),?72,$S($P(IBPD,U,4)="":"<no previous value>",1:$E($P(IBPD,U,4),1,29))
 W ?103,$E($P(IBPD,U,5),1,29),!!
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
 N IBPL  ;IB*737/DTG for use with plan/group
 S (IB01,IB02)=0
 ; IB*602/HN ; Add report headers to Excel Spreadsheets 
 W !,"USER EDIT REPORT^"_$$FMTE^XLFDT($$NOW^XLFDT,1)
 ; IB*602/HN end  
 ;/vd-IB*2*664 - Beginning of new code.
 I REPTYP=1 W !,"For Insurance Companies/Plans"
 ;IB*737/CKB
 I REPTYP=2 W !,"For Payers"
 I REPTYP=3 W !,"For Both Insurance Companies/Plans and Payers"
 ;/vd-IB*2*664 - End of new code.
 ;
 I REPTYP'=2 D
 . I PLANS W !,"Insurance Company^Group Name^User^Date/Time of Change^Modified Field^Previous Value of Data^Modified Value of Data",!
 . E  W !,"Insurance Company^User^Date/Time of Change^Modified Field^Previous Value of Data^Modified Value of Data",!
 ;
 ;IB*737/CKB - Insurance Company, no data found
 I REPTYP'=2 I '$D(^TMP("IBPR",$J)) W !,"User Edits do not exist per the selected filters.",!
 ;
 S IBQUIT=0  ; IB*737/DTG for page check if crt
 F IB01=0,1 F  S IB02=$O(^TMP("IBPR",$J,IB01,IB02)) Q:'IB02  S IBPD=$G(^TMP("IBPR",$J,IB01,IB02)) D  Q:IBQUIT  ;IB*737/DTG screen check
 . S USER=$$GET1^DIQ(200,$P(IBPD,U,3)_",",.01)
 . S DATE=$$FMTE^XLFDT($P(IBPD,U,4),2)
 . ;IB*737/DTG change to if else
 . ;I IB01=0 W $P(IBPD,U)_U_USER_U_DATE_U_$P(IBPD,U,7)_U_$S($P(IBPD,U,5)="":"<no previous value>",1:$P(IBPD,U,5))_U_$P(IBPD,U,6)
 . ;E  W $P(IBPD,U)_U_$P(IBPD,U,2)_U_USER_U_DATE_U_$P(IBPD,U,7)_U_$S($P(IBPD,U,5)="":"<no previous value>",1:$P(IBPD,U,5))_U_$P(IBPD,U,6)
 . I IB01=0 D
 . . W $P(IBPD,U)_U_USER_U_DATE_U_$P(IBPD,U,7)_U
 . . W $S($P(IBPD,U,5)="":"<no previous value>",1:$P(IBPD,U,5))_U_$P(IBPD,U,6)
 . I IB01'=0 D
 . . W $P(IBPD,U)_U
 . . S IBPL="",IBPL=$S($P(IBPD,U,8)=36:"INS CO EDITS",1:$P(IBPD,U,2))
 . . S:IBPL="NO PLANS SELECTED" IBPL="" W IBPL_U
 . . W USER_U_DATE_U_$P(IBPD,U,7)_U_$S($P(IBPD,U,5)="":"<no previous value>",1:$P(IBPD,U,5))_U
 . . W $P(IBPD,U,6)
 . W !
 . I ($Y#($G(IOSL)-5))=0 S IBQUIT=0 D EXLCK Q:IBQUIT  ;IB*737/DTG screen check
 ;
 I IBQUIT Q  ;IB*737/DTG quit if screen and exit.
 ;
 ;/vd-IB*2.0*664 - Beginning of new code for Payer data.
 I REPTYP'=1 D
 . ;IB*737/CKB
 . W !,"Payer^User^Date/Time of Change^Modified Field^Previous Value of Data^Modified Value of Data",!
 . ;IB*737/CKB - Payer, no data found
 . I '$D(^TMP("IBPR2",$J)) W !,"User Edits do not exist per the selected filters.",! Q
 . F IB01=0,1 F  S IB02=$O(^TMP("IBPR2",$J,IB01,IB02)) Q:'IB02  S IBPD=$G(^TMP("IBPR2",$J,IB01,IB02)) D  Q:IBQUIT  ;IB*737/DTG screen check
 . . S USER=$$GET1^DIQ(200,$P(IBPD,U,2)_",",.01)
 . . S DATE=$$FMTE^XLFDT($P(IBPD,U,3),2)
 . . W $P(IBPD,U)_U_USER_U_DATE_U_$P(IBPD,U,6)_U_$S($P(IBPD,U,4)="":"<no previous value>",1:$P(IBPD,U,4))_U_$P(IBPD,U,5)
 . . W !
 . . I ($Y#($G(IOSL)-5))=0 S IBQUIT=0 D EXLCK Q:IBQUIT
 ;/vd-IB*2.0*664 - End of new code for Payer data.
 ;
 ; -- write to screen
 ;I $E(IOST,1,2)["C-" W !,"[END OF REPORT]",! S DIR("A")="Press RETURN to continue" D PAUSE
EXEOR ;IB*737/CKB - called if no data was found
 W "[END OF REPORT]",!
 D EXLCK  ;IB*737/DTG include EOR on excel queued check for pause
 Q
 ;
EXLCK ; IB*737/DTG new tag for excel to check for pause
 ;
 I $E(IOST,1,2)["C-" S DIR("A")="Press RETURN to continue" D PAUSE W !
 Q
 ;
ENOUT ; IB*737/DTG new TAG to cleanup temp files on exit.
 ;
 ;clear temp files
 K ^TMP("IBPYR",$J),^TMP("IBINC",$J),^TMP("IBUSER",$J),^TMP("IBPR",$J),^TMP("IBPR2",$J),^TMP($J)
 K ^TMP("IBPRINS",$J) ; IB*737/DTG to track which DIA(36,"B",INSIENS have been picked up
 Q
 ;
