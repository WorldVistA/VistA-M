LRORDB ;DALOI/FHS - ORDER LEDI TEST USING BARCODE FROM 69.6 ; 12/3/1997
 ;;5.2;LAB SERVICE;**153,222,286**;Sep 27, 1994
 ;
EN(LRRUID,LRSSMP) ;
 ;
 N I,LRSTATUS,LRX
 ;
 K LROT
 ;
 S (LROT,LRSTATUS)=""
 ;
 Q:'$L($G(LRRUID))!('$L($G(LRSSMP)))
 S LR696=$O(^LRO(69.6,"AD",LRSSMP,LRRUID,0)) Q:'LR696
 Q:'$D(^LRO(69.6,LR696,0))#2
 ;
 S LRX=+$P(^LRO(69.6,LR696,0),U,10)
 I LRX S LRSTATUS=$$GET1^DIQ(64.061,LRX_",",.01)
 I LRSTATUS'="",LRSTATUS'="In-Transit" D
 . S I=0
 . F  S I=$O(^LRO(69.6,LR696,2,I)) Q:'I  D  Q:LRSTATUS="In-Transit"
 . . S X=$P(^LRO(69.6,LR696,2,I,0),"^",6) Q:'X
 . . I $$GET1^DIQ(64.061,X_",",.01)="In-Transit" S LRSTATUS="In-Transit"
 ;
 I LRSTATUS'="",LRSTATUS'="In-Transit" D  Q
 . N DIR
 . S DIR("A",1)="This order has a status of [ "_LRSTATUS_" ]"
 . S DIR("A",2)="No test selected."
 . D DISPLO
 ;
 ; Display any comments that accompanied order
 I $D(^LRO(69.6,LR696,99)) D
 . N LRWP
 . S LRWP=$$GET1^DIQ(69.6,LR696_",",99,"","LRWP")
 . S LRWP(.5)="Collecting site order comments:",LRWP(.5,"F")="!!"
 . D EN^DDIOL(.LRWP)
 ;
 D LROT(LR696)
 ;
 I $O(LROT(0)) D LL3^LROW3
 I '$O(LROT(0)) D  Q
 . N DIR
 . S DIR("A",1)="NO tests found on Shipping Manifest "_$G(LRRSITE("SMID"))
 . S DIR("A",2)="For UID "_$G(LRRUID)
 . D DISPLO
 ;
 S $P(^LRO(69.6,LR696,0),U,11)=$G(LRSD("RIEN"))
 Q
 ;
 ;
LROT(LR696) ;
 ;
 N LR60,LR6205,LR6964,LRATG,LRMICHK,LRNLT,LRX,LRY,X
 ;
 K LROT
 ;
 S LR696(0)=$G(^LRO(69.6,LR696,0))
 S LRSPEC=+$P(LR696(0),U,7),LRSAMP=+$P(LR696(0),U,8)
 ;Q:'LRSPEC!('$D(^LAB(61,LRSPEC,0)))
 S (LR6964,LRMICHK)=0
 F  S LR6964=+$O(^LRO(69.6,LR696,2,LR6964)) Q:LR6964<1  D
 . S LR6964(0)=$G(^LRO(69.6,LR696,2,LR6964,0))
 . I LR6964(0)="" Q
 . I $P(LR6964(0),"^",6),$$GET1^DIQ(64.061,$P(LR6964(0),"^",6)_",",.01)'="In-Transit" Q
 . S LR60=$P(LR6964(0),U,11) ; Lab test to order
 . S LR6205=$P(LR6964(0),U,12) ; Urgency
 . I 'LRMICHK,LR60>0,$P(^LAB(60,LR60,0),U,4)="MI" D MICHECK
 . S LRATG=0
 . ; If have everything, then don't check accession test group.
 . I LR60,LRSPEC,LRSAMP,LR6205 D  Q:LRATG
 . . S LR64=+$G(^LAB(60,LR60,64))
 . . I 'LR64 Q
 . . S LRNLT=$P($G(^LAM(LR64,0)),U,2),LRNLT(2)=$P($G(^LAM(LR64,0)),U)
 . . ; Find available spot.
 . . F LRATG=LRWPC+1:1 I '$D(LROT(LRSAMP,LRSPEC,LRATG)) S LRWPC=LRATG Q
 . . D CHKURG,SETLROT
 . S LRNLT=$P(LR6964(0),U,2) Q:'LRNLT
 . S LRNLT(1)=+$O(^LAM("C",LRNLT_" ",0))
 . I 'LRNLT(1)!('$D(^LAM(LRNLT(1),0))) Q
 . S LRNLT(2)=$P(^LAM(LRNLT(1),0),U),LR60=0
 . F  S LR60=+$O(^LAB(60,"AC",LRNLT(1),LR60)) Q:'LR60  D
 . . S LRATG=+$O(^TMP("LRSTIK",$J,"C",LR60,0)) Q:LRATG<1
 . . S LRATG(1)=$G(^TMP("LRSTIK",$J,LRATG)) Q:'LRATG(1)!('$P(LRATG(1),U,3))
 . . S:'$G(LRSAMP) LRSAMP=$P(LRATG(1),U,3)
 . . D CHKURG
 . . I LR60,LRSPEC,LRSAMP,LR6205 D SETLROT
 Q
 ;
 ;
SETLROT ; Setup LROT array
 ;
 S LROT(LRSAMP,LRSPEC,LRATG)=LR60
 S LROT(LRSAMP,LRSPEC,LRATG,1)=LR6205
 S LROT(LRSAMP,LRSPEC,LRATG,"B",LR60)=LR6964_U_LRNLT_U_LRNLT(2)
 ;
 ; Required comment
 S:$P($G(^LAB(60,LR60,0)),U,19) LROT(LRSAMP,LRSPEC,LRATG,2)=$P(^(0),U,19)
 ;
 Q
 ;
 ;
