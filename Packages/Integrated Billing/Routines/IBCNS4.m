IBCNS4 ;ALB/JWS - Trigger Logic for fields 112, 113, 114 of file 399 ;03-SEP-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;Trigger logic to obtain the authorization number / referral number from the 278 transaction file, 356.22
 ; 399 (Bill/Claims file, fields 112, 113, 114 trigger fields 163 & 253, 230 & 254, 231 & 255 respectively
AUTH(BIEN,INS) ;
 I $G(INS)="" Q
 N AUTH,PAT,LOC,DATE,HCSRIEN,RCAT,DATE1
 S AUTH=""
 S PAT=$P($G(^DGCR(399,BIEN,0)),"^",2) I PAT="" Q ""
 S LOC=$S($$INPAT^IBCEF(BIEN)=1:"I",1:"O")
 S DATE=$P($G(^DGCR(399,BIEN,0)),"^",3) I DATE="" Q ""
 S (DATE,DATE1)=$P(DATE,"."),DATE=DATE-1
 F  S DATE=$O(^IBT(356.22,"E",PAT,LOC,INS,DATE)) Q:DATE=""  Q:$P(DATE,".")'=DATE1  D  I AUTH'="" Q
 . S HCSRIEN="" F  S HCSRIEN=$O(^IBT(356.22,"E",PAT,LOC,INS,DATE,HCSRIEN)) Q:HCSRIEN=""  D  I AUTH'="" Q
 .. S AUTH=$P($G(^IBT(356.22,HCSRIEN,103)),"^",2),RCAT=$P($G(^(2)),"^")
 .. I RCAT=4 S AUTH=""
 Q AUTH
 ;
REF(BIEN,INS) ;
 N REF,PAT,LOC,DATE,HCSRIEN,RCAT,DATE1
 S REF=""
 S PAT=$P($G(^DGCR(399,BIEN,0)),"^",2) I PAT="" Q ""
 S LOC=$S($$INPAT^IBCEF(BIEN)=1:"I",1:"O")
 S DATE=$P($G(^DGCR(399,BIEN,0)),"^",3) I DATE="" Q ""
 S (DATE,DATE1)=$P(DATE,"."),DATE=DATE-1
 F  S DATE=$O(^IBT(356.22,"E",PAT,LOC,INS,DATE)) Q:DATE=""  Q:$P(DATE,".")'=DATE1  D  I REF'="" Q
 . S HCSRIEN="" F  S HCSRIEN=$O(^IBT(356.22,"E",PAT,LOC,INS,DATE,HCSRIEN)) Q:HCSRIEN=""  D  I REF'="" Q
 .. S REF=$P($G(^IBT(356.22,HCSRIEN,103)),"^",2),RCAT=$P($G(^(2)),"^")
 .. I RCAT'=4 S REF=""
 Q REF
