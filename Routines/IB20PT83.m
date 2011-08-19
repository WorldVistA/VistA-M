IB20PT83 ;ALB/CPM - EXPORT ROUTINE 'DGPTTS' ; 14-FEB-94
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
DGPTTS ;ALB/AS - UPDATE FACILITY TREATING SPECIALTY/501 MOVEMENTS IN PTF ; 1/30/90 @12
 ;;5.3;Registration;**26**;Aug 13, 1993
 ;needs to be done - OERR link
 ;
EV ;entry point from event driver
 D EV^DGPTTS0
 Q
 ;
DEL ;facility treating specialty has been deleted from ^DGPM
 S DGPTFP=^UTILITY("DGPM",$J,6,DGMV,"PTFP")
 G DEL1:'$D(^DGPT(PTF,"M",+$P(DGPTFP,"^",2),0))
 K DA S DGREC=^(0),DGEX=$S($D(^(300)):^(300),1:""),DA=$P(DGPTFP,"^",2),DA(1)=PTF,DIK="^DGPT("_DA(1)_",""M""," D ^DIK K DA
 S DGMSG="" F X=5:1:15 S:X'=10 DGMSG=DGMSG_$S($D(^ICD9(+$P(DGREC,U,X),0)):$P(^(0),U,1)_", ",1:"")
 G DEL1:DGMSG']"" S ^UTILITY($J,"DEL",$P(DGPTFP,"^",2))=DGMSG
 ;-- save expanded codes 
 S DG1=""
 I DGEX]"" F X=2:1:7 S:$P(DGEX,U,X)]"" $P(DG1,U,X)=$P(DGEX,U,X)
 S:DG1]"" ^UTILITY($J,300,$P(DGPTFP,U,2))=DG1
 K DGI
 S Y=$P(DGREC,U,10) X ^DD("DD") S DGMSG="501 movement of "_$P(^DPT(DFN,0),U,1)_" of "_Y_" losing specialty "_$P(^DIC(42.4,$P(DGREC,U,2),0),U,1)_" was deleted by "_$P(^VA(200,DUZ,0),U,1)_" it contained diag "_$E(DGMSG,1,120)
 S DGMSG1="501 Movement Deletion" D MSG^DGPTMSG1
 ;
DEL1 S X=^DPT(DFN,0),DGMSG="A transfer between treating specialties for "_$P(X,U,1)_" ("_$P(X,U,9)_") on "_$E(+DGMVP,4,5)_"/"_$E(+DGMVP,6,7)_"/"_$E(+DGMVP,2,3)_" was deleted by "_$P(^VA(200,+DUZ,0),U)_".  Please verify PTF #"_PTF_"."
 S DGMSG1="Facility Treating Specialty Deletion" D MSG^DGPTMSG1
 ;
 S DR="" I $P(DGPTFP,"^",3)=1 S DGREC=^DGPT(PTF,"M",1,0) F X=5:1:15 I X'=10 S:$P(DGREC,U,X) DR=DR_X_"///@;"
 I DR]"" S DA(1)=PTF,DIE="^DGPT("_DA(1)_",""M"",",DA=1 D ^DIE
 ;-- clean up expanded code data
 S DR="" I $P(DGPTFP,U,3)=1,$D(^DGPT(PTF,"M",1,300)) S DGREC=^(300) F X=2:1:7 S:$P(DGREC,U,X) DR=DR_"300.0"_X_"///@;"
 I DR]"" S DA=1,DA(1)=PTF D ^DIE
 K DGPTFP,DGREC,DA,DR,DIE,Y,X,DGEX Q
 ;
LE ;entry point for PTF record update
 W:'$D(ZTQUEUED) !,"Updating PTF Record #",PTF,"..." K ^UTILITY($J,"T")
 S DGPREV=$O(^DGPM("ATS",DFN,DGPMCA,0)),DGDT=$S($D(^DGPM(+$P(DGPMAN,"^",17),0)):+^(0),1:"")
 D NOTS:'DGPREV
 I DGPREV S:DGDT T(DGDT)="" D ^DGPTTS1,VARS^DGPTSUDO
 K DGDR,L,MN,DIE,DIC,DIS,D,J,ADM,%DT,DR,I1,LL,NOW,T,TRN,ZTSK,L1,L2,T1,T2,TD,TDD,I,PTN,NTR,DA,NX,NXX,PR,DGTNX,DGTEMP,DGTPR,LOL,LOP,Z,Y,A,B,C,DGAD,DGDEL,X1,X2,^UTILITY($J,"T"),DGTR,DGREC,DGDT1,DGTLOS
 F DA=0:0 S DA=$O(^DGPT(PTF,"P",DA)) Q:DA'>0  I $D(^DGPT(PTF,"P",DA,0)) D BS^DGPTFM6 S DIE="^DGPT("_PTF_",""P"",",DA(1)=PTF,DR="1///"_DGMOVM D ^DIE
 D EN^DGPTTS3 W:'$D(ZTQUEUED) "completed."
Q K DGDT,DA,DGP0,DGMSG,DGPREV,DGREC,DGMOVM,DIC,DIE,DR,V,X,Y Q
 ;
NTR S DGMSG="A Transfer on "_$E(+DGMVA,4,5)_"/"_$E(+DGMVA,6,7)_"/"_$E(+DGMVA,2,3)_" was entered before the latest transfer.  Please verify PTF #"_PTF_"."
 S DGMSG1="New Facility Treating Specialty" D MSG^DGPTMSG1
 Q
 ;
NOTS ;
 S DIE="^DGPT("_PTF_",""M"",",DA(1)=PTF,DA=1,DR="2///@" D ^DIE
 F DA=0:0 S DA=$O(^DGPT(PTF,"P",DA)) Q:DA'>0  I $D(^DGPT(PTF,"P",DA,0)) S DIE="^DGPT("_PTF_",""P"",",DA(1)=PTF,DR="1///@" D ^DIE
 Q
 ;
DGDT ; -- get first ts before dc date
 N X S X=$P(9999999.999999-DGDT,".")
 F DGPREV=0:0 S DGPREV=+$O(^DGPM("ATS",DFN,DGPMCA,DGPREV)) Q:$P(DGPREV,".")'=X
 Q
 ;
CA ; -- determine CA info
 S DGPMCA=$S($P(DGPMP,"^",14):$P(DGPMP,"^",14),1:$P(DGPMA,"^",14))
 S DGPMAN=$S($D(^DGPM(+DGPMCA,0)):^(0),1:""),DGMVT=$S($P(DGPMP,"^",2):$P(DGPMP,"^",2),1:$P(DGPMA,"^",2)),PTF=$P(DGPMAN,"^",16),DGADM=+DGPMAN
 Q
