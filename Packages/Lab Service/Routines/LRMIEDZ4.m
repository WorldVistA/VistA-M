LRMIEDZ4 ;DALOI/FHS/RBN - CONTINUE MICROBIOLOGY EDIT ;11/18/11  16:04
 ;;5.2;LAB SERVICE;**350,461**;Sep 27, 1994;Build 15
 ;
 ; Formerly a part of LRMIEDZ2
 ;
EC ;
 ;
 K LRTX
 ;
 S LRAN=$P($P(LRBG0,U,6)," ",3),LRLLOC=$P(LRBG0,U,8),LRODT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,4),LRSN=$P(^(0),U,5)
 I $D(^LRO(69,+LRODT,1,+LRSN,0)) D
 . S DIC="^LRO(69,"_LRODT_",1,",DA=LRSN,DR=6
 . I DA>0 D EN^DIQ
 ;
 I $D(DTOUT)!($D(DUOUT)) S LREND=1 Q
 ;
 K LRNPTP
 N LRMSTR,LRMFLG
 ;
 S (LRI,N,LRMFLG)=0
 F  S LRI=+$O(^LRO(68,LRAA,1,LRAD,1,+LRAN,4,LRI)) Q:LRI<.5  D
 . I $P(^LRO(68,LRAA,1,LRAD,1,+LRAN,4,LRI,0),U,2)>49 Q
 . ;notify user if a merged / cancelled test was preselected
 . S LRMSTR=^LRO(68,LRAA,1,LRAD,1,+LRAN,4,LRI,0)
 . I $P(LRMSTR,U,6)]"" D
 . . W !,$P(^LAB(60,+LRMSTR,0),U),"  ",$P(LRMSTR,U,6)
 . . S LRMFLG=1
 . I LRPTP>0,+LRMSTR=LRPTP D
 . . I $P(LRMSTR,U,6)="*Merged" D
 . . . W !,"    This test was merged to another accession"
 . . . W !,"    and may not be resulted on this accession.",!
 . . I $P(LRMSTR,U,6)="*Not Performed" D
 . . . W !,"    This test may not be resulted since it is marked as ""Not Performed"".",!
 . ;do not allow resulting of test which was merged / cancelled
 . I $P(LRMSTR,U,6)="*Merged"!($P(LRMSTR,U,6)="*Not Performed") Q
 . S N=N+1,LRTS(N)=+^LRO(68,LRAA,1,LRAD,1,+LRAN,4,LRI,0)
 . S LRTX(N)=$S($P(^LAB(60,LRTS(N),0),U,14):^LAB(62.07,$P(^(0),U,14),.1),1:"")
 . I LRTS(N)=LRPTP S LRNPTP=N Q
 ;
 I LRMFLG W !
 I '$D(LRNPTP),LRPTP>0 W !,"No eligible tests match with the test you preselected.",!
 I $D(LRNPTP) S LRI=LRNPTP
 ;
 I '$D(LRNPTP),N>0 F J=1:1:N D
 . W !,?3,J,?8,$P(^LAB(60,LRTS(J),0),U)
 . S Y=$P(^LRO(68,LRAA,1,LRAD,1,+LRAN,4,LRTS(J),0),U,5)
 . I Y>0 W " Completed ",$$FMTE^XLFDT(Y,"1M")
 W !
 ;
 Q
