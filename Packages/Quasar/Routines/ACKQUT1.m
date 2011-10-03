ACKQUT1 ;HCIOFO/BH-Quasar utilities routine ; 04/01/03
 ;;3.0;QUASAR;**6**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
ACKCPT(CODE)    ;  Validate CPT code using today's date
 ;
 N ACKPARAM,DTE,X,Y
 D NOW^%DTC S DTE=$P(%,".",1)
 S ACKPARAM=$P($$CPT^ICPTCOD(CODE,DTE),"^",7)
 I 'ACKPARAM D
 . W !!
 . W "The selected code is not valid for today's date.",!!
 Q ACKPARAM
 ;
ACKICD(CODE) ;  Validate ICD code using today's date
 ;
 N ACKPARAM,DTE,X,Y
 D NOW^%DTC S DTE=$P(%,".",1)
 S ACKPARAM=$P($$ICDDX^ICDCODE(CODE,DTE),"^",10)
 I 'ACKPARAM D
 . W !!
 . W "The selected code is not valid for today's date.",!!
 ;
 Q ACKPARAM
 ;
 ;
CPT(CODE,ACKVD,ACKCSC) ; screen for active CPT codes
 N ACKPARAM
 I $P(^ACK(509850.4,CODE,0),U,2)'[$E(ACKCSC) Q 0
 I $P(^ACK(509850.4,CODE,0),U,4)'=1 Q 0
 S ACKPARAM=$P($$CPT^ICPTCOD(CODE,ACKVD),"^",7)
 Q ACKPARAM
 ;
 ;
ICD(CODE,ACKVD,ACKCSC) ; screen for active ICD codes
 N ACKPARAM
 I $P(^ACK(509850.1,CODE,0),U,4)'[$E(ACKCSC) Q 0
 I $P(^ACK(509850.1,CODE,0),U,6)'=1 Q 0
 S ACKPARAM=$P($$ICDDX^ICDCODE(CODE,ACKVD),"^",10)
 Q ACKPARAM
 ;
 ;
