RCXVDEQ ;DAOU/ALA-AR Data Extract Queue Trigger ;02-JUL-03
 ;;4.5;Accounts Receivable;**201,228,240,243,232**;Mar 20, 1995
 ;*****240 change in this routine for test sites only****
 ;
 ;**Program Description**
 ;  This program will log a record who meets the
 ;  selection criteria for the VISTA Data Extract
 ;
AR ;  Triggers from the Accounts Receivable File (#430)
 NEW DFN
 ;
 S RCXVBLN=D0,RCXVSTAT=$P(^PRCA(430,D0,0),U,8)
 I '+$P(^PRCA(430.3,RCXVSTAT,0),U,6) Q
 ;
 S DFN=$P(^PRCA(430,D0,0),U,7)
 D FIL("D")
 ;
 K RCXVBLN,RCXVSTAT
 Q
 ;
AT ;  Triggers from the Accounts Receivable Transactions (#433)
 NEW DFN
 ;
 S RCXVBLN=$P($G(^PRCA(433,D0,0)),U,2)
 I RCXVBLN="" Q
 S RCXVTYP=$P($G(^PRCA(433,D0,1)),U,2)
 I RCXVTYP="" Q
 ;
 I '+$P(^PRCA(430.3,RCXVTYP,0),U,6) Q
 ;
 S DFN=$P(^PRCA(430,RCXVBLN,0),U,7)
 D FIL("D")
 ;
 K RCXVBLN,RCXVTYP
 Q
 ;
FIL(RCXVBTY) ;  File the record into the AR Data Queue File (#348.4)
 ;
 ;  If a test system has 'turned off' extract, quit
 I '$$GET1^DIQ(342,"1,",20.04,"I") Q
 ;
 ;  Input Parameter
 ;    RCXVBTY = Batch Type (H=Historical, D=Daily, C=Current Fiscal Year, A=Active,E=FY05 DATA,I=CoPay Patient Data)
 ;    RCXVBLN = Bill IEN
 ;
 N FDA,RCXVCURB,RCVXBNM,RCVXBMX
 ; 
 ; Where there has been any update/change to the system 
 ; for a particular bill for the previous days business business (T-1). 
 ;
 ; Get current batch
BTC K ^TMP("RCXVA",$J)
 D FIND^DIC(348.4,"","","P",DT,"","C","I $P(^(0),U,4)=RCXVBTY","","^TMP(""RCXVA"",$J)")
 S RCXVCURB=+$P($G(^TMP("RCXVA",$J,"DILIST",0)),U,1)
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
 ;  change in line below for patch 240
 I (RCVXBNM>RCVXBMX)!(RCVXBNM=RCVXBMX)!(RCXVBST="T")!(RCXVBST="C") D NBT G BTC:RCXQFL=1
 ;
CON ;  Continue with updating the AR Data Queue file
 S RCXVDA=$S($G(RCXVCURB)'=0:RCXVCURB,1:RCXVDA)
 ;
 ;  If the Batch Type is 'R', quit
 I RCXVBTY="R"!(RCXVBTY="I") Q
 ;
 ;  If this bill number already exists in this batch, quit
 I $D(^RCXV(RCXVDA,1,RCXVBLN)) Q
 ;
 ; File record
 NEW DIC,DIE,X,DA,DLAYGO,Y,DINUM
 S DA(1)=RCXVDA,DIC="^RCXV("_DA(1)_",1,",DIE=DIC,(X,DINUM)=RCXVBLN
 S DLAYGO=348.41,DIC(0)="L",DIC("P")=DLAYGO
 I '$D(^RCXV(DA(1),1,0)) S ^RCXV(DA(1),1,0)="^348.41^^"
 K DO D FILE^DICN K DO
 ;
 S RCUPD(348.4,RCXVDA_",",.07)=(RCVXBNM+1)
 S RCUPD(348.41,RCXVBLN_","_RCXVDA_",",.02)=$G(DFN)
 D FILE^DIE("","RCUPD","RCXVERR")
 ;
 K RCXVDA,RCVXBNM,RCXVBLN,RCXVCURB,RCXVBTY,RCVXBMX,RCVXCTY,RCXVBDT
 K ^TMP("RCXVA",$J),IENARRAY,RCXVBST,RCUPD,RCXVERR,RCXQFL
 Q
 ;
NBT ;  Create a new batch
 N $ES,$ET
 S $ET="D ER^RCXVDEQ"
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
UDR ;  Update Deposits/Receipts subfile
 ; If this batch payment number already exists in this batch, quit
 I $D(^RCXV(RCXVDA,2,RCXVD0)) Q
 ;
 ; File record
 NEW DIC,DIE,X,DA,DLAYGO,Y,DINUM
 S DA(1)=RCXVDA,DIC="^RCXV("_DA(1)_",2,",DIE=DIC,(X,DINUM)=RCXVD0
 S DLAYGO=348.42,DIC(0)="L",DIC("P")=DLAYGO
 I '$D(^RCXV(DA(1),2,0)) S ^RCXV(DA(1),2,0)="^348.42^^"
 K DO D FILE^DICN K DO
 ;
 S RCUPD(348.4,RCXVDA_",",.07)=RCXVRNUM
 D FILE^DIE("","RCUPD","RCXVERR")
 K RCXVERR,RCUPD
 Q
 ;
ER ; Unlock and log error
 L -^RCXVLK
 D ^%ZTER
 D UNWIND^%ZTER
 Q
