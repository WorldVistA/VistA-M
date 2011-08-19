SPNADF6 ;SAN DIEGO/WDE AD HOC REPORT FUNCTIONAL STATUS FILE (#154.1) 07/31/02
 ;;2.0;Spinal Cord Dysfunction;**14,19,20**;01/02/1997
 ;;2.0;QM Integration Module;;Apr 06, 1994
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S SPNMRTN="MENU^SPNADF6",SPNORTN="OTHER^SPNADF",SPNDIC=154.1
 S SPNMHDR="Self Report of Function"
 D ^SPNAHOC0
 Q
MENU ; *** Build the menu array
 S SPNMENU=1
 F SP=1:1 S X=$P($T(TEXT+SP),";",3,99) Q:X=""  D
 . S SPNMENU(SPNMENU)=X,SPNMENU=SPNMENU+1
 . Q
OTHER ; *** Set up other (optional) EN1^DIP variables
 S DIS(0)="I $$EN2^SPNPRTMT(+$P($G(^SPNL(154.1,D0,0)),U))"
 S DISUPNO=0
 Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)           
 ;;1^Patient^~.01;"Patient"^PAO^2:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^SSN^~999.01^FAO^1:60^
 ;;1^Date of Birth^~999.02;"Date Of Birth"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Date of Death^~999.09;"Date Of Death"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Care Type^1003;"Care Type"^SAOM^1:INPATIENT;2:OUTPATIENT;3:ANNUAL EVALUATION;4:CONTINUUM OF CARE;^D SET^SPNAHOC2
 ;;1^Care Start Date^~1001;"Care Start Date"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Care End Date^~1002;"Care End Date"^DAO^::AETS^D DATE^SPNAHOC2
 ;;0^Record Type^~.02;"Record Type"^SAOM^1:Self Report of Function;2:FIM;3:ASIA;4:CHART;5:FAM;6:DIENER;7:DUSOI;8:Multiple Sclerosis;^D SET^SPNAHOC2
 ;;1^Score Type^.021;"Score Type"^PAO^154.3:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Division^~.023;"Division"^FAO^1:5
 ;;1^Disposition^~.024;"Disposition"^PAO^154.12:AEMNQZ^D POINTER^SPNAHOC2
 ;;1^Respondent Type^~.03;"Respondent Type"^SAOM^1:PATIENT;2:CLINICIAN;3:PROXY;^D SET^SPNAHOC2
 ;;1^Date Recorded^~.04;"Date Recorded"^DAO^::AETS^D DATE^SPNAHOC2
 ;;1^Mvment inside House^~.16;"move around inside of house"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Xfr Bed/Chr/Whlchr^~.13;"Xfer To Bed/Chair/Wheelchair"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Xfer Tub/Shower^~.15;"Xfer To Tub/Shower"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Xfer to Toilet^~.14;"Xfer To Toilet"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Toileting^~.1;"Toileting"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Bladder Management^~.11;"Bladder Management"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Bowel Management^~.12;"Bowel Management"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Eating^~.05;"Eating"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Grooming^~.06;"Grooming"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Bathing^~.07;"Bathing"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Dressing Upper Body^~.08;"Dressing Upper Body"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Dressing Lower Body^~.09;"Dressing Lower Body"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Walk/Wheelchair^~.16;"Walk/Wheelchair"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Method of Walk/Wheelchair^~.161;"Method Of Walk/Wheelchair"^SAOM^W:WALK;C:WHEELCHAIR;B:BOTH;^D SET^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Stairs^~.17;"Stairs"^PAO^154.11:AEMNQZ^D POINTER^SPNAHOC2|I $P(^(0),U,3)<3
 ;;1^Get 2 Places Otside Home^~2.01;"Get To Places Outside Of Home"^SAOM^1:WITHOUT HELP;2:WITH HELP;3:UNABLE;^D SET^SPNAHOC2
 ;;1^Shopping^~2.02;"Shopping"^SAOM^1:WITHOUT HELP;2:WITH HELP;3:UNABLE;^D SET^SPNAHOC2
 ;;1^Planning Cooking Meals^~2.03;"Planning And Cooking Own Meals"^SAOM^1:WITHOUT HELP;2:WITH HELP;3:UNABLE;^D SET^SPNAHOC2
 ;;1^Doing Housework^~2.04;"Doing Housework"^SAOM^1:WITHOUT HELP;2:WITH HELP;3:UNABLE;^D SET^SPNAHOC2
 ;;1^Handling Money^~2.05;"Handling Money"^SAOM^1:WITHOUT HELP;2:WITH HELP;3:UNABLE;^D SET^SPNAHOC2
 ;;1^Help During Last 2 Weeks^~2.08;"Help During Last 2 Weeks"^SAOM^1:YES;0:NO;^D SET^SPNAHOC2
 ;;1^Number of Hours of Help^~2.09;"Number Of Hours Of Help"^NAO^-999999999:999999999:9^
 ;;1^Hrs of Hlp Last 24hrs^~2.13;"Hours Of Help Within Last Day"^NAO^-999999999:999999999:9^
 ;;1^Method Ambulation Walking^~2.06;"Method Ambulation (Walking)"^SAOM^1:WITHOUT HELP;2:WITH DEVICE;3:CANNOT WALK;4:BEDRIDDEN;^D SET^SPNAHOC2
 ;;1^Method Ambulation Whlchr^~2.07;"Method Ambulation (Wheelchair)"^SAOM^1:MANUAL;2:MOTORIZED;3:DOES NOT USE W/CHR;4:BEDRIDDEN;^D SET^SPNAHOC2
