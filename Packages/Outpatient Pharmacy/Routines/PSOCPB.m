PSOCPB ;BIR/BaB - pharmacy co-pay application cont'd ;1/30/07 9:08am
 ;;7.0;OUTPATIENT PHARMACY;**72,71,85,185,143,219,239,201,263,303**;DEC 1997;Build 19
 ;
 ;REF/IA
 ;DIS^SDROUT2/112
 ;^IBARX/125
 ;VADPT/10061
 ;SWSTAT^IBBAPI/4663
COPAY ;
 ;Called by PSON52,PSORN52...Requires PSOCPAY,PSOBILL,DEA=PSDEA,PSOFLAG
 ;PSOFLAG=1 NEW, PSOFLAG=0 RENEW
 S PSOSAVE=PSOCPAY ; Save original status of PSOCPAY
 I '$G(PSOSCP)!('$G(PSOSCA)) D SCP^PSORN52D  ;CIDC-must ask sc if flagged for it in enrollment
 I $G(PSODRUG("DEA"))["S"!($G(PSODRUG("DEA"))["I")!($G(PSODRUG("DEA"))["N") S PSOCPAY=0
 G:+PSOBILL'=2&('$G(PSOSCA)) COPAY2
 D FULL^VALM1
 I $G(PSOMESOI)=1,$G(PSORXED) W !!,"The Pharmacy Orderable Item has changed for this order. Please review any",!,"existing SC or Environmental Indicator defaults carefully for appropriateness.",! S PSOMESOI=2
 I $G(PSOMESFI)=1 W !!,"The Pharmacy Orderable Item has changed for this order. Please review any",!,"existing SC or Environmental Indicator defaults carefully for appropriateness.",! S PSOMESFI=2
 S DFN=+$G(PSODFN) D DIS^SDROUT2
ASK ;
 N PSOUFLAG S PSOUFLAG=0
 K PSOCPZ("DFLG"),PSONEW("NEWCOPAY")
 W ! K DIR,DTOUT,DIRUT,DUOUT
 I $G(PSORX("SC"))="SC"!($G(PSORX("SC"))="NSC")!($G(PSOSCOTH)) D
 . W:PSOSCP<50&($G(PSODRUG("DEA"))'["S")&($G(PSODRUG("DEA"))'["I")&($G(PSODRUG("DEA"))'["N") !,"This Rx has been flagged by the provider as: "_$S($G(PSOSCOTH):"NO COPAY",$G(PSORX("SC"))="SC":"NO COPAY",1:"COPAY"),! I $G(PSOSCOTX) S PSOSCOTX=2
 S DIR("A")="Was treatment for Service Connected condition",DIR(0)="Y"
 S DIR("?")="Enter 'Yes' if this prescription is for a Service Connected condition"
 I $G(PSORX("SC"))]""!($G(PSORX(+$G(PSORENW("OIRXN")),"SC"))'="") S DIR("B")=$S($G(PSORX("SC"))="SC":"YES",$G(PSORX("SC"))="NSC":"NO",$G(PSORX(+$G(PSORENW("OIRXN")),"SC"))=1:"YES",$G(PSORX(+$G(PSORENW("OIRXN")),"SC"))=0:"NO",1:"")
 I $G(PSONEWFF),$G(PSOFLAG) I $G(PSOANSQD("SC"))=0!($G(PSOANSQD("SC"))=1) S DIR("B")=$S($G(PSOANSQD("SC"))=1:"YES",1:"NO")
 I $G(DIR("B"))="YES"!($G(DIR("B"))="NO") S PSOUFLAG=$G(DIR("B"))
 I $G(DIR("B"))="" K DIR("B")
 D ^DIR
 I $G(Y)=1!($G(Y)=0) S PSOANSQ("SC")=$G(Y) I $G(PSONEWFF),$G(PSOFLAG) S PSOANSQD("SC")=$G(Y)
 I PSOFLAG I Y["^"!($D(DTOUT))!($D(DUOUT)) S PSOCPZ("DFLG")=1
 S:Y=0 Y=2
 S PSOANSR=+Y I 'PSOANSR,'PSOFLAG D  S $P(PSOCPAY,"^")=$S($G(PSOUFLAG)="NO":1,1:0) W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR G COPAY2
 .W !!,"This Renewal has been designated as "_$S($G(PSOUFLAG)="YES":"SERVICE CONNECTED",1:"NON-SERVICE CONNECTED.")
 .W:PSOSCP<50&($G(PSODRUG("DEA"))'["S")&($G(PSODRUG("DEA"))'["I")&($G(PSODRUG("DEA"))'["N") !,"Please use the 'Reset Copay Status/Cancel Charges' option to make corrections."
 .S PSOANSQ("SC")=$S($G(PSOUFLAG)="YES":1,1:0)
 I $G(PSOFLAG),$G(PSOCPZ("DFLG")) G EXIT
 S:PSOANSR=1 PSOCPAY=0 S:PSOANSR=2 $P(PSOCPAY,"^")=1
COPAY2 ;
 N PSOPFS S PSOPFS=$$SWSTAT^IBBAPI()
 I +PSOCPAY=1,($P(PSOCPAY,"^",2)=1)!($P(PSOCPAY,"^",2)=2) D
 .;set IB node in ^PSRX for copay if xactn type is 1 or 2
 .S PSONEW("NEWCOPAY")=$P($G(PSOCPAY),"^",2)_"^^"_$S(+$G(PSOPFS):"",1:$P($G(PSOCPAY),"^",2))
EXIT ;
 S PSOCPAY=PSOSAVE ;Restore val of PSOCPAY
 K PSOSAVE,PSOANSR,DIR,DUOUT,DIRUT,DTOUT,Y,X
 Q
RESET ;RESET COPAY STATUS
 K PSOSUMM,PSOPFS,PSOPFSA,PSOLFIL,PSOPFSG
 I '$D(PSOPAR) D ^PSOLSET G RESET
 W ! S DIC="^PSRX(",DIC(0)="AEQZ" D ^DIC K DIC G:Y<0 EXT S PSODA=+Y
 W !,?17,"PATIENT: ",$P($G(^DPT($P(^PSRX(PSODA,0),"^",2),0)),"^")
 D ICN^PSODPT($P(^PSRX(PSODA,0),"^",2))
 S PSORXN=$P(^PSRX(PSODA,0),"^"),PREA="R"
 S PCOPAY=$G(^PSRX(PSODA,"IB"))
 W !!,"Rx # ",PSORXN," is a ",$S(+PCOPAY:"Copay",1:"No Copay")," prescription"
 S PSOLFIL=$$LF^PSOPFSU1(PSODA) D PFSA^PSOPFSU1(PSODA,PSOLFIL,3)  ;PSOCPC def PSOPFSA=1 if OP SC/EI's change.
 D EXEMCHK^PSOCPC ; CHECK/CHANGE EXEMPTION FLAGS
 S PSOIBQ=$G(^PSRX(PSODA,"IBQ"))
 I '$G(^PSRX(PSODA,"IB")),PSOIBQ'["1" D  G ASKCAN
 . K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Do you want to reset the status to COPAY" D ^DIR K DIR
 . I Y'=1 Q
 . S DIC="^IBE(350.3,",DIC("S")="I $P(^(0),U,3)'=2",DIC(0)="AEQMZ",DIC("A")="Select Reason for Reset : " D ^DIC K DIC I Y'<0 S PSORSN=+Y
 . S PREA="R",PSOOLD="No Copay",PSONW="Copay",PSOCOMM="" D ACTLOG^PSOCPA
 . S PSI=0,PSOCOMM="Copay status of this Rx has been reset to COPAY." D SETSUMM^PSOCPC
 . S $P(^PSRX(PSODA,"IB"),"^")=1 ;Reset flag to COPAY
 ;
 I $G(^PSRX(PSODA,"IB")) D  G ASKCAN
 . K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Do you want to reset the status to NO COPAYMENT" D ^DIR K DIR
 . I Y'=1 Q
 . S DIC="^IBE(350.3,",DIC("S")="I $P(^(0),U,3)'=2",DIC(0)="AEQMZ",DIC("A")="Select Reason for Reset : " D ^DIC K DIC I Y'<0 S PSORSN=+Y
 . S PREA="R",PSOOLD="Copay",PSONW="No Copay",PSOCOMM="" D ACTLOG^PSOCPA
 . S PSI=0,PSOCOMM="Copay status of this Rx has been reset to NO COPAY." D SETSUMM^PSOCPC
 . S $P(^PSRX(PSODA,"IB"),"^")="" ;Reset flag to NO COPAY
ASKCAN D ASKCAN^PSOCPD
 I '$D(PSOSUMM) S PSI=0,PSOCOMM="No action taken" D SETSUMM^PSOCPC
 D PRTSUMM
 I $P($G(PSOPFS),"^",3)>0&(+$G(PSOPFSA)) D CHRG^PSOPFSU1(PSODA,PSOLFIL,"CG",PSOPFS)
RESETE K PSODA,PSORXN,PSORSN,PSOREF,X,Y,PCOPAY,PREA,PSOCOMM,PSI
 G RESET
EXT K PSODA,PSORXN,PSORSN,PSOREF,X,Y,PCOPAY,PREA,PSOCOPAY
 Q
BILLED ;Collect IB nums,cancel chrgs,reset flag.
 W !!,"**********Charges are on file for this Rx.**********"
 Q
BILL2 ;
 N PSOPREV ; VAR FOR PREV CANCELLED
 S PSOPREV=0
 S DIC="^IBE(350.3,",DIC("S")="I $P(^(0),U,3)'=2",DIC(0)="AEQMZ",DIC("A")="Select Reason for Reset or Charge Cancellation : " D ^DIC K DIC G ENDMSG:Y<0 S PSORSN=+Y
 S X=PSOPAR7_"^"_+$P(^PSRX(PSODA,0),"^",2)_"^^"_DUZ
 S SAVX=X
 I $D(PSOCAN) D:'$G(PSOPFS)  I +$G(PSOPFS)!($G(PSOPFSG)) D PFS^PSOPFSU1 G BILL2END:'$D(PSOCAN)
 . N III S III="" F  S III=$O(PSOCAN(III)) Q:III=""  I PSOCAN(III)["PFS" S PSOPFSG=1 Q  ;PFSS switch off, check for prev cots billing
 D POTBILL2
 I '$D(PSOCAN) G BILL2END
 I $G(CANTYPE) D PREVCAN I $O(X(""))="" Q
 I '$G(CANTYPE) S I="" F  S I=$O(PSOCAN(I)) Q:I=""  S X($P(PSOCAN(I),"^",1))=$P(PSOCAN(I),"^",2)_"^"_PSORSN
 D CANCEL^IBARX
 I $G(CANTYPE) D MSG
 I '$D(Y) Q
 I +Y=-1 Q
 I $D(Y(PSORXN)),+Y(PSORXN)'=-1 S $P(^PSRX(PSODA,"IB"),"^",2)=+Y(PSORXN) K Y(PSORXN) S PREA="C",PSOREF=0,PSOOLD="",PSONW="" D ACTLOG^PSOCPA I '$G(CANTYPE) D MSG
 F PSOREF=0:0 S PSOREF=$O(Y(PSOREF)) Q:PSOREF=""  I +Y(PSOREF)'=-1 S ^PSRX(PSODA,1,PSOREF,"IB")=+Y(PSOREF) S PREA="C",PSOOLD="",PSONW="" D ACTLOG^PSOCPA I '$G(CANTYPE) D MSG
BILL2END K X,Y,SAVX,PSOREF,PSOCAN
 Q
 ;
POTBILL2 ;see if any potential charges (entries from file 354.71 -- bills that exceeded cap prev) to be cancelled before cancelling regular charges
 N X,I
 S X=SAVX
 I $T(CANIBAM^IBARX)="" Q
 S I="" F  S I=$O(PSOCAN(I)) Q:I=""  I PSOCAN(I)["^CAP" S X($P(PSOCAN(I),"^",1))=$P(PSOCAN(I),"^",2)_"^"_PSORSN K PSOCAN(I)
 I $O(X(""))="" Q
 S PSOPREV=1
 D CANIBAM^IBARX
 I $D(X(PSORXN)) S $P(^PSRX(PSODA,"IB"),"^",4)="" S PREA="C",PSOREF=0,PSOCOMM="Potential charge cancelled",PSOOLD="",PSONW="" D ACTLOG^PSOCPA D POTMSG K X(PSORXN)
 F PSOREF=0:0 S PSOREF=$O(X(PSOREF)) Q:PSOREF=""  Q:PSOREF>11  S $P(^PSRX(PSODA,1,PSOREF,"IB"),"^",2)="" S PREA="C",PSOCOMM="Potential charge cancelled",PSOOLD="",PSONW="" D ACTLOG^PSOCPA D POTMSG
 K PSOREF,PREA,PSOCOMM
 Q
REFILL S PSOREF=0
 F  S PSOREF=$O(^PSRX(PSODA,1,PSOREF)) Q:PSOREF'?1N.N  D
 . I $D(^PSRX(PSODA,1,PSOREF,"PFS")) S:$P($G(^PSRX(PSODA,1,PSOREF,"PFS")),"^",2) X(PSOREF)="^"_$G(PSORSN) Q
 . I $D(^PSRX(PSODA,1,PSOREF,"IB")),+^("IB")>0 S X(PSOREF)=+^PSRX(PSODA,1,PSOREF,"IB")_"^"_$G(PSORSN)
 S PSOREF=0 F  S PSOREF=$O(^PSRX(PSODA,1,PSOREF)) Q:PSOREF'?1N.N  I '$D(X(PSOREF)),+$P($G(^PSRX(PSODA,1,PSOREF,"IB")),"^",2) S XX(PSOREF)=+$P(^PSRX(PSODA,1,PSOREF,"IB"),"^",2)_"^"_$G(PSORSN) ; IF ONLY ENTRY FROM 354.71 SAVE IT
 Q
SETCP ;IF NOT COPAY MAKE ELIG CALL/SET FLAG FOR FUTURE
 W ! S X=PSOPAR7_"^"_+$P(^PSRX(PSODA,0),"^",2)
 D XTYPE^IBARX
 I +Y=-1 W !!,"Error in processing Copay eligibility, no action taken." Q
 S (ACTYP,BL)="",(PSOBILL,PSOCPAY)=0
CP ;
 S ACTYP=$O(Y(ACTYP)) G:'ACTYP CP1
 F I=0:0 S BL=$O(Y(ACTYP,BL)) Q:BL=""  I BL>0 S PSOBILL=BL,PSOCPAY=ACTYP
 G CP
CP1 K ACTYP,BL,I
 I (PSOBILL'>0)!(PSOCPAY=0) G INELIG
 S $P(^PSRX(PSODA,"IB"),"^")=PSOCPAY
 W !,"COPAY status on this Rx has been reset.",!,"*** Future refills will be classified as COPAY."
 S PREA="R",PSOOLD="No Copay",PSONW="Copay"
 D ACTLOG^PSOCPA
 Q
INELIG W !,"This Rx does not meet patient eligibility requirement for Copay.",!,"****** Status unchanged *******"
 S Y=-1
 Q
ENDMSG K X W !,"Unable to process CHARGE REMOVAL without REASON for Reset."
 R !,"ENTER a REASON now?  (Y/N) ",X:DTIME Q:'$T
 I ($E(X)["?")!("YyNn^"'[$E(X)) W !,"Enter YES to select REASON and RESET STATUS." G ENDMSG
 I "Yy"[$E(X) G BILL2
 Q
MSG ;
 S PSI=0
 I $G(CANTYPE) S PSOCOMM="Rx # "_PSORXN_" - All copay charges cancelled" D SETSUMM^PSOCPC K PSOCOMM Q
 S PSOCOMM="Rx # "_PSORXN_" - "_$S(PSOREF=0:"Original fill",1:"Refill "_PSOREF)_" copay charge cancelled"
 D SETSUMM^PSOCPC
 K PSOCOMM
 Q
POTMSG ;
 S PSI=0
 I $G(CANTYPE) Q  ; (MESSAGE WILL GET SET LATER)
 S PSOCOMM="Rx # "_PSORXN_" - "_$S(PSOREF=0:"Original fill",1:"Refill "_PSOREF)_" potential copay charge cancelled"
 D SETSUMM^PSOCPC
 K PSOCOMM
 Q
MSGNOCAN ;
 S PSI=0
 S PSOCOMM="Rx # "_PSORXN_" - All copay charges have already been cancelled." D SETSUMM^PSOCPC K PSOCOMM
 Q
 ;
PRTSUMM ; prt sum of actions in reset/cancel
 I '$D(PSOSUMM) Q
 W !
 S PSI=""
 F  S PSI=$O(PSOSUMM(PSI)) Q:PSI=""  W !,PSOSUMM(PSI)
 K PSOSUMM
 Q
PREVCAN ; PREVIEW CANCELS IF "ALL" IS SELECTED
 N I,PSOBILL
 S I="" F  S I=$O(PSOCAN(I)) Q:I=""  D  I PSOBILL S X($P(PSOCAN(I),"^",1))=$P(PSOCAN(I),"^",2)_"^"_PSORSN
 . S PSOBILL=1 I $T(STATUS^IBARX)'="" I PSOCAN(I)'["CAP" S PSOBILL=$$STATUS^IBARX($P(PSOCAN(I),"^",2)) S:PSOBILL=2 PSOBILL=0 ; PREVIOUSLY CANCELLED
 I $O(X(""))="" D
 . I PSOPREV D MSG Q
 . D MSGNOCAN
 Q
 ;
