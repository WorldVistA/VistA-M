LRACK ;SLC/DCM/MILW/JMC - CHECK CUMULATIVE DEVICE STATUS ; 9/30/87  15:11 ;
 ;;5.2;LAB SERVICE;**201**;Sep 27, 1994
 ;
LRIG K LRFG,LRFG1,LRFG2
 S LRFRSEP=$P($G(^LAB(64.5,1,6)),U,2) ; Set flag if printing separate file rooms.
 S LRIG=0
 F  S LRIG=$O(^LAB(64.5,1,3,LRIG)) Q:LRIG<1  D  Q:$D(LRFG)
 . I LRFRSEP,$P($G(^LAB(64.5,1,3,LRIG,.1)),U,3) Q  ; Printing file room on separate schedule and this is a file room report.
 . S Z=^LAB(64.5,1,3,LRIG,0)
 . I '$L($P(Z,U,8)),$L($P(Z,U,7)) S LRFG=1,LRDT=LRLDT Q
 . I '$L($P(Z,U,8)),'$L($P(Z,U,7)) S LRFG1=1
 . I $L($P(Z,U,8)),$L($P(Z,U,7)) S LRFG2=1
 . I $D(LRFG1),$D(LRFG2) S LRFG=1,LRDT=LRLDT
 I '$D(LRFG) D
 . S LRIG=0
 . F  S LRIG=$O(^LAB(64.5,1,3,LRIG)) Q:LRIG<1  D
 . . I LRFRSEP,$P($G(^LAB(64.5,1,3,LRIG,.1)),U,3) Q  ; Printing file room on separate schedule and this is a file room report.
 . . S $P(^LAB(64.5,1,3,LRIG,0),U,4,8)=""
 K LRFG,LRFG1,LRFG2,LRIG,Z
 Q
 ;
EN ;
STA ;from LRACM
 S Y=$P(^LAB(64.5,1,0),U,3) S Y=$$Y2K^LRX(Y) S LRRDT=Y
 S Z=$G(^LAB(64.5,1,6))
 S Y=$P(Z,U,1) I Y S Y=$$Y2K^LRX(Y) S LRFRDT=Y
 S LRFRSEP=$S($P(Z,U,2):"YES",1:"NO")
 S L=0,DIC="^LAB(64.5,1,3,",FLDS="1;L15,15;L20,17;L25,18;L7,25,26,2,3"
 S DIOEND="W !!,?10,""REPORT DATE: ""_LRRDT"
 I $D(LRFRDT) S DIOEND=DIOEND_",!,""FILE ROOM REPORT DATE: ""_LRFRDT"
 S DIOEND=DIOEND_",!,""   SEPARATE FILE ROOM: ""_LRFRSEP"
 S BY=".01;S1",FR="",TO="",DHD="CUMULATIVE DEVICE STATUS"
 D EN1^DIP,^%ZISC
 K LRFRDT,LRFRSEP,LRRDT,L,DIC,DHD,DIOEND,FLDS,BY,FR,TO,Y
 Q
