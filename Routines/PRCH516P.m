PRCH516P ;WOIFO/CR-VENDOR LOOKUP AND CONVERSION ;1/08/01 9:36 AM
 ;;5.1;IFCAP;**16**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 W !!,?10,"Illegal entry point...terminating",$C(7)
 Q
A1 ;
 ; This routine is used by patch PRC*5.1*16 to complete a conversion of
 ; vendors, file #440, and to update the socioeconomic groups in
 ; the CODE INDEX file #420.6.
 ;
 W !,?10,">>>>>>  VENDOR CONVERSION - FILE #440  <<<<<<"
 W !!,?10,">>>>>> CODE INDEX UPDATE - FILE #420.6 <<<<<<"
 W !!,?5,"This program will gather all the vendors from the VENDOR file"
 W !,?5,"(#440) with the socioeconomic group codes 'Q' and 'R' to"
 W !,?5,"perform the following:"
 W !
 W !,?5,"The code 'Q' will be deleted and the code 'S'"
 W !,?5,"will be added to the vendor if it does not have it."
 W !
 W !,?5,"The code 'R' will be replaced by the new code 'RV' and the"
 W !,?5,"code 'S' will be added to the vendor if it does not have it."
 W !
 W !,?5,"The codes 'Q' and 'R' in the CODE INDEX file (#420.6)"
 W !,?5,"will be deactivated as part of this patch.",!
 W !,?5,"PLEASE OBTAIN A PRINTOUT OF ALL THE VENDORS BEFORE AND"
 W !,?5,"AFTER THE CONVERSION AND SAVE BOTH FOR FUTURE REFERENCE."
 ;
 K ^TMP($J,"PRCH516P")
 S CONV=0
 I $D(^TMP($J,"PRCH516P")) G START
 E  D START1 I '$D(^TMP($J,"PRCH516P")) D  Q
 . W !!,?5,"NO RECORDS FOUND...TERMINATING.",$C(7) D EXIT
START ;
 W !!,?5,"Searching for all the eligible vendors, please wait..." H 2
 W !!,?5,"...list completed and ready to be printed!!!",!,$C(7)
 W !,?5,"(Enter '^' at the DEVICE prompt to quit.)",!!
 I $D(^TMP($J,"PRCH516P"))&($G(CONV)=0) D A4 Q:POP
 W !
 S %A="Continue with the conversion",%B="",%=2
 D ^PRCFYN G:%=2 EXIT
 W !! S:%=1 CONV=1
 Q:$G(CONV)'=1
 ;
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTDESC="VENDOR LOOKUP FOR CONVERSION - PATCH PRC*5.1*16",ZTRTN="A2^PRCH516P",ZTSAVE("^TMP($J,")="",ZTSAVE("CONV")="" D ^%ZTLOAD,HOME^%ZIS,EXIT Q
 D A2,EXIT,^%ZISC
 Q
 ;
START1 S X="" F  S X=$O(^PRC(440,X)) Q:X=""  S Z11=$G(^PRC(440,X,1.1,0)),CNTR=$P(Z11,"^",4) I CNTR>0 D
 .S SEG="" F  S SEG=$O(^PRC(440,X,1.1,SEG)) Q:SEG=""  S:$G(SEG)=158 $P(^TMP($J,"PRCH516P",X),"^",1)=SEG S:$G(SEG)=159 $P(^TMP($J,"PRCH516P",X),"^",2)=SEG
 .S CNTR=$G(CNTR)-1
 .Q:CNTR=0
 Q
 ;
EXIT K CNTR,CONV,COUNT,EX,I,J,N,P,PRCINDX,SEG,TDATE,X,XXZ,Y,Z11,^TMP($J,"PRCH516P")
 Q
 ;
