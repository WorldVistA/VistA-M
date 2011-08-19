IBDFPRG ;ALB/AAS - AICS PURGE UTILITY ; 4-OCT-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
% ; -- purge utility for purging entries from the
 ;    Form Definition file (357.95)
 ;    Form Tracking file (357.96)
 ;    Form Specification file (359.2)
 ;    AICS Error Log file (359.3)
 ;
MANUAL ; -- Option to purge records, ask input
 N IBCNT2,IBCNT5,IBCNT6,IBCNT7,IBD,IBHOW,IBLDT,IBDAYS,IBPURGE,IBQUIT,DIR,DIRUT,DUOUT,X,Y,IBLOG,D0,DA,D,ZTSK
 I '$D(DT) D DT^DICRW
 ;
 S IBQUIT=0
 D ASK
 Q:IBQUIT
 S IBLDT=$$FMADD^XLFDT(DT,-IBDAYS)
 S ZTSAVE("IB*")="",ZTRTN="DQ^IBDFPRG",ZTDESC="IBD - Manual Purge of form tracking",ZTIO="" D ^%ZTLOAD
 W !,$S($D(ZTSK):"Request Queued Task="_ZTSK,1:"Request Canceled") D HOME^%ZIS S IBQUIT=1 Q
 Q
 ;
DQ ; -- entry point from manual task
 S IBLOG=$$ADD
 I IBPURGE("FT") D PURGFT^IBDFPRG1(IBLDT,IBHOW),PURGEL^IBDFPRG1(IBLDT)
 I IBPURGE("FD") D PURGFD^IBDFPRG1(IBLDT)
 D OUTPUT
 G EXIT
 Q
 ;
EXIT ; -- exit for all modes
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
AUTO ; -- Background option to automatically purge records
 N X,Y,IBCNT2,IBCNT5,IBCNT6,IBCNT7,IBLDT,IBHOW,IBD,IBLOG,D0,DA,D
 I '$D(DT) D DT^DICRW
 ; 
 ; -- if parameters not defined don't run
 I $P($G(^IBD(357.09,1,0)),"^",3)=""!($P($G(^IBD(357.09,1,0)),"^",2)="")  G AUTOQ
 S IBHOW=$P($G(^IBD(357.09,1,0)),"^",2)
 ;
 ; -- Compute last date to purge records
 S IBLDT=$$FMADD^XLFDT(DT,-$P($G(^IBD(357.09,1,0)),"^",3))
 S IBLOG=$$ADD
 ;
 ; -- purge all entries in form tracking according to parameters
 D PURGFT^IBDFPRG1(IBLDT,+$P($G(^IBD(357.09,1,0)),"^",2))
 ;
 ; -- purge form definition entries only if marked for deletion 
 ;    and all entries are complete
 D PURGFD^IBDFPRG1(IBLDT)
 ;
 ; -- purge entries from AICS ERROR LOG (359.3)
 D PURGEL^IBDFPRG1(IBLDT)
 ;
 D OUTPUT
 G EXIT
 ;
AUTOQ Q
 ;
ADD() ; -- add new entry to purge log
 N DIC,DLAYGO
 S Y=-1
 I $G(^IBD(357.08,0))'="" S X=$$NOW^XLFDT,DIC="^IBD(357.08,",DIC(0)="L",DLAYGO=357.08 D FILE^DICN
ADDQ Q +Y
 ;
EDIT ; -- update entry after running
 N DIC,DIE,DA,DR,X,Y
 I IBLOG<1!($G(^IBD(357.08,+IBLOG,0))="") Q
 S DIE="^IBD(357.08,",DA=IBLOG
 S DR=".02////"_$G(IBHOW)_";.03////"_$G(IBLDT)_";.04////"_$G(IBCNT6)_";.05////"_$G(IBCNT5)_";.06////"_$G(IBCNT2)_";.07////"_$G(IBCNT7)
 D ^DIE
 Q
 ;
