LRRP8B ;HDSO/DSK - WKLD STATS REPORT BY SHIFT; Sep 29, 2025@17:00
 ;;5.2;LAB SERVICE;**589**;Sep 27, 1994;Build 1
 W !!,"ENTRY POINT IS AT EN^LRRP8." H 3 QUIT
 ;
BUILD ;
 N LRGCN,LRCCN,LRDCN
 S ^TMP("LR",$J,0)=0
 D INITMAN^LRCAPMR1
 D GENCOM^LRCAPMR1,CAPCOM^LRCAPMR1
 ;LR*5.2*589: Correct ending date if user entered month and year.
 ;            Upstream routines flip the "to" and "from" variables
 ;            depending on various factors. "31" covers max number
 ;            of days per month.
 I $E(LRTO,6,7)="00" S $E(LRTO,6,7)=31
 S LRCDT=LRFR-1
 F  S LRCDT=$O(^LRO(64.1,LRIN,1,LRCDT)) Q:('LRCDT)!(LRCDT>LRTO)  D
 . D DATCOM^LRCAPMR1
 . S LRCC=0
 . F  S LRCC=$O(^LRO(64.1,LRIN,1,LRCDT,1,LRCC)) Q:'LRCC  D
 . . I LRCAPS Q:'$D(LRCAPS(LRCC))
 . . S LRCAPNAM=$$WKLDNAME^LRCAPU(LRCC)
 . . D SHIFT
 . . D BMPMANL^LRCAPMR1
 Q
SHIFT ;*** If shift, setup start and stop time ranges for each shift ***
 N I2
 I LRSTFLG=0 S LRNSFT=1,LRST(1)=LRSTRT_"^"_LRSTOP
 F I2=1:1:LRNSFT D
 . S LRSTRT=$P(LRST(I2),"^"),LRSTOP=$P(LRST(I2),"^",2)
 . S LRTIM=LRSTRT-.000001
 . F  S LRTIM=$O(^LRO(64.1,LRIN,1,LRCDT,1,LRCC,1,LRTIM)) Q:('LRTIM)!(LRTIM>LRSTOP)  D
 . . S LRREC=$G(^LRO(64.1,LRIN,1,LRCDT,1,LRCC,1,LRTIM,0)) Q:'$L(LRREC)
 . . S LRUC=+$P(LRREC,U,3) S:'LRUC LRUC=1
 . . S LRA=$P(LRREC,U,7) Q:'LRA
 . . I LRAA Q:'$D(LRAA(LRA))
 . . S LRANAM=$P($G(^LRO(68,LRA,0)),U) S:LRANAM="" LRANAM="UNKN - "_LRA
 . . S ^(0)=^TMP("LR",$J,0)+LRUC
 . . S:'$D(^TMP("LR",$J,"AA",LRA,0)) ^(0)=0 S ^(0)=^(0)+LRUC
 . . S:'$D(^TMP("LR",$J,"AA",LRA,"SHFT",I2,0)) ^(0)=0 S ^(0)=^(0)+LRUC
 . . S:'$D(^TMP("LR",$J,"AA",LRA,"SHFT",I2,"CCN",LRCAPNAM,0)) ^(0)=0_U_LRCAPNUM S $P(^(0),U)=^(0)+LRUC
 . . S:'$D(^TMP("LR",$J,"AA",LRA,"CCN",LRCAPNAM,0)) ^(0)=0_U_LRCAPNUM S $P(^(0),U)=^(0)+LRUC
 Q
