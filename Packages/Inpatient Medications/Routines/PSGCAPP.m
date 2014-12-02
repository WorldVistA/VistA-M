PSGCAPP ;BIR/CML3-PRINT DATA FOR ACTION PROFILE ;05 Oct 98 / 10:21 AM
 ;;5.0;INPATIENT MEDICATIONS;**8,20,60,111,149,169,275,301**;16 DEC 97;Build 3
LOOP ;
 N PSJCLIN1
 D NOW^%DTC S PSGDT=%,PSGPDT=$$ENDTC2^PSGMI(PSGDT),CML=IO'=IO(0)!($E(IOST,1,2)'="C-")
 U IO I '$D(^TMP($J)) D  G DONE
 .W:$Y @IOF W !?26,"UNIT DOSE ACTION PROFILE #2",?62,PSGPDT,!?10,"NO ",$S(PSGAPO="E":"EXPIRING",1:"ACTIVE")," ORDERS FOUND FOR ",$S(PSGSS="G":"WARD GROUP: "_PSGAPWGN,PSGSS="W":"WARD: "_PSGAPWDN,1:"PATIENT(S) SELECTED"),"."
 S (LN,LINE,ALN,S1,WD,PN)="",$P(LN,"_",19)="",$P(LINE,"-",81)="",$P(ALN," -",18)="",ALN=ALN_" A C T I V E"_ALN
 S PSGVAMC=$$SITE^PSGMMAR2(80)
 F  S (PS1,S1,PSJTEAM)=$O(^TMP($J,S1)) Q:S1=""!$D(PSJDLW)  S:S1="zz" (PS1,PSJTEAM)="NOT FOUND" F  S WD=$O(^TMP($J,S1,WD)) Q:WD=""!$D(PSJDLW)  D
 . F  S PN=$O(^TMP($J,S1,WD,PN)) Q:PN=""!$D(PSJDLW)  S PI=$G(^(PN)) S:PI="" PI=$G(^TMP($J,S1,"zz",PN)) S:((PI="")&$P($G(PN),"^",2)) PI=$$SETPI^PSGCAP0($P(PN,"^",2)) D H1
 ;
DONE ;PSJ*5*149 Add WD1 to killed variables.
 W:CML&($Y) @IOF K AD,ALN,CML,DF,LINE,LN,MF,N,PG,PI,PPN,PS1,PSGPDT,RCT,RF,PID,TD,WD,PSJDLW,PSGVAMC,WD1,PSJCNTR,PSJAMO Q
 ;
