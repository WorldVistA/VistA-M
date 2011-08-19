RMPOPST0 ;EDS/JAM - HOME OXYGEN BILLING TRANSACTIONS/POSTING,Part 1 ;7/24/98
 ;;3.0;PROSTHETICS;**29,44,47,55**;Feb 09, 1996
 ;
 ;This subroutine is part of the billing module.  Patient records are
 ;sorted by fund control point (FCP) and then posted to a 1358 service
 ;order or Purchase Card order. It calls IFCAP modules to post
 ; transactions.
 Q
 ;
POST ;main module to post billing transactions to IFCAP
 N SITE,RVDT,VDR,FIL K ^TMP($J)
 S FIL=665.72,SITE=RMPOXITE,RVDT=RMPODATE,VDR=RMPOVDR,QUIT=0
 ;
 ; P55 see if user wants to post $0 amounts to 2319 or ignore them
 K DIR
 S RMPRPZAM=$$ANY2319()
 I RMPRPZAM="^" W !!,"Posting Cancelled..." D EXIT Q
 ;
 D BUILD
 ;I $O(IFCAP(""))="" W !!,"Nothing to Post..." Q
 I $O(^TMP($J,""))="" W !!,"Nothing to Post..." Q
 ;
 ;Give user last chance to cancell posting
 W !
 K DIR S DIR(0)="Y",DIR("A")="Are you Sure you Want to Post Transactions"
 S DIR("B")="NO",DIR("?")="NO to Cancel Posting or YES to Proceed"
 W ! D ^DIR
 I Y'=1!($D(DIRUT)) W !!,"Posting Cancelled..." D EXIT Q
 K DIR
 D PROCESS
 ;
EXIT D CLEANUP
 K ^TMP($J),VADM,A,Y,DIRUT,QUIT
 Q  ;EXIT
 ;
 ; p55 - prompt if user wants option to post $0 to 2319
 ;     - returns
 ;       0 if user doesn't want 'the post to 2319' prompt
 ;       "^" on 'time out' or '^'
 ;       1 if user wants prompting 
ANY2319() ;
 N DIR,X,Y,RMPRPAM0
 S RMPRPAM0=0
 W !
 S DIR(0)="Y"
 S DIR("A",1)="If any transactions with $0.00 amounts exist, do you want "
 S DIR("A")="to be able to post any of them to the 2319"
 S DIR("B")="NO"
 S DIR("?")="Enter 'Y' to be prompted to create a 2319 record at each $0 tranasction."
 S DIR("?",1)="If you don't want ANY $0 transactions to be posted to the 2319"
 S DIR("?",2)="then enter 'N'"
 D ^DIR
 S RMPRPAM0=$S(Y=1:1,Y=0:0,1:"^")
 W !
 Q RMPRPAM0
 ;
