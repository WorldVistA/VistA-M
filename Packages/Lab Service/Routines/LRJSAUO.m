LRJSAUO ;ALB/JLC - CALL CPRS IF CERTAIN FIELDS EDITED;10/21/2012 12:32:47
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
 ; Reference to ^ORUQO supported by IA 5756 
 ;
 Q
EN ;search fiile 60 audit for entries to use for quick order search
 N A1,A2,LRAIEN,LRADT,LRF,A,LRT
 S A1=$G(^LAB(69.9,1,64.9103)),LRAIEN=$P(A1,"^"),LRADT=$P(A1,"^",2)
 L +^LRJSAUO:$G(DILOCKTM,5) E  Q
 I LRAIEN="" S LRAIEN=0
 I '$D(^DIA(60,LRAIEN)) S LRAIEN=0
 I $D(^DIA(60,LRAIEN,0)),$P(^(0),"^",2)'=LRADT S LRAIEN=0
 F  S LRAIEN=$O(^DIA(60,LRAIEN)) Q:'LRAIEN  D  I $$REQ2STOP() S ZSTOP=1 Q
 . S A=^DIA(60,LRAIEN,0),LRT=+A,LRF=$P(A,"^",3)
 . I LRF'=.01,LRF'=3,LRF'=17,LRF'=18,LRF'="300,.01" Q
 . D CHECKLR^ORUQO(LRT,$P($G(^LAB(60,LRT,0)),"^"))
 . S ^LAB(69.9,1,64.9103)=LRAIEN_"^"_$P(A,"^",2)
 L -^LRJSAUO
 Q
 ;
REQ2STOP() ;
 ; Check for task stop request
 ; Returns 1 if stop request made.
 N STATUS,X
 S STATUS=0
 I '$D(ZTQUEUED) Q 0
 S X=$$S^%ZTLOAD()
 I X D  ;
 . S (STATUS,ZTSTOP)=1
 . S X=$$S^%ZTLOAD("Received shutdown request")
 ;
 I $Q Q STATUS
 Q
