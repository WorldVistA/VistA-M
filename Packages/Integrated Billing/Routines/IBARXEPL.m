IBARXEPL ;ALB/AAS - PRINT EXEMPTION LETTER - 28-APR-93
 ;;2.0;INTEGRATED BILLING;**34,54,190,206**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% I '$D(DT) D DT^DICRW
 I '$D(IOF) D HOME^%ZIS
 W @IOF,"Print Exemption letters to patients"
 K ^TMP("IBEX LIST",$J)
 S (IBTEMP,IBADDT,IBOK,IBQUIT)=""
 ;
 ; -- find template
 S IBTEMP=$O(^DIBT("B","IB EXEMPTION LETTER",0))
 ;
 ; -- use old template or build new one
 W !!!
 ;
 I IBTEMP D  G:IBQUIT END
 .S DIR(0)="Y",DIR("A")="Delete Results of Previous Search",DIR("B")="NO"
 .S DIR("?")="Enter 'Yes' if you would like to delete the results of a previous search, Enter 'No' if you want to keep the results (i.e. you may be reprinting letters from the same list)."
 .D ^DIR K DIR I $D(DIRUT) S IBQUIT=1
 .I Y=1 D DELT S IBTEMP=0
 .Q
 ;
 I 'IBTEMP D  G:IBQUIT END D:IBADD ADDT
 .S DIR(0)="Y",DIR("A")="Store results of Search in Template",DIR("B")="YES"
 .S DIR("?")="Enter 'Yes' if you would like the results of the search stored in a Sort Template named IB EXEMPTION LETTER.  Enter 'No' if you do not want the template created."
 .S DIR("?",1)="Creating the search template will allow you to",DIR("?",2)="print other lists from the patients you sent the letters to."
 .S DIR("?",3)=" "
 .D ^DIR K DIR I $D(DIRUT) S IBQUIT=1 Q
 .S IBADD=Y
 .Q
 ;
 D PRINT
 ;
END I $D(ZTQUEUED) Q
 D ^%ZISC,KVAR^VADPT
 K C,J,X,Y,D0,DIC,DA,DR,DIE,DFN,DLAYGO,DIR,DIRUT,IB,IBADD,IBADDT,IBTEMP
 K IBOK,IBLET,IBCNT,IBCNTL,IBQUIT,IBNAM,IBDATA,IBJ,IBX,TAB,POP,IBALIN
 K BY,DHD,DIOEND,FLDS,FR,I,L,TO,VAPA,^TMP("IBEX LIST",$J)
 Q
 ;
ADDT ; -- create new template in ^dibt
 K DD,DO
 S DIC="^DIBT(",DIC(0)="L",X="IB EXEMPTION LETTER",DIC("DR")="2///NOW;4///354;7///NOW"
 D FILE^DICN S IBTEMP=+Y I +Y S IBADDT=1 W !!,"<<< Search Template IB EXEMPTION LETTER created!",!
 Q
 ;
DELT ; -- delete search template
 Q:$P($G(^DIBT(+IBTEMP,0)),"^",1)'="IB EXEMPTION LETTER"
 S DIK="^DIBT(",DA=IBTEMP D ^DIK K DIK,DA
 W !!,"<<< Search Template IB EXEMPTION LETTER deleted!",!
 S IBTEMP=""
 Q
 ;
SCR ; -- don't send letters to deceased patients, non-vets
 ;    called by print template IB DO NOT USE
 S IBOK=0 N IBX
 I +$G(^DPT(D0,.35)) G SCRQ ; deceased
 I $P($G(^DPT(D0,"VET")),"^")="N" G SCRQ ; patient non-vet
 S IBX=$P($G(^IBE(354.2,+$P($G(^IBA(354,D0,0)),"^",5),0)),"^",5)
 I IBX=60 G SCRQ ;exemption is non-vet
 I IBX=10 G SCRQ ;sc>50
 S IBOK=1
SCRQ Q
 ;
PRINT ; -- run through list of letters to PRINT
 S X="IB NOW EXEMPT",DIC(0)="XZ",DIC="^IBE(354.6," D ^DIC S IBLET=+Y
 Q:IBLET<1
 ;
 S DIC="^IBA(354,",L=0,FLDS="[IB DO NOT USE]",BY="[IB EXEMPT PATIENTS]",(FR,TO)="?,?,?",DHD="@@"
 S DIOEND="D LET^IBARXEPL"
 D EN1^DIP
 Q
 ;
