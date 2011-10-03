YSPP1 ;ALB/ASF-PATIENT INQUIRY-PART 2 KIN ; 2/15/89  09:29 ;07/30/93 15:10
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 S YSFHDR="Next of Kin, Employment, Claim Number Data <<section 2>>" D ENHD^YSFORM
ENCE ; Called indirectly from YSCEN31
 ;
 I $P(A(.15),U,2)?7N W !?20,"PATIENT LISTED AS INELIGIBLE",$C(7,7)
NOK ;
 W !?3,"NEXT OF KIN: ",$P(A(.21),U),?40,"KIN-2: ",$P(A(.211),U)
 W !,"  RELATIONSHIP: ",$P(A(.21),U,2),?40,"RELATION: ",$P(A(.211),U,2)
 S X=.21,X1=1,X2=3 D MOVE S X=.211,X1=5,X2=3 D MOVE
 W !?16,S(1),?45,S(5),!?16,S(2),?45,S(6),!?16,S(3),?45,S(7),!?16,$$ZIP4^YSPP(+YSDFN,7,S(4)),?45,$$ZIP4^YSPP(+YSDFN,2,S(8))
 W !,"     K1 PHONE: ",$P(A(.21),U,9),?40,"K2 PHONE: ",$P(A(.211),U,9)
EMP ;
 W !!,"     EMP: ",$P(A(.311),U),?40,"DESIGNEE: ",$P(A(.34),U)
 W !," OCCUPAT: ",$P(A(0),U,7),?40,"RELATION: ",$P(A(.34),U,2) S X=.311,X1=1,X2=3 D MOVE S X=.34,X1=5,X2=3 D MOVE
 W !,$S($P(A(.311),U,2)="Y":"(GOVNMT)",1:""),?10,S(1),?47,S(5)
 W !?10,$$ZIP4^YSPP(+YSDFN,3,S(2)),?47,$$ZIP4^YSPP(+YSDFN,6,S(6)),!?10,S(3),?47,S(7),!?10,S(4),?47,S(8)
 W !," E PHONE: ",$P(A(.311),U,9),?38,"D PHONE: ",$P(A(.34),U,9)
 W !!,"",?7,"CLAIM #: ",$P(A(.31),U,3),?29,"LOCATION: ",$$CFL(+$G(YSDFN))
 W !,"   SERVICE CON: ",$S($P(A(.3),U)?1"Y".E:"YES  "_(+$P(A(.3),U,2))_"%",1:"NO"),?30,"PAYMENT: $",$J($P(A(.3),U,3),3,2)
PAR ;
 W !,"FATHER: ",$P(A(.24),U),?40,"MOTHER: ",$P(A(.24),U,2),!?32,"MOTHERS MAIDEN: ",$P(A(.24),U,3)
 Q:$D(YSNOFORM)  D WAIT1^YSUTL:'YST,ENFT^YSFORM:YST Q
MOVE ;
 S S(X1)=$P(A(X),U,X2),S(X1+1)=$P(A(X),U,X2+1),S(X1+2)=$P(A(X),U,X2+2),S(X1+3)=$P(A(X),U,X2+3)_$S($D(^DIC(5,+$P(A(X),U,X2+4),0)):", "_$P(^(0),U,2),1:"")_"  "_$P(A(X),U,X2+5)
 S:S(X1+2)="" S(X1+2)=S(X1+3),S(X1+3)="" S:S(X1+1)="" S(X1+1)=S(X1+2),S(X1+2)=S(X1+3),S(X1+3)="" S:S(X1)="" S(X1)=S(X1+1),S(X1+1)=S(X1+2),S(X1+2)=S(X1+3),S(X1+3)=""
 Q
 ;
CFL(DFN) ;  Claim Folder Location
 QUIT:$G(DFN)'>0 "" ;->
 N YSDATA
 ;
 ;  Get NEW Claim Folder Location...
 K YSDATA
 S DIC=2,DR=.314,DA=+DFN,DIQ="YSDATA",DIQ(0)="E"
 D EN^DIQ1
 S X=$G(YSDATA(2,+DFN,.314,"E")) I X]"" QUIT X
 ;
 ;  Still here?  must not be a NEW Claim Folder Location...
 ;  Get the old Claim Folder Location
 K YSDATA
 S DIC=2,DR=.312,DA=+DFN,DIQ="YSDATA",DIQ(0)="E"
 D EN^DIQ1
 S X=$G(YSDATA(2,+DFN,.312,"E"))
 QUIT X
 ;
