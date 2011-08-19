PRCHEC1 ;SF-ISC/TKW-SUPPLEMENTAL ROUTINES CALLED FROM PRCHEC ;4/20/92  9:41 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EDIT G:$D(PRCHENT) E2 G:$D(PRCHISMS) E2
 S %A=" Do you want to generate the codesheets",%B=" Answer NO if you do not wish to build the LOG codesheets at this time.",%=1 D ^PRCFYN I %=-1 K PRCHPO Q
 G:%=1 E2 W !!," Do you want to remove this P.O. or Receiving Report from the list of",!,"pending codesheets?"
 S %A="REMOVE FROM LIST",%B="If you answer YES, and later want to generate codesheets, you will have",%B(1)="to use the 'Create a Codesheet' option.",%=2 D ^PRCFYN D:%=1 R K PRCHPO
 Q
 ;
E2 S PRCHPONO=$P(^PRC(442,PRCHPO,0),U,1)
 S X=$G(^PRC(442,PRCHPO,17)),Y=$G(^(18))
 W !!,"P.O.(PAT) No.: "_PRCHPONO,!,"Document Identifier: ",$P(Y,U,3) W:PRCHN("SC")=1 ?35,"Requisition Number: ",$P(Y,U,10) W !
 W:PRCHN("SFC")'=2&(PRCHN("SC")'=0) "Department No.: ",$P(X,U,1),! W "Source Code: "_PRCHN("SC"),!
 Q:$D(PRCHISMS)  G:PRCHTYP'="R" EDIT1
 W !,"Payable Code: "_$P(Y,U,2),!
 W "Reason Code: "_$P(X,U,14),!,"DEPOT (or Releasing Facility): ",$P(Y,U,1)
 I PRCHN("SC")=1 W ?45,"Depot Voucher No.: ",$P($G(^PRC(442,PRCHPO,1)),U,13)
 W ! I PRCHN("SFC")'=2 W $C(7),!,"  *** ENTER DIETETICS COST PERIOD IF THIS IS A SUBSISTANCE ORDER ***",!,?5,"****  Dietetics Cost Period: "_$P($G(^PRC(442,PRCHPO,11,PRCHRPT,1)),U,2),!! G EDIT2
 ;
EDIT1 G:PRCHN("SC")'=0 EDIT2
 W !,"Document Identifier Code: "_$P(X,U,2),?38,"Routing Identifier Code: "_$P($G(^PRCD(441.4,+$P(X,U,3),0)),U,1)
 W !,"Media & Status Code: "_$P($G(^PRCD(441.4,+$P(X,U,11),0)),U,1),?38,"Activity Address Code: "_$P(X,U,16)
 W !,"Dept.Designation (Demand Code): "_$P($G(^PRCD(441.4,+$P(X,U,4),0)),U,1),?38,"Fund Code: "_$P(X,U,6),!,"Distribution Code: "_$P(X,U,7),?38,"Project Code: "_$P(X,U,8)
 W !,"Priority Code: "_$P($G(^PRCD(441.4,+$P(X,U,9),0)),U,1),?38,"Advice Code: "_$P($G(^PRCD(441.4,+$P(X,U,10),0)),U,1),!!
 ;
EDIT2 S %A="Do you wish to pre-edit codesheet data ",%B="This data will go on every code sheet.  'NO' will cause the",%B(1)="code sheets to be built with the data as shown,",%B(2)="'^' to quit.",%=2 D YN^PRCFYN
 K:%=-1 PRCHPO Q:%'=1  W !!! K DIE,DA,DR S DIE="^PRC(442,",DA=PRCHPO,DR=102 S:PRCHN("SC")=1 DR=DR_";102.4" S:PRCHN("SFC")'=2&(PRCHN("SC")'=0) DR=DR_";70"
 I PRCHTYP="R" S:PRCHN("SFC")=2 DR=DR_";83//^S X=1" S:PRCHN("SC")=1 DR=DR_";107;.09" S DR=DR_";101"
 S:PRCHTYP="A"&(PRCHN("SC")=0) DR=DR_";71;72;80;72.4;73;75;76;77;78;79"
 D ^DIE K DIE,DA,DR I PRCHTYP="R",PRCHN("SFC")'=2 S DIE="^PRC(442,"_PRCHPO_",11,",DA(1)=PRCHPO,DA=PRCHRPT,DR=20 D ^DIE K DIE,DA,DR
 Q:PRCHTYP'="R"  Q:PRCHN("SFC")'=2  W !!!,"Select any items for which you wish to enter a source deviation code.",!
 ;
EDIT3 S DIC="^PRC(442,"_PRCHPO_",2,",DA(1)=PRCHPO,DIC(0)="AEQM" D ^DIC I Y>0 S DIE=DIC,DA=+Y,DR=39.5 D ^DIE G EDIT3
 Q
 ;
SETUP S PRCHN("SC")="" I $D(^PRC(442,PRCHPO,1)) S PRCHN("SC")=$S($D(^PRCD(420.8,+$P(^(1),U,7),0)):$P(^(0),U,1),1:"") S:"013"[PRCHN("SC") PRCHNRQ=1
 S PRCHN("MP")=$P($G(^PRCD(442.5,+$P(^PRC(442,PRCHPO,0),U,2),0)),U,3)
 S PRCHN("SFC")=$P(^PRC(442,PRCHPO,0),U,19),PRCHEMG=$P($G(^(1)),U,17)
 Q
 ;
OBL Q:'$P(^PRC(442,PRCHPO,0),U,12)  I $D(^PRC(442,PRCHPO,18)),$P(^(18),U,12) W $C(7),!!!,"Control Point Obligated Balances have already been updated.",!! Q
 W !! S %A="  Update Control Point Obligated Balance",%B="  Review the Order first to make sure it is correct. This step should be",%B(1)="done to make sure the Control Point Balance matches CALM."
 S %=2 D ^PRCFYN I %'=1 K PRCHPO Q
 D OBL^PRCHNRQ
 Q
 ;
ASK ;Ask user if they want to report showing code sheets to be created
 W !!!,$C(7),"**** Do you want to print a report showing code sheets to be created? ****" S %A="PRINT REPORT",%B="Answer 'Y' to see what orders have not yet had code sheets generated",%=2
 D YN^PRCFYN
 Q
 ;
R ;REMOVE P.O. OR RECEIVING REPORT FROM PENDING LIST
 I PRCHTYP="A" K ^PRC(442,"AE","N",PRCHPO) Q
 I PRCHTYP="R" K ^PRC(442,"AF","N",PRCHPO,PRCHRPT)
 Q
