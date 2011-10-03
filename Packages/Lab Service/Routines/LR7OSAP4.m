LR7OSAP4 ;slc/dcm - Silent AP API ;3/22/2007
 ;;5.2;LAB SERVICE;**365**;Sep 27, 1994;Build 9
 ;
EN(LRX,LRDFN,LRSS,LRI,GIOM)        ;Get Anatomic Path results from either TIU or Lab files
 ; LRX is the global where the output is placed. Calling package is responsible for cleaning this up
 ; LRDFN = Lab Patient ID
 ; LRSS = Lab Subscript
 ; LRI = Inverse Date/Time from ^LR(LRDFN,LRSS,LRIDT)
 Q:'LRDFN  Q:$G(LRSS)=""  Q:'LRI  Q:'$D(^LR(+LRDFN,LRSS,LRI))&(LRSS'="AU")
 N LRAA,FST,GCNT,B
 K ^TMP("LRC",$J)
 D:LRSS="CY" CY D:LRSS="SP" SPA D:LRSS="EM" EM
 S FST=0,GCNT=0,GIOM=$G(GIOM,96),B=$G(^LR(LRDFN,LRSS,LRI,0))
 D:LRSS="AU" AU
 I LRSS'="AU" D W^LR7OSAP
 M @LRX=^TMP("LRC",$J)
 Q
 ;
CY S LRSS="CY",LRAA(1)="CYTOPATHOLOGY",LRAA=+$O(^LRO(68,"B",LRAA(1),0)) S:'LRAA LRAA=$$FIND(LRSS)
 Q
 ;
SPA S LRSS="SP",LRAA(1)="SURGICAL PATHOLOGY",LRAA=+$O(^LRO(68,"B",LRAA(1),0)) S:'LRAA LRAA=$$FIND(LRSS)
 Q
 ;
EM S LRSS="EM",LRAA(1)="ELECTRON MICROSCOPY",LRAA=+$O(^LRO(68,"B","EM",0)) S:'LRAA LRAA=$$FIND(LRSS)
 Q
 ;
AU D EN^LR7OSAP2(LRDFN)
 Q
 ;
FIND(SS) ;Find a valid entry in 68
 ;SS=LRSS value to look for
 N I,Y
 S I=0,Y="" F  S I=$O(^LRO(68,I)) Q:I<1  I $P($G(^LRO(68,I,0)),"^",2)=SS S Y=I Q
 Q Y
