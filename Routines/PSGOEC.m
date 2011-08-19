PSGOEC ;BIR/CML3-CANCEL ORDERS ;02 Mar 99 / 9:29 AM
 ;;5.0; INPATIENT MEDICATIONS ;**23,58,110,175,201,134,181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PSSLOCK is supported by DBIA 2789.
 ; 
ENA ; all orders
 D ENCV^PSGSETU Q:$D(XQUIT)  S CF=$P(PSJSYSP0,U,5) N ND,ND1 S ND="$D(^PS(55,PSGP,5,PSGDA,4)),$P(^(4),U,12),$P(^(4),U,13)",ND1="$D(^PS(53.1,PSGDA,4)),$P(^(4),U,12),$P(^(4),U,13)"
 F  W !!,"Do you want to ",$S(CF:"discontinue",1:"mark for discontinuation")," all of this patient's orders" S %=1 D YN^DICN Q:%  D ENCAM^PSGOEM
 S PSGCF=0 Q:%<0  S PSGCF=1,T=$E("T",'PSJSYSU) G:%=1 ENCA F T=0:0 S T=$O(^PS(55,PSGP,5,"AUS",T)) Q:'T  F PSGDA=0:0 S PSGDA=$O(^PS(55,PSGP,5,"AUS",T,PSGDA)) Q:'PSGDA  I @ND Q
 E  F PSGDA=0:0 S PSGDA=$O(^PS(53.1,"AC",PSGP,PSGDA)) Q:'PSGDA  I @ND1 Q
 E  G DONE
 W !!,"SOME OR ALL OF THESE ORDERS HAVE" D ENUMK^PSGOEM Q:%'=1
 W !!,"...a few moments, please..." S PSGAL("C")=PSJSYSU*10+21400
 F T=PSGDT:0 S T=$O(^PS(55,PSGP,5,"AUS",T)) Q:'T  F PSGDA=0:0 S PSGDA=$O(^PS(55,PSGP,5,"AUS",T,PSGDA)) Q:'PSGDA  I @ND W "." D RS,^PSGAL5
 F PSGDA=0:0 S PSGDA=$O(^PS(53.1,"AC",PSGP,PSGDA)) Q:'PSGDA  I @ND1 W "." D RS
 W " . . . DONE!" G DONE
ENCA ;
 D NOW^%DTC S (Q1,PSGDT)=+$E(%,1,12) F  S Q1=$O(^PS(55,PSGP,5,"AUS",Q1)) Q:'Q1  F Q2=0:0 S Q2=$O(^PS(55,PSGP,5,"AUS",Q1,Q2)) Q:'Q2  I $P($G(^PS(55,PSGP,5,Q2,0)),"^",21) Q
 E  F Q2=0:0 S Q2=$O(^PS(53.1,"AC",PSGP,Q2)) Q:'Q2  I $P($G(^PS(53.1,Q2,0)),U,21) Q
 I  S PSJNOO=$$ENNOO^PSJUTL5("D") I PSJNOO<0!('$$REQPROV) D  G DONE
 .W !!,$C(7),"No changes made to this order." D PAUSE^VALM1
 S PSGALR=$S('$D(PSGALO):20,PSGALO?4N&($E(PSGALO)=1):10,1:20) I $P(PSJSYSP0,U,5) D ENHE^PSJADT0 S PSGOP=PSGP D ASET
 F SD=PSGDT:0 S SD=$O(^PS(55,PSGP,5,"AUS",SD)) Q:'SD  F PSGORD=0:0 S PSGORD=$O(^PS(55,PSGP,5,"AUS",SD,PSGORD)) Q:'PSGORD  S PSGORD=+PSGORD_"A" D AC
 D NSET S CF=$P(PSJSYSP0,U,5) F PSGORD=0:0 S PSGORD=$O(^PS(53.1,"AC",PSGP,PSGORD)) Q:'PSGORD  S PSGORD=+PSGORD_"N" D NC
 W " . . . DONE!" K PSGORD G DONE
ENO(PSGP,PSGORD) ; single order
 I PSGSTAT="D" W !,"This order has already been DISCONTINUED." D PAUSE^VALM1 Q
 S CF=$S($P(PSJSYSP0,U,5):1,PSGORD["U":0,1:($P($G(^PS(53.1,+PSGORD,0)),U,25)=""&($P($G(^(4)),U,7)=DUZ)))
 S PSJCOM=+$S(PSGORD["U":$P($G(^PS(55,PSGP,5,+PSGORD,.2)),"^",8),1:$P($G(^PS(53.1,+PSGORD,.2)),"^",8))
 I 'CF,PSJCOM W !!,"This order is part of a complex order and CANNOT be marked for discontinuation." Q
 I $$PNDRNOK(PSGORD) N PSJDCTYP S PSJDCTYP=$$PNDRNA(PSGORD) D:(PSJDCTYP=1!(PSJDCTYP=2)) PNDRN($G(PSJDCTYP),PSGORD) G DONE
 I PSJCOM W !!,"This order is part of a complex order. If you discontinue this order the",!,"following orders will be discontinued too (unless the stop date has already",!,"been reached)." D CMPLX^PSJCOM1(PSGP,PSJCOM,PSGORD)
 F  W !!,"Do you want to ",$S(PSJCOM:"discontinue this series of complex orders",CF:"discontinue this order",1:"mark this order for discontinuation") S %=$S($G(PSJOCFLG):2,1:1) D YN^DICN Q:%  D ENCOM^PSGOEM
 I %<0 S VALMBCK="" Q
 G:%=1 SOC I $S(PSGORD["U":$D(^PS(55,PSGP,5,+PSGORD,4)),1:$D(^PS(53.1,+PSGORD,4))),$P(^(4),U,12) W !!,"THIS ORDER HAS"
 I  D ENUMK^PSGOEM I %=1 W "..." K DA S:PSGORD["A" PSGAL("C")=PSJSYSU*10+21400,DA=+PSGORD,DA(1)=PSGP D RS,^PSGAL5:PSGORD["A" W " . . . DONE!"
 G DONE
SOC ;
 I 'CF,'$P($S(PSGORD["U":$G(^PS(55,PSGP,5,+PSGORD,0)),1:$G(^PS(53.1,+PSGORD,0))),U,21) W !!,"...one moment, please..."
 E  I CF,'($G(PSJDCTYP)=2) S PSJNOO=$$ENNOO^PSJUTL5("D") I PSJNOO<0 D ABORT^PSGOEE G DONE
 ; prompt for requesting provider
 I '($G(PSJDCTYP)=2) I CF,'$$REQPROV D ABORT^PSGOEE G DONE
 K DA D NOW^%DTC S PSGDT=%,T=$E("T",'PSJSYSU),PSGALR=20,DA=+PSGORD,DA(1)=PSGP
 I 'PSJCOM D
 .I PSGORD["U" D ASET:CF,AC
 .I PSGORD'["U" D NSET:CF,NC
 I PSJCOM N COMFLG S COMFLG=0 D
 . I PSGORD["P" Q:('$$LOCK^PSJOEA(PSGP,PSJCOM))  D 
 .. N O S O="" F  S O=$O(^PS(53.1,"ACX",PSJCOM,O)) Q:O=""  S (PSGORD,PSJORD)=O_"P" D NSET,NC
 .I PSGORD["U" N O,OO S O=0,OO="" F  S O=$O(^PS(55,"ACX",PSJCOM,O)) Q:'O  F  S OO=$O(^PS(55,"ACX",PSJCOM,O,OO)) Q:OO=""  Q:COMFLG  D
 .. Q:OO=PSGORD  I '$$LS^PSSLOCK(DFN,OO) S COMFLG=1 Q
 I PSJCOM Q:COMFLG  N O,OO S O=0,OO="" F  S O=$O(^PS(55,"ACX",PSJCOM,O)) Q:'O  F  S OO=$O(^PS(55,"ACX",PSJCOM,O,OO)) Q:OO=""  D
 . I OO["V" S ON55=OO D D1^PSIVOPT2 S PSIVALT=1,PSIVALCK="STOP",PSIVREA="D",ON=ON55,P(3)=$P($G(^PS(55,DFN,"IV",+ON55,0)),U,3) D
 .. D LOG^PSIVORAL N PSJORD S PSJORD=ON55,P(3)=$P($G(^PS(55,DFN,"IV",+ON55,0)),U,3),P("NAT")=PSJNOO D HL^PSIVORA
 . I OO["U" N PSGORD,PSJORD S (PSGORD,PSJORD)=OO D ASET^PSGOEC,AC^PSGOEC
 Q
D1 N %,DA,DIE,DIU,STP,NSTOP
 D NOW^%DTC S NSTOP=+$E(%,1,12),STP=$P($G(^PS(55,DFN,"IV",+ON55,0)),U,3),NSTOP=+$S(STP>NSTOP:NSTOP,1:STP),P(17)="D"
 S DA(1)=DFN,DA=+ON55,DIE="^PS(55,"_DFN_",""IV"",",DR="109////"_NSTOP_$S('$P($G(^PS(55,DFN,"IV",+ON55,2)),U,7):";116////"_STP,1:"")_";100///D;.03////"_NSTOP,PSIVACT=1 D ^DIE
 I $S($G(PSIVAC)="OD":0,$G(PSIVAC)'="AD":1,$G(PSGALO)<1060:0,1:$P($G(PSJSYSW0),U,15)) S X=$S($G(PSIVAC)="AD":1,1:2) D ENLBL^PSIVOPT(X,$S(X=1:+$G(PSGUOW),1:DUZ),DFN,3,+ON55,$E("AD",1,3-X))
 D:'$D(PSJIVORF) ORPARM^PSIVOREN Q:'PSJIVORF  ;* S ORIFN=$P($G(^PS(55,DFN,"IV",+ON55,0)),U,21) Q:'ORIFN
 Q
OUT ;
 W $S(PSJCOM:"...ORDER ",1:"...ORDERS "),$S(CF:"DISCONTINUED!",1:"MARKED!") S PSGCANFL=1
DONE ;
 K CF,DA,DIE,DP,DR,ORIFN,ORETURN,PSGAL,PSGALR,PSGDA,SD,ST,T,UCF,Y,PSJDCTYP Q
ASET ;
 S DIE="^PS(55,"_PSGP_",5,",DR="136////@;28////"_$S($P($G(^PS(55,PSGP,5,+$G(PSJORD),0)),U,27)="E":"DE",$D(PSGEDIT):"DE",1:"D")_";Q;34////"_PSGDT_$S(T]"":";49////1",1:"")
 Q
NSET ;
 S DIE="^PS(53.1,",DR="28////"_$S($P($G(^PS(53.1,+$G(PSJORD),0)),U,27)="E":"DE",$D(PSGEDIT):"DE",1:"D")_$S(T]"":";42////1",1:"")_";25////"_PSGDT Q
AC ;
 I 'CF K DA S $P(^PS(55,PSGP,5,+PSGORD,4),U,11,14)="^1^"_DUZ_U_PSGDT,PSGAL("C")=13040,DA=+PSGORD,DA(1)=PSGP D ^PSGAL5
 I 'CF,$D(PSJSYSO) S PSGORD=+PSGORD_"A",PSGPOSA="C",PSGPOSD=PSGDT D ENPOS^PSGVDS
 Q:'CF  K DA,ORIFN S PSGAL("C")=PSJSYSU*10+4000,DA=+PSGORD,DA(1)=PSGP D ^PSGAL5 S $P(^(2),U,3)=$P(^PS(55,PSGP,5,+PSGORD,2),U,4) D ^DIE S ^PS(55,"AUE",PSGP,+PSGORD)=""
 I PSJSYSL K DA S $P(^PS(55,PSGP,5,+PSGORD,7),U,1,2)=PSGDT_U_$S($D(PSGEDIT):"DE",1:"D"),PSGTOL=2,PSGUOW=DUZ,PSGTOO=1,DA=+PSGORD,DA(1)=PSGP D ENL^PSGVDS
 S ORIFN=$P($G(^PS(55,PSGP,5,+PSGORD,0)),U,21) D:ORIFN DCOR^PSGOECS
 Q
NC ;
 I 'CF S $P(^PS(53.1,+PSGORD,4),"^",11,14)="^1^"_DUZ_U_PSGDT
 I 'CF,$D(PSJSYSO) S PSGORD=+PSGORD_"N",PSGPOSA="C",PSGPOSD=PSGDT D ENPOS^PSGVDS
 Q:'CF  S PSGSTAT=$P($G(^PS(53.1,+PSGORD,0)),U,9),PSGORIFN=$P($G(^(0)),U,21)
 I PSGSTAT'="U" K DA,ORIFN S DA=+PSGORD D ^DIE I PSJSYSL,PSJSYSL<3,(PSGSTAT'="P") S $P(^PS(53.1,+PSGORD,7),U,1,2)=PSGDT_U_$S($D(PSGEDIT):"DE",1:"D"),PSGTOO=2,PSGUOW=DUZ,PSGTOL=2 D ENL^PSGVDS
 I PSGSTAT="U" K DA S DA=+PSGORD,DIK="^PS(53.1," D ^DIK
 I PSGORIFN S ORIFN=PSGORIFN D DCOR^PSGOECS
 Q
T ;
 F  W !!,"Is this due to the patient being transferred" S %=2 D YN^DICN Q:%  D ENCTM^PSGOEM1
 S T=$S(%<0:"^",1:$E("T",%=1)) Q
RS ;
 ; naked ref below is from variable ND1, ^PS(53.1,PSGDA,4)
 S $P(^(4),U,11,14)="^^^" Q
 ;
REQPROV()          ;
 I $G(PSJDCTYP)=2 Q 1
 K PSJDCPRV,DIC,DUOUT,DTOUT,Y
 N PROVIDER,PROVNAME,RESULT,RSB S RESULT=0
 S PROVIDER=+$P($G(^PS(55,DFN,5.1)),"^",2),PROVNAME=""
 I PROVIDER>0 D
 .S DIC=200,DR="53.1;53.4",DIQ="RSB",DIQ(0)="I",DA=PROVIDER D EN^DIQ1
 .K DIC,DR,DA,DIQ
 .I $G(RSB(200,PROVIDER,53.1,"I"))="1"&(($G(RSB(200,PROVIDER,53.4,"I"))="")!($G(RSB(200,PROVIDER,53.4,"I"))>DT)) D
 ..S DIC=200,DA=PROVIDER,DR=".01",DIQ="RSB",DIQ(0)="E" D EN^DIQ1
 ..S PROVNAME=$G(RSB(200,PROVIDER,.01,"E")) K DA,DIQ,DR
 K DIC S DIC=200,DIC(0)="AEMQZ"
 S:PROVNAME]"" DIC("B")=PROVNAME
 S DIC("A")="Requesting PROVIDER: "
 S DIC("S")="I $D(^(""PS"")),^(""PS""),$S('$P(^(""PS""),""^"",4):1,1:$P(^(""PS""),""^"",4)>DT)" D ^DIC K DIC
 I +Y>0,'$D(DUOUT),'$D(DTOUT) S RESULT=1,PSJDCPRV=+Y
 Q RESULT
 ;
PNDRNA(ORDER) ; Ask Discontinue Pending Renewal only, or both Pending Renew and Renewed Order
 ; Perform this action only for pending renewals
 I '$G(ORDER)!'($G(ORDER)["P") Q 3
 ; Quit if original order is no longer active
 N ORIGORD,ORIGSTOP S ORIGORD=$P($G(^PS(53.1,+ORDER,0)),"^",25) Q:'ORIGORD  D  I ORIGSTOP<$G(PSGDT) Q 1
 .S ORIGSTOP=$S(ORIGORD["U":$P($G(^PS(55,PSGP,5,+ORIGORD,2)),"^",4),ORIGORD["V":$P($G(^PS(55,PSGP,"IV",+ORIGORD,0)),"^",3),1:"")
 N NDP2
 S NDP2=^PS(53.1,+ORDER,.2) S DRG=NDP2,DO=$P(DRG,"^",2) S DRG=$$ENPDN^PSGMI($P(DRG,"^"))
 S ND2=^PS(53.1,+ORDER,2) S SCH=$P(ND2,"^"),START=$P(ND2,"^",2),START=$$FMTE^XLFDT(START,2)
 W !!?5,DRG_" "_DO
 W !?5,"This order has a pending status. If this pending order"
 W !?5,"is discontinued, the original order may still be active."
 S DIR("A")="Select order(s) to discontinue"
 S DIR(0)="S^1:DC BOTH Orders;2:DC Pending Order;3:Cancel - No Action Taken"
 S DIR("L",1)="1 - DC BOTH Orders"
 S DIR("L",2)="2 - DC Pending Order"
 S DIR("L",3)="3 - Cancel - No Action Taken" D ^DIR
 ; Reverse order - Y=1 - Pending only  Y=2:BOTH
 S Y=$S(Y=1:2,Y=2:1,1:3)
 Q Y
 ;
PNDRN(PSJDCTYP,ORDER) ; Perform Discontinue action for Pending order only or both Pending and Renewed
 ; Perform this action only for pending renewals
 N PSGORD S PSGORD=ORDER
 Q:'$G(PSGORD)!'($G(PSGORD)["P")
 I PSJDCTYP=1 G SOC
 I PSJDCTYP=2 S PSJDCTYP=1 D SOC Q:'$G(PSJDCTYP)  D
 .I ($G(PSJNOO)<0) Q
 .N ND5310 S ND5310=$G(^PS(53.1,+PSGORD,0))
 .N PSGORD S PSGORD=$P(ND5310,"^",25) I PSGORD S PSJDCTYP=2 D SOC K PSJDCTYP
 Q
 ;
PNDRNOK(ORDER) ; Execute DC Pending Renew enhancement only if 
 ;                  1) Renewal order is pending/non-verified, and 
 ;                  2) Original order is not DC'd or Expired
 Q:'$G(PSGORD)!'($G(PSGORD)["P") 0
 N ORIGORD,ORIGSTOP S ORIGORD=$P($G(^PS(53.1,+ORDER,0)),"^",25) Q:'ORIGORD 0  D  I ORIGSTOP<$G(PSGDT) Q 0
 .S ORIGSTOP=$S(ORIGORD["U":$P($G(^PS(55,PSGP,5,+ORIGORD,2)),"^",4),ORIGORD["V":$P($G(^PS(55,PSGP,"IV",+ORIGORD,0)),"^",3),1:"")
 Q:'($P($G(^PS(53.1,+PSGORD,0)),U,24)="R") 0
 Q 1
