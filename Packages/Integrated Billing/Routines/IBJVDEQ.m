IBJVDEQ ;DAOU/ALA - CBO Data Extract Queue Trigger ;02-JUL-03
 ;;2.0;INTEGRATED BILLING;**233,301**;21-MAR-94
 ;
 ;**Program Description**
 ;  This program will log a record who meets the
 ;  selection criteria for the VISTA Data Extract
 ;
BC ;  Triggers from the Bill/Claims File (#399)
 ;  Called from the STATUS DATE field (#.14)
 ;  Variable D0 is the internal bill# passed in by FileMan
 ;
 NEW DFN
 ;
 ; Filter (Auth DT must exist)
 S RDATES=$G(^DGCR(399,D0,"S"))
 I $P(RDATES,U,10)="" Q
 ;
 ;  Get the bill number
 S RCBILL=$P($G(^DGCR(399,D0,0)),U,1)
 ;  Use PRCA(430,"D",bill number to get 430 IEN
 S RCXVBLN=$O(^PRCA(430,"D",RCBILL,""))
 I RCXVBLN="" Q
 ;
 S DFN=$P(^DGCR(399,D0,0),U,2)
 ;  Retrieve all for every new bill authorized in IB
 D FIL("D")
 ;
 K RCBILL,RCXVBLN,RDATES
 Q
 ;
FIL(RCXVBTY) ;  File the record into the AR Data Queue File (#348.4)
 ;
 ;  If a test system has 'turned off' extract, quit
 I '$$GET1^DIQ(342,"1,",20.04,"I") Q
 ;
 ;  Input Parameter
 ;    RCXVBTY = Batch Type (H=Historical, D=Daily, C=Current Fiscal Year, A=Active)
 ;    RCXVBLN = Bill IEN
 ;
 NEW FDA,RCXVCURB,RCVXBNM,RCVXBMX
 ; 
 ; Where there has been any update/change to the system 
 ; for a particular bill for the previous days business (T-1). 
 ;
 ; Get current batch
BTC K ^TMP("RCXVA",$J)
 D FIND^DIC(348.4,"","","P",DT,"","C","I $P(^(0),U,4)=RCXVBTY","","^TMP(""RCXVA"",$J)")
 S RCXVCURB=$P(^TMP("RCXVA",$J,"DILIST",0),U,1)
 S RCVXCTY="",RCXVBDT="",RCXQFL=0
 ;
 ;  If there is no batch for today, create a new batch
 I RCXVCURB=0 D NBT G CON:'RCXQFL,BTC
 ;
 ; Check to see if batch is full.
 S RCXVCURB=$P(^TMP("RCXVA",$J,"DILIST",RCXVCURB,0),U,1)
 I RCXVCURB'=0 D
 . S RCVXBNM=$P($G(^RCXV(RCXVCURB,0)),U,7) ; Number of record in batch
 . S RCVXCTY=$P($G(^RCXV(RCXVCURB,0)),U,4) ; Current batch type
 . S RCXVBDT=$P($G(^RCXV(RCXVCURB,0)),U,2) ; Batch Date
 . S RCXVBST=$P($G(^RCXV(RCXVCURB,0)),U,3) ; Batch Status
 S RCVXBMX=$P($G(^RC(342,1,20)),U,5) ; Max. # of record per batch
 ;  OR if the number of records in batch exceeds the
 ;  maximum number of records per batch --> create new batch
 I (RCVXBNM>RCVXBMX)!(RCVXBNM=RCVXBMX)!(RCXVBST="T") D NBT G BTC:RCXQFL
 ;
CON ;  Continue with updating the AR Data Queue file
 S RCXVDA=$S($G(RCXVCURB)'=0:RCXVCURB,1:RCXVDA)
 ;
 I $D(^RCXV(RCXVDA,1,RCXVBLN)) Q
 ;
 ; File record
 NEW DIC,DIE,X,DA,DLAYGO,Y,DINUM,DO
 S DA(1)=RCXVDA,DIC="^RCXV("_DA(1)_",1,",DIE=DIC,(X,DINUM)=RCXVBLN
 S DLAYGO=348.41,DIC(0)="L",DIC("P")=DLAYGO
 I '$D(^RCXV(DA(1),1,0)) S ^RCXV(DA(1),1,0)="^348.41^^"
 D FILE^DICN
 ;
 S RCUPD(348.4,RCXVDA_",",.07)=(RCVXBNM+1)
 S RCUPD(348.41,RCXVBLN_","_RCXVDA_",",.02)=DFN
 D FILE^DIE("","RCUPD","RCERROR")
 ;
 K RCXVDA,RCVXBNM,RCXVBLN,RCXVCURB,RCXVBTY,RCVXBMX,RCVXCTY,RCXVBDT
 K ^TMP("RCXVA",$J),IENARRAY,RCXVBST,DINUM,ERROR,RCUPD,RCXQFL
 Q
 ;
NBT ;  Create a new batch
 N $ES,$ET
 S $ET="D ER^IBJVDEQ"
 L +^RCXVLK:1 E  S RCXQFL=1 Q
 S RCXVCURB=$P(^RCXV(0),U,3)+1
 S RCVXBNM=0
 S FDA(348.4,"+1,",.01)=RCXVCURB
 S FDA(348.4,"+1,",.02)=DT
 S FDA(348.4,"+1,",.03)="P"
 S FDA(348.4,"+1,",.04)=RCXVBTY
 S FDA(348.4,"+1,",.07)=RCVXBNM
 D UPDATE^DIE("","FDA","IENARRAY","ERROR")
 I '$D(ERROR) S RCXVDA=$G(IENARRAY(1))
 L -^RCXVLK
 Q
 ;
ER ; Unlock and log error
 L -^RCXVLK
 D ^%ZTER
 D UNWIND^%ZTER
 Q
