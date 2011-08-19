IBARXMO1 ;LEX/WRC - PHARMACY CO-PAY CAP ;10/23/03
 ;;2.0;INTEGRATED BILLING;**259**;21-MAR-94
 ;
CALDT ;
 ;set dates min/max and calendar year
 S IBMIN=3011231
 D NOW^%DTC S IBCENYR=$E(X,1,3),IBCENYR=IBCENYR-1,IBMAX=IBCENYR_1231
 S DIR(0)="DOA^"_IBMIN_":"_IBMAX_":AEP^K:X'?2.4N X",DIR("A")="Enter the Two or Four Digit Calendar Year: "
 D ^DIR K DIR
 I Y<1 D KIL Q
 S IBCENYR=$E(Y,1,3),IBSMYR=IBCENYR_"0100",IBEMYR=IBCENYR_1231
 ;
ZIS S %IS="Q" D ^%ZIS
 K %H,%T I POP=1 D KIL Q
 I '$D(IO("Q")) U IO D STRT Q
 S ZTRTN="STRT^IBARXMO1",ZTIO=ION,ZTSAVE("IBSMYR")="",ZTSAVE("IBEMYR")=""
 D ^%ZTLOAD
 W:$D(ZTSK) !,"Request Queued!",!,"Task Number: "_ZTSK,!
 D KIL Q
 ;
