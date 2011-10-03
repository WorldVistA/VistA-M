SRHLSCRN ;B'HAM ISC/DLR - Surgery Interface Menu to initial field settings ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 N CNT,CNT1,OUT,SRA,SRX,SRY,SROBR,SROBX
 S (CNT,SRX)=0 F  S SRX=$O(^SRO(133.2,SRX)) Q:'SRX  I $D(^SRO(133.2,SRX,2,0)) S CNT=CNT+1,CNT(CNT)=SRX D
 .S (CNT1,SRY)=0 F  S SRY=$O(^SRO(133.2,SRX,2,SRY)) Q:'SRY  S CNT1=CNT1+1,CNT(CNT,CNT1)=SRY,CNT(CNT,0)=CNT1
 F  W @IOF S (OUT,SROBR)=0 S SROBR=$$HDR(SROBR) Q:$G(OUT)=1  D
 .I +SROBR>0&(+SROBR'>CNT) D OBR Q:$G(OUT)=1  F  W @IOF S SROBX=0 S OUT=0,SROBX=$$HDR1(SROBR,SROBX) Q:$G(OUT)=1  D:$D(CNT(SROBR,SROBX))
 ..D KDIR S DA=CNT(SROBR,SROBX),DIR("A")="Enter the new setting",DIR(0)="133.2,3" D ^DIR I $D(DIRUT) S OUT=1 Q
 ..I SRA'[Y,Y'="I" W !,"This setting does not correspond to the upper level setting.",!," Press <RETURN> to continue:" R X:DTIME Q
 ..S $P(^SRO(133.2,CNT(SROBR,SROBX),0),U,4)=Y I $D(^(1,0)) S X=0 F  S X=$O(^SRO(133.2,CNT(SROBR,SROBX),1,X)) Q:'X  S $P(^SRO(133.2,X,0),U,4)=Y
 W @IOF
EXIT D KDIR
 Q
HDR(SROBR) ;header for the OBR Menu
 N HDR,SRX
 S HDR="Surgery Interface Setup Menu" W ?((IOM-$L(HDR))/2),HDR
 W !!,"To change the setting in one of the following categories, enter the",!,"corresponding number.",!," (R - Receive)",!," (S - Send)",!," (S/R - Send and Receive)",!," (I - Ignore)"
 W !!
 S SRX=0 F  S SRX=$O(CNT(SRX)) Q:'SRX  W !,$J(SRX,3),".  ",$P(^SRO(133.2,CNT(SRX),0),U)," ",$S($P(^(0),U,4)'="":"("_$P(^(0),U,4)_")",1:"(I)")
 W ! D KDIR S DIR(0)="NO:1:CNT" D  D ^DIR S:$D(DIRUT) OUT=1 I '$D(DIRUT) S SROBR=Y
 .S DIR("?")="Enter the corresponding number of the category you wish to edit. To edit underlying fields, set the category to R for receive or S to send."
 .S DIR("?",1)="The categories above refer to VISTA Surgery data fields.  Below are examples:"
 .S DIR("?",2)="OPERATION -> File 130 fields."
 .S DIR("?",3)="TOURNIQUET -> TIME TOURNIQUET APPLIED (#.48) and File 130.02 fields."
 .S DIR("?",4)="MONITOR -> MONITORS (#.293) and File 130.41 fields."
 .S DIR("?",5)="MEDICATION -> MEDICATIONS (#.375) and File 130.33 fields."
 .S DIR("?",6)="ANESTHESIA -> ANESTHESIA TECHNIQUE (#.37) and File 130.06 fields."
 Q SROBR
