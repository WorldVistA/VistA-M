PRCSP1E ;WISC/SAW/DL-CONTROL POINT ACTIVITY PRINTS CON'T ; 1/30/98 1440
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
FACPT ;FISCAL AUDIT LIST
 D EN1^PRCSUT G W1:'$D(PRC("SITE")),EXIT:Y<0
FACPT1 W !,"Enter the cutoff date for this reconciliation report" S %DT="AEX" D ^%DT G EXIT:Y<0
 S PRCS("DAT1")=Y
 ; Change for PRC*5*250 to make date compare Y2K compliant
 S Q=PRC("FY")+100-1
 S %DT="X",X=$S(PRC("QTR")=1:1001,PRC("QTR")=2:"0101",PRC("QTR")=3:"0401",1:"0701")_$S(PRC("QTR")=1:$E(Q,$L(Q)-1,$L(Q)),1:PRC("FY"))
 D ^%DT G EXIT:Y<0
 S PRCS("DAT")=Y
 ; End of fix for PRC*5*250
 I PRCS("DAT")>PRCS("DAT1") W $C(7),!,"  Cutoff date must be greater than first day of the quarter you selected." G FACPT1
 S C2=PRC("SITE")_"-"_PRC("FY")_"-1-"_$P(PRC("CP")," ")_"-0001",C3=PRC("SITE")_"-"_PRC("FY")_"-4-"_$P(PRC("CP")," ")_"9999"
 S BY="@15,@INTERNAL(#31),.01",FR=$P(PRC("CP")," ")_" ,"_PRCS("DAT")_","_C2,TO=$P(PRC("CP")," ")_" z,"_PRCS("DAT1")_","_C3,FLDS="[PRCSFACPT]" D S
 N REPORT2 S REPORT2=1 D T2^PRCSAPP1 K PRC("CP"),PRCS G FACPT
S S L=0,DIC="^PRCS(410," D EN1^DIP Q
DEV K IO("Q") S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS Q
W2 W !!,"Enter information for another report or an uparrow to return to the menu.",! Q
W1 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W I (IO=IO(0))&('$D(ZTQUEUED)) W !!,"Press return to continue:  " R X:DTIME
 I (IO'=IO(0))!($D(ZTQUEUED)) D ^%ZISC
EXIT K %,%DT,%ZIS,BY,C2,C3,D,DA,DHD,DIC,DIE,PRCS,FLDS,FR,I,L,N,Q,TO,X,Y Q
