FBAARMRA ;AISC/DMK-RETRANSMIT MRA's FOR A DATE ;25OCT89
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
ASK W !! S %DT("A")="Re-transmit MRA's for which date: ",%DT="AEXP",%DT(0)=-DT D ^%DT K %DT(0),%DT("A") G END:X="^"!(X=""),ASK:Y<0 S FBAATD=Y
 I '$D(^FBAA(161.25,"AD",FBAATD)),'$D(^FBAA(161.26,"AD",FBAATD)),'$D(^FBAA(161.96,"AD",FBAATD)) W !!,*7,"No MRA's were transmitted on that date!" G ASK
 ;
 D VEND:$D(^FBAA(161.25,"AD",FBAATD)),VET:$D(^FBAA(161.26,"AD",FBAATD))
 ;
 D:$D(^FBAA(161.96,"AD",FBAATD)) IA(FBAATD) ; prepare IPAC MRAs for retransmission (FB*3.5*123)
 ;
 D RTRAN^FBAAV0
END K D0,FBAATD,OCTD,J,K,XCNP,VAT Q
 ;
VEND F J="O","P" F K=0:0 S K=$O(^FBAA(161.25,"AD",FBAATD,J,K)) Q:K'>0  I $D(^FBAA(161.25,K)) S $P(^(K,0),"^",5)="",^FBAA(161.25,"AE",J,K)="" K ^FBAA(161.25,"AD",FBAATD,J,K)
 Q
VET W !!,?20,"Re-Transmitting",! F K=0:0 S K=$O(^FBAA(161.26,"AD",FBAATD,K)) Q:K'>0  I $D(^FBAA(161.26,K)) S $P(^(K,0),"^",5)="",$P(^(0),"^",2)="P",^FBAA(161.26,"AC","P",K)="" K ^FBAA(161.26,"AD",FBAATD,K),^FBAA(161.26,"AC","T",K)
 Q
 ;
IA(XMITDT)    ; Prepare IPAC Agreement MRAs for re-transmission
 ; Input:       XMITDT  - Internal date to re-transmit IPAC Agreement MRAs for
 ; Output:      IPAC Agreement MRAs for the selected date are prepared for re-transmission
 ; Called From: ASK
 N DIE,DA,DR,DTOUT,MRAACT,MRAIEN,K,TACT,VAID,VAIEN
 ;
 ; Loop through every transmitted Patient MRA record for the specified date and
 ; remove the transmitted date
 S K=0
 F  D  Q:K'>0
 . S K=$O(^FBAA(161.96,"AD",XMITDT,K))
 . Q:'K
 . ;
 . ; IPAC vendor agreement IEN in file 161.95 for this transmitted MRA
 . S VAIEN=$P($G(^FBAA(161.96,K,0)),U,2),MRAIEN=""
 . S VAID=$P($G(^FBAA(161.96,K,0)),U,3)
 . ;
 . ; This must be an Add or a change MRA record for an Agreement that was
 . ; later deleted - Skip it
 . I VAIEN'="",'$D(^FBAA(161.95,VAIEN)) Q
 . I VAIEN S MRAIEN=$$PENDMRA^FBAAIAQ(VAID,.MRAACT)
 . ;
 . ; if there is an existing Pending MRA, then we'll use it and get out
 . I MRAIEN>0 D  Q
 . . S TACT=$P($G(^FBAA(161.96,K,0)),U,4)       ; Action value of transmitted MRA
 . . I TACT="A",MRAACT="C" D                    ; Change pending action to add action
 . . . S DIE=161.96,DA=MRAIEN,DR="3////A"
 . . . D ^DIE
 . ;
 . ; Otherwise, change the status of this MRA back to Pending and remove the Date Transmitted field
 . I $D(^FBAA(161.96,K)) D
 . . S DIE=161.96,DA=K
 . . S DR="4////P"                              ; Set the status back to Pending
 . . S DR=DR_";5////@"                          ; Remove the transmitted date from the record
 . . D ^DIE
 Q
 ;
