FBPST35A ;AISC/CMR-MERGE & DELETION OF DENIALS FILES ; JUN 15 1994
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$D(^DD(163,0)),('$D(^DD(163.1,0))) W !!,"Post-Init FBPST35A has already been run." Q
 W !!,"Beginning FBPST35A....",!!?20,"CONVERSION OF DENIALS FILES"
 I '$D(^FBAA(163,0)) G DEL
 W !!,"Now I will move any Medical Denial information you wish to keep into the",!,"Fee Basis Payment File (#162).  I will then remove the Fee Basis Medical",!,"Denials file (#163) and the Fee Basis Pharmacy Denials file (#163.1)."
ASK W !!,"Do you want to keep any Medical Denials that are presently stored in the" S DIR(0)="Y",DIR("A")="Fee Basis Medical Denials file (#163)",DIR("B")="No"
 S DIR("?")="Answering yes will move the denials to file #162, no will delete them" D ^DIR K DIR G:$D(DIRUT) ABRT I 'Y G DEL
 S FBDEN=1
 W !!,"You may elect to merge all of your Fee Basis Medical Denials.  If you",!,"choose not to retain all denials, you will be prompted to select a",!,"STARTING DATE to retain denials.  Denials from the starting date to the"
 W !,"present date will be merged into file #162.",!!
ASK1 S DIR(0)="Y",DIR("A")="Do you wish to retain all Medical Denials",DIR("B")="No" D ^DIR K DIR G ASK:$D(DIRUT),MOVE:Y
 S DIR(0)="D",DIR("A")="Select date to retain denials" D ^DIR K DIR G ASK1:$D(DIRUT)!(Y'>0) S FBARDT=+Y
MOVE S U="^" I '$G(FBDEN) G DEL
 W !!?5,"Beginning merge"
 ;get patient from denial file and set up or find in pmnt file
 S DFN=0 F  S DFN=$O(^FBAA(163,DFN)) Q:'DFN  D
 .;get vendor from denial file and set up or find in pmnt file
 .S FBV=0 F  S FBV=$O(^FBAA(163,DFN,1,FBV)) Q:'FBV  D
 ..;get trt dt from denial file and set up or find in pmnt file
 ..S FBDSDI=0 F  S FBDSDI=$O(^FBAA(163,DFN,1,FBV,1,FBDSDI)) Q:'FBDSDI  S FBDDT=+^FBAA(163,DFN,1,FBV,1,FBDSDI,0),FBAUTH=$P(+^(0),"^",4) D:($S($G(FBARDT):FBDDT'<FBARDT,1:1))
 ...D PAT^FBAACO,FILEV^FBAACO5(DFN,FBV) Q:$G(FBAAOUT)  D GETSVDT^FBAACO5(DFN,FBV,FBAUTH,0,FBDDT) Q:$G(FBAAOUT)
 ...;get and file svc provided multiples
 ...S FBJ=0 F  S FBJ=$O(^FBAA(163,DFN,1,FBV,1,FBDSDI,1,FBJ)) Q:'FBJ  I $D(^FBAA(163,DFN,1,FBV,1,FBDSDI,1,FBJ,0)) S FBX=+^(0) D
 ....W "." K DD,DO S DIC="^FBAAC(DFN,1,FBV,1,FBSDI,1,",DA(3)=DFN,DA(2)=FBV,DA(1)=FBSDI,X=FBX,DIC(0)="L",DIC("P")="162.03A" D FILE^DICN K DIC,DA Q:'Y  S FBAACPI=+Y
 ....S %X="^FBAA(163,DFN,1,FBV,1,FBDSDI,1,FBJ,",%Y="^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI," D %XY^%RCR
 ....;re-index entry
 ....S DIK="^FBAAC(DFN,1,FBV,1,FBSDI,1,",DA(3)=DFN,DA(2)=FBV,DA(1)=FBSDI,DA=FBAACPI D IX1^DIK K DIK,DA
 ....;delete entry from 163
 ....S DIK="^FBAA(163,DFN,1,FBV,1,FBDSDI,1,",DA(3)=DFN,DA(2)=FBV,DA(1)=FBDSDI,DA=FBJ D ^DIK K DIK,DA
DEL ;delete files 163 and 163.1
 I $D(^DD(163,0)) W !!?5,"Deleting the Fee Basis Medical Denials file (#163)..." S DIU="^FBAA(163,",DIU(0)="DT" D EN^DIU2
 I $D(^DD(163.1,0)) W !!?5,"Deleting the Fee Basis Pharmacy Denials file (#163.1)..." S DIU="^FBAA(163.1,",DIU(0)="DT" D EN^DIU2
 W !!?5,"Cleaning up DD nodes..."
 K ^DD(200,0,"PT",163.03,6),^DD(200,0,"PT",163.1,2),^DD(200,0,"PT",163.11,11),^DD(161.2,0,"PT",163.01,.01),^DD(161.2,0,"PT",163.1,3),^DD(161,0,"PT",163.11,4),^DD(161.27,0,"PT",163.03,4),^DD(161.27,0,"PT",163.11,7)
 K ^DD(50,0,"PT",163.11,9),^DD(161.7,0,"PT",163.03,7),^DD(161.7,0,"PT",163.03,21),^DD(161.7,0,"PT",163.04,1),^DD(161.7,0,"PT",163.04,6),^DD(161.7,0,"PT",163.1,10),^DD(161.7,0,"PT",163.11,13),^DD(161.7,0,"PT",163.11,19)
 K ^DD(2,0,"PT",163,.01),^DD(161.8,0,"PT",163.02,1.5),^DD(161.8,0,"PT",163.03,23),^DD(81,0,"PT",163.03,.01),^DD(161.82,0,"PT",163.03,16)
END K DFN,FBV,FBSDI,FBDSDI,DA,DIU,DIC,FBARDT,FBDEN,DIK,FBAADT,FBAUTH
 W !!,"Completed FBPST35A   " D NOW^%DTC W $$DATX^FBAAUTL(%)
 Q
ABRT ;
 I $D(DUOUT) W !!,*7,"Required Response!!" G ASK
 I $D(DTOUT) W !!,*7,"Unable to complete the FBPST35A Post-Init routine.  To complete this",!,"process, run ^FBPST35A as soon as possible."
 Q
