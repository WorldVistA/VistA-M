SRHLDW1 ;B'HAM ISC/DLR - Surgery Interface Master File Update Menu for Files ; [ 06/11/98  6:17 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 N CNT,OUT,SRTYP
 ;Interface Files (1st 3 letter must be unique for the TMP global)
 S CNT(1)="CPT4^81"
 S CNT(2)="ICD9^80"
 S CNT(3)="MEDICATION^50"
 S CNT(4)="MONITOR^133.4"
 S CNT(5)="PERSONNEL^200"
 S CNT(6)="REPLACEMENT FLUID^133.7"
 S CNT(7)="ANES SUPERVISE CODE^132.95"
 S CNT(8)="LOCATION^44"
 F  W @IOF S (OUT,SRTYP)=0 D HDR Q:$G(OUT)=1  D ASK
 W @IOF
END D KDIR Q
HDR ;header for the OBR Menu
 N HDR,SRX,C
 S HDR="Surgery Interface File Download Option" W ?((IOM-$L(HDR))/2),HDR,!!
 S SRX=0 F  S SRX=$O(CNT(SRX)) Q:'SRX  S C=$G(C)+1 W !,SRX,".  ",$P(CNT(SRX),"^")
 W ! D KDIR S DIR(0)="NO^1:"_C,DIR("A")="Enter file to Capture",DIR("?")="Enter the files corresponding number" D ^DIR S:$D(DIRUT) OUT=1 I '$D(DIRUT) D KDIR S SRTYP=Y
 Q
ASK ;
 N G
 S DIR(0)="YO",DIR("B")="YES",DIR("A")="Update the "_$P(CNT(SRTYP),U)_" file",DIR("B")="YES" D ^DIR I $D(DIRUT)!(Y=0) S OUT=1 Q
 I $P(CNT(SRTYP),U)="CPT4" W !,"NOT AVAILABLE" Q
 W !,"Queuing message" S ZTDTH=$H,ZTIO="",ZTDESC=$P(CNT(SRTYP),U)_" Master File Update.",ZTRTN="ENQ^SRHLDW1"
 F G="SRTYP","CNT("_SRTYP_")" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD
 Q
ENQ ;
 N FEC,REC,SRENT,SRTBL
 S SRENT="",FEC="REP",REC="MAD",SRTBL=CNT(SRTYP)
 ;cpt4,icd9,medication,monitor,personnel,replacement fluid,anes super code,location
 D MSG^SRHLMFN(SRTBL,FEC,REC,SRENT)
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
KDIR ;kills all DIR variables
 K DIR,DIRUT,DUOUT,DTOUT,DIROUT
 Q
