LBRYPRCM ;SSI/ALA-PROCESS FORUM TRANSACTIONS MANUALLY ;[ 05/23/97  12:13 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
 ;  This is to manually process the library transactions
 ;  received from FORUM and not updated automatically
 S TRN="",CT=0
TR S TRN=$O(^LBRY(682.1,"AC","M",TRN)) G EXIT:TRN=""
 S TYP=$P(^LBRY(682.1,TRN,0),U,2) K %,LBRANS
 F I=1:1:4 S LBDATA(I)=$G(^LBRY(682.1,TRN,I))
 S TAF=$P(LBDATA(1),U,2),LDA=$P(LBDATA(1),U,3)
 G TR:TAF=""
 I LDA'="",$G(^LBRY(680.5,LDA,0))="" G TR
 S TIT=$P(LBDATA(1),U),CT=CT+1
 I $D(^LBRY(680.5,TAF,0)),TIT'[$P(^LBRY(680.5,TAF,0),U) D DSP G TR:$G(LBRANS)="N",EXIT:$G(LBRANS)=""
 D TI
TR1 S DIC="^LBRY(682.1,",DIE=DIC,DA=TRN,DR="2///^S X=""P""" D ^DIE
 K CHD,FX,TX,ND1,PC1,ND2,PC2,FR,TO,PF,PT,PO,GLB,IN,INP,DR,DIE,DIC,DA
 K D,D0,X,LBRYCLS,LBDATA,LDA,TAF,TYP,QFL,FLG,LBRANS,%,OTIT,NTIT,TIT
 G TR
TI ;  Update a title from a transaction
 I LDA'="" S DA=LDA D ^LBRYX51
 S LBRYCLS=TAF,$P(^LBRY(680.5,LBRYCLS,0),U)=$P(LBDATA(1),U)
 S FLG=$S(LDA'="":$P(^LBRY(680.5,LDA,0),U,2),TAF'="":$P(^LBRY(680.5,TAF,0),U,2),1:"")
 ;  Move the data from the transaction into the Title Authority File
 S TX="0;5^0;6^3;5^3;8^3;1^3;3^3;4",FX="1;4^2;1^2;2^3;1^3;3^4;2^4;3"
 F I=1:1:7 S FR=$P(FX,U,I),TO=$P(TX,U,I) D
 . S ND1=$P(FR,";"),PC1=$P(FR,";",2),ND2=$P(TO,";"),PC2=$P(TO,";",2)
 . S $P(^LBRY(680.5,LBRYCLS,ND2),U,PC2)=$P($G(^LBRY(682.1,TRN,ND1)),U,PC1)
 S PF="2;3-680.5^3;2-680.5^4;1-680.1^4;4-680.2^4;5-680.9",PT="3;6^3;7^3;2^0;4^0;3"
 F I=1:1:5 S FR=$P(PF,U,I),TO=$P(PT,U,I) D
 . S PO=$P(FR,"-"),GLB=$P(FR,"-",2)
 . S ND1=$P(PO,";"),PC1=$P(PO,";",2),ND2=$P(TO,";"),PC2=$P(TO,";",2)
 . S CH=$P($G(^LBRY(682.1,TRN,ND1)),U,PC1),CHD=CH
 . I CH'="" S J="" F  S J=$O(^LBRY(GLB,"B",$E(CH,1,30),J)) Q:J'>0  S:$P(^LBRY(GLB,J,0),U)=CH CHD=J
 . S $P(^LBRY(680.5,LBRYCLS,ND2),U,PC2)=CHD
 I $D(^LBRY(682.1,TRN,6)) S IN=0 F  S IN=$O(^LBRY(682.1,TRN,6,IN)) Q:IN'>0  D
 . S INP=^LBRY(682.1,TRN,6,IN,0)
 . S ^LBRY(680.5,LBRYCLS,1,IN,0)=$S($D(^LBRY(680.8,"B",INP)):$O(^LBRY(680.8,"B",INP,"")),1:INP)
 . S ^LBRY(680.5,LBRYCLS,1,0)="^680.53PA^"_IN_U_IN
 I $D(^LBRY(682.1,TRN,7)) S IN=0 F  S IN=$O(^LBRY(682.1,TRN,7,IN)) Q:IN'>0  D
 . S ^LBRY(680.5,LBRYCLS,2,IN,0)=^LBRY(682.1,TRN,7,IN,0)
 . S ^LBRY(680.5,LBRYCLS,2,0)="^680.54^"_IN_U_IN_U_DT
 S $P(^LBRY(680.5,LBRYCLS,0),U,5)="N",$P(^(0),U,2)=FLG
 I $F("CTI,TIC,LTR",TYP) S DA=LDA,DIK="^LBRY(680.5," D ^DIK
 S DA=LBRYCLS D ^LBRYX53
 I LDA'="" S LBRTDA="" D
 . F  S LBRTDA=$O(^LBRY(680,"B",LDA,LBRTDA)) Q:LBRTDA=""  D
 . . S DR=".01///^S X=TAF",DIC="^LBRY(680,",DIE=DIC,DA=LBRTDA D ^DIE
 Q
EXIT I CT=0 R !!,"No transactions to process.  Press Return to continue: ",C:DTIME
 K CHD,FX,TX,ND1,PC1,ND2,PC2,FR,TO,PF,PT,PO,GLB,IN,INP,DR,DIE,DIC,DA
 K D,D0,X,LBRYCLS,LBDATA,LDA,TAF,TRN,QFL,FLG,CT,C,OTIT,NTIT,TIT,%
 K LBRANS
 S $P(^LBRY(680.5,0),U,3)=99000
 Q
DSP ; Display differences and ask for override
 S OTIT="" I LDA'="" S OTIT=$P($G(^LBRY(680.5,LDA,0)),U)
 I OTIT="" S OTIT=$P($G(^LBRY(680.5,TAF,0)),U)
 S NTIT=$P($G(^LBRY(682.1,TRN,1)),U)
 W !!,"OLD TITLE: "_OTIT
 W !!,"NEW TITLE: "_NTIT
QS W !!,"Overwrite OLD TITLE with NEW TITLE " D YN^DICN
 I %=0 W !!,"Please answer 'Y' to correct old title or 'N' to not process this title" G QS
 S LBRANS=$S(%=1:"Y",%=2:"N",1:"")
 Q
