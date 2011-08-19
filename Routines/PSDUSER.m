PSDUSER ;BIR/LTL- MFI - NDES USERS Message builder for HL7 ; 16 Aug 95
 ;;3.0; CONTROLLED SUBSTANCES ;**18**;13 Feb 97
 N DIC,DIR,DIRUT,DTOUT,DUOUT,PSD,PSDOUT,X,Y
PIC S DIC="^VA(200,",DIC(0)="AEMQ"
 S DIC("S")="I $S('$P($G(^(0)),U,11):1,$P($G(^(0)),U,11)>DT:1,1:0)"
 F  S DIC("W")="W ""  USER ID:  "",Y,""  "",$P($G(^DIC(3.1,+$P($G(^VA(200,Y,0)),U,9),0)),U)" D ^DIC Q:Y<1  S PSD($P(Y,U,2))=+Y_U_$P($G(^VA(200,+Y,.13)),U)
 K DIC Q:$D(DTOUT)!($D(DUOUT))!($O(PSD(0))']"")
 S PSD(1)=$O(PSD(0)) G:$O(PSD(PSD(1)))']"" HL
PRI S DIR(0)="Y",DIR("A")="Would you like to print a list of the names you are about to transmit",DIR("B")="Yes"
 S DIR("?")="You will be able to add or remove names from the list after reviewing"
 W ! D ^DIR K DIR Q:$D(DIRUT)  G:Y=0 HL
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q" W ! D ^%ZIS Q:POP
 I $D(IO("Q")) N ZTIO,ZTDTH,ZTSK S ZTRTN="Q^PSDUSER",ZTDESC="CS Print User List for NDES interface",ZTSAVE("PSD*")="" D ^%ZTLOAD,HOME^%ZIS G HL
Q N LN,PG S (PG,PSDOUT)=0 D HEADER S PSD=1
 F  S PSD=$O(PSD(PSD)) Q:PSD']""  D:$Y+2>IOSL HEADER Q:PSDOUT  W !,PSD,?32,+PSD(PSD),?42,$P(PSD(PSD),U,2)
 Q
HL N HLERR,HLEVN,HLNDAP,HLMTN,HLFS,HLECH,HLSDATA,HLSDT,HLSEC,HLCHAR,HLDA,HLDAN,HLDAP,HLDT,HLDT1,HLNDAP0,HLPID,HLQ,HLVER
 S HLNDAP="PSD-NDES" D INIT^HLTRANS I $D(HLERR) D KILL^HLTRANS Q
 S HLMTN="MFN",HLEVN=1,HLSDT=DT
MFI S ^TMP("HLS",$J,HLSDT,1)="MFI"_HLFS_200_$E(HLECH)_"NEW PERSON"_HLFS_"PSD-CS"_HLFS_"UPD"_HLFS_HLDT1_HLFS_HLFS_"AL",PSD=0,PSD(1)=2
MFE F  S PSD=$O(PSD(PSD)) Q:PSD']""  S ^TMP("HLS",$J,HLSDT,PSD(1))="MFE"_HLFS_"MUP"_HLFS_HLFS_HLFS_PSD(PSD)_$E(HLECH)_PSD,PSD(1)=PSD(1)+1
SEND D EN^HLTRANS Q
HEADER I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task#",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1
 W:$Y @IOF S $P(LN,"-",81)="",PG=PG+1
 W !,"User List for Narcotic Dispensing Equipment System",?70
 W "Page:  ",PG,!,LN,!?5,"NAME",?32,"USER ID",?42,"PHONE NUMBER",!,LN
