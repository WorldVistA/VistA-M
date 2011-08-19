PSSPOIDT ;BIR/RTR/WRT-Date update in Orderable Item File ;02/14/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**19,29,38,57,68,69,82**;9/30/97
 ;Reference to ^PS(59 supported by DBIA #1976
 ;Passed in is Internal number of Pharmacy Orderable Item
 ;Changed all IIII's to II (PWC-4/5/04). Lines were too long to add new code.
EN(PSPOINT) ;
EN1 I $G(PSSCROSS) S:$G(PSSTEST) PSPOINT=PSSTEST I '$G(PSSTEST)!('$D(^PS(50.7,+$G(PSSTEST),0))) S:$D(ZTQUEUED) ZTREQ="@" Q
 N DA,DR,DIE,X,Y,ZZZ,ZZZA,ZZZS,PSUAPP,INACFLAG,PSSVAP,PSSVNAME,PSSVDOSE,INCDATE,PSACDATE,WWWW,PSLATEST,PSSORDIT
 Q:'$D(^PS(50.7,PSPOINT,0))
 I $P(^PS(50.7,PSPOINT,0),"^",4) D SET G ENT
 S PSSVNAME=$P($G(^PS(50.7,PSPOINT,0)),"^"),PSSVDOSE=$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^")
 S PSACDATE=DT,PSLATEST=0
 S INACFLAG=0
 F ZZZ=0:0 S ZZZ=$O(^PS(50.7,"A50",PSPOINT,ZZZ)) Q:'ZZZ  D
 .S PSUAPP=$P($G(^PSDRUG(ZZZ,2)),"^",3) I PSUAPP["O"!(PSUAPP["X")!(PSUAPP["I")!(PSUAPP["U") S PSSVAP=$P($G(^PSDRUG(ZZZ,"I")),"^") S:PSSVAP&(PSSVAP>PSLATEST) PSLATEST=PSSVAP I 'PSSVAP S INACFLAG=1
 .F ZZZA=0:0 S ZZZA=$O(^PSDRUG("A526",ZZZ,ZZZA)) Q:'ZZZA  I $D(^PS(52.6,ZZZA,0)) S PSSVAP=+$P($G(^PS(52.6,ZZZA,"I")),"^") D
 ..S:PSSVAP&(PSSVAP>PSLATEST) PSLATEST=PSSVAP I 'PSSVAP S INACFLAG=1
 .F ZZZS=0:0 S ZZZS=$O(^PSDRUG("A527",ZZZ,ZZZS)) Q:'ZZZS  I $D(^PS(52.7,ZZZS,0)) S PSSVAP=+$P($G(^PS(52.7,ZZZS,"I")),"^") D
 ..S:PSSVAP&(PSSVAP>PSLATEST) PSLATEST=PSSVAP I 'PSSVAP S INACFLAG=1
 I 'INACFLAG,'$P($G(^PS(50.7,PSPOINT,0)),"^",4) D
 .W:'$G(PSSCROSS)&($G(PSLATEST)'>DT) !!,PSSVNAME,"   ",PSSVDOSE,!,"is being marked inactive since no Additives, Solutions, or Dispense Drugs",!,"marked with an 'I', 'O' or 'U' in the Application Package Use field are matched",!,"to it.",!
 I 'INACFLAG,'$P($G(^PS(50.7,PSPOINT,0)),"^",4) S PSLATEST=$S('PSLATEST:DT,1:PSLATEST) S $P(^PS(50.7,PSPOINT,0),"^",4)=PSLATEST
 D SET G ENT
 Q
SUP(PSSORDIT) ;Supply at Orderable Item
ENT ;Enter here if coming from Inactive date, or from queued job
 I '$D(^PS(50.7,PSSORDIT,0)) S:$D(ZTQUEUED) ZTREQ="@" Q
 I $P(^PS(50.7,PSSORDIT,0),"^",3) D NONFORM G ENTZ
 N ZZZ,ZZZZ,PSSSUP,PSSSUYES,PSSSAP,PSSINA,PSSQDATE,PSSQYES,HLDCROSS
 D NONFORM,NONVA
 S PSSSUP=$P(^PS(50.7,PSSORDIT,0),"^",9),(PSSSUYES,PSSQYES)=0 F ZZZ=0:0 S ZZZ=$O(^PS(50.7,"A50",PSSORDIT,ZZZ)) Q:'ZZZ!(PSSQYES)  D
 .I $P($G(^PSDRUG(ZZZ,0)),"^",3)["S" S PSSSAP=$P($G(^(2)),"^",3),PSSINA=$P($G(^("I")),"^") D
 ..I PSSSAP["O"!(PSSSAP["I")!(PSSSAP["U")!(PSSSAP["X") I 'PSSINA S (PSSQYES,PSSSUYES)=1 Q
 ..I PSSSAP["O"!(PSSSAP["I")!(PSSSAP["U")!(PSSSAP["X") I +PSSINA>DT S PSSQDATE($E(PSSINA,1,7))="",PSSSUYES=1
 I 'PSSSUP,PSSSUYES S $P(^PS(50.7,PSSORDIT,0),"^",9)=1 W:'$G(PSSCROSS) !!,"The supply indicator is now being set for the Orderable Item",!,$P(^PS(50.7,PSSORDIT,0),"^")_"   "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^"),!
 I PSSSUP,'PSSSUYES S $P(^PS(50.7,PSSORDIT,0),"^",9)="" W:'$G(PSSCROSS) !!,"The supply indicator is now being removed for the Orderable Item",!,$P(^PS(50.7,PSSORDIT,0),"^")_"   "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^"),!
 I 'PSSQYES,PSSSUYES,$O(PSSQDATE(0)) F ZZZZ=0:0 S ZZZZ=$O(PSSQDATE(ZZZZ)) Q:'ZZZZ  D
 .S ZTRTN="ENT^PSSPOIDT",ZTIO="",ZTDTH=ZZZZ_.01,ZTDESC="Supply update for Orderable Item",ZTSAVE("PSSORDIT")="" S HLDCROSS=$G(PSSCROSS) S PSSCROSS=1,ZTSAVE("PSSCROSS")="" D ^%ZTLOAD K:'$G(HLDCROSS) PSSCROSS
ENTZ I $G(PSSCROSS) D EN2^PSSHL1(PSSORDIT,"MUP")
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SET S PSSORDIT=PSPOINT
 Q
REST(PSSREST) ;Ask to reactivate or inactivate others
ASKQ K DIR W ! S DIR("A",1)="Do you want to "_$S(PSINORDE="I":"inactivate",1:"reactivate")_" all Drugs/Additives/Solutions",DIR("A")="that are matched to this Orderable Item?"
 S DIR(0)="SB^Y:YES;N:NO;L:LIST ALL DRUGS/ADDITIVES/SOLUTIONS",DIR("B")="N" D ^DIR K DIR Q:$D(DIRUT)!($D(DUOUT))!($D(DTOUT))
 ;I Y="L" H 1 D @$S($P(^PS(50.7,PSSREST,0),"^",3):"LADD",1:"LDIS") W:FLAG&($P(^PS(50.7,PSSREST,0),"^",3)) !!,"Nothing matched to this Orderable Item!",! G:FLAG QREST G ASKQ
 I Y="L" K PSSCXXX,PSSCOUT D LDIS W:'$G(PSSCXXX)&('$G(PSSCOUT)) !!,"Nothing matched to this Orderable Item.",! G:'$G(PSSCXXX)&('$G(PSSCOUT)) QREST K PSSCXXX,PSSCOUT G ASKQ
 I Y="Y" W !,"Please wait..",! D  W !,"Finished!",!
 .I $G(PSINORDE)="I" S PSIDATEX=$P($G(^PS(50.7,PSSREST,0)),"^",4) I PSIDATEX D
 ..F II=0:0 S II=$O(^PS(52.7,"AOI",PSSREST,II)) Q:'II  I $D(^PS(52.7,II,0)) S $P(^PS(52.7,II,"I"),"^")=PSIDATEX
 ..F II=0:0 S II=$O(^PS(52.6,"AOI",PSSREST,II)) Q:'II  I $D(^PS(52.6,II,0)) S $P(^PS(52.6,II,"I"),"^")=PSIDATEX
 .I $G(PSINORDE)="D" D
 ..F II=0:0 S II=$O(^PS(52.7,"AOI",PSSREST,II)) Q:'II  I $D(^PS(52.7,II,0)),$P($G(^("I")),"^") S $P(^PS(52.7,II,"I"),"^")=""
 ..F II=0:0 S II=$O(^PS(52.6,"AOI",PSSREST,II)) Q:'II  I $D(^PS(52.6,II,0)),$P($G(^("I")),"^") S $P(^PS(52.6,II,"I"),"^")=""
 .I $G(PSINORDE)="I" S PSIDATEX=$P($G(^PS(50.7,PSSREST,0)),"^",4) I PSIDATEX F II=0:0 S II=$O(^PSDRUG("ASP",PSSREST,II)) Q:'II  I $D(^PSDRUG(II,0)) S $P(^PSDRUG(II,"I"),"^")=PSIDATEX D:'$G(PSSHUIDG) DRG^PSSHUIDG(II) D
 ..N XX,DVER,DNSNAM,DNSPORT,DMFU S XX=""
 ..F XX=0:0 S XX=$O(^PS(59,XX)) Q:'XX  D
 ..S DVER=$$GET1^DIQ(59,XX_",",105,"I"),DMFU=$$GET1^DIQ(59,XX_",",105.2)
 ..I DVER="2.4" S DNSNAM=$$GET1^DIQ(59,XX_",",2006),DNSPORT=$$GET1^DIQ(59,XX_",",2007) I DNSNAM'=""&(DMFU="YES") D DRG^PSSDGUPD(II,"",DNSNAM,DNSPORT)
 .I $G(PSINORDE)="D" F II=0:0 S II=$O(^PSDRUG("ASP",PSSREST,II)) Q:'II  I $D(^PSDRUG(II,0)),$P($G(^PSDRUG(II,"I")),"^") S DA=II,DIE=50,DR="100///@" D ^DIE D:'$G(PSSHUIDG) DRG^PSSHUIDG(DA) D
 ..N XX,DVER,DNSNAM,DNSPORT,DMFU S XX=""
 ..F XX=0:0 S XX=$O(^PS(59,XX)) Q:'XX  D
 ..S DVER=$$GET1^DIQ(59,XX_",",105,"I"),DMFU=$$GET1^DIQ(59,XX_",",105.2)
 ..I DVER="2.4" S DNSNAM=$$GET1^DIQ(59,XX_",",2006),DNSPORT=$$GET1^DIQ(59,XX_",",2007) I DNSNAM'=""&(DMFU="YES") D DRG^PSSDGUPD(II,"",DNSNAM,DNSPORT)
 . K DA,DIE,DR
 K II,PSIDATEX
QREST K PSSCXXX,PSSCOUT Q
LDIS ;list dispense drugs
 N FLAG,PSSCFLAG,PSSCDATE,ZZ
 S FLAG=1,(PSSCOUT,PSSCXXX)=0 D DHEAD F ZZ=0:0 S ZZ=$O(^PSDRUG("ASP",PSSREST,ZZ)) Q:'ZZ!($G(PSSCOUT))  S FLAG=0 D:($Y+5)>IOSL DHEAD Q:$G(PSSCOUT)  I ZZ S PSSCXXX=1 W !,$P($G(^PSDRUG(ZZ,0)),"^") D DTE
 Q:$G(PSSCOUT)
 S (FLAG,PSSCFLAG)=0
 F ZZ=0:0 S ZZ=$O(^PS(52.6,"AOI",PSSREST,ZZ)) Q:'ZZ!($G(PSSCOUT))  D:($Y+5)>IOSL DHEAD Q:$G(PSSCOUT)  I ZZ D
 .S (PSSCFLAG,PSSCXXX)=1
 .W !,$P($G(^PS(52.6,ZZ,0)),"^"),?42,"(A)"
 .S PSSCDATE=$P($G(^PS(52.6,ZZ,"I")),"^") I PSSCDATE D DTEX
 Q:$G(PSSCOUT)
 ;I $G(PSSCFLAG) W !
 F ZZ=0:0 S ZZ=$O(^PS(52.7,"AOI",PSSREST,ZZ)) Q:'ZZ!($G(PSSCOUT))  D:($Y+5)>IOSL DHEAD Q:$G(PSSCOUT)  I ZZ D
 .W !,$P($G(^PS(52.7,ZZ,0)),"^"),?31,$P($G(^(0)),"^",3),?42,"(S)"
 .S PSSCDATE=$P($G(^PS(52.7,ZZ,"I")),"^") I PSSCDATE D DTEX
 Q
DHEAD I 'FLAG W ! K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR I 'Y S PSSCOUT=1 Q
 W @IOF W !,?6,"Orderable Item ->  ",$P($G(^PS(50.7,PSSREST,0)),"^"),!?6,"Dosage Form    ->  ",$P($G(^PS(50.606,+$P($G(^PS(50.7,PSSREST,0)),"^",2),0)),"^"),!!,"Dispense Drugs:"_$S('FLAG:" (continued)",1:""),!,"---------------"
 Q
DTE I $D(^PSDRUG(ZZ,"I")) S Y=$P(^PSDRUG(ZZ,"I"),"^") D DD^%DT W ?50,Y K Y
 Q
DTEX S Y=$G(PSSCDATE) D DD^%DT W ?50,$G(Y) K Y
 Q
NONFORM ;
 ;formulary status of Orderable Item
 Q:'$G(PSSORDIT)
 N PSNFX,PSNFX1,PSNFX2,PSNFXB
 S (PSNFX1,PSNFX2)=0
 S PSNFXB=$P($G(^PS(50.7,PSSORDIT,0)),"^",12)
 F PSNFX=0:0 S PSNFX=$O(^PS(50.7,"A50",PSSORDIT,PSNFX)) Q:'PSNFX  D
 .I $P($G(^PSDRUG(PSNFX,2)),"^",3)'["O",$P($G(^(2)),"^",3)'["I",$P($G(^(2)),"^",3)'["U",$P($G(^(2)),"^",3)'["X" Q
 .I $P($G(^PSDRUG(PSNFX,"I")),"^"),$P($G(^("I")),"^")'>DT Q
 .I $P($G(^PSDRUG(PSNFX,0)),"^",9)=1 S PSNFX1=1 Q
 .S PSNFX2=1
 I PSNFX1,'PSNFX2 S $P(^PS(50.7,PSSORDIT,0),"^",12)=1
 I PSNFX2 S $P(^PS(50.7,PSSORDIT,0),"^",12)=""
 I $P($G(^PS(50.7,PSSORDIT,0)),"^",12)'=$G(PSNFXB),'$G(PSSCROSS) D
 .W !!,"The Formulary Status of the Pharmacy Orderable Item",!,$P($G(^PS(50.7,PSSORDIT,0)),"^")_"  "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^"),!,"has been changed to "_$S($P($G(^PS(50.7,PSSORDIT,0)),"^",12):"Non-Formulary.",1:"Formulary."),!
 Q
MSSG I '$G(PSSCROSS) W !!,"This Orderable Item is "_$S($P($G(^PS(50.7,PSSORDIT,0)),"^",12):"Non-Formulary.",1:"Formulary."),!
 Q
NONVA ; Evaluates the Non-VA Med Indicator of the Orderable Item
 N PSNVADG,PSNONVA,PSDRG
 ;
 Q:'$G(PSSORDIT)
 S PSNVADG=0,PSNONVA=$P($G(^PS(50.7,PSSORDIT,0)),"^",10),PSDRG=0
 F  S PSDRG=$O(^PS(50.7,"A50",PSSORDIT,PSDRG)) Q:'PSDRG!(PSNVADG)  D
 . I $P($G(^PSDRUG(PSDRG,"I")),"^"),$P($G(^("I")),"^")'>DT Q
 . I $P($G(^PSDRUG(PSDRG,2)),"^",3)["X" S PSNVADG=1
 ;
 I PSNVADG S $P(^PS(50.7,PSSORDIT,0),"^",10)=1
 I 'PSNVADG S $P(^PS(50.7,PSSORDIT,0),"^",10)=""
 ;
 I +$P($G(^PS(50.7,PSSORDIT,0)),"^",10)'=+PSNONVA,'$G(PSSCROSS) D
 . W !!,"The Pharmacy Orderable Item ",$P($G(^PS(50.7,PSSORDIT,0)),"^")
 . W !,"is ",$S('PSNONVA:"now",1:"no longer")," marked as a NON-VA MED Drug."
 Q
