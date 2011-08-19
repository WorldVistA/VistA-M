PSGAP0 ;BIR/CML3-ACTION PROFILE ;20 May 98 / 12:36 PM
 ;;5.0; INPATIENT MEDICATIONS ;**8,58,111**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191
 ;
GOD ; gather order data
 S ND=$G(^PS(55,PSGP,5,PSJJORD,0)),ND2=$G(^(2)),SI=$P($G(^(6)),"^"),DRG=$G(^(.2)) ;WS=$S(DRG&PSGAPWD:$D(^PSI(58.1,"D",+DRG,PSGAPWD)),1:0),DRG=$G(^PS(50.7,+DRG,0))
 ;S NF=$P(DRG,"^",9)
 S X=$$NFWS^PSJUTL1(PSGP,PSJJORD_"U",PSGAPWD) S NF=$P(X,U),WS=$P(X,U,2),SM=$S('$P(X,U,3):0,$P(X,U,4):1,1:2)
 N X,PSG
 D DRGDISP^PSJLMUT1(PSGP,PSJJORD_"U",40,0,.PSG,1)
 S DRG=PSG(1),DRG=$S(DRG["NOT FOUND":"z",1:DRG)
 S ST=$P(ND,"^",9),ND=$P(ND,"^",7),SD=$P(ND2,"^",2),FD=$P(ND2,"^",4)
 I STP'=9999999\1,(SD>STP) Q
 F X="SD","FD" S @X=$E($$ENDTC^PSGMI(@X),1,5)
 ;
 S Y=SI S:Y]"" Y=$$ENSET^PSGSICHK(Y) S X=ND_U_$E(DRG,1,20),^TMP($J,$E(PSGAPWDN,1,20),TM,PN,X,+PSJJORD)=ST_U_SD_U_FD_U_WS_U_SM_U_NF S:Y]"" ^(PSJJORD,1)=Y
 Q
 ;
