DGRPE4 ;ALB/GTS - REGISTRATIONS EDITS ; 5/25/05 08:53am
 ;;5.3;Registration;**624**;Aug 13, 1993
 ;
 ;DGDR contains a string of edits; edit=screen*10+item #
 ;
 ;line tag screen*10+item*1000 = continuation line
 ;
 N DGPH,DGPHFLG,UPARROUT
 S UPARROUT=0
 K DR S (DA,Y)=DFN,DIE="^DPT(",DR="",DGDRS="DR",DGCT=0
 I (DGDR["401") DO
 . S J1="A401"
 . S DGDRD=$P($T(@J1),";;",2)
 . D S
 . D ^DIE
 . I $D(Y)'=0 S UPARROUT=1
 . I UPARROUT=0 DO
 . . K DR,DA,Y,DIE
 . . S (DA,Y)=DFN,DIE="^DPT(",DR="",DGDRS="DR",DGCT=0
 . . S J1="B401"
 . . S DGDRD=$P($T(@J1),";;",2)
 . . D S
 . . S DIE("NO^")=""
 . . D ^DIE
 . . K DR,DA,Y,DIE
 . . N DGEMPST
 . . S DGEMPST=(+$P($G(^DPT(DFN,.311)),"^",15))
 . . I (DGEMPST]"")!(DGEMPST'=3)!(DGEMPST'=9) DO
 . . . S (DA,Y)=DFN,DIE="^DPT(",DR="",DGDRS="DR",DGCT=0
 . . . S J1="C401"
 . . . S DGDRD=$P($T(@J1),";;",2)
 . . . D S
 . . . D ^DIE
 K DR,DA,Y,DIE
 F  Q:DGDR'["401,"  S DGDR=$P(DGDR,"401,")_""_$P(DGDR,"401,",2,999)
 I (UPARROUT=0)&(DGDR["402") DO
 . K DR S (DA,Y)=DFN,DIE="^DPT(",DR="",DGDRS="DR",DGCT=0
 . S J1="A402"
 . S DGDRD=$P($T(@J1),";;",2)
 . D S
 . D ^DIE
 . I $D(Y)'=0 S UPARROUT=1
 . I UPARROUT=0 DO
 . . K DR,DA,Y,DIE
 . . S (DA,Y)=DFN,DIE="^DPT(",DR="",DGDRS="DR",DGCT=0
 . . S J1="B402"
 . . S DGDRD=$P($T(@J1),";;",2)
 . . D S
 . . S DIE("NO^")=""
 . . D ^DIE
 . . K DR,DA,Y,DIE
 . . N DGEMPST
 . . S DGEMPST=(+$P($G(^DPT(DFN,.311)),"^",15))
 . . I (DGEMPST]"")!(DGEMPST'=3)!(DGEMPST'=9) DO
 . . . S (DA,Y)=DFN,DIE="^DPT(",DR="",DGDRS="DR",DGCT=0
 . . . S J1="C402"
 . . . S DGDRD=$P($T(@J1),";;",2)
 . . . D S
 . . . D ^DIE
 K DR,DA,Y,DIE
 F  Q:DGDR'["402,"  S DGDR=$P(DGDR,"402,")_""_$P(DGDR,"402,",2,999)
 K DR,DA,Y,DIE
 Q
S I $L(@DGDRS)+$L(DGDRD)<241 S @DGDRS=@DGDRS_DGDRD Q
 S DGCT=DGCT+1,DGDRS="DR(1,2,"_DGCT_")",@DGDRS=DGDRD Q
 Q
A401 ;;.07;
B401 ;;.31115;
C401 ;;S DGST=$P(^DPT(DA,.311),"^",15);S:$S(DGST']"":1,DGST=3:1,DGST=9:1,1:0) Y=0 I Y=0 K DGST;S:($P(^DPT(DA,.311),"^",15)'=5) Y=.3111;.31116;.3111;S:X']"" Y="@41";.3113;S:X']"" Y=.3116;.3114;S:X']"" Y=.3116;.3115:.3117;.2205;.3119;@41;K DGST;
A402 ;;.2514;
B402 ;;.2515;
C402 ;;S DGST=$P(^DPT(DA,.25),"^",15);S:$S(DGST']"":1,DGST=3:1,DGST=9:1,1:0) Y=0 I Y=0 K DGST;S:($P(^DPT(DA,.25),"^",15)'=5) Y=.251;.2516;.251;S:X']"" Y="@42";.252;S:X']"" Y=.255;.253;S:X']"" Y=.255;.254:.256;.2206;.258;@42;K DGST;
