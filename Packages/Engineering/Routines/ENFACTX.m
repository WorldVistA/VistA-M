ENFACTX ;(WCIOFO)/SAB-FAP CAPITALIZATION THRESHOLD EXPENSE ITEM ;5/29/2002
 ;;7.0;ENGINEERING;**63,71**;August 17, 1993
 ;
EXP(ENDA) ; Expense Equipment Item
 ; input ENDA - equipment entry # to expense
 ; returns 1 if success or 0 if failed
 ; output ^TMP($J,"BAD",entry #
 ;        will be defined if problem
 ;
 N DA,DIC,DIE,DIK,DR,ENAVC,ENDO,ENEQ,ENFA,ENFAP,ENFD,ENX,I,X,Y
 S ENDO=1 ; initialize return value as success
 S ENEQ("DA")=ENDA
 F I=2,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 ;
 ; create FD Document
 S ENFD("DA")=""
 D:ENDO ADDFD
 ; populate FD document with 'user' data
 D:ENDO
 . N ENFDA,ENERR
 . S ENFDA(6915.5,ENFD("DA")_",",100)="FINAL DISPOSITION"
 . S ENFDA(6915.5,ENFD("DA")_",",102)=$$FMTE^XLFDT(DT)
 . S ENFDA(6915.5,ENFD("DA")_",",33)="0.00"
 . S ENFDA(6915.5,ENFD("DA")_",",103)="OTHER"
 . S ENFDA(6915.5,ENFD("DA")_",",34)="THRESH CHG 100K"
 . S ENFDA(6915.5,ENFD("DA")_",",303)="OTHER"
 . S ENFDA(6915.5,ENFD("DA")_",",310)="ENAVC"
 . S ENAVC(1)="Expensed due to new capitalization threshold of $100,000."
 . D FILE^DIE("E","ENFDA","ENERR")
 . I $D(ENERR) D BAD("ERROR FILING DATA IN FD") S ENDO=0
 ; convert 'user' data
 D:ENDO CVTDATA
 ; validate FD document
 D:ENDO
 . S ENFAP("DOC")="FD"
 . K ^TMP($J,"BAD",ENEQ("DA"))
 . D ^ENFAVAL
 . I $D(^TMP($J,"BAD",ENEQ("DA"))) S ENDO=0
 ; delete FD Document when problem
 I 'ENDO,$G(ENFD("DA"))]"" D
 . S DA=ENFD("DA"),DIK="^ENG(6915.5," D ^DIK K DIK
 ; process and xmit FD
 D:ENDO UPDATE
 ; unlock FD
 I $G(ENFD("DA"))]"" L -^ENG(6915.5,ENFD("DA"))
 ; return success OR failure
 Q ENDO
 ;
ADDFD ; create/lock stub entry for FD codesheet
 S DIC="^ENG(6915.5,",DIC(0)="L",DLAYGO=6915.5
 S X=ENEQ("DA"),DIC("DR")="1///NOW;1.5////^S X=DUZ"
 K DD,DO D FILE^DICN K DIC,DLAYGO
 I Y'>0 D BAD("Can't add to FD DOCUMENT LOG") S ENDO=0 Q
 S ENFD("DA")=+Y
 L +^ENG(6915.5,ENFD("DA")):0
 I '$T D BAD("Can't lock FD Document") S ENDO=0 Q
 ; save current asset value on FD
 S $P(^ENG(6915.5,ENFD("DA"),100),U,2)=$$GET1^DIQ(6914,ENEQ("DA"),12)
 Q
 ;
CVTDATA ; convert 'user' pseudo field data into exported data
 ; get data from file
 F I=0,5,100 S ENFAP(I)=$G(^ENG(6915.5,ENFD("DA"),I))
 ; convert into exported data
 I $P(ENFAP(100),U,4)="" S $P(ENFAP(100),U,4)=7
 I $P(ENFAP(5),U,8)="" S $P(ENFAP(5),U,8)="0.00"
 S X=$P(ENFAP(100),U,3) I X]"" D
 . S $P(ENFAP(5),U,5)=$E(X,1,3)+1700
 . S $P(ENFAP(5),U,6)=$E(X,4,5)
 . S $P(ENFAP(5),U,7)=$E(X,6,7)
 S X=$P(ENFAP(100),U,4) I X S $P(ENFAP(5),U,4)=$$GET1^DIQ(6914.8,X,.01)
 ; update file
 S ^ENG(6915.5,ENFD("DA"),5)=ENFAP(5)
 S ^ENG(6915.5,ENFD("DA"),100)=ENFAP(100)
 Q
 ;
UPDATE ; update files based on FD Document
 ; update FAP Balance
 D ADJBAL^ENFABAL($P(ENEQ(9),U,5),$P(ENEQ(9),U,7),$P(ENEQ(8),U,6),$P($P(ENFAP(0),U,2),"."),-$P(ENEQ(2),U,3))
 ; update EQUIPMENT INV file
 S DA=ENEQ("DA"),DIE="^ENG(6914," S DR="34////A;38///6100" D ^DIE
 ; send FD Document to FAP
 D ^ENFAXMT
 ; save adjustment voucher
 S DIE="^ENG(6915.5,",DR="301///NOW",DA=ENFD("DA") D ^DIE
 Q
 ;
BAD(X) ; add text to validation problem list
 N I
 S I=$P($G(^TMP($J,"BAD",ENEQ("DA"))),U)+1
 S ^TMP($J,"BAD",ENEQ("DA"),I)=X
 S ^TMP($J,"BAD",ENEQ("DA"))=I
 Q
 ;
 ;ENFACTX
