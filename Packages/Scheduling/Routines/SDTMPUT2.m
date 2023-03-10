SDTMPUT2 ;MS/SJA - VISTA-BULK DEFAULT PROVIDER UPDATE ;May 15, 2022
 ;;5.3;Scheduling;**817**;Aug 13, 1993;Build 7
 ;
 ;
 N AA,ACT,ALL,CLN,CNT,LN,DIV,III,NUM,LOC,RESTCD,SC,STCODE,STOP,SDASH,SDOUT,STIEN,VAL,SEL
 N TOT,TOTAL,VAUTD,CLIEN,PRIEN,XX
EN ;
 K ^TMP($J)
 S $P(SDASH,"=",80)="",(SEL,ACT,DIV)="",(ALL,SDOUT)=0
 W @IOF W !,?20,"Bulk update for Default Provider field",!
 D ASK Q:SDOUT
 S:$G(VAUTD)=1 DIV="ALL"
 W ! D @SEL
 G EN
 ;
C ; clinic
 K ^TMP($J) S (TOTAL,TOT)=0
 K DIC,DTOUT,DUOUT S DIC="^SC(",DIC(0)="AEQM",DIC("A")="Select Clinic: "
C1 D ^DIC I Y>0 S ^TMP($J,"CL",+Y)="",DIC("A")="Another one:" G C1
 I $D(DTOUT)!($D(DUOUT))!('$O(^TMP($J,"CL",0))) Q
 F III=0:0 S III=$O(^TMP($J,"CL",III)) Q:'III  D
 . W:TOTAL=0 !,SDASH,!
 . D PRC(III)
 W !!
 W !,"Total number of clinics updated ",TOT," out of ",TOTAL
 W !! S DIR(0)="EA",DIR("A")="Press <Enter> to continue" D ^DIR K DIR
 Q
 ;
S ; stop codes
 K ^TMP($J) S (LN,TOTAL,TOT)=0
 K DIC,DTOUT,DUOUT S DIC="^SD(40.6,",DIC(0)="AEMQ",DIC("A")="Select Telehealth Stop Code: "
S1 D ^DIC I Y>0 S ^TMP($J,"ST",+Y)="",DIC("A")="Select another Telehealth Stop Code: " G S1
 I $D(DTOUT)!($D(DUOUT))!('$O(^TMP($J,"ST",0))) Q
 W !
 F STIEN=0:0 S STIEN=$O(^TMP($J,"ST",STIEN)) Q:'STIEN  S CLN=$$ST(STIEN)
 F III=0:0 S III=$O(^TMP($J,"CL",III)) Q:'III  S STOP=$G(^(III)) D
 . W:TOTAL=0 !,SDASH,!
 . S LN=LN+1 W:'(LN#50) "." D PRC(III,STOP)
 W !!
 W !,"Total number of clinics updated ",TOT," out of ",TOTAL
 W !! S DIR(0)="EA",DIR("A")="Press <Enter> to continue" D ^DIR K DIR
 Q
 ;
P ; provider selection
 K ^TMP($J) S (TOTAL,TOT)=0
 S DIC=200,DIC("A")="Select Provider: ",DIC(0)="AEMQ",DIC("S")="I $$SCREEN^SDUTL2(Y,DT)"
P1 D ^DIC I Y>0 S ^TMP($J,"PR",+Y)="",DIC("A")="Another one:" G P1
 I $D(DTOUT)!($D(DUOUT))!('$O(^TMP($J,"PR",0))) Q
 F III=0:0 S III=$O(^TMP($J,"PR",III)) Q:'III  D
 . W:TOTAL=0 !!,SDASH,!
 . D PRU(III)
 W !!
 W !,"Total number of clinics updated ",TOT," out of ",TOTAL
 W !! S DIR(0)="EA",DIR("A")="Press <Enter> to continue" D ^DIR K DIR
 Q
 ;
ST(STIEN) ; stop codes search
 N FLAG,FLG1,FLG2,CODE,P1,P2,P407F,P407S,II,NODE0,CLSTP1,CLSTP2,XX
 S (FLAG,P407F,P407S,P1,P2)=0
 S CODE=$G(^SD(40.6,STIEN,0)),P1=$E(CODE,1,3),P2=$E(CODE,4,6)
 S P407F=$O(^DIC(40.7,"C",P1,0)) S:P2 P407S=$O(^DIC(40.7,"C",P2,0))
 S II=0
 F  S II=$O(^SC(II)) Q:'II  S FLAG=0 D
 . S NODE0=$G(^SC(II,0)),CLSTP1=$P(NODE0,U,7),CLSTP2=$P(NODE0,U,18)
 . I (SC="P"&($G(CLSTP1)="")!(SC="S"&$G(CLSTP2)="")) Q
 . I SC="P" I $G(P407F)=$G(CLSTP1)!(CLSTP1=$G(P407S)) S FLAG=1
 . I SC="S" I $G(P407F)=$G(CLSTP2)!(CLSTP2=$G(P407S)) S FLAG=1
 . I 'FLAG Q
 . S XX=$$ACTIVE(II)
 . I 'XX&(ACT="A") Q
 . S ^TMP($J,"CL",II)=$S(CLSTP1:$$GET1^DIQ(40.7,CLSTP1,1),1:"")_U_$S(CLSTP2:$$GET1^DIQ(40.7,CLSTP2,1),1:"")
 Q 1
 ;
EXIT ; kill and exit
 K DTOUT,DUOUT,DTOT
 K ^TMP($J)
 Q
 ;
ASK ; selection options
 W ! K DIR,Y S DIR(0)="SA^C:Clinic;S:Stop Code;P:Provider;Q:Quit"
 S DIR("A")="Select (C)linic, (S)top Code, (P)rovider, or (Q)uit: "
 S DIR("B")="C"
 D ^DIR K DIR I Y="Q"!$D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 S ACT="A" W !
 S SEL=Y W ! I SEL'="S" Q
 S DIR(0)="SA^P:Primary Stop Code;S:Secondary Stop Code"
 S DIR("A")="(P)rimary Stop Code, (S)econdary Stop Code: "
 S DIR("B")="P"
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 S SC=Y
 Q
 ;
ACTIVE(LOC) ;determine if clinic is active
 ; Output X:1=ACTIVE, 
 ;        X:0=INACTIVE
 N NODE,I1,I2,X
 S X=0
 S NODE=$G(^SC(LOC,"I")) Q:NODE="" 1
 S I1=$P(NODE,U,1)   ;inactive date/time
 S I2=$P(NODE,U,2)   ;reactive date/time
 I (I1="") S X=1 Q X
 I ((I1'="")&(I1>DT))!((I2'="")&(I2'>DT)) S X=1 Q X
 Q X
 ;
PRU(PRIEN) ; call for provider call
 S (CLN,CNT,TOTAL)=0,VAL="" F  S CLN=$O(^SC("AVADPR",PRIEN,CLN)) Q:'CLN  S TOTAL=TOTAL+1 D
 . S (CNT,NUM)=0 F  S NUM=$O(^SC(CLN,"PR",NUM)) Q:'NUM  S CNT=CNT+1,AA=$G(^(NUM,0)) S:$P(AA,U,2) VAL=$P(AA,U)_U_CLN
 . I $G(CLN) S STOP=$$SC(CLN)
 . I $$GET1^DIQ(44,CLN,16,"I") W !,CLN,?12,$$GET1^DIQ(44,$P(VAL,U,2),.01),STOP W !,?8,"--- No action taken, default provider is already set.",! Q
 . I CNT>1 W !,$P(VAL,U,2),?12,$$GET1^DIQ(44,$P(VAL,U,2),.01),STOP W !,?8,"--- No action taken, multiple providers assigned.",! Q
 . I CNT=1,'$$GET1^DIQ(44,CLN,16,"I"),+VAL D
 . . K DR S DR="16////"_$P(VAL,U),DA=CLN,DIE=44 D ^DIE K DA,DIE,DR
 . . W !,$P(VAL,U,2),?12,$$GET1^DIQ(44,CLN,.01),STOP W !,?8,">>> Default Provider set to: ",$$GET1^DIQ(200,+VAL,.01),! S TOT=TOT+1
 . I CNT=1,('$$GET1^DIQ(44,CLN,16,"I")&('+VAL)) W !,CLIEN,?12,$$GET1^DIQ(44,CLN,.01),STOP W !,?8,"--- No action taken, no default provider found.",!
 . I CNT=0,('$$GET1^DIQ(44,CLN,16,"I")&('+VAL)) W !,CLIEN,?12,$$GET1^DIQ(44,CLN,.01),STOP W !,?8,"--- No action taken, no Providers found.",!
 Q
 ;
PRC(CLIEN,STCODE) ; call for clinic search
 S RESTCD=",136,444,446,490,644,646,690,694,699,723,901,",TOTAL=TOTAL+1
 S (CNT,NUM)=0,STOP="",VAL="" F  S NUM=$O(^SC(CLIEN,"PR",NUM)) Q:'NUM  S CNT=CNT+1,AA=$G(^(NUM,0)) S:$P(AA,U,2) VAL=$P(AA,U)_U_CLIEN
 I $G(CLIEN) S STOP=$$SC(CLIEN)
 I SEL="S" S II=$S(SC="P":1,1:2) I $P(STCODE,U,II),RESTCD[(","_$P(STCODE,U,II)_",") D  Q
 . W !,CLIEN,?12,$$GET1^DIQ(44,CLIEN,.01),$$SC(CLIEN)
 . W !,?8,"--- Telehealth Patient Site Stop Codes are not allowed for Bulk",!,?12,"Default Provider Update"
 I $$GET1^DIQ(44,CLIEN,16,"I") W !,CLIEN,?12,$$GET1^DIQ(44,CLIEN,.01),STOP W !,?8,"--- No action taken, default provider is already set.",! Q
 I CNT>1,$G(VAL) W !,$P(VAL,U,2),?12,$$GET1^DIQ(44,$P(VAL,U,2),.01),$$SC($P(VAL,U,2)) W !,?8,"--- No action taken, multiple providers assigned.",! Q
 I CNT=1,$G(VAL),'$$GET1^DIQ(44,CLIEN,16,"I"),+VAL D
 . K DR S DR="16////"_$P(VAL,U),DA=CLIEN,DIE=44 D ^DIE K DA,DIE,DR
 . W !,$P(VAL,U,2),?12,$$GET1^DIQ(44,CLIEN,.01),STOP W !,?8,">>> Default Provider is set to: ",$$GET1^DIQ(200,+VAL,.01),! S TOT=TOT+1
 I CNT=1,('$$GET1^DIQ(44,CLIEN,16,"I")&('+VAL)) W !,CLIEN,?12,$$GET1^DIQ(44,CLIEN,.01),STOP W !,?8,"--- No action taken, no default provider found.",!
 I CNT=0,('$$GET1^DIQ(44,CLIEN,16,"I")&('+VAL)) W !,CLIEN,?12,$$GET1^DIQ(44,CLIEN,.01),STOP W !,?8,"--- No action taken, no Providers found.",!
 Q
 ;
SC(CLIEN) ; call to return clinic stop codes
 N NODE0,RESULT
 S NODE0=$G(^SC(CLIEN,0))
 S RESULT=" ("_$$GET1^DIQ(40.7,$P(NODE0,U,7),1)_"/"_$$GET1^DIQ(40.7,$P(NODE0,U,18),1)_")"
 Q RESULT
 ;
