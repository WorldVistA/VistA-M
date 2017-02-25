PRCAGDR ;WASH-ISC@ALTOONA,PA/CMS - BALANCE DISCREPANCY REPORT ;12/3/93  9:40 AM
V ;;4.5;Accounts Receivable;**78,198,219,301**;Mar 20, 1995;Build 144
 ;;Per VA Directive 6402, this routine should not be modified.
 N CHK,DAT,DEB,DIC,LN1,LN2,NAM,SSN,STD,PG,POP,Y,X,%ZIS S COMM=0
PAT ;select patient
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 W ! S DIC="^DPT(",DIC(0)="AENMQ",DIC("A")="Select Patient: " D ^DIC G:Y<1 OUT S DEB=$O(^RCD(340,"B",+Y_";DPT(",0)) I 'DEB W *7," No AR Information exists!" G PAT
 S $P(LN1,"_",80)="",$P(LN2,"=",80)="",NAM=$$NAM^RCFN01(DEB),SSN=$E($$SSN^RCFN01(DEB),6,9),STD=$$PST^RCAMFN01(DEB) S:STD<1 STD="UNKNOWN"
 S PG=0 D HD
 I '$$EN^PRCAMRKC(DEB) W !!,"This patient's account is currently in balance!"
 E  W !!,"This account is out-of-balance!"
 D ST
 D ASK I CHK=1 D DEV
 G PAT
DEV W ! S IOP="Q",%ZIS="QN",%ZIS("B")="" D ^%ZIS G:POP OUT
 I '$D(IO("Q")) W !!,*7,"YOU MUST QUEUE THIS REPORT!!",! G DEV
 S ZTSAVE("DEB")="",ZTSAVE("NAM")="",ZTSAVE("SSN")="",ZTSAVE("STD")="",ZTRTN="EN^PRCAGDR",ZTDESC="AR DISCREPANCY REPORT" D ^%ZTLOAD G OUT
 Q
OUT D ^%ZISC
 K ^XTMP("PRCAGU",$J),COMM
 Q
CONT ;Ask to Continue
 ;N Y
 ;W !! S DIR(0)="E" D ^DIR I Y'=1 S DTOUT=1 Q
 Q
HD ;PAGE HEADING
 N DIR,Y S PG=PG+1
 W @IOF,!!,?3,NAM,"(",$E(NAM,1),SSN,")   ACCOUNT BALANCE DISCREPANCY REPORT"
 N %,%H,%I,X,Y
 D NOW^%DTC S Y=% D DD^%DT
 W !,?3,"STATEMENT DAY: ",STD,?46,Y,"    PAGE ",PG,!,LN2
HDQ Q
ASK ;Ask print statement
 N DIR,X,Y
 W ! S DIR("A")="Print example of patient statement",DIR(0)="Y" D ^DIR S CHK=Y
 Q
EN ;Enter here to print statement from queue
 N BN,DAT,PAGE,X,Y S PG=0,PAGE=0,$P(LN1,"_",80)="",$P(LN2,"=",80)=""
 D HD,ST
 Q
ST ;Start here find bills
 NEW BBAL,BEG,CHK,END,LDT3,PBAL,PDAT,PEND,SITE,TBAL,X,Y
 ; initialize variables for CS
 NEW CSBB,CSTCH,CSTPC,CSPREV S (CSBB,CSTCH,CSTPC)=0
 I 'STD D 9^PRCAGDT Q
 K ^TMP("PRCAGT",$J) D SITE^PRCAGU
 D NOW^%DTC S END=%,CHK=1,PBAL=0,DAT=$E(DT,1,5)_$S($L(STD)=1:0_STD,1:STD)
 S LDT3=$$FPS^RCAMFN01(DAT,-3)
 S BEG=$$LST^RCFN01(DEB,2) I $P(BEG,".")'<$P(DAT,".") D 8^PRCAGDT(BEG) Q
 I BEG<1 S PDAT="",BEG=0,PBAL=0
 I BEG S PDAT=BEG,BEG=9999999.999999-BEG D PBAL^PRCAGU(DEB,.BEG,.PBAL)
 D EN^PRCAGT(DEB,BEG,.END)
 S TBAL=0 D TBAL^PRCAGT(DEB,.TBAL)
 S BBAL=0 D BBAL^PRCAGU(DEB,.BBAL)
 I CSBB,CSBB'<BBAL Q  ; entire account has been referred to CS
 W !!,"Patient Statement Check:",!!
 S X=$$PRE^PRCAGU(DEB) S PEND=$P(X,U,2),X=+X
 I X,BBAL D 3^PRCAGDT Q
 I BBAL=0,PEND,-PEND=PBAL+TBAL D 2^PRCAGDT Q
 I BBAL'=(PBAL+TBAL) D 1^PRCAGDT(DEB,BBAL,.TBAL,PBAL,BEG) Q
 I BBAL=0,$G(SITE("ZERO")) D 4^PRCAGDT Q
 I BBAL'>0,'$D(^TMP("PRCAGT",$J,DEB)) D 5^PRCAGDT Q
 I BBAL<0,BBAL>-.99 D 6^PRCAGDT Q
 I BBAL'<0,'$D(^XTMP("PRCAGU",$J,DEB)),'COMM D 10^PRCAGDT Q  ;third letter printed, not comment
 S TBAL=TBAL+PBAL
 ;adjust amounts to be filed in 349.2 for CS bills
 S TBAL=TBAL-CSBB ; reduce the total bill balance by CS balance
 S CSPREV=CSBB-(CSTCH+CSTPC) ; compute the CS previous balance as the difference between the bill balance and the transaction balance
 S PBAL=PBAL-CSPREV ; reduce the previous balance by the CS previous balance
 S TBAL("CH")=TBAL("CH")-CSTCH ; reduce total charges by CS charges
 S TBAL("PC")=TBAL("PC")-CSTPC ; reduce total credits by CS credits
 I CHK=1 D OK^PRCAGDT
 K ^TMP("PRCAGT",$J)
 Q
