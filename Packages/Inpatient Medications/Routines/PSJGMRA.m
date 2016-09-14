PSJGMRA ;BIR/MV - Retrieve and display Allergy data ;6 Jun 07  3:37 PM
 ;;5.0;INPATIENT MEDICATIONS;**181,270,260,252,257,281**;16 DEC 97;Build 113
 ;
 ; Reference to ^PS(50.605 is supported by DBIA 696.
 ; Reference to ^PSDRUG( is supported by DBIA 2192.
 ; Reference to ^TMP("GMRAOC" supported by DBIA 4848.
 ; Reference to GETDATA^GMRAOR supported by DBIA 4847.
 ; Reference to ORCHK2^GMRAOR supported by DBIA 2378.
 ; Reference to ^PSODGAL1 supported by DBIA 5764.
 ; Reference to ^PS(50.7 supported by DBIA 2180.
 ;
EN(DFN,PSJDD) ;
 ;DFN - Patient IEN
 ;PSJDD - ^PSDRUG IEN
 Q:'+$G(DFN)
 Q:'+$G(PSJDD)
 N PTR,GMRAING,PSJACK,PSJCLCNT,PSJFLG,PSJVACL,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,PSJNEW,X,Y,PSODRUG,PSODFN,PSJAOC
 K DIC,PSJVACL,^TMP("GMRAOC",$J),^TMP($J,"PSJCLS"),^TMP("PSJDAI",$J)
 S DIC=50,DIC(0)="MQZV",X=PSJDD D ^DIC K DIC Q:Y=-1
 S PSODRUG("IEN")=PSJDD,PSODRUG("VA CLASS")=$P(Y(0),"^",2),PSODRUG("NAME")=$P(Y(0),"^")
 S:+$G(^PSDRUG(+Y,2)) PSODRUG("OI")=+$G(^(2)),PSODRUG("OIN")=$P(^PS(50.7,+$G(^(2)),0),"^")
 S PSODRUG("NDF")=$S($G(^PSDRUG(PSJDD,"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)
 ;changed in psj*5*260
 S PSJAOC=1,PSODFN=DFN D ^PSODGAL1
 S:$G(PSGORQF) VALMBCK="R" G END
 ;
 S PSJACK=0
 S PTR=$P($G(^PSDRUG(PSJDD,"ND")),U)_"."_$P($G(^PSDRUG(PSJDD,"ND")),U,3)
 I +PTR S PSJACK=$$NDF()
 S PSJCLCNT=$$CLASS()
 D DISP
END ;
 K ^TMP("GMRAOC",$J),^TMP($J,"PSJCLS")
 Q
NDF() ;Process NDF drug
 NEW PSJLP
 S PSJACK=0
 K ^TMP("GMRAOC",$J)
 S PSJACK=$$ORCHK2^GMRAOR(DFN,"DR",PTR)
 Q PSJACK
CLASS() ;
 NEW PSJLEN,PSJLOC,PSJCLCHK,PSJCLNM,PSJDDCL,INVCL,INVCNT
 S PSJDDCL=$P($G(^PSDRUG(+PSJDD,0)),U,2)
 S PSJLEN=4,PSJCLCNT=0
 I $E(PSJDDCL,1,4)="CN10" S PSJLEN=5 ;look at 5 chars if ANALGESICS
 ;
 K GMRADRCL,^TMP("GMRAOC",$J,"APC"),^TMP($J,"PSJCLS")
 D GETDATA^GMRAOR(DFN)
 I '$D(^TMP("GMRAOC",$J,"APC")) Q 0
 ;
 S PSJVACL="" F  S PSJVACL=$O(^TMP("GMRAOC",$J,"APC",PSJVACL)) Q:PSJVACL=""  D
 .;*PSJ*5*270 - Check for invalid drug class, print warning message
 . S PSJLOC=^TMP("GMRAOC",$J,"APC",PSJVACL),PSJCLNM=$P($G(^PS(50.605,+$O(^PS(50.605,"B",PSJVACL,0)),0)),U,2)
 . I $G(PSJCLNM)="" S INVCL(PSJVACL)="" Q
 . S PSJVACL(PSJVACL)=PSJVACL_U_PSJCLNM_" ("_PSJLOC_")"
 . S PSJCLCNT=PSJCLCNT+1
 I $D(INVCL) D
 . W $C(7),!!,"WARNING: The following drug class does not exist in the VA DRUG CLASS file",!
 . W "         (#50.605).  Please do a manual Drug-Allergy order check and notify",!
 . W "         the pharmacy ADPAC for follow up.",!
 . S INVCNT="" F  S INVCNT=$O(INVCL(INVCNT)) Q:INVCNT=""  W !,"VA Drug Class: ",INVCNT
 . W ! S DIR("A")="Press Return to continue",DIR(0)="E",DIR("?")="Press Return to continue" D ^DIR K DIR W !
 ;
 S PSJCLCHK=0,PSJVACL="" F  S PSJVACL=$O(PSJVACL(PSJVACL)) Q:PSJVACL=""  D
 .I $E(PSJDDCL,1,PSJLEN)=$E(PSJVACL,1,PSJLEN) D
 .. S PSJCLCHK=PSJCLCHK+1
 .. S ^TMP($J,"PSJCLS",PSJCLCHK)=PSJVACL_" "_$P(PSJVACL(PSJVACL),"^",2)
 K ^TMP("GMRAOC",$J)
 Q PSJCLCHK
DISP ;
 NEW PSJLOC,PSJNIEN,PSJNM,PSJVACL,X,PSJX
 S PSJFLG=0
 S PSJX=$O(^TMP("GMRAOC",$J,"APC",""))
 I '$G(PSJACK)&'$G(PSJCLCNT) Q
 S PSJFLG=1
 W $C(7),!!,"A Drug-Allergy Reaction exists for this medication and/or class!"
 W !!,?3,"Drug: "_$P($G(^PSDRUG(PSJDD,0)),"^")
 I PSJACK D
 . S PSJX=""
 . F X=0:0 S X=$O(GMRAING(X)) Q:'X  D
 .. S PSJX=PSJX_$S(PSJX="":"",1:", ")_GMRAING(X)
 . I PSJX]"" W !?6,"Ingredients: " D MYWRITE^PSJMISC(PSJX,19,75)
 D:PSJCLCNT DISPCL
 D:(PSJFLG&'$D(PSJDGCK)) INTERV("ALLERGY")
 Q
DISPCL ;Display class(es)
 NEW PSJX,X
 Q:'$D(^TMP($J,"PSJCLS"))
 S PSJX=""
 S PSJVACL="" F  S PSJVACL=$O(^TMP($J,"PSJCLS",PSJVACL)) Q:PSJVACL=""  D
 . S PSJX=PSJX_$S(PSJX="":"",1:", ")_^TMP($J,"PSJCLS",PSJVACL)
 . S PSJFLG=1
 I PSJX]"" D
 . W !,?6,"Drug Class: "
 . D MYWRITE^PSJMISC(PSJX,19,75)
 Q
 ;
INTERV(PSJRXREQ,PSJDD1) ;Prompt if user to log an intervention for significant interaction
 ;PSPRXREQ - intervention type
 ;PSJDD1 - Prospective drug name
 NEW DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y,X
 I $G(PSGORQF)=1 Q
 S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to Intervene? ",DIR("B")=$S($G(PSJRXREQ)="ALLERGY":"YES",1:"NO")
 I $G(PSJDD1)]"" S DIR("A")="Do you want to Intervene with "_PSJDD1_"? "
 W ! D ^DIR
 S DIR("?",1)="Answer 'YES' if you DO want to enter an intervention for this medication,"
 S DIR("?")="       'NO' if you DON'T want to enter an intervention for this medication,"
 I Y S PSGP=DFN D ^PSJRXI W !
 Q 
RINTERV(PSJRXREQ,PSJDD1) ;Prompt user to log an intervention for critical interaction
 ;PSPRXREQ - intervention type
 ;PSJDD1 - Prospective drug name
 NEW DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y,X
 K PSGORQF
 S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to Continue? ",DIR("B")="NO"
 I $G(PSJDD1)]"" S DIR("A")="Do you want to Continue with "_PSJDD1_"? "
 S DIR("?",1)="Enter 'NO' if you wish to exit without continuing with the order,",DIR("?")="or 'YES' to continue with the order entry process."
 D ^DIR
 I 'Y S PSGORQF=1 S VALMBCK="R" Q
 I Y S PSGP=DFN D ^PSJRXI W !
 Q
 ;
INST(PSJALCO) ;Find Institution for order
 N PSJALCR,PSJALCMC,PSJALCCL,PSJALCWA,PSJALCIV,PSJALCIN,PSJALCND,PSJALCP1,PSJALCP2
 I PSJALCO="" Q +$$SITE^VASITE(DT)
 S PSJALCR=""
 ;
 I PSJALCO["P" D  G INSTM
 .S PSJALCCL=$P($G(^PS(53.1,+PSJALCO,"DSS")),"^") I PSJALCCL S PSJALCND=$G(^SC(PSJALCCL,0)) D  Q
 ..S PSJALCIN=$P(PSJALCND,"^",4) I PSJALCIN S PSJALCR=PSJALCIN Q
 ..S PSJALCMC=$P(PSJALCND,"^",15)
 .S PSJALCIV=$P($G(^PS(53.1,+PSJALCO,8)),"^",8) I PSJALCIV D  Q
 ..S PSJALCMC=$P($G(^PS(59.5,+PSJALCIV,0)),"^",4) Q
 .D INSTW
 ;
 I PSJALCO["U" S PSJALCP1=$P(PSJALCO,"U"),PSJALCP2=$P(PSJALCO,"U",2) D  G INSTM
 .S PSJALCCL=$P($G(^PS(55,PSJALCP1,5,PSJALCP2,8)),"^") I PSJALCCL S PSJALCND=$G(^SC(PSJALCCL,0)) D  Q
 ..S PSJALCIN=$P(PSJALCND,"^",4) I PSJALCIN S PSJALCR=PSJALCIN Q
 ..S PSJALCMC=$P(PSJALCND,"^",15)
 .D INSTW
 ;
 I PSJALCO["V" S PSJALCP1=$P(PSJALCO,"V"),PSJALCP2=$P(PSJALCO,"V",2) D  G INSTM
 .S PSJALCCL=$P($G(^PS(55,PSJALCP1,"IV",PSJALCP2,"DSS")),"^") I PSJALCCL S PSJALCND=$G(^SC(PSJALCCL,0)) D  Q
 ..S PSJALCIN=$P(PSJALCND,"^",4) I PSJALCIN S PSJALCR=PSJALCIN Q
 ..S PSJALCMC=$P(PSJALCND,"^",15)
 .S PSJALCIV=$P($G(^PS(55,PSJALCP1,"IV",PSJALCP2,2)),"^",2) I PSJALCIV D  Q
 ..S PSJALCMC=$P($G(^PS(59.5,+PSJALCIV,0)),"^",4) Q
 .D INSTW
 ;
 Q +$$SITE^VASITE(DT)
INSTM ;
 I PSJALCR Q PSJALCR
 I $G(PSJALCMC) Q +$$SITE^VASITE(DT,PSJALCMC)
 Q +$$SITE^VASITE(DT)
 ;
INSTW ;
 S PSJALCWA=$$INSTV I PSJALCWA D
 .S PSJALCCL=$P($G(^DIC(42,+PSJALCWA,44)),"^") I PSJALCCL D  Q:PSJALCR
 ..S PSJALCND=$G(^SC(PSJALCCL,0)) S PSJALCIN=$P(PSJALCND,"^",4) I PSJALCIN S PSJALCR=PSJALCIN Q
 ..S PSJALCMC=$P(PSJALCND,"^",15)
 .I '$G(PSJALCMC) S PSJALCMC=$P($G(^DIC(42,+PSJALCWA,0)),"^",11)
 Q
 ;
INSTV() ;Retrieve Ward
 I '$G(DFN) Q 0
 N VAHOW,VAROOT,VAINDT,VAIN,VAERR
 D INP^VADPT
 Q +$G(VAIN(4))
