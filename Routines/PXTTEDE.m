PXTTEDE ;ISL/PKR - Edit an education topic ;6/11/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;
 ;=======================================================================
 N DA,DIC,Y
GETNAME ;
 S DIC="^AUTTEDT("
 S DIC(0)="AEMQ",DIC("A")="Select EDUCATION TOPIC: "
 S DIC("S")="S PXRMSNUM=+$P($$SITE^VASITE,U,3) I $S(PXRMSNUM=5000:1,+$G(Y)'<100000:1,1:0)"
 W !
 D ^DIC
 I Y=-1 G END
 S DA=$P(Y,U,1)
 D EDIT(DIC,DA)
 G GETNAME
 ;
END K DIC,PXY
 Q
 ;=======================================================================
 ;
EDIT(ROOT,DA) ;
 N DIE,DR
 S DIE=ROOT
 S DR="[PXTT EDIT PAT. EDUCATION]"
 D ^DIE
 Q
