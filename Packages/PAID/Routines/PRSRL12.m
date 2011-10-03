PRSRL12 ;HISC/JH,WCIOFO/SAB-INDIVIDUAL EMPLOYEE LEAVE USED REPORT ;08/27/01
 ;;4.0;PAID;**2,5,19,39,34,69**;Sep 21, 1995
 ; prints leave used report when specific employee selected
 N MLINHRS
 S (PAGE,POUT)=0,DAT2=$$FMTE^XLFDT(DT)
 D HDR3
 D TYPSTF^PRSRUT0 ; returns SW(2): = 77 for daily tour, else = 73
 S MLINHRS=$$MLINHRS^PRSAENT(DFN)
 ; init totals for all leave types
 F I=1:1 S X=$P($P(LVT,";",I+1),":") Q:X=""  S TLEV(X)=""
 ;
 ; Add 2 types of leave to hold break out totals of
 ; comp/credit--credit hours & compensatory.
 ;
 S (TLEV("CUCOMP"),TLEV("CUCRED"))=""
 ; loop thru instances of wrk nodes containing leave
 S INX=0 F  S INX=$O(^TMP($J,"USE",INX)) Q:INX'>0  D  Q:POUT
 . ; loop thru pay periods (nn)
 . S PP="" F  S PP=$O(^TMP($J,"USE",INX,PP)) Q:PP=""  D  Q:POUT
 .. ; loop thru leave date (fileman)
 .. S DATE=0
 .. F  S DATE=$O(^TMP($J,"USE",INX,PP,DATE)) Q:DATE'>0  D  Q:POUT
 ... ; loop thru leave date (external)
 ... S DAY=""
 ... F  S DAY=$O(^TMP($J,"USE",INX,PP,DATE,DAY)) Q:DAY=""  D  Q:POUT
 .... S TOUR=$G(^TMP($J,"USE",INX,PP,DATE,DAY)) Q:TOUR=""
 .... D:$Y+5>IOSL HDR Q:POUT
 .... ; start detail line - only print pp and date when changed
 .... W !,"|"
 .... I PP'=PP(1) W PP S PP(1)=PP
 .... W ?4,"|"
 .... I DAY'=DAY(1) W DAY S DAY(1)=DAY
 .... W ?19,"|"
 .... S SW(3)=0 ; flag, set false to suppress new line when 1st segment
 .... ; loop thru segments in node - data source and format from
 .... ;   node 2 for day, empl. in #458 but ONLY contains leave
 .... F K=1:4 Q:$P(TOUR,"^",K+2)=""  D
 ..... N COMPCRED S LEV=$P(TOUR,"^",K+2) ; leave type (internal code)
 ..... W:SW(3) !,"|",?4,"|",?19,"|" ; new line for subsequent segments
 ..... S %=$F(LVT,";"_LEV_":")
 ..... ;comp/credit (CU) is distinguishable by time remarks code (K+3)
 ..... S:LEV="CU" COMPCRED=$S($P(TOUR,"^",K+3)=16:"Credit Hours",1:"Compensatory")
 ..... ;display leave type
 ..... W:%>0 $S(LEV="CU":COMPCRED,1:$P($E(LVT,%,999),";"))
 ..... W:LEV="LWOP" " - AWOL"
 ..... W ?41,"|",$P(TOUR,"^",K),?49,"|",$P(TOUR,"^",K+1),?57,"|"
 ..... ; call PRSRLL to set TIM (elasped time) and TYL (D day, H hour)
 ..... S Z="^^"_DATE_"^"_$P(TOUR,"^",K)_"^"_DATE_"^"_$P(TOUR,"^",K+1)
 ..... I LEV="ML" D  ; For Military Leave - PRS*4.0*69
 ...... I MLINHRS D H^PRSRLL Q
 ...... D D^PRSRLL
 ..... D D^PRSRLL:LEV'="ML"&(SW(2)=77) ; daily tour
 ..... D H^PRSRLL:LEV'="ML"&(SW(2)=73) ; else hour
 ..... W ?57,$S(SW(2)=77:$J(TIM,4),1:$J(TIM,7,2))
 ..... W " ",$S(TYL="H":"Hour",1:"Day")_$S(TIM="":"",TIM'=1:"s",1:"")
 ..... W ?79,"|"
 ..... S TLEV(LEV)=TLEV(LEV)+TIM ; add to total for type of leave
 ..... I LEV="CU" S TLEV($S($P(TOUR,"^",K+3)=16:"CUCRED",1:"CUCOMP"))=TLEV($S($P(TOUR,"^",K+3)=16:"CUCRED",1:"CUCOMP"))+TIM
 ..... S SW(3)=1 ; set flag true so next segment (if any) on new line
 ;
 I 'CNT D
 . D VLIN0
 . W !,"|",?10,"No Leave Usage on File within this Date Range.",?79,"|"
 ;
 ; report totals
 I CNT,'POUT D
 . D HDR:$Y+7>IOSL
 . D VLIN0
 . W !,"|",?4,"|",?19,"|",?27,"TOTALS:"
 . S SW(3)=0 ; set false so 1st type of leave printed on same line
 . ; loop thru leave type totals
 . S LEV="" F  S LEV=$O(TLEV(LEV)) Q:LEV=""  D  Q:POUT
 .. Q:TLEV(LEV)=""  ; none of this type of leave found
 .. D:$Y+5>IOSL HDR Q:POUT
 .. W:SW(3) !,"|",?4,"|",?19,"|",?39 ; new line when not first leave type
 .. S %=$F(LVT,";"_LEV_":") W:%>0 ?39,$P($E(LVT,%,999),";") ; leave type
 .. ;write out subtotals for comp/credit
 .. I LEV="CUCOMP" W ?42,"Compensatory"
 .. I LEV="CUCRED" W ?42,"Credit Hours"
 .. W ?58,$S(SW(2)=77:$J($G(TLEV(LEV)),4),1:$J($G(TLEV(LEV)),7,2))
 .. W " "
 .. I LEV="ML" W $S(MLINHRS:"Hour",1:"Day")
 .. I LEV'="ML" W $S(SW(2)=77:"Day",1:"Hour")
 .. W $S(TLEV(LEV)'=1:"s",1:""),?79,"|"
 .. S:'SW(3) SW(3)=1 ; set true so next leave type on new line
 ;
 ; report footer
 I 'POUT D
 . I IOSL<66 F I=$Y:1:IOSL-6 D VLIN0
 . D VLIDSH0
 . S CODE="L003",FOOT="VA TIME & ATTENDANCE SYSTEM" D FOOT2^PRSRUT0
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 ;
 Q
 ;
HDR ; page break
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,POUT=1 Q
 D VLIDSH0
 S CODE="L003",FOOT="VA TIME & ATTENDANCE SYSTEM" D FOOT2^PRSRUT0
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S POUT=1 Q
HDR3 ; page header
 I $E(IOST,1,2)="C-"!PAGE W @IOF
 S PAGE=PAGE+1
 W !?31,^TMP($J,"USE"),?60,"DATE: ",DAT2
 W !?22,"from: ",XX," to: ",YY
 W !?24,"for: ",NAM," - T&L: ",TLE,!
 D VLIDSH0
 W !,"|","PP",?4,"|","DATE",?19,"|","TYPE",?41,"|","FROM",?49,"|","TO",?57,"|","LENGTH",?79,"|"
 D VLIDSH0
 S (PP(1),DAY(1))="" ; forces pp and leave date to print on new page
 Q
 ;
VLIDSH0 ; dashed line (with columns)
 W !,"|---|--------------|---------------------|-------|-------|---------------------|"
 Q
 ;
VLIN0 ; blank line (with columns)
 W !,"|",?4,"|",?19,"|",?41,"|",?49,"|",?57,"|",?79,"|"
 Q
