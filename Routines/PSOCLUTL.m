PSOCLUTL ;BHAM ISC/DMA - utilities for clozapine reporting system ; 12/22/92
 ;;7.0;OUTPATIENT PHARMACY;**28,56,122,222,268**;DEC 1997;Build 9
 ;External reference ^YSCL(603.01 supported by DBIA 2697
 ;External reference ^PS(55 supported by DBIA 2228
 ;
REG ; register patient
 S DIC=55,DLAYGO=55,DIC(0)="AEQL",DIC("A")="Select patient to register: " D ^DIC K DIC G END:Y<0 S PSO1=+Y,PSONAME=$P(^DPT(PSO1,0),"^") K DLAYGO
 D:$P($G(^PS(55,PSO1,0)),"^",6)'=2 EN^PSOHLUP(PSO1)
 I '$D(^YSCL(603.01,"C",PSO1)) W !!,PSONAME_" has not been authorized for Clozapine",!,"by the NCCC in Dallas.  Contact the NCCC in Dallas for authorization." D OVER G:'$G(%) REG S JADOVER=""
 I $P($G(^PS(55,PSO1,"SAND")),"^")]"" S PSO4=^("SAND") W !!,PSONAME_" is already registered with number "_$P(PSO4,"^"),!!,"Use the edit option to change registration data, or",!,"contact your supervisor",! G REG
NUMBER S DIR(0)="55,53" D ^DIR S PSO2=Y K DIR I $D(DIRUT) W !,"Not registered",! D END G REG
 I $D(^PS(55,"ASAND1",PSO2)),$O(^(PSO2,0))'=PSO1 W !,PSO2," is already assigned to ",$P(^DPT(+$O(^(0)),0),"^") W !,"Please contact your supervisor" D END G REG
 I '$D(JADOVER),'$D(^YSCL(603.01,"B",PSO2)) W !!,"The NCCC in Dallas has not authorized "_PSO2_" for useage",!,"at this facility.  Contact the NCCC in Dallas for authorization." D OVER G:'$G(%) END
 S DIR("A")="Pre-treatment or Active treatment? ",DIR(0)="S^P:PRE-TREATMENT;A:ACTIVE TREATMENT;",DIR("?")="Is this patient new to the Clozapine program, or has s/he been receiving treatment?" D ^DIR K DIR S PSO3=Y
 I $D(DIRUT) W !!,"Not registered" R X:10 K X G END
PHY S DIC="^VA(200,",DIC(0)="AEQMZ",DIC("A")="Provider responsible: ",DIC("S")="I $G(^VA(200,+Y,""PS""))]""""" D ^DIC K DIC I Y<0 W !!,"Not registered",!! R X:10 K X G END
 I $P($G(^VA(200,+Y,"PS")),"^",2)']"" W !!,"Only providers with DEA numbers entered in the New Person",!,"file can register patients in this program.",!! G PHY
 S PSO4=+Y K DIR,DIRUT,DUOUT,DTOUT
 S DIR("A",1)="OK to register "_PSONAME_" with number "_PSO2,DIR("A")="as a"_$S('PSO3:" new",1:"n ongoing")_" patient in this program "
 S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR I Y=0 G END
SAVE S DA=PSO1,DIE=55,DR="53////"_PSO2_";54////"_PSO3_";57////"_PSO4_";56////0;58////"_DT L +^PS(55,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W !!,$C(7),"Patient "_PSONAME_" is being edited by another user!  Try Later." G END
 D ^DIE L -^PS(55,DA)
END K %,%Y,C,D,D0,DA,DI,DQ,DFN,DIC,DIE,DR,PSO,PSO1,PSO2,PSO3,PSO4,PSOC,PSOLN,PSONAME,PSONO,PSOT,R,VAERR,XMDUZ,XMSUB,XMTEXT,Y,^TMP($J),^TMP("PSO",$J) Q
 Q
 ;
FACILITY ;Enter facility DEA number to set up clozapine system
 ;this entry point is no longer used.  this functionality was taken over
 ;by the mental health package with the release of YS*5.01*18
 ;W ! S DIC=59,DIC(0)="AEQM",DIC("A")="Select site to participate in clozapine program : " D ^DIC G END:Y<0
 ;S DIE=DIC,DA=+Y,DR="1R;2R;" L +^PS(59,DA) D ^DIE L -^PS(59,DA) G FACILITY
 Q
 ;
 ;
AGAIN ; re-enter patient - new number, status and provider
 S DIC=55,DIC(0)="AEQM",DIC("A")="Select clozapine patient : " D ^DIC K DIC G END:Y<0 S DA=+Y,PSO1=DA,PSONAME=$P(^DPT(DA,0),"^")
 I $P($G(^PS(55,DA,"SAND")),"^")="" W !,PSONAME_" is not registered.  Use the register option." G AGAIN
 I '$D(^YSCL(603.01,"C",PSO1)) W !!,PSONAME_" has not been authorized for Clozapine",!,"by the NCCC in Dallas.  Contact the NCCC in Dallas for authorization." D OVER G:'$G(%) AGAIN S JADOVER=""
 S DIR(0)="55,53" D ^DIR G END:$D(DIRUT) S PSO2=Y I $D(^PS(55,"ASAND1",PSO2)),$O(^(PSO2,0))'=PSO1 W !,PSO2," already assigned to ",$P(^DPT($O(^(0)),0),"^") G END
 I '$D(JADOVER),'$D(^YSCL(603.01,"B",PSO2)) W !!,"The NCCC in Dallas has not authorized "_PSO2_" for usage",!,"at this facility.  Contact the NCCC in Dallas for authorization." D OVER G:'$G(%) END
 ;S DIR(0)="55,54" D ^DIR G END:$D(DIRUT) S PSO3=Y
 S PSO3=$P(^PS(55,DA,"SAND"),"^",2)
 W !,$P(^DD(55,54,0),"^")_": "_$S(PSO3="A":"ACTIVE TREATMENT",PSO3="D":"DISCONTINUED",PSO3="H":"TREATMENT ON HOLD",1:"PRE-TREATMENT")
PHY1 ;
 S PSO4=$P(^PS(55,DA,"SAND"),"^",5),DIR(0)="55,57" D ^DIR G END:$D(DIRUT) I Y S PSO4=+Y
 I $P($G(^VA(200,PSO4,"PS")),"^",2)="" W !!,"Only providers with DEA numbers entered in the New Person",!,"file can register patients in this program.",!! G PHY1
 G SAVE
 ;
OVER ;allow registration of patients and clozapine numbers not yet authorized by the NCCC.
 K DIR W ! S DIR("A")="Do you want to over-ride this warning",DIR(0)="Y",DIR("B")="No" D ^DIR
 I Y D  S %=1
 .Q  S YSCLDATA(1)="An over-ride was authorize at "_$G(DUZ(2))_" for "_$S($D(PSONAME):PSONAME,1:$G(PSO2))_" by "_$P($G(^VA(200,DUZ,0)),"^")
 .S %H=$H D YMD^%DTC S XMDUN="NCC LOGGER",XMDUZ=.5,XMSUB=$G(DUZ(2))_" NCC ENROLLER ("_X_%_")",XMTEXT="YSCLDATA(",XMY("G.CLOZAPINE ROLL-UP@FORUM.VA.GOV")=""
 .D ^XMD K XMDUN,XMDUZ,XMER,XMREC,XRG,XMSUB,XMTEXT,XMY,XMZ,YSCLDATA
 K DIR,DIRUT,DUOUT Q
