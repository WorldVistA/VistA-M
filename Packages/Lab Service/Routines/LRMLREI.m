LRMLREI ;BPFO/DTG - EDITED ITEMS REPORT PGM FOR NTRT PROCESS ;02/10/2016
 ;;5.2;LAB SERVICE;**468**;FEB 10 2016;Build 64
 ;
EN ;entry point
 N DA,DIE,DR,A,LD,LT,B,PS,PDT,LDT,DIDEL,LRSITE,LRFDAT,LRTDAT,LRFD,LRDTA,C,D,E,K,PAGE,LRTST
 N LRTSTN,LRTE,X,FO,FN,CRT,LR1,PGHD,QUIT,LRDT,ULINE,XDD,Y,LRROOT,LRROOTA,POP
 N DIROUT,DTOUT,FF,HD,I
 S U="^" I $G(DT)="" S DT=$$DT^XLFDT
 S B=$$SITE^VASITE,B=$P(B,U,1) I 'B D  I B="" S LRSITE="Not specified" G ST  ; not set up
 . S B=$$GET1^DIQ(8989.3,"1,",217,"I")
 S PS=$O(^LAB(66.4,"B",B,0)) I PS="" S LRSITE="Not specified" G ST  ; 66.4 not set up
 S A=$$GET1^DIQ(66.4,PS_",",.01,"I"),LRSITE=$$KSP^XUPARAM("WHERE")
 I LRSITE="" S LRSITE="Not specified"
ST ;
 K EDPRT,ULINE S XDD=^DD("DD"),$P(ULINE,"_",79)="_" K AUTO
 D HOME^%ZIS S FF=IOF,HD="Lab NTRT File 60 Audited items Report" W @IOF,!?(IOM-$L(HD)\2),HD,!!!
 S Y=DT X XDD S LRDT(0)=Y,PGHD="Lab NTRT File 60 Audited items Report"
 S LRFD=$$NOW^XLFDT
 ;
 S DIR(0)="D^3160101:"_LRFD_":EX",DIR("A")="Enter From Date" D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT))!($D(DIRUT))!($D(DIROUT)) W !,*7,"Starting Date Not Selected" G DONE
 S LRFDAT=Y\1
 S DIR(0)="D^"_LRFDAT_":"_LRFD_":EX",DIR("A")="Enter To Date" D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT))!($D(DIRUT))!($D(DIROUT)) W !,*7,"Ending Date Not Selected" G DONE
 S LRTDAT=Y
 ;
DEVICE S %ZIS="Q",%ZIS("A")="Output device: " D ^%ZIS
 I POP D HOME^ZIS W !,*7,"No Device Selected" G DONE
 I $D(IO("Q"))!(IOT="HFS") N ZTDTH,ZTRTN,ZTIO,ZTDESC,ZTIO,ZTSAVE S ZTDTH=$$NOW^XLFDT,ZTRTN="BK^LRMLREI",ZTIO=ION,ZTDESC="Lab NTRT Audit Items Report" D  D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued",!! G DO
 . F I="D*","XDD","ULINE","HD","FF","PGHD","LRSITE","LRFDAT","LRTDAT","LRFD" S ZTSAVE(I)=""
 G PRT
 ;
 ;
DO K ZTSK,ZTDTH,ZTRTN,ZTIO,ZTDESC,ZTIO,ZTSAVE
 G DONE
 ;
DONE ; exit
 K DA,DIE,DR,A,LD,LT,B,PS,PDT,LDT,DIDEL,LRSITE,LRFDAT,LRTDAT,LRFD,LRDTA,C,D,E,K,PAGE,LRTST
 K LRTSTN,LRTE,X,FO,FN,CRT,LR1,PGHD,QUIT,LRDT,ULINE,XDD,Y,LRROOT,LRROOTA,POP
 K DIROUT,DTOUT,FF,HD,I
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
LRS(A) ; get edit type/field
 N LRSTRING
 I A="" Q ""
 S LRSTRING=$S(A="M":"MLTF VUID",A="C":"CREATION DATE",A="T":"TST INACT DT",A="R":"SPEC INACT DT",A="E":"NTRT EXPT FLG",A="Y":"TEST TYPE",A="S":"SPEC CREATE DT",1:"")
 Q LRSTRING
 ;
