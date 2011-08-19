PRSDAH3 ;HISC/DAD-PHYSICIAN & DENTIST FIELDS AD HOC REPORT GENERATOR ;04/19/95  08:55
 ;;4.0;PAID;;Sep 21, 1995
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S QAQMRTN="MENU^PRSDAH3",QAQORTN="OTHER^PRSDAH3",QAQDIC=450
 S QAQMHDR="Physician & Dentist Fields"
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
 ;;1^SSN^~8^FAO^1:60^
 ;;1^Pay Plan^~20;"Pay Plan"^FAO^1:60^
 ;;1^Job Title^~16;"Job Title"^FAO^1:60^
 ;;1^Grade^~13;"Grade"^FAO^1:60^
 ;;1^Salary^~28;"Salary"^NAO^-999999999:999999999:9^
 ;;1^Duty Basis^~9;"Duty Basis"^FAO^1:60^
 ;;1^Special Salary Adjustment^~150;"Special Salary Adjustment"^NAO^-999999999:999999999:9^
 ;;1^Special Pay Annual Amt^~142;"Special Pay Annual Amt"^NAO^-999999999:999999999:9^
 ;;1^Geographic Location Pay^~701;"Geographic Location Pay"^NAO^-999999999:999999999:9^
 ;;1^Exceptional Qualifications^~702;"Exceptional Qualifications"^NAO^-999999999:999999999:9^
 ;;1^Position Responsibility^~703;"Position Responsibility"^NAO^-999999999:999999999:9^
 ;;1^Scarce Specialty Pay^~704;"Scarce Specialty Pay"^NAO^-999999999:999999999:9^
 ;;1^Physician And Dentist Pay Cap^~705;"Physician And Dentist Pay Cap"^NAO^-999999999:999999999:9^
 ;;1^State of Licensure^~152;"State of Licensure"^FAO^1:60^
 ;;1^Expiration of Licensure^~90;"Expiration of Licensure"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Expiration of Limited Appt^~95;"Expiration of Limited Appt"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Special Pay Rate Difference^~82;"Special Pay Rate Difference"^NAO^-999999999:999999999:9^
 ;;1^VA Service Date^~154;"VA Service Date"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Academic Title^~119;"Academic Title"^FAO^1:60^
 ;;1^Diplomate^~139;"Diplomate"^FAO^1:60^
 ;;1^Addl Diplomate Specialty A^~120;"Addl Diplomate Specialty A"^FAO^1:60^
 ;;1^Addl Diplomate Specialty B^~132;"Addl Diplomate Specialty B"^FAO^1:60^
 ;;1^Board Eligible Specialty A^~123;"Board Eligible Specialty A"^FAO^1:60^
 ;;1^Board Eligible Specialty B^~124;"Board Eligible Specialty B"^FAO^1:60^
 ;;1^Specialty Trained^~151;"Specialty Trained"^FAO^1:60^
 ;;1^Citizenship^~4;"Citizenship"^FAO^1:60^
 ;;1^Country of Birth^~127;"Country of Birth"^FAO^1:60^
 ;;1^Foreign Medical Graduate Ind^~131;"Foreign Medical Graduate Ind"^FAO^1:60^
 ;;1^Country of Medical School^~128;"Country of Medical School"^FAO^1:60^
 ;;1^Country of Post Grad Training^~129;"Country of Post Grad Training"^FAO^1:60^
 ;;1^Preappointment Experience^~138;"Preappointment Experience"^FAO^1:60^
 ;;1^State of Employment Preappt^~153;"State of Employment Preappt"^FAO^1:60^
 ;;1^No Agreement Reason (At Appt)^~134;"No Agreement Reason (At Appt)"^FAO^1:60^
 ;;1^No Agreement Reason (Current)^~135;"No Agreement Reason (Current)"^FAO^1:60^
 ;;1^Special Pay Agreement Date^~143;"Special Pay Agreement Date"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Special Pay Agreement Length^~144;"Special Pay Agreement Length"^FAO^1:60^
 ;;1^Expiration of Spec Pay Agree^~108;"Expiration of Spec Pay Agree"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Expiration of Geo Location Pay^~114.1;"Expiration of Geo Location Pay"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Special Pay Agreement Qual Apt^~145;"Special Pay Agreement Qual Apt"^FAO^1:60^
 ;;1^Special Pay Agreement Qual Cur^~146;"Special Pay Agreement Qual Cur"^FAO^1:60^
