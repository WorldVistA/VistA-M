RMPOPS23 ;HIN/RVD - HOME OXYGEN BILLING - POST TO 2319 ;5/18/99
 ;;3.0;PROSTHETICS;**29,44,41,110**;Feb 09, 1996;Build 10
 ;
 ;This routine will only post records already been posted in IFCAP.
 ;Patient records are sorted by fund control point (FCP), DFN and
 ;then post to 2319.
 Q
 ;
POST ;main module to post billing transactions to 2319
 D HOME^%ZIS S QUIT=0
 D HOSITE^RMPOUTL0 Q:('$D(RMPOXITE))!QUIT
 D MONTH^RMPOBIL0() Q:$D(RMPODATE)=0!QUIT
 D VENDOR^RMPOBIL0() Q:$D(RMPOVDR)=0!QUIT
 S FIL=665.72,SITE=RMPOXITE,RVDT=RMPODATE,VDR=RMPOVDR,QUIT=0
 W !,"Processing..." D BUILD
 I $O(^TMP($J,""))="" W !,"Everything posted okay!!" G EXIT
 S FCP="" F  S FCP=$O(^TMP($J,FCP)) Q:FCP=""  F DFN=0:0 S DFN=$O(^TMP($J,FCP,DFN)) Q:DFN'>0  D F660
 ;K DIR S DIR(0)="FO",DIR("A")="Press any Key to Continue" D ^DIR
 ;
EXIT ;
 K ^TMP($J)
 ;K DFN,ITM,ITDT,ITNO,PATNAM,PATSSN,LNAM,PATFLG,ITSTR,FCP,LCK,ITOT
 N RMPRSITE,RMPR D KILL^XUSCLEAN
 Q
 ;
BUILD ;Build array IFCAP with patient transactions to post
 ;Separate patient individual items by fund control point
 ;tMP($J) array
 ;   ^TMP($J,FCP)=FCP total^Post flag^error message^purchase card total
 ;   ^TMP($J,FCP,DFN)=patient tot^pat last name_" "_4 digit SSN^post flag^
 ;                  IFCAP error message^pat name
 ;   ^TMP($J,FCP,DFN,ITEM)=item tot
 K ^TMP($J)
 S DFN=0 F  S DFN=$O(^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN)) Q:DFN'>0  D
 . S PATFLG=^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,0)
 . ;check patient post flag
 . Q:$P(PATFLG,U,3)'="Y"
 . D DEM^VADPT S PATNAM=VADM(1),PATSSN=VA("BID") ;patient name & ssn
 . ;lock patient record
 . S LCK=$$PATLCK() I 'LCK W !,PATNAM," record locked by another user" Q
 . ;get items not posted for each patient
 . S ITM=0
 . F  S ITM=$O(^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,1,ITM)) Q:'ITM  D
 . . S ITDT=^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,1,ITM,0)
 . . ;check if item posted
 . . Q:$P(ITDT,U,10)'="Y"
 . . Q:$P(ITDT,U,16)>0
 . . S ITNO=$P(ITDT,U),FCP=$P(ITDT,U,3),ITOT=$P(ITDT,U,6)
 . . I ITOT'>0 Q  ;no amount to post
 . . I FCP="" Q  ;no fund control point
 . . ;set ^TMP($J) array
 . . S ^TMP($J,FCP)=$S('$D(^TMP($J,FCP)):0.00,1:^TMP($J,FCP))+ITOT
 . . I $G(^TMP($J,FCP,DFN))="" D
 . . . S LNAM=$E($P(PATNAM,",")_"       ",1,7)
 . . . S ^TMP($J,FCP,DFN)="^"_LNAM_" "_PATSSN_"^^^"_$E(PATNAM,1,18)
 . . S $P(^TMP($J,FCP,DFN),U)=+^TMP($J,FCP,DFN)+ITOT,^TMP($J,FCP,DFN,ITM)=ITOT
 . D UNLKPAT
 Q
 ;
F660 ;Post to file ^RMPR(660 for form 2319
 S D665A=$G(^RMPR(665,DFN,"RMPOA")) I D665A="" Q
 D  ;AMIS grouper number
 . L +^RMPR(669.9,RMPOXITE,0):9999 I $T=0 S RMPOG=DT_$P(DT,2,3) Q
 . S RMPOG=$P(^RMPR(669.9,RMPOXITE,0),U,7),RMPOG=RMPOG-1
 . S $P(^RMPR(669.9,RMPOXITE,0),U,7)=RMPOG
 . L -^RMPR(669.9,RMPOXITE,0)
 S TRXDT=$P(^RMPO(665.72,RMPOXITE,1,RMPODATE,1,RMPOVDR,0),U,2)
 S RFCPIEN=$O(^RMPO(665.72,1,1,RMPODATE,2,"B",FCP,0))
 S SRVORD=$P(^RMPO(665.72,RMPOXITE,1,RMPODATE,2,RFCPIEN,0),U,4)
 S PAYINF=$P(^RMPO(665.72,RMPOXITE,1,RMPODATE,2,RFCPIEN,0),U,2)
 S ITM=0 F  S ITM=$O(^TMP($J,FCP,DFN,ITM)) Q:ITM'>0  D
 . S ITMD=$G(^RMPO(665.72,RMPOXITE,1,RMPODATE,1,RMPOVDR,"V",DFN,1,ITM,0))
 . S RMITEM=$P(ITMD,U,1)
 . I $G(RMITEM),$D(^RMPR(661,RMITEM,0)) S RITIEN=$P(^RMPR(661,RMITEM,0),U,1)
 . I ITMD="" Q
 . I $P(ITMD,U,6)'>0 Q       ;nothing posted to IFCAP
 . S RMCPHC=$P(ITMD,U,2),RMCPT="",RMCPRENT=$P(ITMD,U,18),RMCPSO="C"
 . S RMCPTY=$P(ITMD,U,14),RMCPQH=$P(ITMD,U,19)
 . S RMCPT1=$G(^RMPR(661.1,RMCPHC,4))
 . I RMCPT1["RP",((RMCPTY="R")!(RMCPTY="X")) S RMCPT=RMCPT_"RP,"
 . I RMCPT1["QH",($G(RMCPQH)) S RMCPT=RMCPT_"QH,"
 . I (RMCPRENT=1),(RMCPT1["RR") S RMCPT=RMCPT_"RR,"
 . I RMCPT1["NU",(RMCPT'["RR") S RMCPT=RMCPT_"NU,"
 . I $L(RMCPT)>2 S RMCLEN=$L(RMCPT),RMCPT=$E(RMCPT,1,RMCLEN-1)
 . S DIC="^RMPR(660,",DIC(0)="L",X=DT
 . K DD,DO D FILE^DICN I +Y<0 Q
 . S D6I=+Y,D6X=D6I_","
 . K DIE,DA,DR S DA(4)=RMPOXITE,DA(3)=RMPODATE,DA(2)=RMPOVDR,DA(1)=DFN
 . S DIE="^RMPO(665.72,"_DA(4)_",1,"_DA(3)_",1,"_DA(2)_",""V"","_DA(1)
 . S DIE=DIE_",1,",DA=ITM,DR="15////^S X=D6I" D ^DIE
 . S D660(660,D6X,.02)=DFN                 ;Patient name pointer
 . S D660(660,D6X,1)=TRXDT                 ;Request date
 . S D660(660,D6X,2)=$P(ITMD,U,14)         ;Type of transaction
 . S D660(660,D6X,4)=$P(ITMD,U)            ;item
 . S D660(660,D6X,4.1)=$P(^RMPR(661.1,$P(ITMD,U,2),0),U,4) ;HCPCS
 . S D660(660,D6X,4.5)=$P(ITMD,U,2)        ;PSAS HCPCS
 . S D660(660,D6X,4.7)=RMCPT               ;RMCPT
 . S D660(660,D6X,5)=$P(ITMD,U,7)          ;quantity
 . S D660(660,D6X,7)=RMPOVDR               ;vendor
 . S D660(660,D6X,8)=RMPO("STA")           ;station
 . S D660(660,D6X,10)=DT                   ;Delivery date
 . I $P(PAYINF,U) S D660(660,D6X,11)=9
 . I $P(PAYINF,U)="P" S D660(660,D6X,11)=14
 . S D660(660,D6X,23)=SRVORD               ;IFCAP transaction number
 . S D660(660,D6X,12)="C"                  ;Source
 . S D660(660,D6X,14)=$P(ITMD,U,6)         ;total cost
 . S D660(660,D6X,16)=$P(ITMD,U,4)         ;remarks
 . S SUSDES=$S($P(ITMD,U,11)'="":"Suspended Amt "_$P(ITMD,U,11)_" ",1:"")
 . S D660(660,D6X,24)=SUSDES_$P(ITMD,U,12) ;description
 . S D660(660,D6X,27)=DUZ                  ;initator
 . S D660(660,D6X,62)=$P(D665A,U)          ;patient category
 . S D660(660,D6X,63)=$P(D665A,U,5)        ;special category
 . S D660(660,D6X,68)=RMPOG
 . S D660(660,D6X,78)=$P(ITMD,U,15)        ;unit of issue
 . D FILE^DIE("K","D660","ERR")
 . I $D(ERR) D
 . . W !!,"Posting to 2319 for item ",ITM," patient ",DFN," failed."
 . . W "Posting will be done later"
 . I '$D(ERR),$D(^DPT(DFN,0)),$D(^PRC(441,RITIEN,0)) D
 . . W !,"Patient: ",$P(^DPT(DFN,0),U,1)," Item: ",ITM," posted to 2319."
 K DIC,X,Y
 Q
 ;
PATLCK() ;Lock patient level in ^RMPO(665.72
 L +^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,0):5
 Q $T
 ;
UNLKPAT ;Unlock patient level in ^RMPO(665.72
 L -^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,0)
 Q
 ;
QUIT() S QUIT=$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q QUIT
