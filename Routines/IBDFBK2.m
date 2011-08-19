IBDFBK2 ;ALB/AAS - AICS broker Utilities ;23-May-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
RECV(RESULT,IBD) ; -- called by broker
 ; -- receives raw data array from scanning workstation and returns
 ;    data may come in spurs, IBD("MOREDATA") = 1 if more data pending
 ;
 ;    errors, warnings, and expanded data.
 ;    Input : Result - (called by reference, see output)
 ;            IBD    - (called by reference) contains the raw
 ;                     data from the workstation (IBD(FD1) - IBD(FD9))
 ;                     IB("MOREDATA") - if more data pending.
 ;
 ;    Output: RESULT - a new array element (result(lcnt) will be
 ;                     created for each error, warning and
 ;                      data element received
 ;
 N I,J,X,Y,IBDATA,CNT,LCNT,IBDJ,INODE,ZTQUEUED,IOM,IBDF,PXCA,PXCAVSIT,ORVP,IBQUIT,SDFN,FORMID,DIE,DIC,DR,DA,DFN,D,D0,DA,DI,DK,DL,AUPNPAT,AUPNDOB,AUPNDOD,AUPNDAYS,AUPNSEX
 I $D(IBD)=0 S RESULT(1)="NO DATA RECEIVED" G RECVQ
 S ZTQUEUED="",IOM=80
 ;
 S I=""
 S IBDJ=$J
 I $D(IBTEST) S IBDJ=$G(IBD("IBDJ"))
 F  S I=$O(IBD(I)) Q:I=""  S ^TMP("IBD-SCAN-RAWDATA",IBDJ,I)=IBD(I)
 I $G(IBD("MOREDATA")) S RESULT(1)="PARTIAL DATA RECEIVED" G RECVQ
 ;
 S RESULT(1)="0^END OF DATA RECEIVED"
 ;
 ; -- parse strings
 ;    data on workstation is built into strings upto 120 characters
 ;    each data element delimited by a "~" and need to be parsed
 ;    into an array IBDATA() which is then parsed into the bubbles,
 ;    dynamic, and handprint arrays.  IBDATA() represents data as it
 ;    is received from the scanner.
 ;
 S CNT=0
 F I=1:1 S INODE="FD"_I S IBDATA=$G(^TMP("IBD-SCAN-RAWDATA",IBDJ,INODE)) Q:IBDATA=""  D
 . F J=1:1 S X=$P(IBDATA,"~",J) Q:X=""  S CNT=CNT+1,IBDF(CNT)=X
 ;
 S RESULT(1)="DATA PARSED INTO FIRST ARRAY"
 K IBD
 ;
 S RESULT(1)=$$PCE^IBDFBKR(.IBDF,.PXCA)
 I $D(PXCA("ERROR")) S RESULT(1)="9^DATA REJECTED BY PCE: Critical data missing or incorrect"
 I $D(PXCA("IBD-ABORT")) S RESULT(1)="9^DATA NOT SENT TO PCE"
 S LCNT=1
 ;
 ; -- Don't try to parse array if data isn't valid
 S IBQUIT=+RESULT(1),RESULT(1)=$P(RESULT(1),"^",2,99)
 G:(IBQUIT<8!(IBQUIT>10)) RECVQ
 D EW(.RESULT,.PXCA,.LCNT)
 ;
 ; -- create result array to pass back to workstation
 D LSTDATA^IBDFBK3(.RESULT,.PXCA,.LCNT)
 ;
 I '$D(IBTEST),'$G(IBD("MOREDATA")) K ^TMP("IBD-SCAN-RAWDATA",$J)
 ;remember to uncomment the line above - done 10/29/96 cmr
RECVQ I '$D(IBTEST) K PXCA,IBDF
 ;I IBQUIT<8
 Q
 ;
EW(RESULT,PXCA,LCNT,AICS) ;
 ; -- List Errors and Warning generated in PCE
 ;    Input : Result - (called by reference, see output)
 ;            PXCA   - (by referencethe array of data formated to
 ;                      the PCE device interface specification
 ;            lcnt   - (by reference) a counter for the result array
 ;    Output: RESULT - a new array element result(lcnt) will be
 ;                     created for each error and warning received
 ;
 N I,J,K,L,M,X,IBX
 F M="ERROR","WARNING","AICS ERROR" I $D(PXCA(M)) D
 .I $G(AICS),M="AICS ERROR" Q
 .S I=""  F  S I=$O(PXCA(M,I)) Q:I=""  S J="" F  S J=$O(PXCA(M,I,J)) Q:J=""  D
 ..S K="" F  S K=$O(PXCA(M,I,J,K)) Q:K=""  S L="" F  S L=$O(PXCA(M,I,J,K,L)) Q:L=""  S IBX=$G(PXCA(M,I,J,K,L)) D
 ...S X=M_": "_$P(IBX,"^")
 ...I $E(X,1,4)'="AICS" S X="PCE "_X
 ...I $P(IBX,"^",2)'="" S X=X_" - "_$P(IBX,"^",2)
 ...I $P(IBX,"^",3)'="" S X=X_" - "_$P(IBX,"^",3)
 ...I I="DIAGNOSIS/PROBLEM" S X=X_", ICD9: "_$P($G(^ICD9(+$G(PXCA(I,J,K)),0)),"^")_", "_$P($G(PXCA(I,J,K)),"^",13) I L=2,$P(PXCA(I,J,K),"^",2)="P" S $P(PXCA(I,J,K),"^",2)="S"
 ...I I="ENCOUNTER",L=15 S X=X_", "_$P($G(^VA(200,+$P($G(PXCA(I)),"^",4),0)),"^") I $P(PXCA(I),"^",15)="P" S $P(PXCA(I),"^",15)="S"
 ...D NEWLINE^IBDFBK3(.RESULT,X,.LCNT)
EWQ Q
 ;
UNRECV(FID) ; -- used by test to un received data when testing.
 ;
 N IBI
 I +$G(FID)<1 Q
 S IBI=0  F  S IBI=$O(^IBD(357.96,+FID,9,IBI)) Q:'IBI  I $G(^IBD(357.96,+FID,9,IBI,0))'="" S $P(^(0),"^",2)=""
 K ^IBD(357.96,+FID,10)
 Q
 ;
RECVERR(FORMID,ER) ; -- error occurred in ibdfbkr, store in 359.3
 Q:ER<11
 S DIALOG=$S(ER=11:3579610,ER=12:3579607,ER=13:3579607,ER=14:3579604,ER=15:3579606,ER=16:3579605,ER=17:3579608,ER=18:3579609,1:3570001)
 S FORMID=$G(FORMID("FORMID")),FORMID("SOURCE")=1
 S FORMID("APPT")=$P($G(^IBD(357.96,+$G(FORMID),0)),"^",3)
 D LOGERR^IBDF18E2(DIALOG,.FORMID)
 Q
 ;
TESTR ;
 S IBTEST="" K ALAN
 S IBD("MOREDATA")=0
 S IBD("IBDJ")=576718735
 S FORMID=+$P($G(^TMP("IBD-SCAN-RAWDATA",IBD("IBDJ"),"FD1")),"FORMID=",2)
 I +FORMID>0 D UNRECV(FORMID)
 D RECV(.ALAN,.IBD)
 W !! X "ZW ALAN W !! ZW PXCA"
 K IBTEST
 Q
