IBQLT ;LEB/MRY - TRANSMIT DATA ; 24-APR-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;**1,2**;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; 
 I '$D(DT) D DT^DICRW
 ;D PULL^IBQLPL
 W !!,"Transmit Rollup Data",!
 ;W !,"The next National Rollup will be " S Y=IBBDT X ^DD("DD") W Y_" to " S Y=IBEDT X ^DD("DD") W Y
 ;I IBMSG'="" W !!,IBMSG,!,IBMSG1
 ;
DEC95 ;; -- per Directive ....
 ;; -- until 1/1/96, allow sites to transmit previous rollup periods.
 ;I DT<2960101,DT<2951116 D ASK^IBQLT5 G:IBQUIT END
 ;I DT<2960101,DT>2951115 D ASK^IBQLT5A G:IBQUIT END
 ;
 ; - ask user for roll-up period to be transmitted
 D RANGE^IBQLT5 G:IBQUIT END
 ;
 F I="IBBDT","IBEDT" S ZTSAVE(I)=""
 S ZTRTN="START^IBQLT",ZTDESC="IBQ - TRANSMIT ROLLUP DATA",ZTIO=""
 W ! D ^%ZTLOAD G END
 ;
START ;
 S IBDDT=IBBDT-.01,IBCNT=0,IBREC=0
 S IBCNT=1,^TMP("IBQLT",$J,IBCNT,0)="**"_"^"_IBBDT_"^"_IBEDT
 F  S IBDDT=$O(^IBQ(538,"ADIS",IBDDT)) Q:'IBDDT!(IBDDT>IBEDT)  D
 .S IBTRN="" F  S IBTRN=$O(^IBQ(538,"ADIS",IBDDT,IBTRN)) Q:'IBTRN  D DATA
 ;
 ; -- transmit data thru mailman handler
 D TRANSMIT
 ;
END K ^TMP("IBQLT",$J),^TMP("IBQ",$J),IBDDT,IBTRN,INTRND0,IBTRND1,IBTRND2,IBREC,IBCNT,IBBDT1,IBEDT1
 K IBBDT,IBEDT,IBMSG,IBMSG1,IBRDT1,IBQUIT
 Q
 ;
 ;
DATA ; -- build ^tmp($j,cnt,0) and ^tmp("ibql",$j,cnt,0) for mailman handler.
 ; IBTRND0 = entry id^site^ssn^admitting diagnosis^enroll code^
 ;           admitting phy^attending phy^resident phy,^admission^
 ;          discharge^ward^treating specialty^acute adm?^
 ; IBTRND1 = si from adm^is from adm^reasons from adm^
 ;          provider interviewed?^adm influenced?^rollup type^service
 ; IBTRND2 = day^is^si^d/s^interviewed?^reasons^service
 ;
 I '$G(^IBQ(538,IBTRN,0))!($P(^(1),"^",6)="L") Q
 S IBREC=IBREC+1,IBTRND0=^IBQ(538,IBTRN,0),IBTRND1=$G(^(1))
 I '$P(IBTRND0,"^",2) S $P(IBTRND0,"^",2)=$P($$SITE^VASITE,"^")
 ; -- null out unwanted field entries from transmission.
 ; -- admitting phy,attending phy,resident phy,ward
 F I=6,7,8,11 S $P(IBTRND0,"^",I)=""
 S IBCNT=IBCNT+1,^TMP("IBQLT",$J,IBCNT,0)=IBTRND0_"^"_IBTRND1
 ; -- continued stay reviews
 S N=0 F  S N=$O(^IBQ(538,IBTRN,13,N)) Q:'N  D
 .S IBTRND2=^IBQ(538,IBTRN,13,N,0),$P(IBTRND2,"^")=$P(IBTRND0,"^")_"."_$P(IBTRND2,"^")
 .S IBCNT=IBCNT+1,^TMP("IBQLT",$J,IBCNT,0)=IBTRND2
 Q
 ;
TRANSMIT ;  
 ; -- transmit data to National DataBase
 S Y=IBBDT X ^DD("DD") S IBBDT1=Y S Y=IBEDT X ^DD("DD") S IBEDT1=Y
 S XMY("S.IBQN SERVER@ISC-CHICAGO.VA.GOV")="",XMDUZ="UTILIZATION MANAGEMENT ROLLUP MONITOR"
 S XMTEXT="^TMP(""IBQLT"",$J,",XMSUB="Rollup Extract" D ^XMD
 ; -- transmit local message
 S XMY("G.IBQ ROLLUP")=""
 S XMSUB="Rollup Extract transmitted",XMDUZ="IBQ MONITOR"
 S ^TMP("IBQ",$J,1,0)="Utilization Management Rollup was transmitted.",^TMP("IBQ",$J,2,0)=""
 S ^TMP("IBQ",$J,3,0)="Site: "_$P($$SITE^VASITE,"^"),^TMP("IBQ",$J,5,0)="Number of Records sent: "_IBREC
 S ^TMP("IBQ",$J,6,0)="Period: "_IBBDT1_" - "_IBEDT1
 S XMTEXT="^TMP(""IBQ"",$J," D ^XMD
 Q
