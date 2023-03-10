RCP371 ;AITC/DOM - Patch PRCA*4.5*371 Post Installation Processing ;20 Feb 2020 14:00:00
 ;;4.5;Accounts Receivable;**371**;Feb 20, 2020;Build 29
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ;
 D CMPTMP ;
 D BMES^XPDUTL("PRCA*4.5*371 post-installation finished "_$$HTE^XLFDT($H))
 Q
 ;
CMPTMP ; Recompile ACCOUNTS RECEIVABLE (#430) input templates due to the new AMCCF index
 N X,Y,DMAX
 D MES^XPDUTL(">> Recompile Input Templates for Accounts Receivable (#430) screens...")
 ;
 S DMAX=$$ROUSIZE^DILF
 S X="PRCATA",Y=$$FIND1^DIC(.402,,"X","PRCA OLD SET","B")
 I Y D EN^DIEZ
 ;
 S DMAX=$$ROUSIZE^DILF
 S X="PRCATE",Y=$$FIND1^DIC(.402,,"X","PRCA SET","B")
 I Y D EN^DIEZ
 ;
 S DMAX=$$ROUSIZE^DILF
 S X="PRCATSE",Y=$$FIND1^DIC(.402,,"X","PRCASV REL","B")
 I Y D EN^DIEZ
 Q
 ;
IXCHK ; Check for new MCCF Index creation
 I $D(^RCY(344.31,"MCCF")),$D(^RCY(344.4,"MCCF")) D  Q
 . D BMES^XPDUTL("MCCF Indices created.")
 D BMES^XPDUTL("MCCF Indices not created.")
 Q
 ;
