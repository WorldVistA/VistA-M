RMPRPIU0 ;HINES OIFO/RVD-UTILITY ROUTINE ;9/24/02  10:52
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 ;
 ;DBIA #799   - Fileman read of file #420.5
 ;DBIA #800   - Fileman read of file #440.
 ;DBIA #801   - Fileman read of file #441.
 ;DBIA #10035 - Fileman read of file #2.
 ;DBIA #10090 - Fileman read of file #4.
 ;DBIA #10060 - Fileman read of file #200.
 Q
 ;
 ; Return Station Name
GETSTN(RMPRIEN) ;input IEN of file #4
 N RMPRO
 S RMPRO=$$GET1^DIQ(4,RMPRIEN,.01)
 Q RMPRO
 ;
 ; Return Vendor Name
GETVEN(RMPRIEN) ;input IEN of file #440
 N RMPRO
 S RMPRO=$$GET1^DIQ(440,RMPRIEN,.01)
 Q RMPRO
 ;
 ; Return Unit of Issue
GETUNI(RMPRIEN) ;input IEN of file #420.5
 N RMPRO
 S RMPRO=$$GET1^DIQ(420.5,RMPRIEN,.01)
 Q RMPRO
 ; Return Item Master Short Description.
GETITM(RMPRIEN) ;input IEN of file #441
 N RMPRO
 S RMPRO=$$GET1^DIQ(441,RMPRIEN,.05)
 Q RMPRO
 ; Return USER Name
GETUSR(RMPRIEN) ;input IEN of file #200
 N RMPRO
 S RMPRO=$$GET1^DIQ(200,RMPRIEN,.01)
 Q RMPRO
 ; Return Patient Name
GETPAT(RMPRIEN) ;input IEN of file #2
 N RMPRO
 S RMPRO=$$GET1^DIQ(2,RMPRIEN,.01)
 Q RMPRO
