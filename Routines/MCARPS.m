MCARPS ;WISC/TJK,RCH-PROCEDURE SUMMARY REPORTS ;6/18/97  10:53
 ;;2.3;Medicine;**8**;09/13/1996
CHOOZ K S5 R !,"PRINT BY DATE OR PROCEDURE (D/P): D//",WH:DTIME
 S WH=$E(WH,1) G BEG:"DP"[WH I WH'?1"^".E W:WH'?1"?".E *7,"  ??" D HELP G CHOOZ
 K WH,X,Y Q
BEG ;SEARCH FOR SELECTED PATIENT IN CARDIOLOGY FILE
 I WH="P" D PROC I $D(S5),S5=U G CHOOZ
 S DIC="^MCAR(690,",DIC(0)="AEQM"
 D ^DIC I Y<0 K WH,DIC,Y Q
 ; ------------------------
 ; SSN = Enternal Format of the patients SSN with the first letter
 ; of the last name tacked on the end
 ; ------------------------
 S DFN=+Y D DEM^VADPT S MCARNM=VADM(1),SSN=VA("PID")
 D INP^VADPT S WARD=$S(VAIN(4)'="":$P(VAIN(4),U,2),1:"NOT INPATIENT") D KVAR^VADPT
LOC ;LOCATE PROCEDURES FROM "AC" X-REF
 I '$D(^MCAR(690,"AC",DFN)) W !!,"NO PROCEDURES FOR THIS PATIENT" G BEG
 I $D(S5),'$D(@(U_S5_",""C"","_DFN_")")) W !!,"NO ",$P(@(U_S5_",0)"),U,1)," PROCEDURES FOR THIS PATIENT" G BEG
 D ^MCARPS1
PR K IO("Q") S %ZIS="QM" D ^%ZIS K %ZIS G EXIT:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="PR0^MCARPS",ZTDESC="PROCEDURE SUMMARY"
 I  S ZTSAVE("^TMP(""MCAR"",$J,")="",(ZTSAVE("DFN"),ZTSAVE("WH"),ZTSAVE("MC*"),ZTSAVE("SSN"),ZTSAVE("WARD"))="" D ^%ZTLOAD K ZTSK W !!,*7,"Report Queued" G FIN
 U IO
PR0 D TOP S I="",L=0
PR1 S I=$O(^TMP("MCAR",$J,I)) G PR1:I="OT" I I="" G EXP:IOST'?1"P-".E,FIN
 S J=""
PR2 S J=$O(^TMP("MCAR",$J,I,J)) G PR1:J=""
 S PR=^(J),MCARDT=$S(WH="P":$P(J,U),1:I),MCARPROC=$S(WH="P":I,1:$P(J,U))  ;MC*2.3*8
 S MCARPROC=$O(^MCAR(697.2,"B",MCARPROC,0)),MCARPROC=$P(^MCAR(697.2,MCARPROC,0),U,8)
 I $P(PR,U,12)'="" S MCARPROC=$P(PR,U,12)  ;MC*2.3*8
 S DA=$P(PR,U,2),K=$P(PR,U),M=$P(PR,U,10)
 S K=$S(K="N"!(K="L"):"NORMAL",K="A":"ABNORMAL",K="B":"BORDERLINE",K="T":"TECHNICALLY UNSATISFACTORY",K="ND":"NON-DIAGNOSTIC",K="MI":"MILDLY ABNORMAL",K="MO":"MODERATELY ABNORMAL",K="S":"SEVERELY ABNORMAL",1:"")
 ;S Y=9999999.9999-MCARDT X ^DD("DD") S L=L+1 W !,$J(L,2),?4,MCARPROC,?36,Y,?56,$E(K,1,22) W !,?1,M S ^TMP("MCAR",$J,"OT",L)=MCARPROC_U_DA_U_$P(PR,U,3,5)_U_J S $P(^(L),U,6)=Y,$P(^(L),U,7)=K,$P(^(L),U,10)=M,$P(^(L),U,11)=J
 S Y=9999999.9999-MCARDT X ^DD("DD") S L=L+1 W !,$J(L,2),?4,MCARPROC,?36,Y,?56,$E(K,1,22) W !,?1,M S ^TMP("MCAR",$J,"OT",L)=MCARPROC_U_DA_U_$P(PR,U,3,5)_U_J S $P(^(L),U,6)=Y,$P(^(L),U,7)=K,$P(^(L),U,10)=M,$P(^(L),U,11)=$S(WH="P":I_U_$P(J,U,2),1:J)
 S LN=LN+2 I LN'<(IOSL-2) G EXP:IOST'?1"P-".E D TOP
 G PR2
TOP W @IOF,!,"NAME: ",MCARNM,?35,"SSN: ",SSN,?55,"WARD: ",$E(WARD,1,19)
 ;W !!,"PROCEDURE",?36,"DATE",?56,"RESULTS",! F M=1:1:79 W "-"
 W !!,"(SUBSPECIALTY)/PROCEDURE",?36,"DATE",?56,"RESULTS" S M="",$P(M,"-",79)="-" W !,M
 S LN=6 Q
EXP G FIN:LN=6 W !!,*7,"FOR PROCEDURE EXPANSION (1-",L,") OR <RETURN> TO CONTINUE DISPLAY//" R R:DTIME G EXIT:R=U,EXIT:'$T
 I R'="",$D(^TMP("MCAR",$J,"OT",R)) G EXP1
 G FIN:I="" D TOP G PR2
EXP1 W @IOF,!! S OT=^TMP("MCAR",$J,"OT",R),(DA,MCARGDA)=$P(OT,U,2),MCARPPS=$P(OT,U,3,4),MCPRO=$P(OT,U,11) D MCPPROC^MCARP
 S MCARGRTN=$P(OT,U,5)
 K DXS D NEW,REDISP G EXP
FIN W:IOST'?1"P-".E !!,"END OF REPORT" W:IOST?1"P-".E @IOF D ^%ZISC
EXIT S:$D(ZTQUEUED) ZTREQ="@" K ZTSK
 K LN,PR,OT,DA,MCARPPS,I,J,R,L,S1,S2,S4,S5,S6,DFN,LL,LL1,MCARGRTN,POP,IO("Q")
 K ^TMP("MCAR",$J),K,N,MCARDT,WARD,MCARNM,MCARPROC,M,SSN
 ;The kill statement on next line will reset the TMP global for Imaging
 K ^TMP("MAG","ROW"),^("COL")
 Q
NEW N DFN,SSN,I,J,L D @MCARPPS Q
REDISP S MCL=$S(L#8:L-(L#8),1:L-8) D TOP
 F MCRED=MCL+1:1:MCL+8 Q:'$D(^TMP("MCAR",$J,"OT",MCRED))  S MCRED1=^(MCRED) W !,$J(MCRED,2),?4,$P(MCRED1,U),?36,$P(MCRED1,U,6),?56,$E($P(MCRED1,U,7),1,22),!,?1,$P(MCRED1,U,10) S LN=LN+2
 K MCL,MCRED,MCRED1 Q
PROC K PE,S5 R !,"Select Procedure:  ALL// ",S5:DTIME
 Q:S5=U  I S5="ALL"!(S5="") K S5 Q
 S DIC(0)="ZQE",DIC=697.2,X=S5 D ^DIC
 G PROC:Y<0 S S5=$P(Y(0),U,2),PE=$P(Y(0),U,1) Q
HELP W !,"You may sort this report by date or procedure.",!,"If you choose 'D' (date) all medical procedures will be displayed starting",!,"with the most recent procedure."
 W !,"If you choose 'P' (procedure), you may specify in the next prompt either a",!,"specific procedure or 'ALL' procedures, alphabetically arranged with the most",!,"recent of that type of procedure displayed first." Q