A2 ;Convert the vendor with intenal code 'Q'=158 to code 'S'=162 if code
 ;'S' is not present. If code 'S' is present, just delete code 'Q' and
 ;update the multiple header.
 ;
 S J="" F  S J=$O(^TMP($J,"PRCH516P",J)) Q:J=""!(J'>0)  D:$P($G(^TMP($J,"PRCH516P",J)),"^",1)=158
 .S PRCINDX=$P(^PRC(440,J,1.1,0),"^",4)
 .I PRCINDX>0 D
 ..K ^PRC(440,J,1.1,158,0) S $P(^PRC(440,J,1.1,0),"^",4)=$P(^PRC(440,J,1.1,0),"^",4)-1
 ..I '$D(^PRC(440,J,1.1,162,0)) S $P(^PRC(440,J,1.1,162,0),"^",1)="162",$P(^PRC(440,J,1.1,0),"^",3)="162",$P(^PRC(440,J,1.1,0),"^",4)=$P(^PRC(440,J,1.1,0),"^",4)+1
 ..I $D(^PRC(440,J,1.1,162,0)) S $P(^PRC(440,J,1.1,0),"^",3)="162"
 ;
 ;Convert any vendor with code 'R'=159 to code 'RV'=167.
 S J="" F  S J=$O(^TMP($J,"PRCH516P",J)) Q:J=""!(J'>0)  D:$P($G(^TMP($J,"PRCH516P",J)),"^",2)=159
 .S PRCINDX=$P(^PRC(440,J,1.1,0),"^",4)
 .I PRCINDX>0 D
 ..K ^PRC(440,J,1.1,159,0) S $P(^PRC(440,J,1.1,0),"^",4)=$P(^PRC(440,J,1.1,0),"^",4)-1
 ..;If code 'S' is not present, add it and update multiple header.
 ..I '$D(^PRC(440,J,1.1,162,0)) S $P(^PRC(440,J,1.1,162,0),"^",1)="162",$P(^PRC(440,J,1.1,0),"^",3)="162",$P(^PRC(440,J,1.1,0),"^",4)=$P(^PRC(440,J,1.1,0),"^",4)+1
 ..S $P(^PRC(440,J,1.1,0),"^",3)="167"
 ..S $P(^PRC(440,J,1.1,167,0),"^",1)="167",$P(^PRC(440,J,1.1,0),"^",4)=$P(^PRC(440,J,1.1,0),"^",4)+1
 D A3
 Q
 ;
A3 ;Get a record of vendors before and after conversion.
 U IO
 D NOW^%DTC S Y=% D DD^%DT S TDATE=Y
 S (EX,P)=1,COUNT=0
 I '$D(^TMP($J,"PRCH516P")) S P=1 D HEADER W !!!!!!,?10,"*** NO RECORDS TO PRINT ***" Q
 ;
 S J="" F  S J=$O(^TMP($J,"PRCH516P",J)) Q:EX="^"  Q:J=""!(J'>0)  D
 .D:P=1 HEADER
 .S PRCINDX=$P(^PRC(440,J,1.1,0),"^",4) I PRCINDX>0 D
 ..W ?2,J,?15,$P(^PRC(440,J,0),"^",1)
 ..S N="" F  S N=$O(^PRC(440,J,1.1,N)) Q:N=""  W:N>0 ?60,$P(^PRCD(420.6,N,0),"^",1),"  "
 ..W !
 ..I (IOSL-$Y)<6 D HOLD Q:EX="^"
 .S COUNT=COUNT+1
 W !!,?5,"Found "_COUNT_" entries."
 Q
 ;
HOLD ;
 G HEADER:$P(IOST,"-")="P" W !,"Press return to continue, '^' to exit:" R XXZ:DTIME S:XXZ="^" EX="^" S:'$T EX="^" D:EX'["^" HEADER
 Q
HEADER ;
 W @IOF
 W !,"LIST OF VENDORS FOR PATCH PRC*5.1*16",?42,TDATE,?70,"PAGE ",P
 W:$G(CONV)=1 !,"(AFTER CONVERSION)",!
 W:$G(CONV)=0 !,"(BEFORE CONVERSION)",!
 F I=1:1:8 W "----------"
 W !,?2,"VENDOR ID",?15,"VENDOR NAME",?60,"VENDOR CODES",!!
 S P=P+1
 Q
 ;
A4 ;Allow the user to get a printout before conversion.
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTDESC="VENDOR LOOKUP FOR CONVERSION - PATCH PRC*5.1*16",ZTRTN="A3^PRCH516P",ZTSAVE("^TMP($J,")="",ZTSAVE("CONV")="" D ^%ZTLOAD,HOME^%ZIS Q
 D A3,^%ZISC
 Q
 ;
PRE ;Delete all the entries in file #420.6.
 ;This entry point is invoked from KIDS for installation of PRC*5.1*16 
 ;and should not be used directly.
 K ^PRCD(420.6)
 Q
