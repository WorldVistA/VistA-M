IBDFPRG1 ;ALB/AAS - AICS PURGE UTILITY ; 4-OCT-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
% ; -- purge utility for purging entries from the
 ;    Form Definition file (357.95)
 ;    Form Tracking file (357.96)
 ;    Form Specification file (359.2)
 G MANUAL^IBDFPRG
 ;
 ;
PURGFD(IBLDT) ; -- Procedure
 ; -- purge entires in Form Definition file marked for deletion
 ;    that were marked before ibldt and no incomplete entries in
 ;    form tracking exist
 ;
 ;    Input :  ibldt  := only purge records with a date marked for
 ;                       deletion older than this date
 ;    Output:  ibcnt5 := number of entries in 357.95 deleted
 ;             ibcnt2 := number of entries in 359.2 deleted
 ;
 N IBI,IBJ,IBSTAT,X,Y
 S (IBCNT5,IBCNT2)=0
 I IBLDT=""!(IBLDT'?7N) G PURGFDQ
 S IBI=0
 F  S IBI=$O(^IBD(357.95,"ADEL",IBI)) Q:'IBI!(IBI'<IBLDT)  D
 .S IBJ=0
 .F  S IBJ=$O(^IBD(357.95,"ADEL",IBI,IBJ)) Q:'IBJ  D
 ..
 ..; -- "a" x-ref is special x-ref of all forms not received
 ..;  for 357.95 check KILLTYPE^IBDF19
 ..;
 ..I $D(^IBD(357.96,"A",IBJ)) Q
 ..I $D(^IBD(357.95,IBJ,0)) S X=$$DEL("^IBD(357.95,",IBJ),IBCNT5=IBCNT5+1
 ..I $D(^IBD(359.2,IBJ,0)) S X=$$DEL("^IBD(359.2,",IBJ),IBCNT2=IBCNT2+1
 ..Q
 .Q
 ;
PURGFDQ Q
 ;
PURGFT(IBLDT,IBHOW) ; -- Procedure
 ; -- purge entries from form tracking file (357.96)
 ;    Input :  ibldt  := only purge records with an appointment
 ;                       date older than this date
 ;             ibhow  := 0=no records, 1=complete, 2=all
 ;    Output:  ibcnt6 := number of entries in 357.96 deleted
 ;
 N X,Y,IBI,IBJ,IBSTAT
 S IBCNT6=0
 I IBLDT=""!(IBLDT'?7N) G PURGFTQ
 S IBHOW=+$G(IBHOW)
 I IBHOW<0!(IBHOW>2) G PURGFTQ
 ;
 S IBI=0
 F  S IBI=$O(^IBD(357.96,"D",IBI)) Q:'IBI!(IBI'<IBLDT)  D
 .S IBJ=0
 .F  S IBJ=$O(^IBD(357.96,"D",IBI,IBJ)) Q:'IBJ  D
 ..I $$STATCHK(IBJ,IBHOW) S X=$$DEL("^IBD(357.96,",IBJ),IBCNT6=IBCNT6+1
 ..Q
 .Q
PURGFTQ Q
 ;
PURGEL(IBLDT) ; -- 
 ; -- Purge AICS Error Log older created prior to ibdldt
 ;    Input :  ibldt  := only purge error created prior to this date
 ;
 ;    Output:  ibcnt7 := number of entries in 359.3 deleted
 ;
 N IBI,IBJ
 S (IBCNT7,IBI)=0
 F  S IBI=$O(^IBD(359.3,"B",IBI)) Q:'IBI!(IBI'<IBLDT)  D
 .S IBJ=0
 .F  S IBJ=$O(^IBD(359.3,"B",IBI,IBJ)) Q:'IBJ  D
 ..I $D(^IBD(359.3,IBJ,0)) S X=$$DEL("^IBD(359.3,",IBJ),IBCNT7=IBCNT7+1
PURGELQ Q
 ;
STATCHK(ENTRY,IBHOW) ; -- Function
 ; -- determine if entry in 357.96 can be deleted
 ;    Input :  Entry := internal number of entry in 357.96
 ;             ibhow := 0,1,2, to delete none, complete, or all
 ;    Output:  Okay  := 1=okay to delete, 0=not okay
 ;
 N OKAY,STATUS
 S OKAY=0
 S IBHOW=+$G(IBHOW)
 I IBHOW<1!(IBHOW>2) G STATQ ;How is none or not valid, don't delete
 I '$D(^IBD(357.96,ENTRY,0)) G STATQ ;Entry doesn't exist
 ;
 ; -- if delete all, okay=1
 I IBHOW=2,$P($G(^IBD(357.96,ENTRY,0)),"^",3) S OKAY=1 G STATQ
 ;
 ; -- if status = complete, piece 11 must equal 3, 4, or 12 to delete
 S STATUS=$P($G(^IBD(357.96,ENTRY,0)),"^",11)
 S OKAY=$S(STATUS=3:1,STATUS=4:1,STATUS=6:1,STATUS=7:1,STATUS=12:1,1:0)
 ;
STATQ Q OKAY
 ;
DEL(FILE,DA) ; -- Function
 ; -- delete one entry
 ;    Input :  File  := internal file number of file or global root
 ;             da    := internal number of entry, If more than DA
 ;                      needs to be defined then pass da array by
 ;                      reference
 ;    Output:  1 := succeded, 0 := failed
 ;
 N SUCCESS
 S SUCCESS=0
 I $G(FILE)=""!(+$G(DA)<1) G DELQ
 S DIK=FILE D ^DIK
 S SUCCESS=1
 W:'$D(ZTQUEUED) !,"Entry number "_DA_" in file "_DIK_" Deleted!"
DELQ Q SUCCESS
