PRCH410 ;WISC/KMB/DXH/DGL - CREATE 2237 FROM PURCHASE CARD ORDER ; 4/4/00 7:56am
 ;;5.1;IFCAP;**123,171,181,186**;Oct 20, 2000;Build 10
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; prcsip is package-wide variable for inv pt that may or may not be
 ; passed to this routine
 ;
 ;PRC*5.1*181 Split the update for setting File 442, node 23 piece 23
 ;            (410 pointer) and piece 13 (sort group) into two sets,
 ;            410 pointer before the Sort Group query and Sort Group
 ;            after. This eliminates a user crashing at Sort Group
 ;            query and creating 2 410 entries due to missing 410 
 ;            pointer in file 442 that was not set due to Sort
 ;            Group query failure. 
 ;
 ;PRC*5.1*186 RGB 7/1/2014 Fix for 3 Remedy tickets:
 ;            INC752542 Fix duplicate entries in file 443 by changing 
 ;                      the direct field 1.5 and x-ref 'AC' set to 
 ;                      Fileman update of status field.
 ;            INC952389 Modify logic to insure when All/Delivery switch
 ;                      is set that the DO affects the Running Balance 
 ;                      report when auto obligated. Also, modified the
 ;                      EDI check in same area for logic clarity.
 ;
START ;
 N VV,ST,Y,Z,Z0,Z1,Z2,I,J,CCEN,ESTS,NET,SERV,EMER,COUNT,COUNT1,L,PDUZ,FY,QTR,CP,LOC,ADATE,TDATE,SDATE,LL,PC,PCREF,XDA
 N SCP,SGRP,COR,VEN,VEND
 Q:'$D(DA)  Q:+DA=0  S XDA=DA
 S Z0=$G(^PRC(442,XDA,0)),PRC("SITE")=$P(Z0,"-"),CP=$P(Z0,"^",3),SCP=$P(CP," "),PRC("SST")=$P($G(^PRC(442,XDA,23)),"^",7),PCREF=$P(Z0,"^"),PCREF=$P(PCREF,"-",2)
 S TDATE=$$DATE^PRC0C($P($G(^PRC(442,XDA,1)),"^",15),"I"),PRC("FY")=$E(TDATE,3,4),PRC("QTR")=$P(TDATE,"^",2),(TDATE,SDATE)=$P($$DATE^PRC0C("T","E"),"^",7)
 S CCEN=$P(Z0,"^",5),ESTS=$P(Z0,"^",13),ADATE=$P(Z0,"^",10)
 I CCEN'="" S CCEN=$E($P(^PRCD(420.1,CCEN,0),"^"),1,30)
 S Z1=$G(^PRC(442,XDA,1)),(VV,VEND)=$P(Z1,"^"),SERV=$P(Z1,"^",2),EMER=$P(Z1,"^",17),LOC=$P(Z1,"^",11),PDUZ=DUZ
 S ST="ST" S:EMER="Y" ST="EM"
 S PRC("CP")=+SCP
 I $G(PRCSIP) I '$O(^PRC(420,PRC("SITE"),1,PRC("CP"),7,"B",PRCSIP,0)) K PRCSIP ; Kill inventory point if not match FCP
 I '$G(PRCSIP) S J=0 F  S J=$O(^PRC(442,XDA,2,J)) Q:'J!($G(PRCSIP))  S K=0 F  S K=$O(^PRC(442,XDA,2,J,5,0)) Q:'K!($G(PRCSIP))  S PRCSIP=$P($G(^PRC(442,XDA,2,J,5,K,0)),U)
IP D:'$G(PRCSIP) IP^PRCSUT
 I '$G(PRCSIP),$O(^PRC(420,PRC("SITE"),1,PRC("CP"),7,0)) D  I Y=0 G IP
 . K DIR S DIR("A")="** WARNING ** No inventory point selected - Continue anyway",DIR("B")="NO",DIR(0)="Y"
 . S DIR("?",1)="The FCP you entered has Inventory points associated with it, but none have been selected."
 . S DIR("?")="Press 'Y' to return to the inventory point prompt or 'N' to continue the order without one."
 . D ^DIR K DIR
 . I $E(X)="^"!(Y=1) W !,"No inventory point was attached.",! Q
 . Q
 S PC=$P($G(^PRC(442,XDA,23)),"^",8)
 S COUNT=$P($G(^PRC(442,XDA,2,0)),"^",4) I +COUNT'=0 D ITEM I $G(X)="#",$G(PRCRMPR)=1 Q
 S CDA=$P($G(^PRC(442,XDA,23)),"^",23)
 S:$G(PRCHPC)=3 CDA=$P($G(^PRC(442,XDA,13,0)),U,3)
 I CDA="" D REC Q:CDA=""
 S CCDA=CDA
