LA7ADLS ;DALISC/JMC - Select Accessions for Auto Downloading ; 3/7/95 0:900;
 ;;5.2;LAB MESSAGING;**23,27**;Sep 27, 1994
 ;
EN ; Select Accessions to resend.
 I '$D(^LAB(62.4,"AE")) D  G EXIT
 . W !,$C(7),"No instruments currently flagged for automatic downloading."
 . W !,"Use build and download a load/worklist options to download."
 . S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR
 D EXIT ; Housekeeping before we start.
 S (LA7CNT,LA7QUIT)=0
 S DIR(0)="SO^1:Range of Accessions;2:Selected Accessions",DIR("A")="Selection Method",DIR("B")=1
 D ^DIR
 I $D(DIRUT) G EXIT
 S LA7TYPE=+Y
 S LRACC=1,LREXMPT=1 ; Set flags used by LRWU4.
 I LA7TYPE=1 D
 . D ^LRWU4 ; Get list of accession numbers.
 . I LRAN<1 S LA7QUIT=1 Q  ; User aborted selection.
 . S FIRST=LRAN,X=$O(^LRO(68,LRAA,1,LRAD,1,":"),-1)
 . W !
 . S DIR(0)="NO^"_LRAN_":"_X_":0",DIR("A")="Download from "_LRAN_" to",DIR("B")=LRAN
 . D ^DIR K DIR
 . I $D(DIRUT) S LA7QUIT=1 Q
 . S LRAN=FIRST-1,LAST=Y
 . F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:'LRAN!(LRAN>LAST)  D
 . . W:$X>(IOM-1) ! W "." ; Let user know we're looking.
 . . D SETTMP
 I LA7TYPE=2 F  D  Q:LA7QUIT!(LRAN<1)
 . D ^LRWU4
 . I $D(DTOUT)!($D(DUOUT)) S LA7QUIT=1 Q
 . I LRAN<1 S:'$D(^TMP($J)) LA7QUIT=1 Q
 . D SETTMP
 I LA7QUIT D EXIT Q
 I '$D(^TMP($J)) D  G EXIT
 . W $C(7),!!,"No accessions found to download"
 . S DIR(0)="E" D ^DIR
 W !!,"Found ",LA7CNT," accessions that can be downloaded."
 S DIR(0)="YO",DIR("A")="Ready to download",DIR("B")="NO" D ^DIR
 I Y'=1 G EXIT ; User aborted retransmission.
 W !
 S LA7CNT=0,LA7UID=""
 F  S LA7UID=$O(^TMP($J,LA7UID)) Q:LA7UID=""  D
 . D EN^LA7ADL(LA7UID) S LA7CNT=LA7CNT+1
 . W:$X>(IOM-1) ! W "." ; Let user know we're looking.
 W !!,"Done - ",LA7CNT," accession",$S(LA7CNT>1:"s",1:"")," scheduled for downloading!",!!
 D EXIT
 Q
 ;
SETTMP ; Setup TMP global with accession to download.
 S LA7UID=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),U)
 I $L(LA7UID) S LA7CNT=LA7CNT+1,^TMP($J,LA7UID)=""
 Q
 ;
EXIT ; Housekeeping - clean up.
 K ^TMP($J)
 K LA7CNT,LA7QUIT,LA7TYPE,LA7UID,FIRST,LAST
 K LRAA,LRACC,LRAD,LRAN,LREXMPT,LRIDIV,LRX
 K %DT,DA,DIC,DIR,DIRUT,DTOUT,DUOUT,X,Y
 Q
