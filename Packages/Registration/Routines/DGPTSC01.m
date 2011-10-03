DGPTSC01 ;ALB/MTC - Additional routines to check for valid jumping ; JUN 14,1991
 ;;5.3;Registration;;Aug 13, 1993
 ;;MAS 5.1;
501 ;-- check if jump to expanded question was valid.
 S DGTX=X,DGER=1
 N DGPTIT,DGBPC,DGHOLD,DGPTF,DG701
 S DGHOLD=^DGPT(DA(1),"M",DA,0),DGPTF=DA(1)
 F DGI=5:1:9 I $P(DGHOLD,U,DGI)]"" S DGPTIT($P(DGHOLD,U,DGI)_";ICD9(")=""
 D SCAN^DGPTSCAN
 I $D(DGBPC(DGFLAG)) K:(DGFLAG=4)&($$ACTIVE(DGPTF,DGTX)) DGTX S:$D(DGTX) DGER=0,X=DGTX G ENQ
 D ERRMSG S DGER=1
 G ENQ
 ;
401 ;-- check if jump to expanded question was valid.
 S DGTX=X
 N DGPTIT,DGBPC,DGHOLD,DGPTF,DG701
 S DGHOLD=^DGPT(DA(1),"S",DA,0)
 F DGI=8:1:12 I $P(DGHOLD,U,DGI)]"" S DGPTIT($P(DGHOLD,U,DGI)_";ICD0(")=""
 D SCAN^DGPTSCAN
 I $D(DGBPC(DGFLAG)) S DGER=0,X=DGTX G ENQ
 D ERRMSG S DGER=1
 G ENQ
 ;
701 ;--
 N DGREC,DGPTF,DGPTIT,DGBPC,DGHOLD,DG701
 S DGPTF=DA,DGTX=X
 G ENQ:'$D(^DGPT(DA,70)) S DGREC=^(70)
 F DGI=10,16:1:24 I $P(DGREC,U,DGI) S DGPTIT($P(DGREC,U,DGI)_";ICD9(")=""
 D SCAN^DGPTSCAN
 D FLAGCHK^DGPTSCAN,GETNUM^DGPTSCAN
 F DGI=2:1:DGFNUM I $P(DG701,U,DGI)]"",$D(DGBPC(DGI)) K DGBPC(DGI)
 S DGER=1
 F DGI=2:1:DGFNUM I ($D(DGBPC(DGI))&(DGFLAG=DGI)) K:(DGFLAG=4)&($$ACTIVE(DGPTF,DGTX)) DGTX S DGER=0 S:$D(DGTX) X=DGTX Q
 I 'DGER S:'$D(DGTX) DGER=1 G ENQ
 D ERRMSG G ENQ
ERRMSG ;-- generic error message
 W !,"*** ERROR *** You must select a ICD that requires an expanded response."
 Q
 ;
ENQ ;
 K DGI,DGTX,DGHOLD,DGPTIT,DGBPC,DGPTF,DG701
 Q
 ;
DRUG ;-- if default drug is present in 45.89 then use it
 ;-- pass in DGPTIT(X) for one ICD9 code.
 S DGTY=$O(DGPTIT(0))
 G:'DGTY DRUGQ
 K DGTX
 I $D(^DIC(45.89,"ASPL",DGTY)) F DGTI=0:0 S DGTI=$O(^DIC(45.89,"ASPL",DGTY,DGTI)) Q:DGTI']""  I $D(^DIC(45.89,DGTI,0)),$P(^(0),U)=4,$D(^DIC(45.61,+$P(^(0),U,4),0)) S DGTX=$P(^(0),U)
 ;
DRUGQ ;
 K DGTY,DGTI
 Q
 ;
ACTIVE(PTF,DRUG) ;-- check if drug has been inactivated
 ;-- returns 1 if not active, else 0
 N DATE,SUBDATE,ACTIVE
 S ACTIVE=0
 S DATE=$S('$D(^DGPT(PTF,70)):DT,^(70):+^(70),1:DT),SUBDATE=$S($D(^DIC(45.61,+DRUG,0)):$P(^(0),U,3),1:"")
 I SUBDATE>0,SUBDATE<DATE S Y=SUBDATE X ^DD("DD") W !,"*** ERROR *** This Substance has been inactivated as of ",Y S ACTIVE=1
 Q ACTIVE
