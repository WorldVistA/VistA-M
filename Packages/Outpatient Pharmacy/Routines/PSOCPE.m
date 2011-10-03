PSOCPE ;BIR/BAB - PHARMACY COPAY APPLICATION UTILITIES FOR IB ;10/26/92
 ;;7.0;OUTPATPSOCT PHARMACY;**26,71,85,114,157,219,268,225,303**;DEC 1997;Build 19
 ;
 ;REF/IA
 ;^XUSEC/10076
 ;^PSDRUG(/221
 ;Routine initially released as part of the copayment enhancement.
 ;called from PSOLBL
INV ;         Entry point from PSOCP - Prints one copay invoice
 I '$D(PSOCPN)!($G(RXP)) Q
 S PSOCPBAR=0
 I $D(PSOBARS),PSOBARS S PSOCPBAR=1
 D DEM^VADPT S Y=DT X ^DD("DD") S EDT=Y
 W ?54,"PRESCRIPTION COPAYMENT INFORMATION"
 W !!,?54,VADM(1)," ",VA("PID")," ",EDT
 S PSZ1=0,PSZ2="",PSOCPBN=$P(VADM(2),"^"),PSOCPBN=$S(PSOCPBN]"":PSOCPBN,1:"Unavailable")
 ;I '$G(PSOCPN) S PSOCPN=$P(^PSRX(RX,0),U,2)
 I PSOCPBAR,(PSOCPBN]"") S X="S",X2=PSOCPBN W !,?54,@PSOBAR1,PSOCPBN,@PSOBAR0
 E  W !
 W !,?54,"The following prescriptions are"
 W !,?54,"eligible for prescription copayment.",!!
DRUG S PSZ2="" F  S PSZ2=$O(^TMP($J,"PSOCP",PSOCPN,PSZ2)) Q:PSZ2']""  S PSZ=^(PSZ2) D PRT
NAR ; Print narrative from site parameter file
 K ^UTILITY($J,"W") S DIWL=55,DIWR=99,DIWF="" W !
 G:'$D(^PS(59,PSOSITE,4,0)) END
 G:$P(^PS(59,PSOSITE,4,0),"^",3)'>0 END
 F PSO9=0:0 S PSO9=$O(^PS(59,PSOSITE,4,PSO9)) G:'PSO9 P1 I $D(^PS(59,PSOSITE,4,PSO9,0)) S X=^(0) D ^DIWP
P1 D ^DIWW
 K DIWF,DIWL,DIWR,PSO9
END ;
 W @IOF
 K ^TMP($J,"PSOCP",PSOCPN),PSOCPBAR,PSOCPBN,PSZ1,PSZ2,PSOCPN,DIWF,DIWL,DIWR,PSO9
 Q
PRT ;
 W ?54,PSZ2
 W ?72," ",$P(^TMP($J,"PSOCP",PSOCPN,PSZ2),"^",3)," ","Days Supply",!
 W ?56,$E($P(^TMP($J,"PSOCP",PSOCPN,PSZ2),U,2),1,45),!
 Q
