MBAALEXT ;OIT-PD/CBR - WAIT LIST API - EXTERNAL FUNCTIONS ;02/13/2015
 ;;1.0;Scheduling Calendar View;**1**;Aug 27, 2014;Build 85
 ;
PATDET(RETURN,DFN) ;RETURN PATIENT DETAILS MBAA RPC: MBAA EWL NEW
 Q:'+$G(DFN) 0
 N REC,ERT
 K RETURN
 D GETS^DIQ(2,DFN,".01;.351","IE","REC","ERT")
 S RETURN("NAME")=REC(2,DFN_",",.01,"I")_"^"_REC(2,DFN_",",.01,"E")
 S RETURN("DOD")=REC(2,DFN_",",.351,"I")_"^"_REC(2,DFN_",",.351,"E")
 Q 1
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;INSTFMST(STN) ;RETURNS INSTITUTION NAME FROM STATION NUMBER
 ; N INSTIEN
 ; S INSTIEN=$$FIND1^DIC(4,"","X",STN,"D")
 ; Q $$GET1^DIQ(4,INSTIEN,60)
 ; ;
 ;SELPAT() ;SELECT PATIENT
 ; N DIC,X,Y
 ; S DIC=2
 ; S DIC(0)="AEMQZ"
 ; D ^DIC
 ; Q $S($D(DTOUT):-1,$D(DUOUT):-1,(Y<0):-1,1:+Y)
 ; ;
