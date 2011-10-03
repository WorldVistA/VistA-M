PSGDSP0 ;BIR/ 5:18 PM-DISCHARGE ORDERS CONT. ; 05 Oct 98 / 10:24 AM
 ;;5.0; INPATIENT MEDICATIONS ;**8,20**;16 DEC 97
 ;
 ; Reference to DIS^SDROUT2 supported by DBIA #195.
 ;
ENHDR ; first header for each patient
 S (N,DF)=0,PSEX=$P(PI,"^"),PDOB=$P(PI,"^",2),PSSN=$P(PI,"^",3),RB=$P(PI,"^",5),AD=$P(PI,"^",6),TD=$P(PI,"^",7),SCV=$P(PI,"^",8),SC=$P(PI,"^",9),WT=$P(PI,"^",10),PPN=$P(PN,"^"),PSGP=$P(PN,"^",2),PI=$P(PI,"^",4) S:'WT WT="NF"
 S AGE=$P(PDOB,";",2),PDOB=$P(PDOB,";"),PG=1,VAEL(3)=$P(ELIG,"^",1,2),VAEL(4)=$P(ELIG,"^",3),VAEL(6)=$P(ELIG,"^",4,5),ELIG=$S('VAEL(3):0,1:$P(VAEL(3),"^",2)<50)
 ;
ENHDR1 ;
 S PSGVAMC=$$SITE^PSGMMAR2(80)
 W:$Y @IOF W !?+HDR,"AUTHORIZED ABSENCE/DISCHARGE ",$P(HDR,"^",2),?62,PSGPDT,!?+PSGVAMC,$P(PSGVAMC,U,2),!?1,"VA FORM: 10-7978M",!?1,"Effective Date:" W:HDR>19 ?72,"Page: 1"
 I HDR>19 W !,ELN,!,"Instructions to the physician:",!?4,"A. A prescription blank (VA FORM 10-2577F) must be used for:",!?9,"1. all class II narcotics",!?9,"2. any medications marked as 'nonrenewable'"
 I HDR>19 W !?9,"3. any new medications in addition to those entered on this form." W !?4,"B. If a medication is not to be continued, mark ""TAKE NO ACTION"".",!?4,"C. To continue a medication, you MUST:",!?9,"1. enter directions, quantity,"
 I HDR>19 W " and refills",!?9,"2. sign the order, enter your DEA number, and enter the date AND time."
 W !,ELN,!
 ;,!?1,PPN,?36,"Ward: "_WD,!?7,"PID: "_PSSN,?30,"Weight(kg): "_WT,?61,"Admitted: "_AD
 D ENTRY^PSJHEAD(DFN,$G(PSJOPC),PG,$G(PSJNARC),$G(PSJTEAM,1),1)
 ;W !?7,"DOB: "_PDOB_"  ("_AGE_")",?37,"Sex: "_PSEX W:TD ?53,"Last Transferred: "_TD W !?3,"Inpt Dx: "_PI,?$S($L(RB)<9:61,1:69-$L(RB)),"Room-bed: "_RB,!?1,"Reactions:" D ENRCT
 W !,ELN I HDR>19,$D(^PS(53.1,"AC",PSGP)) W !!?18,"*** THIS PATIENT HAS NON-VERIFIED ORDERS. ***",!
 I HDR>19 W !?4,"___ AUTHORIZED ABSENCE <96 HOURS   ___ AUTHORIZED ABSENCE >96 HOURS",!?8,"NUMBER OF DAYS: _____   (NO REFILLS allowed on AA/PASS meds)",!!?4,"___ REGULAR DISCHARGE   ___ OPT NSC   ___ SC"
 D:HDR'<22 DIS^SDROUT2 W !!?8,"Next scheduled clinic visit" W:'SCV ":" I SCV W " is on ",SCV W:SC]"" " at ",SC
 W:HDR>19 !,ELN,!?56,"Schedule",?72,"Cost per",!," No.",?10,"Medication",?56,"Type",?72,"Dose" Q
 ;
ENRCT ;
 N DFN,GMRA,GMRAL,RCT,X S DFN=PSGP,GMRA="0^0^111" D ^GMRADPT
 S X=0 F  S X=$O(GMRAL(X)) Q:'X  I $P(GMRAL(X),U,2)]"" S RCT($P(GMRAL(X),U,2))=""
 W:'$D(RCT) "____________________" S RCT="" F X=1:1 S RCT=$O(RCT(RCT)) Q:RCT=""  W:X>1 "," W:$X+$L(RCT)>77 ! W " ",RCT
 Q
