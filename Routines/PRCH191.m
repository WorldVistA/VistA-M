PRCH191 ;WISC/DJM Display MIN/MAX report ; 11/4/99 2:35pm
 ;;5.0;IFCAP;**191**;4/21/95
 ; This report will list all records that have a limit set to
 ; zero (0). In file 441, Sub-File VENDOR, for fields 8 and 8.5.
 ;
 ; The second part of the report will list all records that have a
 ; limit set to zero (0). In file 442, Sub-File ITEM, for field 9.6.
 ;
START N PRCX,PRCY,PTR,MIN,MAX,TEST,AA,BB,CC,EE,MSG,DATA,STA0,STA1
 ;
 ; Clean up and set up.
 ;
 S PRCX=0
 K ^TMP("DJM",$J)
 F  S PRCX=$O(^PRC(441,PRCX))  Q:PRCX'>0  D
 .  S PRCY=0
 .  F  S PRCY=$O(^PRC(441,PRCX,2,PRCY)) Q:PRCY'>0  D
 .  .  S PTR=$G(^PRC(441,PRCX,2,PRCY,0))
 .  .  Q:PTR=""
 .  .  S (MIN,MAX)=""
 .  .  S:$P(PTR,"^",12)=0 MIN="X"
 .  .  S:$P(PTR,"^",9)=0 MAX="X"
 .  .  I (MIN="")&(MAX="") Q
 .  .  S ^TMP("DJM",$J,PRCX,PRCY)=MIN_"^"_MAX
 .  .  Q
 .  Q
 S (TEST,DATA)=$D(^TMP("DJM",$J))
 G:TEST=0 NEXT
 ;
 ; Now display the records in file 441 that need to be changed.
 ;
441 ; Display entries that need correcting in file 441.
 ;
 K MSG
 S MSG(1)="         FILE 441"
 S MSG(2)="  "
 S MSG(3)="An X will show records with a value of 0 in the MINIMUM"
 S MSG(4)="ORDER QTY (MIN) column or the MAXIMUM ORDER QTY (MAX)"
 S MSG(5)="column.  This patch changes both fields to accept "
 S MSG(6)=".01--999999 as input."
 S MSG(7)="  "
 S MSG(8)="Use the 'Item File Edit' option to change records with"
 S MSG(9)="field values out of range. Or set them to null/blank."
 S MSG(10)="Enter the IMF IEN column value (110) to select"
 S MSG(11)="the record to change.  At the 'Select VENDOR:'"
 S MSG(12)="prompt enter the VENDOR IEN"
 S MSG(13)="column value (36300) to select the proper vendor"
 S MSG(14)="containing the fields to edit."
 S MSG(15)="  "
 D MES^XPDUTL(.MSG)
 K MSG
 S MSG(1)="IMF      VENDOR"
 S MSG(2)="IEN      IEN       MIN       MAX"
 S MSG(3)="---      ------    ---       ---"
 D MES^XPDUTL(.MSG)
 S PRCX=0
 F  S PRCX=$O(^TMP("DJM",$J,PRCX)) Q:PRCX'>0  D
 .  S PRCY=0
 .  F  S PRCY=$O(^TMP("DJM",$J,PRCX,PRCY)) Q:PRCY'>0  D
 .  .  S PTR=$G(^TMP("DJM",$J,PRCX,PRCY))
 .  .  S AA=PRCX_"          "
 .  .  S AA=$E(AA,1,9)
 .  .  S BB=PRCY_"          "
 .  .  S BB=$E(BB,1,10)
 .  .  S CC=$P(PTR,"^")_"          "
 .  .  S CC=$E(CC,1,10)
 .  .  S EE=$P(PTR,"^",2)
 .  .  K MSG
 .  .  S MSG(1)="  "
 .  .  S MSG(2)=AA_BB_CC_EE
 .  .  D MES^XPDUTL(.MSG)
 .  .  Q
 .  Q
 K MSG
 S MSG(1)="  "
 S MSG(2)="  "
 D MES^XPDUTL(.MSG)
 K MSG
 ;
