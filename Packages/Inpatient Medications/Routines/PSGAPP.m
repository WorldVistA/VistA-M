PSGAPP ;BIR/CML3-PRINT DATA FOR ACTION PROFILE ;05 Oct 98 / 10:36 AM
 ;;5.0; INPATIENT MEDICATIONS ;**8,20,60,50,111,169**;16 DEC 97
 ;
LOOP ;
 D NOW^%DTC S PSGDT=%,DT=$$DT^XLFDT,PSGPDT=$$ENDTC2^PSGMI(PSGDT),CML=IO'=IO(0)!($E(IOST,1,2)'="C-")
 U IO I '$D(^TMP($J)) W:$Y @IOF W !?28,"UNIT DOSE ACTION PROFILE",?62,PSGPDT,!?10,"NO ACTIVE ORDERS FOUND FOR ",$S(PSGSS="G":"WARD GROUP: "_PSGAPWGN,PSGSS="W":"WARD: "_PSGAPWDN,1:"PATIENT(S) SELECTED"),"." G DONE
 S PSGVAMC=$$SITE^PSGMMAR2(80)
 S (LN,LINE,ALN)="",$P(LN,"_",19)="",$P(LINE,"-",81)="",$P(ALN," -",18)="",ALN=ALN_" A C T I V E"_ALN
 S (PN,WD,TM)="" F  S WD=$O(^TMP($J,WD)) Q:WD=""!$D(PSJDLW)  F  S TM=$O(^TMP($J,WD,TM)) Q:TM=""!$D(PSJDLW)  F  S PN=$O(^TMP($J,WD,TM,PN)) Q:PN=""!$D(PSJDLW)  D
 . ;naked reference on line below refers to the full reference on the line above
 . S PI=$G(^(PN)),AMO=0 S:PI="" PI=$G(^TMP($J,WD,"zz",PN)) D H1
 ;
DONE ;
 W:CML&($Y) @IOF K AD,ALN,AMO,CML,DF,LINE,LN,MF,N,PG,PI,PPN,PSGPDT,RCT,RF,PID,TD,TM,WD,PSJDLW,PSJTEAM,PSGVAMC,PSJCNTR,PSJAMO Q
 ;
H1 ;
 Q:$D(PSJDLW)
 I $E(IOST,1)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:$D(DTOUT)!$D(DUOUT) PSJDLW=1 I $D(DTOUT)!$D(DUOUT) Q
 S (N,DF)=0,PSEX=$P(PI,"^"),PDOB=$P(PI,"^",2),PID=$P(PI,"^",3),RB=$P(PI,"^",5),AD=$P(PI,"^",6),TD=$P(PI,"^",7),WT=$P(PI,"^",8),PI=$P(PI,"^",4),PPN=$P(PN,"^",2),(DFN,PSGP)=$P(PN,"^",3)
 S PAGE=$P(PDOB,";",2),PDOB=$P(PDOB,";"),PG=1 W:$Y @IOF W !?26,"UNIT DOSE ACTION PROFILE #1",?62,PSGPDT
 W !?+PSGVAMC,$P(PSGVAMC,U,2)
 W !?23,"(Continuation of VA FORM 10-1158)",?72,"Page: 1",!,LINE
 W !,"   This form is to be used to REVIEW/RENEW/CANCEL existing active medication",!," orders for inpatients.  Review the active orders listed and beside"
 W " each order",!," circle one of the following:",!?30,"R - to RENEW the order",!?30,"D - to DISCONTINUE the order",!?30,"N - to take NO ACTION (the order will remain",!?34,"active until the stop date indicated)"
 W !!,"   A new order must be written for any new medication or to make any changes",!," in dosage or directions on an existing order.",!,LINE,!
 S PSJOPC="" D ENTRY^PSJHEAD(DFN,PSJOPC,PG,$G(PSJNARC),$G(PSJTEAM,1),1)
 W !,LINE,!," No. Action",?16,"Drug",?52,"ST Start Stop  Status/Info",!,ALN