H1 ; first header for patient
 ; PSJ*5*149 Use WD1 to preserve value of WD
 N WD1
 I $P(WD,"^")="zz",($P(WD,"^",2)]"") I ($P(WD,"^",2)'=$P($G(PSJCLIN1),"^",2)) S PSJCLIN1=WD D
 .N MIDLEN,SIDLEN S MIDLEN=$L($P(PSJCLIN1,"^",2)) S SIDLEN=((81-MIDLEN)\2)
 .S (LN,LINE,ALN)="",$P(LN,"_",(SIDLEN\2))="",$P(LINE,"-",81)="",$P(ALN," -",(SIDLEN\2))="",ALN=ALN_$P(PSJCLIN1,"^",2)_ALN
 I $G(WD)="zz" S WD1=WD N WD S WD="*NF*"
 D ^PSGCAPP0
 S WD=$G(WD1,WD)
END ;
 S (ON,DRG)="" F  S DRG=$O(^TMP($J,S1,WD,PN,DRG)) Q:DRG=""  F  S ON=$O(^TMP($J,S1,WD,PN,DRG,ON)) Q:ON=""  S ND=^(ON),SI=$G(^(ON,1)) D NP:$Y+12>IOSL Q:$D(PSJDLW)  D ORDP
 ; Check for orders in other locations for the same patient; ensure all of one patient's orders display in the same section of the report
 N WD2,PN2,DRG2,ON2 S WD2="" F  S WD2=$O(^TMP($J,S1,WD2)) Q:WD2=""  I WD2'=WD S PN2="" F  S PN2=$O(^TMP($J,S1,WD2,PN2)) Q:PN2=""  I PN2=PN S (WD2(WD2),DRG2)="" F  S DRG2=$O(^TMP($J,S1,WD2,PN2,DRG2)) Q:DRG2=""  D
 .S ON2="" F  S ON2=$O(^TMP($J,S1,WD2,PN2,DRG2,ON2)) Q:ON2=""  N WD,DRG,ON S WD=WD2,DRG=DRG2,ON=ON2 S ND=^(ON),SI=$G(^(ON,1)) D NP Q:$D(PSJDLW)  D ORDP
 ; Remove the previously printed orders from the 'other' locations so they are not printed again later
 N TMPWD S TMPWD="" F  S TMPWD=$O(WD2(TMPWD)) Q:TMPWD=""  K ^TMP($J,S1,TMPWD,PN)
 Q:$D(PSJDLW)
 I $D(^PS(53.1,"AC",PSGP)) W !!?13,"******** THIS PATIENT HAS NON-VERIFIED ORDERS. ********"
 S DF=1 W:'$D(PSJDLW) !!?16,LN,?40,LN_LN,!?16,"Date AND Time",?40,"PROVIDER'S SIGNATURE"
 D:$Y+10>IOSL NP1 W:'$D(PSJDLW) !!!?10,"MULTIDISCIPLINARY REVIEW",!?16,"(WHEN APPROPRIATE)",?40,LN_LN,!?40,"PHARMACIST'S SIGNATURE"
 D:$Y+6>IOSL NP1 W:'$D(PSJDLW) !!?40,LN_LN,!?40,"NURSE'S SIGNATURE"
 ; PSJ*5*169 Standardize AMO section to 10 lines.
 N PSJCNTR,PSJAMO
 I IOSL-$Y>10 D
 . W !!?3,"ADDITIONAL MEDICATION ORDERS:"
 . F PSJCNTR=1:1:10 W !!,LINE S PSJAMO=0 I $Y+9>IOSL S PSJAMO=1 D NP1
 I  W:'$D(PSJDLW) !!?16,LN,?40,LN_LN,!?16,"Date AND Time",?40,"PROVIDER'S SIGNATURE",!
 E  F Q=$Y+5:1:IOSL-1 W !
 W:'$D(PSJDLW) !?2,PPN,?40,PID,?78-$L(PDOB),PDOB Q
 ;
ORDP ;
 S N=N+1 I ON["V" D PRT^PSGCAPIV(ON) Q
 N X,PSG S PSGP=$P(PN,U,2)
 D DRGDISP^PSJLMUT1(+PSGP,+ON_"U",39,69,.PSG,0)
 S SM=$P(ND,"^",5),NF=$P(ND,"^",6),DCU=$P(ND,"^",7),DCU=$S($E(DCU)=".":"0"_DCU,'DCU:"0.00",1:DCU) W !,$J(N,3)
 W ?5,PSG(1),?46,$P(DRG,"^"),?49,$P(ND,"^",2),?55,$P(ND,"^",3),?61,$P(ND,"^") I NF!SM!$P(ND,"^",4) W ?65 W:NF "NF " W:$P(ND,"^",4) "WS " W:SM $E("HSM",SM,3)
 N X F X=1:0 S X=$O(PSG(X)) Q:'X  W !?5,PSG(X)
 I SI]"" W !?8,"Special Instructions: " F X=1:1:$L(SI," ") S Y=$P(SI," ",X) W:$X+$L(Y)>78 !?31 W Y," "
ORDP1 ;*** Also being called from ^PSGCAPIV.   PSJ*5*169 Don't allow RENEW on one-time orders.
 W !!?5,"__TAKE NO ACTION     __DISCONTINUE     "_$S($P(DRG,"^")="O"!($G(QST)="O"):"       ",1:"__RENEW")_"   COST/DOSE: ",DCU,!?2,"------------------------------------------------------------------------",! Q
 ;
NP ;
 W:'$D(PSJDLW) !!?16,LN,?40,LN_LN,!?16,"Date AND Time",?40,"PROVIDER'S SIGNATURE"
 ;
NP1 ;
 Q:$D(PSJDLW)
 I $E(IOST,1)="C" K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S PSJDLW=1 Q
 F Q=$Y:1:IOSL-4 W !
 I '$G(PG),$P($G(PI),"^",3) S (N,DF)=0,PSEX=$P(PI,"^"),PDOB=$P(PI,"^",2),PID=$P(PI,"^",3),RB=$P(PI,"^",5),AD=$P(PI,"^",6),TD=$P(PI,"^",7),WT=$P(PI,"^",8),WTD=$P(PI,"^",9),HT=$P(PI,"^",10),HTD=$P(PI,"^",11),PPN=$P(PI,"^",12),PSGP=$P(PN,"^",2) D
 .S PAGE=$P(PDOB,";",2),PDOB=$P(PDOB,";"),PG=1
 ;* S PG=PG+1 W !?2,PPN,?40,PID,?78-$L(PDOB),PDOB W:$Y @IOF W !?28,"UNIT DOSE ACTION PROFILE #2",?73-$L(PG),"Page: "_PG,!?1,PPN,?40,PID,?60,PDOB I DF W !!,LINE Q
 S PG=$G(PG)+1 W !?2,PPN,?40,PID,?78-$L(PDOB),PDOB W:$Y @IOF
 W !?26,"UNIT DOSE ACTION PROFILE #2",?73-$L(PG),"Page: "_PG
 W !?+PSGVAMC,$P(PSGVAMC,U,2)
 W !?1,PPN,?40,PID,?60,PDOB
 I DF D  Q
 . I $G(PSJAMO)=1 W !!,"ADDITIONAL MEDICATION ORDERS (CONTINUED):",! Q
 . W !!,LINE
 ; Make sure orders always have correct profile heading - ACTIVE for Inpatient orders, clinic name for Clinic Orders
 I ($$CLINIC^PSJO1($P(PN,"^",2),+ON_"U")]"") N ALN S ALN="" S $P(ALN," -",18)="",ALN=ALN_$$CLINIC^PSJO1($P(PN,"^",2),+ON_"U")_ALN
 I ($$CLINIC^PSJO1($P(PN,"^",2),+ON_"U")=""),$G(PSJPWD) N ALN S ALN="" S $P(ALN," -",18)="",ALN=ALN_" A C T I V E"_ALN
 W !!," No. Action",?16,"Drug",?46,"ST Start Stop  Status/Info",!,ALN
 Q
