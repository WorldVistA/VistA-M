PSJEXP0 ;BIR/CML3,KKA-PRINTS MEDICATION EXPIRATION NOTICES ;13 FEB 96 / 10:04 AM
 ;;5.0; INPATIENT MEDICATIONS ;**50,58**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ;
 D NOW^%DTC S PSGDT=%,PSGOD=$$ENDTC^PSGMI(PSGDT) U IO
 I '$D(^TMP("PSG",$J)) W:IO'=(IO(0)!(IOST'["C-"))&($Y) @IOF W !!," AS OF ",PSGOD,!,"NO EXPIRED ORDERS FROM ",PSGEXPS," THROUGH ",PSGEXPF,!,"FOR ",$S(PSGSS="P":"PATIENT",PSGSS="W":"WARD",1:"WARD GROUP"),": ",PSJMSG,"." G DONE
 S PSGPDT=PSGOD,(BLF,LINE,PSSN,Q,TM,WDN,RB,PN)="",PG=0,$P(LINE,"-",81)="" K PSJDLW
 F  S TM=$O(^TMP("PSG",$J,TM)) Q:TM=""!$G(PSJDLW)  F  S WDN=$O(^TMP("PSG",$J,TM,WDN)) Q:WDN=""!$G(PSJDLW)  F  S RB=$O(^TMP("PSG",$J,TM,WDN,RB)) Q:RB=""!$G(PSJDLW)  D STRT1
 S Q=1 D:'$G(PSJDLW) NP
 ;
DONE ;
 W:(IO'=IO(0)!(IOST'["C-"))&($Y) @IOF K AD,BLF,DX,LINE,OPN,PSJORB,OSSN,OTM,OWDN,PAGE,PDOB,PG,PN,PRB,PSD,PSGPDT,PSSN,PST,PTM,PWDN,RCT,Q1,RB,TD,WDRG
 Q
 ;
STRT1 ;
 F  S PN=$O(^TMP("PSG",$J,TM,WDN,RB,PN)) Q:PN=""!$G(PSJDLW)  S ND=^(PN) D INFO F SD=0:0 S SD=$O(^TMP("PSG",$J,TM,WDN,RB,PN,SD)) Q:'SD!$G(PSJDLW)  D PRT
 Q
 ;
PRT ;
 S PSD=$$ENDTC^PSGMI(SD)
 F PST="C","O","OC","P","R" S DRG="" F  S DRG=$O(^TMP("PSG",$J,TM,WDN,RB,PN,SD,PST,DRG)) Q:DRG=""!$G(PSJDLW)  S ND=^(DRG),PSJJORD=$P(DRG,"^",2) D:$Y+6>IOSL NP I '$G(PSJDLW) D:PSJJORD'["V" WREC I PSJJORD["V" S PSJJORD=$P(PSJJORD,"V") D WRECIV
 Q
 ;
INFO ;
 S PSGP=$P(PN,"^",2),PTM=$P(ND,"^"),PWDN=$P(ND,"^",2),PRB=$P(ND,"^",3),PPN=$P(ND,"^",4) S:PPN=PSGP PPN=PPN_";DPT(" F X="PTM","PWDN","PRB" I @X="zz" S @X="*NF*"
 S PSEX=$P(ND,"^",5),PDOB=$P(ND,"^",6),PSSN=$P(ND,"^",7),DX=$P(ND,"^",8),WT=$P(ND,"^",9),AD=$P(ND,"^",10),TD=$P(ND,"^",11),PAGE=$S($P(PDOB,";",2):$P(PDOB,";",2),1:"?"),PDOB=$P(PDOB,";") S:PSEX="" PSEX="*NF*"
 F X="PDOB","AD","TD" S @X=$E(@X,1,8)
 ;
NP ; last line and heading for next page
 G:'BLF HEADER F Q1=$Y:1:(IOSL-4) W !
 W !?5,OPN,?37,OSSN,?51,OWDN,?68,PSJORB Q:Q
 ;
HEADER ;
 I IOST["C-" K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S PSJDLW=1 Q
 S PG=PG+1 W:$Y @IOF W !,"   AS OF: ",PSGPDT,?73-$L(PG),"Page: ",PG,!!!,?20,"THE FOLLOWING MEDICATIONS WILL EXPIRE",!?17,"FROM ",PSGEXPS," THROUGH ",PSGEXPF,!?10,"TO CONTINUE MEDICATIONS, PLEASE REORDER ON VA FORM 10-1158.",!!
 S:$D(PSJSEL("TM")) TEAM=TM D ENTRY^PSJHEAD(PSGP,"",PG,"","")
 ;W !!?1,PPN,?36,"Ward: "_PWDN
 ;W !?7,"PID: "_PSSN,?30,"Weight(kg): "_WT,?61,"Admitted: ",AD
 ;W !?7,"DOB: "_PDOB_"  ("_PAGE_")",?37,"Sex: "_PSEX W:TD ?53,"Last transferred: ",TD
 ;W !?8,"Dx: "_$S(DX]"":DX,1:"*NF*"),?$S($L(PRB)<9:61,1:69-$L(PRB)),"Room-Bed: ",PRB,!?1,"Reactions:" D ENRCT^PSGAPP
 W !!?1,"Medication",?42,"ST",?45,"Start",?52,"Stop",?67,"Status/Info",!?3,"Dosage",?67,"Provider",!,LINE S BLF=1,OPN=PPN,PSJORB=PRB,OSSN=PSSN,OTM=PTM,OWDN=$E(PWDN,1,16) Q
 ;
WREC ; write Unit Dose record here
 N X,PSG
 D DRGDISP^PSJLMUT1(+PSGP,+PSJJORD_"U",39,39,.PSG,0)
 S PSGOD=$$ENDTC^PSGMI($P(ND,"^",2)) W !!?1,PSG(1),?42,PST,?45,$E(PSGOD,1,5)_" "_PSD,?67,$P(ND,"^",4) I $P(ND,"^",8) W ?70,$E("HSM",$P(ND,"^",8),3)
 ;W !?1,PSG(2),?79-$L($P(ND,"^",5)),$P(ND,"^",5)
 N MARX D TXT^PSGMUTL($P(ND,"^",5),24)
 N DLINS,LN S DLINS=$O(PSG(""),-1)
 F LN=2:1:$S(MARX-1>DLINS:MARX,1:DLINS+1)  D
 .W !,$G(PSG(LN)),?55,$G(MARX(LN-1))
 ;N X F X=2:0 S X=$O(PSG(X)) Q:'X  W !?1,PSG(X)
 ;S WCNT=1,SI=$G(^PS(55,PSGP,5,PSJJORD,6)) I SI]"" W ! F  S WRD=$P(SI," ",WCNT) Q:$L(WRD)=0  S WCNT=WCNT+1 W:$X+$L(WRD)>80 ! W " ",WRD
 S SI=$P($G(^PS(55,PSGP,5,PSJJORD,6)),"^") I SI]"" W !?5,"Special Instructions: " F X=1:1:$L(SI," ") S Y=$P(SI," ",X) W:$X+$L(Y)>78 !?28 W Y," "
 Q
WRECIV ; write IV record here
 N DRG,P,ON55,PSG
 S (FSTFLG,SNDFLG,LNCNT)=0
 S PSGOD=$$ENDTC^PSGMI($P(ND,"^",2))
 S DFN=PSGP,ON=+PSJJORD D GT55^PSIVORFB W !
 N X F X=0:0 S X=$O(DRG("AD",X)) Q:'X  D NAME^PSIVUTL(DRG("AD",X),39,.PSG,1) F JJ=0:0 S JJ=$O(PSG(JJ)) Q:'JJ  W !?1,PSG(JJ) S LNCNT=LNCNT+1 D:LNCNT=1 FST D:LNCNT=2 SND
 N X,PSG,JJ F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  D NAME^PSIVUTL(DRG("SOL",X),33,.PSG,0) F JJ=0:0 S JJ=$O(PSG(JJ)) Q:'JJ  W ! W:JJ=1 ?3,"in" W ?6,PSG(JJ) S LNCNT=LNCNT+1 D:LNCNT=1 FST D:LNCNT=2 SND
 W !?1,$P(P("MR"),U,2)_" "_P(9)_" "_P(8) D:'FSTFLG FST I FSTFLG&('SNDFLG) W ! D SND
 S OPI=$P(P("OPI"),"^") I OPI]"" W !?5,"Other Print Info: " F X=1:1:$L(OPI," ") S Y=$P(OPI," ",X) W:$X+$L(Y)>78 !?28 W Y," "
 Q
FST S FSTFLG=1 W ?42,PST,?45,$E(PSGOD,1,5)_" "_PSD,?67,P(17)
 Q
SND S SNDFLG=1 W ?79-$L($P(P(6),U,2)),$P(P(6),U,2) Q
LIST ;**list IV orders, UD orders, or ALL
 K DTOUT,DUOUT,DIR W ! S DIR(0)="SOAM^IV:IV;UD:Unit Dose;A:ALL",DIR("A")="List IV orders, Unit Dose orders, or All orders: ",DIR("B")="ALL",DIR("?")="Please enter a code."
 S DIR("?",1)="Enter ""IV"" to see only IV orders, ""UD"" to see only Unit",DIR("?",2)="Dose orders, or ""A"" to see both IV and Unit Dose orders." D ^DIR K DIR S:$D(DTOUT)!($D(DUOUT)) OUT=1 S CHOICE=Y
 Q
