FBSVBR ;ISW/SAB - PAYMENT BATCH RESULT MESSAGE SERVER ;12/5/2011
 ;;3.5;FEE BASIS;**131**;JAN 30, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine is called by a server option to process the
 ; Payment Batch Result message sent by Central Fee.
 ; The patch FB*3.5*131 version of this routine will ignore the message.
 ; A future patch, FB*3.5*132, will modify this routine to process the
 ; message contents and update Fee Basis files accordingly. 
 ;
 ; ICRs
 ;  #10072 REMSBMSG^XMA1C
 ;
 ; remove Central Fee message from server basket
 N XMSER,XMZ
 S XMSER="S."_XQSOP,XMZ=XQMSG D REMSBMSG^XMA1C
 Q
