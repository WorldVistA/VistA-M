PSOCPC ;BHAM ISC/BAB - PHARMACY CO-PAY APPLICATION ;06/09/92
 ;;7.0;OUTPATIENT PHARMACY;**10,9,71,85,114,157,143,239,201,275,225**;DEC 1997;Build 29
 ;
 ;REF/IA
 ;piece 9 of zero node of File 350 and APDT cross reference of File 350/2215
 ;$$STATUS^IBARX/125
 ;File 350.1/592 (DBIA125-B)
WARN ; Message when attempt is made to delete a refill date on COPAY
 N PSOIB,PSOIBST
 S PSOFLG=0
 G:'$D(^PSRX(DA(1),1,DA,"IB")) ENDW
 S PSOIB=^PSRX(DA(1),1,DA,"IB")
 I +PSOIB'>0 G ENDW
 S PSOIBST=$$STATUS^IBARX(+PSOIB) I PSOIBST=2!(PSOIBST=0) G ENDW
 I +PSOIB>0 D CANCEL G ENDW:PSOFLG=0
 I '$G(PSOXXDEL) D EN^DDIOL("This REFILL has COPAY charges, which MUST be removed","","$C(7),!!"),EN^DDIOL("BEFORE the refill date is deleted.","","!")
 I '$G(PSOXXDEL) D EN^DDIOL("Use option RESET COPAY STATUS/CANCEL CHARGES, return to EDIT A PRESCRIPTION,","","!!"),EN^DDIOL("and delete the refill date.","","!"),EN^DDIOL(" ","","!!")
 S PSOFLG=1
ENDW ;
 I PSOFLG
 K PSOFLG
 Q
CANCEL ;Check if charge is cancelled for this Refill date
 S PSOFLG=1 ;indicates a charge not cancelled
 S PSOX=+^PSRX(DA(1),1,DA,"IB")
 D LAST I PSOLAST'=PSOPARNT,$D(^IB(PSOLAST,0)),$P(^IBE(350.1,$P(^IB(PSOLAST,0),"^",3),0),"^",5)=2 S PSOFLG=0
 K PSOLAST,PSOPARNT,PSOX,PSOL,PSOLDT
 Q
LAST ;find last entry
 S PSOLAST=""
 S PSOPARNT=$P(^IB(+PSOX,0),"^",9) I 'PSOPARNT S PSOPARNT=+PSOX
 S PSOLDT=$O(^IB("APDT",PSOPARNT,"")) I +PSOLDT F PSOL=0:0 S PSOL=$O(^IB("APDT",PSOPARNT,PSOLDT,PSOL)) Q:'PSOL  S PSOLAST=PSOL
 I PSOLAST="" S PSOLAST=PSOPARNT
 Q
 ;
