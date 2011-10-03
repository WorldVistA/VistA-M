PRCHDP1 ;WISC/RSD/RHD-DISPLAY A P.O. ;2/17/98  15:49
 ;;5.1;IFCAP;**143**;Oct 20, 2000;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 S PRCHD0=$G(^PRC(442,D0,0)),PRCHD1=$G(^(1)),X=0
 N PRCHSIT1
 S PRCHDSIT=$P(PRCHD0,"-",1)
 S PRCHSIT1=$S($P($G(^PRC(442,D0,23)),U,7)]"":$P(^(23),U,7),1:$P(PRCHD0,"-"))
 S PRCHDSHP="" Q:PRCHD0']""  S:'$D(PRCHPO) PRCHPO=D0
 I PRCHD1']"",$D(^PRC(442,D0,4,1,0)) S DIC="^PRC(442,",DA=PRCHPO D EN^DIQ Q
 Q:PRCHD1']""  S PRCHDS=0 I +$P(PRCHD0,U,2)'=4,$P(PRCHD1,U,12)="" S PRCHDSHP=$G(^PRC(411,PRCHSIT1,1,+$P(PRCHD1,U,3),0))
 I '$T,$P(PRCHD1,U,12)]"" S PRCHDSHP=$G(^PRC(440.2,$P(PRCHD1,U,12),0)),PRCHDS=1 I +PRCHDSHP>0 S $P(PRCHDSHP,U,1)=$E($P($G(^DPT(+PRCHDSHP,0)),U,1),1,21)
 S IOP="HOME",%ZIS="",PRCHDST=$G(^PRC(411,PRCHDSIT,0)),PRCHDHSP=$G(^(3)) D ^%ZIS W:$Y>0 @IOF
 S PRCHTYPE=$P($G(^PRC(442,D0,23)),U,11)
 I PRCHTYPE="P"!(PRCHTYPE="S") S PRCHTYPE="P"
 W !,$S($G(PRCHTYPE)="P":"PC ORDER: ",$G(PRCHTYPE)="D":"DELIVER ORDER: ",$D(PRCHNRQ):"REQUISITION: ",1:"PURCHASE ORDER: ")_$P(PRCHD0,U,1),?37,"STATUS: " I +$G(^PRC(442,D0,7))>0 W $E($P($G(^PRCD(442.3,+^(7),0)),U,1),1,34)
 W !,"M.O.P.: ",$P($G(^PRCD(442.5,+$P(PRCHD0,U,2),0)),U,1),?37,"LAST PARTIAL RECD.: " S X=0 I $D(^PRC(442,D0,11,0)) S I=0 F  S I=$O(^PRC(442,D0,11,I)) Q:I=""!(I'>0)  S X=I,Y=+^(I,0)
 S:X>0 X=X_"  "_$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3) W:X>0 X W !,?37,"REQUESTING SERVICE: ",$S($D(^DIC(49,+$P(PRCHD1,U,2),0)):$P(^(0),U,1),1:"")
 N PRCHDV1 S PRCHDV=$G(^PRC(440,+PRCHD1,0)),PRCHDV1=$P(PRCHDV,U,1)
 I PRCHDV1="SIMPLIFIED",$P($G(^PRC(442,PRCHPO,24)),U,2)'="" S PRCHDV1=$P($G(^PRC(442,PRCHPO,24)),U,2)
 W !,"VENDOR:",?9,PRCHDV1
 W ?48,"SHIP TO: ",$P(PRCHDSHP,U,1)
 ;
 ; Make sure that the station number is defined for Prosthetics users.
 S PRC("SITE")=PRCHDSIT
 D FTYP^PRCHFPNT S V(1)=$P(PRCHDV,U,2),V=2,S=1 S:'PRCHDS S(S)=PRCHFTYP,S=S+1
 I $P(PRCHDV,U,3)]"" S V(V)=$P(PRCHDV,U,3),V=V+1 S:$P(PRCHDV,U,4)]"" V(V)=$P(PRCHDV,U,4),V=V+1 S:$P(PRCHDV,U,5)]"" V(V)=$P(PRCHDV,U,5),V=V+1
 S V(V)=$S($P(PRCHDV,U,6)]"":($P(PRCHDV,U,6)_", "),1:"   ")_$P($G(^DIC(5,+$P(PRCHDV,U,7),0)),U,2)_"  "_$P(PRCHDV,U,8),V=V+1
 S:$P(PRCHDV,U,10)]"" V(V)=$P(PRCHDV,U,10),V=V+1
 I $D(^PRC(440,+PRCHD1,2)),$P(^(2),U,1)]"" S V(V)="ACCT # "_$P(^(2),U,1)
 I $P(PRCHDST,U,19)="Y",$D(^PRC(440,+PRCHD1,3)),$P(^(3),U,4)'="" S V(6)="FMS Vendor Code: "_$P(^(3),U,4)_$P(^(3),U,5)
 I $P(PRCHD1,U,4)="Y" S V(8)=" VERBAL PURCHASE ORDER" S:$P(PRCHD1,U,5)="Y" V(8)=" CONFIRMATION COPY"
 S PRCHEDI=$G(^PRC(440,+PRCHD1,3)) I PRCHEDI]"",$P(PRCHEDI,U,2)="Y",$P($G(^PRC(442,D0,12)),U,16)'="n" D  S V(8)=PRCHEDIT_" DO NOT MAIL"
 .S PRCHEDIT="",PRCHEDIT=$P($G(^PRC(442,D0,12)),U,14)
 .S PRCHEDIT=$S(PRCHEDIT'="":"*EDI EMERGENCY ORDER-"_$P($G(^PRC(443.4,PRCHEDIT,0)),U)_"*",1:"*EDI ORDER*") Q
 K PRCHEDI,PRCHEDIT
 S:$P(PRCHDSHP,U,2)]"" S(S)=$P(PRCHDSHP,U,2),S=S+1 S:$P(PRCHDSHP,U,3)]"" S(S)=$P(PRCHDSHP,U,3),S=S+1 S:$P(PRCHDSHP,U,4)]"" S(S)=$P(PRCHDSHP,U,4),S=S+1
 S S(S)=$S($P(PRCHDSHP,U,5)]"":($E($P(PRCHDSHP,U,5),1,12)_", "),1:"   ")_$P($G(^DIC(5,+$P(PRCHDSHP,U,6),0)),U,2)_"  "_$P(PRCHDSHP,U,7),S=S+2
 I $P(PRCHDSHP,U,8)]"",'PRCHDS S S(S)="DELIVERY HOURS:",S=S+1,S(S)=$P(PRCHDSHP,U,8)
 ;S:$P($G(^PRC(442,D0,23)),"^",11)="S" V(1)=""
 I $P(PRCHDV,U)="SIMPLIFIED",$P($G(^PRC(442,PRCHPO,24)),U,2)'="" S V(1)=""
 F I=1:1:7 W ! W:$D(V(I)) ?9,V(I) W:$D(S(I)) ?57,S(I)
 W ! W:$D(V(8)) V(8) W:$D(S(8)) ?57,S(8) W !
 I $P(PRCHD1,U,11)]"" W ?38,"DELIVERY LOCATION: ",$P(PRCHD1,U,11),!
 F I=1:1:80 W "_"
 I $P($G(^PRC(442,D0,24)),U,3)="RMPR" D  K RMPRPO,RMPR664,RMPRR3
 . S RMPRPO=$P($P($G(^PRC(442,D0,0)),U),"-",2) Q:RMPRPO=""
 . S RMPR664=$O(^RMPR(664,"G",RMPRPO,0)) Q:RMPR664'>0
 . S RMPRR3=$G(^RMPR(664,RMPR664,3)) I $P(RMPRR3,U)="",$P(RMPRR3,U,4)="" Q
 . W !,"Prosthetics Delivery information:"
 . W !,?7,"Delivery To: ",$E($P(RMPRR3,U),1,50)
 . W !,?9,"Attention: ",$E($P(RMPRR3,U,4),1,50)
 . W ! F I=1:1:80 W "_"
