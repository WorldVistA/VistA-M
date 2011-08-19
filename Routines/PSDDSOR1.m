PSDDSOR1 ;BHM/MHA/PWC - Digitally signed CS Orders Report; 08/30/02
 ;;3.0; CONTROLLED SUBSTANCES ;**40,67**;13 Feb 97;Build 8
 ;Ref. to ^PSRX( supported by DBIA 1977
 ;Ref. to ^PS(52.41, supported by DBIA 3848
 ; PSD*3*67 added checks for pending file to only include information
 ; about patient in pending file ^PS(52.41
 ;
 Q
PRT I ($Y+13)>IOSL D:AC HD^PSDDSOR D:'AC HD^PSDDSOR2 Q:$D(DIRUT)
 S I=0,PL=""
 I $P($G(Y2),"^")]"" S PL=$E($P(Y2,"^"),1,30)
 E  S PL=$E($P($G(Y6),"^"),1,30),I=1
 W !?1," DRUG"_$S($G(I):" (OI)",1:"")_": "_PL,?50,"CS Federal Schedule: "_$P(Y2,"^",5)
 W !?2,"Provider: "_$E($P(Y4,"^")_P1,1,30),?50,"DEA #: "_$S($P(Y4,"^",3)]"":$P(Y4,"^",3),$P(Y4,"^",2):$$DEA^XUSER(,$P(Y4,"^",2)),1:"")
 S PL=$P(Y5,"^"),PL1="" F I=2:1:6 S J=$P(Y5,"^",I) D:J]""
 .I $L(J)+$L(PL)<60 S PL=PL_", "_J
 .E  S PL1=PL1_$S(PL1]"":", ",1:"")_J
 W !?2,"Provider Address: "_PL W:PL1]"" !?23,PL1
 W !?2,"CPRS Order #: "_$P(Y0,"^",2),?50,"Date Order Written: " S Y=$P(Y0,"^",5) I Y W $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 W !?2,"Patient Name: "_$E($P(Y1,"^")_P1,1,30),?50,"PATIENT ID: "
 S DFN=$S(AC=4:$P($G(^PS(52.41,S5,0)),"^",2),1:$P(^PSRX(S5,0),"^",2)) D PID^VADPT W $E($P(Y1,"^"))_VA("BID")
 S PL=$P(Y1,"^",2),PL1="" F I=3:1:7 S J=$P(Y1,"^",I) D:J]""
 .I $L(J)+$L(PL)<60 S PL=PL_", "_J
 .E  S PL1=PL1_$S(PL1]"":", ",1:"")_J
 W !?2,"Patient Address: "_PL W:PL1]"" !?19,PL1
 W !?2,"Rx #: "_$S(AC=4:"",$D(^PSRX(S5,0)):$P(^PSRX(S5,0),"^"),1:"")
 W ?50,"Qty: "_$S(AC=4:$P(^PS(52.41,S5,0),"^",10),1:$P(Y2,"^",3))
 W !?2,"SIG: "
 S PL=0 I AC'=4,$D(^PSRX(S5,"SIG1")) D  G P1
 .F  S PL=$O(^PSRX(S5,"SIG1",PL)) Q:'PL  W:PL>1 ! W ?7,^PSRX(S5,"SIG1",PL,0)
 I AC=4,$D(^PS(52.41,S5,"SIG")) D  G P1
 .F  S PL=$O(^PS(52.41,S5,"SIG",PL)) Q:'PL  W:PL>1 ! W ?7,^PS(52.41,S5,"SIG",PL,0)
 W ?7,$P(Y3,"^")
P1 S RX2=$S(AC=4:"",$D(^PSRX(S5,2)):^PSRX(S5,2),1:"")
 W !?2,"Date Filled: " S Y=$P(RX2,"^",2) I Y W $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 W ?50,"Date Released: " S Y=$P(RX2,"^",13) I Y W $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 W !?2,"Releasing Pharmacist: "_$S($P(RX2,"^",3):$P(^VA(200,$P(RX2,"^",3),0),"^"),1:"")
 W ?50,"Valid PKI Certificate?: "
 N FL0 S FL0=$S(AC=4:"No",1:"Yes"),Y=$P(RX2,"^",2)
 I AC'=4,$D(^PSRX(S5,"A")) N FL S FL=0 F  S FL=$O(^PSRX(S5,"A",FL)) Q:'FL!(FL0="No")  I $P(^PSRX(S5,"A",FL,0),"^",2)="K" S FL0="No",Y=$P($P(^(0),"^"),".")
 W FL0
 W !?2,"Date Signature Validation Attempted by Pharmacy: "
 I Y W $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 W !?2,"CPRS Nature of Order: "_$P(Y0,"^",3),?50,"CPRS Status: "_$P($P(Y0,"^",4),";",2)
 S PL=$S($P(Y0,"^",7)]"":$P(Y0,"^",7),$P(Y0,"^"):"Digitally Signed",1:"")
 W !?2,"Signature Status: "_$E(PL,1,60) W:$L(PL)>60 !,?20,$E(PL,61,200) W !
 Q