NEXT ; Now to see if there are any records in file 442 that need to be
 ; corrected.
 ;
 S PRCX=0
 K ^TMP("DJM",$J)
 F  S PRCX=$O(^PRC(442,PRCX)) Q:PRCX'>0  D
 .  S PRCY=0,(STA0,STA1)=""
 .  F  S PRCY=$O(^PRC(442,PRCX,2,PRCY)) Q:PRCY'>0  D
 .  .  S PTR=$G(^PRC(442,PRCX,2,PRCY,0))
 .  .  Q:PTR=""
 .  .  S MAX=""
 .  .  S:$P(PTR,"^",14)=0 MAX="X"
 .  .  Q:MAX=""
 .  .  S STA0=$P($G(^PRC(442,PRCX,7)),"^",1)
 .  .  S STA1=$P($G(^PRCD(442.3,STA0,0)),"^",1)
 .  .  S MAX=MAX_"     "_STA1
 .  .  S ^TMP("DJM",$J,PRCX,PRCY)=MAX
 .  .  Q
 .  Q
 S (TEST,DATA)=$D(^TMP("DJM",$J))
 ;
 ; See if there is any data from file 441 or file 442.
 ;
 G:(TEST=0)&(DATA=0) EXIT
 ;
 ; There must be some data from file 441.  DATA is not 0.
 ;
 G:TEST=0 FINAL
 ;
442 ; Now display the records in file 442 that need to be changed.
 ;
 K MSG
 S MSG(1)="         FILE 442"
 S MSG(2)="  "
 S MSG(3)="An X will show records with a value of 0 in the MAXIMUM"
 S MSG(4)="ORDER QTY (MAX) column.  This patch changes the field"
 S MSG(5)="to accept only .01--999999 as input."
 S MSG(6)="  "
 S MSG(7)="Use the 'Edit an Incomplete Purchase Order' option"
 S MSG(8)="to change records with the field value out of range."
 S MSG(9)="Or set them to null/blank. Please note, only P.O.s"
 S MSG(10)="that have not been signed can be edited with this"
 S MSG(11)="option."
 S MSG(12)="  "
 S MSG(13)="Enter the P.O. NAME column value (688-A90002) to"
 S MSG(14)="select the record to change.  At the 'Select LINE ITEM"
 S MSG(15)="NUMBER:' prompt enter ` plus the ITEM IEN column value"
 S MSG(16)="(`1) to select the proper line item containing the"
 S MSG(17)="field to edit."
 S MSG(18)="  "
 D MES^XPDUTL(.MSG)
 K MSG
 S MSG(1)="P.O.     P.O.           ITEM            SUPPLY"
 S MSG(2)="IEN      NAME           IEN       MAX   STATUS"
 S MSG(3)="----     ----           ----      ---   ------"
 D MES^XPDUTL(.MSG)
 S PRCX=0
 F  S PRCX=$O(^TMP("DJM",$J,PRCX)) Q:PRCX'>0  D
 .  S PRCY=0
 .  F  S PRCY=$O(^TMP("DJM",$J,PRCX,PRCY)) Q:PRCY'>0  D
 .  .  S PTR=$G(^TMP("DJM",$J,PRCX,PRCY))
 .  .  S AA=PRCX_"          "
 .  .  S AA=$E(AA,1,9)
 .  .  S BB=$P($G(^PRC(442,PRCX,0)),U,1)_"          "
 .  .  S BB=$E(BB,1,15)
 .  .  S CC=PRCY_"          "
 .  .  S CC=$E(CC,1,10)
 .  .  K MSG
 .  .  S MSG(1)="  "
 .  .  S MSG(2)=AA_BB_CC_PTR
 .  .  D MES^XPDUTL(.MSG)
 .  .  Q
 .  Q
 ;
FINAL ; Now display the final message.  What to do with this report.
 ;
 K MSG
 S MSG(1)="  "
 S MSG(2)="  "
 S MSG(3)="This report identified records that have a field(s) that"
 S MSG(4)="are no longer within the input transform range of"
 S MSG(5)=".01--999999."
 S MSG(6)="Please contact appropriate personnel for any corrections."
 S MSG(7)="  "
 D MES^XPDUTL(.MSG)
 ;
EXIT K ^TMP("DJM",$J),STA0,STA1
 Q
