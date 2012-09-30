IBY8POST ;ALB/AAS - UNBILLED AMOUNTS POST INT ;29-SEP-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**19**; 21-MAR-94
 ;
 ;
% N X,Y,I,J,DA,DR,DIC,DIE,DINUM,IB,DIFROM,DLAYGO
 D DT^DICRW
 D FORM,MAILGRP,EDIT
 W !!,"<<<  Post init complete!"
 G END
 ;
FORM ; -- add new entry to billing form table
 N X,Y,I,J,DA,DIC,DLAYGO,DINUM,DO,DD,IB
 S DA=$O(^IBE(353,"B","IB REPORTS",0)) G:DA FORMQ
 W !!,"<<<  Adding new entry to BILL FORM TYPE for IB REPORTS!"
 K DO,DD S X="IB REPORTS",DIC="^IBE(353,",DIC(0)="L",DLAYGO=353
 F IB=5:1:100 I '$D(^IBE(353,IB)) S DINUM=IB D FILE^DICN Q
FORMQ Q
 ;
MAILGRP ; -- Stuff in new mail group
 N A,B,C,D,E,F
 S A="IB UNBILLED AMOUNTS",B=0,C=.5,D=1,G=1
 I $D(^XMB(3.8,"B",A)) Q
 S E(DUZ)=""
 S F(1)="This mail group will be automatically mailed the IB Unbilled Amounts"
 S F(2)="report each month."
 S X="XMBGRP" X ^%ZOSF("TEST") S IBT=$T
 W !!,"<<<  Adding mail group "_A,!
 I IBT S X=$$MG^XMBGRP(A,B,C,D,.E,.F,G)
 I 'IBT D
 .S X=A
 .;
 .W !,"     You may add members at this time."
 .S DIC="^XMB(3.8,",DIC(0)="FZMNL",DLAYGO=3.8
 .S DIC("DR")="3///"_F(1)_F(2)_";4///"_$S(B=0:"PU",1:"PR")_";5///"_C_";10///0;7///"_$S(D>0:"y",1:"n")_";2"
 .D FILE^DICN I Y<0 W !,"<<<  Mail Group ("_X_") CREATION FAILED !!!" Q
 Q
 ;
EDIT ; -- Edit new site parameters
 Q:$P($G(^IBE(350.9,1,6)),"^",25)
 W !!,"<<< Updating your IB Site Parameters"
 S DA=1,DR="6.25///IB UNBILLED AMOUNTS;6.24///0",DIE="^IBE(350.9," D ^DIE
 Q
 ;
END K DLAYGO
 Q
