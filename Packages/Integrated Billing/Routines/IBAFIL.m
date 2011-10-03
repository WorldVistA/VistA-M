IBAFIL ;ALB/AAS - INTEGRATED BILLING, PASS OFF TO BE FILED ; 25-FEB-91
 ;;Version 2.0 ; INTEGRATED BILLING ;**40**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% I '$G(DFN) S Y="-1^IB002" Q  ; Invalid patient pointer
 I '$G(IBSEQNO) S Y="-1^IB017" Q  ; Sequence number is missing
 I '$G(IBDUZ) S Y="-1^IB007" Q  ; Invalid user ID
 I '$D(^IBE(350.9,1,0)) D ^IBR Q  ; no site parameters - file in foreground
 ;
 I '$P(^IBE(350.9,1,0),"^",3) N Y D ^IBR Q  ; file in foreground
 ;Patch 40 looks for a space to set "APOST" x-ref if finds then lock.
 F IBNOW=IBNOW:.000001 I '$D(^IB("APOST",IBNOW)) L +^IB("APOST",IBNOW):0 Q:$T
 S ^IB("APOST",IBNOW,DFN,IBSEQNO,IBDUZ)=IBNOS
 L -^IB("APOST",IBNOW)
 ;
 ;  - if filer not started, start it.
 I $P(^IBE(350.9,1,0),"^",4)="",'$P(^(0),"^",10) D ZTSK^IBEF Q
 ;
 ;check to see if not running, wait 2 seconds, test again
 ;before restarting (time to deque)
 D EN^IBECK I IBFLAG[3 H 2 D EN^IBECK I IBFLAG[3 D S1^IBEFUTL
 K IBFLAG
 Q
 ;
REPASS ;  -called from IB INCOMPLETE print template
 D NOW^%DTC S IBNOW=%
 S DFN=$P(^IB(D0,0),"^",2),IBATYP=$P(^(0),"^",3),IBSEQNO=$P(^IBE(350.1,IBATYP,0),"^",5),IBDUZ=DUZ,IBNOS=D0
 D IBAFIL
 K IBN,IBNOW,DFN,IBDUZ,IBSEQNO,IBATYP
 Q