HDR1(SROBR,SROBX) ;header for the OBX Menu
 N HDR1,SRX
 S HDR1=$P(^SRO(133.2,CNT(SROBR),0),U)_" DATA" W ?((IOM-$L(HDR1))/2),HDR1
 W !!,"Toggle the current setting to (R)eceive, (S)end, or (I)gnore."
 W !
 S SRX=0 F  S SRX=$O(CNT(SROBR,SRX)) Q:SRX>(CNT(SROBR,0)\2+(CNT(SROBR,0)#2))!('SRX)  D
 .W !,$J(SRX,2),". ",$P(^SRO(133.2,CNT(SROBR,SRX),0),U)," ",$S($P(^(0),U,4)'="":"("_$P(^(0),U,4)_")",1:"(I)")
 .I $D(CNT(SROBR,SRX+(CNT(SROBR,0)\2+(CNT(SROBR,0)#2)))) D
 ..W ?40,$J(SRX+(CNT(SROBR,0)\2+(CNT(SROBR,0)#2)),2),". ",$P(^SRO(133.2,CNT(SROBR,SRX+(CNT(SROBR,0)\2+(CNT(SROBR,0)#2))),0),U)," ",$S($P(^(0),U,4)'="":"("_$P(^(0),U,4)_")",1:"(I)")
 W ! D KDIR S DIR(0)="NO:1:CNT(SROBR,0)",DIR("?")="To toggle the current setting of an item, enter its corresponding number." D SDIR D ^DIR S:$D(DIRUT) OUT=1 I '$D(DIRUT) S SROBX=Y
 Q SROBX
OBR ;
 N X,X1
 D KDIR S DIR("A")="Do you wish to change the current setting of "_$P(^SRO(133.2,CNT(SROBR),0),U),DIR(0)="133.2,3^O",DA=CNT(SROBR) D ^DIR I $D(DIRUT) S OUT=1
 S $P(^SRO(133.2,CNT(SROBR),0),U,4)=Y I $D(^SRO(133.2,CNT(SROBR),1,0)) S X=0 F  S X=$O(^SRO(133.2,CNT(SROBR),1,X)) Q:'X  S:Y'="S/R" $P(^SRO(133.2,X,0),U,4)=Y
 S SRA=Y I Y="S/R" K DA
 I SRA="S" D
 .I $D(^SRO(133.2,CNT(SROBR),1,0)) S X=0 F  S X=$O(^SRO(133.2,CNT(SROBR),1,X)) Q:'X  S:$P(^SRO(133.2,X,0),U,4)="R" $P(^SRO(133.2,X,0),U,4)="S"
 .I $D(^SRO(133.2,CNT(SROBR),2,0)) S X=0 F  S X=$O(^SRO(133.2,CNT(SROBR),2,X)) Q:'X  S:$P(^SRO(133.2,X,0),U,4)="R" $P(^(0),U,4)="S" I $D(^SRO(133.2,X,1,0)) S X1=0 F  S X1=$O(^SRO(133.2,X,1,X1)) Q:'X1  S $P(^SRO(133.2,X1,0),U,4)="S"
 I SRA="R" D
 .I $D(^SRO(133.2,CNT(SROBR),1,0)) S X=0 F  S X=$O(^SRO(133.2,CNT(SROBR),1,X)) Q:'X  S:$P(^SRO(133.2,X,0),U,4)="S" $P(^SRO(133.2,X,0),U,4)="R"
 .I $D(^SRO(133.2,CNT(SROBR),2,0)) S X=0 F  S X=$O(^SRO(133.2,CNT(SROBR),2,X)) Q:'X  S:$P(^SRO(133.2,X,0),U,4)="S" $P(^(0),U,4)="R" I $D(^SRO(133.2,X,1,0)) S X1=0 F  S X1=$O(^SRO(133.2,X,1,X1)) Q:'X1  S $P(^SRO(133.2,X1,0),U,4)="R"
 I $P(^SRO(133.2,CNT(SROBR),0),U,4)="I" S OUT=1
 Q
KDIR ;kills all DIR variables
 K DIR,DIRUT,DUOUT,DTOUT,DIROUT
 Q
SDIR ;sets the DIR help screen for the OBX identifiers
 S DIR("?",1)="These items correspond to fields in the VISTA Surgery package."
 I SROBR=1 D
 .S DIR("?",1)="The items above refer to VISTA Surgery package fields.  Below are examples:"
 .S DIR("?",2)="  HR -> End Pulse (#.84)"
 .S DIR("?",3)="  BP -> End BP    (#.85)"
 .S DIR("?",4)="  RR -> End Resp  (#.86)"
 Q
