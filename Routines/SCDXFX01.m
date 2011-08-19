SCDXFX01 ;ALB/JRP - AMBULATORY CARE FILE X-REFS & UTILS;30-APR-1996
 ;;5.3;Scheduling;**44,99**;AUG 13, 1993
 ;
AACXMIT(IFN,SET,OLDDATE) ;Logic for AACXMIT* cross references of
 ; TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73)
 ;
 ;Input  : IFN - Pointer to entry in file
 ;         SET - If 1, set cross reference
 ;               If 0, kill cross reference
 ;               If -1, check the current value of TRANSMISSION
 ;                 REQUIRED field (#.04), setting the cross reference
 ;                 if a value of 'YES' is found and killing the
 ;                 cross reference if a value of 'NO' is found
 ;                 (DEFAULT)
 ;         OLDDATE - Previous value of DATE/TIME OF EVENT field (#.06)
 ;                 - Only valid when KILLing the x-ref is due to the
 ;                   DATE/TIME OF EVENT field (#.06) changing
 ;Output : None
 ;
 ;Check input
 Q:('$G(IFN))
 Q:('$D(^SD(409.73,IFN)))
 S:($G(SET)="") SET=-1
 S OLDDATE=+$G(OLDDATE)
 ;Declare variables
 N ZERO,EVENT,EVNTDATE,XMIT
 ;Get zero node
 S ZERO=$G(^SD(409.73,IFN,0))
 ;Get value of TRANSMISSION REQUIRED field
 S XMIT=+$P(ZERO,"^",4)
 ;Set/kill logic based on value of TRANSMISSION REQUIRED
 S:(SET=-1) SET=$S(XMIT=1:1,1:0)
 ;Get event date/time
 S EVNTDATE=+$P(ZERO,"^",6)
 ;Use old event date/time if killing due to this value changing
 S:(('SET)&(OLDDATE)) EVNTDATE=OLDDATE
 ;No event date/time - don't set x-ref
 Q:('EVNTDATE)
 ;Setting of x-ref is screened so x-ref is only set on add, edit,
 ; delete, and retransmit events
 S EVENT=+$P(ZERO,"^",5)
 I (SET) Q:((EVENT>3)!(EVENT<0))  S ^SD(409.73,"AACXMIT",EVNTDATE,IFN)=""
 ;Kill x-ref
 K:('SET) ^SD(409.73,"AACXMIT",EVNTDATE,IFN)
 Q
 ;
AACNA(IFN,SET,OLDDATE) ;Logic for AACNA* cross references of TRANSMITTED
 ; OUTPATIENT ENCOUNTER file (#409.73)
 ;
 ;Input  : IFN - Pointer to entry in file
 ;         SET - If 1, set cross reference
 ;               If 0, kill cross reference (DEFAULT)
 ;         OLDDATE - Previous value of DATE/TIME OF XMIT TO NPCDB
 ;                   field (#11)
 ;                 - Only valid when KILLing the x-ref is due to the
 ;                   DATE/TIME OF XMIT TO NPCDB field (#11) changing
 ;Output : None
 ;
 ;Check input
 Q:('$G(IFN))
 Q:('$D(^SD(409.73,IFN)))
 S SET=+$G(SET)
 S OLDDATE=+$G(OLDDATE)
 ;Declare variables
 N NODE,XMITDATE
 ;Get node
 S NODE=$G(^SD(409.73,IFN,1))
 ;Get date/time of transmission
 S XMITDATE=+$P(NODE,"^",1)
 ;Use old date/time of transmission if this changed
 S:(('SET)&(OLDDATE)) XMITDATE=OLDDATE
 ;No transmission date/time - don't set x-ref
 Q:('XMITDATE)
 ;Set x-ref
 S:(SET) ^SD(409.73,"AACNOACK",XMITDATE,IFN)=""
 ;Kill x-ref
 K:('SET) ^SD(409.73,"AACNOACK",XMITDATE,IFN)
 Q
 ;
AUTO() ;Auto-numbering logic for TRANSMITTED OUTPATIENT ENCOUNTER file
 ;
 ;Input  : None
 ;Output : N - Next value to use for NUMBER field (#.01) of
 ;             TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73)
 ;Note   : Auto-numbering logic is based on the LAST XMIT OUTPAT
 ;         ENC NUMBER field (#701.01) of the SCHEDULING PARAMETER
 ;         file (#404.91)
 ;
 ;Declare variables
 N NEXT,SUCCESS
 ;Lock node to prevent simultaneous use
 L +^SD(404.91,1,"AMB"):1800 S SUCCESS=$S(($T):1,1:0)
 Q:('SUCCESS) 0
 ;Get last value used and increment by 1
 S NEXT=1+$G(^SD(404.91,1,"AMB"))
 ;Make sure value hasn't already been used
 I $D(^SD(409.73,"B",NEXT)) F NEXT=NEXT:1 Q:('$D(^SD(409.73,"B",NEXT)))
 ;Store new value
 S $P(^SD(404.91,1,"AMB"),"^",1)=NEXT
 ;Unlock node
 L -^SD(404.91,1,"AMB")
 ;Return value to use
 Q NEXT
