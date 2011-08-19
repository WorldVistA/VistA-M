PRSDAH2 ;HISC/DAD-TITLE 38 EMPLOYEE FIELDS AD HOC REPORT GENERATOR ;04/19/95  08:55
 ;;4.0;PAID;;Sep 21, 1995
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S QAQMRTN="MENU^PRSDAH2",QAQORTN="OTHER^PRSDAH2",QAQDIC=450
 S QAQMHDR="Title 38 Employee Fields"
 D ^QAQAHOC0
 Q
MENU ; *** Build the menu array
 S QAQMENU=1
 F QA=1:1 S X=$P($T(TEXT+QA),";;",2,99) Q:X=""  S QAQMENU(QAQMENU)=X,QAQMENU=QAQMENU+1
 Q
OTHER ; *** Set up other (optional) EN1^DIP variables, e.g.
 ; *** DCOPIES,DHD,DHIT,DIOBEG,DIOEND,DIS(),IOP,PG
 S ASKFLG="P" D ASK^PRSDPRNT K ASKFLG S:%=-1 QAQQUIT=1
 K QAQFOUND S QAQFOUND=0,DHIT="S QAQFOUND=1"
 S DIOEND="I 'QAQFOUND W !!,""No data found for this report !!"""
 Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)
 ;;1^Employee Name^~.01;"Employee Name"^FAO^1:60^
 ;;1^Service^~458;"Service"^FAO^1:60^
 ;;1^Duty Station^~590;"Duty Station"^FAO^1:60^
 ;;1^SSN^~8^FAO^1:60^
 ;;1^Pay Plan^~20;"Pay Plan"^FAO^1:60^
 ;;1^Job Series^~15.5;"Job Series"^FAO^1:60^
 ;;1^Job Title^~16;"Job Title"^FAO^1:60^
 ;;1^Assignment^~3;"Assignment"^FAO^1:60^
 ;;1^Functional Code^~12;"Functional Code"^FAO^1:60^
 ;;1^Grade^~13;"Grade"^FAO^1:60^
 ;;1^Salary^~28;"Salary"^NAO^-999999999:999999999:9^
 ;;1^Type of Appointment^~42;"Type of Appointment"^FAO^1:60^
 ;;1^Duty Basis^~9;"Duty Basis"^FAO^1:60^
 ;;1^Special Salary Adjustment^~150;"Special Salary Adjustment"^NAO^-999999999:999999999:9^
 ;;1^Chief Nurse Level^~604;"Chief Nurse Level"^FAO^1:60^
 ;;1^Nurse Pay Schedule^~605;"Nurse Pay Schedule"^FAO^1:60^
 ;;1^State of Licensure^~152;"State of Licensure"^FAO^1:60^
 ;;1^Expiration of Licensure^~90;"Expiration of Licensure"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Expiration of Limited Appt^~95;"Expiration of Limited Appt"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date of Grade for T38 Emp^~105;"Date of Grade for T38 Emp"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date of Entry to T38 Position^~106;"Date of Entry to T38 Position"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Education^~10;"Education"^FAO^1:60^
 ;;1^College Major^~5;"College Major"^FAO^1:60^
 ;;1^Date Grad from Prof School^~107;"Date Grad from Prof School"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^VA Service Date^~154;"VA Service Date"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Salary Date^~27;"Salary Date"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Step Rate Review^~109;"Step Rate Review"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Proficiency Date^~112;"Proficiency Date"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^2-Year Prob Period Completion^~94;"2-Year Prob Period Completion"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Citizenship^~4;"Citizenship"^FAO^1:60^
 ;;1^Country of Birth^~127;"Country of Birth"^FAO^1:60^
 ;;1^Special Pay Ret Ded^~147;"Special Pay Ret Ded"^FAO^1:60^
 ;;1^Special Pay Annual Amt^~142;"Special Pay Annual Amt"^NAO^-999999999:999999999:9^
 ;;1^Special Pay Rate Difference^~82;"Special Pay Rate Difference"^NAO^-999999999:999999999:9^
 ;;1^Physician And Dentist Pay Cap^~705;"Physician And Dentist Pay Cap"^NAO^-999999999:999999999:9^
