LRMLRCP ;BPFO/DTG - FILE 60 ITEMS WITHOUT MLTF REPORT PGM FOR NTRT PROCESS ;02/10/2016
 ;;5.2;LAB SERVICE;**468**;FEB 10 2016;Build 64
 ;
 ; from option LR NDS SPECIMENS W/O VUIDS
 ;
 ; print tests and specimens that do not have a create date
EN ;entry point
 N DA,DIE,DR,A,LD,LT,B,PS,PDT,LDT,DIDEL,LRSITE,LRFDAT,LRTDAT,LRFD,LRDTA,C,D,E,K,PAGE,LRTST
 N LRTSTN,LRTE,X,FO,FN,CRT,LR1,PGHD,QUIT,LRDT,ULINE,XDD,Y,LRROOT,LRROOTA,LRNTI,AR,LXB,LXA
 N AA,DIC,DDIQ,FF,HD,I,LRNT,LRTC,LSITE,POP,DIQ
 S U="^" I $G(DT)="" S DT=$$DT^XLFDT
 S B=$$SITE^VASITE,B=$P(B,U,1) I 'B S LRSITE="Not specified" G ST  ; not set up
 S PS=$O(^LAB(66.4,"B",B,0)) I PS="" S LRSITE="Not specified" G ST  ; 66.4 not set up
 S A=$$GET1^DIQ(66.4,PS_",",.01,"I"),LRSITE=$$KSP^XUPARAM("WHERE")
 I LRSITE="" S LRSITE="Not specified"
ST ;
 K EDPRT,ULINE S XDD=^DD("DD"),$P(ULINE,"_",79)="_" K AUTO
 D HOME^%ZIS S FF=IOF,HD="Lab NDS File 60 Tests/Specimens Without MLTF Vuids Report" W @IOF,!?(IOM-$L(HD)\2),HD,!!!
 S Y=DT X XDD S LRDT(0)=Y,PGHD="Lab NDS File 60 Tests/Specimens Without MLTF Vuids Report"
 S LRFD=$$NOW^XLFDT
 ; skip the date questions
 ; S DIR(0)="D^3160101:"_LRFD_":EX",DIR("A")="Enter From Date" D ^DIR K DIR
 ; I $D(DUOUT)!($D(DTOUT))!($D(DIRUT))!($D(DIROUT)) W !,*7,"Starting Date Not Selected" G DONE
 ; S LRFDAT=Y\1
 ; S DIR(0)="D^"_LRFDAT_":"_LRFD_":EX",DIR("A")="Enter To Date" D ^DIR K DIR
 ; I $D(DUOUT)!($D(DTOUT))!($D(DIRUT))!($D(DIROUT)) W !,*7,"Ending Date Not Selected" G DONE
 ; S LRTDAT=Y
 ;
DEVICE S %ZIS="Q",%ZIS("A")="Output device: " D ^%ZIS
 I POP D HOME^ZIS W !,*7,"No Device Selected" G DONE
 I $D(IO("Q"))!(IOT="HFS") N ZTDTH,ZTRTN,ZTIO,ZTDESC,ZTIO,ZTSAVE S ZTDTH=$$NOW^XLFDT,ZTRTN="BK^LRMLRCP",ZTIO=ION,ZTDESC="Lab NTRT Edit Items Report" D  D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued",!! G DO
 . F I="D*","XDD","ULINE","HD","FF","PGHD","LRSITE","LRFDAT","LRTDAT","LRFD" S ZTSAVE(I)=""
 . ; I IOT="HFS" S:$G(IO("HFSIO"))="" IO("HFSIO")=IO
 G PRT
 ;
 ;
DO K ZTSK,ZTDTH,ZTRTN,ZTIO,ZTDESC,ZTIO,ZTSAVE
 G DONE
 ;
