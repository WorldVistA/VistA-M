LA7SBCR3 ;DALISC/JMC - Shipping Barcode Reader Utility ; 7 Feb 1997
 ;;5.2;LAB MESSAGING;**27**;Sep 27, 1994
 Q
 ;
TEST(LA7,LA7PROM,LA7BAR) ; Setup test/specimen info.
 ; Input:
 ;                  LA7=array to return values
 ;              LA7PROM=prompt to display to user
 ;               LA7BAR=0/1 using barcode reader
 ;
 ; Returns array LA7()
 ;
 ;  If successful ERROR=0
 ;                  NLT=National Laboratory Test code
 ;             SPECIMEN=HL7 specimen code
 ;                  UID=Sender's Unique Identifier
 ;
 ;   unsuccessful ERROR=>0
 ;
 N LA7X,X,Y
 ; Initialize array.
 F Y="ERROR","NLT","SPECIMEN","UID" S LA7(Y)=""
 S LA7PROM=$G(LA7PROM,"Test")
 I LA7BAR D
 . S Y=$$RD^LA7SBCR(LA7PROM)
 . I Y<1 S LA7("ERROR")="1^User timeout/abort" Q
 . S Y=$$UPCASE^LRAFUNC(Y)
 . S LA7=$P(Y,"STX^",2),LA7=$P(LA7,"^ETX",1)
 . I LA7="" S LA7("ERROR")="2^Incorrect barcode format" Q
 . S $P(LA7("UID"),"^",3)=$P(LA7,"^",1)
 . S $P(LA7("NLT"),"^",3)=$P(LA7,"^",2)
 . S $P(LA7("SPECIMEN"),"^",3)=$P(LA7,"^",3)
 . S LA7("ERROR")=0
 Q