LET ; -- called by dioend, prints list from tmp array
 S IBALIN=$P($G(^IBE(354.6,IBLET,0)),"^",4)
 I IBALIN<10!(IBALIN>25) S IBALIN=15
 S IBNAM="" F  S IBNAM=$O(^TMP("IBEX LIST",$J,IBNAM)) Q:IBNAM=""!(IBQUIT)  S DFN=0 F  S DFN=$O(^TMP("IBEX LIST",$J,IBNAM,DFN)) Q:'DFN!(IBQUIT)  S IBDATA=^(DFN) D ONE
 D FINAL,END
 Q
 ;
ONE ; -- print one letter
 N IBCONF ; Confidential Address Flag
 S TAB=5
 I '$D(IOF) D HOME^%ZIS
 S IBCNTL=$G(IBCNTL)+1 I $E(IOST,1,2)="C-" W @IOF
 S IB=0
 ;
 ; -- print header
 S IBCNT=0
 F I=1:1:6 S IB=$O(^IBE(354.6,IBLET,2,IB)) Q:'IB  S X=$G(^(IB,0)) W !?(IOM-$L(X)+1/2),X S IBCNT=IBCNT+1
 W !?TAB S Y=DT D DT^DIQ S IBCNT=IBCNT+1
 F IBCNT=IBCNT:1:6 W ! S IBCNT=IBCNT+1
 W !?(IOM-28),"In Reply Refer To:" S IBCNT=IBCNT+1
 W !?(IOM-28),$E($P(IBDATA,"^")),$P($P(IBDATA,"^",2),"-",3),!
 S IBCNT=IBCNT+2
 S IBX=$$RXST^IBARXEU(DFN,DT) I $P($G(^IBE(354.6,IBLET,0)),"^",3)'=2,$P(IBX,"^",3)=120 S Y=$$PLUS^IBARXEU0($P(IBX,"^",5)) W ?(IOM-28),"Renewal Date: " D DT^DIQ
 ;
 ; -- print pt. name and address
 F IBCNT=IBCNT:1:(IBALIN-1) W !
 W !?TAB,$P(IBNAM,",",2)," ",$P(IBNAM,",") D ADD^VADPT S IBCNT=IBCNT+1
 S IBCONF=$$CONFADD^IBARXEL() ; Should we use Confidential Address?
 W !?TAB,VAPA($S(IBCONF:13,1:1)) S IBCNT=IBCNT+1
 I VAPA($S(IBCONF:14,1:2))'="" W !?TAB,VAPA($S(IBCONF:14,1:2)) I VAPA($S(IBCONF:15,1:3))'="" W ", ",VAPA($S(IBCONF:15,1:3)) S IBCNT=IBCNT+1
 W !?TAB,VAPA($S(IBCONF:16,1:4)),", ",$P($G(^DIC(5,+VAPA($S(IBCONF:17,1:5)),0)),"^",2),"  ",$S(IBCONF:$P(VAPA(18),"^",2),1:VAPA(6)) S IBCNT=IBCNT+1
 I $E(IOST,1,2)="C-" D PAUSE^IBOUTL Q:IBQUIT
 ;
 ; -- print main body
 W !! S IBCNT=IBCNT+2
 K ^UTILITY($J,"W"),DIWR,DIWL,DIWF,DN S DIWL=1,DIWF="C80WN"
 S IB=0 F  S IB=$O(^IBE(354.6,IBLET,1,IB)) Q:IB=""  S X=$G(^(IB,0)) D ^DIWP S IBCNT=IBCNT+1 ; W !,X
 D ^DIWW K ^UTILITY($J,"W")
 I $E(IOST,1,2)="C-" D PAUSE^IBOUTL Q:IBQUIT
 W:$E(IOST,1,2)'="C-" @IOF
 Q
 ;
FINAL ; -- Print last page
 W @IOF,!!!,?20,"EXEMPTION LETTERS PRINTING COMPLETED"
 W !!,?20,$G(IBCNTL)," LETTERS PRINTED"
 Q
