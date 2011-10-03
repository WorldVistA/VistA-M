BPSOSCB ;BHAM ISC/FCS/DRS/DLF - Prep for building BPS array ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;----------------------------------------------------------------------
 ; Called from BPSOSCA from BPSOSQG from BPSOSQ2
 ; Setup BPS() array which contains all pertinent data to create
 ;   claim Submission Records for the current Billing Item Record:
 ;
 ; Input:
 ;   RXILIST needs to be defined - List of Transactions
 ; Returns
 ;   BPS    Formatted array containing data required to create claim
 ;             submission records.  This array is shared by all BPSOSC*
 ;             routines and some of the BPSOSH routines as well.
 ;----------------------------------------------------------------------
 ;
 Q
BPS() ;
 N IEN59,IEN5902,INDEX,ENTRY,VAINFO
 ;
 ; Set up some basic variables from first transaction
 S IEN59=$O(RXILIST(""))
 I IEN59="" Q "320^BPS Transaction not found in RXILIST"
 ;
 S IEN5902=$P(^BPST(IEN59,9),U,1)
 I IEN5902="" Q "321^VA Insurer not determined"
 ;
 ; Set transaction multiple into VAINFO array and get top node of multiple
 D GETS^DIQ(9002313.59,IEN59_",","902*","I","VAINFO")
 ;
 ; Set up BPS array for Patient, Insurer, Site and NCPDP record format data
 D GETINFO^BPSOSCC(IEN59,IEN5902)
 ;
 ; Get medication and prescription data for each medication
 S IEN59=""
 F INDEX=1:1 S IEN59=$O(RXILIST(IEN59)) Q:'IEN59  D
 . S IEN5902=$P(^BPST(IEN59,9),U,1)
 . D MEDINFO^BPSOSCD(IEN59,IEN5902,INDEX)
 ;
 ; Set up BPS("RX",0)
 S BPS("RX",0)=INDEX-1
 I BPS("RX",0)=0 Q "322^No claims in RXILIST"
 ;
 ; If certification, get certification overrides
 S IEN59=$O(RXILIST("")),IEN5902=$P(^BPST(IEN59,9),U,1)
 S ENTRY=$$GET1^DIQ(9002313.59902,IEN5902_","_IEN59_",",902.23,"I")
 I ENTRY,$D(^BPS(9002313.31,ENTRY)) D SETBPS^BPSOSC2(ENTRY)
 ;
 ; Quit with no error
 Q 0