FOB W !,"FOB POINT: ",$S("O"=$E($P(PRCHD1,U,6)):"ORIGIN","D"=$E($P(PRCHD1,U,6)):"DESTINATION",1:""),?29,"|","PROPOSAL: " S DIWL=1,DIWR=16,DIWF="",X=$P(PRCHD1,U,8) K ^UTILITY($J,"W") D DIWP^PRCUTL($G(DA))
 K ^TMP($J,"W") S %X="^UTILITY($J,""W"",",%Y="^TMP($J,""W""," D %XY^%RCR
 W ?40,$G(^TMP($J,"W",1,1,0)),?57,"|AUTHORITY: ",!,"COST CENTER: ",$P(PRCHD0,U,5),?29,"|",?40,$G(^TMP($J,"W",1,2,0)),?57,"|  "
 S Y=0 F I=1:1 S Y=$O(^PRC(442,D0,14,Y)) Q:'Y  W:I>1 "," W $P($G(^PRC(442.4,+^(Y,0),0)),U,2)
 W !,"TYPE: ",$P(PRCHD1,U,14) D TY W X,?29,"|",?40,$G(^TMP($J,"W",1,3,0)),?57,"|"_$S($P($G(^PRC(442,D0,23)),U,11)'="":"BUYER",1:"AGENT")_":"
DIS W !,"DELIVER ON/BEFORE " S Y=$P(PRCHD0,U,10) D DT W ?29,"|","CONTRACT: "
 S Y=+$P(PRCHD1,U,10),Y=$P($G(^VA(200,Y,0)),U,1) W ?57,"|  ",$P(Y,",",2)," ",$P(Y,",",1)
 W !,"DISCOUNT TERM: " S X=0 I $D(^PRC(442,D0,5,0)) F I=1:1:2 S X=$O(^PRC(442,D0,5,X)) Q:X=""!(X'>0)  W $P(^(X,0),U,4),$P(^(0),U,1) W:$P(^(0),U,1)=+$P(^(0),U,1) "%" W $P(^(0),U,2)," "
CON K Y S X=0 F I=1:1:3 S:(X'="") X=$O(^PRC(442,D0,2,"AC",X)) D:X'=""  D:I=2 APP W ?29,"|" W:$D(Y) ?38,$S($D(^(Y)):$J(^(Y),3),1:"") W:X'="" ?41,X W ?57,"|" D DAT:I=1,EST:I=2,TOT:I=3 W ! K Y
 .S:$D(^(X)) Y=$O(^(X,0))
 F I=1:1:80 W "-"
 G ^PRCHDP2
APP W "APP: ",$P(PRCHD0,U,4),"-",$P($P(PRCHD0,U,3)," ",1) Q
DAT W "DATE: " S Y=$P(PRCHD1,U,15) D DT Q
TOT W "TOTAL: ",$J($P(PRCHD0,U,15),8,2) Q
EST S Y=$S($D(^PRC(442,D0,7)):$P(^(7),U,3),1:"") Q:Y'="Y"  W "ESTIMATED" Q
DT I Y W Y\100#100,"/",Y#100\1,"/",Y\10000+1700
 Q
TY S X=+$P(PRCHD1,U,7),X=$P($G(^PRCD(420.8,X,0)),U,1),X=$S(X=2:"PURCHASE ORDER",X="B":"DELIVERY & PURCHASE ORDER",X="":"",1:"DELIVERY ORDER")
 Q