SET ;set item data and vendor on record
 L +^PRCS(410,CDA):15 Q:'$T
 ;
 I VEND'="",$P($G(^PRC(440,VEND,0)),"^")'="SIMPLIFIED" S ^PRCS(410,CDA,2)=$G(^PRC(440,VEND,0))
 I $P($G(^PRC(440,+VEND,0)),"^")="SIMPLIFIED" S VEND="SIMPLIFIED" S:$P($G(^PRC(442,XDA,24)),"^",2)'="" VEND=$P($G(^PRC(442,XDA,24)),"^",2) S ^PRCS(410,CDA,2)=VEND
 S VEN=$P(^PRCS(410,CDA,2),"^")
 S COR=$P($G(^PRC(442,XDA,23)),"^",12),SGRP=$P($G(^PRC(442,XDA,23)),"^",13)
 S DA=CDA,DIE="^PRCS(410,",DR="3////4"_";"_"5///"_TDATE_";"_"7////"_SDATE_";"_"15////"_CP_";"_"15.5////"_CCEN_";"_"21////"_TDATE_";"_"12////"_VV D ^DIE
 S DR="1////O"_";"_"6.3////"_SERV_";"_"7.5////"_ST_";"_"40////"_DUZ_";"_"68////"_DUZ_";"_"8////"_COR D ^DIE
 S DR="46////^S X=LOC"_";"_"47////"_ADATE_";"_"48.1////"_ESTS_";"_"52///"_XDA_";"_"24///"_PCREF D ^DIE
 I $G(PRCSIP) S DR="4////^S X=PRCSIP" D ^DIE
 I PC="" S PC=9999999
 S DR="451////^S X=PC" D ^DIE
 I +COUNT'=0 F IT=1:1:COUNT D
 .S ^PRCS(410,CDA,"IT",IT,0)=BB(IT)
 .I +COUNT1'=0 F J=1:1:COUNT1 D
 ..S:$D(BB(IT,J)) ^PRCS(410,CDA,"IT",IT,1,J,0)=BB(IT,J)
 .I COUNT1="" S ^PRCS(410,CDA,"IT",IT,1,0)="^^1^1^"_TDATE_"^^"
 .F LL="AB","B" S ^PRCS(410,CDA,"IT",LL,IT,IT)=""
 .I $P(BB(IT),"^",4)'="" S ^PRCS(410,CDA,"IT","AG",$P(BB(IT),"^",4),IT)=""
 .S:+COUNT1'=0 ^PRCS(410,CDA,"IT",IT,1,0)="^410.03^"_COUNT1_"^"_COUNT1
 I $D(VEN) S ^PRCS(410,"E",$E(VEN,1,30),CDA)=""
 S ^PRCS(410,"AQ",1,CDA)="" S:COUNT'="" ^PRCS(410,CDA,"IT",0)="^410.02AI^"_COUNT_"^"_COUNT
 L +^PRC(442,XDA):$S(DILOCKTM>15:DILOCKTM,1:15) Q:'$T  S $P(^PRC(442,XDA,23),"^",23)=CDA L -^PRC(442,XDA)   ;PRC*5.1*181  Set 410 pointer prior to Sort Group query
 I '$G(PRCPROST),$G(RPUSE)'=1,$G(COMMENT)'="delivery",$G(PRCHPC)'="" S DA=CDA,DR=49 D ^DIE
 L -^PRCS(410,CDA)
 L +^PRC(442,XDA):15 Q:'$T  S $P(^PRC(442,XDA,23),"^",13)=$P($G(^PRCS(410,CDA,11)),"^") L -^PRC(442,XDA)
 S DA=XDA K DIE QUIT
ITEM ;
 F IT=1:1:COUNT D
 .F J=1,2,3,4,5,6,8 S $P(BB(IT),"^",J)=$P($G(^PRC(442,XDA,2,IT,0)),"^",J)
 .S $P(BB(IT),"^",7)=$P($G(^PRC(442,XDA,2,IT,0)),"^",9)
 .S COUNT1=$P($G(^PRC(442,XDA,2,IT,1,0)),"^",4) I +COUNT1'=0 F J=1:1:COUNT1 S BB(IT,J)=$G(^PRC(442,XDA,2,IT,1,J,0))
 QUIT
REC ;create skeleton 410 record
 S:$G(XDA)'="" PRC("CP")=$P($G(^PRC(442,XDA,0)),U,3)
 Q:+$G(PRC("CP"))=0
 S T(2)="",Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 S PRC("BBFY")=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),$P(PRC("CP")," "),1)
 S X=$P(Z,"-",1,2)_"-"_$P(PRC("CP")," ")
 D EN1^PRCSUT3 Q:'$D(X)  Q:$G(X)="#"&($G(PRCRMPR)=1)  S X1=X D EN2^PRCSUT3 Q:$G(DA)=""  Q:'$D(X1)  S CDA=DA
 K X,T(2) QUIT
