QANAHOC ;HISC/DAD-Ad Hoc Report interface for the QA Patient Incident Review file (#742) ;2/8/93  10:12
 ;;2.0;Incident Reporting;**1,15,17,27,26**;08/07/1992
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S QAQMRTN="MENU^QANAHOC",QAQORTN="OTHER^QANAHOC",QAQDIC=742
 S QANXIT=0 D ^QAQAHOC0
 K %Y,B,D,DIJ,DP,QAND0,QAQ,QANXIT,QAQFOUND,QB,QC
 Q
CONVERT ;Convert sort parameters for Incident Case Status.
 ;Codes from ^DD(742.4,.09,0)
 ;0 --->'Closed'               1 --->'Open'
 ;2 --->'Deleted'              3 --->'Quick'
 Q:'$D(QAQBEGIN(QB))!('$D(QAQEND(QB)))
 Q:(QAQBEGIN(QB)=0)&(QAQEND(QB)=0)
 Q:(QAQBEGIN(QB)=2)&(QAQEND(QB)=2)
 ;Quit if the input vars do not exist, of if 'open' is not included in
 ;the sort parameters.
 ;If 'open' is included, and 'deleted' is not, screen out 'deleted'.
 ;If 'open' is included, and 'closed' is not, screen out 'closed'.
 I QAQBEGIN(QB)=0,(QAQEND(QB)=1) D  Q
 . S TO(QB)=3
 . S DIS(0)="S QAND0=$P($G(^QA(742,D0,0)),U,3) I $G(QAND0)]"""",($P($G(^QA(742.4,QAND0,0)),U,8))#3'>1"
 I QAQBEGIN(QB)=0,(QAQEND(QB)=2) S TO(QB)=3 Q
 I QAQBEGIN(QB)=1,(QAQEND(QB)=1) D  Q
 . S TO(QB)=3
 . S DIS(0)="S QAND0=$P($G(^QA(742,D0,0)),U,3) I $G(QAND0)]"""",($P($G(^QA(742.4,QAND0,0)),U,8)>0),($P($G(^QA(742.4,QAND0,0)),U,8)#3'>1)"
 I QAQBEGIN(QB)=1,(QAQEND(QB)=2) S TO(QB)=3 Q
 Q
MENU ; *** Build the menu array
 F QA=1:1 S X=$P($T(TEXT+QA),";;",2,99) Q:X=""  S QAQMENU(QA)=X
 Q
OTHER ; *** Set up other (optional) EN1^DIP variables, e.g.
 ; *** DCOPIES,DHD,DHIT,DIOBEG,DIOEND,DIS(),IOP,PG
 K DIS,QAQFOUND S QAQFOUND=0,DHIT="S QAQFOUND=1"
 S DIOEND="I 'QAQFOUND W !!,""No data found for this report !!"""
 ;Check if 'Incident Case Status' is a sort field.
 F QB=0:0 S QB=$O(QAQOPTN("S",QB)) Q:QB'>0!(QANXIT)  D
 . S QC=$O(QAQOPTN("S",QB,0)) Q:QC'>0
 . I $P(QAQOPTN("S",QB,QC),";",1)=".03:,.09" S QANXIT=1 D CONVERT
 F  S %=2 W !!?5,"Do you want the report to include 'deleted' records" D YN^DICN Q:"-12"[%  W !?5,"Please answer (Y)es or (N)o."
 I %=2 D
 . I $D(DIS(0)) S DIS(0)=DIS(0)_",($P($G(^QA(742,D0,0)),U,12)'=-1),($P($G(^QA(742.4,QAND0,0)),U,8)'=2)"
 . E  S DIS(0)="S QAND0=$P($G(^QA(742,D0,0)),U,3) I $G(QAND0)]"""",($P($G(^QA(742,D0,0)),U,12)'=-1),($P($G(^QA(742.4,QAND0,0)),U,8)'=2)"
 Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)
 ;;1^Patient^~.01;"Patient"^PAO^2:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;1^Patient Id^~.02;"Patient Id"^FAO^1:30^
 ;;1^Date of Admission^~.04;"Date Of Admission"^DAO^::AET^S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_(1700+$E(Y,1,3))
 ;;1^Patient Type^~.05;"Patient Type"^SO^0:OUTPATIENT;1:INPATIENT;^;I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^Ward/Clinic^~.06;"Ward/Clinic"^PAO^44:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;1^Treating Specialty^~.07;"Treating Specialty"^PAO^45.7:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;1^Service^~.08;"Service"^PAO^730:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;1^Responsible Service^.12,~.01;"Responsible Service"^PAO^730:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;1^Medication Errors^~.11;"Medication Errors"^PAO^742.13:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;0^Case Number^~.03:.01;"Case Number"^FAO^7:13^
 ;;1^Incident^~.03:.02;"Incident"^PAO^742.1:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;1^Incident Location^~.03:.04;"Incident Location"^PAO^742.5:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;1^Type of Death^~.03:.15;"Type of Death"^PAO^742.14:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;1^Level of Review^~.03:.12;"Level of Review"^SO^^;I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^Date of Incident^~.03:.03;"Date of Incident"^DAO^::AET^S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_(1700+$E(Y,1,3))
 ;;1^Incident Case Status^~.03:,.09;"Incident Case Status"^SO^0:CLOSED;1:OPEN;2:DELETED;^;I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^Severity Level^~.1;"Severity Level"^SO^0:NO INJURY OR DISABILITY;1:MINOR;2:MAJOR;3:DEATH;^;I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^National Case Status^~.03:.17;"National Case Status"^SO^^;I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;0^Fall Assessment Score^~.09;"Fall Assessment Score"^FAO^1:3^
 ;;0^Person Reporting the Incident^~.03:.06;"Person Reporting the Incident"^PAO^200:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;0^Patient Diagnosis^.15,~.01;"Patient Diagnosis"^FAO^3:60^
 ;;0^Medical Center Action^.03:.16;"Medical Center Action"^SO^1:CHANGE IN POLICY/PROCEDURE;2:EDUCATION/TRAINING;3:SYSTEMS CHANGE;4:DISCIPLINARY;5:DISTRICT COUNCIL NOTIFIED;6:NONE INDICATED;^;I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;0^Incident Description^.03:.05;"Incident Description"^
 ;;0^Pertinent Information^.03:.2;"Pertinent Information"^
 ;;1^Division^~.03:52;"Division"^PAO^4:AEMNZQ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
