SDCWL ;ALB/MLI - CLINIC WORKLOAD REPORT ; 18 APRIL 88
 ;;5.3;Scheduling;**140,132**;Aug 13, 1993
 D Q S U="^" D ASK2^SDDIV G Q:Y<0 S (VAUTC,SDADD,SDALL,SDNAM,SDPRE)=0 D DATE^SDUTL G Q:POP D WKL^SDAMQ2(SDBD,SDED) G DT:($E(SDBD,6,7)&$E(SDED,6,7))
 S:'$E(SDBD,4,5) SDBD=$E(SDBD,1,3)_"0101" S:'$E(SDED,4,5) SDED=$E(SDED,1,3)_"1231" S:'$E(SDBD,6,7) SDBD=$E(SDBD,1,5)_"01" S:'$E(SDED,6,7) SDED=$E(SDED,1,5)_"31"
DT S SDB1=$TR($$FMTE^XLFDT(SDBD,"5DF")," ","0"),SDE1=$TR($$FMTE^XLFDT(SDED,"5DF")," ","0")
 S SDB=$TR($$FMTE^XLFDT(SDBD,"2FD")," ","0"),SDE=$TR($$FMTE^XLFDT(SDED,"2FD")," ","0")
 S SDBD=SDBD-.1,SDED=SDED+.9
 I SDED<2871001 S SDS="C" S VAUTNI=2 D CLINIC^VAUTOMA G Q:Y<0,RT
1 R !,"Totals by (C)LINIC or (S)TOP CODE?:  C//",X:DTIME G Q:(X="^")!'$T S Z="^CLINIC^STOP CODE" W:X["?" !,"Type:",!?10,"'C' for CLINIC totals only, or",!?10,"'S' for STOP CODE and CLINIC totals",! I X="" S X="C" W X
 D IN^DGHELP G:%=-1 1 S SDS=X I SDS="C" S VAUTNI=2 D CLINIC^VAUTOMA G Q:Y<0,RT
