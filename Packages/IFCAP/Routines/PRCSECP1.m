PRCSECP1 ;SF-ISC/LJP/DGL-COPY A TRANSACTION CON'T ;7/29/99
V ;;5.1;IFCAP;**148**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
S1 ;subroutine to copy transactions of form type 1 (i.e. 1358)
 K PRCSTMP
 N I,PRCSIP
 I $D(^PRCS(410,T1,0)) D
 . F I=2,4 S $P(^PRCS(410,DA,0),U,I)=$P(^PRCS(410,T1,0),U,I)
 . D IP^PRCSUT
 . I $G(PRCSIP) S $P(^PRCS(410,DA,0),U,6)=PRCSIP
 S:$D(^PRCS(410,T1,1)) $P(^PRCS(410,DA,1),U,5)=$P(^(1),U,5)
 I $D(^PRCS(410,T1,3)) S PRCSTMP=^(3),^PRCS(410,DA,3)=$P(^PRCS(410,DA,3),U,1,2)_"^"_$P(PRCSTMP,U,3,6)_"^^"_$P(PRCSTMP,U,8)_"^^"_$P(PRCSTMP,U,10)
 I $P(PRCSTMP,U)'=$P(^PRCS(410,DA,3),U) S $P(^PRCS(410,DA,3),U,3)=""
 S:$D(^PRCS(410,T1,10)) $P(^PRCS(410,DA,10),U)=$P(^(10),U)
 ;
 D CHECK
 D S4,S5,S7
 Q
 ;
 ;subroutine S2 is called to copy all transactions of form type <> 1
 ;(anything other than a 1358)
S2 K PRCSTMP
 N I,PRCSIP
 ;if possible, copy over transaction type & form type from old trans.
 ;also get inventory distrib. point from NEW FCP inv distrib point
 I $D(^PRCS(410,T1,0)) D
 . F I=2,4 S $P(^PRCS(410,DA,0),U,I)=$P(^PRCS(410,T1,0),U,I)
 . D IP^PRCSUT
 . I $D(PRCSIP) S $P(^PRCS(410,DA,0),U,6)=PRCSIP
 ;copy classification of request
 I $D(^PRCS(410,T1,1)) S $P(^PRCS(410,DA,1),U,5)=$P(^(1),U,5)
 ;now copy cost center, vendor, requesting service, and vendor contract #
 ;"CHECK" checks for valid FCP user, CC, BOC, etc.
 I $D(^PRCS(410,T1,3)) D
 . F I=3,4,5,10 S $P(^PRCS(410,DA,3),U,I)=$P(^PRCS(410,T1,3),U,I)
 . I $P(^PRCS(410,T1,3),U)'=$P(^PRCS(410,DA,3),U) S $P(^PRCS(410,DA,3),U,3)=""
 . D CHECK
 ;copy the line item count
 S:$D(^PRCS(410,T1,10)) $P(^PRCS(410,DA,10),U)=$P(^(10),U)
 ;S:$D(^PRCS(410,T1,9)) $P(^PRCS(410,DA,9),U,1)=$P(^(9),U,1)
 ;
 D S4,S5,S7
 Q
 ;
S3 ;Note: S3 commented out (prior to patch 182) so it falls through to S4
 ;K PRCSTMP
 ;S:$D(^PRCS(410,T1,3)) $P(^PRCS(410,DA,3),U,3)=$P(^(3),U,3) D CHECK
 ;I $D(^PRCS(410,T1,"CO",0)) S ^PRCS(410,DA,"CO",0)=$P(^(0),U,1,4)_"^"_DT,PRCSI="CO",PRCSK=0 D S6
 ;D S4 Q
 ;
 ;
S4 ;copy vendor info, sort group and authoritie(s)
 ;
 N PRC11
 S:$D(^PRCS(410,T1,2)) ^PRCS(410,DA,2)=^(2)
 I $D(^PRCS(410,T1,11)) S PRC11=^(11),^PRCS(410,DA,11)=$P(PRC11,"^")_"^^^"_$P(PRC11,"^",4,5)
 ;following line (copy sub control point) commented out before P182 
 ;I $D(^PRCS(410,T1,12,0)) S ^PRCS(410,DA,12,0)=^(0),PRCSI=12,PRCSK=0 D S6
 Q
 ;
