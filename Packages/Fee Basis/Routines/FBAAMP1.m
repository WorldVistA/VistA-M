FBAAMP1 ;AISC/CMR-MULTIPLE PAYMENT ENTRY ;7/6/2003
 ;;3.5;FEE BASIS;**4,55,61,77**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
SUSP ;enter suspense data
 N FBX
 ;S DIR(0)="162.5,9",DIR("A")="Amount Suspended: $",DIR("B")=FBJ-FBK,DIR("?")="Press Return if $ "_(FBJ-FBK)_" is Amount Suspended, otherwise enter correct suspension amount" D ^DIR K DIR
 ;I $D(DIRUT) W !!,"Invalid entry, enter a number between .01 and 999999" G SUSP
 ;S FBAAAS=+Y
 ;I +Y'=(FBJ-FBK) S FBAAAS=+Y W ! S DIR("A")="Is $"_FBAAAS_" correct for Amount Suspended",DIR("B")="Yes",DIR(0)="Y" D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1 Q
 ;G SUSP:'Y
 ;W !! S DIC="^FBAA(161.27,",DIC(0)="AEQ" D ^DIC I X["^" S FBAAOUT=1 Q
 ;S FBAASC=+Y
 S FBX=$$ADJ^FBUTL2(FBJ-FBK,.FBADJ,2)
 I FBX=0 S FBAAOUT=1
 Q
SUSP1 I FBAASC=4 K ^TMP($J,"FBWP") W !!,"Suspension Description: " S DIC="^TMP($J,""FBWP"",",DWLW=80,DWPK=1 D EN^DIWE K DIC,DWLW,DWPK I '$O(^TMP($J,"FBWP",0)) W !!,*7,"Description of Suspense is required." G SUSP1
 Q
HCFA F FBSI=28,30,31,32 S FBHCFA(FBSI)=""
 W ! F FBSI=28,30,31 D  Q:$G(FBAAOUT)
 . N ICDVDT S ICDVDT=$G(FBMPDT)
 . F  S DIR(0)="P"_$S(FBSI=28&($$EXTPV^FBAAUTL5(FBPOV)="01"):"O^80",FBSI=28&($$EXTPV^FBAAUTL5(FBPOV)'="01"):"^80",FBSI=30:"^353.1",FBSI=31:"O^353.2")_":EMZ" D HCFA1 Q:$G(FBAAOUT)  Q:FBSI'=28  Q:$$CHKICD9^FBCSV1(+Y,$G(FBMPDT))]""
 Q:$G(FBAAOUT)
 W !
 I $$EXTPV^FBAAUTL5(FBPOV)'="01" D
 . S FBSI=32,DIR(0)="Y",DIR("A")="Service connected condition"
 . S DIR("?")="^W !!,""Respond by answering 'Yes' or 'No'."",! I $G(DFN) W !?1,*7,""Patient:  "",$$NAME^FBCHREQ2(DFN) D DIS^DGRPDB W !!"
 . D HCFA1 I $D(DIRUT) S FBAAOUT=1 Q
 Q
HCFA1 D ^DIR I $D(DTOUT)!($D(DUOUT)) S FBAAOUT=1 Q
 I Y'=-1 D
 .I DIR(0)["P" S FBHCFA(FBSI)=$P(Y,"^")
 .I DIR(0)="Y" S FBHCFA(FBSI)=$S(Y=1:"Y",1:"N")
 K DIR Q
DESC N FBJ
 I FBAASC=4,$D(^TMP($J,"FBWP",0)) S ^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,1,0)=^(0) F FBJ=1:1 Q:'$D(^TMP($J,"FBWP",FBJ,0))  S ^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,1,FBJ,0)=^(0)
 Q