2 F SDI=1:0 Q:SDI>20  W !,"Enter Stop Code: " W:'$D(SDCL) "ALL//" R X:DTIME Q:(X="^")!'$T!(X="")  W:X["?" !,"Enter a stop code or return when all stop codes have been entered" D CL^SDSCP
 G:X="^"!('$T&(SDI<20)) Q I X="",'$D(SDCL) S SDCL="",SDALL=1
ADD I SDS="S" W !,"Do you want to include add/edits" S %=2 D YN^DICN W:%Y["?" !,"Answer 'Y'es to see add/edits entered through the ADD/EDIT STOP CODES option or",!,"'N'o to leave them out" G Q:%<0,ADD:%'>0 S SDADD='(%-1)
RT I SDS="S"&((SDBD-10000)<2871000) S SDRT="E" G 3
 R !,"Brief or Expanded Report? E//",X:DTIME G Q:X="^"!'$T S Z="^BRIEF^EXPANDED" W:X["?" !,"Enter 'B'rief to see a comparison of data to previous year only",!,"or 'E'xpanded to see patient breakdown by clinic/stop code" I X="" S X="E" W X
 D IN^DGHELP S SDRT=X G RT:%=-1,ST:X="B"
3 W !,"(D)ETAIL BY DAY or (S)UMMARY BY MONTH?: D//" R X:DTIME G Q:(X="^")!'$T W:X["?" !,"TYPE:",!?10,"'D' for report by individual clinic meeting",!?10,"'S' for report by month" I X="" S X="D" W X
 S Z="^DETAIL BY DAY^SUMMARY BY MONTH" D IN^DGHELP G:%=-1 3 S SDF=X
PN I SDF="D" W !,"Do you want to see patient names" S %=2 D YN^DICN W:%Y["?" "ANSWER 'Y'ES OR 'N'O" G Q:%<0,PN:%'>0 S SDNAM='(%-1)
5 I SDS="C"!((SDBD-10000)>2871000) W !,"Do you want to compare this data to the same period in the previous year" S %=2 D YN^DICN W:%Y["?" "ANSWER 'Y'ES OR 'N'O" G Q:%<0,5:%'>0 S SDPRE='(%-1)
 W !!,"Report will cover the period from: ",SDB1," through ",SDE1 W:SDPRE !,"Comparison will be done against the same period for the previous year" W !!
ST S DGPGM="6^SDCWL",DGVAR="VAUTC#^VAUTD#^SDALL^SDCL#^SDB^SDB1^SDBD^SDE^SDE1^SDED^SDF^SDRT^SDS^SDADD^SDNAM^SDPRE" K IOP D ZIS^DGUTQ G:POP Q U IO D 6,CLOSE^DGUTQ Q
6 S (SDOB,SDPG,SDHR,SD1)=0,%DT="R",X="N" D ^%DT
 S SDNOW=$TR($$FMTE^XLFDT(Y,"5DF")," ","0")_"@"_$P(Y,".",2)
 F I=0:0 S I=$S(SDS="S"!VAUTC:$O(^SC(I)),1:$O(VAUTC(I))) Q:'I  D SET^SDCWL3
 ;
 IF SDADD D SCAN
 I (SDRT="B"!SDPRE)&'$D(SDFL) S SDBD=SDBD-10000,SDED=SDED-10000,SDFL=1 G 6
 I '$D(^TMP($J,"CL")),'$D(^("SC")) D NONE^SDCWL3 G Q
 G Q:'$D(^TMP($J)) D:SDRT="E"&($D(^TMP($J,1))!$D(^("SC"))) ^SDCWL1,LEG^SDCWL3 D ERR^SDCWL3:$D(^TMP($J,"ERR")),PREV^SDCWL2:SDPRE!(SDRT="B")
Q W ! K ^TMP($J),%,%DT,%Y,BEGDATE,DFN,DGPGM,DGVAR,DIV,ENDDATE,I,I1,J,J1,K,K1,L,L1,M,M1,N,N1,P,P1,POP,Q,Q1,R,S,SD1,SDADD,SDAED,SDALL,SDAPT,SDAS,SDB,SDBD,SDBO,SDCA,SDCL,SDCR,SDCUR,SDD,SDDIV,SDE,SDED,SDEO,SDF,SDF1,SDFL,SDHK,SDHR
 K SDF2,SDI,SDIN,SDN,SDNAM,SDNM,SDNOW,SDNS,SDNUM,SDOB,SDOLD,SDP,SDPG,SDPN,SDPRE,SDRT,SDS,SDSC,SDSCC,SDSCH,SDSCI,SDSCN,SDSCO,SDSCS,SDSCU,SDSSN,SDST,SDSTAT,SDSUB,SDT,SDTOT,SDUN,SDV,VAUTC,VAUTD,VAUTNI,X,Y,Z,SDE1,SDB1 Q
 ;
SCAN ; -- scan ^SCE for date range
 N SDT,SDOE,SDOE0,SDSC,SDPAR,SDORG
 S SDT=SDBD
 F  S SDT=$O(^SCE("B",SDT)) Q:'SDT!(SDT>SDED)  D
 . S SDOE=0
 . F  S SDOE=$O(^SCE("B",SDT,SDOE)) Q:'SDOE  D
 . . S SDOE0=$G(^SCE(SDOE,0))
 . . S SDSC=+$P($G(^DIC(40.7,+$P(SDOE0,U,3),0)),U,2)
 . . S SDPAR=+$P(SDOE0,U,6)
 . . S SDORG=+$P(SDOE0,U,8)
 . . ;
 . . ; -- do checks
 . . IF SDORG'=2 Q               ; -- must be a/e
 . . IF SDPAR Q                  ; -- must not have parent
 . . IF '$$OKAE^SDVSIT2(SDOE) Q  ; -- must be checked out
 . . IF 'SDSC Q                  ; -- must be a vaild stop code
 . . ;
 . . D ADDON^SDCWL2
 Q
 ;