END ;
 S (ON,DRG)="" F  S DRG=$O(^TMP($J,WD,TM,PN,DRG)) Q:DRG=""  F  S ON=$O(^TMP($J,WD,TM,PN,DRG,ON)) Q:ON=""  S ND=^(ON),SI=$G(^(ON,1)) D NP:$Y+11>IOSL Q:$D(PSJDLW)  D ORDP
 Q:$D(PSJDLW)
 I $D(^PS(53.1,"AC",PSGP)) W !!?13,"******** THIS PATIENT HAS NON-VERIFIED ORDERS. ********"
 S DF=1 W:'$D(PSJDLW) !!?16,LN,?40,LN_LN,!?16,"Date AND Time",?40,"PROVIDER'S SIGNATURE"
 D:$Y+11>IOSL NP1 W:'$D(PSJDLW) !!!?10,"MULTIDISCIPLINARY REVIEW",!?16,"(WHEN APPROPRIATE)",?40,LN_LN,!?40,"PHARMACIST'S SIGNATURE"
 D:$Y+7>IOSL NP1 W:'$D(PSJDLW) !!?40,LN_LN,!?40,"NURSE'S SIGNATURE"
 ; PSJ*5*169 Standardize AMO section to 10 lines.
 N PSJCNTR,PSJAMO
 I IOSL-$Y>11 D
 . W !!?3,"ADDITIONAL MEDICATION ORDERS:"
 . F PSJCNTR=1:1:10 W !!,LINE S PSJAMO=0 I $Y+9>IOSL S PSJAMO=1 D NP1
 . S AMO=1
 I  W !!?16,LN,?40,LN_LN,!?16,"Date AND Time",?40,"PROVIDER'S SIGNATURE",!
 E  I $Y+6<IOSL F Q=$Y+5:1:IOSL-1 W !
 W:'$D(PSJDLW) !?2,PPN,?40,PID,?78-$L(PDOB),PDOB
 ; PSJ*5*169 Standardize AMO section to 10 lines.
 I 'AMO D
 .S AMO=1 D NP1 Q:$D(PSJDLW)  D
 . . W !!?3,"ADDITIONAL MEDICATION ORDERS:"
 . . F PSJCNTR=1:1:10 W !!,LINE S PSJAMO=0 I $Y+9>IOSL S PSJAMO=1 D NP1
 .W:'$D(PSJDLW) !!?16,LN,?40,LN_LN,!?16,"Date AND Time",?40,"PROVIDER'S SIGNATURE",!
 .W:'$D(PSJDLW) !?2,PPN,?40,PID,?78-$L(PDOB),PDOB
 Q
 ;
ORDP ;
 S N=N+1 I ND="" D PRT^PSGAPIV(ON) Q
 N X,PSG S PSGP=$P(PN,U,3)
 D DRGDISP^PSJLMUT1(+PSGP,+ON_"U",39,65,.PSG,0)
 S SM=$P(ND,"^",5),NF=$P(ND,"^",6) W !,$J(N,3) W $S($P(DRG,"^")="O":"   ",1:"  R")_" D N "  ;PSJ*5*169 Don't allow RENEW for one-time orders.
 W PSG(1),?52,$P(DRG,U),?55,$P(ND,U,2),?61,$P(ND,U,3),?67,$P(ND,U) I NF!SM!$P(ND,U,4) W ?71 W:NF "NF " W:$P(ND,U,4) "WS " W:SM $E("HSM",SM,3)
 N X F X=1:0 S X=$O(PSG(X)) Q:'X  W !?11,PSG(X)
 I SI]"" W !?11,"Special Instructions: " F X=1:1:$L(SI," ") S Y=$P(SI," ",X) W:$X+$L(Y)>78 !?35 W Y," "
 W ! Q
 ;
NP ;
 Q:$G(PSJDLW)
 W !!?16,LN,?40,LN_LN,!?16,"Date and Time",?40,"PROVIDER'S SIGNATURE"
 ;
NP1 ;
 Q:$D(PSJDLW)
 I $E(IOST,1)="C" K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S PSJDLW=1 Q
 I $Y+5<IOSL F Q=$Y:1:IOSL-4 W !
 S PG=PG+1 W:'AMO !?2,PPN,?40,PID,?78-$L(PDOB),PDOB W:$Y @IOF W !?26,"UNIT DOSE ACTION PROFILE #1",?73-$L(PG),"Page: "_PG
 W !?+PSGVAMC,$P(PSGVAMC,U,2)
 W !?1,PPN,?40,PID,?60,PDOB
 ; PSJ*5*169 Standardize AMO section to 10 lines.
 I DF D  Q
 . I $G(PSJAMO)=1 W !!,"ADDITIONAL MEDICATION ORDERS (CONTINUED):",! Q
 . W !!,LINE
 W:'AMO !!," No. Action",?16,"Drug",?52,"ST Start Stop  Status/Info",!,ALN Q
 ;
ENRCT ;
 N DFN,GMRA,GMRAL,RCT,X S DFN=PSGP,GMRA="0^0^111" D EN1^GMRADPT
 S X=0 F  S X=$O(GMRAL(X)) Q:'X  I $P(GMRAL(X),"^",2)]"" S RCT($P(GMRAL(X),"^",2))=""
 I '$D(RCT) W " ____________________" Q
 S RCT="" F X=0:1 S RCT=$O(RCT(RCT)) Q:RCT=""  W:X "," W:$X+$L(RCT)>77 ! W " ",$S(RCT="NKA":"No Known Allergies",1:RCT)
 Q
