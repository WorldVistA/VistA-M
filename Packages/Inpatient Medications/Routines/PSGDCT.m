PSGDCT ;BIR/CML3-DRUG COST TOTALS ; 24 Mar 98 / 10:10 AM
 ;;5.0; INPATIENT MEDICATIONS ;**9,50,91**;16 DEC 97
 ; Reference to ^PS(50.606 supported by DBIA# 2174.
 ; Reference to ^PS(50.7 supported by DBIA# 2180.
 ; Reference to ^PS(50.605 is supported by DBIA# 2138.
 ; Reference to ^PSDRUG is supported by DBIA# 2192. 
 ;
 D ENCV^PSGSETU Q:$D(XQUIT)
 S HLP="DRUG COST" D ENDTS^PSGAMS G:'SD!'FD DONE K PSGERR D QUES I $D(PSGERR) W " not selected, DRUG report terminated...",$C(7) G DONE
 S RTN="DCT" D EN3^PSGTI I 'POP,'$D(IO("Q")) D ENQ D:IO'=IO(0)!($E(IOST)'="C") ^%ZISC
 ;
DONE ;
 D DONE1^PSGDCTP
 Q
 ;
ENQ ;
 D ^PSGDCT1,^PSGDCTP
 Q
 ;
QUES ;
 K DIR,PSGDCLW S DIR(0)="Y",DIR("A")="Select by Ward? (Y/N):",DIR("B")="NO",DIR("??")="^D WDHLP^PSGDCT1" D ^DIR K DIR I $D(DIRUT) S PSGERR=1 W !!,"...Ward" Q
 I Y D  G:'$D(PSGDCLW) QUES
 .K DIR S DIR(0)="FAO",DIR("A")="Select WARD: ",DIR("B")="ALL",DIR("?")="^D DIC^PSGDCT(""^DIC(42,"",""PSGDCLW"",""WARD"")" W !! D ^DIR K DIR I Y="ALL" S PSGDCLW="ALL" Q
 .D DIC("^DIC(42,","PSGDCLW","WARD") K:'$O(PSGDCLW(0)) PSGDCLW
 ;
 ; ask 'sort by', 'cost limit', and 'dispensing amount limit' questions
 K DIR S DIR(0)="SAO^1:DISPENSE DRUG;2:ORDERABLE ITEM;3:VA CLASS",DIR("A")="Select drugs by DISPENSE DRUG, ORDERABLE ITEM, or VA CLASS: ",DIR("?")="^D ENQH^PSGDCT1" W ! D ^DIR  K DIR I 'Y S PSGERR=1 W !!,"...Select category" Q
 S PSGDCT=Y,PSGDCT(1)=$S(PSGDCT=1:"DISPENSED DRUG",PSGDCT=2:"ORDERABLE ITEM",1:"VA CLASS"),X=PSGDCT(1) D LC S PSGDCT(2)=X K X,Y
 ;
SH ;Select entries to be included..
 K DIR S DIR(0)="FAO",DIR("A")="Select "_PSGDCT(2)_": ",DIR("B")="ALL",PSG=$S(PSGDCT=1:"^PSDRUG(",PSGDCT=2:"^PS(50.7,",1:"^PS(50.605,"),DIR("?")="^D DIC^PSGDCT("""_PSG_""",""PSGDCLW"","""_PSGDCT(1)_""")"
 W !! D ^DIR K DIR I $D(DIRUT) W !!,"...",PSGDCT(1)," not selected" S PSGERR=1 Q
 I Y="ALL" S PSGDCTD=Y
 E  D DIC(PSG,"PSGDCTD",PSGDCT(1)) G:$O(PSGDCTD(0))="" SH
 I PSGDCT>1 D DISP Q:$D(PSGERR)
 ;
SB ;
 I $G(PSGDCTD)'="ALL" D  I X<2 S PSGDCTS="N",(PSGDCTA,PSGDCTL)="" Q
 .S Y="" F X=0:1 S Y=$O(PSGDCTD(Y)) Q:Y=""
 K DIR S DIR(0)="SOA^1:"_PSGDCT(1)_";2:COST;3:AMOUNT DISPENSED",DIR("A")="Sort drugs by "_PSGDCT(1)_", COST, or AMOUNT DISPENSED: ",DIR("??")="^D SBCHK^PSGDCT1" D ^DIR K DIR I $D(DIRUT) W !!,"...Sort order" S PSGERR=1 Q
 S PSGDCTS=$S(Y=3:"A",Y=2:"C",1:"N")
 ;
CL F  R !!,"Print all drugs costing at least? ",PSGDCTL:DTIME W:'$T $C(7) S:'$T PSGDCTL="^" Q:"^"[PSGDCTL!(PSGDCTL?.1"-".N.1".".2N)  D:PSGDCTL?1."?" CLM^PSGDCT1 W:PSGDCTL'?1."?" $C(7),$C(7),"  ??"
 W:PSGDCTL="" "  (ALL)" I PSGDCTL="^" S PSGERR=1 W !!,"...Cost limit" S PSGERR=1 Q
 ;
AL F  R !!,"Print all drugs with a dispensing amount of at least? ",PSGDCTA:DTIME W:'$T $C(7) S:'$T PSGDCTA="^" Q:"^"[PSGDCTA!(PSGDCTA?.1"-"1.N)  D:PSGDCTA?1."?" ALM^PSGDCT1 W:PSGDCTA'?1."?" $C(7),$C(7),"  ??"
 W:PSGDCTA="" "  (ALL)" I PSGDCTA="^" W !!,"...Dispensing amount" S PSGERR=1 Q
 Q
 ;
DISP ;view dispensed drugs
 F  W !!,"Display the dispense drugs" S %=1 D YN^DICN Q:%  W !!,"Answer 'YES' and I will display the dispensed drugs associated with the ",!,PSGDCT(1)," or answer 'NO' and only the totals will be displayed.",!
 I %<0 S PSGERR=1 W !!,"...Dispense drug display" Q
 K PSGDISP S:%=1 PSGDISP=1
 Q
 ;
DIC(PSG,PSGDC,PSGT) ;LooK up a ward or report types.
 K DIC,@PSGDC S @PSGDC=1,DIC=PSG,DIC(0)="QEMZ"
 ;if Orderable Item, display the IV identifier
 I DIC="^PS(50.7," D
 .;/IV flag and Identifier is no longer used after POE changes
 .;/S PSJIDD=$P($G(^PS(59.7,1,31)),"^",2)
 .;/S DIC("W")="W ""  ""_$P(^PS(50.606,$P(^PS(50.7,+Y,0),""^"",2),0),""^"")_$S($P(^PS(50.7,+Y,0),""^"",3):"" ""_$G(PSJIDD),1:"""")_"
 .S DIC("W")="W ""  ""_$P(^PS(50.606,$P(^PS(50.7,+Y,0),""^"",2),0),""^"")_"
 .S DIC("W")=DIC("W")_""" ""_$S($P(^PS(50.7,+Y,0),""^"",4):$E($P(^(0),""^"",4),4,5)_""-""_$E($P(^(0),""^"",4),6,7)_""-""_$E($P(^(0),""^"",4),2,3),1:"""")"
 ;/F  D ^DIC K PSJIDD Q:Y<0  S DIC(0)=DIC(0)_"A",DIC("A")="Select another "_PSGT_": " S X=PSGDC_"("""_$S($G(PSGDCT)=3:$P(Y(0),U),1:+Y)_""")",@X=Y(0,0)
 F  D ^DIC Q:Y<0  S DIC(0)=DIC(0)_"A",DIC("A")="Select another "_PSGT_": " S X=PSGDC_"("""_$S($G(PSGDCT)=3:$P(Y(0),U),1:+Y)_""")",@X=Y(0,0)
 Q
 ;
LC ;Convert data to lower case wording
 F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A,$E(X,%-1)'="V" S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)
 Q