ESIG ;put ESIG on record, update due-ins
 N PRCHOBL     ;PRC*171 D.O. auto obligate flags
 S NET=$P($G(^PRC(442,PODA,0)),"^",15) L +^PRCS(410,DA):15 Q:'$T  F I=1,8 S $P(^PRCS(410,DA,4),"^",I)=NET
 I $D(PRCHDELV) D SWCHK   ;PRC*171 D.O. auto obligate check for EDI and All/Delivery flags on
 I $D(PRCHDELV),PRCHOBL=1 S $P(^PRCS(410,DA,4),"^",3)=NET,$P(^PRCS(410,DA,4),"^",4)=$P(^PRCS(410,DA,1),"^")   ;PRC*171 auto obligate sets for D.O. flag sets
 S:'$D(PRC("CP")) ZIP=$P(^PRC(442,PODA,0),"^",3),PRC("CP")=$P(ZIP," ") Q:PRC("CP")=""
 S BAL=$P($G(^PRC(420,PRC("SITE"),1,+PRC("CP"),4,PRC("FY"),0)),"^",PRC("QTR")+1)
 L -^PRCS(410,DA)
 D ERS410^PRC0G(DA_"^A")
 S MESSAGE="" D ENCODE^PRCSC1(DA,DUZ,.MESSAGE)
 S:'$D(PRC("CP")) ZIP=$P(^PRC(442,PODA,0),"^",3),PRC("CP")=$P(ZIP," ") Q:PRC("CP")=""
 D:'$D(PRC("FY")) FY^PRCH442
 N KTEMP S KTEMP=X
 S AA=PRC("SITE")_"^"_+PRC("CP")_"^"_PRC("FY")_"^"_PRC("QTR")_"^"_NET D EBAL^PRCSEZ(AA,"C") I $D(PRCHDELV),PRCHOBL=1 D EBAL^PRCSEZ(AA,"O")   ;PRC*171 auto obligate sets for D.O. flag sets
 S X=KTEMP
 S BAL=$P($G(^PRC(420,PRC("SITE"),1,+PRC("CP"),4,PRC("FY"),0)),"^",PRC("QTR")+1)
 W !,"Cost of this request: $",$J(X,0,2),!,"Current Control Point Balance: $",$J(BAL,0,2),!
 S PRCSN=$G(^PRCS(410,DA,0))
 ;PRC*5.1*186
 I $P(PRCSN,U,4)>1 D
 . S X=$P(PRCSN,U,1),DIC="^PRC(443,",DIC(0)="L",DLAYGO=443 D ^DIC K DIC,DLAYGO,X
 . S X=$O(^PRCD(442.3,"C",60,0)),PRCHSTS=X
 . S DIE="^PRC(443,",DR="1.5////^S X=PRCHSTS" D ^DIE K DR,DIE,PRCHSTS,X
 . S $P(^PRC(443,DA,0),U,11)=$P(PRCSN,U,6)
 I '$G(PRCHPHAM),$G(PRCHPC)'=1 D EN2^PRCPWI
 S PRCSINV=$P(^PRCS(410,DA,0),U,6)
 S DIE="^PRC(443,",DR="9///^S X=1;10///^S X=4;11////^S X=PRCSINV;13///^S X=""E"";3.7///^S X=5730;3.5///^S X=1;2////^S X=DUZ"
 D ^DIE K DIE,DR
 S BAL=$P($G(^PRC(420,PRC("SITE"),1,+PRC("CP"),4,PRC("FY"),0)),"^",PRC("QTR")+1)
 D ES1^PRCHG
 S PRCHSY(0)=^PRC(443,CDA,0) ;After Signature use 443 entry
 S PRCHS="",PRCHSY=DA,PRCHSP="" D LST1^PRCHNPO2
 S BAL=$P($G(^PRC(420,PRC("SITE"),1,+PRC("CP"),4,PRC("FY"),0)),"^",PRC("QTR")+1)
 S DA=CDA,DIK="^PRC(443," D ^DIK K DIK
 K BAL,ZIP,PRCSN,X,MESSAGE QUIT
SWCHK ;CHECK EDI AND ALL/DEL FLAGS FOR DELIVERY ORDERS    ;PRC*171 D.O. auto obligate check for EDI and All/Delivery flags on
 N PRCHFUND,PRCEDICK,PRCVEND
 S PRCHOBL=0
 S PRCVEND=$P($G(^PRC(442,PODA,1)),U) S:PRCVEND'="" PRCEDICK=$P($G(^PRC(440,PRCVEND,3)),U,2)
 S PRCHFUND=$P(^PRC(442,PODA,0),U,3) Q:PRCHFUND=""  S PRCHFUND=+$P(PRCHFUND," ")
 I $P($G(^PRC(442,PODA,23)),U,11)="D"!$D(PRCHDELV) D
 . I $P($G(^PRC(420,PRC("SITE"),3)),U,2)'=""!($P($G(^PRC(420,PRC("SITE"),1,PRCHFUND,6)),U,2)'="") S PRCHOBL=1    ;PRC*5.1*186
 . I $P(^PRC(442,PODA,0),U,2)=26 S PRCHOBL=1
 I '$G(PRCHOBL) D
 . I ($P($G(^PRC(420,PRC("SITE"),1,PRCHFUND,6)),U)="Y")!($P($G(^PRC(420,PRC("SITE"),3)),U)="Y") S:PRCEDICK="Y" PRCHOBL=1   ;PRC*5.1*186
 Q
