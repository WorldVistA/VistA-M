PRCNCOST ;SSI/SEB-Display Cost Report ;[ 02/26/97  5:57 PM ]
 ;;1.0;PRCN;**3**;Sep 13, 1996
EN ;
 W !!,"This report should be printed on 132 column paper !"
 S IOM=132,%ZIS="Q" D ^%ZIS Q:POP>0
 I $D(IO("Q")) D  Q
 . S ZTRTN="BEG^PRCNCOST",ZTDESC="Equipment Cost Report"
 . D ^%ZTLOAD,HOME^%ZIS K IO("Q"),ZTSK,%ZTLOAD,ZTREQ
 I $E(IOST)="C" U IO
BEG K ^TMP($J) S PG=0,$P(LIN,"-",130)=""
 D HDR S GTOTAL=0,D0=""
 F STA=10,31 F  S D0=$O(^PRCN(413,"AC",STA,D0)) Q:D0=""  D
 . S PSERV=$P(^PRCN(413,D0,0),U,3) Q:PSERV=""
 . S SERV=$P(^DIC(49,PSERV,0),U),^TMP($J,"COST",SERV,D0)=""
 S SERV=""
SRV S SERV=$O(^TMP($J,"COST",SERV)) G EXIT:$G(C)'="",FIN:SERV=""
 W !,"Service: ",SERV S (D0,STOTAL)=0,NL=NL+1 D CHKPG Q:$G(C)'=""
 S D0="" F  S D0=$O(^TMP($J,"COST",SERV,D0)) Q:D0=""  D GETSUMS
 Q:$D(C)  W !!,"Subtotal for ",SERV,":",?117,$J(STOTAL,10,2),!
 F I=1:1:130 W "-"
 S GTOTAL=GTOTAL+STOTAL,NL=NL+3 D CHKPG
 G SRV
FIN W !,"Total:",?117,$J(GTOTAL,10,2) S NL=NL+1 D CHKPG
 I $E(IOST)'="C" W @IOF
 D ^%ZISC
EXIT K D0,D1,GTOTAL,STOTAL,LTOTAL,TOTAL,SERV,PSERV,C,FN,I,NL,PN,COST
 K TXT,LIN,STA,^TMP($J,"COST")
 Q
GETSUMS ; Get line item total & display stuff
 W !,$P(^PRCN(413,D0,0),U) S (D1,TOTAL,LTOTAL)=0
 F  S D1=$O(^PRCN(413,D0,1,D1)) Q:'+D1  D
 . S DR=15,DR(413.015)=6,DIQ(0)="C",DIQ="LBTOT"
 . S DIC=413,DA=D0,DA(1)=D1,DA(413.015)=D1 NEW D1
 . D EN^DIQ1
 . S X=$G(LBTOT(413.015,DA(413.015),6))
 . S LTOTAL=LTOTAL+X
 . K DIC,LBTOT,DIC,DR,DIQ,DA,X
 S TOTAL=TOTAL+LTOTAL W $J(LTOTAL,10,2)
 F FN=20,22,24,53,54,60,63,65,66 D
 . S:FN<25 I=2,PN=FN-15 S:FN>25 I=7,PN=FN-51
 . S COST=$P($G(^PRCN(413,D0,I)),U,PN),TOTAL=TOTAL+COST
 . W $J(COST,10,2)
 W $J(TOTAL,10,2) S STOTAL=STOTAL+TOTAL,NL=NL+1 D CHKPG
 Q
CHKPG ; If printing to screen & it is full, clear screen
 Q:IOT'["TRM"!(IOSL>NL+3)  W !,"Hit RETURN to continue or '^' to quit. "
 R C:DTIME S:'$T C=U K:C'?1"^".E C
 Q
HDR ; Print a header for the report
 S PG=PG+1,TXT="  " I $E(IOST)="C" W @IOF
 W !,"EQUIPMENT REQUEST COST SUMMARY REPORT"
 W $J("",IOM-$L(TXT)\2) S X="N",%DT="T" D ^%DT W $$FMTE^XLFDT(Y,"1P")_"  PAGE: "_PG,!
 W ?31,"Annual",?61,"Training",?71,"Training",?81,"Constr./",?91
 W "Special",?101,"Test",?111,"Maint.",!,?21,"Line Item",?31,"Recurring"
 W ?41,"Training",?51,"Contract",?61,"Tuition",?71,"Travel",?81
 W "Renov.",?91,"Install.",?101,"Equipment",?111,"Impact",?121,"Total"
 W !,"Transaction #" S NL=5 F I=2:1:12 W ?(I*10+1),"Cost"
 W !,LIN
 Q
