PRCAAPI ;ALB-SBW - API for ASCD Project ;26/Mar/2007
 ;;4.5;Accounts Receivable;**250**;Mar 20, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
GETDATA(BILL) ;Get AR Data
 ;Input:
 ;  Bill Number
 ;Output:
 ; 
 ;  Original Amount (430;3) ^  Date Account Activated (430;60) ^ 
 ;    Total Paid Principle (430;77) ^ Date Entered (433;19)
 N OUT,BXREF,BILLIEN,IENS,PAYDATE,BILLOUT
 S OUT=""
 Q:$G(BILL)="" OUT
 ;Determine which cross reference to use.
 ;   "B" xref contains Site-Bill Number
 ;   "D" XREF contains Bill Number without the Station Number.
 S BXREF=$S(BILL["-":"B",1:"D")
 S BILLIEN=$O(^PRCA(430,BXREF,BILL,0))
 Q:BILLIEN'>0 OUT
 ;
 S IENS=BILLIEN_","
 ;Get file 430 values
 D GETS^DIQ(430,IENS,"3;60;77","I","BILLOUT")
 ;Get file 433 values
 S PAYDATE=$$DFP^RCXVUTIL(BILLIEN)
 ;
 ;Put data in OUT variable
 S:$G(BILLOUT(430,IENS,3,"I"))]"" $P(OUT,U,1)=BILLOUT(430,IENS,3,"I")
 S:$G(BILLOUT(430,IENS,60,"I"))]"" $P(OUT,U,2)=BILLOUT(430,IENS,60,"I")
 S:$G(BILLOUT(430,IENS,77,"I"))]"" $P(OUT,U,3)=BILLOUT(430,IENS,77,"I")
 S:PAYDATE]"" $P(OUT,U,4)=PAYDATE
 Q OUT
