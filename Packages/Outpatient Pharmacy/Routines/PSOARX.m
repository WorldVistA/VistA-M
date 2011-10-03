PSOARX ;B'ham ISC/SAB - display archived rxs ;03/10/94  1:08 pm 
 ;;7.0;OUTPATIENT PHARMACY;**10,148**;DEC 1997
GET S RX=^PSRX(DA,0),J=DA,RX2=$G(^PSRX(DA,2)),R3=$G(^(3)),RTN=$G(^("TN")) S DFN=+$P(RX,"^",2) S ANS="",FFX=0
 S PSDIV=$S($D(^PS(59,+$P(RX2,"^",9),0)):$P(^(0),"^",1)_" ("_$P(^(0),"^",6)_")",1:"Unknown"),PSDIV=$E(PSDIV,1,28)
 S PSEXDT=$P(RX2,"^",6),PSEXDT=$S(PSEXDT]"":$E(PSEXDT,4,5)_"/"_$E(PSEXDT,6,7)_"/"_$E(PSEXDT,2,3),1:"Unknown")
PR D STAT
 W !!,"Rx: "_$P(RX,"^")
 S MED=+$P(RX,"^",6),M1="" S:$D(^PSDRUG(MED,0)) M1=^(0) W ?20,$S($P(M1,"^",3)["S":"      Item: ",1:"      Drug: "),$P(M1,"^",1),?65,$S(RTN'="":"Trade Name: "_RTN,1:"")
 W ?96,"QTY: ",$P(RX,"^",7),"     ",$S($P(RX,"^",8)?1N.N:$P(RX,"^",8),1:"??")," Day Supply"
 W !?7,"SIG: "
 I '$P(^PSRX(DA,"SIG"),"^",2) S (SIG,X)=$P($G(^PSRX(DA,"SIG")),"^") D SIGONE^PSOHELP W SIG G RFL
 F I=0:0 S I=$O(^PSRX(DA,"SIG1",I)) Q:'I  W $P(^PSRX(DA,"SIG1",I,0),"^") W:$O(^PSRX(DA,"SIG1",I)) !?12
RFL S II=J D LAST^PSORFL W !?4,"Latest: "_RFL,?37,"# of Refills: "_$P(RX,"^",9)
 S RFM=$P(RX,"^",9),PL=0 I $O(^PSRX(DA,1,0)) F I=0:0 S I=$O(^PSRX(DA,1,I)) Q:'I  S RFM=RFM-1,PL=PL+1
 W "  Remaining: "_RFM
 S PHYS=$S($D(^VA(200,+$P(RX,"^",4),0)):$P(^(0),"^"),1:"Unknown") W ?70,"Provider: "_PHYS
DTT S DTT=$P(RX,"^",13) D DAT W !?4,"Issued: "_DAT,?43,"Clinic: "_$S($D(^SC(+$P(RX,"^",5),0)):$P(^(0),"^",1),1:"Not on File"),?71,"Division: "_PSDIV
 S DTT=$P(RX2,"^",1)\1 D DAT W !?4,"Logged: "_DAT,?42,"Routing: " S X=$F("MWI",$P(RX,"^",11))-1 W:X $P("Mail^Window^Inpatient","^",X),?69,"Clerk Code: "_$S($D(^VA(200,+$P(RX,"^",16),0)):$P(^(0),"^"),1:"Unknown")
 W !?3,"Expires: "_PSEXDT
 W ?46,"Cap: "_$P("Non-^","^",$S($D(^PS(55,DFN,0)):+$P(^(0),"^",2),1:0)),"Safety",?73,"Status: "_ST I ($D(PS)#2),PS="DISCONTINUE",ST["DISCONTINUE" S PS="Reinstate"
 G:$D(PSOZVER) REM S DTT=$P(RX2,"^",2) D DAT W !?4,"Filled: "_DAT,?24,"Pharmacist: "_$S($D(^VA(200,+$P(RX2,"^",3),0)):$P(^(0),"^",1),1:""),?56,"Verifying Pharmacist: "_$S($D(^VA(200,+$P(RX2,"^",10),0)):$P(^(0),"^",1),1:"")
 W ?75,"Lot #: "_$P(RX2,"^",4),?85," QTY: "_$P(RX,"^",7)
REM W !?2,$S($P(RX2,"^",15):"Returned to Stock:  "_$E($P(RX2,"^",15),4,5)_"/"_$E($P(RX2,"^",15),6,7)_"/"_$E($P(RX2,"^",15),2,3),1:"Released: "_$S($P(RX2,"^",13):$E($P(RX2,"^",13),4,5)_"/"_$E($P(RX2,"^",13),6,7)_"/"_$E($P(RX2,"^",13),2,3),1:""))
 W !?3,"Remarks: "_$P(R3,"^",7)
 S PSOZ=0 D HEAD:PL F N=0:0 S N=$O(^PSRX(DA,1,N)) Q:'N  S P1=^(N,0) D N G Q:ANS'=""
ACT G Q:'$O(^PSRX(DA,"A",0)) G Q:ANS="^" D H1 F N=0:0 D LP1 Q:PSOZ
 I $O(^PSRX(DA,4,0)) D CMOP^PSOARCTG
 G Q
A1 D H1:FFX,DAT1 W !,N1,?3,DAT1,?14 S X=$P(P1,U,2),X=$F("HUCELPRWSIVDABXGKNM",X)-1
 W:X $P("Hold^Unhold^DC'd^Edit^Renewed^Partial^Reinstate^Reprint^Suspense^Returned Stock^Intervention^Deleted^Drug Interaction^Processed^X-Interface^Patient Inst.^PKI/DEA^Dispense Completed^ECME^","^",X) W ?25
 S X=$P(P1,U,4) W:X]"" $S(X>0&(X<6):"Refill "_X,X=6:"Partial",X>6:"Refill "_(X-1),1:"Original"),?35,$S($D(^VA(200,+$P(P1,"^",3),0)):$P(^(0),"^",1),1:"Unknown")
 G:PSOZ A2 W ?60,N2,?63,DAT2,?74 S X=$P(P2,U,2),X=$F("HUCELPRWSIVDABXGKNM",X)-1
 W:X $P("Hold^Unhold^DC'd^Edit^Renewed^Partial^Reinstate^Reprint^Suspense^Returned Stock^Intervention^Deleted^Drug Interaction^Processed^X-Interface^Patient Inst.^PKI/DEA^Dispense Completed^ECME^","^",X) W ?85
 S X=$P(P2,U,4) W:X]"" $S(X>0&(X<6):"Refill "_X,X=6:"Partial",X>6:"Refill "_(X-1),1:"Original"),?95,$S($D(^VA(200,+$P(P1,"^",3),0)):$P(^(0),"^",1),1:"Unknown")
A2 W:($P(P1,U,5)]"")!(('PSOZ)&($P(P2,U,5)]"")) ! W:$P(P1,U,5)]"" ?5,"Comment: "_$E($P(P1,U,5),1,45) Q:PSOZ  W:$P(P2,U,5)]"" ?65,"Comment: "_$E($P(P2,U,5),1,45)
 I ($L($P(P1,U,5))>45)!($L($P(P2,U,5))>45) W ! W:$L($P(P1,U,5))>45 ?14,$E($P(P1,U,5),46,75) W:('PSOZ)&($L($P(P2,U,5))>45) ?79,$E($P(P2,U,5),46,75)
 Q
N S (DTT1,DTT2)="" Q:ANS="^"  D HEAD:FFX W !,N,?3 S DTT1=$P(P1,"^",8)\1,DTT2=$P(P1,U,1) D DAT1 W DAT1,?14,DAT2,?27,$P(P1,"^",4),?32
 S PSDIV=$S($D(^PS(59,+$P(P1,"^",9),0)):$P(^(0),"^"),1:"Unknown")
 S X=$P(P1,"^",2),X=$F("MWIBD",X)-1 W:X $P("Mail^Window^Inpatient","^",X),?40,$P(P1,"^",6),?52,$E($S($D(^VA(200,+$P(P1,"^",5),0)):$P(^(0),"^",1),1:""),1,16),?70,PSDIV
 W !?4,$S($P(P1,"^",16):"Returned to Stock:  "_$E($P(P1,"^",16),4,5)_"/"_$E($P(P1,"^",16),6,7)_"/"_$E($P(P1,"^",16),2,3),1:"Released: "_$S($P(P1,"^",18):$E($P(P1,"^",18),4,5)_"/"_$E($P(P1,"^",18),6,7)_"/"_$E($P(P1,"^",18),2,3),1:""))
 I $P($G(^PSRX(DA,1,N,"IB")),"^")]"" W "     Copay Billing #:  "_$P($G(^PSRX(DA,1,N,"IB")),"^")
 W !?5,"Remarks: "_$P(P1,"^",3) Q
Q K ANS,PSDIV,PSEXDT,MED,M1,FFX,DTT,DAT,RX,RX2,R3,RTN,SIG,STA,P1,PL,P0,Z0,Z1,EXDT,DAT1,DAT2,DTT1,DTT2,I,N,N1,N2,P2,PSOAC,PSOZ,RFM
 Q
LP1 S PSOZ=0,(N,N1)=$O(^PSRX(DA,"A",N)) S:'N PSOZ=1 Q:PSOZ  S P1=^(N1,0),DTT1=P1\1,(N,N2)=$O(^PSRX(DA,"A",N)) S:'N PSOZ=1 S (P2,DTT2)=""
 I 'PSOZ S P2=^PSRX(DA,"A",N2,0),DTT2=P2\1
 D A1
 Q
HEAD D:$Y>(PSOACPL-20) HD1^PSOARCSV
 W !,"#",?3,"Log Date",?14,"Refill Date",?27,"QTY",?32,"Routing",?40,"Lot #",?52,"Pharmacist",?70,"Division",! F I=1:1:79 W "="
 S FFX=0 Q
H1 ;
 W !!,"Activity Log:",!,"#",?3,"Date",?14,"Reason",?25,"Rx Ref",?35,"Security",?60,"#",?63,"Date",?74,"Reason",?85,"Rx Ref",?95,"Security",! F I=1:1:55 W "="
 W ?60 F I=1:1:60 W "="
 Q
DAT ;
 S DAT=$E(DTT,4,5)_"/"_$E(DTT,6,7)_"/"_$E(DTT,2,3)
 Q
DAT1 S (DAT1,DAT2)="",DTT1=DTT1\1,DTT2=DTT2\1 S:DTT1?7N DAT1=$E(DTT1,4,5)_"/"_$E(DTT1,6,7)_"/"_$E(DTT1,2,3) S:(DTT2?7N)&('PSOZ) DAT2=$E(DTT2,4,5)_"/"_$E(DTT2,6,7)_"/"_$E(DTT2,2,3)
 Q
STAT ;gets status of rx
 S ST0=$P(^PSRX(DA,"STA"),"^") I ST0<12,$O(^PS(52.5,"B",J,0)),$D(^PS(52.5,+$O(^(0)),0)),'$G(^("P")) S ST0=5
 I ST0<12,$P(RX2,"^",6)<DT S ST0=11
 S ST=$P("Error^Active^Non-Verified^Refill^Hold^Non-Verified^Suspended^^^^^Done^Expired^Discontinued^Deleted^Discontinued^Discontinued (Edit)^Provider Hold^","^",ST0+2)
 Q