DONE ; exit
 K DA,DIE,DR,A,LD,LT,B,PS,PDT,LDT,DIDEL,LRSITE,LRFDAT,LRTDAT,LRFD,LRDTA,C,D,E,K,PAGE,LRTST
 K LRTSTN,LRTE,X,FO,FN,CRT,LR1,PGHD,QUIT,LRDT,ULINE,XDD,Y,LRROOT,LRROOTA,LRNTI,AR,LXB,LXA
 K AA,DIC,DDIQ,FF,HD,I,LRNT,LRTC,LSITE,POP,DIQ
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
BK ;entry if queued
PRT ; print report
 D GET664
 S (QUIT,PAGE)=0,CRT=$S($E(IOST,1,2)="C-":1,1:0),(LRTST,LRTE,LRTSTN)=""
 I CRT,PAGE=0 W @IOF
 S PAGE=PAGE+1 D HEADER
 S LRROOT="^LAB(60,""B"")",LRROOTA="^LAB(60,""B"""
PL ; Step down the B X-ref - exclude synomyms
 S LRROOT=$Q(@LRROOT) I $E(LRROOT,1,$L(LRROOTA))'=LRROOTA G PDONE
 I $G(@LRROOT)=1 G PL
 S LRTST=$QS(LRROOT,4)
 ;
 D GET60T
 ; check test is valid for NTRT
 S AA=$G(LXA(4,"I"))
 I AA="WK" G PL
 I AA="BB" G PL
 ;
 S LRTSTN=$G(LXA(.01,"I")),LRTSTN=$E(LRTSTN,1,40)
 ;
 S LRTC=$G(LXA(131,"I")) I LRTC'="" S LRTC=$$FMTE^XLFDT(LRTC,9)
 ; check test subscript is valid for NTRT
 S LRTE=0,LR1=0
PLE S LRTE=$O(^LAB(60,LRTST,1,LRTE)) I 'LRTE G PL
 S B=+LRTE_","_(+LRTST)
 K LRDTA,C,LRER D GETS^DIQ(60.01,B,"**","IE","C","LRER")
 I $G(LRER("DIERR"))'="" G PLE
 M LRDTA=C("60.01",B_",") K C
 I $G(LRDTA(30,"I"))'="" G PLE
 I LR1=0 W !,LRTSTN,?42,"Create Date: ",LRTC,?67,"Inactive: " S B=$G(LXA(132,"I")) W $S(B="":"N",1:B)
 S LR1=1
 ; specimen name if one
 S D=$G(LRDTA(.01,"E")) S:D'="" D=$E(D,1,30)
 ; create date
 S K=$G(LRDTA(35,"I")) I K'="" S K=$$FMTE^XLFDT(K,"7")
 ; inactive flag
 S C=$G(LRDTA(32,"I")) I C="" S C="N"
 ; exception flag
 S E=$G(LRDTA(34,"I")) I E="" S E="N"
 W !,?2,D,?35,K,?47,C,?57,E
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
 W !,?11,HD
 W !,?27,"Date Printed: "_$$FMTE^XLFDT(DT),?70,"Page ",PAGE,!
 S PAGE=PAGE+1
 ;
 W !,?2,"Specimen",?35,"Create DT",?47,"Inactive",?57,"Exception"
 W !,ULINE
 I PAGE>2 D  ;<
 . S B=$O(^LAB(60,LRTST,1,LRTE)) I 'B Q
 . W !,LRTSTN
 Q
 ;
PAUSE N DIR,DIRUT,X,Y
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="E" D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 Q
 ;
GET664 ; get file 66.4 info
 S LSITE=$$SITE^VASITE,LSITE=$P(LSITE,U,1)
 S LRNT=$O(^LAB(66.4,"B",LSITE,0))
 D GETS^DIQ(66.4,LRNT_",","**","IE","AR")
 M LRNTI=AR("66.4",LRNT_",") K AR
 Q
 ;
GET60T ; get top of file 60 test info
 S DA=LRTST,DIQ="LXB",DIQ(0)="IE",DIC=60,DR=".01;4;64.1;5;13;131;132;133" D EN^DIQ1
 K LXA M LXA=LXB(60,DA) K LXB
 Q
 ;
