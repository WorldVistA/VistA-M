PRPFIPST  ; ;1/7/98  12:34 PM
 ;CTB/WASH-ISC@ALTOONA  PATIENT FUNDS XREF CONVERSION  ;1/6/98  4:33 PM
V ;;3.0;PATIENT FUNDS;**6,7**;JUNE 1, 1989
 ;LOOP THROUGH 470 GET POINTER
 ;DISPLAY FILE 16 AND FILE 200 VALUE
 ;SELECT NUMBER IN FILE 16 LINE WHICH ARE WRONG
 ;PROCESS CHANGES
 N %DT,CONVDATE,UNINSTAL,%A,%B,%,DA,Y
 S %DT("A")="Select Date of Installation of Patch PRPF*3*6: ",%DT="AE",DT("?")="Enter the date the Data Dictionaries for Patch PRPF*3*6 were installed. " D ^%DT
 QUIT:Y<0
 S CONVDATE=+Y
 S UNINSTAL=0
 S %=1,%A="Do you wish to prepare an UNINSTALL File",%B="An UNINSTALL file will permit you to reverse this action." D ^PRPFYN Q:%<1
 I %=1 S UNINSTAL=1
 W !! S %A="OK TO BEGIN",%=2,%B="" D ^PRPFYN
 I %'=1 W !!,"NO ACTION TAKEN" Q
 K ^TMP("PRPF UNINSTALL")
 S DA=0 F  S DA=$O(^PRPF(470,DA)) Q:'DA  D
 . N OLDDA,NEWDA,RDATE
 . S X=$G(^PRPF(470,DA,0))
 . S RDATE=+$P(X,"^",12) I RDATE>CONVDATE QUIT
 . S OLDDA=$P(X,"^",13)  Q:OLDDA=""
 . S NEWDA=$G(^DIC(16,OLDDA,"A3")) Q:NEWDA=""
 . S $P(^PRPF(470,DA,0),"^",13)=NEWDA I UNINSTAL=1 S ^TMP("PRPF UNINSTALL",DA)=OLDDA W "."
 . QUIT
 W !,"DONE.  " I UNINSTAL,$D(^TMP("PRPF UNINSTALL")) W "UNINSTALL OPTION AVAILABLE." W !!
 Q
UNINSTAL ;
 N %A,%B,%,DA
 I '$D(^TMP("PRPF UNINSTALL")) W !,*7,"No Uninstall file available" QUIT
 S %=1,%A="This option will reverse the Provider Conversion for Patient Funds Patch PRPF*3*7",%A(1)="OK TO CONTINUE",%B="" D ^PRPFYN
 I %'=1 W !,"NO ACTION TAKEN" QUIT
 S DA=0 F  S DA=$O(^TMP("PRPF UNINSTALL",DA)) Q:'DA  S $P(^PRPF(470,DA,0),"^",13)=^TMP("PRPF UNINSTALL",DA) K ^TMP("PRPF UNINSTALL",DA)
 W !,"UNINSTALL COMPLETED"
 QUIT
REMOVE ;
 N %A,%B,%
 I '$D(^TMP("PRPF UNINSTALL")) W !,*7,"No Uninstall file available to remove." QUIT
 S %=1,%A="This option will remove the ^TMP("_""""_"PRPF UNINSTALL"_""""_")) global.",%A(1)="Removal will prevent recovery of original, pre-conversion data.",%A(2)="MAKE SURE YOU HAVE VERIFIED THE CONVERSION."
 S %A(3)="",%A(4)="OK TO CONTINUE",%B="" D ^PRPFYN
 I %'=1 W !,"NO ACTION TAKEN" QUIT
 K ^TMP("PRPF UNINSTALL")
 W !!,"UNINSTALL FILE REMOVED"
 QUIT
