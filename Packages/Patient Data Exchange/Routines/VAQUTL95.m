VAQUTL95 ;ALB/JFP/JRP - SETS COMMONLY USED VARIABLES;01-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
 ;
STATPTR ; -- Sets PDX status pointers
 S (VAQRSLT,VAQUNSOL)=""
 S VAQRSLT=$O(^VAT(394.85,"B","VAQ-RSLT",VAQRSLT))
 S VAQUNSOL=$O(^VAT(394.85,"B","VAQ-UNSOL",VAQUNSOL))
 QUIT
 ;
PAUSE ; -- Pauses the screen
 W ! S DIR(0)="EA",DIR("A")="Press RETURN to continue:" D ^DIR K DIR W !
 QUIT
 ;
END ; -- End of code
 QUIT
 ;
IMPDTE(XMITDATE) ;CHECK DATE USED IN PDX TRANSMISSIONS FOR PRECISENESS
 ;INPUT  : XMITDATE - Date in format MM-DD-YYYY
 ;OUTPUT : N - If date is precise, MM-DD-YYYY (what was sent)
 ;             If date is not precise
 ;                MM--YYYY if day is not precise
 ;                YYYY if month is not precise
 ;         -1 - Bad input
 ;
 ;CHECK INPUT
 Q:($G(XMITDATE)="") -1
 Q:(XMITDATE'?2N1"-"2N1"-"4N) -1
 ;DECLARE VARIABLES
 N MONTH,DAY,YEAR
 ;GET PIECES OF DATE
 S MONTH=$P(XMITDATE,"-",1)
 S DAY=$P(XMITDATE,"-",2)
 S YEAR=$P(XMITDATE,"-",3)
 ;YEAR IS IMPRECISE (ERROR)
 Q:('(+YEAR)) -1
 ;MONTH NOT PRECISE
 Q:('(+MONTH)) YEAR
 ;DAY NOT PRECISE
 Q:('(+DAY)) (MONTH_"--"_YEAR)
 ;DATE IS PRECISE
 Q XMITDATE
 ;
AMPMTIME(XMITTIME) ;PLACE AM/PM ON END OF TIME USED IN PDX TRANSMISSIONS
 ;INPUT  : XMITTIME - Time in format hh:mm:ss (seconds optional)
 ;OUTPUT : N - XMITTIME concatenated with AM or PM
 ;             If time falls between midnight and noon, AM is used
 ;             If time falls between noon and midnight, PM is used
 ;        -1 - Bad input
 ;NOTES  : If seconds are not included, 00 will be used
 ;       : If time is exactly midnight, AM is used
 ;       : If time is exactly noon, PM is used
 ;       : If time is between 00:00:00 and 00:00:59, 00:01:00 will
 ;         be used as the input time (FileMan has problem with it)
 ;       : Time between midnight and one AM will return 12AM
 ;
 ;CHECK INPUT
 Q:($G(XMITTIME)="") -1
 S:(XMITTIME?2N1":"2N) XMITTIME=XMITTIME_":00"
 S:(XMITTIME?2N1":"2N1":") XMITTIME=XMITTIME_"00"
 Q:(XMITTIME'?2N1":"2N1":"2N) -1
 S:(XMITTIME?1"00:00:"2N) XMITTIME="00:01:00"
 ;DECLARE VARIABLES
 N HOUR,OUTPUT
 S HOUR=+$P(XMITTIME,":",1)
 S OUTPUT=-1
 ;MIDNIGHT TO NOON (AM) - CONVERT 00 AM TO 12 AM
 I (HOUR<12) D
 .S:('HOUR) OUTPUT="12:"_$P(XMITTIME,":",2,3)_"AM"
 .S:(HOUR) OUTPUT=XMITTIME_"AM"
 ;NOON TO MIDNIGHT (PM)
 S:(HOUR>11) OUTPUT=XMITTIME_"PM"
 Q OUTPUT
 ;
CHCKDT(XMITDT) ;CHECK DATE AND TIME OF PDX TRANSMISSION
 ;INPUT  : XMITDT - Date and time of transmission
 ;                  MM-DD-YYYY@hh:mm:ss
 ;OUTPUT : N - Date and time in acceptable FimeMan format
 ;        -1 - Bad input/error
 ;NOTES  : Refer to $$IMPDTE for date check
 ;       : Refer to $$AMPMTIME for time check
 ;
 ;CHECK INPUT
 Q:($G(XMITDT)="") -1
 ;DECLARE VARIABLES
 N DATE,TIME
 S DATE=$$IMPDTE($P(XMITDT,"@",1))
 Q:(DATE="-1") -1
 S TIME=$$AMPMTIME($P(XMITDT,"@",2))
 Q:(TIME="-1") -1
 Q (DATE_"@"_TIME)
