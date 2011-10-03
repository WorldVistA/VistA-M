DGBT1 ;ALB/SCK - BENEFICIARY TRAVEL DISPLAY SCREEN 1; 12/15/92  1/8/93 4/1/93 ; 10/31/05 1:11pm
 ;;1.0;Beneficiary Travel;**11**;September 25, 2001
 Q
SCREEN ;  clear screen and write headers
 W @IOF
 W !?18,"Beneficiary Travel Claim Information <Screen 1>"
 W !!?2,"Claim Date: ",DGBTDTE
 D PID^VADPT6 W !!?8,"Name: ",VADM(1),?40,"PT ID: ",VA("PID"),?64,"DOB: ",$P(VADM(3),"^",2)
 W !!?5,"Address: ",VAPA(1) W:VAPA(2)]"" !?14,VAPA(2) W:VAPA(3)]"" !?14,VAPA(3) W !?14,VAPA(4),$S(VAPA(4)]"":", "_$P(VAPA(5),"^",2)_"  "_$P(VAPA(11),U,2),1:"UNSPECIFIED")
SETVAR  ;  if new claim, move in current info for elig, sc%
 I 'CHZFLG S DGBTELG=VAEL(1),DGBTCSC=VAEL(3)
 I +DGBTELG=3,'$E(DGBTCSC)=1 S DGBTCSC=1
 W !!," Eligibility: ",$P(DGBTELG,"^",2) W:DGBTCSC ?45,"SC%: ",$P(DGBTCSC,"^",2)
 I $O(VAEL(1,0))'="" W !," Other Elig.: " F I=0:0 S I=$O(VAEL(1,I)) Q:'I  W ?14,$P(VAEL(1,I),"^",2),!
SC ;  service connected status/information
 I DGBTCSC&($P(DGBTCSC,"^",2)'>29) W !!,"Disabilities:" S I3=""
 N DGQUIT
 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I!($G(DGQUIT)=1)  D
 . S I1=^(I,0),I2=$S($D(^DIC(31,+I1,0)):$P(^(0),"^",1)_" ("_+$P(I1,"^",2)_"%-"_$S($P(I1,"^",3):"SC",1:"NSC")_")",1:""),I3=I1
 . I $Y>(IOSL-3) D PAUSE I DGQUIT=0 W @IOF
 . I $G(DGQUIT)=1 Q
 . W !?14 W I2
 ;
INCOME ;  income and eligibility information
 N DGBTIFL S DGBTIFL=$P(DGBTINC,U,2)
 W !!?2,"Income: ",$P(DGBTINC,U),?40,"Source of Income:  ",$S(DGBTIFL="M":"MEANS TEST",DGBTIFL="C":"COPAY TEST",DGBTIFL="I":"INCOME SCREENING",DGBTIFL="V":"VA CHECK",1:"")
 W !?2,"No. of Dependents: ",DGBTDEP
 I DGBTMTS]"" W:$P(DGBTMTS,"^")'="N" ?40,"MT Status: ",$S($P(DGBTMTS,"^")="R":"REQUIRED",$P(DGBTMTS,"^")="P":$P($P(DGBTMTS,"^",2)," "),DGBTMTS=U:" NOT APPLICABLE",1:$P(DGBTMTS,"^",2))
 W:$P(DGBTMTS,"^")="P" !?68,$P($P(DGBTMTS,"^",2)," ",2)
 I $P(DGBTMTS,"^")="N" W !!?20,"MEANS TEST ",$P(DGBTMTS,"^",2)
 ;
 W !!?2,"BT Income: ",$S($D(DGBTCA):DGBTCA,1:"NOT RECORDED") W:$D(DGBTCE) ?25,"Certified Eligible: ",$S(DGBTCE:"YES",1:"NO"),?53,"Date Certified: ",$S($D(DGBTCD):DGBTCD,1:"NOT RECORDED")
 I $D(DGBTCE) I DGBTCE'=1 W *7,*7,!!?8,"* * * NOTE * * PATIENT HAS BEEN CERTIFIED INELIGIBLE BASED ON INCOME"
 S DGBTINFL="" I $D(DGBTINC),$D(DGBTCA),$P(DGBTINC,U)'=DGBTCA,$P(DGBTMTS,"^")'="N" S DGBTINFL=" * * * * Discrepancy exists in incomes reported, please verify * * * *" W !!?5,DGBTINFL
 F I=$Y:1:20 W !
QUIT ;
 K I1,I2,I3
 Q
 ;
PAUSE   ;added with DGBT*1*11
 I $E(IOST,1,2)["C-" N DIR S DIR(0)="E" D ^DIR S DGQUIT='Y
 Q
