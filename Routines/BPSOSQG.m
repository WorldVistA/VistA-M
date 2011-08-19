BPSOSQG ;BHAM ISC/FCS/DRS/FLS - form transmission packets ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; PACKET
 ;   Calls BPSOSCA to get claims data (BPS array)
 ;   Calls BPSECA1 to create packet
 ;   Calls CHOP^BPSECMC2 to send packet to HL7 application
 ;
PACKET() ;EP - BPSOSQ2
 ; packetize one prescription (and possibly more prescriptions
 ; for the same patient, if they're ready now.)
 ; Called from BPSOSQ2,
 ;  which gave us RXILIST(IEN59) array of claims to packetize.
 ;
 N CLAIMIEN,ERROR,FIRST59
 ;
 ; Get first transaction from list
 S FIRST59=$O(RXILIST(0))
 ;
 ; If it's a reversal, we already have an ^BPSC(, which was
 ;   created by the call to BPSECA8, way back at the beginning.
 ; So, unlike claims, we need only the NCPDP formatting for it
 ;   by creating CLAIMIEN array and jumping to POINTM
 I $G(^BPST(FIRST59,4)) D  G POINTM
 . ; Mimic a few things that are set up in the code we're skipping
 . S CLAIMIEN=$P(^BPST(FIRST59,4),U)
 . S CLAIMIEN(CLAIMIEN)=""
 ;
 ; DMB - This code will only be executed if there is more than one
 ;  transaction in RXILIST.  This will not happen for the VA but leave
 ;  functionality in case we bundle claims later
 I $O(RXILIST($O(RXILIST("")))) D
 . D LOG2LIST^BPSOSL($T(+0)_"-Packetizing - we have more than one claim:")
 . N I,X,Y S (X,Y)=""
 . F I=1:1 S X=$O(RXILIST(X)) Q:'X  D
 . . S $P(Y,", ",I-1#4+1)=X
 . . I I#4=0 D LOG2LIST^BPSOSL(Y) S Y=""
 . I Y]"" D LOG2LIST^BPSOSL(Y)
 ;
 ; BPSOSCA calls BPSOSCB,BPSOSCC,BPSOSCD to set up BPS(*) and
 ;    then calls BPSOSCE to create claims in 9002313.02
 ; BPSOSCA expects RXILIST(*) to be defined and will return
 ;   ERROR - any error encountered
 ;   CLAIMIEN - last claim created
 ;   CLAIMIEN(CLAIMIEN) - the list of all claims created
 S ERROR=$$EN^BPSOSCA(.CLAIMIEN)
 I ERROR D LOG2LIST^BPSOSL($T(+0)_"-ERROR="_ERROR_" returned from BPSOSCA")
 I $G(CLAIMIEN)<1 Q $S(ERROR:ERROR,1:"300^No Claim IEN returned by BPSOSCA")
 ;
 ; POINTM will create the claims packet and put them in XTMP
POINTM ; Reversals are joining again here
 N VAMSG,IEN59,ERROR
 ;
 ; CLAIMIEN(*) = a list of CLAIMIENs that were generated from
 ;   all the prescriptions that might have been bundled together.
 ;   So we must loop through that list.
 ; Currently, VA does not bundle claims.  If it does so,
 ;   we may want to change error handling.
 S ERROR=0,CLAIMIEN=""
 F  S CLAIMIEN=$O(CLAIMIEN(CLAIMIEN)) Q:CLAIMIEN=""  D
 . S IEN59=$O(^BPST("AE",CLAIMIEN,""))
 . I IEN59="" S IEN59=$O(^BPST("AER",CLAIMIEN,""))
 . I IEN59="" S ERROR="500^Transaction IEN not determined for "_CLAIMIEN Q
 . D SETSTAT^BPSOSU(IEN59,50)
 . K VAMSG
 . D LOG2CLM^BPSOSL(CLAIMIEN,$T(+0)_"-Packet being built for Claim ID "_$P(^BPSC(CLAIMIEN,0),U))
 . D ASCII^BPSECA1(CLAIMIEN,.VAMSG)
 . I '$G(VAMSG("HLS",0)) S ERROR="501^Claim packet not built for "_$P($G(^BPSC(CLAIMIEN,0)),U,1) Q
 . D CHOP^BPSECMC2(.VAMSG,CLAIMIEN,IEN59)
 Q ERROR
