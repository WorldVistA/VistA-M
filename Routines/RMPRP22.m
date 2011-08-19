RMPRP22 ;PHX/RFM-CONT RMPRP21 ;8/29/1994
 ;;3.0;PROSTHETICS;**3**;Feb 09, 1996
 S RO=0 F I=1:1 S RO=$O(R664(1,RO)) Q:RO'>0  D  Q:$D(J1)
 .I I>4 S J1=1 W !!,?9,"***SEE ATTACHED CONTINUATION SHEET FOR ITEM DESCRIPTION(S)***",!! Q
 .I $D(R664(1,RO,1,0)) S RP=0 F J=1:1 S RP=$O(R664(1,RO,1,RP)) Q:RP=""  D  Q:$D(J1)
 ..I I>4!((J+I)>4) S J1=1 W !!,?9,"***SEE ATTACHED CONTINUATION SHEET FOR ITEM DESCRIPTION(S)***",!! Q
 D ADD
 S RO=0 F  S RO=$O(R664(1,RO)) Q:RO'>0  D:'$D(RMPRMOR)&($Y>36) CONT D:$D(RMPRMOR)&($Y>58) CONT D:'$D(RMPRMOR) ADD D START
 I '$D(RMPRMOR)&($Y<37) F  W ! Q:$Y>36
 Q
START W !,"#"_RO_"."
 W ?4,$P(R664(1,RO,0),U,2)
 W ?50,$J($P(R664(1,RO,0),U,4),6) S RMPRUT=$P(R664(1,RO,0),U,5) W:$D(^PRCD(420.5,+RMPRUT,0)) ?61,$P(^PRCD(420.5,+RMPRUT,0),U,1),?65,$J($FN($P(R664(1,RO,0),U,3),"P",2),6)
ZWE S RMPRTOT=$P(R664(1,RO,0),U,3)*$P(R664(1,RO,0),U,4) W ?72,$J($FN(RMPRTOT,"P",2),8) D EXT
 Q
EXT ;CHECKING FOR EXTENDED DESCRIPTION
 S RMPRCH=$G(R664(1,RO,1,0)) Q:RMPRCH=""  S (RMPR90,RMPRX)=$Q(R664(1,RO,0,0)),RMPRX=$E(RMPRX,1,10) Q:RMPR90=""  F  S RMPR90=$Q(@RMPR90) Q:RMPRX'=$E(RMPR90,1,10)  D:$D(RMPRMOR)&($Y>58) CONT D:'$D(RMPRMOR)&($Y>36) CONT D WRI
 Q
WRI ;CONTINUATION OF 10-2421
 W !,@RMPR90 Q
CONT D:'$D(RMPRMOR) CON W @IOF,!,"CONTINUATION OF 2421",?27,"ORDER NUMBER: ",RTN,?71,"PAGE ",RMPRPAGE S RMPRMOR=1,RMPRPAGE=RMPRPAGE+1 D HDR^RMPRP21
 Q
ADD S (RMPRAMT2,RMPRAMT,RMPRAMT1,RMPRAMTN)=0
 S RC=0 F  S RC=$O(R664(1,RC)) Q:RC=""!(RC["B")  D ADD1
 I $D(R664(2)) S RMPRDISC=$S($P(R664(2),U,6)'="":$P(R664(2),U,6),1:"") I $D(RMPRDISC) S RMPRAMT2=$J(RMPRDISC*RMPRAMT/100,0,2),RMPRAMTN=RMPRAMT-$J(RMPRAMT2,0,2),RMPRAMTN=$J(RMPRAMTN+$P(R664(0),U,10),0,2) Q
 Q
ADD1 S RMPRAMT1=$J($P(R664(1,RC,0),U,4)*$P(R664(1,RC,0),U,3),0,2) S RMPRAMT=RMPRAMT+RMPRAMT1 Q
CON ;CONTINUATION OF 2421
 W !,RMPRB,!,"16. Contract Number: " S RO("C")=$O(R664(1,0)) W:RO("C") $P(R664(1,RO("C"),0),U,14) W ?61,"Subtotal: ",$J($FN(RMPRAMT,"P",2),8)
 W !,"    ACCT.#: ",RMPRVACN K RMPRVACN
 W ?28,"Discount $" I $D(RMPRAMT2) W $J($FN(RMPRAMT2,"P",2),7)
 W ?45,"Shipping: ",$J($FN($P(R664(0),U,10),"P",2),5)
 W ?62,"Total",?69,"$",$J($FN(RMPRAMTN,"P",2),9)
 W !,RMPRB,!,"17. Signature and Title of"
 W ?28,"18. DATE",?39,"19. Signature and Title of",?70,"20. Date"
 W !,?5,"Requesting Official",?39,"Contracting/Accountable Officer"
 W !!,?5,RDUZ,?39,RMPR("SIG") S Y=$P($G(R664(4)),U,5) I Y'="" D DD^%DT W ?68,Y
 W !,RMPRB,!?25,"Order and Receipt Action",!,RMPRB
 W !,"21. Order Number",?18,"22. Date of Order",?37,"23. Date Item Received",?62,"24. Date Delivered"
 W !,?3,RTN,?22,RMPRODTE
 W !,RMPRB
 W !,"25. The articles or services listed herein have been received, or rendered",!,"ordered in the quantity and quality specified orginally or as shown by"
 W !,"authenticated changes, except as noted.",!!?40,"Signature of Veteran or VA Official",!,RMPRB,!?30,"VOUCHER AUDIT BLOCK (For use by VA Facility only)",!,RMPRB
 W !,"Approved For",?25,"Date",?50,"Voucher Auditor",!!,$E(RMPRB,1,50),!,"Acct. Symbol",?54,"ADP Form 10-2421  APR 1991" S RMPRMOR1=1
 Q
