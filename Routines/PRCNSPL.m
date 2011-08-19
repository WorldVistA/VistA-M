PRCNSPL ;SSI/SEB-Split a request ;[ 09/09/96  10:43 AM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
 S DIC("S")="S ST=$P(^(0),U,7) I ST=1!(ST=4)!(ST=11)!(ST=12)!(ST=14)!(ST=15)!(ST=16)!(ST=17)!(ST=29)!(ST=37)!(ST=40)&($P(^(0),U,2)=DUZ)"
 S DIC="^PRCN(413,",DIC(0)="AEQZ" D ^DIC G:Y<0 EXIT S DA=+Y K DIC("S")
 S PTRN=$P(^PRCN(413,DA,0),U)
INIT S N=413.015,PRCNUSR=($P(^PRCN(413,DA,0),U,7)>1),(FF,NL,IN)=0
 S GLO=DIC_DA_",1,",PRCNDEEP=1,PROG="PRNT" D:'$D(IOT) HOME^%ZIS
 S DIC="^PRCN(413,"
LOOP G:$D(NEW) NEW S (II,JJ)=0
 F  S IN=$O(^PRCN(413,DA,1,IN)) Q:'+IN!($D(DUOUT))  W ! D SUBS^PRCNPRNT,ASK
 K PRCNDEEP,N,FN,PRFLD,PRCNUSR
 G:$D(DUOUT) EXIT
 I '$D(NEW) W $C(7),!!,"You didn't select any line items! Request not split." G EXIT
 I II=$P(^PRCN(413,DA,1,0),U,4) W $C(7),!!,"You selected all of the line items! Request not split." G EXIT
 S IN=DA
NEW ; Get new request # and build a new request
 G:$D(DUOUT) EXIT
 W !!,"Splitting this request. Please wait..."
 D FSF S ODA=IN
 S X=PTRN_SUF W !,"NEW TRANSACTION NUMBER: ",X S NTRN=X
 S DIC="^PRCN(413,",DIC(0)="LQZ",DLAYGO=413 D FILE^DICN Q:+Y<1  S (NDA,DA)=+Y
 S $P(^PRCN(413,DA,0),U,2,99)=$P(^PRCN(413,ODA,0),U,2,99)
 S GL="^PRCN(413,"_ODA_",1.9)"
 F  S GL=$Q(@GL) Q:GL'[("413,"_ODA)  S @("^PRCN(413,"_DA_","_$P(GL,",",3,99))=@GL
LINE ; Copy over line items, remove line items from orig. request
 F PRCNI=1:1 S PRCNJ=$P(NEW,U,PRCNI) Q:PRCNJ=""  D
 . I $G(^PRCN(413,NDA,1,0))="" S ^PRCN(413,NDA,1,0)="^413.015A^^"
 . S X=$P(^PRCN(413,ODA,1,PRCNJ,0),U),DLAYGO=413.015,DIC(0)="L",DA(1)=NDA
 . S DIC="^PRCN(413,"_DA(1)_",1," D FILE^DICN S DA=+Y
 . S %X="^PRCN(413,"_ODA_",1,"_PRCNJ_",",%Y="^PRCN(413,"_DA(1)_",1,"_DA_","
 . D %XY^%RCR
 S DA(1)=ODA,DIK="^PRCN(413,"_DA(1)_",1,"
 F PRCNI=1:1 S PRCNJ=$P(NEW,U,PRCNI) Q:'PRCNJ  S DA=PRCNJ D ^DIK
 S X=$P(^PRCN(413,ODA,2),U,18) D
 . D:'$D(PSER) PRIMAX^PRCNCMRP
 . S RNK="" F  S RNK=$O(^PRCN(413,"P",PSER,RNK)) Q:RNK=""  K ^PRCN(413,"P",PSER,RNK,ODA)
 . K PSER,X,RNK,LPRI,II,PRIMAX
 S X=$P(^PRCN(413,NDA,2),U,18) D
 . D:'$D(PSER) PRIMAX^PRCNCMRP
 . S RNK="" F  S RNK=$O(^PRCN(413,"P",PSER,RNK)) Q:RNK=""  K ^PRCN(413,"P",PSER,RNK,NDA)
 . K PSER,X,RNK,LPRI,II,PRIMAX
MKREP D:$P(^PRCN(413,ODA,0),U,9)="R" REPL
EXIT K DUOUT,II,JJ,TST,REQ,PRCNDEL,DIC,IEXP,IEXN,PI,ODA,ORDA,PRCNJ,PRCNI
 K C,CODES,D0,DA,FF,GLO,I,ID,J,N2,NEW,NL,OGLO,OID,OIN,OPC,PC,PGL
 K PRCNDD,PROG,PTRN,PV,ST,X,Y,VAL,V,%,%Y
 Q
REPL ; Split replacement request
 S ORDA=$P(^PRCN(413,ODA,0),U,11),REQ=$P(^PRCN(413.1,ORDA,0),U),TST=$P(REQ,"-",1,3)
 NEW NDA D SEQ^PRCNUTL S TST=TST_"-" S:REQ["P" TST=TST_"P"
 S DIC="^PRCN(413.1,"
 S DLAYGO=413.1,X=TST_$E("00000",$L(PRCNDA)+1,5)_PRCNDA_SUF D ^DIC Q:Y<0
 S RDA=+Y,GL="^PRCN(413.1,"_ORDA_",1.9)",II=1,(I,J,JJ)=0,PRCNDEL=""
 S $P(^PRCN(413.1,RDA,0),U,2)=$P(^PRCN(413.1,ORDA,0),U,2,99)
 S $P(^PRCN(413.1,RDA,0),U,9)=DA,$P(^PRCN(413,DA,0),U,11)=RDA
 F  S GL=$Q(@GL) Q:GL'[("413.1,"_ORDA)  D
 . S @("^PRCN(413.1,"_RDA_","_$P(GL,",",3,99))=@GL
REPLINE F I=1:1 S II=$P(NEW,U,I) Q:II=""  D
 . S JJ=0 F  S JJ=$O(^PRCN(413.1,ORDA,1,JJ)) Q:'+JJ  D
 .. I $P(^PRCN(413.1,ORDA,1,JJ,0),U,3)'=II S:$P(PRCNDEL,U,JJ)'=0 $P(PRCNDEL,U,JJ)=1 Q
 .. S J=J+1,^PRCN(413.1,RDA,1,J,0)=^PRCN(413.1,ORDA,1,JJ,0),TI=+^(0)
 .. S $P(^PRCN(413.1,RDA,1,J,0),U,3)=I,$P(PRCNDEL,U,JJ)=0
 .. S ^PRCN(413.1,RDA,1,"B",TI,J)=""
 S ^PRCN(413.1,RDA,1,0)="^413.11IPA^"_J_U_J Q:OLD=""
REPDEL ; Compress unmoved items and delete moved line items in orig. request
 S L=0,O=1 F I=1:1 S II=$P(PRCNDEL,U,I) Q:II=""  S:O&('II) L=I D  S O=II
 . I II&(O'=II) S $P(PRCNDEL,U,I)=0,$P(PRCNDEL,U,L)=1,I=L D
 .. S ^PRCN(413.1,ORDA,1,L,0)=^PRCN(413.1,ORDA,1,I,0)
 .. S $P(^PRCN(413.1,ORDA,1,L,0),U,3)=L
 Q:L<1  F J=L:1:I-1 S LI=+^PRCN(413.1,ORDA,1,J,0) D
 . K ^PRCN(413.1,ORDA,1,"B",LI,J),^PRCN(413.1,ORDA,1,J)
 Q
ASK S %=1 W !!,"Transfer this line item to the new request" D YN^DICN
 S:%=-1 DUOUT=1 I %=0 W !,"Answer 'Y' for yes, and 'N' for no." G ASK
 S:%=1 II=II+1,$P(NEW,U,II)=IN S:%=2 JJ=JJ+1,$P(OLD,U,JJ)=IN
 Q
FSF ; Find new transaction number
 S SUF="",SFL=0
 F BSF=65:1:90 S TTRN=PTRN_$C(BSF) D  Q:SFL=1
 . I '$D(^PRCN(413,"B",TTRN)) S SFL=1,SUF=$C(BSF) Q
 K TTRN,BSF,SFL
 Q
