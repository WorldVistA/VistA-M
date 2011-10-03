XUPSPRA ;ALB/CMC - Build PRA segment;Aug 6, 2010
 ;;8.0;KERNEL;**551**;Jul 10, 1995;Build 2
EN(XUPSIEN,XUPSSTR,HL) ;
 ;XUPSIEN - New Person Internal Entry Number
 ;XUPSSTR - sequence numbers which should be used, only field 6 for DEA# at this point used
 ;HL - hl7 array variables
 ;RETURN:  PRA segment returned or -1^error message
 ;
 N XUPSREC,NUM
 I XUPSIEN=""!(XUPSSTR="")!('$D(HL)) S XUPSREC="-1^Missing Parameters" G QUIT ;missing parameter
 S $P(XUPSREC,HL("FS"),1)="PRA" ;sequence 1 set to segment type
 ;DEA# FIELD 6
 S NUM=$P($G(^VA(200,XUPSIEN,"PS")),"^",2)
 I NUM="" S NUM=HL("Q")
 S $P(XUPSREC,HL("FS"),7)=NUM
QUIT Q XUPSREC