PAT ;
 ;;S RB=$G(^DPT(PSGP,.101)),TM="zz" S:RB]"" TM=$S('$D(PSGAPTM):"zz",1:$O(^PS(57.7,"AWRT",PSGAPWD,RB,0))) I PSGAPWDN="" S PSGAPWDN="* NF *"
 S RB=$G(^DPT(PSGP,.101)) S:RB]"" TM=$S('$D(PSGAPTM):"zz",1:$O(^PS(57.7,"AWRT",PSGAPWD,RB,0))) S:$G(TM)="" TM="zz" I PSGAPWDN="" S PSGAPWDN="* NF *"
 I $D(PSGAPTM) S ATM="",ATM=$O(PSGAPTM(ATM)) I ATM'="ALL" Q:'$D(PSGAPTM(+TM))
 S:TM'="zz" TM=^PS(57.7,PSGAPWD,1,TM,0)
 S PSJACNWP=1 D PSJAC2^PSJAC(1),NOW^%DTC S PSGDT=%,PND=PSGP(0),PN=$S($G(PSJSEL("RBP"))="R":RB,1:"")_"^"_$E($P(PND,"^"),1,20)_"^"_PSGP
 I '$G(STT) S STT=PSGDT,STP=9999999
 S:PSGMTYPE[1 PSGMTYPE="2,3,4,5,6"
 I PSGMTYPE[2 D
 . F STRT=STT:0 S STRT=$O(^PS(55,PSGP,5,"AUS",STRT)) Q:'STRT  F PSJJORD=0:0 S PSJJORD=$O(^PS(55,PSGP,5,"AUS",STRT,PSJJORD)) Q:'PSJJORD  D GOD
 . S XTYPE=2,PST="S" D ^PSGAPIV
 N XTYPE F XTYPE=3:1:6 I PSGMTYPE[XTYPE S PST=$S(XTYPE=3:"P",XTYPE=4:"A",XTYPE=5:"H",1:"C") D ^PSGAPIV
 I PSGMTYPE[3 S XTYPE=3,PST="S" D ^PSGAPIV ;* Find syringe type iv
 I $D(^TMP($J,$E(PSGAPWDN,1,20),TM,PN)) D
 . ;naked reference on line below refers to full global reference on line above
 . S ^(PN)=$P(PSJPSEX,"^",2)_"^"_$E($P(PSJPDOB,"^",2),1,10)_";"_PSJPAGE_"^"_VA("PID")_"^"_PSJPDX_"^"_$S(PSJPRB]"":PSJPRB,1:"*NF*")_"^"_$E($P(PSJPAD,"^",2),1,10)_"^"_$E($P(PSJPTD,"^",2),1,10)_"^"_+PSJPWT
 . S:($G(PSJSEL("WG"))="^OTHER") ^TMP("PSGAP0",$J,"OUTPT",PSGP)=""
 Q
 ;
GDT ;
 K %DT S %DT="EFTX",Y=-1,%DT(0)=$S(N["R":PSGDT,1:STT) F  W !!,"Enter ",N," date/time: " R X:DTIME W:'$T $C(7) S:'$T X="^" Q:"^"[X  D DTM:X?1."?",^%DT Q:Y>0
 I X'="^" S:N["R" STT=$S(Y'>0:PSGDT,Y#1:+$E(Y,1,12),1:Y+.0002)-.0001 S:N["O" STP=$S(Y'>0:9999999,Y#1:+$E(Y,1,12),1:Y+.24)
 K %DT Q
 ;
EN ; entry point
 I PSGSS'="P" D NOW^%DTC S PSGDT=%,DT=$$DT^XLFDT F N="START","STOP" D GDT I X="^" S PSJSTOP=1 Q
 I PSGSS'="P" Q:X="^"  S:'$P(STP,".",2) $P(STP,".",2)=24 S:'$P(STT,".",2) $P(STT,".",2)="0001"
 S PSJSTOP=$$MEDTYPE^PSJMDIR($G(PSGWD)) Q:PSJSTOP  S PSGMTYPE=Y
 K ZTSAVE S:PSGSS'="P" (ZTSAVE("STT"),ZTSAVE("STP"))="" F X="PSGP","PSGSS","PSGAPWD","PSGAPWG","PSGAPWDN","PSGAPWGN","PSGPAT(","PSGAPTM(","PSGMTYPE","PSGPTMP","PSJSEL(","PSJOS","PPAGE" S ZTSAVE(X)=""
 W !,"...this may take a few minutes...(you should QUEUE this report)..."
 S PSGTIR="ENQ^PSGAP0",ZTDESC="ACTION PROFILE" D ENDEV^PSGTI S:POP PSJSTOP=1 Q:POP!$D(IO("Q"))
 ;
ENQ ; queued entry point
 K ^TMP("PSGAP0",$J) N RB,ATM,TM,DRGI,DRGN,DRGT,ON,PST,PSIVUP,PSJORIFN,QST,SLS,XTYPE
 D @("P"_PSGSS),^PSGAPP D ^%ZISC K ^TMP("PSGAP0",$J)
 Q
 ;
PG ;
 I $G(PSJSEL("WG"))="^OTHER" D CLIN Q
 F PSGAPWD=0:0 S PSGAPWD=$O(^PS(57.5,"AC",PSGAPWG,PSGAPWD)) Q:'PSGAPWD  I $D(^DIC(42,PSGAPWD,0)),$P(^(0),"^")]"" S PSGAPWDN=$P(^(0),"^") D PW
 Q
 ;
CLIN ;
 F INDEX="AIVC","AUDC" S STOP=0 F  S STOP=$O(^PS(55,INDEX,STOP)) Q:'STOP  S CLIN=0 F  S CLIN=$O(^PS(55,INDEX,STOP,CLIN)) Q:'CLIN  D
 . S DFN=0 F  S DFN=$O(^PS(55,INDEX,STOP,CLIN,DFN)) Q:'DFN  I '$D(^TMP("PSGAP0",$J,"OUTPT",DFN)) D
 .. S PSGP=DFN,Q=STOP N STOP D PAT
 Q
 ;
PW ;
 F PSGP=0:0 S PSGP=$O(^DPT("CN",PSGAPWDN,PSGP)) Q:'PSGP  D
 .S Q=$O(^PS(55,PSGP,5,"AUS",STT)) I Q D PAT Q
 .S Q=$O(^PS(55,PSGP,"IV","AIS",STT)) I Q D PAT
 Q
 ;
PP ;
 F PSGP=0:0 S PSGP=$O(PSGPAT(PSGP)) Q:'PSGP  S PSGAPWDN=$P($G(^DPT(PSGP,.1)),"^") S:PSGAPWDN]"" PSGAPWD=+$O(^DIC(42,"B",PSGAPWDN,0)) D PAT
 Q
 ;
DTM ;
 S Y=%DT(0) D D^DIQ S T=$P(Y,"@",2),Y=$P(Y,",")
 W !!?2,"If a ",N," date is entered, an action profile will print for only those",!,"patients that have at least one active order with a ",$S(N["A":"STOP",1:"START")," DATE on or ",$S(N["A":"after",1:"before"),!,"the ",N," date entered."
 W !?2,"Entry is not required.  If neither date is entered, all patients with active",!,"orders will print (for the ward(s) chosen).  Enter an up-arrow (^) to exit."
 W !?2,"If you wish to enter a ",$S(N["R":"start",1:"stop")," date of ",Y,", you must enter a TIME of day",!,"of ",T," or greater.  Any date after ",Y," does not need time entered.",! S Y=-1 Q
