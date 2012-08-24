DGRP7CP ;ALB/BDB - REGISTRATION SCREEN 7 EXPANSION FIELDS FOR VBA PENSION;04/21/2011
 ;;5.3;Registration;**842**;Aug 13, 1993;Build 33
 ;
EN(DFN,QUIT) ; Display/edit Pension Award and Termination
 ; Returns QUIT=1 if ^ entered
 ;
EN1 D CLEAR^VALM1
 N DGRP,X,Z,ZP,I,DGMBCK
 F I=0,.29,.3,.31,.32,.321,.36,.362,.385,"TYPE","VET" S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 D EN^DDIOL("                 COMPENSATION AND PENSION, SCREEN <7> EXPANSION","","!")
 D EN^DDIOL($$SSNNM^DGRPU(DFN),"","!")
 S X=$S($D(DGRPTYPE):$P(DGRPTYPE,"^",1),1:"PATIENT TYPE UNKNOWN"),X1=79-$L(X) D EN^DDIOL(X,"","?X1")
 S X="",$P(X,"=",80)="" D EN^DDIOL(X,"","!")
 D EN^DDIOL("Aid & Attendance: ","","!!?17")
 S Z=$$YN2^DG1010P0(DGRP(.362),12) D MBCK^DGRP7 D EN^DDIOL(Z,"","?0")
 D EN^DDIOL("Housebound: ","","!?23")
 S Z=$$YN2^DG1010P0(DGRP(.362),13) D MBCK^DGRP7 D EN^DDIOL(Z,"","?0")
 D EN^DDIOL("VA Pension: ","","!?23")
 I $P(DGRP(.362),"^",14)']"" D EN^DDIOL("UNANSWERED","","?0")
 I $P(DGRP(.362),"^",14)]"" S ZP=$$YN2^DG1010P0(DGRP(.362),14) D MBCK^DGRP7 D EN^DDIOL(ZP,"","?0") D
 . I $P(DGRP(.385),"^",1)]"" D EN^DDIOL("Pension Award Effective Date: ","","!?5") S Z=$$DATENP^DG1010P0(DGRP(.385),1) D EN^DDIOL(Z,"","?0") D
 .. S Z=$$GET1^DIQ(2,DFN,.3852,"I") I Z]"" D EN^DDIOL("Pension Award Reason: ","","!?13") S Z=$$GET1^DIQ(27.18,Z,.01,"E") D EN^DDIOL(Z,"","?0")
 . I $E(ZP,1)="N",$P(DGRP(.385),"^",3)]"" D EN^DDIOL("Pension Terminated Date: ","","!?10") S Z=$$DATENP^DG1010P0(DGRP(.385),3) D EN^DDIOL(Z,"","?0") D
 .. S Z=$$GET1^DIQ(2,DFN,.3854,"I") I Z]"" D EN^DDIOL("Pension Terminated Reason 1: ","","!?6") S Z=$$GET1^DIQ(27.18,Z,.01,"E") D EN^DDIOL(Z,"","?0")
 .. S Z=$$GET1^DIQ(2,DFN,.3855,"I") I Z]"" D EN^DDIOL("Pension Terminated Reason 2: ","","!?6") S Z=$$GET1^DIQ(27.18,Z,.01,"E") D EN^DDIOL(Z,"","?0")
 .. S Z=$$GET1^DIQ(2,DFN,.3856,"I") I Z]"" D EN^DDIOL("Pension Terminated Reason 3: ","","!?6") S Z=$$GET1^DIQ(27.18,Z,.01,"E") D EN^DDIOL(Z,"","?0")
 .. S Z=$$GET1^DIQ(2,DFN,.3857,"I") I Z]"" D EN^DDIOL("Pension Terminated Reason 4: ","","!?6") S Z=$$GET1^DIQ(27.18,Z,.01,"E") D EN^DDIOL(Z,"","?0")
 D EN^DDIOL("VA Disability: ","","!?20") S Z=$$YN2^DG1010P0(DGRP(.3),11) D MBCK^DGRP7 D EN^DDIOL(Z,"","?0")
 D EN^DDIOL("Total Check Amount: ","","!?15") S Z=$$DISP^DG1010P0(DGRP(.362),20,'DGMBCK) D EN^DDIOL($S(Z:"$"_Z,1:Z),"","?0")
 D EN^DDIOL("GI Insurance: ","","!?21") D EN^DDIOL($$YN2^DG1010P0(DGRP(.362),17),"","?0")
 D EN^DDIOL("Amount: ","","!?27") S Z=$$DISP^DG1010P0(DGRP(.362),6) D EN^DDIOL($S(Z:"$"_Z,1:Z),"","?0")
 D EN^DDIOL(" ","","!!")
 Q
 ;
DTCHK ;check to see that the pension award date is not greater than today or less that DOB+16 years
 I $G(X)>DT D EN^DDIOL("The Pension Award Date must not be greater than today.","","!!!") K X Q
 I $G(X)<($P(^DPT(DFN,0),U,3)+160000) D EN^DDIOL("The Pension Award Date must not be before the patient's 16th birthday.","","!!!") K X
 Q
 ;
DISPPEN ;
 I $P(DGRP(.362),"^",14)]"" S ZP=$$YN2^DG1010P0(DGRP(.362),14) D
 . I $P(DGRP(.385),"^",1)]"" D EN^DDIOL("Pension Award Effective Date: ","","!?5") S Z=$$DATENP^DG1010P0(DGRP(.385),1) D EN^DDIOL(Z,"","?0") D
 .. S Z=$$GET1^DIQ(2,DFN,.3852,"I") I Z]"" D EN^DDIOL("Pension Award Reason: ","","!?13") S Z=$$GET1^DIQ(27.18,Z,.01,"E") D EN^DDIOL(Z,"","?0")
 . I $E(ZP,1)="N",$P(DGRP(.385),"^",3)]"" D EN^DDIOL("Pension Terminated Date: ","","!?10") S Z=$$DATENP^DG1010P0(DGRP(.385),3) D EN^DDIOL(Z,"","?0") D
 .. S Z=$$GET1^DIQ(2,DFN,.3854,"I") I Z]"" D EN^DDIOL("Pension Terminated Reason 1: ","","!?6") S Z=$$GET1^DIQ(27.18,Z,.01,"E") D EN^DDIOL(Z,"","?0")
 .. S Z=$$GET1^DIQ(2,DFN,.3855,"I") I Z]"" D EN^DDIOL("Pension Terminated Reason 2: ","","!?6") S Z=$$GET1^DIQ(27.18,Z,.01,"E") D EN^DDIOL(Z,"","?0")
 .. S Z=$$GET1^DIQ(2,DFN,.3856,"I") I Z]"" D EN^DDIOL("Pension Terminated Reason 3: ","","!?6") S Z=$$GET1^DIQ(27.18,Z,.01,"E") D EN^DDIOL(Z,"","?0")
 .. S Z=$$GET1^DIQ(2,DFN,.3857,"I") I Z]"" D EN^DDIOL("Pension Terminated Reason 4: ","","!?6") S Z=$$GET1^DIQ(27.18,Z,.01,"E") D EN^DDIOL(Z,"","?0")
 ;
