PRSRL11 ;HISC/JH,WIRMFO/JAH,SAB-ALL EMPLOYEE LEAVE USED REPORT ;8/27/01
 ;;4.0;PAID;**2,17,39,34,69**;Sep 21, 1995
 ; prints leave used report when All employees in T&L Unit selected
 S (PAGE,POUT)=0,DAT2=$$FMTE^XLFDT(DT)
 D HDR1
 N MLINHRS
 ; loop thru pay periods (external value)
 S PP=""
 F  S PP=$O(^TMP($J,"USE",PP)) Q:PP=""  D  Q:POUT
 . S DATE(1)="" ; previous leave date, used to control printing of date
 . ; loop thru leave dates (fileman)
 . S DATE=0 F  S DATE=$O(^TMP($J,"USE",PP,DATE)) Q:DATE'>0  D  Q:POUT
 .. S DATE(2)=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 .. ; loop thru employee names
 .. S NAM="" F  S NAM=$O(^TMP($J,"USE",PP,DATE,NAM)) Q:NAM=""  D  Q:POUT
 ... ; loop thru employee ssn's
 ... S SSN=""
 ... F  S SSN=$O(^TMP($J,"USE",PP,DATE,NAM,SSN)) Q:SSN=""  D  Q:POUT
 .... ; loop thru employee ien's (file #450)
 .... S D0=0
 .... F  S D0=$O(^TMP($J,"USE",PP,DATE,NAM,SSN,D0)) Q:D0'>0  D  Q:POUT
 ..... ; loop thru instances of wrk nodes that contained leave
 ..... S NUM=0
 ..... F  S NUM=$O(^TMP($J,"USE",PP,DATE,NAM,SSN,D0,NUM)) Q:NUM'>0  D  Q:POUT
 ...... S TOUR=$G(^TMP($J,"USE",PP,DATE,NAM,SSN,D0,NUM))
 ...... Q:TOUR=""!($P(TOUR,U,3)="")  ; no start time or type of time
 ...... Q:$E($P(TOUR,U,3),1)="H"  ; holiday worked or excused
 ...... S PRSRSSN=$E(SSN,1,3)_$E(SSN,5,6)_$E(SSN,8,11)
 ...... D TYPSTF^PRSRUT0 ; returns SW(2), = 77 for daily tour, else = 73
 ...... S MLINHRS=$$MLINHRS^PRSAENT(DFN)
 ...... D:$Y+5>IOSL HDR Q:POUT
 ...... W !,"|"
 ...... I DATE'=DATE(1) W DATE(2) S DATE(1)=DATE ; print date if changed
 ...... W ?10,"|",$E(NAM,1,20),?32,"|"
 ...... S SW(3)=0 ; flag, set false to suppress new line when 1st segment
 ...... ; loop thru leave segments in node - data source and format from 
 ...... ;   node 2 for day, empl. in #458 but ONLY contains leave
 ...... ; Break out CU posting to comp or credit based on time remarks.
 ...... ;
 ...... F K=1:4 Q:$P(TOUR,"^",K+2)=""  D
 ....... N COMPCRED S LEV=$P(TOUR,"^",K+2),%=$F(LVT,";"_LEV_":")
 ....... W:SW(3) !,"|",?10,"|",?32,"|" ; new line for subsequent segments
 .......; W:%>0 $P($E(LVT,%,999),";")
 ....... S:LEV="CU" COMPCRED=$S($P(TOUR,"^",K+3)=16:"Credit Hours",1:"Compensatory")
 ....... W:%>0 $S(LEV="CU":COMPCRED,1:$P($E(LVT,%,999),";"))
 ....... W ?53,"|",$P(TOUR,"^",K),?61,"|",$P(TOUR,"^",K+1),?69,"|"
 ....... ; call PRSRLL to set TIM (elasped time) and TYL (D day, H hour)
 ....... S Z="^^"_DATE_"^"_$P(TOUR,"^",K)_"^"_DATE_"^"_$P(TOUR,"^",K+1)
 ....... I LEV="ML" D
 ........ I MLINHRS D H^PRSRLL Q
 ........ D D^PRSRLL
 ....... D D^PRSRLL:LEV'="ML"&(SW(2)=77) ; daily tour
 ....... D H^PRSRLL:LEV'="ML"&(SW(2)=73) ; else hour
 ....... W $S(SW(2)=77:$J(TIM,7),1:$J(TIM,7,2))
 ....... W ?($X+1),TYL,?79,"|"
 ....... S SW(3)=1 ; set flag true so next segment (if any) on new line
 .. Q:POUT
 .. D VLIN1
 ;
 I 'CNT D
 . D VLIN1
 . W !,"|",?10,"No Leave Usage on File within this Date Range.",?79,"|"
 ;
 ; report footer
 I 'POUT D
 . I $Y+5<IOSL,IOSL<66 F I=$Y:1:IOSL-5 D VLIN1
 . D VLIDSH1
 . S CODE="L004",FOOT="VA TIME & ATTENDANCE SYSTEM" D FOOT2^PRSRUT0
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 Q
 ;
HDR ; page break
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,POUT=1 Q
 D VLIDSH1
 S CODE="L004",FOOT="VA TIME & ATTENDANCE SYSTEM" D FOOT2^PRSRUT0
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S POUT=1 Q
HDR1 ; page header
 W:$E(IOST,1,2)="C-"!(PAGE) @IOF
 S PAGE=PAGE+1
 W !?31,^TMP($J,"USE"),?60,"DATE: ",DAT2
 W !?22,"from: ",XX," to: ",YY
 W !?36,"T&L: ",$P(TLE(1),"^"),!
 D VLIDSH1
 W !,"|","DATE",?10,"|","EMPLOYEE",?32,"|","TYPE",?53,"|","FROM",?61,"|","TO",?69,"|","LENGTH",?79,"|"
 D VLIDSH1
 S DATE(1)="" ; forces leave date to print on new page
 Q
 ;
VLIDSH1 ;dashed line (with columns)
 W !,"|---------|---------------------|--------------------|-------|-------|---------|"
 Q
 ;
VLIN1 ; blank line (with columns)
 W !,"|",?10,"|",?32,"|",?53,"|",?61,"|",?69,"|",?79,"|"
 Q
