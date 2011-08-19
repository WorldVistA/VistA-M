DGPTMSG ;ALB/JDS/AS - PTF MESSAGE ENTRY/EDIT/PRINT ; 7 NOV 89  14:46
 ;;5.3;Registration;**164**;Aug 13, 1993
 ;
 D LO^DGUTL
PAT K DIC("S") S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC G Q:Y'>0 S DFN=+Y,(DGMISD,DGADMTY)=""
 I $D(^DPT(DFN,.1)) S D=$O(^DIC(42,"B",^(.1),0)) I D>0 S D=+$P(^DIC(42,D,0),"^",11),DGMISD=$S($D(^DG(40.8,+D,"DEV")):$P(^("DEV"),"^",4),1:"")
 I DGMISD="" S DGMISD=$P(^DG(43,1,0),"^",19) G Q:DGMISD=""
 K DGMSG D DICN1^DGPTMSG1 G Q:Y<0
 S DA=+Y,DR="10",DIE="^DGM(" D ^DIE
 I '$O(^DGM(DA,"M",0)) S DIK=DIE D ^DIK W !,"MESSAGE DELETED" G PAT
 S DGPGM="PR^DGPTMSG",DGVAR="DGADMTY^DA",ZTIO=DGMISD,DGUTQND=""
 D Q1^DGUTQ W !!,"***** MESSAGE SENT *****",*7,!!
 G PAT
PR ;
 U IO S RET="",L=$S($D(^DGM(+DA,0)):^(0),1:0) G Q:'L S DFN=$P(L,"^",2),L1=$S($D(^DPT(+DFN,0)):^(0),1:""),X="N",%DT="T" D ^%DT S NOW=Y W !!," Mess #: ",+L,?20,"Name: ",$E($P(L1,"^",1),1,27),?55," SSN: ",$P(L1,"^",9),!
 S D=$P(L,"^",4) W "Entered: " W:D $TR($$FMTE^XLFDT(D,"5DF")," ","0") W ?22,"By: ",$S($D(^VA(200,+$P(L,"^",3),0)):$P(^(0),U,1),1:""),?55,"Ward: ",$S($D(^DPT(DFN,.1)):^(.1),1:"")
 W !,"   Time: " W:D#1 $E(D,9,10),":",$E(D_"0000",11,12) W ?51,"Room/bed: ",$S($D(^DPT(DFN,.101)):^(.101),1:""),!
 W "Printed: ",$TR($$FMTE^XLFDT(NOW,"5DF")," ","0"),?20,"Time: ",$E(NOW_"00000",9,10)_":"_$E(NOW_"00000",11,12)
 W ?41,"Treating Specialty: ",$S($D(^DPT(DFN,.103)):$S($D(^DIC(45.7,+^(.103),0)):$P(^(0),U,1),1:""),1:""),!
 I DGADMTY]"" W "Admission Type: ",$S($D(^DG(405.1,+DGADMTY,0)):$P(^(0),"^",1),1:"NOT SPECIFIED")
 W ?51,"Provider: ",$S($D(^DPT(DFN,.104)):$S($D(^VA(200,+^(.104),0)):$P(^(0),U,1),1:""),1:""),!
 S DIC="^DGM(",DR="M" K ^UTILITY($J) D EN^DIQ
 S DR="4///NOW",DIE="^DGM(",DP=45.5 D ^DIE
 I RET S DIE="^DGM(",DR="4///NOW;5///P",DP=45.5 D ^DIE
 G QQ:$O(^DGM(DA,"E",0))'>0 W !,"Edited",?17,"Retran",?25,"By",! F I=1:1:60 W "="
 F I=0:0 S I=$O(^DGM(DA,"E",I)) Q:I'>0  S L=^(I,0),D=+L W !,$TR($$FMTE^XLFDT(D,"5DF")," ","0"),"@",$E(D_"0000",9,10),":",$E(D_"00000",11,12),?17,$S($P(L,"^",3):"YES",1:"NO"),?25,$S($D(^VA(200,+$P(L,"^",2),0)):$P(^(0),U,1),1:"")
QQ D:IO]"" ^%ZISC Q
 ;
IN S DIC="^DGM(",DIC(0)="AEQMZ"
PA D ^DIC K DIC("S") G Q:Y'>0 S DA=+Y
 S L=^DGM(DA,0),DFN=$P(L,"^",2),L1=^DPT(DFN,0),NOW=$P(L,U,5) W !!," Mess #: ",+L,?20,"Name: ",$E($P(L1,"^",1),1,27),?55," SSN: ",$P(L1,"^",9),!
 S D=$P(L,"^",4) W "Entered: ",$TR($$FMTE^XLFDT(D,"5DF")," ","0"),?22,"By: ",$S($D(^VA(200,+$P(L,"^",3),0)):$P(^(0),U,1),1:""),?55,"Ward: ",$S($D(^DPT(DFN,.1)):^(.1),1:"")
 W !,"   Time: ",$E(D,9,10),":",$E(D_"0000",11,12),?51,"Room/bed: ",$S($D(^DPT(DFN,.101)):^(.101),1:""),!
 W "Printed: " W:NOW $TR($$FMTE^XLFDT(NOW,"5DF")," ","0") W ?22,"Time: " W:NOW $E(NOW_"00000",9,10)_":"_$E(NOW_"00000",11,12) W !
 G M:+$P(L,U,7)'>0 S N=$P(L,U,7)_"00000" W "Chk off: ",$TR($$FMTE^XLFDT(N,"5DF")," ","0"),?22,"Time: ",$E(N,9,10)_":"_$E(N,11,12),?53,"By: ",$E($S($D(^VA(200,+$P(L,U,8),0)):$P(^(0),U,1),1:""),1,22),!
M S DIC="^DGM(",DR="M" D EN^DIQ
 G PA:$O(^DGM(DA,"E",0))'>0 W !,"Edited",?17,"Retran",?25,"By",! F I=1:1:60 W "="
 F I=0:0 S I=$O(^DGM(DA,"E",I)) Q:I'>0  S L=^(I,0),D=+L W !,$TR($$FMTE^XLFDT(D,"5DF")," ","0"),"@",$E(D_"0000",9,10),":",$E(D_"00000",11,12),?17,$S($P(L,"^",3):"YES",1:"NO"),?25,$S($D(^VA(200,+$P(L,"^",2),0)):$P(^(0),U,1),1:"")
 W !! G PA
 ;
Q K DGADMTY,DGMISD,DGPGM,DGUTQND,DGVAR,%DT,D,DA,DIC,DIE,DIK,DP,DR,I,L,L1,N,NOW,RET,X,Y,ZTIO Q
