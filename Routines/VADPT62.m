VADPT62 ;ALB/MJK - Patient ID Trigger Nodes ; 11 MAR 1991
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ; This routine contains all the the 1 and 2 nodes for triggers
 ; on fields in the PATIENT ELIGIBILITIES multiple of the
 ; PATIENT file.
 ;
 ; Because of the layered nature of the execution of these
 ; triggers, M11+ could not handle their execution reliably.
 ; Store errors would sometimes occur.
 ;
 ; By placing the code for these nodes in this rouitne, the operating
 ; system will not have use up as much symbol space to store the
 ; executeable code. The 1 and 2 nodes now only contain calls
 ; to the appropriate tag in this routine. [Tag 'P31' is the
 ; tag called by the 3rd cross reference of the LONG ID field
 ; to execute the 'set' logic of the trigger - ^DD(2.0361,.03,1,3,1).]
 ;
E31 ; -- first set node of ^DD(2.0361,.01,1,3,1) trigger on ELIGIBILITY field
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DPT(D0,"E",D1,0)):^(0),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y X ^DD(2.0361,.01,1,3,1.1) X ^DD(2.0361,.01,1,3,1.4)
 Q
 ;
E32 ; -- first kill node of ^DD(2.0361,.01,1,3,2) trigger on ELIGIBILITY field
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DPT(D0,"E",D1,0)):^(0),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2.0361,.01,1,3,2.4)
 Q
 ;
L11 ; -- first set node of ^DD(2.0361,.03,1,1,1) trigger on LONG ID field
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DPT(D0,"E",D1,0)):^(0),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y X ^DD(2.0361,.03,1,1,1.1) X ^DD(2.0361,.03,1,1,1.4)
 Q
 ;
L12 ; -- first kill node of ^DD(2.0361,.03,1,1,2) trigger on LONG ID field
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DPT(D0,"E",D1,0)):^(0),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" X ^DD(2.0361,.03,1,1,2.4)
 Q
 ;
L31 ; -- first set node of ^DD(2.0361,.03,1,3,1) trigger on LONG ID field
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA S Y(0)=X S X=$S('$D(^DPT(DA(1),.36)):0,1:DA=+^(.36)) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.36)):^(.36),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X=DIV X ^DD(2.0361,.03,1,3,1.4)
 Q
 ;
L32 ; -- first kill node of ^DD(2.0361,.03,1,3,2) trigger on LONG ID
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA S Y(0)=X S X=$S('$D(^DPT(DA(1),.36)):0,1:DA=+^(.36)) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.36)):^(.36),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2.0361,.03,1,3,2.4)
 Q
 ;
S31 ; -- first set node of ^DD(2.0361,.04,1,3,1) trigger on SHORT ID field
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA S Y(0)=X S X=$S('$D(^DPT(DA(1),.36)):0,1:DA=+^(.36)) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.36)):^(.36),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X=DIV S X=DIV X ^DD(2.0361,.04,1,3,1.4)
 Q
 ;
S32 ; -- first kill node of ^DD(2.0361,.04,1,3,2) trigger on SHORT ID field
 K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA S Y(0)=X S X=$S('$D(^DPT(DA(1),.36)):0,1:DA=+^(.36)) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.36)):^(.36),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X="" X ^DD(2.0361,.04,1,3,2.4)
 Q
 ;
