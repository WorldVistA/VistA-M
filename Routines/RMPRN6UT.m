RMPRN6UT ;HINES-CIOFO/HNC - DISPLAY HEADER GROUPS NPPD;2-14-98
 ;;3.0;PROSTHETICS;**32,36,39,44,48,50,57,84,103,144**;Feb 09, 1996;Build 17
 ;
 ; ODJ - patch 50 - 7/28/00 - amend repair selection so that we don't
 ;                            need to alter this routine for NPPD line
 ;                            changes made in RMPRN62
 ; AAC - PATCH 103 - 01/17/05 - NPPD CATEGORIES/LINES - NEW and REPAIR
 ;
 ;;
DIS W !,?5,"1.   WHEELCHAIRS AND ACCESSORIES"
 W !,?5,"2.   ARTIFICIAL LEGS"
 W !,?5,"3.   ARTIFICIAL ARMS AND TERMINAL DEVICES"
 W !,?5,"4.   ORTHOSIS/ORTHOTICS"
 W !,?5,"5.   SHOES/ORTHOTICS"
 W !,?5,"6.   SENSORI-NEURO AIDS"
 W !,?5,"7.   RESTORATIONS"
 W !,?5,"8.   OXYGEN AND RESPIRATORY"
 W !,?5,"9.   MEDICAL EQUIPMENT"
 W !,?5,"10.  ALL OTHER SUPPLIES AND EQUIPMENT"
 W !,?5,"11.  HOME DIALYSIS PROGRAM"
 W !,?5,"12.  ADAPTIVE EQUIPMENT"
 W !,?5,"13.  HISA"
 W !,?5,"14.  SURGICAL IMPLANTS"
 W !,?5,"15.  MISC"
 W !,?5,"16.  REPAIR"
 W !,?5,"17.  BIOLOGICAL IMPLANTS"
ASK ;
 K DIR,DTOUT,DIRUT
 S RMPRCDE=""
 S DIR(0)="N^1:17:0"
 S DIR("A")="Select NPPD Group "
 D ^DIR
 G:$D(DIRUT)!($D(DTOUT)) EXIT
 S BR=0,BRC=0 K BRA W @IOF
 I Y=1 S SELY=10
 I Y=2 S SELY=20
 I Y=3 S SELY=30
 I Y=4 S SELY=40
 I Y=5 S SELY=50
 I Y=6 S SELY=60
 I Y=7 S SELY=70
 I Y=8 S SELY=80
 I Y=9 S SELY=90
 I Y=10 S SELY=91
 I Y=11 S SELY=92
 I Y=12 S SELY=93
 I Y=13 S SELY=94
 I Y=14 S SELY=96
 I Y=15 S SELY=99
 I Y=16 S SELY=100
 I Y=17 S SELY=97
 F  S BR=$O(^TMP($J,"RMPRCODE",BR)) Q:BR=""  D
 .I $E(BR,1,2)=SELY S BRC=BRC+1 W !?5,BRC_".",?10,BR,?18,^(BR) S BRA(BRC,BR)=""
 .Q
 I SELY=100 D
 . D RSEL
 . Q
 E  D
 . D NSEL
 . Q
 G:$D(DIRUT)!($D(DTOUT)) EXIT
 Q
RSEL ;repair selection
 N CNT,Y,OFFS,TXT,I
 S CNT=$P(^TMP($J,"RMPRCODE"),U,2) ; num of NPPD repair lines
 S OFFS=CNT-(CNT\2)-1
 F I=0:1:OFFS D
 . S TXT=$P($T(REP+I^RMPRN62),";;",2)
 . W !,$J(I+1,2)_".",?5,$P(TXT,";",1),?14,$P(TXT,";",2)
 . S TXT=$P($T(REP+I+OFFS+1^RMPRN62),";;",2)
 . Q:$E(TXT)'="R"
 . W ?35,$J(I+2+OFFS,2)_".",?40,$P(TXT,";",1),?51,$P(TXT,";",2)
 . Q
 F I=OFFS:1:17 W !
 S DIR(0)="N^1:"_CNT_":0"
 S DIR("A")="Select NPPD Line "
 D ^DIR
 Q:$D(DIRUT)!($D(DTOUT))
 S TXT=$P($T(REP+Y-1^RMPRN62),";;",2)
 S RMPRCDE=$P(TXT,";",1)
 Q
NSEL ;new select
 I BR'="" W "QUIT" Q
 W !
 S DIR(0)="N^1:"_BRC_":0"
 S DIR("A")="Select NPPD Line "
 D ^DIR
 Q:$D(DIRUT)!($D(DTOUT))
 S RMPRCDE=$O(BRA(Y,RMPRCDE))
 Q
EXIT ;exit on ^ or timeout
 K ^TMP($J)
 Q
 ;END
