PSALOG1H ;BIR/LTL,JMB-Unposted Procurement History - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;This routine prints the pharmacy procurement history High Cost Items
 ;report for a selected month. It is called by PSALOG.
 ;
HIGH S PSAPG=0 D HDR
 ;If the "PSA" array does not exist, the "PSAC" array cannot be created.
 I '$D(^TMP("PSA",$J)) W !!,"No items were found for the selected month." G END^PSALOG0
 ;If the "PSA" array exists, the "PSAC" does not exit, and the user
 ;requested the Item Totals report, the routine attempted to create
 ;the "PSAC" array and found no data.
 I $D(^TMP("PSA",$J)),'$D(^TMP("PSAC",$J)),$G(PSATOTAL) W !!,"No items were found for the selected month." G END^PSALOG0
 ;If the "PSA" array exists, the "PSAC" does not exit, and the user
 ;did not request the Item Totals report, create the "PSAC" array.
 I $D(^TMP("PSA",$J)),'$D(^TMP("PSAC",$J)),'$G(PSATOTAL) D CREATE
 I '$D(^TMP("PSAC",$J)) W !!,"No items were found for the selected month." G END^PSALOG0
 S PSAINVO=0 F  S PSAINVO=+$O(^TMP("PSAC",$J,PSAINVO)) Q:'PSAINVO!(PSAOUT)  D
 .D:$Y+4>IOSL HDR Q:PSAOUT
 .S PSAITEM="" F  S PSAITEM=$O(^TMP("PSAC",$J,PSAINVO,PSAITEM)) Q:PSAITEM=""  D
 ..Q:$G(^TMP("PSAC",$J,PSAINVO,PSAITEM))<PSALOW
 ..W !,$E(PSAITEM,1,56)
 ..S X=$P($G(^TMP("PSAC",$J,PSAINVO,PSAITEM)),"^"),X2="2$" D COMMA^%DTC
 ..W ?58,X,"(",$P($G(^TMP("PSAC",$J,PSAINVO,PSAITEM)),"^",2),")",!
 G END^PSALOG0
HDR I $E(IOST,1,2)="C-",PSAPG D  Q:PSAOUT
 .S PSASS=22-$Y F PSAKK=1:1:PSASS W !
 .S DIR(0)="E" D ^DIR K DIR S:'Y PSAOUT=1
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),"^"),"." S PSAOUT=1 Q
 W:$Y @IOF S PSAPG=PSAPG+1
 W:$E(IOST)'="C" !!,PSARPDT W:$E(IOST,1,2)="C-" !
 W ?20,"DRUG ACCOUNTABILITY/INVENTORY INTERFACE",?72,"PAGE ",$J(PSAPG,2)
 W !?((80-(65+$L(PSALOW)))/2),"UNPOSTED PHARMACY PROCUREMENTS FOR "_PSAMOYR_" HIGH COST ITEMS OVER $",PSALOW
 W !!?1,"ITEM NAME",?61,"TOTAL ITEM COST",!,PSADLN
 Q
CREATE ;Create the "PSAC" array.
 S PSACP=0 F  S PSACP=$O(^TMP("PSA",$J,PSACP)) Q:'PSACP  D
 .S PSAITEM="" F  S PSAITEM=$O(^TMP("PSA",$J,PSACP,PSAITEM)) Q:PSAITEM']""  S PSAIEN=0 F  S PSAIEN=$O(^TMP("PSA",$J,PSACP,PSAITEM,PSAIEN)) Q:'PSAIEN  D
 ..S PSATMP=$G(^TMP("PSA",$J,PSACP,PSAITEM,PSAIEN))
 ..S PSATOTO=$G(PSATOTO)+($P(PSATMP,"^",2)*$P(PSATMP,"^",9))
 ..I '$O(^TMP("PSA",$J,PSACP,PSAITEM,PSAIEN)) S ^TMP("PSAC",$J,(999999999-PSATOTO),PSAITEM)=PSATOTO_"^"_PSACP K PSATOTO
 Q
