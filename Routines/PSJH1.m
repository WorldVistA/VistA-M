PSJH1 ;BIR/CML3,PR-GET UNIT DOSE/IV ORDERS FOR INPATIENT ; 11/15/07 4:21pm
 ;;5.0; INPATIENT MEDICATIONS ;**35,47,58,85,174,198**;16 DEC 97;Build 7
 ;
 ;Reference to ^PS(50.7 is supported by DBIA 2180
 ;Reference to ^PS(55 is supported by DBIA 2191
 ;Reference to ^%DTC is supported by DBIA 10000
 ;Reference to ^%ZOSV is supported by DBIA 10097
 ;Reference to ^XLFDT is supported by DBIA 10103
 ;
ECHK ;
 S C="A",DRG=$P($G(^PS(55,PSGP,5,+O,.2)),"^") S:PSJOS START=-$P($G(^(2)),"^",2)
 S O=O_"U"
 G:SD>PSGDT SET S ND=$G(^PS(55,PSGP,5,+O,0)) G:$S($P(ND,"^",9)="":1,1:"DE"'[$P(ND,"^",9)) SET S ND4=$G(^(4)) I ST'="O",SD'<PSGODT,$S($P(ND,"^",9)="E":$P(ND4,"^",16),1:0)
 E  I ST="O",$P(ND,"^",9)="E",$S('$P(ND4,"^",UDU):1,SD<PSGODT:0,1:$P(ND4,"^",16))
 E  Q:PSJOL="S"  S C="O"
 ;
SET ;
 S DN=$S(DRG="":"NOT FOUND",'$D(^PS(50.7,DRG,0)):"NOT FOUND ("_DRG_")",$P(^(0),"^")]"":$P(^(0),"^"),1:DRG_";PS(50.7,"),NF=$P(DN,"^",9),SUB=$S(PSJOS:START,1:$E(DN,1,50))
 S ^TMP("PSJ",$J,C,$S(PSJOS:SUB,1:ST),$S(PSJOS:ST,1:SUB),O)=DN_"^"_NF,PSJOCNT=PSJOCNT+1 Q
 ;
IVSET ; Set IV data in ^TMP("PSJ",$J,.
 N DRG,DRGT,ON55,ORTX,P,STAT,TYP,X,Y,ND
 ;GMZ;PSJ*5*198;Change date search criteria for IV orders to be consistent with the way unit dose orders work
 I ON["V" S ON55=ON,Y=$G(^PS(55,DFN,"IV",+ON,0)) Q:$D(PSJHDATE)&($P(Y,"^",3)<PSJHDATE)  F X=2,3,4,9,17 S P(X)=$P(Y,U,X)
 I ON'["V" S ND=$G(^PS(53.1,+ON,0)) I 'ND K ^PS(53.1,"AS",SD,PSGP,+ON) Q
 I ON'["V",ND S P(17)=$P($G(^PS(53.1,+ON,0)),U,9),Y=$G(^PS(53.1,+ON,2)),P(9)=$P(Y,U),P(2)=$P(Y,U,2),P(3)=$P(Y,U,4),P(4)=$P($G(^PS(53.1,+ON,8)),U)
 G:PSJOS IVSET1 I P(4)="H" S ORTX="* TPN *" G IVSET1
 I P(4)="A" D @$S(ON["V":"GTDRG^PSIVORFB",1:"GTDRG^PSIVORFA"),GTOT^PSIVUTL(P(4)) I $E(P("OT"))="F" S DRGT=$O(DRG(0)),Y=$O(DRG(DRGT,0)),ORTX=$P(DRG(DRGT,Y),U,2) G IVSET1
 S ORTX=$$ENPDN^PSGMI(+$S(ON["V":$G(^PS(55,DFN,"IV",+ON,6)),1:$G(^PS(53.1,+ON,.1))))
 ;
IVSET1 ;
 S TYP=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3)) I TYP'="O" S TYP="C"
 S STAT=$S("ED"[P(17):"O",P(17)="P":"NZ",1:"A"),^TMP("PSJ",$J,STAT,$S(PSJOS:-P(2),1:TYP),$S(PSJOS:TYP,1:ORTX),ON)="",PSJOCNT=PSJOCNT+1
 Q
 ;
ENU ; update status field to reflect expired orders, if necessary
 W !!,"...a few moments, I have some updating to do..."
ENUNM ;
 F Q=+PSJPAD:0 S Q=$O(^PS(55,PSGP,5,"AUS",Q)) Q:'Q!(Q>PSGDT)  S UPD=Q F QQ=0:0 S QQ=$O(^PS(55,PSGP,5,"AUS",Q,QQ)) Q:'QQ  I $D(^PS(55,PSGP,5,QQ,0)),"DEH"'[$E($P(^(0),"^",9)) S $P(^(0),"^",9)="E"
 K UPD Q
 ;
EN ; enter here
 I PSJOL="L",$D(XRTL) D T0^%ZOSV
 K ^TMP("PSJ",$J) D NOW^%DTC S PSGDT=+$E(%,1,12),DT=$$DT^XLFDT,PSJOS=$P(PSJSYSP0,"^",11),UDU=$S($P(PSJSYSU,";",3)>1:3,1:1) S:'$D(PSJHDATE) PSJHDATE=0
 S PSJOCNT=0 F PSJORD=0:0 S PSJORD=$O(^PS(55,DFN,"IV",PSJORD)) Q:'PSJORD  D
 .S X=$G(^PS(55,DFN,"IV",+PSJORD,0))
 .S Y=$P(X,U,17)
 .S ON=+PSJORD_"V" D IVSET
 D NOW^%DTC S PSJIVOF=PSJOCNT,PSGDT=%,X1=$P(%,"."),X2=-2 D C^%DTC S PSGODT=X_(PSGDT#1),HDT=$$ENDTC^PSGMI(PSGDT)
 F ST="C","O","OC","P","R" F SD=+PSJHDATE:0 S SD=$O(^PS(55,PSGP,5,"AU",ST,SD)) Q:'SD  F O=0:0 S O=$O(^PS(55,PSGP,5,"AU",ST,SD,O)) Q:'O  D ECHK
 Q:$D(PSGONNV)
 F SD="I","N" S O=0 F  S O=$O(^PS(53.1,"AS",SD,PSGP,O)) Q:'O  D NVSET
 ;I $S(+PSJSYSU=3:1,1:$D(PSGLPF)) S SD="P",O=0 F  S O=$O(^PS(53.1,"AS",SD,PSGP,O)) Q:'O  S ON=O_"P" D @$S($P($G(^PS(53.1,O,0)),U,4)="F":"IVSET",1:"NVSET")
 S SD="P",O=0 F  S O=$O(^PS(53.1,"AS",SD,PSGP,O)) Q:'O  S ON=O_"P" D @$S($P($G(^PS(53.1,O,0)),U,4)="F":"IVSET",1:"NVSET")
 I PSJOL="L",$D(XRT0) S XRTN="PSJO1" D T1^%ZOSV
 Q
 ;
NVSET ; Set up orders from 53.1.
 N ND,OSAVE,PORD S ND=$G(^PS(53.1,O,0)) I 'ND D  Q
 .K ^PS(53.1,"AS",SD,PSGP,O)
 S ST=$P($G(^PS(53.1,O,0)),U,7),START=-$P($G(^(2)),U,2),DRG=$P($G(^(.2)),U),C="N"_$TR(SD,"NIP","XYZ") S:ST="" ST="z"
 S PORD=$P($G(^PS(53.1,O,.2)),U,8),OSAVE=O,O=$S(PORD:PORD,1:O_"P") D SET S O=+OSAVE
 Q
 ;
KILL ;
 K P,STAT,TYP,ORTX,N,JJ
 Q
