PSOLBLS ;BIR/LGH-LABEL FOR SUSPENDED SCRIPTS ;11/17/92 18:18
 ;;7.0;OUTPATIENT PHARMACY;**5,30**;DEC 1997
 ;External reference to ^DIC(5 supported by DBIA 10056
 I '+$G(RXN) Q
AC S PSODFN=DFN,(SPPL,RXX,STA)=""
 I $G(PSODTCUT)']"" S X1=DT,X2=-120 D C^%DTC S PSODTCUT=X
 D ^PSOBUILD S (STA,RXX)=""
 F  S STA=$O(PSOSD(STA)) Q:STA=""  F  S RXX=$O(PSOSD(STA,RXX)) Q:RXX=""  I $P(PSOSD(STA,RXX),"^",2)=5 S SPPL=$P(PSOSD(STA,RXX),"^")_","_SPPL
 G:SPPL="" EXIT
 D 6^VADPT,PID^VADPT
 W ?54,$G(VA("PID")),!,?54,$P(^DPT(DFN,0),"^")
 I '$P(^PS(59,PSOSITE,1),"^",28) S ADDR(3)=$G(VAPA(4))_", "_$P($G(VAPA(5)),"^",2)_"  "_$S($G(VAPA(11))]"":$P($G(VAPA(11)),"^",2),1:$G(VAPA(6))),ADDR(2)="" S:$G(VAPA(2))]"" ADDR(2)=VAPA(2)_" "_VAPA(3) S:ADDR(2)="" ADDR(2)=ADDR(3),ADDR(3)=""
 I '$P(^PS(59,PSOSITE,1),"^",28) W !,?54,$G(VAPA(1)),!,?54,$G(ADDR(2)),!,?54,$G(ADDR(3)),!
 E  W !,?54,$G(VAPA(1)),!,?54,$G(ADDR(2)) W:$G(ADDR(3))'="" !,?54,$G(ADDR(3)) W:$G(ADDR(4))'="" !,?54,$G(ADDR(4)) W !
 W !,?54,"   The following prescriptions will be"
 W !,?54,"mailed to you on or after the date indicated."
 W !!,?54,"Rx#                   Date"
 W !,?54,"============================================",!
 F XX=1:1 Q:$P(SPPL,",",XX)=""  S RX=$P(SPPL,",",XX) D
 .S SPNUM=$O(^PS(52.5,"B",RX,0)) I SPNUM S SPDATE=$P($G(^PS(52.5,SPNUM,0)),"^",2) S Y=SPDATE D DD^%DT S SPDATE=Y
 .W !,?54,$P(^PSRX(RX,0),"^"),?72," ",$G(SPDATE),!,?56,$$ZZ^PSOSUTL(RX) K SPNUM,SPDATE,Y,ZDRUG
 W @IOF
EXIT K XX,RX,SPPL,RXX,SPPL,PSOSD,Y,SPNUM,SPDATE Q
 Q
MAIL S PSOMSTOP=1,PSOMAILS=1,PS=$S($D(^PS(59,PSOSITE,0)):^(0),1:"") I $P(PSOSYS,"^",4),$D(^PS(59,+$P($G(PSOSYS),"^",4),0)) S PS=^PS(59,$P($G(PSOSYS),"^",4),0)
 S VAADDR1=$P(PS,"^"),VASTREET=$P(PS,"^",2),STATE=$S($D(^DIC(5,+$P(PS,"^",8),0)):$P(^(0),"^",2),1:"UNKNOWN")
 S PSZIP=$P(PS,"^",5) S PSOHZIP=$S(PSZIP["-":PSZIP,1:$E(PSZIP,1,5)_$S($E(PSZIP,6,9)]"":"-"_$E(PSZIP,6,9),1:""))
 K ^UTILITY($J,"W") S PSKNT=0,DIWL=55,DIWR=100,DIWF="" F ZZ=0:0 S ZZ=$O(^PS(59,PSOSITE,6,ZZ)) Q:'ZZ  I $D(^(ZZ,0)) S X=^(0) D ^DIWP
 I '$D(^UTILITY($J,"W",DIWL)) S PSOMAILS=0 G MAILR
 F AA=0:0 S AA=$O(^UTILITY($J,"W",DIWL,AA)) Q:'AA  S PSKNT=PSKNT+1 W ?54,^(AA,0) W ! D CHECK
MAILR I $G(PSOMAILS) S PSKNT=PSKNT+1 W ! D CHECK
 K ^UTILITY($J,"W") F ZZ=0:0 S ZZ=$O(^PS(59,PSOSITE,7,ZZ)) Q:'ZZ  I $D(^(ZZ,0)) S X=^(0) D ^DIWP
 I $D(^UTILITY($J,"W",DIWL)) F AA=0:0 S AA=$O(^UTILITY($J,"W",DIWL,AA)) Q:'AA  S PSKNT=PSKNT+1 W ?54,^(AA,0) W ! D CHECK
 I PSKNT>20 G REXIT
 I PSKNT<4 W:PSKNT=0 !!!! W:PSKNT=1 !!! W:PSKNT=2 !! W:PSKNT=3 !
 I PSKNT<4 W "Pharmacy Service (119)",!,$G(VAADDR1),!,$G(VASTREET),!,$P(PS,"^",7)_", "_$G(STATE)_"  "_$G(PSOHZIP) W !!!!!!!!!!!! D PRINT G REXIT
 I PSKNT=4 W ! W $G(VAADDR1),!,$G(VASTREET),!,$P(PS,"^",7)_", "_$G(STATE)_"  "_$G(PSOHZIP) W !!!!!!!!!!!! D PRINT G REXIT
 I PSKNT=5 W ! W $G(VASTREET),!,$P(PS,"^",7)_", "_$G(STATE)_"  "_$G(PSOHZIP) W !!!!!!!!!!!! D PRINT G REXIT
 I PSKNT=6 W ! W $P(PS,"^",7)_", "_$G(STATE)_"  "_$G(PSOHZIP) W !!!!!!!!!!!! D PRINT G REXIT
 I PSKNT=18 W ! W "Use the label above to mail the computer",!,"copies back to us. Apply enough postage",!,"to your envelope to ensure delivery." G REXIT
 I PSKNT=19 W ! W "copies back to us. Apply enough postage",!,"to your envelope to ensure delivery." G REXIT
 I PSKNT=20 W ! W "to your envelope to ensure delivery." G REXIT
 S PSKNT=(20-PSKNT) F PP=1:1:PSKNT W !
 W ! D PRINT
REXIT K ^UTILITY($J,"W"),PSKNT,PP,AA,ZZ,DIWL,DIWF,DIWR,PSOMSTOP,PSOMAILS,VAADDR1,VASTREET,STATE,PSZIP,PSOHZIP W @IOF Q
CHECK W:PSKNT=4 "Pharmacy Service (119)" W:PSKNT=5 $G(VAADDR1) W:PSKNT=6 $G(VASTREET) W:PSKNT=7 $P(PS,"^",7)_", "_$G(STATE)_"  "_$G(PSOHZIP)
 W:PSKNT=19 "Use the label above to mail the computer" W:PSKNT=20 "copies back to us. Apply enough postage" W:PSKNT=21 "to your envelope to ensure delivery."
 Q
PRINT W "Use the label above to mail the computer",!,"copies back to us. Apply enough postage",!,"to your envelope to ensure delivery." Q
ALL ;PRINT ALLERGIES
 I $G(PSOBLALL),$P(PPL,",",PI+1)'="" Q
 X "N X S X=""GMRADPT"" X ^%ZOSF(""TEST"") Q" Q:'$T
 S GMRA="0^0^111" D ^GMRADPT
 K ^TMP($J,"ALL")
 I $G(GMRAL) F PSORY=0:0 S PSORY=$O(GMRAL(PSORY)) Q:'PSORY  S ^TMP($J,"ALL",$S($P(GMRAL(PSORY),"^",4):1,1:2),$S('$P(GMRAL(PSORY),"^",5):1,1:2),$P(GMRAL(PSORY),"^",7),$P(GMRAL(PSORY),"^",2))=""
 W ?102,$G(PNM),"  ",$G(SSNP),!!
 W ?102,"Verified Allergies",!,?102,"------------------"
 S III=0,(ALG,ALGR)="" F  S ALG=$O(^TMP($J,"ALL",1,1,ALG)) Q:ALG=""  F  S ALGR=$O(^TMP($J,"ALL",1,1,ALG,ALGR)) Q:ALGR=""  S III=1 W !,?104,ALGR
 I III W !
 I 'III W !,?104,$S($G(GMRAL)=0:"NKA",1:"") W:$G(GMRAL)=0 !
 W !,?102,"Non-Verified Allergies",!,?102,"----------------------"
 S III=0,(ALG,ALGR)="" F  S ALG=$O(^TMP($J,"ALL",2,1,ALG)) Q:ALG=""  F  S ALGR=$O(^TMP($J,"ALL",2,1,ALG,ALGR)) Q:ALGR=""  S III=1 W !,?104,ALGR
 I III W !
 I 'III W !,?104,$S($G(GMRAL)=0:"NKA",1:"") W:$G(GMRAL)=0 !
 W !,?102,"Verified Adverse Reactions",!,?102,"--------------------------"
 S (ALG,ALGR)="" F  S ALG=$O(^TMP($J,"ALL",1,2,ALG)) Q:ALG=""  F  S ALGR=$O(^TMP($J,"ALL",1,2,ALG,ALGR)) Q:ALGR=""  S III=1 W !,?104,ALGR
 W !!,?102,"Non-Verified Adverse Reactions",!,?102,"------------------------------"
 S (ALG,ALGR)="" F  S ALG=$O(^TMP($J,"ALL",2,2,ALG)) Q:ALG=""  F  S ALGR=$O(^TMP($J,"ALL",2,2,ALG,ALGR)) Q:ALGR=""  W !,?104,ALGR
 K ^TMP($J,"ALL"),ALGR,PSORY,GMRA,GMRAL,ALG,III,JJJ W @IOF Q
