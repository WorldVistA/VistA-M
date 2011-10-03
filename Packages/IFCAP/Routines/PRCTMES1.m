PRCTMES1 ;WISC@ALTOONA/RGY-MESSAGE TEXT ;12.9.97
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
S ;
 W ! F PRCTHLP=1:1 S PRCTHLP1=$P($T(@MES+PRCTHLP),";",3) Q:PRCTHLP1=""  W !,PRCTHLP1
 W ! K MES,PRCTHLP1,PRCTHLP Q
 ;
REC S MES="REC" G S
 ;;*** Error, number of records read from barcode reader does not
 ;;    equal the number transmitted.  Please re-transmit the data.
 ;;
COM S MES="COM" G S
 ;;If you want to line up all comment lines (::) in you BARCODE program
 ;;at a certain column, enter the column you wish all comments to begin.
 ;;For example:  If some of your comments begin at column 37 in some lines
 ;;and some comments begin at column 40 in other lines, you may want to
 ;;have all comments begin at column 35 for readability.
 ;;Valid choices are 30, 35, 40 and 45.
 ;;
WARN S MES="WARN" G S
 ;;### WARNING: When a program is sent to the barcode reader, ALL DATA
 ;;stored on the barcode reader will be LOST!  Make sure that previous
 ;;users of this barcode reader have no need for data, if any, that
 ;;might exist on the reader.
 ;; 
 ;;Please follow these steps:
 ;;  
 ;;1) If you have not already done so, you may now connect the
 ;;   barcode reader to the output device.
 ;; 
 ;;2) After you have connected the barcode reader to the device, clear
 ;;   the barcode reader by turning the reader off and back on.
 ;; 
 ;;3) After you have completed the above steps, press the <RETURN>
 ;;   key to start sending the IRL program to the bar code reader.
 ;;   If you want to escape this option, enter a '^' and <RETURN>.
 ;; 
 ;;OK, you must now enter either <RETURN> ...
 ;;                       ... or '^'<RETURN>: 
 ;;
NODEV S MES="NODEV" G S
 ;;If you do NOT select a device for this data to be processed on, it will
 ;;not be processed.
 ;;
YN S MES="YN" G S
 ;;Anwer with a 1 for YES or 2 for NO.
 ;;
NONID S MES="NONID" G S
 ;;*** Data processor has NOT been tasked.  Identifier is non-existent.
 ;;Please contact COMPUTER SYSTEMS MANAGER.
 ;;
NOTI S MES="NOTI" G S
 ;;*** Data processor has NOT been tasked.  DATE/TIME OF DATA UPLOAD is
 ;;non-existent.  Please contact COMPUTER SYSTEMS MANAGER.
 ;;
NORTN S MES="NORTN" G S
 ;;*** Data cannot be processed because a ROUTINE is non-existent.
 ;;Please contact COMPUTER SYSTEMS MANAGER.
 ;;
COM1 S MES="COM1" G S
 ;;*** Please key in the first line no. from which you want to align the
 ;;comments.
 ;;
COM2 S MES="COM2" G S
 ;;*** Please key in the last line no. to which you want to align the
 ;;comments.
 ;;
