PSIVRD ;BIR/PR,MLM-HANDLE QUICK RET/DES ENTRY ;29 SEP 97 / 11:17 AM
 ;;5.0; INPATIENT MEDICATIONS ;**38,58,88**;16 DEC 97
 ;        ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ;
EN ; Entry point to enter returns/destroyed items.
 D ^PSIVXU Q:$D(XQUIT)  F  D ENGETP^PSIV Q:DFN<0  D EN1
Q K ACTION,D,DFN,DIC,DIR,DRG,DRGI,DRGN,E,E1,HELP,I,I1,JJ,LABELS,MXMN,ON,ON55,ONCNT,P,PS,PSGDT,PSGID,PSGP,PSGLMT,PSGODDD,PSIVAC,PSIVC,PSIVNOL,PSIVNOW,PSIVON
 K PSIVPL,PSIVPR,PSIVSITE,PSIVUP,PSIVX,PSJORIFN,PSJORL,PSJHT,PSJPWT,PSJSYSL,PSJSYSU,PSJSYSW,PSJSYSW0,Q,UL80,VA,VADM,VAIN,VAERR,PSIVNU,PSIVOV1,PSIVOV2,PSIVSN,RDFLAG,RDWARD,X,XQUIT,Y
 Q
 ;
EN1 ;
 S PSIVBR="D PROCESS^PSIVRD" D ENCHS1^PSIV
 Q
EN1OLD ;
 ;S PSIVAC="RD" D ENNB^PSIVACT I P("PT")'="N" D GTORDRS Q
