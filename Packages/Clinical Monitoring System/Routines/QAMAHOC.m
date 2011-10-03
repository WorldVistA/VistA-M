QAMAHOC ;HISC/DAD-AD HOC REPORT INTERFACE FOR THE QA MONITOR FILE (#743) ;9/3/93  13:02
 ;;1.0;Clinical Monitoring System;;09/13/1993
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S QAQMRTN="MENU^QAMAHOC",QAQORTN="OTHER^QAMAHOC",QAQDIC=743
 S QAQMHDR="Clinical Monitoring System"
 D ^QAQAHOC0
 K QAQFOUND
 Q
MENU ; *** Build the menu array
 F QA=1:1 S X=$P($T(TEXT+QA),";;",2,99) Q:X=""  S QAQMENU(QA)=X
 Q
OTHER ; *** Set up other (optional) EN1^DIP variables, e.g.
 ; *** DCOPIES,DHD,DHIT,DIOBEG,DIOEND,DIS(),IOP,PG
 K QAQFOUND S QAQFOUND=0,DHIT="S QAQFOUND=1"
 S DIOEND="I 'QAQFOUND W !!,""No data found for this report !!"""
 Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)
 ;;1^Monitor Code^~.01;"Monitor Code"^FAO^1:30^
 ;;1^Monitor Title^~.02;"Monitor Title"^FAO^1:30^
 ;;1^Service^~1;"Service"^PAO^49:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;0^Standard of Care^~2;"Standard of Care"^
 ;;0^Clinical Indicator^~3;"Clinical Indicator"^
 ;;1^Rationale^4,~.01;"Rationale"^PAO^743.91:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;0^Explain Rationale^4,~1;"Explain Rationale"^
 ;;1^Auto Enroll Monitor^~6;"Auto Enroll Monitor"^SO^1:YES;0:NO;^I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^Monitor Status^~7;"Monitor Status"^SO^1:FINISHED;0:UNDER CONSTRUCTION;^I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^On/Off Switch^~54;"On/Off Switch"^SO^1:ON;0:OFF;^I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^Condition^20,~.01;"Condition"^PAO^743.3:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;1^Time Frame^~50;"Time Frame"^PAO^743.92:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;1^Min Sample/Alert Level^~51;"Min Samp/Alert Lev"^NAO^0:1000000:0^
 ;;1^Threshold^~52;"Threshold"^FAO^1:30^
 ;;1^Hi/Lo Percent^~53;"Hi/Lo Percent"^SO^H:HIGH;L:LOW;^I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^Start Date^~55;"Start Date"^DAO^::AET^S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_(1700+$E(Y,1,3))
 ;;1^End Date^~56;"End Date"^DAO^::AET^S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_(1700+$E(Y,1,3))
 ;;1^Print Daily Fall Out List^~57;"Daily Fall Out List"^SO^1:YES;0:NO;^I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^Bulletin When Threshold Met^~59;"Threshold Met Bulletin"^SO^1:YES;0:NO;^I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^Bulletin At End Of Time Frame^~60;"End Of Time Frame Bulletin"^SO^1:YES;0:NO;^I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^Bulletin When Min Sample Met^~61;"Min Samp/Alert Lev Met Bulletin"^SO^1:YES;0:NO;^I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^Bulletin Mail Group^~62;"Bulletin Mail Group"^PAO^3.8:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;0^Mail Group Description^~62:3;"Mail Group Desc"^
 ;;1^Mail Group Member^62:,2,~.01;"Mail Group Menber"^PAO^200:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
 ;;1^Allow 'Duplicate' Fall Outs^~63;"Allow Duplicate Fall Outs"^SO^1:YES;0:NO;^I $D(Y(0))#2 S Y=$P(Y(0),U)
 ;;1^Other Data To Capture^30,~.01;"Other Data To Capture"^PAO^743.4:AEMNQZ^I $D(Y(0,0))#2 S Y=$P(Y(0,0),U)
