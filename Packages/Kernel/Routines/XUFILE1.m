XUFILE1 ;SF/XAK - ASSIGN & DELETE FILE ACCESS ;1/25/93  11:42 ;12/2/91  1:17 PM
 ;;8.0;KERNEL;;Jul 10, 1995
DELF ;
 S DIC=$S(DUZ(0)="@":"^DIC(",1:"^VA(200,DUZ,""FOF"","),DIC(0)="QEAM"
 S DIC("A")="Select FILE to delete all access from: " D ^DIC G KIL:Y<0 K DIC
DF S %=2 W !,"Are you sure you want to delete all access to the "_$P(Y,U,2)_" file"
 D YN^DICN G KIL:%<0!(%=2)
 I '% W !!?5,"Answer YES to delete all access, or NO to leave things as they are.",! G DF
 S ZTRTN="DQ^XUFILE1",ZTSAVE("XUW")=+Y
 S ZTDESC="Delete all Access to the "_$P(Y,U,2)_" file.",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD W !,"Request Queued" G KIL
DQ F DA(1)=0:0 S DA(1)=$O(^VA(200,"AFOF",XUW,DA(1))) Q:DA(1)'>0  S DA=XUW,DIK="^VA(200,"_DA(1)_",""FOF""," D ^DIK
 G KIL
DELI ;
 S DIC("A")="Select USER whose Access you want to remove: "
 S DIC("S")="I $O(^VA(200,Y,""FOF"",0))>0"
 S DIC=200,DIC(0)="QEAM" D ^DIC G KIL:Y<0 S DA(1)=+Y K DIC
D1 S %=2 W !,"Are you sure you want to remove all of "_$P(Y,U,2)_"'s access"
 D YN^DICN G KIL:%<0!(%=2)
 I '% W !!?5,"Answer YES to delete all access, or NO to leave things as they are.",! G D1
 S ZTRTN="D2^XUFILE1",ZTSAVE("DA(")=""
 S ZTDESC="Delete all Access to Files for one user",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD W !,"Request Queued" G KIL
D2 S DIK="^VA(200,"_DA(1)_",""FOF"","
 F DA=0:0 S DA=$O(^VA(200,DA(1),"FOF",DA)) Q:DA'>0  D ^DIK
KIL G KIL^XUFILE
 ;
ACC D L^DICRW1 Q:X'>0!($D(DTOUT))  S L=0,BY="[XUFILE BY FILE NUMBER]",FR=X,TO=DIB(1),FLDS="[XUFILE ACCESS ABBREVIATED]",DIC="^VA(200," K DIB D EN1^DIP G KIL