ORDNO ;
 F  R !!,"Enter the order number(s) to be processed: ",PSIVNU:DTIME Q:"^"[PSIVNU  D READ
 Q
 ;
READ ; Read order no.s, no profile.
 N DONE I '$T!(PSIVNU="^")!(PSIVNU="") S PSIVNU="" Q
 I PSIVNU["?" W !!,"Enter order number(s) separated by a comma e.g. 2,4,5,6.",! Q
 I PSIVNU[" " W $C(7),$C(7),"??",!! Q
 F I=1:1:$L(PSIVNU,",") S ON=$P(PSIVNU,",",I) D
 .I $L(ON)'>0 W $C(7),$C(7),"??",!! S DONE=1
 .F JJ=1:1:$L(ON) Q:$G(DONE)  I $A($E(ON,JJ))<48!($A($E(ON,JJ))>57) W !!,$C(7),$C(7),"Order ",ON," is invalid.",!! S DONE=1
 I '$G(DONE) F I=1:1:$L(PSIVNU,",") S ON=$P(PSIVNU,",",I) I '$D(^PS(55,DFN,"IV",+ON,0)) W !!,$C(7),$C(7),"Order number ",+ON," does not exist for this patient.",! S DONE=1
 I '$G(DONE) D NOW^%DTC S PSIVNOW=% F ONCNT=1:1:$L(PSIVNU,",") D  S ON=9999999999-$P(PSIVNU,",",ONCNT) D OV1
 .S X=$G(^PS(55,DFN,"IV",+ON,0)) I $P(X,U,3)<PSIVNOW,("AR"[$P(X,U,17)) S $P(^PS(55,DFN,"IV",+ON,0),U,17)="E" D EXPIR^PSIVOE
 Q
 ;**********************************************************
 ;* GTORDRS, ASK, OV subroutines are no longer use in 5.0. *
 ;**********************************************************
GTORDRS ;Needs PSIVBR (Branch point)
 S IOP="HOME" D ^%ZIS K %ZIS,IOP Q:P("PT")="N"
 D ^PSIVPRO Q:X="^"  I X]"" G OV
ASK Q:PS<1  W !!,"Choose 1-",PS,": " R X:DTIME S:'$T X="^" Q:"^"[X
 I X?1."?" S HELP="CHSE" D ^PSIVHLP D:X?2."?" H2^PSGON G ASK
 S PSGLMT=PS D ^PSGON G:'$D(X) ASK
OV ;
 W ! F PSIVOV1=1:1:PSGODDD F PSIVOV2=1:1:$L(PSGODDD(PSIVOV1),",")-1 S ON=+$P(PSGODDD(PSIVOV1),",",PSIVOV2),ON=$S($D(^TMP("PSIV",$J,"AB",ON)):^(ON),$D(^TMP("PSIV",$J,"NB",ON)):^(ON),$D(^TMP("PSIV",$J,"XB",ON)):^(ON),1:"") Q:'ON  D OV1
 Q
OV1 ;
 S (ON,ON55,P("PON"))=9999999999-ON_"V" K PSIVNUM D GT55^PSIVORFB,ENNONUM^PSIVORV2(DFN,ON)
 D PROCESS1
 Q
 ;
PROCESS ;
 D FULL^VALM1
 S PSJORD=ON D ENNH^PSIVORV2(ON)
PROCESS1 ;
 I '$D(^PS(55,DFN,"IV",+ON,9)) W !!,$C(7),$C(7),"No labels have been dispensed for this order." N DIR S DIR(0)="E" D ^DIR Q
 I $P(^PS(55,DFN,"IV",+ON,2),U,2)'=PSIVSN W !!,"WARNING ",$C(7),$C(7),$C(7),"This order is in a different IV room",!," from the one in which you are entering returned/destroyed!" S E1=$P(^(2),U,2),E=PSIVSN
 D PAUSE^VALM1
 S PSIVLBTP=2,PSJMORE=0,RDFLAG="ON" D EN^VALM("PSJ LM IV RETURN LABELS")
 Q
 ;
 ;S RDFLAG="ON",X="Was this bottle RECYCLED or DESTROYED or CANCELLED ?^R^^RECYCLED,DESTROYED,CANCELLED" D ENQ^PSIV Q:X=U  I X["?" S HELP="RTDS" D ^PSIVHLP1 G PROCESS1
 ;W ! S Y=$E(X),PSIVC=$S(Y="R":2,Y="D":3,1:4)
 ;
WARD ;Get the ward to associate returns or destroyed with.
 I '$D(PSJIDLST) W !,"No labels are available" D PAUSE^VALM1 Q
 K DIC I $D(^DPT(DFN,.1)) S DIC("B")=^DPT(DFN,.1)
 S DIC("A")="Enter ward or ^OUTPATIENT: ",DIC(0)="AEQ",DIC=42,D="B" D IX^DIC G:X="^"!(X="") KILL I $P("^OUTPATIENT",X)="" W $P("^OUTPATIENT",X,2) S RDWARD=.5 G WARD1
 S:Y>0 RDWARD=+Y I Y<0 G WARD
 ;
WARD1 ;
 NEW PSIVCTD S PSIVCTD=""
 S PSJY=$$PROMPT^PSIVLBRP()
 Q:PSJY=""
 S PSIVNOL=0
 F PSJSEL=1:1 S PSJSEL1=$P(PSJY,",",PSJSEL) Q:PSJSEL1=""  S PSIVNOL=PSIVNOL+1
 F PSJSEL=1:1 S PSJSEL1=$P(PSJY,",",PSJSEL) Q:PSJSEL1=""  D
 . S PSJID=$G(PSJIDLST(PSJSEL1)) Q:PSJID=""
 . S PSJIDNO=$P(PSJID,"V",2) D NOW^%DTC
 . K DA,DR,DIE,DIC
 . S DA=PSJIDNO,DA(1)=DFN,DIE="^PS(55,"_DA(1)_",""IVBCMA"","
 . S DR="4////"_%_";5////"_$S(PSIVC=2:"RC",PSIVC=3:"DT",1:"CA") D ^DIE
 . K DA,DR,DIE,DIC
 S LABELS=PSIVNOL,ACTION=$S(PSIVC=2:2,PSIVC=3:3,1:4) D ^PSIVLTR,^PSIVSTAT W "...Done."
 Q
NRD ;Ask number of bottles/bags
 Q
 ;NO LONGER USE
 S MXMN=$P(^PS(55,DFN,"IV",+ON,9),U,3)
NRD1 ;
 Q
 ;NO LONGER USE
 R !,"Number of bottles: ",X:DTIME W:'$T $C(7) S:'$T X="^" G:"^"[X KILL I X?1."?" S HELP="REDT" D ^PSIVHLP G NRD1
 I $S($E(X,$E(X)="-"+1,$L(X))'?1.N:1,X<-50:1,X>MXMN:1,1:'X) W $C(7),"  ??" G NRD1
 ;
 S PSIVNOL=+X,LABELS=PSIVNOL,ACTION=$S(PSIVC=2:2,PSIVC=3:3,1:4) D ^PSIVLTR,^PSIVSTAT W "...Done."
 ;
KILL ;
 Q
 ;NO LONGER USE
 W:"^"[X $C(7),"NO ACTION TAKEN" K D,LABELS,MXMN,X,Y,PSIVNOL,HELP,DIC,RDFLAG,PSIVC
 S VALMBCK="R"
 Q
