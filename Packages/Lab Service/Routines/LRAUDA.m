LRAUDA ;AVAMC/REG/WTY/KLL - AUTOPSY PATH DATA ENTRY ;08/20/01
 ;;5.2;LAB SERVICE;**72,248,259,322**;Sep 27, 1994
 ;
L ;Define AU Section
 S LRDICS="AU",LRQUIT=0,XPAD=""
 D ^LRAP
 I '$D(Y) D
 .S LRQUIT=1
 Q
P ;Autopsy Protocol
 D L
 I LRQUIT D END Q
 D PDR
 S LRSOP="P",LR(6)=1
 D EDIT
 Q
PDR ;Entry for resetting DR string
 K DR
 ;KLL-RESET PAD SEPARATE FROM PROTOCOL
 S:XPAD'="D" DR="13;13.01///^S X=LRWHO;32.1;32.2;32.3;99"
 S:XPAD="D" DR="13.01///^S X=LRWHO;32.2;32.3;14.9"
 Q
PAD ;Provisional Anatomic Diagnoses
 D L
 I LRQUIT D END Q
 K DR S DR="13.01///^S X=LRWHO;32.2;32.3;14.9"
 ;KLL-S XPAD=D TO KEEP PAD SEPARATE FROM PROTOCOL
 S XPAD="D"
 ;
 S LRSOP="P",LR(6)=1
 D EDIT
 Q
 ;
S ;Special Studies
 D L
 I LRQUIT D END Q
 K DR
 S DR="N LRREL D RELEASE^LRAPUTL(.LRREL,LRDFN,LRSS) "
 S DR=DR_"I LRREL(1) D VMSG^LRAUDA S Y=0;32"
 S DR(2,63.2)=".01;5"
 D EDIT
 Q
B ;Autopsy Report/SNOMED Coding
 D L
 I LRQUIT D END Q
 S LR(2)=1
 D BDR
 D EDIT
 Q
BDR ;Entry for resetting DR string
 K DR S DR="13;13.01///^S X=LRWHO;32.1;32.2;32.3;99;32"
 S DR(2,63.2)=".01;I '$D(LR(1)) S Y=4;1;1.5;3;4"
 S DR(3,63.21)=".01",DR(3,63.22)=".01;I '$D(LR(1)) S Y=0;1"
 S DR(3,63.24)=".01;S:'$P(^LAB(61.5,X,0),U,3) Y=0;.02"
 S DR(4,63.23)=".01",LRSOP="B"
 Q
 ;
A ;Autopsy Report/ICD9CM Coding
 D L
 I LRQUIT D END Q
 D ADR
 S LRSOP="A"
 D EDIT
 Q
ADR ;Entry for resetting DR string
 K DR S DR="13;13.01///^S X=LRWHO;32.1;32.2;32.3;99;80"
 Q
R ;Autopsy Supplementary Report
 D L
 I LRQUIT D END Q
 S LRSOP="R",LRSFLG="S"
 D EDIT
 K LRSFLG
 Q
I ;ICD9CM coding
 D L
 I LRQUIT D END Q
 I '$D(Y) D END Q
 S DR=80,LRSOP="I"
 D EDIT
 Q
F ;Final Anatomic DX Date
 D L
 I LRQUIT D END Q
 K DR S DR="13.1;83.1;83.2"
 S LRSOP="F"
 D EDIT
 Q
VMSG ;Verified message
 N LRMSG
 S LRMSG=$C(7)_"Report verified.  Cannot edit with this option."
 D EN^DDIOL(LRMSG,"","!!")
 Q
EDIT ;
 D ^LRAPDA
END ;
 K LRQUIT
 D V^LRU
 Q
