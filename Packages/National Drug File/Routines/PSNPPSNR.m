PSNPPSNR ;HP/AF-CONF option continued ; 05 Mar 2014  1:20 PM
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;External reference to ^ORD(101 supported by DBIA #872
 ;External reference ^DIC(19.2 supported by DBIA #1472
 ;Reference to ^DIC(19 supported by DBIA #2246
 ;Reference to ^DIC(19.2 supported by DBIA #2910
 ;Reference to ^ORD( supported by DBIA #872
 ;
 ;Mark Scheduled options, menu options, and protocol out of order.
 ;Used by UPDT - Begin update of NDF data from PPS-N option during install of PPS-N/NDF Update file. 
DISOPTS ;
 N DIRUT,DUOUT,DIR,X,Y,PPG,DA,DIC,DIE,DR,DUOUT,DIRUT,PPSN
 S (Y,X,PPG)="",DIR(0)="Y",DIR("?")="Please enter Y or N."
 S DIR("A")="Do you want to DISABLE Scheduled Options, Menu Options and Protocols"
 S DIR("B")="YES"
 D ^DIR
 Q:Y="^"!("Nn"[Y)!('Y)!$G(DIRUT)!$G(DTOUT)
 F  D DISSO Q:PPG=""!$G(DIRUT)!$G(DTOUT)
 F  D DISMO Q:PPG=""!$G(DIRUT)!$G(DTOUT)
 F  D DISPR Q:PPG=""!$G(DIRUT)!$G(DTOUT)
 K ^TMP("PSNPPSNR",$J)
 Q
 ;
DISSO ;
 N DIC,DIK,DR,DIR,DA,I,II,III,IV,ICNT,X,Y,DIE,DTOUT,DIRUT,DUOUT,SCHED,FILEIEN,MENUN,SOPT,ALLOF,ALLOF2,ALLNAM,LENGTH,FDA
 S PPG=1
 ;
DISSO1 ;
 D HDR^PSNPARM
DISSOS ;
 W !,"Enter the name or partial name of the Scheduled Option that you wish to have",!,"paused during the processing."
 K ^TMP("PSNPPSNR",$J),PPSN
 S (I,II,III,ICNT,X)=0,ICNT=0
 F  S X=$O(^PS(57.23,1,3,"B",X)) Q:'$G(X)  F  S I=$O(^PS(57.23,1,3,"B",X,I)) Q:I=""  D
 .S ^TMP("PSNPPSNR",$J,X)=I
 .S ICNT=ICNT+1,SOPT="",SOPT=$$GET1^DIQ(19.2,X,.01,"E") S:SOPT'="" PPSN(SOPT,ICNT)=I
 W:ICNT>0 !!?3,"PPS-N Scheduled Options defined to mark 'out of order':"
 F  S I=$O(PPSN(I)) Q:I=""  W !?8,I I $Y>20 R !,"Enter to continue...",X:120 W @IOF
 I $D(PPSN(2)) S I="" F  S I=$O(PPSN(I)) Q:I=""  W !,"    "_PPSN(I)
 R !!,"Scheduled Options: ",Y:120
 I $G(Y)=""!(Y=-1)!($G(DTOUT))!($G(DIRUT))!($G(DUOUT)) S PPG="" Q
 I Y="?" W @IOF,!!,"Enter the Scheduled Option that you wish to have paused during the",!,"processing of the update file or '??' for more help. ",! G DISSOS
 I Y="??" W @IOF D SHELP R !,"Enter to continue...",X:120 G DISSO1
 ;
 ;set all beginning with a prefix
 I Y["*" S ALLOF=$P(Y,"*"),LENGTH=$L(ALLOF) D  G DISSO1
 .F  S III=$O(^DIC(19.2,"B",III)) Q:III=""  S IV="" F  S IV=$O(^DIC(19.2,"B",III,IV)) Q:IV=""  D
 ..S ALLNAM=$$GET1^DIQ(19.2,IV,.01,"E")
 ..Q:ALLNAM=""
 ..S ALLOF2=$E(ALLNAM,1,LENGTH)
 ..I ALLOF=ALLOF2 D
 ...Q:$D(^PS(57.23,1,3,"B",IV))
 ...S DIC="^PS(57.23,1,3,",DA(1)=1
 ...S FDA(57.24,"+1,1,",.01)=IV
 ...D UPDATE^DIE("","FDA","","ERROR")
 ;
 ;delete all beginning with a prefix
 I Y["@" S ALLOF=$P(Y,"@"),LENGTH=$L(ALLOF) D  G DISSO1
 .K DIR S DIR("?")="Please enter Y or N.",DIR("B")="NO"
 .S DIR("A")="Are you sure that you want to delete ALL items starting with "_ALLOF,DIR(0)="Y"
 .D ^DIR
 .Q:'$G(Y)
 .F  S III=$O(^PS(57.23,1,3,"B",III)) Q:III=""  S IV="",IV=$O(^PS(57.23,1,3,"B",III,IV)) D
 ..S ALLNAM=$$GET1^DIQ(19.2,III,.01,"E")
 ..I ALLNAM'="" D
 ...S ALLOF2="",ALLOF2=$E(ALLNAM,1,LENGTH)
 ...Q:ALLOF'=ALLOF2
 ...K DIK,DIC S (DIK,DIC)="^PS(57.23,1,3,"
 ...S DA(1)=1,DA=IV,DR=".01///@" D ^DIK K DIR
 ;
DISSO2 ;
 K DIC S DIC="^DIC(19.2,",DIC(0)="EQMZ",X=Y D ^DIC
 I ($G(DTOUT))!($G(DIRUT))!($G(DUOUT)) S PPG="" G DISSO1
 I 'Y!(Y=-1) W !!,"Selection not found.",! R !,"Enter to continue...",X:120 G DISSO1
 S (SCHED,FILEIEN,MENUN)="",SCHED=$P(Y,"^")
 I $D(^TMP("PSNPPSNR",$J,SCHED)) S FILEIEN=^TMP("PSNPPSNR",$J,SCHED),MENUN=$$GET1^DIQ(19,SCHED,.01,"E")
 G DISSO1:'Y!(Y=-1)!($G(DTOUT))!($G(DIRUT))!($G(DUOUT))
 ;
DISSO3 ;
 I $D(SCHED),$D(^TMP("PSNPPSNR",$J,SCHED)) D  Q
 .K DIR S DIR("?")="Please enter Y or N.",DIR("B")="NO",DIR("A")="Do you want to delete it from the PPS-N Control file"
 .S DIR(0)="Y"
 .D ^DIR
 .K DIK,DIC S (DIK,DIC)="^PS(57.23,1,3,",DA(1)=1
 .I $G(Y) S DA(1)=1,DA=FILEIEN,DR=".01///@" D ^DIK K DIR
 .Q:$G(DUOUT)!($G(DIRUT))!($G(DTOUT))!('$G(Y))
 S FDA(57.24,"+1,1,",.01)=SCHED
 D UPDATE^DIE("","FDA","","ERROR")
 Q
 ;
DISMO ;
 S PPG=1
 N DIC,DIK,DR,DIR,DA,I,II,III,IV,ICNT,X,Y,DIE,DTOUT,DIRUT,DUOUT,SCHED,FILEIEN,MENUN,SOPT,ALLOF,ALLOF2,ALLNAM,LENGTH,FDA
DISMO1 ;
 D HDR^PSNPARM
DISMOS ;
 W !,"Enter the name or partial menu name of the menu that you wish to have paused",!,"during the processing."
 K ^TMP("PSNPPSNR",$J),PPSN
 S (I,II,III,ICNT,X)=0,ICNT=0
 F  S X=$O(^PS(57.23,1,3.1,"B",X)) Q:'$G(X)  F  S I=$O(^PS(57.23,1,3.1,"B",X,I)) Q:I=""  D
 .S ^TMP("PSNPPSNR",$J,X)=I
 .S ICNT=ICNT+1,SOPT="",SOPT=$$GET1^DIQ(19,X,.01,"E") S:SOPT'="" PPSN(SOPT,ICNT)=I
 W:ICNT>0 !!?3,"PPS-N Menu Options defined to mark 'out of order':"
 F  S I=$O(PPSN(I)) Q:I=""  W !?8,I I $Y>20 R !,"Enter to continue...",X:120 W @IOF
 I $D(PPSN(2)) S I="" F  S I=$O(PPSN(I)) Q:I=""  W !,"    "_PPSN(I)
 R !!,"Menu Option: ",Y:120
 I $G(Y)=""!(Y=-1)!($G(DTOUT))!($G(DIRUT))!($G(DUOUT)) S PPG="" Q
 I Y="?" W !!,"Enter the Menu Option that you wish to have paused during the processing of the update file or '??' for more help. ",! G DISMOS
 I Y="??" W @IOF D SHELP R !,"Enter to continue...",X:120 G DISMO1
 ;
 ;set all beginning with a prefix
 I Y["*" S ALLOF=$P(Y,"*"),LENGTH=$L(ALLOF) D  G DISMO1
 .F  S III=$O(^DIC(19,"B",III)) Q:III=""  S IV="" F  S IV=$O(^DIC(19,"B",III,IV)) Q:IV=""  D
 ..S ALLNAM=$$GET1^DIQ(19,IV,.01,"E")
 ..Q:ALLNAM=""
 ..S ALLOF2=$E(ALLNAM,1,LENGTH)
 ..I ALLOF=ALLOF2 D
 ...Q:$D(^PS(57.23,1,3.1,"B",IV))
 ...S DIC="^PS(57.23,1,3.1,",DA(1)=1
 ...S FDA(57.2331,"+1,1,",.01)=IV
 ...D UPDATE^DIE("","FDA","","ERROR")
 ;
 ;delete all beginning with a prefix
 I Y["@" S ALLOF=$P(Y,"@"),LENGTH=$L(ALLOF) D  G DISMO1
 .K DIR S DIR("?")="Please enter Y or N.",DIR("B")="NO",DIR("A")="Are you sure that you want to delete ALL items starting with "_ALLOF
 .S DIR(0)="Y"
 .D ^DIR
 .Q:'$G(Y)
 .F  S III=$O(^PS(57.23,1,3.1,"B",III)) Q:III=""  S IV="",IV=$O(^PS(57.23,1,3.1,"B",III,IV)) D
 ..S ALLNAM=$$GET1^DIQ(19,III,.01,"E")
 ..I ALLNAM'="" D
 ...S ALLOF2="",ALLOF2=$E(ALLNAM,1,LENGTH)
 ...Q:ALLOF'=ALLOF2
 ...K DIK,DIC S (DIK,DIC)="^PS(57.23,1,3.1,"
 ...S DA(1)=1,DA=IV,DR=".01///@" D ^DIK K DIR
 ;
DISMO2 ;
 K DIC S DIC="^DIC(19,",DIC(0)="EQMZ",X=Y D ^DIC
 I ($G(DTOUT))!($G(DIRUT))!($G(DUOUT)) S PPG="" G DISMO1
 I 'Y!(Y=-1) W !!,"Selection not found.",! R !,"Enter to continue...",X:120 G DISMO1
 S (SCHED,FILEIEN,MENUN)="",SCHED=$P(Y,"^")
 I $D(^TMP("PSNPPSNR",$J,SCHED)) S FILEIEN=^TMP("PSNPPSNR",$J,SCHED),MENUN=$$GET1^DIQ(19,SCHED,.01,"E")
 G DISMO1:'Y!(Y=-1)!($G(DTOUT))!($G(DIRUT))!($G(DUOUT))
 ;
DISMO3 ;
 I $D(SCHED),$D(^TMP("PSNPPSNR",$J,SCHED)) D  Q
 .K DIR S DIR("?")="Please enter Y or N.",DIR("B")="NO",DIR("A")="Do you want to delete it from the PPS-N Control file"
 .S DIR(0)="Y"
 .D ^DIR
 .K DIK,DIC S (DIK,DIC)="^PS(57.23,1,3.1,",DA(1)=1
 .I $G(Y) S DA(1)=1,DA=FILEIEN,DR=".01///@" D ^DIK K DIR
 .Q:$G(DUOUT)!($G(DIRUT))!($G(DTOUT))!('$G(Y))
 S FDA(57.2331,"+1,1,",.01)=SCHED
 D UPDATE^DIE("","FDA","","ERROR")
 Q
 ;
DISPR ;
 ;
 S PPG=1
 N DIC,DIK,DR,DIR,DA,I,II,III,IV,ICNT,X,Y,DIE,DTOUT,DIRUT,DUOUT,SCHED,FILEIEN,MENUN,SOPT,ALLOF,ALLOF2,ALLNAM,LENGTH,FDA
DIPRO1 ;
 D HDR^PSNPARM
DIPROS ;
 W !,"Enter the name or partial name of the protocol that you wish to have",!,"paused during the processing."
 K ^TMP("PSNPPSNR",$J),PPSN
 S (I,II,III,ICNT,X)=0,ICNT=0
 F  S X=$O(^PS(57.23,1,3.2,"B",X)) Q:'$G(X)  F  S I=$O(^PS(57.23,1,3.2,"B",X,I)) Q:I=""  D
 .S ^TMP("PSNPPSNR",$J,X)=I
 .S ICNT=ICNT+1,SOPT="",SOPT=$$GET1^DIQ(101,X,.01,"E") S:SOPT'="" PPSN(SOPT,ICNT)=I
 W:ICNT>0 !!?3,"PPS-N Protocols defined to mark 'out of order':"
 F  S I=$O(PPSN(I)) Q:I=""  W !?8,I I $Y>20 R !,"Enter to continue...",X:120 W @IOF
 I $D(PPSN(2)) S I="" F  S I=$O(PPSN(I)) Q:I=""  W !,"    "_PPSN(I)
 R !!,"Protocol: ",Y:120
 I $G(Y)=""!(Y=-1)!($G(DTOUT))!($G(DIRUT))!($G(DUOUT)) S PPG="" Q
 I Y="?" W !!,"Enter the Protocol that you wish to have paused during the processing of the update file or '??' for more help. ",! G DIPROS
 I Y="??" W @IOF D SHELP R !,"Enter to continue...",X:120 G DIPRO1
 ;
 ;set all beginning with a prefix
 I Y["*" S ALLOF=$P(Y,"*"),LENGTH=$L(ALLOF) D  G DIPRO1
 .F  S III=$O(^ORD(101,"B",III)) Q:III=""  S IV="" F  S IV=$O(^ORD(101,"B",III,IV)) Q:IV=""  D
 ..S ALLNAM=$$GET1^DIQ(101,IV,.01,"E")
 ..Q:ALLNAM=""
 ..S ALLOF2=$E(ALLNAM,1,LENGTH)
 ..I ALLOF=ALLOF2 D
 ...Q:$D(^PS(57.23,1,3.2,"B",IV))
 ...S DIC="^PS(57.23,1,3.2,",DA(1)=1
 ...S FDA(57.2332,"+1,1,",.01)=IV
 ...D UPDATE^DIE("","FDA","","ERROR")
 ;
 ;delete all beginning with a prefix
 I Y["@" S ALLOF=$P(Y,"@"),LENGTH=$L(ALLOF) D  G DIPRO1
 .K DIR S DIR("?")="Please enter Y or N.",DIR("B")="NO",DIR("A")="Are you sure that you want to delete ALL items starting with "_ALLOF
 .S DIR(0)="Y"
 .D ^DIR
 .Q:'$G(Y)
 .F  S III=$O(^PS(57.23,1,3.2,"B",III)) Q:III=""  S IV="",IV=$O(^PS(57.23,1,3.2,"B",III,IV)) D
 ..S ALLNAM=$$GET1^DIQ(101,III,.01,"E")
 ..I ALLNAM'="" D
 ...S ALLOF2="",ALLOF2=$E(ALLNAM,1,LENGTH)
 ...Q:ALLOF'=ALLOF2
 ...K DIK,DIC S (DIK,DIC)="^PS(57.23,1,3.2,"
 ...S DA(1)=1,DA=IV,DR=".01///@" D ^DIK K DIR
 ;
 ;
DIPRO2 ;
 K DIC S DIC="^ORD(101,",DIC(0)="EQMZ",X=Y D ^DIC
 I ($G(DTOUT))!($G(DIRUT))!($G(DUOUT)) S PPG="" G DIPRO1
 I 'Y!(Y=-1) W !!,"Selection not found.",! R !,"Enter to continue...",X:120 G DIPRO1
 S (SCHED,FILEIEN,MENUN)="",SCHED=$P(Y,"^")
 I $D(^TMP("PSNPPSNR",$J,SCHED)) S FILEIEN=^TMP("PSNPPSNR",$J,SCHED),MENUN=$$GET1^DIQ(101,SCHED,.01,"E")
 G DIPRO1:'Y!(Y=-1)!($G(DTOUT))!($G(DIRUT))!($G(DUOUT))
 ;
DIPRO3 ;
 I $D(SCHED),$D(^TMP("PSNPPSNR",$J,SCHED)) D  Q
 .K DIR S DIR("?")="Please enter Y or N.",DIR("B")="NO"
 .S DIR("A")="Do you want to delete it from the PPS-N Control file",DIR(0)="Y"
 .D ^DIR
 .K DIK,DIC S (DIK,DIC)="^PS(57.23,1,3.2,",DA(1)=1
 .I $G(Y) S DA(1)=1,DA=FILEIEN,DR=".01///@" D ^DIK K DIR
 .Q:$G(DUOUT)!($G(DIRUT))!($G(DTOUT))!('$G(Y))
 S FDA(57.2332,"+1,1,",.01)=SCHED
 D UPDATE^DIE("","FDA","","ERROR")
 G DISPR
 Q
 ;
SHELP ;
 W !,"You are building a list of options and/or protocols to be marked 'Out"
 W !,"Of Order'. You may enter them in several different ways:"
 W !,"You may simply enter an option or protocol name,"
 W !," or  NAM  for a listing all that begin with the characters 'NAM'"
 W !," or  ^    to quit and exit the program,"
 W !," or  ?    to see a brief help prompt,"
 W !," or  ??   to see this help screen again,"
 W !," or  ???  to see all entries"
 W !," or NAM* to select everything that begins with the characters 'NAM'"
 W !," or NAM@ remove item that begin with the characters 'NAM'"
 W !
 Q
