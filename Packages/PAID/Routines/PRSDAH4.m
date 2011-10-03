PRSDAH4 ;HISC/DAD-AD HOC REPORT INTERFACE FOR THE PAID EMPLOYEE FILE (#450) ;05/23/95  14:17
 ;;4.0;PAID;;Sep 21, 1995
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S QAQMRTN="MENU^PRSDAH4",QAQORTN="OTHER^PRSDAH4",QAQDIC=450
 S QAQMHDR="Followup Code Fields"
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
 ;;1^Placement Followup^~91;"Placement Followup"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Conversion To Career Tenure^~93;"Conversion To Career Tenure"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Expiration Of Limited Appt^~95;"Expiration Of Limited Appt"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Expiration Of Formal Detail^~96;"Expiration Of Formal Detail"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Redetermination Of WGI^~97;"Redetermination Of WGI"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Eligible For Drug Testing^~115.17;"Eligible For Drug Testing"^FAO^1:60^
 ;;1^Followup Code 08^~97.1;"Followup Code 08"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Elig For Conv To Comp Service^~98;"Elig For Conv To Comp Service"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Annual Leave Restriction^~92;"Annual Leave Restriction"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Obligated Service^~99;"Obligated Service"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Expiration Of Grade Retention^~100;"Expiration Of Grade Retention"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Supervisor/Mgr Prob Period^~102;"Supervisor/Mgr Prob Period"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Beginning Of Nonpay Status^~103;"Beginning Of Nonpay Status"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^1-Year Prob Period Completion^~104;"1-Year Prob Period Completion"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Federal Service Date^~110;"Federal Service Date"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Career Promotion Determination^~111;"Career Promotion Determination"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Expiration Of FERS Period^~113;"Expiration Of FERS Period"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Temporary Health Benefits Elig^~114;"Temporary Health Benefits Elig"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Expiration Of Geo Location Pay^~114.1;"Expiration Of Geo Location Pay"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code S*^~115.16;"Followup Code S*"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 30^~116.01;"Followup Code 30"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 31^~116.02;"Followup Code 31"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 32^~116.03;"Followup Code 32"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 33^~116.04;"Followup Code 33"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 34^~116.05;"Followup Code 34"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 35^~116.06;"Followup Code 35"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 36^~116.07;"Followup Code 36"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 37^~116.08;"Followup Code 37"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 38^~116.09;"Followup Code 38"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 39^~116.1;"Followup Code 39"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 40^~116.11;"Followup Code 40"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 41^~116.12;"Followup Code 41"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 42^~116.13;"Followup Code 42"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 43^~116.14;"Followup Code 43"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 44^~116.15;"Followup Code 44"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 45^~116.16;"Followup Code 45"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 46^~116.17;"Followup Code 46"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 47^~116.18;"Followup Code 47"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 48^~116.19;"Followup Code 48"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Followup Code 49^~116.2;"Followup Code 49"^DAO^::AETS^D DATE^QAQAHOC2
