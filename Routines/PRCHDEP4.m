PRCHDEP4 ;WISC/RWS-SUPPLEMENTAL ROUTINES CALLED FROM PRCHDEP3 ;4/20/92  9:34 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EDIT G:$D(PRCHENT) E2 S %A=" Do you want to generate the codesheets",%B=" Answer NO if you do not wish to build the LOG codesheets at this time.",%=1 D ^PRCFYN I %=-1 K PRCHPO Q
 G:%=1 E2 W !!," Do you want to remove this P.O. or Receiving Report from the list of",!,"pending codesheets?"
 S %A="REMOVE FROM LIST",%B="If you answer YES, and later want to generate codesheets, you will have",%B(1)="to use the 'Create a Codesheet' option.",%=2 D ^PRCFYN D:%=1 R S DA=PRCHPO,DIC="^PRC(442," D UNLCK^PRCHDEP3 K PRCHPO Q
E2 S PRCHPONO=$P(^PRC(442,PRCHPO,0),U,1)
 S X=$G(^PRC(442,PRCHPO,17)),Y=$G(^(18))
 W !!,"P.O.(PAT) No.: "_PRCHPONO,!,"Document Identifier: ",$P(Y,U,3) W:PRCHN("SC")=1 ?35,"Requisition Number: ",$P(Y,U,10) W !
 W:PRCHN("SFC")'=2&(PRCHN("SC")'=0) "Department No.: ",$P(X,U,1),! W "Source Code: "_PRCHN("SC"),!
 Q
 ;
SETUP ;S PRCHN("SC")="" I $D(^PRC(442,PRCHPO,1)) S PRCHN("SC")=$S($D(^PRCD(420.8,+$P(^(1),U,7),0)):$P(^(0),U,1),1:"") S:"013"[PRCHN("SC") PRCHNRQ=1
 S PRCHN("SC")="" I $D(^PRC(442,PRCHPO,1)) S PRCHN("SC")=$P($G(^PRCD(420.8,+$P(^(1),U,7),0)),U,1) S:"013"[PRCHN("SC") PRCHNRQ=1
 ;S PRCHN("MP")=$S($D(^PRCD(442.5,+$P(^PRC(442,PRCHPO,0),U,2),0)):$P(^(0),U,3),1:"")
 S PRCHN("MP")=$P($G(^PRCD(442.5,+$P(^PRC(442,PRCHPO,0),U,2),0)),U,3)
 ;S PRCHN("SFC")=$P(^PRC(442,PRCHPO,0),U,19),PRCHEMG=$S($D(^(1)):$P(^(1),U,17),1:"") Q
 S PRCHN("SFC")=$P(^PRC(442,PRCHPO,0),U,19),PRCHEMG=$P($G(^(1)),U,17)
 Q
 ;
OBL Q:'$P(^PRC(442,PRCHPO,0),U,12)  I $D(^PRC(442,PRCHPO,18)),$P(^(18),U,12) W $C(7),!!!,"Control Point Obligated Balances have already been updated.",!! Q
 W !! S %A="  Update Control Point Obligated Balance",%B="  Review the Order first to make sure it is correct. This step should be",%B(1)="done to make sure the Control Point Balance matches CALM."
 S %=2 D ^PRCFYN I %'=1 K PRCHPO Q
 D OBL^PRCHNRQ
 Q
 ;
ASK W !!!,$C(7),"**** Do you want to print a report showing code sheets to be created? ****" S %A="PRINT REPORT",%B="Answer 'Y' to see what orders have not yet had code sheets generated",%=2
 D YN^PRCFYN
 Q
 ;
R ;REMOVE P.O. OR RECEIVING REPORT FROM PENDING LIST
 I PRCHTYP="A" K ^PRC(442,"AE","N",PRCHPO) Q
 I PRCHTYP="R" K ^PRC(442,"AF","N",PRCHPO,PRCHRPT)
 Q
 ;
EN001 S PRCFA("DICS")="I Y=401",PRCFA("TTF")=401
 D GT^PRCHEC I '% D UNLCK^PRCHDEP3 G EN01^PRCHDEP3
 D B401
 D SC^PRCHCS0
 D ^PRCHCS
 G EN01^PRCHDEP3
 ;
B401 ;DEPOT DUE-IN TRANSACTION 401
 S PRCHTP(1,1)="S X=PRCHPO;344",PRCHTP(1,2)=".1;385",PRCHTP(1,3)="D DOCID^PRCHCS2;344",PRCHTP(1,4)="7;406"
 S PRCHTP(1,5)="D:'$D(PRCFA(1)) DEFAULT^PRCHDEP4 S X=PRCFA(1);408"
 S PRCHTP(1,6)="S X=PRCFA(2);384"
 S PRCHTP(1,7)="S Y=$E(PRCFA(3),1,5),PRCFLN=5 D LZF^PRCFU S X=Y K Y;386"
 S PRCHTP(1,8)="S X=PRCFA(4);387"
 S PRCHTP(1,9)="S X=401;3"
 S PRCHTP(1,10)="S X=1;396"
 S PRCHTP(1,11)="S X="" "";389"
 S PRCHTP(1,12)="S X=""00000"";390"
 S PRCHTP(1,13)="S X=""00000"";391"
 S PRCHTP(1,14)="S X=""00000"";392"
 S PRCHTP(2,1)=".01;300",PRCHTP(2,2)="2;405",PRCHTP(2,3)="S X=$P(PRCHDIC1(2,0),U,13),X=$P(X,""-"",2)_$P(X,""-"",3)_$P(X,""-"",4);308",PRCHTP(2,4)="3;303",PRCHTP(2,5)="5;388"
 Q
 ;
DEFAULT S DR="[PRCH-DEP LOG 401]",DIE=423 D ^DIE
 Q:'$D(^PRCF(423,DA,0))  S PRCFA(1)=$P(^(304),U,16)
 S PRCFA(2)=$P(^PRCF(423,DA,302),U,9)
 S PRCFA(3)=$P(^PRCF(423,DA,303),U,1)
 S PRCFA(4)=$P(^PRCF(423,DA,303),U,2)
 Q
 ;
B431 ;DEPOT 431 AND 434 TRANSACTIONS
 S PRCHTP(1,1)="S X=PRCHPO;5.1"
 S PRCHTP(2,1)=".01;300"
 Q
