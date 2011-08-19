LRBLSTR ;AVAMC/REG - BB SUPERVISOR ;2/18/93  09:51 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S ZTRTN="QUE^LRBLSTR" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU S (LRT,LRP,LRB)=0
 F LRDFN=0:0 S LRDFN=$O(^LR(LRDFN)) Q:'LRDFN  S LRP=LRP+1 S:$D(^LR(LRDFN,"BB")) LRB=LRB+1 F LRS=1,1.5,1.6,1.7,2,2.1,3,"BB" I $D(^LR(LRDFN,LRS)) S LRT=LRT+$L(^(LRS,0)) D C
 W !,"# of bytes: ",LRT,!,"# of patients: ",LRP,!,"Average # of bytes per patient: " W:LRP LRT\LRP W !,"# of patients with Blood Bank data: ",LRB,!,"Average # of bytes per Blood Bank patient: " W:LRB LRT\LRB Q
C F A=0:0 S A=$O(^LR(LRDFN,LRS,A)) Q:'A  S LRT=LRT+$L(^(A,0))
 Q
H S LRQ=LRQ+1,X="T",%DT="" D ^%DT,D^LRU W @IOF,Y," BLOOD BANK BYTE COUNT",?(IOM-10),"Pg: ",LRQ,!,LRQ(1),!,LR("%") Q
END D V^LRU Q
