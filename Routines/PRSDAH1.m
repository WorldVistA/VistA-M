PRSDAH1 ;HISC/DAD-BASIC EMPLOYEE FIELDS AD HOC REPORT GENERATOR ;04/18/95  10:58
 ;;4.0;PAID;;Sep 21, 1995
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S QAQMRTN="MENU^PRSDAH1",QAQORTN="OTHER^PRSDAH1",QAQDIC=450
 S QAQMHDR="Basic Employee Fields"
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
 ;;1^Cost Center^~17;"Cost Center"^FAO^1:60^
 ;;1^Subacct Code^~18;"Subacct Code"^FAO^1:60^
 ;;1^Fund Control Point^~451;"Fund Control Point"^FAO^1:60^
 ;;1^SSN^~8;"SSN"^FAO^1:60^
 ;;1^Sex^~31;"Sex"^FAO^1:60^
 ;;1^Date of Birth^~32;"Date of Birth"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Station EOD^~2;"Station EOD"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Service Computation Date^~30;"Service Computation Date"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Duty Basis^~9;"Duty Basis"^FAO^1:60^
 ;;1^Pay Basis^~19;"Pay Basis"^FAO^1:60^
 ;;1^Normal Hours^~591;"Normal Hours"^FAO^1:60^
 ;;1^FTEE of Position^~450;"FTEE of Position"^NAO^-999999999:999999999:9^
 ;;1^Pay Plan^~20;"Pay Plan"^FAO^1:60^
 ;;1^Job Series^~15.5;"Job Series"^FAO^1:60^
 ;;1^Job Title^~16;"Job Title"^FAO^1:60^
 ;;1^Grade^~13;"Grade"^FAO^1:60^
 ;;1^Step^~38;"Step"^FAO^1:60^
 ;;1^Salary^~28;"Salary"^NAO^-999999999:999999999:9^
 ;;1^Assignment^~3;"Assignment"^FAO^1:60^
 ;;1^Functional Code^~12;"Functional Code"^FAO^1:60^
 ;;1^Citizenship^~4;"Citizenship"^FAO^1:60^
 ;;1^Perf/Profcy Rating Code^~22;"Perf/Profcy Rating Code"^FAO^1:60^
 ;;1^FLSA^~11;"FLSA"^FAO^1:60^
 ;;1^Retirement Code^~26;"Retirement Code"^FAO^1:60^
 ;;1^TSP Status^~409;"TSP Status"^FAO^1:60^
 ;;1^Health Insurance^~231;"Health Insurance"^FAO^1:60^
 ;;1^Life Insurance^~226;"Life Insurance"^FAO^1:60^
 ;;1^Salary Date^~27;"Salary Date"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Supervisory Level^~39;"Supervisory Level"^FAO^1:60^
 ;;1^Type of Appointment^~42;"Type of Appointment"^FAO^1:60^
 ;;1^Expiration of Limited Appt^~95;"Expiration of Limited Appt"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Veterans Preference^~43;"Veterans Preference"^FAO^1:60^
 ;;1^Vet Status^~603;"Vet Status"^FAO^1:60^
 ;;1^Accession/Separation Code^~48;"Accession/Separation Code"^FAO^1:60^
 ;;1^Accession/Separation Eff Date^~49;"Accession/Separation Eff Date"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Accession/Separation NOA Code^~50;"Accession/Separation NOA Code"^FAO^1:60^
 ;;1^BUS Code^~52;"BUS Code"^FAO^1:60^
 ;;1^Union Code-1^~428;"Union Code-1"^FAO^1:60^
 ;;1^Union Dues Anniversary Date^~430;"Union Dues Anniversary Date"^DAO^::AETS^D DATE^QAQAHOC2
