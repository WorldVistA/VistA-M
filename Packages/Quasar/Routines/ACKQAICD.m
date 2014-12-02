ACKQAICD ;HCIOFO/BH - Quasar utilities routine ;30 Jan 2013  3:30 PM
 ;;3.0;QUASAR;**21**;Feb 11, 2000;Build 40
 ;
ICDSYS(ACKQDOS,ACKQTYP) ; -- Get coding system
 ; -- input
 ;       ackqdos = date of service (DT) default
 ;       ackqtyp = diagnosis or procedure  (DIAG) default
 ;
 ; -- output pointer to ICD Version file for coding system
 ;
 N ACKQTYP1,IMPDATE,VERSION
 I $G(ACKQDOS)="" S ACKQDOS=DT
 I $G(ACKQTYP)="" S ACKQTYP1="10D"
 S VERSION=1 ; Default answer
 S IMPDATE=$$IMPDATE^LEXU(ACKQTYP1)
 I ACKQTYP1="10D" D  Q VERSION
 . I ACKQDOS<IMPDATE S VERSION="1",ACKQTYP="ICD"
 . I ACKQDOS'<IMPDATE S VERSION="30",ACKQTYP="10D" Q
 I ACKQTYP="PROC" D  Q VERSION
 . I ACKQDOS<IMPDATE S VERSION="2" Q
 . I ACKQDOS'<IMPDATE S VERSION="31" Q
 Q $G(VERSION)
