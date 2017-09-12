XU8P453 ;OAK_BP/CMW - NPI Phase2 ;01-Jun-07
 ;;8.0;KERNEL;**453**; Jul 10, 1995;Build 36
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; NPI Phase2 release
 ; Create mail group on local machine
 ; 
 Q
 ;
POST ; Entry point for post install
 ;
 ; remove mail group if it already exists
 N Y
 S X="NPI EXTRACT VERIFICATION" S D="B",DIC=3.8,DIC(0)="" D IX^DIC
 I +Y D
 . N DIK,DA
 . S DIK="^XMB(3.8,",DA=+Y
 . D ^DIK
 ;
MAILGRP ; -- Create new mail group
 W !!,"Creating new Mailgroup NPI EXTRACT VERIFICATION"
 W !!,*7,"<<<  Person running this process will automatically be added to mail group!  >>>"
 N A,B,C,D,E,F,G,X,IBT
 S A="NPI EXTRACT VERIFICATION",B=0,C=.5,D=0,G=1
 I $G(DUZ)="" W !,"NO USER" G END
 S E(DUZ)=""
 S F(1)="Members of this mail group will automatically receive an email verification entry"
 S F(2)="for each NPI Extract file that has been generated at the sites."
 S X="XMBGRP" X ^%ZOSF("TEST") S IBT=$T
 I IBT D
 . W !!,"<<<  Adding mail group "_A,!
 . S X=$$MG^XMBGRP(A,B,C,D,.E,.F,G)
 ;
 I 'IBT D
 .; -- environment pre-init check for Mailman 7.1 should not allow the
 .;    following lines to display.
 .W !!,"<<<   **NOTE**  Mail Group not created!  >>>"
 .W !,"<<<  Earlier version then Mailman 7.1 on your system!  >>>"
 .W !,"<<<  Please create a mailgroup named NPI EXTRACT VERIFICATION and add members!  >>>"
 ;
REMOTE ; Add remote mail group
 I '$D(^XMB(3.8,"B",A)) G END
 S DLAYGO=3.8,DA(1)=+X
 S DIC="^XMB(3.8,"_DA(1)_",6,",DIC(0)="L",X="vhaconpiextractmonitoring@domain.ext"
 D ^DIC
 ;
END K DLAYGO,DA,DIC
 Q
