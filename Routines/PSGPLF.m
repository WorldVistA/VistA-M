PSGPLF ;BIR/CML3-FILES AWAY PICK LIST DATA (BACKGROUND JOB) ;29 SEP 97 / 12:40 PM
 ;;5.0; INPATIENT MEDICATIONS ;**84,130,168**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PSDRUG is supported by DBIA# 2192.
 ; Reference to ^ECXUD1 is supported by DBIA# 172.
 ; Reference to ^DIC(42 is supported by DBIA# 1377.
 ; Reference to ^DIC(42 is supported by DBIA# 10039.
 ;
FILE ; add data to cost file and order
 S PSGX=$P(PLR,"^",2),PSGY=$P(PLR,"^",3) S:PSGX?7N1"DI" PSGX=0 S PSGX=+PSGX S:PSGY="" $P(PLR,"^",3)=PSGX,PSGY=PSGX
 S COST="",(D3,DO)=$P(PLR,"^") I $G(D3) Q:'$D(^PS(55,PN,5,O,1,D3,0))
 I D3=+D3 S D3=$P($G(^PS(55,PN,5,O,1,D3,0)),"^") I D3=+D3 S COST=$P($G(^PSDRUG(D3,660)),"^",6)
 E  S D3="999Z"
 I COST="" S PSGPLFF=0 S:D3="999Z" D3=PN_","_O_","_DO S:'$D(^TMP("PSGNCF",$J,"B",D3)) ^(D3)="" Q
 S PS=PSGY<0*2 S:PS PSGY=-PSGY S COST=COST*PSGY G:'PSGY&'COST OS
 F  L +^PS(57.6,D0,1,D1,1,D2,1,D3,0):1 I  Q
 I $D(^PS(57.6,D0,1,D1,1,D2,1,D3,0)) S ND=^(0),PSGZ=1
 E  S ND=D3,PSGZ=0
 S $P(ND,"^",2+PS)=$P(ND,"^",2+PS)+PSGY,$P(ND,"^",3+PS)=$P(ND,"^",3+PS)+COST,^PS(57.6,D0,1,D1,1,D2,1,D3,0)=ND L -^PS(57.6,D0,1,D1,1,D2,1,D3,0)
 G:PSGZ OS
 F  L +^PS(57.6,D0,1,D1,1,D2,1,0):1 I  S ND=$G(^PS(57.6,D0,1,D1,1,D2,1,0)) S:ND="" ND="^57.63P^" S $P(ND,"^",3)=D3,$P(ND,"^",4)=$P(ND,"^",4)+1 S ^(0)=ND L -^PS(57.6,D0,1,D1,1,D2,1,0) Q
 I '$D(^PS(57.6,D0,1,D1,1,D2,0)) F  L +^PS(57.6,D0,1,D1,1,0):1 I  S ND=$G(^PS(57.6,D0,1,D1,1,0)) S:ND="" ND="^57.62P" S $P(ND,"^",3)=D2,$P(ND,"^",4)=$P(ND,"^",4)+1 S ^(0)=ND L -^PS(57.6,D0,1,D1,1,0) Q
 ;
OS ;
 I PSGX!PSGY F  L +^PS(55,PN,5,O,1,DO,0):1 I  S PSGZ=$G(^PS(55,PN,5,O,1,DO,0)),$P(PSGZ,"^",5)=$P(PSGZ,"^",5)+PSGX,$P(PSGZ,"^",PS>0+6)=$P(PSGZ,"^",PS>0+6)+PSGY,^(0)=PSGZ L -^PS(55,PN,5,O,1,DO,0) Q
 N PSGSTRT S PSGSTRT=$P($G(^PS(55,PN,5,O,2)),"^",2)
 I PSGY,D0=+D0,D1=+D1,D2=+D2,D3=+D3 S:PS PSGY=-PSGY,COST=-COST D ENPLF^PSGAMSA(PN,O,D3,PSGY,COST,1,D1,D2,D0) S X="ECXUD1" X ^%ZOSF("TEST") I  S ECUD=PN_"^"_D0_"^"_D3_"^"_PSGY_"^"_D1_"^"_D2_";200^"_COST_"^"_PSGSTRT_"^"_$G(O) D ^ECXUD1
 S $P(PLR,"^",4)=1,^PS(53.5,G,1,PN,1,$P(PD,"^",2),1,$P(DD,"^",2),0)=PLR
 Q
 ;
GD1 ; get next (second) level (ward) in 57.6
 S WH=WD,D1=$O(^DIC(42,"B",WD,0)) S:'D1 D1="999Z" Q:$D(^PS(57.6,D0,1,D1))
 F  L +^PS(57.6,D0,1,0):1 I  S ND=$G(^PS(57.6,D0,1,0)) S:ND="" ND="^57.61PA" S $P(ND,"^",3)=D1 S:'$D(^(D1)) $P(ND,"^",4)=$P(ND,"^",4)+1 S ^(0)=ND,^(D1,0)=D1 L -^PS(57.6,D0,1,0) Q
 Q
 ;
EN ; action starts here
 N G,T,W,R,P,S,PD,DD,DDRG D NOW^%DTC S PSGDT=%,G=0 K C,^TMP("PSGNCF",$J)
 F  S G=$O(^PS(53.5,"AF",G)) Q:'G  S PSGPLTND=$G(^PS(53.5,G,0)) K:PSGPLTND="" ^PS(53.5,"AF",G) I PSGPLTND]"" I $$LOCK^PSGPLUTL(G,"PSGPL") D  D UNLOCK^PSGPLUTL(G,"PSGPL")
 .S WSF=$P(PSGPLTND,"^",7),D0=$S($P(PSGPLTND,"^",3):$P($P(PSGPLTND,"^",3),"."),1:DT)
 .I '$D(^PS(57.6,D0)) F  L +^PS(57.6,0):1 I  S ND=$G(^(0)) S:ND="" ND="UNIT DOSE PICK LIST STATS^57.6D" S $P(ND,"^",3)=D0,$P(ND,"^",4)=$P(ND,"^",4)+1,^(0)=ND,^(D0,0)=D0 L -^PS(57.6,0) Q
 .S T="",PSGPLFF=1
 .F  S T=$O(^PS(53.5,"AC",G,T)) Q:T=""  S (WH,W)="" F  S (W,WD)=$O(^PS(53.5,"AC",G,T,W)) Q:W=""  S R="" D:'WSF GD1 F  S R=$O(^PS(53.5,"AC",G,T,W,R)) Q:R=""  S P="" F  S P=$O(^PS(53.5,"AC",G,T,W,R,P)) Q:P=""  D
 ..S PN=$P(P,"^",2),(DD,PD)="",S="A" S:WSF WD=$P(^PS(53.5,G,1,PN,0),"^",3) D:WD'=WH&WSF GD1
 ..F  S S=$O(^PS(53.5,"AC",G,T,W,R,P,S)) Q:("Z"[S)!(S="NO ORDERS")  F  S PD=$O(^PS(53.5,"AC",G,T,W,R,P,S,PD)) Q:PD=""  S O=+$P($G(^PS(53.5,G,1,PN,1,$P(PD,"^",2),0)),"^"),D2=$P($G(^PS(55,PN,5,O,0)),"^",2) S:'D2 D2="999Z" D
 ...F  S DD=$O(^PS(53.5,"AC",G,T,W,R,P,S,PD,DD)) Q:(DD="")!(DD="NO DISPENSE DRUG")  S PLR=$G(^PS(53.5,G,1,PN,1,$P(PD,"^",2),1,$P(DD,"^",2),0)) Q:PLR=""  D:'$P(PLR,"^",4) FILE
 .I PSGPLFF S $P(^PS(53.5,G,0),"^",5)=2,^PS(53.5,"AO",+$P(PSGPLTND,"^",2),$P(PSGPLTND,"^",3),G)="" K ^PS(53.5,"AF",G)
 ;
 I $D(^TMP("PSGNCF",$J,"B")) D ^PSGPLFM
 ;
DONE ;
 K %,AM,C,COST,D0,D1,D2,D3,DO,ECUD,ND,O,PIN,PLR,PN,PS,PSGPLFF,PSGPLTND,Q,WD,WH,WSF,PSGX,PSGY,PSGZ Q
