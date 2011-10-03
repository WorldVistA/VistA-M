IBPFU ;ALB/CPM - FIND BILLING DATA TO ARCHIVE - UTILITIES ; 20-APR-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
LAST(NUM) ; Find last valid date for archiving a billing record.
 ;         Input:   NUM  --  number of previous fiscal years to retain.
 ;         Output:  Date of last day of fiscal year which may be archived
 N FY S:'$D(NUM) NUM=1
 S FY=$S($E(DT,4,5)<10:$E(DT,1,3),1:$E(DT,1,3)+1),FY=FY-(NUM+1)
 Q FY_"0930"
 ;
LOGADD(IBFILE) ; File a log entry in file #350.6
 ;         Input:   IBFILE  --  File number of file to be archived
 ;         Output:  ien of new log entry, or 0 if error occurred.
 N DA,DD,DO,DIC,DIE,DR,DLAYGO,IEN,X
 S IEN=0 L +^IBE(350.6,0):10 E  G LOGADDQ
 S X=$P($S($D(^IBE(350.6,0)):^(0),1:"^^-1"),"^",3)+1 I 'X G LOGADDQ
 S DIC="^IBE(350.6,",DIC(0)="L",DLAYGO=350.6
 F X=X:1 I X>0,'$D(^IBE(350.6,X)) L +^IBE(350.6,X):1 I $T,'$D(^IBE(350.6,X)) S DINUM=X D FILE^DICN I +Y>0 Q
 S (DA,IEN)=+Y,DIE="^IBE(350.6,",DR=".02////IB ARCHIVE/PURGE #"_DA_";.03////"_IBFILE_";.05////1;1.01///NOW"
 D ^DIE L -^IBE(350.6,IEN) I $D(Y) S IEN=0
LOGADDQ L -^IBE(350.6,0) Q IEN
 ;
TEMPL(IBFILE,LOGDA) ; Add a new search template to file #.401 (SORT TEMPLATES)
 ;         Input:   IBFILE  --  File number of file to be archived
 ;                  LOGDA   --  IEN of log entry
 ;         Output:  ien of new template, or 0 if error occurred.
 N DA,DD,DO,DIC,DIE,DR,IEN,X
 I '$D(IBFILE)!('$D(LOGDA)) S IEN=0 G TEMPLQ
 S X="IB ARCHIVE/PURGE #"_LOGDA,DIC(0)="",DIC="^DIBT(" D FILE^DICN
 S (DA,IEN)=+Y,DIE=DIC,DR="2////"_DT_";3////"_DUZ(0)_";4////"_IBFILE_";5////"_DUZ_";6////"_DUZ(0)_";8////1"
 D ^DIE I $D(Y) S IEN=0
TEMPLQ Q IEN
