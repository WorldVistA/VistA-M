PSJPR0 ;BIR/CML3,PR-INPATIENT MEDS PROFILE - GATHER ORDERS ;2/3/92  15:43 [ 12/16/97  2:07 PM ]
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 D NOW^%DTC S PSGDT=%,(X1,DT)=$P(%,"."),X2=-2 D C^%DTC S PSGODT=X_(PSGDT#1),PSGID=PSGDT,HDT=$$ENDTC^PSGMI(PSGDT) K ^UTILITY("PSG",$J)
 W !!,"...a few moments, please..." D ENUNM^PSGOU
 S C="A",ST="O" F SD=PSGPAD:0 S SD=$O(^PS(55,PSGP,5,"AU","O",SD)) Q:'SD  F O=0:0 S O=$O(^PS(55,PSGP,5,"AU","O",SD,O)) Q:'O  D OCHK
 F ST="C","OC","P","R" F SD=PSGPAD:0 S SD=$O(^PS(55,PSGP,5,"AU",ST,SD)) Q:'SD  F O=0:0 S O=$O(^PS(55,PSGP,5,"AU",ST,SD,O)) Q:'O  D ECHK
 F ON=0:0 S ON=$O(^PS(55,DFN,"IV",ON)) Q:'ON  I $D(^(ON,0)) D CHK^PSIVACT K PS S ST=$P(^PS(55,DFN,"IV",ON,0),"^",17) S IV=$S(ST="D":1,1:$P(^(0),"^",3)'>PSGDT),C=$E("O",IV)_"IV" D:'IV!(PSGOL="L"&IV) IV
 F SD="I","N" F O=0:0 S O=$O(^PS(53.1,"AS",SD,PSGP,O)) Q:'O  S ST=$S('$D(^PS(53.1,O,0)):"z",$P(^(0),"^",7)]"":$P(^(0),"^",7),1:"z"),DRG=$S($D(^(1,1,0)):+^(0),1:""),C="N"_$S(SD="N":"X",1:"Y") D SET
 Q
 ;
OCHK ;
 S C="A" G:SD>PSGDT!$S('PSJSYSU:0,'$D(^PS(55,PSGP,5,O,0)):0,"D"[$E($P(^(0),"^",9)):0,'$D(^(4)):1,'$P(^(4),"^",+PSJSYSU):1,SD<PSGODT:0,1:$P(^(4),"^",16)) DS Q:PSGOL["S"  S C="O" G DS
 ;
ECHK ;
 S C="A" G:SD>PSGDT!$S(SD<PSGODT:0,'$D(^PS(55,PSGP,5,O,0)):0,$P(^(0),"^",9)'="E":0,'$D(^(4)):0,1:$P(^(4),"^",16)) DS Q:PSGOL="S"  S C="O" G DS
 ;
IV ;
 S ^UTILITY("PSG",$J,C,ST,$S('$D(^PS(52.6,+$O(^PS(DFN,"IV",ON,"AD",0)),0)):"z",$P(^(0),"^")]"":$P(^(0),"^"),1:"z"),ON)="" Q
 ;
DS S DRG=$S($D(^PS(55,PSGP,5,O,1,1,0)):+^(0),1:0)
SET S ^UTILITY("PSG",$J,C,ST,$S('$D(^PSDRUG(DRG,0)):"z",$P(^(0),"^")]"":$P(^(0),"^"),1:"z"),O)="" Q
 ;
