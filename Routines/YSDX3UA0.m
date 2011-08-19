YSDX3UA0 ;DALISC/LJA - Continuation of YSDX3UA0 code... ;8/17/94 08:22
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;;
 ;
DXLS ;This subroutine looks up and displays the diagnosis for Length of Stay (DXLS)
 ;D RECORD^YSDX0001("DXLS^YSDX3UA0") ;Used for testing.  Inactivated in YSDX0001...
 Q:'$D(^YSD(627.8,"AD",YSDFN))  ;->
 S J=$O(^YSD(627.8,"AD",YSDFN,0)) ;     Inverse date
 S J1=$O(^YSD(627.8,"AD",YSDFN,J,0)) ;  IEN
 QUIT:$P(^YSD(627.8,J1,1),U,4)["I"  ;-> Condition
 S J2=$P(^YSD(627.8,J1,1),U) ;          Diag variable pointer
 S Y=$P(^YSD(627.8,+J1,0),U,3) D DD^%DT S YSDXLSD=Y
 ;
 S J3=$P(J2,";",2)
 S J4=$P(J2,";")
 S J5="^"_J3_J4_","_0_")"
 S J50=@J5
 ;
 ;  DSM?
 I J3["YSD" D
 .  S YSDXLS=^YSD(627.7,+J4,"D") ;        Code name
 .  S YSDXLSN=$P(J50,U,2) ;               Code#
 ;
 ;  ICD9?
 I J3["ICD9(" D
 .  S YSDXLS=$P(J50,U) ;                  Code #
 .  S YSDXLSN=$P(J50,U,3) ;               Code name
 ;
 I $D(YSDXLS) D
 .  W !!,"The following diagnosis has been noted as the DXLS:  "
 .  W !!?3,YSDXLS_" "_$E(YSDXLSN,1,25)," dated ",YSDXLSD
 QUIT
 ;
DXLSQ ;
 ;D RECORD^YSDX0001("DXLSQ^YSDX3UA0") ;Used for testing.  Inactivated in YSDX0001...
 I C2["I" S YSDXLX="n" QUIT  ;->
 W !!,"Is "_YSW_" "_$E(YSWN,1,45),!?5," the DXLS"
 S %=2
 D YN^DICN
 I %=-1!(%=2) S YSDXLX="n" QUIT  ;->
 I %=0 D  G DXLSQ ;->
 .  W !!,"This is the diagnosis accounting the largest % of length of stay for this "
 .  W !,"admission.  There may only be ONE DXLS (DSM or ICD9) per admission."
 S YSDXLX="y"
 I $D(J1) D   QUIT  ;->
 .  S DIE="^YSD(627.8,",DA=J1,DR="10///^S X=""c"""
 .  L +^YSD(627.8,DA)
 .  D ^DIE
 .  L -^YSD(627.8,DA)
 QUIT
 ;
EOR ;YSDX3UA0 - Continuation of YSDX3UA0 code... ;8/17/94
