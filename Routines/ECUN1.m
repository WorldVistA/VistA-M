ECUN1 ;BIR/MAM-Allocate DSS Units (cont'd) ;13 Nov 95
 ;;2.0; EVENT CAPTURE ;**8,19**;8 May 96
 I '$D(UNIT(1))!('$D(USER(1))) W !!,"You must select both DSS Units and Event Capture Users.  No action taken.",!!,"Press <RET> to continue  " R X:DTIME Q
 W !!!,"Assigning DSS Units for Event Capture Users selected ...",!
 S (CNT,CNT1)=0 F I=0:0 S CNT=$O(UNIT(CNT)) Q:'CNT  F I=0:0 S CNT1=$O(USER(CNT1)) Q:'CNT1  D ALLOC
 K USER,UNIT
 W !!,"Press <RET> to continue  " R X:DTIME
 Q
ALLOC ; stuff info in USER/NEW PERSON file
 I '$D(^VA(200,+USER(CNT1),"EC",0)) S ^VA(200,+USER(CNT1),"EC",0)="^200.72PA^^"
 K DA,DIC,DD,DO I '$D(^VA(200,+USER(CNT1),"EC","B",+UNIT(CNT))) S DINUM=+UNIT(CNT),DA(1)=+USER(CNT1),DIC(0)="L",DIC="^VA(200,"_DA(1)_",""EC"",",X=+UNIT(CNT) D FILE^DICN K DIC
 Q
 ;
 ;
ACTSCR(ECDSS) ;- Reactivate Event Code Screens on DSS Unit
 ;
 N ECLOC,ECCAT,ECPROC,ECSCRN
 G ACTSCRQ:'$G(ECDSS)
 S (ECLOC,ECSCRN)=0,(ECCAT,ECPROC)=""
 ;
 ;- Get EC Screen IEN
 F  S ECLOC=$O(^ECJ("AP",ECLOC)) Q:'ECLOC  D
 . F  S ECCAT=$O(^ECJ("AP",ECLOC,ECDSS,ECCAT)) Q:ECCAT=""  D
 .. F  S ECPROC=$O(^ECJ("AP",ECLOC,ECDSS,ECCAT,ECPROC)) Q:ECPROC=""  D
 ... S ECSCRN=+$O(^ECJ("AP",ECLOC,ECDSS,ECCAT,ECPROC,0))
 ...;
 ...;- If inactive date exists, delete it
 ... I $P($G(^ECJ(ECSCRN,0)),"^",2)'="" D
 .... L +^ECJ(ECSCRN):5 Q:'$T
 .... S DIE="^ECJ("
 .... S DA=ECSCRN
 .... S DR="1////@"
 .... D ^DIE
 .... K DA,DIE,DR
 .... L -^ECJ(ECSCRN)
ACTSCRQ Q
 ;
 ;
HELP ;
 W !!,"Enter <RET> if you wish to continue with this option, or YES to make ",!,"additions or deletions to the list.  Enter ^ to quit the option.",!!,"Press <RET> to continue  " R X:DTIME Q
 Q
