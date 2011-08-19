BPSOSCA ;BHAM ISC/FCS/DRS - Create BPS Claims entries ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ; Create BPS Claims entries for RXILIST(*) claims.
 ; Called from PACKET^BPSOSQG
 ;
 ; Input:
 ;      RXILIST(IEN59) - Array of pointers to 9002313.59
 ;         A list of prescriptions for the same visit/patient/etc.
 ;         to be bundled into one or more 9002313.02 claims
 ;
 ; Outputs:
 ;      CLAIMIEN(CLAIMIEN)="", pointers to the ^BPSC(CLAIMIEN,
 ;                             claim records created.
 ;      ERROR
 ;
 ; BPSOSCA calls:
 ;   BPSOSCB to build BPS(*) array
 ;      (and BPSOSCB calls BPSOSCC and BPSOSCD)
 ;   BPSOSCE to build the ^BPSC( entry
 ;
EN(CLAIMIEN) ;EP - from BPSOSQG
 I $D(RXILIST)<10  D  Q "306^No RXILIST defined"
 . N RETVAL S RETVAL=$$IMPOSS^BPSOSUE("P","TI","Bad RXILIST",,,$T(+0))
 . D LOG2LIST^BPSOSL($T(+0)_"-No RXILIST passed into BPSOSCA")
 ;
 ; Manage local variables
 N BPS,START,END,TOTAL,NCLAIMS,CLAIMN,ERROR
 S ERROR=$$BPS^BPSOSCB()
 I ERROR D LOG2LIST^BPSOSL($T(+0)_"-$$BPS^BPSOSCB(.BPS) returned "_ERROR)
 I $G(BPS("RX",0))="" S:'ERROR ERROR="301^BPS(""RX"" not created" Q ERROR
 I $G(BPS("NCPDP","# Meds/Claim"))="" Q "302^Number of Meds not returned"
 ;
 ; Calculate number of claim records to be generated for Billing Item
 S NCLAIMS=((BPS("RX",0)-1)\BPS("NCPDP","# Meds/Claim"))+1
 I NCLAIMS=0 Q "303^Number of claims is zero"
 ;
 ;Generate claim submission records
 F CLAIMN=1:1:NCLAIMS D  Q:$G(ERROR)
 . S START=((CLAIMN-1)*BPS("NCPDP","# Meds/Claim"))+1
 . S END=START+BPS("NCPDP","# Meds/Claim")-1
 . S:END>BPS("RX",0) END=BPS("RX",0)
 . S TOTAL=END-START+1
 . S ERROR=$$NEWCLAIM^BPSOSCE(START,END,TOTAL)
 . I ERROR]"" Q
 . S CLAIMIEN=BPS(9002313.02)
 . S CLAIMIEN(CLAIMIEN)=""
 . ; Mark each of the .59s with the claim number and position within
 . F I=START:1:END D
 .. ;
 .. ; IEN59 handling 06/23/2000. The ELSE should never happen again.
 .. ; and the $G() can probably be gotten rid of, safely.
 .. N IEN59 S IEN59=$G(BPS("RX",I,"IEN59"))
 .. I IEN59 D
 ... N DIE,DA,DR S DIE=9002313.59
 ... ;
 ... ; Field #3-CLAIM, #14-POSITION
 ... ; POSITION:  Not the relative position within the packet,
 ... ; but the index in BPS("RX",n,....  This is the position in which
 ... ; it will be stored in ^BPSC(ien,400,POSITION
 ... ; and likewise for 9002313.03 when the response comes in.
 ... S DA=IEN59,DR=3_"////"_CLAIMIEN_";14////"_I N I D ^DIE
 .. E  D
 ... S $P(^BPST(BPS("RX",I,"RX IEN"),0),"^",4)=CLAIMIEN
 ... S ^BPST("AE",CLAIMIEN,BPS("RX",I,"RX IEN"))=""
 ... S $P(^BPST(BPS("RX",I,"RX IEN"),0),"^",9)=I
 Q ERROR
