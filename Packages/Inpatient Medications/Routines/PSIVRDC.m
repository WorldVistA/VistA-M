PSIVRDC ;BIR/MV - RECYCLE, CANCEL, DESTROY ACTIONS ;30 Aug 2001  4:21 PM
 ;;5.0; INPATIENT MEDICATIONS ;**85,200**;16 DEC 97;Build 14
 ;
 ;;Reference to ^PS(55 is supported by DBIA 2191
 ;
EN ;
 NEW CHK,PSGDT,PSIVPL,PSIVPR,PSIVSITE,PSIVSN,PSJSYSL,PSJSYSP,PSJSYSP0,PSJSYSU
 D ^PSIVXU Q:$D(XQUIT)
 NEW DA,DIC,DIR,X,X,Y
 W !
 F  K DIR S DIR(0)="SOA^R:RECYCLE;C:CANCEL;D:DESTROY",DIR("A")="Enter action to take (Recycle/Cancel/Destroy): " D ^DIR Q:$S(Y="R":0,Y="C":0,Y="D":0,1:1)  D GTID(Y)
 Q
GTID(PSJRDC) ;
 F  K DIR S DIR(0)="FO^1:50",DIR("A")="Scan Barcode to "_$$TXT(PSJRDC) D  Q:X=""!$D(DTOUT)!$D(DUOUT)!$D(DIROUT)  D UPDID($$UP^XLFSTR(X),PSJRDC)
 . S DIR("?")="Please enter the barcode ID" D ^DIR
 Q
UPDID(PSJID,PSJRDC)        ;
 NEW ACTION,DA,DIC,DFN,ON,LABELS,PSIVNOL,PSJLB,X,Y
 I '$D(^PS(55,+$P(PSJID,"V"),"BCMA",PSJID)) W !,"...Invalid ID number.  Please try again.",!! Q
 S DA(1)=$P(PSJID,"V"),DIC="^PS(55,"_DA(1)_",""IVBCMA"",",X=$P(PSJID,"V",2),DIC(0)="ZQ" D ^DIC
 I Y=-1 W !!,"...Invalid ID number.  Please try again.",!! Q
 W !
 F X=1:1:8 S PSJLB(X)=$P(Y(0),U,X)
 I $S(PSJLB(4)]""&("CGIS"[PSJLB(4)):1,PSJLB(7)="RP":0,PSJLB(7)]"":1,1:0) D  Q
 . W !,"...The ID entered was marked as "
 . W $S(PSJLB(4)="C":"Completed.",PSJLB(4)="G":"Given.",PSJLB(4)="I":"Infusing.",PSJLB(4)="S":"Stop.",PSJLB(7)="CA":"Cancel.",PSJLB(7)="DT":"Destroy.",PSJLB(7)="RC":"Recycle.",1:""),!
 S ON=PSJLB(2),DFN=$P(PSJID,"V")
 D DSPLY
 K DIR S DIR(0)="FO^1:50",DIR("A")=$$TXT(PSJRDC),DIR("B")=PSJID D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q
 I X'=PSJID W !,"...Barcode ID did not match.  No action was taken." W ! Q
 K DA,DR,DIE,DIC,DIR
 D NOW^%DTC
 S DA=$P(PSJID,"V",2),DA(1)=DFN,DIE="^PS(55,"_DA(1)_",""IVBCMA"","
 S DR="4////"_%_";5////"_$S(PSJRDC="R":"RC",PSJRDC="D":"DT",1:"CA") D ^DIE
 K DA,DR,DIE,DIC,DTOUT,DUOUT,DIROUT
 ;BHW;PSJ*5*200;Add RDFLAG and RDWARD so PSIVSTAT will update the Cumulative doses.
 N RDFLAG,RDWARD
 S RDFLAG="ON"
 S RDWARD=$P(^PS(55,DFN,"IV",+ON,0),U,22) I 'RDWARD S RDWARD=$S($D(^DPT(DFN,.1)):$O(^DIC(42,"B",^DPT(DFN,.1),0)),1:.5)
 ;BHW;PSJ*5*200;End Changes
 S PSIVNOL=1,LABELS=1,ACTION=$S(PSJRDC="R":2,PSJRDC="D":3,1:4) D ^PSIVLTR,^PSIVSTAT
 W !,"...Done!",!!
 Q
DSPLY ;Display the patient name, additives/solutions.
 NEW PSJAS,PSJADSOL,PSJL,PSJLBN,PSJLEN,PSJLN,VA,VADM,X
 K ^TMP("PSIVLB",$J)
 D DEM^VADPT
 S PSJL="",(PSJLEN,PSJLN)=1,PSJLBN=$P(PSJID,"V",2)
 F PSJAS="AD","SOL" D ADSOL^PSIVLB(PSJAS)
 W !,VADM(1),!
 F X=0:0 S X=$O(^TMP("PSIVLB",$J,X)) Q:'X  W !,^(X,0)
 W !
 K ^TMP("PSIVLB",$J)
 Q
TXT(X) ;Expand the set of code to text.
 Q $S(X="R":"Recycle",X="C":"Cancel",X="D":"Destroy",1:"")
