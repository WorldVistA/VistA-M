PRCNLID ;SSI/SEB-Display line items ;[ 05/31/96  10:21 AM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
 S PRCNDATA=^PRCN(413,D0,1,D1,0) I 'PRCNDATA W $C(7),!,"No such line item!" G Q
 W @IOF,"Line Item #",$P(PRCNDATA,U),?40,"Contract #",$P(PRCNDATA,U,6)
 W !,"Unit Cost: ",$P(PRCNDATA,U,4),?40,"Quantity Required: ",$P(PRCNDATA,U,5)
 S I=0 W !,"Description:"
 F  S I=$O(^PRCN(413,D0,1,D1,1,I)) Q:I=""  W !,?4,^PRCN(413,D0,1,D1,1,I,0)
Q K PRCNDATA,I Q
