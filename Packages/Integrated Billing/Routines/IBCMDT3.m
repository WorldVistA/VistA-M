IBCMDT3 ;ALB/VD - INSURANCE PLANS MISSING DATA REPORT (PRINT) ; 10-APR-15
 ;;2.0;INTEGRATED BILLING ;**549,827**;21-MAR-94;Build 24
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^%DTC in ICR #10000
 ; Reference to ^DIR in ICR #10026
 ;
 ; Print the report.
 ;  Required Input:  Global print array ^TMP($J,"PR"
 ;
 ;
EN ; - Entry point to print report
 N EORMSG,IBHDT,NODATA
 N IBQUIT S IBQUIT=0  ;IB*827/DTG move new and set of IBQUIT from PRINT to here
 N IBXTFEED,IBLNC,MAXCNT S (IBXTFEED,IBLNC,MAXCNT)=""  ;IB*827/DTG new var's for line feeds and page breaks
 S MAXCNT=IOSL-3,IBXTFEED=21,IBLNC=0  ;IB*827/DTG correct line feeds
 I 'CRT S MAXCNT=IOSL-5,IBXTFEED=50
 S EORMSG="*** END OF REPORT ***"
 D NOW^%DTC S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 S NODATA=1
 D PRINT
 K ^TMP($J,"PR"),^TMP("IBCMDT",IBNMSPC)
 I NODATA D
 . N IBPAG
 . S IBPAG=0
 . D COMP
 ;IB*827/DTG manage EOR for IBQUIT
 ;W !!!,EORMSG
 ;D PAUSE
 I IBQUIT W !
 I 'IBQUIT D
 . W !!!,EORMSG
 . D PAUSE
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
 ;N CVLMRC,CVLPRT,CVSWT,IBC,IBCVLT,IBI,IBP,IBPAG,IBQUIT,NEWIC,POSWT,%
 N CVLMRC,CVLPRT,CVSWT,IBC,IBCVLT,IBI,IBP,IBPAG,NEWIC,POSWT,%  ;IB*827/DTG move new of IBQUIT to EN
 ;
 N IBOINS S IBOINS=""  ;IB*827/DTG new var for line feeds and page breaks
 ;
 N IBOLK S IBOLK=0  ;IB*827/DTG new counter for pause
 S (IBI,IBQUIT,IBPAG,CVLPRT,POSWT)=0,IBCVLT=""
 F  S IBI=$O(^TMP($J,"PR",IBI)) Q:('IBI!IBQUIT)  D
 . S IBC=$G(^TMP($J,"PR",IBI)),POSWT=+$P(IBC,U,1)
 . I $D(^TMP($J,"PR",IBI))=1 Q
 . S NODATA=0
 . ;D COMP D  Q:IBQUIT
 . D P0 Q:IBQUIT  D  Q:IBQUIT  ;IB*827/DTG increase checks for line pause
 . . S IBP=0
 . . S IBOLK=0,CVLPRT=0  ;IB*TBD/XXX value for pause
 . . ; plan
 . . ;F  S IBP=$O(^TMP($J,"PR",IBI,IBP)) Q:'IBP  D  Q:IBQUIT
 . . F  S IBP=$O(^TMP($J,"PR",IBI,IBP)) D:('IBP&('IBOLK)) P1  Q:'IBP  D  Q:IBQUIT  ;IB*827/DTG value for pause
 . . . S IBPD=$G(^TMP($J,"PR",IBI,IBP))
 . . . ;I $Y>(IOSL-5) D PAUSE Q:IBQUIT  D COMP
 . . . I $Y>(MAXCNT-($S('NEWIC:5,1:1))) D PAUSE Q:IBQUIT  S CVLPRT=0,IBOLK=1,IBOINS=0 D COMP S IBOINS=1  ;IB*827/DTG value for pause
 . . . S CVSWT=1 D PLAN
 . . . ; coverage
 . . . S IBCVLT=""
 . . . F  S IBCVLT=$O(^TMP($J,"PR",IBI,IBP,IBCVLT)) Q:IBCVLT=""  D  Q:IBQUIT
 . . . . S CVLMRC=$G(^TMP($J,"PR",IBI,IBP,IBCVLT))
 . . . . I $Y>(MAXCNT-($S(+CVSWT:4,1:0))) D PAUSE Q:IBQUIT  S CVLPRT=0,IBOLK=1,IBOINS=0 D COMP,PLAN,CVLMHD:'CVSWT S IBOINS=1  ;IB*827/DTG value for pause
 . . . . I +CVSWT D CVLMHD S CVSWT=0
 . . . . ;IB*827/DTG correct so that lines are in the capture buffer
 . . . . ;W !?4,$P(CVLMRC,U,1),?30,$P(CVLMRC,U,2),?50,$P(CVLMRC,U,3)
 . . . . W ?4,$P(CVLMRC,U,1),?30,$P(CVLMRC,U,2),?50,$P(CVLMRC,U,3),!
 . . . . I $Y>MAXCNT D PAUSE Q:IBQUIT  S CVLPRT=0,IBOLK=1,IBOINS=0 D COMP,PLAN,CVLMHD S IBOINS=1  ;IB*827/DTG value for pause
 . . . . S CVLPRT=1
 ;
 ;IB*827/DTG move new of IBQUIT to EN
 ;K IBC,IBCVLM,IBI,IBJJ,IBQUIT,IBP,IBPAG,IBPD,IBS,IBSD
 K IBC,IBCVLM,IBI,IBJJ,IBP,IBPAG,IBPD,IBS,IBSD
 Q
 ;
COMP ; Print Company header
 I IBOINS=1 W !! D COMPS S NEWIC=1 Q  ;IB*827/DTG for page breaks.
 ; Input:   NODATA - 1 if no data was found
 I CRT!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 ;IB*TBD/XXX fix extra line feed at top of display
 ;W !,"INSURANCE PLANS MISSING DATA"
 I 'CRT W !
 W "INSURANCE PLANS MISSING DATA"
 ;IB*827/DTG correct so that lines are in the capture buffer
 ;W ?80,IBHDT,?110,"Page: ",IBPAG
 ;W !,$G(SUBHD),!
 W ?80,IBHDT,?110,"Page: ",IBPAG,!
 W $G(SUBHD),!!
 I +$G(NODATA) D  Q
 . W !!!,"--- No Data To Report ---",!
 ;
 D COMPS  ;IB*827/DTG moved co info for page breaks.
 ; - sub-header
 ;W !?1,$P(IBC,U,2)_"  "_$P(IBC,U,3)_"  "_$P(IBC,U,4)
 ;I +POSWT W ?90,"PRESCRIPTION ONLY"
 S NEWIC=1
 Q
 ;
COMPS ; Print Company SUB header
 ;
 ; - sub-header
 ;IB*827/DTG correct so that lines are in the capture buffer
 W ?1,$P(IBC,U,2)_"  "_$P(IBC,U,3)_"  "_$P(IBC,U,4)
 I +POSWT W ?90,"PRESCRIPTION ONLY"
 W !
 Q
 ;
PLAN ; Print plan information.
 I CVLPRT W ! S CVLPRT=0
 I +NEWIC D
 . ;W !!?2,"GROUP NUMBER",?20,"GROUP NAME",?46,"TYPE OF PLAN",?62,"ELEC PLAN",?78,"FTF"
 . W !?2,"GROUP NUMBER",?20,"GROUP NAME",?46,"TYPE OF PLAN",?62,"ELEC PLAN",?78,"FTF"  ;IB*827/DTG line feeds
 . ;W:+$G(POSWT) ?98,"BIN",?109,"PCN"
 . W:+$G(POSWT) ?98,"BIN",?109,"PCN" W !
 . ;W !?2,"------------",?20,"----------",?46,"------------",?62,"---------",?78,"---"
 . W ?2,"------------",?20,"----------",?46,"------------",?62,"---------",?78,"---"  ;IB*827/DTG line feeds
 . ;W:+$G(POSWT) ?98,"---",?109,"---"
 . W:+$G(POSWT) ?98,"---",?109,"---" W !  ;IB*827/DTG line feeds
 ;W !?2,$P(IBPD,U,2),?20,$E($P(IBPD,U,3),1,25),?46,$E($P(IBPD,U,4),1,15)
 W ?2,$P(IBPD,U,2),?20,$E($P(IBPD,U,3),1,25),?46,$E($P(IBPD,U,4),1,15)  ;IB*827/DTG line feeds
 W ?62,$E($P(IBPD,U,5),1,15),?78,$P(IBPD,U,6)
 W:+$G(POSWT) ?98,$P(IBPD,U,7),?109,$P(IBPD,U,8)
 W !  ;IB*827/DTG correct so that lines are in the capture buffer
 ;
 S NEWIC=0
 Q
 ;
CVLMHD ; Print Coverage Limit sub-header
 ;W !!?4,"Coverage",?30,"Effective Date",?50,"Covered?"
 W !?4,"Coverage",?30,"Effective Date",?50,"Covered?",!  ;IB*827/DTG line feeds
 ;W !?4,"--------",?30,"--------------",?50,"--------"
 W ?4,"--------",?30,"--------------",?50,"--------"  ;IB*827/DTG line feeds
 W !  ;IB*827/DTG correct so that lines are in the capture buffer
 Q
 ;
P0 ; IB*827/DTG IBI check before pause
 ;
 N IBAC S IBAC=0
 I IBOINS=1&(IBOLK=1) S IBAC=1
 I $Y>(MAXCNT-7) S IBOINS=0
 I IBAC&('IBOINS) D PAUSE Q:IBQUIT
 D COMP
 S IBOINS=1
 Q
 ;
P1 ; IB*827/DTG IBP check before pause
 I $Y>(MAXCNT-($S('NEWIC:5,1:1))) D PAUSE
 Q
 ;
PAUSE ; Pause for screen output.
 N IBJJ,DIR,DIRUT,DTOUT,DUOUT  ;IB*TBD/XXX correct newing
 ;Q:$E(IOST,1,2)'["C-"
 ;F IBJJ=$Y:1:(IOSL-7) W !
 F IBJJ=$Y:1:IBXTFEED W !  ;IB*827/DTG don't allow to many line feeds
 Q:'CRT  ;IB*827/DTG need linefeeds if printed
 S DIR(0)="E" D ^DIR K DIR
 I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
