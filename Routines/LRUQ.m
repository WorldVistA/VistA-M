LRUQ ;AVAMC/REG - CHECK FOR BAD POINTERS TO LAB FILE ;2/18/93  13:13
 ;;5.2;LAB SERVICE;**242**;Sep 27, 1994
 D END W !!,"Check parent file for bad pointers to lab file."
 S X="?" D FILE^LRDPA G:Y<1 END S LRF=+Y,LRN=$P(Y,U,2),LR=^DIC(LRF,0,"GL")
 D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU,H S LR("F")=1
 F DFN=0:0 S DFN=$O(@(LR_DFN_")")) Q:'DFN!(LR("Q"))  D
 .S LRDFN=$$LRDFN^LR7OR1(DFN) Q:LRDFN=""  D LR
 D END^LRUTL,END Q
LR S X=$S($D(^LR(LRDFN,0)):^(0),1:"") I X="" D:$Y>(IOSL-6) H Q:LR("Q")  W !,DFN,?15,LRDFN," no entry in lab data file" Q
 S LR(2)=$P(X,"^",2),LR(3)=$P(X,"^",3) I DFN'=LR(3)!(LR(2)'=LRF) D:$Y>(IOSL-6) H Q:LR("Q")  W !,DFN,?15,LRDFN,?30,LR(3),?45,LR(2)
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q
 D F^LRU W !,"Bad lab pointers from ",LRN," file (global ",LR," )"
 W !,"Parent DFN",?15,"Parent LRDFN",?30,"Lab DFN",?45,"Lab pointer to parent file",!,LR("%") Q
 ;
END D V^LRU Q
