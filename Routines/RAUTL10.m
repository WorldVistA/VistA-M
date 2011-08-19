RAUTL10 ;HISC/CAH,FPT,GJC-Utility Routine ;7/23/97  11:05
 ;;5.0;Radiology/Nuclear Medicine;**28**;Mar 16, 1998
 ;
UPDLOC ;Update Pt Loc Info, file 74.4
 ;RAY3= 0 node of 74.4, RAB= IEN of 74.3, RARDIFN= IEN of 74.4
 N RAY I '$D(^RARPT(RARPT,0)) Q
 I $P(^RARPT(RARPT,0),U,11) S RAPRTOK=1 Q
 S RAI="",RAI1=$S($D(^DPT(RADFN,.1)):^(.1),1:0) S:RAI1="" RAI1=0 S RAI=$O(^DIC(42,"B",RAI1,0)) S:'$D(RABTY) RABTY="ALL"
 I '$P(RAY3,U,6),'$P(RAY3,U,8),RAB=$$DQ("FILE ROOM") S RAPRTOK=1 G SET
 I $P(RAY3,U,6),$P(RAY3,U,6)=RAI S RAPRTOK=1 G SET
 I $P(RAY3,U,8),'RAI S RAPRTOK=1 G SET
 I $P(RAY3,U,6),'RAI S $P(RAY3,U,6)="" S RAY=$$DQ("FILE ROOM") D:'$D(RAFL) UP2(0) S:'RAY RAPRTOK=1 S:RAY=RAB&((RAI1=RABTY)!(RABTY="ALL")) RAPRTOK=1 G SET
 I $P(RAY3,U,6),$P(RAY3,U,6)'=RAI S $P(RAY3,U,6)=RAI D:'$D(RAFL) UP2(1) S:RAI1=RABTY!(RABTY="ALL") RAPRTOK=1 G SET
 I $P(RAY3,U,8),RAI S $P(RAY3,U,8)="",$P(RAY3,U,6)=RAI S RAY=$$DQ("WARD REPORTS") D:'$D(RAFL) UP2(2) S:RAY=RAB!('RAY) RAPRTOK=1
SET I $D(RAPRTF),$D(RAPRTOK) S $P(^RARPT(RARPT,0),U,11)=DT
 K RAI,RAI1 Q
 ;
UP2(RAX) ;update file - 74.4
 ;INPUT: RAX (required)
 ;   If RAX=0, inpt to outpt/RAX=1, ward transfer/RAX=2, outpt to inpt
 ;OUTPUT: If being called from RARTST2 and patient has been discharged,
 ; the variable RARTST2I will be defined and will contain the IEN of
 ; the altered File Room record in file 74.4.
 N RABI,RABTCH,RADQ,DA,DIE,DR,DC S (RADQ("FROM"),RADQ("TO"))=0
 S:RAX=0 RADQ("FROM")=$$DQ("WARD REPORTS"),RADQ("TO")=$$DQ("FILE ROOM")
 S:RAX=2 RADQ("FROM")=$$DQ("CLINIC REPORTS"),RADQ("TO")=$$DQ("WARD REPORTS")
 I RAX'=1 S RABI=0 F  S RABI=$O(^RABTCH(74.4,"B",RARPT,RABI)) Q:'RABI  S RABTCH=+$P($G(^RABTCH(74.4,RABI,0)),U,11) S:RABTCH=RADQ("FROM") $P(RADQ("FROM"),U,2)=RABI S:RABTCH=RADQ("TO") $P(RADQ("TO"),U,2)=RABI
 I RAX=0,$P(RADQ("FROM"),U,2),$P(RADQ("TO"),U,2) S DIK="^RABTCH(74.4,",DA=$P(RADQ("TO"),U,2) D ^DIK K DIK I $D(RARTST2) D
 .;If file room entry in file 74.4 was deleted, and this is a discharged
 .;patient (i.e. RAX=0), and UPDLOC is being called from RARTST2 (i.e.
 .;RARTST2 is defined), set RARTST2I to IEN of remaining 74.4 entry that
 .;will be edited below to point to File Room.
 .;This fix was added so RARTST2 can properly update 'Date Printed' on
 .;the 74.4 entry for File Room for discharged patients.  Otherwise,
 .;File Room entries would print twice before being removed from queue.
 . I $$DQ("FILE ROOM")=$P(RADQ("TO"),U,1),'$D(^RABTCH(74.4,+$P(RADQ("TO"),U,2),0)) S RARTST2I=+$P(RADQ("FROM"),U,2)
 I RAX=2,'+RADQ("TO"),$P(RADQ("FROM"),U,2) S DIK="^RABTCH(74.4,",DA=$P(RADQ("FROM"),U,2) D ^DIK K DIK
 S DR=$S(+RADQ("TO")&($P(RADQ("FROM"),U,2)):"11////^S X=+RADQ(""TO"")",1:"")
 S DIE="^RABTCH(74.4,",DR="I RAX>0 S Y=""@1"";6///@;S Y=""@2"";@1;6////^S X=RAI;@2;S:RAX=0 Y=""@3"" S:RAX=1 Y="""";8///@;@3;S:DA'=$P($G(RADQ(""FROM"")),U,2) Y="""";"_DR
 S DA=0 F  S DA=$O(^RABTCH(74.4,"B",RARPT,DA)) Q:'DA  D LOCK,^DIE L -^RABTCH(74.4,DA,0)
 K DA,DIE,DR,DE,DQ Q
DQ(X) ;distr queue
 ;INPUT: queue name
 ;OUTPUT: IEN in distr queue (74.3) or 0
 S X=+$O(^RABTCH(74.3,"B",X,0))
 Q $S('X:0,+$G(^RABTCH(74.3,X,"I")):0,1:X)
LOCK L +^RABTCH(74.4,DA,0):2 I '$T G LOCK
 Q
STR70(RA0,RA1,RA2,RA3) ;
 S RA0=""
 Q:'$O(^RADPT(RA1,"DT",RA2,"P",RA3,"M","B",0))
 M RA0=^RADPT(RA1,"DT",RA2,"P",RA3,"M","B")
 D STR(.RA0)
 Q
STR751(RA0,RAOIFN) ;
 S RA0=""
 Q:'$O(^RAO(75.1,RAOIFN,"M","B",0))
 M RA0=^RAO(75.1,RAOIFN,"M","B")
 D STR(.RA0)
 Q
STR(RA0) ;
 N I S I=""
 F  S I=$O(RA0(I)) Q:'I  S RA0=RA0_I_","
 Q