OUTPUT ; -- output results of purge
 ;
 S IBD(1)="Purge of Form Tracking Statistics"
 S IBD(2)="Status of Form Tracking Entries Purged .......... "_$S(+$G(IBHOW)=0:"None",$G(IBHOW)=1:"Completed",$G(IBHOW)=2:"All",1:"None")
 S IBD(3)="Form Tracking entries purged upto ............... "_$$FMTE^XLFDT($G(IBLDT))
 S IBD(4)="Number of Form tracking Entries Deleted ......... "_$G(IBCNT6)
 S IBD(5)="Number of Form Definition Entries Deleted ....... "_$G(IBCNT5)
 S IBD(6)="Number of Form Specification Entries Deleted .... "_$G(IBCNT2)
 S IBD(7)="Number of AICS Error Log Entries Deleted ........ "_$G(IBCNT7)
 D EDIT,SEND
 ;
 I '$D(ZTQUEUED) S X="" F  S X=$O(IBD(X)) Q:'X  W !,IBD(X)
 Q
 ;
ASK ; -- ask what to purge
 ;    Output : ibpurge("ft") := 1=yes purge form tracking, 0=no
 ;             ibpurge("fd") := 1=yes purge form definition, 0=no
 ;
 N DIR
 S IBPURGE("FD")=0,IBPURGE("FT")=0
 ;
 S DIR(0)="Y"
 S DIR("?")="Answer YES if you want to purge Form Tracking of unneeded records"
 W !!!,"Do you want to purge Form Tracking?"
 D ^DIR
 I $D(DIRUT) S IBQUIT=1 Q
 S IBPURGE("FT")=+Y
 ;
 K DIR
 S DIR(0)="Y"
 S DIR("?")="Answer YES if you want to purge Form Defintions of unneeded records"
 W !!,"Do you want to purge Form Definitions and Form Specifications?"
 D ^DIR
 I $D(DIRUT) S IBQUIT=1 Q
 S IBPURGE("FD")=+Y
 ;
 ; -- if the user wants to purge form tracking get needed parms
 I IBPURGE("FT")!(IBPURGE("FD")) D ASKN,ASKH
 I 'IBPURGE("FT"),'IBPURGE("FD") S IBQUIT=1
 Q
 ;
ASKN ; -- ask number of days to retain
 ;    Output : IBDAYS := number of days to retain
 ;
 N DIR
 S IBDAYS=-1
 S DIR(0)="N^60:999:0"
 S DIR("A")="Number of Days to Retain"
 S DIR("B")=+$P($G(^IBD(357.09,1,0)),"^",3)
 S DIR("?")="Enter the number of days of form tracking data to retain"
 D ^DIR
 I $D(DIRUT) S IBQUIT=1 Q
 S IBDAYS=+Y
 Q
 ;
ASKH ; -- ask how to purge
 ;    Output : IBHOW  := 0=none, 1=complete, 2=all
 ;
 N DIR
 S IBHOW=-1
 S DIR(0)="S^0:None;1:Purge Completed Entries;2:Purge All Entries"
 S DIR("A")="Purge what Entries"
 S DIR("B")=+$P($G(^IBD(357.09,1,0)),"^",2)
 S DIR("?")="Choose whether you want to purge only completed entries or whether to purge all entries"
 D ^DIR
 I $D(DIRUT) S IBQUIT=1 Q
 S IBHOW=+Y
 Q
 ;
SEND ; -- send mail message to group if defined
 N IBDGRP,XMDUZ,XMTEXT,XMY,XMSUB,XMZ
 S XMDUZ="AICS PACKAGE",XMTEXT="IBD(",XMSUB="AICS PURGE RESULTS"
 K XMY S XMN=0
 S IBDGRP=$$GET1^DIQ(3.8,+$P($G(^IBD(357.09,1,1)),"^"),.01)
 ;S IBDGRP=$P($G(^XMB(3.8,+$P($G(^IBD(357.09,1,1)),"^"),0)),"^")
 Q:IBDGRP=""
 S XMY("G."_IBDGRP_"@"_^XMB("NETNAME"))=""
 D ^XMD
 Q
