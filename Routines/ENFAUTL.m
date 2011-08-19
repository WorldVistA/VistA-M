ENFAUTL ;(WIRMFO)/DH/SAB-FAP Utilities ;1.12.98
 ;;7.0;ENGINEERING;**25,29,39,48**;August 17, 1993
CHKFA(DA) ;X returned
 ;piece 1 = 1 if FA current, 0 otherwise
 ;piece 2 = date/time of current FA
 ;piece 3 = date/time of current FD
 ;piece 4 = IEN of most recent FA
 N FADA,FADT,FDDT,J,K,L,X
 S K=0 F J=0:0 S J=$O(^ENG(6915.2,"B",DA,J)) Q:'J  S K=J
 S FADT=$S(K=0:"",1:$P(^ENG(6915.2,K,0),U,2))
 S L=0 F J=0:0 S J=$O(^ENG(6915.5,"B",DA,J)) Q:'J  S L=J
 S FDDT=$S(L=0:"",1:$P(^ENG(6915.5,L,0),U,2))
 S FADA=(FADT>FDDT)
 S X=FADA_U_FADT_U_FDDT_U_K
 Q X
 ;
DEC(X) ;Add decimal points if necessary
 ;X must be numeric
 N X1,X2,Y
 S X=$TR(X,"$")
 I X?1.12N1"."2N S Y=X G DECDUN
 I X=0 S Y="0.00" G DECDUN
 I X'["." S Y=X_".00" S:$L(Y)>15 Y="" G DECDUN
 S X1=$P(X,"."),X2=$P(X,".",2) I $L(X1)>12 S Y="" G DECDUN
 S Y=X1_"."_$E((X2_"00"),1,2)
DECDUN Q Y
 ;
CMRSTA ;Update STATION NUMBER in 6914 upon changes to 6914.1
 ;Triggered by 'AD' x-ref on 6914.1
 N EQ,CMR,STATION,DATE,I,X
 S %DT="T",X="N" D ^%DT,DD^%DT S DATE=Y
 S STATION("DEF")=$P(^DIC(6910,1,0),U,2)
 S CMR=DA,STATION=$P(^ENG(6914.1,CMR,0),U,7)
 S (EQ("COR"),EQ("UPDT"),EQ("FAP"))=0
 W !!,"Please bear with me as I attempt to update your Equipment File..."
 S I=0 F  S I=$O(^ENG(6914,"AD",CMR,I)) Q:I'>0  W:'(I#10) "." D
 . S STATION("EX")=$P($G(^ENG(6914,I,9)),U,5)
 . I STATION("EX")="",STATION=STATION("DEF") S $P(^ENG(6914,I,9),U,5)=STATION,EQ("UPDT")=EQ("UPDT")+1 Q
 . I STATION=STATION("EX") S EQ("COR")=EQ("COR")+1 Q
 . I $D(^ENG(6915.2,"B",I)),+$$CHKFA(I) S EQ("FAP")=EQ("FAP")+1,EQ("FAP",I)="" Q
 . S $P(^ENG(6914,I,9),U,5)=STATION,EQ("UPDT")=EQ("UPDT")+1
RSLTS ;Summarize the outcome
 W !!,(EQ("COR")+EQ("UPDT")+EQ("FAP"))," Equipment Records were examined."
 W !,EQ("COR")," were found to be correct as is."
 W !,EQ("UPDT")," were updated."
 I EQ("FAP")>0 D  G:'EQ("LIST") CMRXIT
 . S EQ("LIST")=0
 . W !,EQ("FAP")," have been sent to FAP under the old station number."
 . W !,"These ",EQ("FAP")," records can only be changed via FAP documents. You must",!,"do an FD, manually change the STATION NUMBER, and then do an FA."
 . S DIR(0)="Y",DIR("A")="Would you like a list of these "_EQ("FAP")_" records",DIR("B")="YES"
 . D ^DIR K DIR I $D(DIRUT)!(Y'>0) Q
 . S EQ("LIST")=1,%ZIS="QM" D ^%ZIS I POP S EQ("LIST")=0 Q
 . I $D(IO("Q")) D
 .. S ZTDESC="Equipment to be edited via FAP",ZTRTN="DQ^ENFAUTL"
 .. F I="EQ","CMR","STATION","DATE" S ZTSAVE(I)=""
 .. S EQ("LIST")=0 D ^%ZTLOAD,HOME^%ZIS K ZTSK
 I EQ("FAP")'>0 G CMRXIT
 ;
DQ ;Print the FAP list
 N END,ENL,ENPG
 U IO
 S (END,ENPG)=0,$P(ENL,"-",(IOM-2))="-" D HD
 S I=0 F  S I=$O(EQ("FAP",I)) Q:I'>0  D  Q:END
 . W !,?10,I
 . I $Y+4>IOSL,$O(EQ(I))>0 D HD
 ;
CMRXIT ; Exit CMRSTA
 Q
 ;
HD ;Report header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W "Equipment Not Updated at time of CMR STATION NUMBER change"
 W ?(IOM-10),"Page ",ENPG
 W !,"  because the Equipment was Reported to FAP."
 W !,"CMR: ",$P(^ENG(6914.1,CMR,0),U),?20,"New STATION NUMBER: ",STATION
 W !,"Date of change: ",DATE
 W !,ENL
 Q
 ;
CC(STATION,CMR) ;Is putative STATION NUMBER consistent with CMR
 N X,X1,X2 I STATION'?3N.2UN S X=0 G CCDUN
 S X=1,X1=$E(STATION),X2=$E(CMR,1,2)
 I "89"[X1,"57^58"'[X2 S X=0 G CCDUN
 I X1=3,$E(X2)'=6 S X=0
CCDUN Q X
 ;
DATE(TYPE) ;Get dates for FAP docs
 ;Returns ENFAP("DT")
 S %DT("A")=TYPE_" DATE: ",%DT="AE"
DT D ^%DT I Y'>0 S ENFAP("DT")=+Y Q
 I $E(Y,4,5)="00" W !,$C(7),"Month is required." G DT
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 S ENFAP("DT")=+Y
 Q
 ;
CMRCC(ENI) ; CMR (#6914.1) file COST CENTER computed field
 ; in ENI (ien of CMR)
 N ENCC,ENX
 S ENCC=""
 S ENX=$E($G(^ENG(6914.1,ENI,0)),1,2)
 S ENX(0)=$S(ENX]"":$O(^ENG(6914.9,"B",ENX,0)),1:"")
 S:ENX(0) ENCC=$P($G(^ENG(6914.9,ENX(0),0)),U,3)
 Q ENCC
 ;
 ;ENFAUTL
