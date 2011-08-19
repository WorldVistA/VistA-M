YSPHY1 ;SLC/DJP-CONTINUATION OF YSPHY ;11/15/90  16:34 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
ENCLN ; Called by routine YSPHY
 I $P(^MR(YSDFN,"PE",YSIDT,0),U)'=DT D:YSEDIT=1 MSG5 D:YSEDIT=0 MSG6 Q
CLNCK ;
 I $D(^MR(YSDFN,"PE",YSIDT,.8)) D:YSEDIT=1 MSG3 D:YSEDIT=0 MSG6 Q
PCSET ;
 I YSNEW=1 S YSPNUM=$P(^MR(YSDFN,"PE",0),U,4) S $P(^MR(YSDFN,"PE",0),U,4)=YSPNUM-1 K YSPNUM
PHYCLN ;
 K ^MR(YSDFN,"PE",YSIDT),^MR(YSDFN,"PE","B",YSYDT) D MSG4
 I YSNP=1 K ^MR("B",YSDFN,YSDFN),^MR(YSDFN),^MR(YSDFN,"PE",0)
 Q
YSDIZ ; Called by routine YSPHY
 S DP=90.01
 S YSZS=^MR(YSDFN,YSPE,YSIDT,.9) F I=1:1:19 S YSZS(I+1)=$P(YSZS,U,I)
 S YSZS="" F Z=2:1:11,$S(YSSEX["F":13,1:12),14:1:19 D DIZ1 Q:X["^"
 S YSZS="" F I=2:1:19 S YSZS=YSZS_YSZS(I)_U
 L +^MR(YSDFN) S ^MR(YSDFN,YSPE,DA,.9)=YSZS L -^MR(YSDFN)
 Q
DIZ1 ;
 S DP=90.01,DQ=^DD(DP,Z,0),YSDE=YSZS(Z) D ^YSDIZ Q:X["^"  S YSZS(Z)=YSDE D ABNORM:YSDE>2 Q
ABNORM ;
 S DIE=YSDIZ,DR=$S(X=3:Z_".9",1:Z_".1:"_Z_".9") D ^DIE Q
HLP1 ; Called by routine YSPHY
 I YSNEW=0 W !!,"Enter 'E' to EDIT an existing physical for this patient.",!!,"Enter 'P' to PRINT a current physical for this patient."
 I YSNEW=1 W !!,"Enter 'E' to ENTER a new physical for this patient."
 W !!,"Enter 'Q' to QUIT the exam process."
 Q
HLP2 ;  Called by routine YSPHY
 W !!!,"Entering 'Y' or <CR> for 'YES' accepts the given PREVIOUS exam for EDITING",!?5,"or PRINTING."
 W !!,"ENTERING 'N' for 'NO' allows you to ENTER a new exam." D HLP3
 Q
HLP3 ;
 W !!,$C(7,7),"IMPORTANT NOTE: (1). You may NOT enter MORE than ONE EXAM per PATIENT per DAY."
 W !?16,"(2). Only the DESIGNATED EXAMINER can EDIT a PREVIOUS exam.",!!
 Q
HLP4 ; Called by routine YSPHY
 W !!,"Enter a previous physical exam NUMBER to EDIT an existing exam."
 W !!,"Or enter <CR> to CREATE a NEW physical exam." D HLP3
 Q
CHK1 ; Called by routine YSPHY
 Q:YSNEW=1  S YSEDUZ=$P(^MR(YSDFN,YSPE,YSLDT,0),U,10) I YSEDUZ'=DUZ S YSUOUT=1 D MSG1 Q
 Q
CHK2 ; Called by routine YSPHY
 I YSYDT=YSA(1) D MSG2 S YSUOUT=1 Q
 ;Using A(1) instead of A(K) will force compare to the most current exam.
 S YSNEW=1
 Q
MSG1 ;
 W !!,$C(7),?1,"*** ONLY THE DESIGNATED EXAMINER MAY EDIT A PREVIOUSLY ENTERED EXAM ***",!! H 3
 Q
MSG2 ;
 W !!,$C(7),?1,"**    A PREVIOUS physical EXAM for this PATIENT was created TODAY     **"
 W !?1,"** You may NOT create MORE than ONE physical EXAM per PATIENT per DAY **",!! H 3
 Q
MSG3 ; Called by routine YSPHY
 W !!?1,"** The EXAM SAVED with the remaining portion SET to NORMAL **" H 3
 Q
MSG4 ;
 W !!,$C(7),?10,"** PROCESSING OF THIS EXAM WAS TERMINATED **"
 W !!?10,"**     << EXAM DELETED FROM FILES >>      **" H 3
 Q
MSG5 ;
 W !!,$C(7),?10,"**   << EXAM SAVED >>   **",! H 3
 Q
MSG6 ; Called by routine YSPHY
 W !!?1,"** The EXAM SAVED with remaining portion set as previously entered **",! H 3
 Q
END ; Called by routine YSPHY, YSPHYR
 I $D(YSTOUT),YSTOUT W:IOF]"" @IOF
 F J=1:1:18 S X="V"_J K @X
 K %,%DT,%ZIS,A,A1,B4,C,D,J,K,D0,DA,DIC,DIE,DP,DQ,DR,YSDT(0),YSDT(1),DXS,I,I0,IO("Q"),IOP,J,K,L,M,P,POP,X,X1,Y,YS,YSAGE,YSAC,YSBL,YSBLN,YSCD,YSCON,YSDE,YSDFN,YSDH,YSDIZ,YSDOB,YSDOT,YSDTM,YSFTR,YSHD,YSFHDR,YSIDT
 K YSLFT,YSNM,YSNP,YSNS,YSPE,YSPI,YSPPL,YSPST,YSPSV,YSPY,YSSEX,YSSP,YSSSN,YST,YSTM,YSTOUT,YSUOUT,YSUSER,YSX,YSYDT,YSYN,YSZS,YSZZ,Z,ZTSK I $D(YSTIME) S:YSTIME>0 DTIME=YSTIME
 K YSTIME,YSLDT,YSNEW,YSEDIT,YSEDUZ Q
