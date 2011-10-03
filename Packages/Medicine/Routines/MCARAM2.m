MCARAM2 ;WASH ISC/JKL-MUSE TRANSFER LAB DATA TO LOCAL ;2/13/98  09:12
 ;;2.3;Medicine;**16**;09/13/1996
 ;
 ;
 ;Modules to return lab data in a local array
 ; USAGE: S X=$$L#^MCARAM2(.A,B) , where # = integer from 7 to 12
 ; WHERE: .A=local array into which data is placed
 ;         B=1 line of lab data
 ;  if unsuccessful, returns an error message
 ;  if successful, returns a function value of 0 and a value array:
 ;  MCA(field #) = value of field
 ;  MCA("CONT") = diagnosis line # in alphabetic form
 ;  MCA("DX,#") = line of diagnosis data
 ;  MCA("DT") = date/time in FM format
 ;
L7(MCA,MCD) ;Returns "DT" = date/time in FM format
 ;        "DX,G" = 7th line of diagnosis
 N MCERR,Y
 S MCERR=$$AR^MCARAM4(.MCA,"DAY",MCD,11,22) Q:+MCERR=2 $$LOG^MCARAM7("51-Date is a null data field")  I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"TM",MCD,23,31) Q:+MCERR=2 $$LOG^MCARAM7("51-Time is a null data field")  I +MCERR>50 Q MCERR
 S X=MCA("DAY")_"@"_MCA("TM")
 I X?2N1"-"3A1"-"2N1"@"2N1":"2N Q $$LOG^MCARAM7("52-Date/Time not DD-MMM-YYYY@HH:MM")
 I X'?2N1"-"3A1"-"4N1"@"2N1":"2N Q $$LOG^MCARAM7("52-Date/Time not DD-MMM-YYYY@HH:MM")
 S %DT="RX" D ^%DT I Y'>0 Q $$LOG^MCARAM7("53-Date/Time rejected by %DT")
 S:Y>0 MCA("DT")=Y
 S MCERR=$$AR^MCARAM4(.MCA,"DX,"_MCA("CONT"),MCD,32,134) I +MCERR>50 Q MCERR
 Q 0
 ;
L8(MCA,MCD) ;Returns Field 3 = vent. rate, "DX,H" = 8th line of diagnosis
 N MCERR
 S MCERR=$$AR^MCARAM4(.MCA,3,MCD,11,18,1)
 I +MCERR=2 K MCA(3) S MCERR=$$LOG^MCARAM7("2-Vent. rate is a null data field")
 I +MCERR=1 K MCA(3) S MCERR=$$LOG^MCARAM7("1-Vent. rate not numeric")
 I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"DX,"_MCA("CONT"),MCD,32,134) I +MCERR>50 Q MCERR
 Q 0
 ;
L9(MCA,MCD) ;Returns Field 4 = PR interval, "DX,I" = 9th line of diagnosis
 N MCERR
 S MCERR=$$AR^MCARAM4(.MCA,4,MCD,12,18,1)
 I +MCERR=2 K MCA(4) S MCERR=$$LOG^MCARAM7("2-PR interval is a null data field")
 I +MCERR=1 K MCA(4) S MCERR=$$LOG^MCARAM7("1-PR interval not numeric")
 I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"DX,"_MCA("CONT"),MCD,32,134) I +MCERR>50 Q MCERR
 Q 0
 ;
L10(MCA,MCD) ;Returns Field 5 = QRS duration, "DX,J" =10th line of diagnosis
 N MCERR
 S MCERR=$$AR^MCARAM4(.MCA,5,MCD,13,18,1)
 I +MCERR=2 K MCA(5) S MCERR=$$LOG^MCARAM7("2-QRS duration is a null data field")
 I +MCERR=1 K MCA(5) S MCERR=$$LOG^MCARAM7("1-QRS duration not numeric")
 I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"DX,"_MCA("CONT"),MCD,32,134) I +MCERR>50 Q MCERR
 Q 0
 ;
L11(MCA,MCD) ;Returns Field 6 = QT, 7 = QTc, "DX,K"=11th line of diagnosis
 N MCERR
 S MCERR=$$AR^MCARAM4(.MCA,6,MCD,7,14,1)
 I +MCERR=2 K MCA(6) S MCERR=$$LOG^MCARAM7("2-QT is a null data field")
 I +MCERR=1 K MCA(6) S MCERR=$$LOG^MCARAM7("1-QT not numeric")
 I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,7,MCD,16,18,1)
 I +MCERR=2 K MCA(7) S MCERR=$$LOG^MCARAM7("2-QTc is a null data field")
 I +MCERR=1 K MCA(7) S MCERR=$$LOG^MCARAM7("1-QTc not numeric")
 I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"DX,"_MCA("CONT"),MCD,32,134) I +MCERR>50 Q MCERR
 Q 0
 ;
KNMK ; Kill name check variables
 K MCNAM,MCFNAM,MCLNAM,MC12NAM,MC12FNAM,MC12LNAM,MCA12 Q
 ;
ERR ;Error return
 Q MCERR
DATE(MCDATE) ; Get the two digit century for the date
 N MCMTH,A1,A2,A3,SD
 S SD=$P(MCDATE,"@",1),A2=0
 S A1=$P(SD,"-",2) G:A1'?3A EXIT
 S A1=$TR(A1,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S A2=$S(A1="JAN":1,A1="FEB":2,A1="MAR":3,A1="APR":4,A1="MAY":5,A1="JUN":6,A1="JUL":7,A1="AUG":8,A1="SEP":9,A1="OCT":10,A1="NOV":11,A1="DEC":12,1:0) G:'A2 EXIT
EXIT Q $E(MCDATE,1,7)_1700+$S(A2&(A2>$E(DT,4,5)):1700+$E(DT,1)_$E(MCDATE,8,15))
