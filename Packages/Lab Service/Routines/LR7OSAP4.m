LR7OSAP4 ;DALOI/staff - Silent AP API ;11/05/09  10:57
 ;;5.2;LAB SERVICE;**365,350**;Sep 27, 1994;Build 230
 ;
EN(LRX,LRDFN,LRSS,LRI,LRGIOM)        ;Get Anatomic Path results from either TIU or Lab files
 ; LRX is the global where the output is placed. Calling package is responsible for cleaning this up
 ; LRDFN = Lab Patient ID
 ; LRSS = Lab Subscript
 ; LRI = Inverse Date/Time from ^LR(LRDFN,LRSS,LRIDT)
 Q:'LRDFN  Q:$G(LRSS)=""  Q:'LRI  Q:'$D(^LR(+LRDFN,LRSS,LRI))&(LRSS'="AU")
 N LRAA,FST,GCNT,B
 ;
 K ^TMP("LRC",$J)
 ;
 D:LRSS="CY" CY D:LRSS="SP" SPA D:LRSS="EM" EM
 ;
 S FST=0,GCNT=0,B=$G(^LR(LRDFN,LRSS,LRI,0))
 ;
 S GIOM=$G(LRGIOM)
 I GIOM="" D
 . S GIOM=$$GET^XPAR("USR^DIV^PKG","LR AP GUI REPORT RIGHT MARGIN",1,"Q")
 . I GIOM="" S GIOM=96
 ;
 ; Display "Printed at:" notice
 I $$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")>1 D PFAC^LR7OSMZU
 ;
 I LRSS="AU" D AU
 I LRSS'="AU" D
 . D W^LR7OSAP
 ;
 M @LRX=^TMP("LRC",$J)
 Q
 ;
 ;
CY ;
 S LRSS="CY",LRAA(1)="CYTOPATHOLOGY",LRAA=+$O(^LRO(68,"B",LRAA(1),0)) S:'LRAA LRAA=$$FIND(LRSS)
 Q
 ;
 ;
SPA ;
 S LRSS="SP",LRAA(1)="SURGICAL PATHOLOGY",LRAA=+$O(^LRO(68,"B",LRAA(1),0)) S:'LRAA LRAA=$$FIND(LRSS)
 Q
 ;
 ;
EM ;
 S LRSS="EM",LRAA(1)="ELECTRON MICROSCOPY",LRAA=+$O(^LRO(68,"B","EM",0)) S:'LRAA LRAA=$$FIND(LRSS)
 Q
 ;
 ;
AU ;
 D EN^LR7OSAP2(LRDFN)
 Q
 ;
 ;
FIND(SS) ;Find a valid entry in 68
 ; SS=LRSS value to look for
 N I,Y
 S I=0,Y="" F  S I=$O(^LRO(68,I)) Q:I<1  I $P($G(^LRO(68,I,0)),"^",2)=SS S Y=I Q
 Q Y
