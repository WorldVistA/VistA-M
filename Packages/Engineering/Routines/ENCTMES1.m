ENCTMES1 ;(WASH ISC)/RGY-Help Text Processor ;7-25-90
 ;;7.0;ENGINEERING;;Aug 17, 1993
 ;Copy of PRCTMES1 ;DH-WASH ISC
S ;
 W ! F ENCTHLP=1:1 S ENCTHLP1=$P($T(@MES+ENCTHLP),";",3) Q:ENCTHLP1=""  W !,ENCTHLP1
 W ! K MES,ENCTHLP1,ENCTHLP Q
 ;
REC S MES="REC" G S
 ;;*** Error, number of records read from barcode reader does not
 ;;    equal the number transmitted.  Please re-transmit the data.
 ;;
COM S MES="COM" G S
 ;;If you want to line up all comment lines (::) in you IRL program
 ;;at a certain column, enter the column you wish all comments to begin.
 ;;For example:  If your comments begin at column 37 in some lines
 ;;and comments begin at column 40 in other lines, you may want to
 ;;have all comments begin at column 35 for readability.
 ;;Valid choices are 30, 35, 40 and 45.
 ;;
WARN S MES="WARN" G S
 ;;### WARNING: When a program is sent to the barcode reader, ALL DATA
 ;;stored on the barcode reader will be LOST!  Make sure that previous
 ;;users of this barcode reader have no need for data, if any, that
 ;;might exist on the reader.
 ;; 
 ;;Please follow the following steps:
 ;;  
 ;;1) If you have not already done so, you may now connect up the
 ;;   barcode reader to the output device.
 ;; 
 ;;2) After you have connected the barcode reader to the device, clear
 ;;   the barcode reader by turning the reader off and back on.
 ;; 
 ;;3) After you have completed the above steps, press the return
 ;;   key to start sending the program to the barcode reader.  If you
 ;;   want to abort this option, enter a ^ and return.
 ;; 
 ;;OK, you must now enter either a return ...
 ;;                       ... or an '^' return: 
 ;;
 ;;
NORTN S MES="NORTN" G S
 ;;*** WARNING, The data has been saved in the BARCODE PROGRAM file, but
 ;;will NOT be processed because the ROUTINE field in the BARCODE PROGRAM
 ;;file is missing.  --- Contact COMPUTER SYSTEMS MANAGER ---
 ;;
NODEV S MES="NODEV" G S
 ;;If you do NOT select a device for this data to be processed on, it will
 ;;not be processed automatically.
 ;;
YN S MES="YN" G S
 ;;Anwer with a 1 for YES or 2 for NO.
 ;;
NONID S MES="NONID" G S
 ;;*** Data processor has NOT been tasked. Identifier is non-existent.
 ;;Please contact COMPUTER SYSTEMS MANAGER.
 ;;
NOTI S MES="NOTI" G S
 ;;*** Data processor has NOT been tasked. DATE/TIME OF DATA UPLOAD is
 ;;non-existent. Please contact COMPUTER SYSTEMS MANAGER.
 ;;
COM1 S MES="COM1" G S
 ;;*** Please key in the first line number from which you want to align
 ;;the comments.
COM2 S MES="COM2" G S
 ;;*** Please key in the last line number to which you want to align
 ;;the comments.
 ;;