BUILD ;Build array IFCAP with patient transactions to post
 ;Separate patient individual items by fund control point
 ;^TMP($J) array
 ;   ^TMP($J,FCP)=FCP total^Post flag^error message^purchase card total
 ;   ^TMP($J,FCP,DFN)=patient tot^pat last name_" "_4 digit SSN^post flag^
 ;                  IFCAP error message^pat name
 ;  ^TMP($J,FCP,DFN,ITEM)=item tot
 N DFN,ITM,ITDT,ITNO,PATNAM,PATSSN,LNAM,PATFLG,ITSTR,FCP,LCK,ITOT
 S DFN="" F  S DFN=$O(DFNS(DFN)) Q:DFN=""  D
 . S PATFLG=^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,0)
 . ;check patient accept flag
 . I $P(PATFLG,U,2)'="Y" Q
 . ;check patient post flag
 . I $P(PATFLG,U,3)="Y" Q
 . D DEM^VADPT S PATNAM=VADM(1),PATSSN=VA("BID") ;patient name & ssn
 . ;lock patient record
 . S LCK=$$PATLCK() I 'LCK W !,PATNAM," record locked by another user" Q
 . ;get items not posted for each patient
 . S ITM=0
 . F  S ITM=$O(^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,1,ITM)) Q:'ITM  D
 . . S ITDT=^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,1,ITM,0)
 . . K R2319F
 . . ;check if item posted
 . . I $P(ITDT,U,10)="Y" Q
 . . S ITNO=$P(ITDT,U),FCP=$P(ITDT,U,3),ITOT=$P(ITDT,U,6)
 . .; I ITOT'>0 Q  ;no amount to post
 . . I ITOT'>0 D
 . . .S RMITEM=$P($G(^RMPR(661,ITNO,0)),U,1)
 . . .I RMPRPZAM D
 . . . .W !,"*** Patient: ",$E(PATNAM,1,7)," - Line Item: ",$P($G(^PRC(441,RMITEM,0)),U,2)," has a ZERO DOLLAR amount ***"
 . . . .S DIR("??")="This is a required field, you must enter Y/N"
 . . . .S DIR(0)="Y",DIR("A")="Would You like to Post to 2319 (Y/N) "
 . . . .F  D ^DIR I Y=1!(Y=0) S R2319F=Y K DIR Q
 . . .E  D
 . . . .S R2319F=0
 . . .I $D(R2319F),(R2319F=0) D
 . . . .K DIE,DA,DR S DA(4)=RMPOXITE,DA(3)=RMPODATE,DA(2)=RMPOVDR
 . . . .S DA(1)=DFN,DIK="^RMPO(665.72,"_DA(4)_",1,"_DA(3)_",1,"_DA(2)_",""V"","_DA(1)
 . . . .S DIK=DIK_",1,",DA=ITM D ^DIK K DIK,DA
 . . . .S RNEXITEM=$O(^RMPO(665.72,RMPOXITE,1,RMPODATE,1,RMPOVDR,"V",DFN,1,0))
 . . . .I 'RNEXITEM S DA(3)=RMPOXITE,DA(2)=RMPODATE,DA(1)=RMPOVDR,DA=DFN D
 . . . . .S DIK="^RMPO(665.72,"_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",""V""," D ^DIK K DIK,DA
 . . I $D(R2319F),(R2319F=0) Q
 . . I FCP="" Q  ;no fund control point
 . . ;set ^TMP($J) array
 . . S ^TMP($J,FCP)=$S('$D(^TMP($J,FCP)):0.00,1:^TMP($J,FCP))+ITOT
 . . I $G(^TMP($J,FCP,DFN))="" D
 . . . S LNAM=$E($P(PATNAM,",")_"       ",1,7) ;pad/truncate last name
 . . . S ^TMP($J,FCP,DFN)="^"_LNAM_" "_PATSSN_"^^^"_$E(PATNAM,1,18)
 . . S $P(^TMP($J,FCP,DFN),U)=+^TMP($J,FCP,DFN)+ITOT,^TMP($J,FCP,DFN,ITM)=ITOT
 . D UNLKPAT
 Q  ;BUILD
 ;
PROCESS ;process FCP data - ask for method of payment
 N FCP,PAYINF,FCPTOT,IEN442,SRVORD,PCTOT,IENFCP,LCK
 S FCP="" F  S FCP=$O(^TMP($J,FCP)) Q:FCP=""  D  I QUIT Q
 . ;PAYINF=payment type^IEN of file 442^service order number^purchase 
 . ;card total^IEN of fund control point transaction
 . S FCPTOT=+^TMP($J,FCP) W !!,"Fund Control Point: ",FCP
 . S PAYINF=$$FCP^RMPOBILU(FCP)
 . I PAYINF="" S $P(^TMP($J,FCP),U,3)="Posting aborted"
 . Q:QUIT!(PAYINF="")  I PAYINF=-1 D  Q
 . . S $P(^TMP($J,FCP),U,2)=0,$P(^TMP($J,FCP),U,3)="Payment type not given"
 . . ;W "  ",$P^TMP($J,FCP),U,3)
 . S IEN442=$P(PAYINF,U,2),SRVORD=$P(PAYINF,U,3)
 . S PCTOT=$P(PAYINF,U,4),IENFCP=$P(PAYINF,U,5)
 . ;W !,"Service Order Number: ",SRVORD
 . ;check lock on FCP
 . S LCK=$$FCPLCK() I 'LCK D  Q
 . . S $P(^TMP($J,FCP),U,2)=0,$P(^TMP($J,FCP),U,3)="Locked by another user"
 . . W "  ",$P(^TMP($J,FCP),U,3)
 . D IFCAP^RMPOPST1  ;process payment to IFCAP
 . D UNLKFCP  ;unlock FCP level
 Q  ;PROCESS
 ;
PATLCK() ;Lock patient level in ^RMPO(665.72
 L +^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,0):5
 Q $T   ;PATLCK
 ;
FCPLCK() ;Lock fund control level in ^RPO(665.72
 L +^RMPO(FIL,SITE,1,RVDT,2,IENFCP,0):5
 Q $T  ;FCPLCK
 ;
UNLKPAT ;Unlock patient level in ^RMPO(665.72
 L -^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,0)
 Q  ;UNLKPAT
 ;
UNLKFCP ;Unlock fund contrl point level in ^RMPO(665.72
 L -^RMPO(FIL,SITE,1,RVDT,2,IENFCP,0)
 Q  ;UNLKFCP
 ;
CLEANUP ;Display post messages for FCP
 ;Call line tag to unlock ^RMPO at patient level
 N DFN,UNLCK,FLG
 S FCP="",FLG=1
 F  S FCP=$O(^TMP($J,FCP)) Q:FCP=""  D
 . I '$P(^TMP($J,FCP),U,2) D
 . . I FLG W !!,"FCP Not Posted",?40,"Message" D
 . . . W !,"---------------",?40,"-------"
 . . W !,FCP,?40,$P(^TMP($J,FCP),U,3) S FLG=0
 . S DFN="" F DFN=$O(^TMP($J,FCP,DFN)) Q:DFN=""  D
 . . I '$D(UNLCK(DFN)) D UNLKPAT S UNLCK(DFN)=""
 W !! I FLG W "All Fund Control Points posted successfully"
 K DIR S DIR(0)="FO",DIR("A")="Press any Key to Continue" D ^DIR
 Q  ;CLEANUP