EXEMCHK ; Allow reset of exemption answers
 N PSOTG,PSOCPN,PSOEXMT,PSOANS,OLDIBQ,PSOSCP,PSOSCA
 S PSOANS=0 D SCP^PSORN52D
 S OLDIBQ=$G(^PSRX(PSODA,"IBQ"))
 I OLDIBQ[0!(OLDIBQ)[1 D
 . S PSOANS=1
 . I $P(OLDIBQ,"^",1)'="" S PSOTG("SC")=$P(OLDIBQ,"^",1)
 . I $P(OLDIBQ,"^",2)'="" S PSOTG("MST")=$P(OLDIBQ,"^",2)
 . I $P(OLDIBQ,"^",3)'="" S PSOTG("AO")=$P(OLDIBQ,"^",3)
 . I $P(OLDIBQ,"^",4)'="" S PSOTG("IR")=$P(OLDIBQ,"^",4)
 . I $P(OLDIBQ,"^",5)'="" S PSOTG("EC")=$P(OLDIBQ,"^",5)
 . I $P(OLDIBQ,"^",6)'="" S PSOTG("HNC")=$P(OLDIBQ,"^",6)
 . I $P(OLDIBQ,"^",7)'="" S PSOTG("CV")=$P(OLDIBQ,"^",7)
 . I $P(OLDIBQ,"^",8)'="" S PSOTG("SHAD")=$P(OLDIBQ,"^",8)
 S PSOCPN=$P(^PSRX(PSODA,0),"^",2)
 S RXP=PSODA
 D SCNEW^PSOCP(.PSOTG,PSOCPN,"",PSODA)
 N EXMT
 D XTYPE^PSOCP ; KEEP THIS CALL IN HERE TO SEE IF SC QUESTION APPLIES
 ;I $D(PSOTG("SC")) S PSOTG("SC")=$P(OLDIBQ,"^",1) ; CHANGED TO JUST USE IBQ SETTING IF SC QUESTION APPLIES - DON'T RE-CALCULATE SERVICE-CONNECTED
 S EXMT="" F  S EXMT=$O(PSOTG(EXMT)) Q:EXMT=""  I PSOTG(EXMT)'="" S PSOANS=1 Q
 I $O(PSOTG(""))="" Q
 I PSOANS W !!,"The following exemption flags have been set:"
 F EXMT="SC","CV","AO","IR","EC","SHAD","MST","HNC" I $G(PSOTG(EXMT))'="" W !,$S(EXMT="EC":"SWAC",1:EXMT),": ",?6,$S(PSOTG(EXMT)=1:"Yes",PSOTG(EXMT)=0:"No",1:"")
 W !
 W ! K DIR S DIR(0)="Y",DIR("B")="N" D  S DIR("A")="Do you want to enter/edit any copay exemption flags"
 . S EXMT="" F  S EXMT=$O(PSOTG(EXMT)) Q:EXMT=""  I PSOTG(EXMT)="" S DIR("B")="Y" Q
 S DIR("?")="Enter 'Y' for Yes if you want to edit any applicable medication exemption flags."
 S DIR("??")="^D HELPEXEM^PSOCPC"
 D ^DIR K DIR S PSOEXMT=Y I Y'=1 Q
 ; PRESENT ALL APPLICABLE EXEMPTIONS AND SAVE NEW ANSWERS
 N PSOIBQ,PSOSUBS,PSOQUES,PSOLTAG,OLDIBQ,II,PSOCHG,PSOPATST
 S PSOPATST=$$GET1^DIQ(52,PSODA_",",3,"I")
 S PSOIBQ=""
 S OLDIBQ=$G(^PSRX(PSODA,"IBQ"))
 I '$D(^PSRX(PSODA,"IBQ")),+($G(^PSRX(PSODA,"IB")))=2 S $P(OLDIBQ,"^",1)=0 ; SC QUESTION WAS PREVIOUSLY ANSWERED AS N
 S PSOCOMM="",PSOOLD="",PSONW=""
 S II=0
 F EXMT="SC","CV","AO","IR","EC","SHAD","MST","HNC" I $D(PSOTG(EXMT)) D
 . S PSOLTAG="REL"_EXMT_"^PSOCPE"
 . S HELPTAG="HELP"_EXMT
 . S PSOQUES=$P($T(@PSOLTAG),";",2) I PSOQUES="" Q
 . S PSOQUES=$P(PSOQUES,"?")
 . S PSOSUBS=$P($T(@PSOLTAG),";",3) I PSOSUBS="" Q
 . D ASKEXEM
 I $D(PSOCHG) D
 . ;PSO*7*275 IBQ node should not be present in some cases.
 . K ^PSRX(PSODA,"IBQ")
 . S:PSOSCP<50&($TR(PSOIBQ,"^")'="")&($P($G(^PS(53,+$G(PSOPATST),0)),"^",7)'=1) ^PSRX(PSODA,"IBQ")=PSOIBQ
 . D RESET^PSORN52D  ;set SC/EI on ICD node
 . S PSOPFSA=1 ;PFSS-denotes to calling routine that outpatient classifications changed.
 . D EN^PSOHLSN1(PSODA,"XX","","Order edited")
 . I PCOPAY,PSOIBQ["1" D  ; RESET TO NO COPAY
 . . W !,"Editing of exemption flag(s) has resulted in a copay status change.",!,"The status for this Rx will be reset to NO COPAY."
 . . S $P(^PSRX(PSODA,"IB"),"^",1)=""
 . . S PSOREF="",PSOOLD="Copay",PSONW="No Copay",PREA="R" D ACTLOG^PSOCPA
 . . S PSOCOMM="Copay status reset due to exemption flag(s)"
 . . S PSI=0 D SETSUMM
 . I $G(II)>0 D
 . . S PSOCOMM="The following exemption flags have been changed: ",PSI=0 D SETSUMM
 . . S II="" F  S II=$O(PSOCHG(II)) Q:II=""  S PSOCOMM=PSOCHG(II),PSI=0 D SETSUMM
 Q
 ;
ASKEXEM ; ASK THE EXEMPTION QUESTIONS
 K DIR S DIR("A")=PSOQUES,DIR(0)="YO" S:PSOTG(EXMT)=1 DIR("B")="Y" S:PSOTG(EXMT)=0 DIR("B")="N" D @HELPTAG
ASKEXEM1 D ^DIR I X="@" R !,"  Are you sure you want to delete this answer? ",X:DTIME I $E(X)'="Y",$E(X)'="y" G ASKEXEM1
 I X="^" S X=$G(DIR("B")) S Y=$S(X="Y":1,X="N":0,1:"")
 S $P(PSOIBQ,"^",PSOSUBS)=$S(Y=1:1,Y=0:0,1:"")
 I $P(PSOIBQ,"^",PSOSUBS)'=$P(OLDIBQ,"^",PSOSUBS) S II=II+1,PSOCHG(II)=$S(EXMT="EC":"SWAC",1:EXMT)_": "_$S($P(PSOIBQ,"^",PSOSUBS)=1:"Yes",$P(PSOIBQ,"^",PSOSUBS)=0:"No",1:"")
 I Y=1 D
 . I PSOCOMM'="" Q
 . D SETCOMM^PSOCP
 Q
 ;
HELPEXEM ; help text for exemption edit question
 W !,"Enter 'Y' for Yes if you want to edit any applicable exemption flags such as"
 W !,"Service Connected (SC), Combat Veteran(CV), Agent Orange (AO), Ionizing"
 W !,"Radiation (IR), Southwest Asia Conditions (SWAC), PROJ 112/SHAD,"
 W !,"Military Sexual Trauma (MST), or Head and/or Neck Cancer (HNC)."
 Q
 ;
HELPSC ;
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is for a Service Connected condition."
 S DIR("?",2)="This response will be used to determine whether or not a copay should be"
 S DIR("?",3)="applied to the prescription."
 Q
 ;
HELPAO ;
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition due to",DIR("?",2)="Vietnam-Era Herbicide (Agent Orange) exposure. This response will be used to"
 S DIR("?",3)="determine whether or not a copay should be applied to the prescription."
 Q
 ;
HELPIR ;
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition due to",DIR("?",2)="ionizing radiation exposure during military service. This response will be used"
 S DIR("?",3)="to determine whether or not a copay should be applied to the prescription."
 Q
 ;
HELPEC ;
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition related to",DIR("?",2)="service in Southwest Asia. This response will be used to determine whether"
 S DIR("?",3)="or not a copay should be applied to the prescription."
 Q
 ;
HELPMST ;
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition related",DIR("?",2)="to Military Sexual Trauma. This response will be used to determine whether or"
 S DIR("?",3)="not a copay should be applied to the prescription."
 Q
 ;
HELPHNC ;
 S DIR("?")=" ",DIR("?",1)="Enter 'Yes' if this prescription is being used to treat Head and/or Neck Cancer",DIR("?",2)="due to nose or throat radium treatments while in the military. This response"
 S DIR("?",3)="will be used to determine whether or not a copay should be applied to the",DIR("?",4)="prescription."
 Q
 ;
HELPCV ;
 S DIR("?")=" "
 S DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition related"
 S DIR("?",2)="to Combat Services. This response will be used to determine whether or"
 S DIR("?",3)="not a copay should be applied to the prescription."
 Q
 ;
HELPSHAD ;
 S DIR("?")=" "
 S DIR("?",1)="Enter 'Yes' if this prescription is being used to treat a condition related"
 S DIR("?",2)="to PROJ 112/SHAD. This response will be used to determine whether or"
 S DIR("?",3)="not a copay should be applied to the prescription."
 Q
SETSUMM ; SET MESSAGE INTO SUMMARY
 S PSI=$O(PSOSUMM(PSI)) G:$O(PSOSUMM(PSI)) SETSUMM
 S PSI=PSI+1,PSOSUMM(PSI)=PSOCOMM
 K PSOCOMM
 Q
 ;
