DGBTCD ;ALB/SCK/BLD - BENEFICIARY TRAVEL CLAIM DISPLAY; 12/15/92 4/14/93
 ;;1.0;Beneficiary Travel;**2,7,9,20**;September 25, 2001;Build 185
 Q
SCREEN ;this will display the information screen at the end of a claim and 
 Q:'$D(^DGBT(392,DGBTDT,0))  S U="^" K DGBTVAR F I=0,"A","C","D","M","R","T" S DGBTVAR(I)=$S($D(^DGBT(392,DGBTDT,I)):^(I),1:"")
 S DGBTACCT=$S($D(^DGBT(392.3,+$P(DGBTVAR(0),U,6),0)):$P($G(^(0)),U,5),1:0)
 I 'DGBTACCT W !!,*7,">> WARNING! No ACCOUNT TYPE for this claim, Please correct through Claim Enter/Edit!" G QUIT
 W @IOF
 W !?18,"Beneficiary Travel Claim Information <Display>"
 W !!,?2,"Claim Date: ",DGBTDTE W:$P(DGBTVAR(0),U,11)'=""&($D(^DG(40.8,$P(DGBTVAR(0),U,11),0))) ?40,"Division: ",$P(^DG(40.8,$P(DGBTVAR(0),U,11),0),U)
 D PID^VADPT6 W !!?8,"Name: ",VADM(1),?40,"PT ID: ",VA("PID"),?64,"DOB: ",$P(VADM(3),U,2)
 S (DGBTFCTY,DGBTTCTY)=""
 I $P(DGBTVAR("D"),U,4)]"" S DGBTCNA=$P(DGBTVAR("D"),U,4) D CITY^DGBTCR I DGBTCSZ[DGBTCNA D
 . S DGBTCSZ=DGBTCNA_", "_$S(+$P(DGBTVAR("D"),U,5)>0:$P(^DIC(5,$P(DGBTVAR("D"),U,5),0),U,2),1:"")_"  "
 . S Y=$P(DGBTVAR("D"),U,6),Y=$E(Y,1,5)_$S($E(Y,6,9)]"":"-"_$E(Y,6,9),1:"") S DGBTCSZ=DGBTCSZ_Y,DGBTFCTY=DGBTCSZ
 I $P(DGBTVAR("T"),U,4)]"" S DGBTCNA=$P(DGBTVAR("T"),U,4) D CITY^DGBTCR S:DGBTCSZ[DGBTCNA DGBTCSZ=DGBTCNA_", "_$S(+$P(DGBTVAR("T"),U,5)>0:$P(^DIC(5,$P(DGBTVAR("T"),U,5),0),U,2),1:"")_"  "_$P(DGBTVAR("T"),U,6) S DGBTTCTY=DGBTCSZ
FROM W !!," Depart From: ",$E($P(DGBTVAR("D"),U),1,30)
 W ?46,"To: ",$E($P(DGBTVAR("T"),U),1,30)
 W !?14 W:$P(DGBTVAR("D"),U,2)]"" $P(DGBTVAR("D"),U,2) W:$P(DGBTVAR("D"),U,2)="" $P(DGBTVAR("D"),U,3) W:$P($G(DGBTVAR("D")),U,2)=""&($P($G(DGBTVAR("D")),U,3)="") DGBTFCTY
 W ?50 W:$P(DGBTVAR("T"),U,2)]"" $P(DGBTVAR("T"),U,2) W:$P(DGBTVAR("T"),U,2)="" $P(DGBTVAR("T"),U,3) W:$P(DGBTVAR("T"),U,2)=""&($P(DGBTVAR("T"),U,3)="") DGBTTCTY
 W !?14 W:$P(DGBTVAR("D"),U,3)]"" $P(DGBTVAR("D"),U,3) W:$P(DGBTVAR("D"),U,2)]""&($P(DGBTVAR("D"),U,3)="") DGBTFCTY
 W ?50 W:$P(DGBTVAR("T"),U,3)]"" $P(DGBTVAR("T"),U,3) W:$P(DGBTVAR("T"),U,2)]""&($P(DGBTVAR("T"),U,3)="") DGBTTCTY
 W !?14 W:$P(DGBTVAR("D"),U,2)]""&($P(DGBTVAR("D"),U,3)]"") DGBTFCTY
 W ?50 W:$P(DGBTVAR("T"),U,2)]""&($P(DGBTVAR("T"),U,3)]"") DGBTTCTY
ELIG W !!," Eligibility: " W:$P(DGBTVAR(0),U,3) $P(^DIC(8,$P(DGBTVAR(0),U,3),0),U) W:$P(DGBTVAR(0),U,4)]"" ?45,"SC%: ",$P(DGBTVAR(0),U,4)
 I $P(DGBTVAR(0),U,5) W ?57,"Cert. Date: " S VADAT("W")=9999999-$P($P(DGBTVAR(0),U,5),".") D ^VADATE W $P(VADATE("E"),"@") K VADAT,VADATE
