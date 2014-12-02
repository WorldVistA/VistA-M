ACKQUT1 ;HCIOFO/BH - Quasar utilities routine ;11 Jun 2013  4:19 PM
 ;;3.0;QUASAR;**6,21**;Feb 11, 2000;Build 40
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
 S ACKPARAM=$P($$ICDDATA^ICDXCODE("DIAG",CODE,DTE,"I"),"^",10)
 I $D(^TMP("ACKQ_CO_DIRECTIVE",$J)) S ACKPARAM=1
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
 I '$D(^ACK(509850.1,CODE,0)) Q 0
 I $P(^ACK(509850.1,CODE,0),U,4)'[$E(ACKCSC) Q 0
 I $P(^ACK(509850.1,CODE,0),U,6)'=1 Q 0
 I $P(^ACK(509850.1,CODE,0),U,7)'=$$ICDSYS^ACKQAICD(ACKVD) Q 0 ; Match ICD version in file to ICD version for date
 ;S ACKPARAM=$P($$ICDDX^ICDCODE(CODE,ACKVD),"^",10)
 ;
 S ACKPARAM=$P($$ICDDATA^ICDXCODE("DIAG",CODE,ACKVD),"^",10)
 Q ACKPARAM
 ;
 ;
