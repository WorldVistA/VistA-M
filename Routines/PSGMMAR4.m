PSGMMAR4 ;BIR/CML3-MD MARS - PRINT O/P ORDERS ;05 Oct 98 / 10:25 AM
 ;;5.0; INPATIENT MEDICATIONS ;**8,12,20,111**;16 DEC 97
 ;
PSGMARB ;***Print blank MAR for PRN orders.
 NEW L1 S L1="      |           |"
 D HEADER F X=1:1:(BL/2) D
 . F Q=1:1:6 W:Q=1 !,L1,?55,"|",?75,"| ",L1 W:Q'=1 !,?55,"|",?75,"| "
 . W !,LN1
 D BOT
 K ^TMP($J,"1PRN")
 Q
 ;
EN ;***Start print prn orders.
 NEW LABX,L1,P1,P2 S (PG,LAB)=0,L1="      |            |"
 S:'$D(PSGMPG) PSGMPG=0 S PSGMPGN="PAGE: "
 F  S PG=$O(^TMP($J,"1PRN",PG)) Q:'PG  D
 . D HEADER
 . F LAB=0:0 S LABX=LAB,LAB=$O(^TMP($J,"1PRN",PG,LAB)) Q:'LAB  F LN=0:0 S LN=$O(^TMP($J,"1PRN",PG,LAB,LN)) Q:'LN  D
 .. S P1=$P(^TMP($J,"1PRN",PG,LAB,LN),U,1),P2=$P(^(LN),U,2)
 .. S:LN=1 P1=$S(P1]"":P1,1:L1),P2=$S(P2]"":P2,1:L1)
 .. W !,P1,?55,"|",?75,"| ",P2
 .. W:'(LN#6) !,LN1
 . F LABX=LABX+1:1:(BL/2) D
 . .F X=1:1:6 S:X=1 (P1,P2)=L1 W !,P1,?55,"|",?75,"| ",P2 S (P1,P2)=""
 . .W !,LN1
 . S:'$O(^TMP($J,"1PRN",PG)) PSGMPGN="LAST PAGE: " D BOT
 Q
 ;
HEADER ;*** Patient info
 S:'$G(PSGXDT) PSGXDT=PSGDT
 W:$G(PSGPG) @IOF S PSGPG=1 W ?1,"ONE-TIME/PRN SHEET",?61,PSGMARDF_" DAY MAR",?100,PSGMARSP_"  through  "_PSGMARFP
 W !?5,$P($$SITE^PSGMMAR2(80),U,2),?102,"Printed on  ",$$ENDTC2^PSGMI(PSGXDT)
 W !?5,"Name:  "_PPN,?62,"Weight (kg): "_WT,?103,"Loc: "_$S(PWDN'["C!":PWDN,1:$P($G(^SC($P(PWDN,"!",2),0)),"^"))
 W !?6,"PID:  "_PSSN,?25,"DOB: "_BD_"  ("_PAGE_")",?62,"Height (cm): "_HT,?99,"Room-Bed: "_$S(PWDN'["C!":PRB,1:"")
 W !?6,"Sex:  "_PSEX,?25," Dx: "_DX,?$S(TD:94,1:99),$S(TD:"Last Transfer: "_TD,1:"Admitted: "_$S(PWDN'["C!":AD,1:""))
 I '$D(PSGALG) W !,"Allergies:  See attached list of Allergies/Adverse Reactions"
 NEW PSGX S PSGX=0 D ATS^PSGMAR3(.PSGX) D:PSGX HEADER Q:PSGX
 I $G(PSJDIET)]"" W !?57,"Diet: ",PSJDIET
 E  W !
 ;* W !!?1,"Order",?9,"Start",?21,"Stop",?77,"Order",?85,"Start",?97,"Stop",!,LN1
 W !?1,"Order",?9,"Start",?21,"Stop",?77,"Order",?85,"Start",?97,"Stop",!,LN1
 Q
 ;
BOT ; rest of PRN sheet
 W !,"|  DATE  |  TIME  |         MEDICATION/DOSE/ROUTE           | INIT |        REASON         |       RESULTS         |  TIME  | INIT |"
 S X=$S(BL=4:26,1:20) F Q=1:1:X W !,LN31
 ;W "|        |        |                                         |      |                       |                       |        |      |"
ENB ;
 I $D(PSGMPG) S PSGMPG=PSGMPG+1 S PSGMPGN=$S(PSGMPGN'["LAST":"PAGE: ",1:PSGMPGN)_PSGMPG
 W !,LN1
 W !,"|",?13,"SIGNATURE/TITLE",?40,"| INIT |          INJECTION SITES           |",?97,"SIGNATURE/TITLE",?124,"| INIT |"
 F Q=1:1:10 W !,"|"_$E(LN1,1,39)_"|------|"_BLN(Q),?84,"|"_$E(LN1,1,39)_"|------|"
 W !,LN1,!?3,PPN,?45,PSSN,?58,"Room-Bed: "_$S(PWDN'["C!":PRB,1:""),?100,$S($D(PSGMPG):PSGMPGN,1:""),?116,"VA FORM 10-5568d",*13
 S PSGMAROC=0,(PSGMAPA(1),PSGMAPB(1),PSGMAPC(1),PSGMAPD(1))="      |       |" F Q=2:1:6 S (PSGMAPA(Q),PSGMAPB(Q),PSGMAPC(Q),PSGMAPD(Q))=""
 Q