CHKURG ; Check for forced, highest allowed and missing urgency on this test
 ;
 N X
 ;
 ; Forced urgency
 I +$P(^LAB(60,LR60,0),U,18) S LR6205=+$P(^LAB(60,LR60,0),U,18)
 ;
 ; If missing urgency then look above workload urgencies for last urgency
 ; that matches on HL7 urgency othewise use site's default for routine.
 I 'LR6205 D
 . S X=$P(LR6964(0),U,5)
 . I $L(X) S LR6205=+$O(^LAB(62.05,"HL7",X,50),-1)
 . S LR6205=$S(LR6205>0:LR6205,1:LROUTINE)
 ;
 ; Highest urgency allowed, reset if higher than highest allowed.
 S X=+$P(^LAB(60,LR60,0),U,16)
 I LR6205<X S LR6205=X
 ;
 Q
 ;
 ;
MICHECK ; Check "MI" subscript test for missing topography and collection sample
 ;
 N DA,DIE,DR,X,Y
 S DA=LR696,DIE=69.6,DR="",LRMICHK=1
 I LRSPEC'>0 S DR=4_";"
 I LRSAMP'>0 S DR=DR_5
 I LRSPEC D
 . S LRX=$$GET1^DIQ(61,LRSPEC_",",".09:2")
 . I LRX="XXX"!(LRX="ORH") S DR="4;5"
 I DR="" Q
 D EN^DDIOL("Update missing order information for:",,"!!")
 D EN^DDIOL("",,"!")
 D ^DIE
 S LR696(0)=$G(^LRO(69.6,LR696,0))
 S LRSPEC=+$P(LR696(0),U,7),LRSAMP=+$P(LR696(0),U,8)
 ;
 Q
 ;
 ;
SMID ; Call to get shipping manifest ID (manual selection)
 N CNT,DA,DIR,LRSMID,LRY,X,Y
 S LREND=0,LRSMID=""
 S DIR(0)="69.6,18" D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S LREND=1 Q
 I $D(DIRUT) Q
 S LRY=Y
 I LRY'="",$D(^LRO(69.6,"D",LRY)) S LRSMID=LRY
 I LRSMID="" D
 . D SHOW
 . K ^TMP("LR",$J,"SMID")
 ;
 I LRSMID="" D  Q
 . N DIR
 . S DIR(0)="YO",DIR("A")="Use manifest '"_LRY_"' anyway",DIR("B")="NO"
 . W ! D ^DIR
 . I Y S LRRSITE("SMID")=LRY
 ;
 S LRRSITE("SMID")=LRSMID
 S LRY=$O(^LRO(69.6,"D",LRSMID,0))
 I LRY S LRRSITE("SDT")=$$GET1^DIQ(69.6,LRY_",",14,"I")
 K DIR
 ;
 ; Flag to determine if this shipping manfiest should be used to
 ; look up orders when manually accessioning.
 S DIR(0)="YO",DIR("A")="Lookup orders using this manifest",DIR("B")="YES"
 D ^DIR
 I $D(DIRUT) S LREND=1 Q
 S LRRSITE("SMID-OK")=Y
 Q
 ;
 ;
SHOW ; Gather a list of possible SMID to select from
 N CNT,DIR,IEN,LEN,SMID,VAL
 K ^TMP("LR",$J,"SMID")
 S SMID=LRY,LEN=$L(LRY),CNT=0
 I SMID?1.N S SMID=SMID_" "
 F  S SMID=$O(^LRO(69.6,"D",SMID)) Q:$E(SMID,1,LEN)'=LRY  D
 . S IEN=+$O(^LRO(69.6,"D",SMID,0))
 . I $P($G(^LRO(69.6,IEN,0)),"^",5)'=+$G(LRRSITE("RSITE")) Q
 . S CNT=CNT+1
 . S ^TMP("LR",$J,"SMID",CNT)=SMID
 I 'CNT W !,"No manifest '",LRY,"' found on file." Q
 I CNT=1 S LRSMID=^TMP("LR",$J,"SMID",CNT) Q
 ;
 ; Select SMID from List
 D DISPL
 S DIR(0)="NO^1:"_CNT,DIR("A")="Select Manifest Number"
 D ^DIR
 I $D(DIRUT) W !,"No manifest selected." Q
 S LRSMID=$G(^TMP("LR",$J,"SMID",Y))
 Q
 ;
 ;
DISPL ;
 N CNT,DIR,DIRUT
 W @IOF
 S CNT=0
 F  S CNT=$O(^TMP("LR",$J,"SMID",CNT)) Q:'CNT  D  Q:$D(DIRUT)
 . I CNT#3=1 D  Q:$D(DIRUT)
 . . I '(CNT#(IOSL-3)) S DIR(0)="E" D ^DIR Q:$D(DIRUT)
 . . W !
 . W $$LJ^XLFSTR(CNT_". "_^TMP("LR",$J,"SMID",CNT),26)
 Q
 ;
 ;
DISPLO ; Display the order from #69.6
 N DA,DIC,DIRUT,DTOUT,DUOUT,DX,S,X,Y
 S DIR("A")="Would you like a display of the Order"
 S DIR(0)="Y" D ^DIR K DIR
 I $D(DIROUT)!(Y'=1) W ! Q
 S DA=LR696,DIC="^LRO(69.6,",S=0 W @IOF D EN^DIQ W !
 Q