XMPT ;   Entry point for menu option to select copay exemption
 N PSORXPNM,PSORXPRE,PSOCPEDA
 I '$D(PSOPAR) D ^PSOLSET G XMPT
 W ! S (DIC,DIE)="^PS(53,",DIC(0)="AEQMZ" D ^DIC K DIC G:Y<0 QUIT
 G:$D(DTOUT) QUIT
 S PSORXPRE=$P($G(^PS(53,+$G(Y),0)),"^",7)
 S PSORXPNM=$P($G(^PS(53,+$G(Y),0)),"^")
 S DA=+Y,DR="15" L +^PS(53,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W !!,PSORXPNM_" is locked by another user. Try Later!" W ! D PAGE G QUIT
 W ! D ^DIE
 I PSORXPRE,$P($G(^PS(53,DA,0)),"^",7) W !!,"All Rx's entered with this Rx Patient Status will be EXEMPT from Copayment.",! D PAGE L -^PS(53,DA) G QUIT
 I 'PSORXPRE,'$P($G(^PS(53,DA,0)),"^",7) W !!,"All Rx's entered with this Rx Patient Status will NOT be exempt from Copayment.",! D PAGE L -^PS(53,DA) G QUIT
 D WARN L -^PS(53,DA)
QUIT K PSORXPRE,DIE,DIC,DA,DR,X,C,Y
 Q
PAGE ;
 I '$G(DUZ("AUTO")) K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
WARN ;
 S PSOCPEDA=$G(DA)
 W !!?28,"**** WARNING ****",!
 I 'PSORXPRE W !,"By setting the Exempt from Copayment for the Rx Patient Status of",!,PSORXPNM," to 'YES', every prescription entered",!,"with this Rx Patient Status will NOT be charged a Copayment.",!
 I PSORXPRE W !,"By setting the EXEMPT FROM COPAYMENT for the Rx Patient Status of ",!,PSORXPNM," to 'NO', prescriptions entered with this Rx",!,"Patient Status from this point on will NOT be exempt from Copayment.",!
 W !,"A mail message will be sent to PSORPH and PSO COPAY Key holders informing",!,"them of your change."
 W ! K DIR S DIR(0)="Y",DIR("A")="Are you sure you want to do this",DIR("B")="Y" D ^DIR K DIR
 I $G(Y) D  D MAIL G WARNX
 .I 'PSORXPRE W !!,"Setting ",PSORXPNM," Rx Patient Status to Exempt from Copayment." Q
 .W !!,"Setting Exempt from Copayment to 'NO' for the ",PSORXPNM,!,"Rx Patient Status."
 I 'PSORXPRE W !!,"No action taken." S $P(^PS(53,PSOCPEDA,0),"^",7)=0 H 1
 I PSORXPRE W !!,"No action taken." S $P(^PS(53,PSOCPEDA,0),"^",7)=1 H 1
WARNX W ! D PAGE
 S DA=$G(PSOCPEDA) K PSOCPEDA
 Q
MAIL ;
 K PSOTXT,PSOCFN,PSODCPA
 I $G(DUZ) S DIC=200,DR=".01",DA=DUZ,DIQ(0)="E",DIQ="PSODCPA(" D EN^DIQ1 S PSOCFN=$G(PSODCPA(200,DA,.01,"E")) K PSODCPA,DIC,DIQ,DR
 I 'PSORXPRE S PSOTXT(1,0)="The "_PSORXPNM_" Rx Patient Status has been marked as",PSOTXT(2,0)="Exempt from Copayment by "_$G(PSOCFN)_".",PSOTXT(3,0)="Every prescription with this Rx Patient Status will not be charged a Copayment."
 I PSORXPRE S PSOTXT(1,0)="The Exempt from Copayment status has been removed from the",PSOTXT(2,0)=PSORXPNM_" Rx Patient Status by "_$G(PSOCFN)_".",PSOTXT(3,0)="Prescriptions entered with this Rx Patient Status will not be exempt from"
 I PSORXPRE S PSOTXT(4,0)="Copayment."
 F PSOCXPDA=0:0 S PSOCXPDA=$O(^XUSEC("PSORPH",PSOCXPDA)) Q:'PSOCXPDA  S XMY(PSOCXPDA)=""
 F PSOCXPDA=0:0 S PSOCXPDA=$O(^XUSEC("PSO COPAY",PSOCXPDA)) Q:'PSOCXPDA  S XMY(PSOCXPDA)=""
 I $G(DUZ) S XMY(DUZ)=""
 S XMSUB="Exempt from Copayment",XMTEXT="PSOTXT(",XMDUZ="Outpatient Pharmacy" D ^XMD
 K PSOTXT,PSOCXPDA,XMDUZ,PSOCFN,XMTEXT,XMSUB,XMY
 Q
 ;
MAIL2 ; SEND MAIL TO PHARMACIST, PROVIDER, AND HOLDERS OF PSO COPAY KEY
 N PSOC,PSOTXT,X
 K XMY
 S XMSUB="PRESCRIPTION QUESTIONS REVIEW NEEDED"
 S XMDUZ="Outpatient Pharmacy Package"
 S PSOTXT(1)=" "
 S DFN=+$P($G(^PSRX(RXP,0)),"^",2) D PID^VADPT
 S PSODIV=$P($G(^PSRX(RXP,2)),"^",9) S:PSODIV'="" XMSUB=XMSUB_" ("_$P($G(^PS(59,PSODIV,0)),"^",6)_")",PSODIV=$P($G(^PS(59,PSODIV,0)),"^",1) ; ADDED DIVISION NUMBER TO SUBJECT LINE - PATCH 85
 S PSOTXT(2)=$P($G(^DPT($P(^PSRX(RXP,0),"^",2),0)),"^",1)_"  ("_$G(VA("BID"))_")"_"    "_PSODIV
 D ELIG
 S PSOTXT(PSOC)="Rx# "_$P(^PSRX(RXP,0),"^",1)_" ("_PSOREF_")    "_$S('$G(^PSRX(RXP,"IB")):"NO COPAY",1:"COPAY")
 S PSOC=PSOC+1
 S DRG=+$P(^PSRX(RXP,0),"^",6)
 S PSOC=PSOC+1
 S PSOTXT(PSOC)=$P($G(^PSDRUG(DRG,0)),"^",1)
 S PSOC=PSOC+1
 S PSOTXT(PSOC)=" "
 S PSOC=PSOC+1
 S PSOTXT(PSOC)="Due to a change in criteria, additional information listed below is needed"
 S PSOC=PSOC+1
 S PSOTXT(PSOC)="to determine the final VA copay and/or insurance billable status for this Rx"
 S PSOC=PSOC+1
 S PSOTXT(PSOC)="so that appropriate action can be taken by pharmacy personnel."
 S PSOC=PSOC+1
 S PSOTXT(PSOC)=" "
 S PSOC=PSOC+1
 F EXMT="SC","CV","AO","IR","EC","SHAD","MST","HNC" I $D(PSOTG(EXMT)) D
 . I PSOTG(EXMT)'="" Q
 . S PSOLTAG="REL"_EXMT
 . S PSOQUES=$P($T(@PSOLTAG),";",2) I PSOQUES="" Q
 . S PSOC=PSOC+1,PSOTXT(PSOC)=PSOQUES
 . S PSOQUES=$P($T(@PSOLTAG),";",2) I PSOQUES="" Q
 S PSOC=PSOC+1,PSOTXT(PSOC)=" "
 S PSOC=PSOC+1,PSOTXT(PSOC)="This message has been sent to the provider of record, the pharmacist who"
 S PSOC=PSOC+1,PSOTXT(PSOC)="finished the prescription order, and all holders of the PSO COPAY key."
 S PSOC=PSOC+1,PSOTXT(PSOC)=" "
 S PSOC=PSOC+1,PSOTXT(PSOC)="Providers:"
 S PSOC=PSOC+1,PSOTXT(PSOC)="Please respond with your answer to the question(s) as a reply to this"
 S PSOC=PSOC+1,PSOTXT(PSOC)="message. The prescription will be updated by the appropriate staff."
 S PSOC=PSOC+1,PSOTXT(PSOC)=" "
 S PSOC=PSOC+1,PSOTXT(PSOC)="Staff assigned to update the Prescription responses:"
 S PSOC=PSOC+1,PSOTXT(PSOC)="Please use the RESET COPAY STATUS/CANCEL CHARGES option to enter the responses"
 S PSOC=PSOC+1,PSOTXT(PSOC)="to the questions above, which may result in a Rx copay status change and/or"
 S PSOC=PSOC+1,PSOTXT(PSOC)="the need to remove VA copay charges or may result in a charge to the patient's"
 S PSOC=PSOC+1,PSOTXT(PSOC)="insurance carrier."
 S PSOC=PSOC+1,PSOTXT(PSOC)=" "
 S PSOC=PSOC+1,PSOTXT(PSOC)="Note: The SC question is now asked for Veterans who are SC>49% in order to"
 S PSOC=PSOC+1,PSOTXT(PSOC)="determine if the Rx can be billed to a third party insurance. These Veterans"
 S PSOC=PSOC+1,PSOTXT(PSOC)="will NOT be charged a VA copay."
 S PSOC=PSOC+1,PSOTXT(PSOC)=" "
 S PSOC=PSOC+1,PSOTXT(PSOC)="Supply, nutritional and investigational drugs are not charged a VA copay"
 S PSOC=PSOC+1,PSOTXT(PSOC)="but could be reimbursable by third party insurance."
 ; S XMY() TO ALL THE RECIPIENTS
 I '$G(PSOREF) S XMY(+$P(^PSRX(RXP,0),"^",4))="" ; ORIGINAL
 I $G(PSOREF) S XMY(+$P(^PSRX(RXP,1,PSOREF,0),"^",17))="" ; REFILL
 I $G(^PSRX(RXP,"OR1")) I $P(^PSRX(RXP,"OR1"),"^",5)'="" S XMY($P(^PSRX(RXP,"OR1"),"^",5))=""
 F PSOCXPDA=0:0 S PSOCXPDA=$O(^XUSEC("PSO COPAY",PSOCXPDA)) Q:'PSOCXPDA  S XMY(PSOCXPDA)=""
 S XMTEXT="PSOTXT("
 D ^XMD K XMSUB,XMY,XMDUZ,XMTEXT,PSODIV,PSOCXPDA,PSOLTAG,PSOC,PSOQUES,PSOTG
 Q
 ;
ELIG D ELIG^VADPT S PSOC=3,PSOTXT(PSOC)="Eligibility: "_$P(VAEL(1),"^",2)_$S(+VAEL(3):"     SC%: "_$P(VAEL(3),"^",2),1:""),PSOC=PSOC+1
 N N,I,I1,PSDIS,PSCNT
 S N=0 F  S N=$O(VAEL(1,N)) Q:'N  S $P(PSOTXT(PSOC)," ",14)=$P(VAEL(1,N),"^",2),PSOC=PSOC+1
 S PSOTXT(PSOC)=" ",PSOC=PSOC+1,PSOTXT(PSOC)="Disabilities: "
 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  S I1=$S($D(^DPT(DFN,.372,I,0)):^(0),1:"") D:+I1
 .S PSDIS=$S($P($G(^DIC(31,+I1,0)),"^")]""&($P($G(^(0)),"^",4)']""):$P(^(0),"^"),$P($G(^DIC(31,+I1,0)),"^",4)]"":$P(^(0),"^",4),1:""),PSCNT=$P(I1,"^",2)
 .S:$L(PSOTXT(PSOC)_PSDIS_"-"_PSCNT_"% ("_$S($P(I1,"^",3):"SC",1:"NSC")_"), ")>80 PSOC=PSOC+1,$P(PSOTXT(PSOC)," ",14)=" "
 .S PSOTXT(PSOC)=$G(PSOTXT(PSOC))_PSDIS_"-"_PSCNT_"%("_$S($P(I1,"^",3):"SC",1:"NSC")_"), "
 S PSOC=PSOC+1 S PSOTXT(PSOC)=" ",PSOC=PSOC+1
 Q
 ;
 ;EXEMPTION QUESTIONS - MAIL MESSAGE POSITION;SUBSCRIPT IN "IBQ" NODE
RELSC ;Is this Rx for a Service Connected Condition?;1
RELMST ;Is this Rx related to the treatment of Military Sexual Trauma?;2
RELAO ;Is this Rx for treatment of Vietnam-Era Herbicide (Agent Orange) exposure?;3
RELIR ;Is this Rx for treatment of Ionizing Radiation exposure?;4
RELEC ;Is this Rx for treatment related to service in SW Asia?;5
RELHNC ;Is this Rx related to treatment of Head and/or Neck Cancer?;6
RELCV ;Is this Rx potentially for treatment related to Combat?;7
RELSHAD ;Is this Rx related to treatment of PROJ 112/SHAD?;8
 ;