BK ;entry if queued
PRT ; print report
 S (QUIT,PAGE)=0,CRT=$S($E(IOST,1,2)="C-":1,1:0),LRTSTN=""
 I CRT,PAGE=0 W @IOF
 S PAGE=PAGE+1 D HEADER
 S LRROOT="^LAB(60,""B"")",LRROOTA="^LAB(60,""B"""
 ;S LRTST=0
PL ;S LRTST=$O(^LAB(60,LRTST)) I 'LRTST G PDONE
 ; Step down the B X-ref - exclude synomyms
 S LRROOT=$Q(@LRROOT) I $E(LRROOT,1,$L(LRROOTA))'=LRROOTA G PDONE
 I $G(@LRROOT)=1 G PL
 I $G(@LRROOT) G PL
 S LRTST=$QS(LRROOT,4)
 ;
 S LRTSTN=$$GET1^DIQ(60,LRTST_",",.01,"I"),LRTSTN=$E(LRTSTN,1,40)
 S LRTE=0,LR1=0
PLE S LRTE=$O(^LAB(60,LRTST,15,LRTE)) I 'LRTE G PL
 S B=+LRTE_","_(+LRTST)
 K LRDTA,C,LRER D GETS^DIQ(60.28,B,"**","IE","C","LRER")
 I $G(LRER("DIERR"))'="" G PLE
 M LRDTA=C("60.28",B_",") K C
 ; edit date
 S C=$G(LRDTA(.01,"I")) I C="" G PLE
 S D=C\1 I D<LRFDAT G PLE
 I D>LRTDAT G PLE
 S C=$$FMTE^XLFDT(C,"7M")
 I LR1=0 W !,"TEST: ",LRTSTN
 S LR1=1
 ; specimen name if one
 S D=$G(LRDTA(.06,"I")) I D'="" S X=$$GET1^DIQ(60.01,D_","_LRTST,.01,"E"),X=$E(X,1,30) W !,?10,"Specimen: ",X
 ; edit field
 S K=$G(LRDTA(.03,"I")) I K'="" S B=$$LRS(K)
 ; user who did transaction
 S E=$G(LRDTA(.02,"E")) I E'="" S E=$E(E,1,14)
 ; test type
 S FO=$G(LRDTA(.04,"I")) I FO'="" D  ;<
 . I K="M" S FO=$$GET1^DIQ(66.3,FO_",",.01),FO=$E(FO,1,15) Q
 . I K="C"!(K="T")!(K="R")!(K="S") S FO=FO\1 S:FO<2 FO="" I FO>1 S FO=$$FMTE^XLFDT(FO,9)
 S FN=$G(LRDTA(.05,"I")) I FN'="" D  ;<
 . I K="M" S FN=$$GET1^DIQ(66.3,FN_",",.01),FN=$E(FN,1,15) Q
 . I K="C"!(K="T")!(K="R")!(K="S") S FN=FN\1 S:FN<2 FN="" I FN>1 S FN=$$FMTE^XLFDT(FN,9)
 W !,?1,C,?18,B,?32,E,?48,FO,?65,FN
 ;
 I CRT,($Y>(IOSL-4)) D  I QUIT G PDONE
 .D PAUSE
 .Q:QUIT
 .W @IOF
 .D HEADER
 E  I ('CRT),($Y>(IOSL-2)) D
 .W @IOF
 .D HEADER
 ;
 G PLE
 ;
PDONE ; print done
 W !!,?29,$S(QUIT'=1:"--- Report Finished ---",1:"--- Report Aborted ---") G DONE
 ;
HEADER ;Description: Prints the report header.
 Q:QUIT
 N LINE
 I $Y>1 W @IOF
 W !,?22,HD
 W ?70,"Page ",PAGE,!,?27,"Date Printed: "_$$FMTE^XLFDT(DT),!
 S PAGE=PAGE+1
 ;
 W !,?1,"Date",?18,"Edit Field",?32,"User",?48,"Old Value",?65,"New Value"
 W !,ULINE
 I PAGE>2 W !,"TEST: ",LRTSTN
 Q
 ;
PAUSE N DIR,DIRUT,X,Y
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="E" D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 Q
