SRHLDW ;B'HAM ISC/DLR - Surgery Interface Master File Update Menu for set of Codes ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 N C,CNT,OUT,RNG,SR,SRA,SRTBL,SRX,SRXX,SRY,Y
 S (CNT,SRX)=0 F  S SRX=$O(^SRO(133.2,SRX)) Q:'SRX  I $D(^SRO(133.2,SRX,2,0)) D
 .S SRY=0 F  S SRY=$O(^SRO(133.2,SRX,2,SRY)) Q:'SRY  S SR=^SRO(133.2,SRY,0) I $P(SR,U,6)="CE" S Y="",C=$P(^DD($P(SR,U,2),$P(SR,U,3),0),U,2) I C'["P" D Y^DIQ S:'$D(SRA(SRY)) CNT=CNT+1,CNT(CNT)=SRY I '$D(SRA(SRY)) S SRA(SRY)=1
 F  W @IOF S (OUT,SRTBL)=0 D HDR Q:$G(OUT)=1  S RNG=Y F SRXX=1:1:$L(RNG,",")-1 S SRTBL=$P(RNG,",",SRXX) D SET
 W @IOF
EXIT D KDIR
 Q
HDR ;header for the Table Menu
 N HDR,SRX
 S HDR="Surgery Interface Table Setup Menu" W ?((IOM-$L(HDR))/2),HDR
 W !!,"This option allows the users to populate table files on the Automated",!,"Anesthesia Information System."
 W !!
 S SRX=0 F  S SRX=$O(CNT(SRX)) Q:SRX>(CNT\2+(CNT#2))!('SRX)  D
 .W !,$J(SRX,2),". ",$P(^SRO(133.2,CNT(SRX),0),U)
 .I $D(CNT(SRX+(CNT\2+(CNT#2)))) D
 ..W ?40,$J(SRX+(CNT\2+(CNT#2)),2),". ",$P(^SRO(133.2,CNT(SRX+(CNT\2+(CNT#2))),0),U)
 W ! D KDIR S DIR(0)="LO^1:"_CNT D  D ^DIR S:$D(DIRUT) OUT=1 I '$D(DIRUT) S SRTBL=Y
 .S DIR("?")="This option sends a message to the Automated Anesthesia Information System (AAIS) informing the system to replace its current field setting with the current VISTA field setting."
 Q
SET ;SRTBL - HL7 table    FEC - file-level event code (MFE-3)  REC - Record-level event code (MFI-1)  SRENT - surgery file entry (not used for set of codes)
 N FEC,REC,SRENT
 S DIR(0)="YO",DIR("A")="Update the "_$P(^SRO(133.2,CNT(SRTBL),0),U)_" table",DIR("B")="YES" D ^DIR Q:Y'=1
 S SRENT="",SRTBL=^SRO(133.2,CNT(SRTBL),0),FEC="REP",REC="MAD" D MSG^SRHLMFN(SRTBL,FEC,REC,SRENT)
 Q
KDIR ;kills all DIR variables
 K DIR,DIRUT,DUOUT,DTOUT,DIROUT
 Q