ACCT W !!?5,"Account: ",$S($P(DGBTVAR(0),U,6):$E($P(^DGBT(392.3,$P(DGBTVAR(0),U,6),0),U),1,15),1:"") W:$P(DGBTVAR("A"),U,3) ?31,"REVIEW VISIT"
 ;question added for DG*1.0*20 E18
 W !!,"Common Carrier Req: ",$S($$GET1^DIQ(392,DGBTDT,55.1)="YES":"YES",1:"NO") W ?48,"COMMON CARRIER FEE: " S X=$P(DGBTVAR("C"),U,2),X2="2$" N X3 D COMMA^%DTC W X ;
 W !,?51,"Most Econ. Cost: " S X=$P(DGBTVAR(0),U,8),X2="2$" N X3 D COMMA^%DTC W X
ATT I DGBTACCT=4!(DGBTACCT=5) W !,"Attend/Payee: ",$S($D(DGBTVAR("A")):$P(DGBTVAR("A"),U,2),1:"")
 I $G(PATCHDT)'<$G(DGBTDT) I $G(DGBTACCT)'=4&($G(DGBTACCT)'=5) W !," Mode/Trans.: ",$S($P($G(DGBTVAR("A")),U,4):$P(^DGBT(392.43,$P($G(DGBTVAR("A")),U,4),0),U),1:"")  ;changed file from 392.4 to 392.43
 I $G(PATCHDT)<$G(DGBTDT) I $G(DGBTACCT)'=4&($G(DGBTACCT)'=5) W !," Mode/Trans.: ",$S($P($G(DGBTVAR("A")),U,4):$P(^DGBT(392.4,$P($G(DGBTVAR("A")),U,4),0),U),1:"")  ;use file 392.4 if claim date is before install date
 I $D(^DG(43,1,"BT")) I $P(^DG(43,1,"BT"),U,2)=1 W ?51,"Meals & Lodging: " S X=$P($G(DGBTVAR("M")),U,4) N X3 D COMMA^%DTC W X
 I $G(DGBTACCT)=4!($G(DGBTACCT)=5) W !,"One Way/"
 I $G(DGBTACCT)'=4&($G(DGBTACCT)'=5) D
 . S DGX=$S($P($G(DGBTVAR(0)),U,7):"Carrier",$P($G(DGBTVAR(0)),U,14):"CoreFLS",1:"Carrier") W:DGX["FLS" !,"CoreFLS Carrier: " W:DGX["Carrier" !?5,"Carrier: "
 . W $E($S((DGX["FLS"&$P($G(DGBTVAR(0)),U,14)):$P(^DGBT(392.31,$P($G(DGBTVAR(0)),U,14),0),U),(DGX["Carrier"&$P(DGBTVAR(0),U,7)):$P(^PRC(440,$P(DGBTVAR(0),U,7),0),U),1:""),1,27) K DGX
 I $D(^DG(43,1,"BT")) I $P(^DG(43,1,"BT"),U,2)=1 W ?46,"Ferry, Bridges, Etc.: " S X=$P(DGBTVAR("M"),U,5) N X3 D COMMA^%DTC W X
 I $G(DGBTACCT)=4!($G(DGBTACCT)=5) W !?2,"Round Trip: ",$S($P(DGBTVAR("M"),U)=1:"ONE WAY",$P(DGBTVAR("M"),U)=2:"ROUND TRIP",1:"")
 I $G(DGBTACCT)'=4&($G(DGBTACCT)'=5) W !,"Auth. Person: " I $P(DGBTVAR("A"),U) W $S($D(DGBTVAR("A"))&($D(^VA(200,$P(DGBTVAR("A"),U),0))):$P(^VA(200,$P(DGBTVAR("A"),U),0),U),1:"")
 I $G(DGBTACCT)=4!($G(DGBTACCT)=5) W ?46,"Total Mileage Amount: " D  N X3 D COMMA^%DTC W X
 .S X=$P(DGBTVAR("M"),U,3)
 I $G(DGBTACCT)=4!($G(DGBTACCT)=5) W !,"Mileage/"
DED W ?48,"Applied Deductible: " D  N X3 D COMMA^%DTC W X
 .S X=$P($G(DGBTVAR(0)),"^",9)   ;$G(DGBTDCV1)    ;$P(DGBTVAR(0),"^",9)
 W ! W:$G(DGBTACCT)=4!($G(DGBTACCT)=5) ?5,"One Way: ",$P($G(DGBTVAR("M")),U,2)_" MILES"
 W ?53,"Amount Payable " S X=$$GET1^DIQ(392,DGBTDT,10) N X3 D COMMA^%DTC W X
REMARK W !!,"Remarks: ",$S($D(^DGBT(392,DGBTDT,"R")):$P(^DGBT(392,DGBTDT,"R"),U),1:"")
QUIT K DGBTCNA,DGBTCSZ,DGBTFCTY,DGBTTCTY,DGBTCNA,DGBTDIV,VADAM,X,X2,I
 Q