S5 ;copy special remarks (using S6)
 S PRCSI="RM"
 I $D(^PRCS(410,T1,PRCSI,0)) D
 . S ^PRCS(410,DA,PRCSI,0)=$P(^(0),U,1,4)_"^"_DT,PRCSK=0
 . D S6
 Q
 ;
S6 ;General purpose copy used for remarks
 F  S PRCSK=$O(^PRCS(410,T1,PRCSI,PRCSK)) Q:'PRCSK  D
 . S:$D(^PRCS(410,T1,PRCSI,PRCSK,0)) ^PRCS(410,DA,PRCSI,PRCSK,0)=$P(^(0),U,1)
 Q
 ;
S7 ;copy the items from the old transaction to the new
 I $D(^PRCS(410,T1,"IT",0)) D
 . S ^PRCS(410,DA,"IT",0)=^PRCS(410,T1,"IT",0)
 . K PRCSTMP S PRCSK=0
 . D S8
 Q
 ;
S8 ;copy the items from old to new (detail)
 F  S PRCSK=$O(^PRCS(410,T1,"IT",PRCSK)) Q:'PRCSK  I $D(^(PRCSK,0)) D
 . S PRCSTMP=^PRCS(410,T1,"IT",PRCSK,0)
 . S ^PRCS(410,DA,"IT",PRCSK,0)=$P(PRCSTMP,U,1,7)
 . S PRCSL=0 D S9
 Q
S9 ;copy the items from old txn to new (further detail)
 N PRCSTMP
 I $D(GET1) S $P(^PRCS(410,DA,"IT",PRCSK,0),"^",4)=GET1
 I $D(^PRCS(410,T1,"IT",PRCSK,1,0)) S PRCSTMP=^(0) D
 . S ^PRCS(410,DA,"IT",PRCSK,1,0)=$P(PRCSTMP,U,1,4)_"^"_DT
 F  S PRCSL=$O(^PRCS(410,T1,"IT",PRCSK,1,PRCSL)) Q:'PRCSL  D
 . L -^PRCS(410,DA)
 . I $D(^PRCS(410,T1,"IT",PRCSK,1,PRCSL,0)) S PRCSTMP=^(0),^PRCS(410,DA,"IT",PRCSK,1,PRCSL,0)=PRCSTMP
 Q
CHECK ;Check for valid CC/BOC on the FCP for this transaction
 ;if old trans didn't have an FCP stop right now
 N TEST S TEST=$P($G(^PRCS(410,T1,3)),"^",3) Q:TEST=""
 S PRC("ACC")=$$ACC^PRC0C(PRC("SITE"),PRC("CP")_"^"_PRC("FY")_"^"_PRC("BBFY"))
 S PRCSAPP=$P(PRC("ACC"),"^",11)
 S $P(^PRCS(410,DA,3),U)=PRC("CP"),$P(^(3),"^",2)=PRCSAPP,$P(^(3),"^",12)=$P(PRC("ACC"),"^",3)
 S $P(^PRCS(410,DA,3),"^",11)=$P($$DATE^PRC0C(PRC("BBFY"),"E"),"^",7)
 S $P(^PRCS(410,DA,7),U)=DUZ,$P(^PRCS(410,DA,7),U,2)=$P($G(^VA(200,DUZ,20)),U,3)
 ;P182--Commented out following 4 lines which were determining a default
 ;CC and attempting to get a default BOC.  Now this is accomplished in
 ;CHGCCBOC^PRCSCK, which is called upon return to ^PRCSECP
 ;I '$D(^PRC(420,PRC("SITE"),1,+PRC("CP"),2,TEST)) D
 ;.S GET=0 S GET=$O(^PRC(420,PRC("SITE"),1,+PRC("CP"),2,GET)) Q:+GET=0
 ;.Q:'$D(^PRCD(420.1,GET))  S GET1=0 S GET1=$O(^PRCD(420.1,GET,1,GET1)) Q:'$D(^PRCD(420.2,GET1))  S GET1=$E(^PRCD(420.2,GET1,0),1,30)
 ;.Q:+GET1=0  S $P(^PRCS(410,DA,3),"^",3)=GET
 Q
W1 W !!,"Would you like to review this request" S %=2 D YN^DICN G W1:%=0 Q:%'=1  S (N,PRCSZ)=DA,PRCSF=1 D PRF1^PRCSP1 S DA=PRCSZ K X,PRCSF,PRCSZ Q
W3 W !!,"Would you like to copy another request" S %=1 D YN^DICN G W3:%=0 Q
