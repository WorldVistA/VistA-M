IBCMDT3 ;ALB/VD - INSURANCE PLANS MISSING DATA REPORT (PRINT) ; 10-APR-15
 ;;2.0;INTEGRATED BILLING ;**549**; 10-APR-15;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Print the report.
 ;  Required Input:  Global print array ^TMP($J,"PR"
 ;
 ;
EN ; - Entry point to print report
 N EORMSG,IBHDT,NODATA
 S EORMSG="*** END OF REPORT ***"
 D NOW^%DTC S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 S NODATA=1
 D PRINT
 K ^TMP($J,"PR"),^TMP("IBCMDT",IBNMSPC)
 I NODATA D
 . N IBPAG
 . S IBPAG=0
 . D COMP
 W !!!,EORMSG
 D PAUSE
 ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 ; Close Device
 D ^%ZISC
 Q
 ;
PRINT ; Print report
 ; Input:   NODATA  - Set to 1 initially
 ; Output:  NODATE  - Set to 1 if at least one Insurance Company
 ;                    with data found
 N CVLMRC,CVLPRT,CVSWT,IBC,IBCVLT,IBI,IBP,IBPAG,IBQUIT,NEWIC,POSWT,%
 S (IBI,IBQUIT,IBPAG,CVLPRT,POSWT)=0,IBCVLT=""
 F  S IBI=$O(^TMP($J,"PR",IBI)) Q:('IBI!IBQUIT)  D
 . S IBC=$G(^TMP($J,"PR",IBI)),POSWT=+$P(IBC,U,1)
 . I $D(^TMP($J,"PR",IBI))=1 Q
 . S NODATA=0
 . D COMP D  Q:IBQUIT
 . . S IBP=0
 . . F  S IBP=$O(^TMP($J,"PR",IBI,IBP)) Q:'IBP  D  Q:IBQUIT
 . . . S IBPD=$G(^TMP($J,"PR",IBI,IBP))
 . . . I $Y>(IOSL-5) D PAUSE Q:IBQUIT  D COMP
 . . . S CVSWT=1 D PLAN
 . . . S IBCVLT=""
 . . . F  S IBCVLT=$O(^TMP($J,"PR",IBI,IBP,IBCVLT)) Q:IBCVLT=""  D  Q:IBQUIT
 . . . . S CVLMRC=$G(^TMP($J,"PR",IBI,IBP,IBCVLT))
 . . . . I +CVSWT D CVLMHD S CVSWT=0
 . . . . W !?4,$P(CVLMRC,U,1),?30,$P(CVLMRC,U,2),?50,$P(CVLMRC,U,3)
 . . . . S CVLPRT=1
 ;
 K IBC,IBCVLM,IBI,IBJJ,IBQUIT,IBP,IBPAG,IBPD,IBS,IBSD
 Q
 ;
COMP ; Print Company header
 ; Input:   NODATA - 1 if no data was found
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"INSURANCE PLANS MISSING DATA"
 W ?80,IBHDT,?110,"Page: ",IBPAG
 W !,$G(SUBHD),!
 I +$G(NODATA) D  Q
 . W !!!,"--- No Data To Report ---",!
 ;
 ; - sub-header
 W !?1,$P(IBC,U,2)_"  "_$P(IBC,U,3)_"  "_$P(IBC,U,4)
 I +POSWT W ?90,"PRESCRIPTION ONLY"
 S NEWIC=1
 Q
 ;
PLAN ; Print plan information.
 I CVLPRT W ! S CVLPRT=0
 I +NEWIC D
 . W !!?2,"GROUP NUMBER",?20,"GROUP NAME",?46,"TYPE OF PLAN",?62,"ELEC PLAN",?78,"FTF"
 . W:+$G(POSWT) ?98,"BIN",?109,"PCN"
 . W !?2,"------------",?20,"----------",?46,"------------",?62,"---------",?78,"---"
 . W:+$G(POSWT) ?98,"---",?109,"---"
 W !?2,$P(IBPD,U,2),?20,$E($P(IBPD,U,3),1,25),?46,$E($P(IBPD,U,4),1,15)
 W ?62,$E($P(IBPD,U,5),1,15),?78,$P(IBPD,U,6)
 W:+$G(POSWT) ?98,$P(IBPD,U,7),?109,$P(IBPD,U,8)
 S NEWIC=0
 Q
 ;
CVLMHD ; Print Coverage Limit sub-header
 W !!?4,"Coverage",?30,"Effective Date",?50,"Covered?"
 W !?4,"--------",?30,"--------------",?50,"--------"
 Q
 ;
PAUSE ; Pause for screen output.
 Q:$E(IOST,1,2)'["C-"
 F IBJJ=$Y:1:(IOSL-7) W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
