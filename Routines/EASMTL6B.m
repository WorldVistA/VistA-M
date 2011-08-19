EASMTL6B ;ALB/SCK - EAS QUEUED MEANS TEST LETTERS ; 2/25/02
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,15**;MAR 15,2001
 ;
BCKJOB ;  Queued entry point for tasked letter printing
 N EATYP,EASMULT,EASKP,EASARY,EASTMP,EASPTR,DFN,EASPRF,EASDEV,EASPRM,EAX,EASTSK,EASERR,EADPTR,EATYP
 ;
 S EASTMP="^TMP(""EASMT"",$J)"
 K @EASTMP
 ;
 F EATYP=1,2,4 D
 . D BLD^EASMTL6(EATYP,0,EASTMP,.EASKP)
 . D RESULT^EASMTL6(.EASKP,EATYP)
 . Q:'$D(@EASTMP)
 . S EASIEN=0
 . F  S EASIEN=$O(@EASTMP@(EASIEN)) Q:'EASIEN  D
 . . D LETTER^EASMTL6A(EASIEN,EATYP)
 . . D UPDSTAT^EASMTL6(EASIEN,EATYP)
 . K @EASTMP
 ;
 Q
 ;
LTRTYP(EASIEN) ;  Function lookup for current pending letter type.
 ;  Input
 ;     EASIEN - IEN in the Letter status file, #713.2
 ;
 ;  Output
 ;     Current pending to print letter type
 ;        60-DAY = 1
 ;        30-DAY = 2
 ;         0-DAY = 4
 ;     Unable to determine = 0
 ;
 N RSLT
 ;
 S RSLT=0
 I $P($G(^EAS(713.2,EASIEN,"Z")),U,2) S RSLT=4
 I $P($G(^EAS(713.2,EASIEN,4)),U,2) S RSLT=2
 I $P($G(^EAS(713.2,EASIEN,6)),U,2) S RSLT=1
 Q $G(RSLT)
