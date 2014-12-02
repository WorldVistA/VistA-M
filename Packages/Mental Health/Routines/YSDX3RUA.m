YSDX3RUA ;SLC/DJP - Print Utilities for Diagnoses Reporting in MH - Cont ;13 May 2013  9:21 AM
 ;;5.01;MENTAL HEALTH;**16,107**;Dec 30, 1994;Build 23
 ;D RECORD^YSDX0001("^YSDX3RUA") ;Used for testing.  Inactivated in YSDX0001...
 ;
AX4 ;  Called by routine YSDX3R
 ; Print latest Axis 4 information
 ;D RECORD^YSDX0001("AX4^YSDX3RUA") ;Used for testing.  Inactivated in YSDX0001...
 Q:'$D(^YSD(627.8,"AX4",YSDFN))  S A1=0 F I=1:1:1 S A1=$O(^YSD(627.8,"AX4",YSDFN,A1)) Q:'A1  S A2=0 F  S A2=$O(^YSD(627.8,"AX4",YSDFN,A1,A2)) Q:'A2  D AX4P
 Q
AX4P ;
 ;D RECORD^YSDX0001("AX4P^YSDX3RUA") ;Used for testing.  Inactivated in YSDX0001...
 S YSPS=$P($G(^YSD(627.8,A2,60)),U) S:YSPS']"" YSPS="None given" S A3=$P(^(60),U,2),Y=$P(^(0),U,3) D DD^%DT S A9=$P(Y,"@")
 S TOTSET=";"_$P(^DD(627.8,61,0),U,3),SUBSET=$F(TOTSET,";"_A3_":") I SUBSET S YSAX4=$E($P($E(TOTSET,SUBSET,999),";"),1,50) I $Y+YSSL+4>IOSL D CK^YSDX3RU Q:YSTOUT!YSUOUT!YSLFT
 W !!,"AXIS IV:  Psychosocial stressors: ",YSPS,!?10,"Severity: ",A3_"--"_YSAX4,!?10,"Dated:    ",A9
 Q
AX5 ; Called by routine YSSP6
 ;
 ;D RECORD^YSDX0001("AX5^YSDX3RUA") ;Used for testing.  Inactivated in YSDX0001...
 Q:'$D(^YSD(627.8,"AX5",YSDFN))  S A5=$O(^YSD(627.8,"AX5",YSDFN,0)) Q:'A5  S A6=$O(^YSD(627.8,"AX5",YSDFN,A5,0)) Q:'A6  S A7=$P(^YSD(627.8,A6,60),U,3) D GAF^YSDX3UB
 S Y=$P(^YSD(627.8,A6,0),U,3) D DD^%DT S A8=$P(Y,"@")
 I $Y+YSSL+4>IOSL D CK^YSDX3RU Q:YSTOUT!YSUOUT!YSLFT
 W !!,"AXIS V:   Current GAF: ",A7_" (as of "_A8_")",!?10,"Highest GAF past year: ",$S($D(G5):G5,1:"No other GAF for past year") I $D(G5) W "  (dtd "_$S($D(G11):G11,1:"Date Missing")_")",!
 D FINISH^YSDX3RU
 QUIT
 ;
DXLS ; Called by routines YSDX3R, YSPP6
 ; This subroutine looks up and displays the diagnosis for Length of Stay (DXLS)
 ;D RECORD^YSDX0001("DXLS^YSDX3RUA") ;Used for testing.  Inactivated in YSDX0001...
 Q:'$D(^YSD(627.8,"AD",YSDFN))
 S J=$O(^YSD(627.8,"AD",YSDFN,0)) ; Inverse date
DXLS1 ;
 ;D RECORD^YSDX0001("DXLS1^YSDX3RUA") ;Used for testing.  Inactivated in YSDX0001...
 S J1=$O(^YSD(627.8,"AD",YSDFN,J,0)) ;       IEN
 S J2=$P(^YSD(627.8,+J1,1),U) ;               Diag variable pointer
 S (Y,YSDXLSD2)=$P(^YSD(627.8,+J1,0),U,3) D DD^%DT S YSDXLSD=Y ; Diag Date/time
 S J3=$P(J2,";",2) ;                  Global ref
 S J4=+$P(J2,";") ;                   IEN
 S J5="^"_J3_J4_","_0_")" ;           Global ref of 0 node
 S J50=@J5 ;                          Data for 0 node
 ;
 S YSDXCSTX=""
 ;  DSM?
 I J3["YSD" D
 .  S YSDXLSN=^YSD(627.7,+J4,"D") ;   Diagnosis name
 .  S YSDXLS=$P(J50,U,1) ;            ICD Code
 .  S YSDXCSTX="(ICD-"_$S($P(J50,U,8)'="":$P(J50,U,8),1:"9")_")"
 ;
 ;  ICD9?
 I J3["ICD9(" D
 .  N YSDXDATA S YSDXDATA=$$ICDDATA^ICDXCODE("DIAG",J4,YSDXLSD2,"I")
 .  S YSDXLSN=$P(YSDXDATA,U,4) ;      Diagnosis name
 .  S YSDXLS=$P(YSDXDATA,U,2) ;       ICD Code
 .  S YSDXCSTX=$P($P($$SINFO^ICDEX($P(YSDXDATA,U,20)),U,2),"-",2)
 .  S YSDXCSTX="(ICD-"_YSDXCSTX_")"
 ;
 I $D(YSDXLS) D
 .  W !!,"Principal Diagnosis (DXLS):  ",!!?3
 .  W YSDXCSTX_" "_YSDXLS_" "_$E(YSDXLSN,1,59),!?8," dated ",YSDXLSD
 ;
 ;  Modifiers?
 I $D(^YSD(627.8,+J1,5)) D
 .  S J6=$P(^YSD(627.8,+J1,5,0),U,3) ; Stands for
 .  F I=1:1:J6 W !?3,"--- ",$P(^YSD(627.8,+J1,5,I,0),U,3)
 ;
 K J1,J2,J3,J4,J5,J50,J6,YSDXCSTX,YSDXLSN,YSDXLS,YSDXLSD,YSCON
 QUIT
 ;
EOR ;YSDX3RUA - Print Utilities for Diagnoses reporting - continued ;9/18/92 15:37