STRT ;
 ;-set the annual billing cap in variable IBY
 S IBD=IBEMYR,IBP=2 D CAP^IBARXMC(IBD,IBP,.IBM,.IBY,.IBF,.IBT)
 S IBSITE=$P($$SITE^VASITE,"^",3) ;get the site's station number
 S (IBTNBOC,IBTV,IBTVC,IBAB,IBANB,IBA5,IBB5,IBA3)=0
 S IBDFN=0
 F  S IBDFN=$O(^IBAM(354.71,"AD",IBDFN)) Q:'IBDFN  D
 . S IBP=$$PRIORITY^IBARXMU(IBDFN)
 . I IBP<2!(IBP>6) Q
 . D IB350R
 . S IBTRDT=IBSMYR-1,IBTIEN=""
 . F  S IBTRDT=$O(^IBAM(354.71,"AD",IBDFN,IBTRDT)) Q:IBTRDT=""!(IBTRDT>IBEMYR)!($D(IBSLESS))  D
 .. F  S IBTIEN=$O(^IBAM(354.71,"AD",IBDFN,IBTRDT,IBTIEN)) Q:IBTIEN=""  D
 ... S IBTREC=$G(^IBAM(354.71,IBTIEN,0))
 ... I $P(IBTREC,"^",4)'="",($D(^TMP("IBARXMO1",$J,$P(IBTREC,"^",4)))) Q  ;ignore charge because "co-pay" cancellation (status=11) not in 354.71
 ... S IBTSTA=$E($P(IBTREC,"^",1),1,3) ;get the orginating station
 ... I IBTSTA<+IBSITE S IBSLESS=1 Q  ;if the vet was billed at a 'lesser site', don't count him here
 ... I IBTSTA=+IBSITE S IBSSITE=1 ;vet was billed at this site, so vet can be counted at this site
 ... S IBAB=IBAB+$P(IBTREC,"^",11) ;increment the total amount billed to the vet
 ... I IBAB=IBY!(IBAB>IBY),('$D(IBMRK)) S IBMRK=$P(IBTREC,"^",3) ;if the vet hit or exceeded the cap for the first time, set the date that occurred
 ... S IBANB=IBANB+$P(IBTREC,"^",12) ;increment the total amount not billed
 . I $D(IBSLESS) D RESET Q  ;vet to be counted at the 'lesser site'
 . I '$D(IBSSITE) D RESET Q  ;vet wasn't billed here at least once in the timeframe
 . I IBAB<.01 D RESET Q  ;vet wasn't billed
 . S IBTNBOC=IBTNBOC+IBANB ;increment 'Amount Above Cap'
 . S IBTV=IBTV+1 ;increment 'Veterans Billed the Co-payment'
 . I IBAB<IBY D  D RESET Q  ;if vet didn't reach the cap
 .. S IBA5=IBA5+IBAB ;increment the amounts billed to vets not reaching cap
 .. S IBB5=IBB5+1 ;increment # vets not reaching cap
 . I $D(IBMRK) S X1=IBMRK,X2=IBSMYR D ^%DTC S IBA3=IBA3+X ;calculate running total of time rquired by vet to reach the cap
 . S IBTVC=IBTVC+1 ;increment 'Veterans Reaching the Cap'
 . D RESET
 S IBAVGD=$S('IBTVC:0,1:IBA3/IBTVC) ;calculate 'Average Days Reaching Cap'
 S IBAVGBUC=$S('IBB5:0,1:IBA5/IBB5) ;calculate 'Average Billed to Those Not Reaching Cap'
 D PRINT
 ;
KIL I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 ;
 K %DT,IBSMYR,Y,IBEMYR,%IS,IBD,IBP,IBM,IBY,IBT,IBSITE,IBTNBOC,IBTV,IBTVC,IBAB,IBANB,IBA5,IBB5,IBA3,IBDFN,IBMRK,IBAVGD,IBAVGBUC,IBTRDT,IBTIEN,IBTREC,IBTSTA,X,IBPSMYR,IBPEMYR
 K DIR,POP,IBF,IBMIN,IBMAX,IBCENYR,IB350STD,IB350IEN,IB350R,X1,X2,X3,ZTIO,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("IBARXMO1",$J)
 Q
 ;
RESET ;
 S (IBAB,IBANB)=0
 K IBMRK,IBSLESS,IBSSITE
 Q
 ;
PRINT ;
 I $E(IOST,1,2)="C-" W @IOF,*13
 S IBSMYR=$E(IBSMYR,1,5)_"01"
 S Y=IBSMYR D DD^%DT S IBPSMYR=Y
 S Y=IBEMYR D DD^%DT S IBPEMYR=Y
 W !,?26,"FACILITY PHARMACY CO-PAY CAP"
 W !,?32,"SUMMARY REPORT"
 W !,?23,IBPSMYR," THROUGH ",IBPEMYR
 D NOW^%DTC S Y=X D DD^%DT W !,?29,"RUN DATE: ",Y,!!
 W !,"Total Vets Billed:" S X=IBTV,X2=0,X3=20 D COMMA^%DTC W ?50,X
 W !,"Total Vets At or Above the Cap:" S X=IBTVC,X2=0,X3=20 D COMMA^%DTC W ?50,X
 W !,"Average Number of Days to Reach Cap:" S X=IBAVGD,X2=0,X3=20 D COMMA^%DTC W ?50,X
 W !,"Average Amount Charged to Those Not Reaching Cap:" S X=IBAVGBUC,X2="2$",X3=20 D COMMA^%DTC W ?50,X
 W !,"Potential Billable Amount:" S X=IBTNBOC,X2="2$",X3=20 D COMMA^%DTC W ?50,X
 I $E(IOST,1,2)="C-" W !! S DIR(0)="E" D ^DIR
 Q
IB350R ;
 ;build array of "co-pay" cancellations (status=11) not in 354.71
 ;
 K ^TMP("IBARXMO1",$J)
 S IB350STD=IBSMYR
 F  S IB350STD=$O(^IB("APTDT",IBDFN,IB350STD)) Q:IB350STD=""!(IB350STD>IBEMYR)  D
 . S IB350IEN=""
 . F  S IB350IEN=$O(^IB("APTDT",IBDFN,IB350STD,IB350IEN)) Q:'IB350IEN  D
 .. S IB350R=$G(^IB(IB350IEN,0))
 .. I $P(IB350R,"^",5)'=11 Q
 .. I $P(IB350R,"^",9)'="" S ^TMP("IBARXMO1",$J,$P(IB350R,"^",9))=""
 Q
