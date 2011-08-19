DGPTFVC3 ;ALB/MTC - VAILIDATION CHECK FOR PTF ADDITIONAL QUESTIONS ; 18 MAR 91
 ;;5.3;Registration;**164,729**;Aug 13, 1993;Build 59
 ;
 ; Called by Q+2^DGPTFTR
 ; Variable Passed In:  PTF - Current PTF record.
 ; Variable Returned :  DGERR - 1 if fails else "" 
 ;
EN ;
 D INIT G:DGOUT ENQ
 D 401,501,701
ENQ ;
 K DGPTF,DGHOLD,DGMOV,DGJ,DGBPC,DGPTIT,DGOUT,DGSUR,DGREC
 Q
501 ;-- check 501's for inconsistent data
 K DGPTIT
 F DGMOV=0:0 S DGMOV=$O(^DGPT(DGPTF,"M",DGMOV)) Q:DGMOV'>0  I $D(^DGPT(DGPTF,"M",DGMOV,0)) S DGHOLD=^(0) D CHKFL5
 K DGMOV
 Q
 ;
CHKFL5 ;-- check field entries
 F DGJ=5:1:9 I $P(DGHOLD,U,DGJ)]"" S DGPTIT($P(DGHOLD,U,DGJ)_";ICD9(")=""
 D DC^DGPTSCAN,SCAN^DGPTSCAN
 I '$D(DGBPC),'$D(^DGPT(DGPTF,"M",DGMOV,300)) G CHK5Q
 S DGHOLD=$S($D(^DGPT(DGPTF,"M",DGMOV,300)):^(300),1:"")
 D GETNUM^DGPTSCAN
 ;F DGII=2:1:DGFNUM I ('$D(DGBPC(DGII))&($P(DGHOLD,U,DGII)]""))!($D(DGBPC(DGII))&($P(DGHOLD,U,DGII)']"")) S DGERR=1 D W501
 F DGII=2:1:DGFNUM I ($D(DGBPC(DGII))&($P(DGHOLD,U,DGII)']"")) S DGERR=1 D W501
 ;
CHK5Q K DGFNUM,DGII,DGBPC,DGPTIT
 Q
 ;
401 ;-- check 401's for inconsistent data
 K DGPTIT
 F DGSUR=0:0 S DGSUR=$O(^DGPT(DGPTF,"S",DGSUR)) Q:DGSUR'>0  I $D(^DGPT(DGPTF,"S",DGSUR,0)) S DGHOLD=^(0) D CHKFL4
 Q
 ;
CHKFL4 ;-- check field entries
 F DGJ=8:1:12 I $P(DGHOLD,U,DGJ)]"" S DGPTIT($P(DGHOLD,U,DGJ)_";ICD0(")=""
 D DC^DGPTSCAN,SCAN^DGPTSCAN
 I '$D(DGBPC),'$D(^DGPT(DGPTF,"S",+DGSUR,300)) G CHK4Q
 S DGHOLD=$S($D(^DGPT(DGPTF,"S",+DGSUR,300)):^(300),1:"")
 ;I ('$D(DGBPC(1))&($P(DGHOLD,U)]""))!($D(DGBPC(1))&($P(DGHOLD,U)']"")) S DGERR=1 D W401
 I ($D(DGBPC(1))&($P(DGHOLD,U)']"")) S DGERR=1 D W401
CHK4Q K DGBPC,DGPTIT
 Q
 ;
701 ;-- process 701 load DGPTIT array
 K DGPTIT
 G CHK7Q:'$D(^DGPT(DGPTF,70)) S DGREC=^(70)
 F DGI=10,16:1:24 I $P(DGREC,U,DGI) S DGPTIT($P(DGREC,U,DGI)_";ICD9(")=""
 D DC^DGPTSCAN,SCAN^DGPTSCAN,ANYPSY^DGPTSCAN
 I '$D(DGBPC),'$D(^DGPT(DGPTF,"M")) G CHK7Q
 S DGTREC=$S($D(^DGPT(DGPTF,300)):^(300),1:"")
 S DG701="" D FLAGCHK^DGPTSCAN
 D GETNUM^DGPTSCAN
 ;F DGII=2:1:DGFNUM I $D(DGBPC(DGII))&($P(DGTREC,U,DGII)']"")!('$D(DGBPC(DGII))&($P(DG701,U,DGII)]"")&($P(DGTREC,U,DGII)']""))!('$D(DGBPC(DGII))&($P(DGTREC,U,DGII)]"")&($P(DG701,U,DGII)']"")) S DGERR=1 D W701
 F DGII=2:1:DGFNUM I $D(DGBPC(DGII))&($P(DGTREC,U,DGII)']"") S DGERR=1 D W701
CHK7Q ;
 K DGII,DGFNUM,DG701,DGHOLD,DGTREC,DGI
 Q
 ;
W401 ;-- display error message for 401
 N X S X=+^DGPT(DGPTF,"S",DGSUR,0),X=$TR($$FMTE^XLFDT(X,"5DF")," ","0")
 W !,"401 Surgery  date: ",X,"...",$P($T(ERRMSG+1),";",4)
 Q
W501 ;-- display error message for 501
 N X S X=+$P(^DGPT(DGPTF,"M",DGMOV,0),"^",10),X=$TR($$FMTE^XLFDT(X,"5DF")," ","0")
 W !,"501 Movement date: ",X,"...",$P($T(ERRMSG+DGII),";",4)
 Q
W701 ;-- display error messages for 701
 W !,"701 ",$P($T(ERRMSG+DGII),";",4)
 Q
INIT ;
 I '$D(PTF) S DGOUT=1 G INITQ
 S DGOUT=0,DGPTF=PTF
 I '$D(^DGPT(DGPTF)) S (DGOUT,DGERR)=1
 D LO^DGUTL,HOME^%ZIS
INITQ Q
 ;
ERRMSG ;-- error messages
 ;;1;Kidney Transplant Status Data Error.
 ;;2;Suicide Indicator Data Error.
 ;;3;Legionnaire's Disease Indicator Data Error.
 ;;4;Substance Abuse Type Data Error.
 ;;5;Psychiatry Axis IV Data Error.
 ;;6;Psychiatry Axis V Data Error.
 ;;7;Psychiatry Axis V Data Error.
 ;
 ;
