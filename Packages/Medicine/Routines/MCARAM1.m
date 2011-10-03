MCARAM1 ;WASH ISC/JKL-MUSE TRANSFER LAB DATA TO LOCAL ;4/27/99  09:50
 ;;2.3;Medicine;**23**;09/13/1996
 ;
 ;
 ;Modules to return lab data in a local array
 ; USAGE: S X=$$L#^MCARAM1(.A,B) , where # = integer from 1 to 6
 ; WHERE: .A=local array into which data is placed
 ;         B=1 line of lab data
 ;  if unsuccessful, returns an error message
 ;  if successful, returns a function value of 0 and a value array:
 ;  MCA(field #) = value of field
 ;  MCA("CONT")= line # of diagnosis in alphabetic form
 ;  MCA("DX,#") = line of diagnosis data
 ;  MCA("RX,#")=parsed medication line
 ;  MCA("NAME") = patient name, MCA("AGE")= patient age
 ;  MCA("RACE") = patient race, MCA("SEX")= patient sex
L1(MCA,MCD) ;Returns "DX,A" = 1st line of diagnosis, Field 2=Type of EKG
 N MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"DX,"_MCA("CONT"),MCD,32,84) I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,2,MCD,85,134) I +MCERR>50 Q MCERR
 S MCA(2)=$S(MCA(2)["STAT":"S",MCA(2)["ROUT":"R",MCA(2)["ORIG":"O",1:"")
 I MCA(2)="" K MCA(2) Q $$LOG^MCARAM7("2-EKG Type is a null data field")
 Q 0
 ;
L2(MCA,MCD) ;Returns "NAME" = patient name, "DX,B" = 2nd line of diagnosis
 N MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"NAME",MCD,1,31) Q:+MCERR>50 MCERR  I +MCERR=2 S MCA("NAME")="No patient name" Q $$LOG^MCARAM7("57-Name is a null data field")
 S:MCA("NAME")[", " MCA("NAME")=$P(MCA("NAME"),", ")_","_$P(MCA("NAME"),", ",2)
 S MCA("NAME")=$$UP^XLFSTR(MCA("NAME"))
 S MCERR=$$AR^MCARAM4(.MCA,"DX,"_MCA("CONT"),MCD,32,134) I +MCERR>50 Q MCERR
 Q 0
 ;
L3(MCA,MCD) ;Returns Field .02=Social Security number
 ;                Field 18=Ward/Clinic, "DX,C" = 3rd line of diagnosis
 N MCERR,MCI
 S MCA(.02)=$E(MCD,4,12),MCERR=$$DFCK^MCARAM4(MCA(.02),1) Q:+MCERR>50 MCERR  Q:+MCERR=1 $$LOG^MCARAM7("54-Social Security Number is not numeric")  I +MCERR=2 Q $$LOG^MCARAM7("54-Social Security Number is a null data field")
 S MCERR=$$AR^MCARAM4(.MCA,"DX,"_MCA("CONT"),MCD,32,134) I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,18,MCD,18,31) I +MCERR>50 Q MCERR
 I +MCERR=2 K MCA(18) S MCERR=$$LOG^MCARAM7("2-Ward/Clinic is a null data field") Q MCERR
 S MCI=MCA(18) K MCA(18)
 I $D(^SC("B",MCI))!$D(^SC("C",MCI)) S MCA(18)=$O(^(MCI,0))
 I '$D(MCA(18)) S MCERR=$$LOG^MCARAM7("1-Undefined Ward/Clinic")
 Q 0
 ;
L4(MCA,MCD) ;Returns "AGE"=patient age, Field .08=height, .07=weight
 ; "RACE"=race, "SEX"=patient sex, "DX,D" = 4th line of diagnosis
 N MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"AGE",MCD,1,5,1) I +MCERR>50 Q MCERR
 I +MCERR=2 K MCA("AGE") S MCERR=$$LOG^MCARAM7("2-Age is a null data field")
 I +MCERR=1 K MCA("AGE") S MCERR=$$LOG^MCARAM7("1-Age is not a numerical data field")
 S MCERR=$$AR^MCARAM4(.MCA,.08,MCD,8,11,1) I +MCERR>50 Q MCERR
 I +MCERR=2 K MCA(.08) S MCERR=$$LOG^MCARAM7("2-Height is a null data field")
 I +MCERR=1 K MCA(.08) S MCERR=$$LOG^MCARAM7("1-Height is not a numerical data field")
 S MCERR=$$AR^MCARAM4(.MCA,.07,MCD,14,17,1) I +MCERR>50 Q MCERR
 I +MCERR=2 K MCA(.07) S MCERR=$$LOG^MCARAM7("2-Weight is a null data field")
 I +MCERR=1 K MCA(.07) S MCERR=$$LOG^MCARAM7("2-Weight is not a numerical data field")
 S MCERR=$$AR^MCARAM4(.MCA,"RACE",MCD,21,24) I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"SEX",MCD,25,31) I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"DX,"_MCA("CONT"),MCD,32,134) I +MCERR>50 Q MCERR
 Q 0
 ;
L5(MCA,MCD) ;Returns "RX", #s = data for each medication
 ;        "DX,E" = 5th line of diagnosis
 N MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"RX,0",MCD,5,31) I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,"DX,"_MCA("CONT"),MCD,32,134) I +MCERR>50 Q MCERR
 Q 0
 ;
L6(MCA,MCD) ;Returns Field 16=systolic bp, 15=diastolic bp,
 ;        "DX,F" = 6th line of diagnosis
 N MCERR
 S MCERR=$$AR^MCARAM4(.MCA,16,MCD,11,13,1) Q:+MCERR>50 MCERR  I +MCERR=2 K MCA(16) S MCERR=$$LOG^MCARAM7("2-Systolic bp is a null data field")
 I +MCERR=1 K MCA(16) S MCERR=$$LOG^MCARAM7("2-Systolic bp is not a numerical data field")
 S MCERR=$$AR^MCARAM4(.MCA,15,MCD,15,17,1) Q:+MCERR>50 MCERR  I +MCERR=2 K MCA(15) S MCERR=$$LOG^MCARAM7("2-Diastolic bp is a null data field")
 I +MCERR=1 K MCA(15) S MCERR=$$LOG^MCARAM7("2-Diastolic bp is not a numerical data field")
 S MCERR=$$AR^MCARAM4(.MCA,"DX,"_MCA("CONT"),MCD,32,134) I +MCERR>50 Q MCERR
 Q 0
 ;
 ;
ERR ;Error return
 Q MCERR
