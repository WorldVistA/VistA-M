PSO386P ;BIR/MR - HOLD REASON conversion post-install routine; 05/31/12 1:16pm
 ;;7.0;OUTPATIENT PHARMACY;**386**;DEC 1997;Build 4
 ;
 N RXIEN,HLDREA
 F HLDREA=3,5 D
 . S RXIEN=0
 . F  S RXIEN=$O(^PSRX("AH",HLDREA,RXIEN)) Q:'RXIEN  D
 . . I '$G(^PSRX(RXIEN,"H")) Q
 . . S $P(^PSRX(RXIEN,"H"),"^",1)=6
 . . S ^PSRX("AH",6,RXIEN)=""
 . . K ^PSRX("AH",HLDREA,RXIEN)
 Q
