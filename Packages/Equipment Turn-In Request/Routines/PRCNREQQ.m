PRCNREQQ ;SSI/ALA-Line Item Quantity Edit ;[ 08/05/96  5:51 PM ]
 ;;1.0;Equipment/Turn-In Request;**5**;Sep 13, 1996
 I +X'=X!(X>9999)!(X<1)!(X?.E1"."1N.N) K X Q
 S PRVQTY=$P($G(^PRCN(413,DA(1),1,DA,0)),U,5)
 I $P(^PRCN(413,DA(1),0),U,9)'="R" G EXIT
 I PRVQTY="" G EXIT
 S RDI=DA,RDA=DA(1),TDA=$P(^PRCN(413,RDA,0),U,11),PRCNCMR=$P(^(0),U,16)
 S NQTY=X I $G(NEW)'="" G EXIT
 I NQTY>PRVQTY D GRT G EXIT
 I NQTY<PRVQTY D LES
EXIT K PRVQTY,NUM,TTDA,TDA,RDA,RDI,NN,NQTY,NM,QTY
 Q
GRT ;  If the quantity increased and type is replacement
 W !!,"You have increased your requested quantity.  This request type is "
 W !,"a 'REPLACEMENT'.  You must have a selected replacement item from the"
 W !,"Inventory file for each individual quantity of a line item."
 W !,"You must ADD a replacement item for each additional quantity requested."
 W !!,"Do you wish to continue" D YN^DICN I %<0!(%=2) K X Q
 I %=0 G GRT
 ; Go add replacement items
 S NM=$P($G(^PRCN(413.1,TDA,1,0)),U,3)
 I NM="" S ^PRCN(413.1,TDA,1,0)="^413.11IPA^^"
 D CT I NQTY=NUM W !,"Equal quantity to replacement items already!" Q
 S QTY=NQTY,PRCNTYP=$P(^PRCN(413,RDA,1,RDI,0),U,12) D RP2^PRCNREQN D CT I NUM<NQTY W !,"Not enough replacement items" G GRT
 S X=NQTY
 Q
LES ;  If the quantity decreased and type is replacement
 N DV
 W !!,"You have decreased your requested quantity.  This request type is "
 W !,"a 'REPLACEMENT'.  You must have a selected replacement item from the"
 W !,"Inventory file for each individual quantity of a line item."
 W !,"You must DELETE a replacement item for each decremented quantity requested."
 W !!,"Do you wish to continue" D YN^DICN I %<0!(%=2) K X Q
 I %=0 G LES
 ;  Go to edit and prompt for '@'
 S QTY=NQTY D CT S TTDA=TDA D EN1^PRCNREQE S TDA=TTDA D CT S $P(^PRCN(413.1,TDA,1,0),U,3,4)=NUM_U_NUM
 I NUM>NQTY W !!,"You didn't delete any items.  Please try again." G LES
 Q
CT S NUM=0,NN="" F  S NN=$O(^PRCN(413.1,TDA,1,"AC",RDI,NN)) Q:NN=""  S NUM=NUM+1
 Q
