QAOSAHO2 ;HISC/DAD-AD HOC REPORT INTERFACE FOR THE QA OCCURRENCE SCREEN FILE (#741) ;2/19/93  15:42
 ;;3.0;Occurrence Screen;;09/14/1993
MENU ;
 F QA=1:1 S X=$P($T(TEXT+QA),";;",2,99) Q:X=""  S QAQMENU(QA)=X
 Q
TEXT ;; SORT ^ MENU TEXT ^ FIELD # ^ DIR(0)
 ;;1^Occurrence Screen^~3;"Screen"^PAO^741.1:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Patient Name^~.01;"Patient"^PAO^2:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Social Security Number^~.01:.09;"SSN"^FAO^9:9^
 ;;1^Date of Occurrence^~1;"Occurrence Date"^DAO^::EX^D DATE^QAQAHOC2
 ;;1^Screen Status^~3:,100;"Screen Status"^SO^1:INACTIVE;N:NATIONAL;L:LOCAL;^D SET^QAQAHOC2
 ;;1^Occurrence Identifier^~2;"Occurrence ID"^FAO^7:7^
 ;;1^Associated Admission^~.02;"Associated Admission"^DAO^::EX^D DATE^QAQAHOC2
 ;;1^Severity of Outcome^~19:1;"Severity of Outcome"^PAO^741.8:AEMQZ^S:$D(Y(0))#2 Y=$P(Y(0),U,2)
 ;;1^Ward/Clinic^~4;"Ward/Clinic"^PAO^44:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Service/Section^~5;"Service/Section"^PAO^49:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Bed Service^~4:,42:,.03;"Bed Service"^SO^M:MEDICINE;S:SURGERY;P:PSYCHIATRY;NH:NHCU;NE:NEUROLOGY;I:INTERMEDIATE MED;R:REHAB MEDICINE;SCI:SPINAL CORD INJURY;D:DOMICILIARY;B:BLIND REHAB;NC:NON-COUNT;^D SET^QAQAHOC2
 ;;1^Clinic Service^~4:9;"Clinic Service"^SO^^D SET^QAQAHOC2
 ;;1^Treating Specialty^~6;"Treating Spec"^PAO^45.7:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Medical Team^~7;"Med Team"^PAO^741.93:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Attending Physician^~8;"Attending Phys"^PAO^200:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Resident/Provider^~9;"Res/Prov"^PAO^200:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Status (Open,Closed,Deleted)^~11;"Status"^SO^0:OPEN;1:CLOSED;2:DELETED;^D SET^QAQAHOC2
 ;;1^Final Disposition Date^~14;"Final Disp Date"^DAO^::EX^D DATE^QAQAHOC2
 ;;1^Final Disposition Authority^~16;"Final Disp Authority"^PAO^741.2:AEMQZ^D POINTER^QAQAHOC2
 ;;1^Total Elapsed Days^~15;"Total Elapsed Days"^NAO^0:999:0^
 ;;1^Review Level (Clin,Peer,Mgmt)^10,~.01;"Revr Level"^PAO^741.2:AEMQZ^D POINTER^QAQAHOC2
 ;;1^Reviewer Name^10,~.02;"Revr Name"^PAO^200:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Reviewer Service^10,~.03;"Revr Serv"^PAO^49:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Reviewer Findings^10,~4:1;"Revr Findings"^PAO^741.6:AEMQZ^S:$D(Y(0))#2 Y=$P(Y(0),U,2)
 ;;1^Reviewer Actions^10,5,~.01:2;"Revr Actions"^PAO^741.7:AEMQZ^S:$D(Y(0))#2 Y=$P(Y(0),U,2)
 ;;0^Reviewer Comments^10,~10;"Reviewer Comments"^
 ;;1^Date Review Completed^10,~1;"Date Review Completed"^DAO^::EX^D DATE^QAQAHOC2
 ;;1^Reviewer Elapsed Days^10,~8;"Reviewer Elapsed Days"^NAO^0:999:0^
 ;;1^Primary Reason Clin Referral^10,~3;"Primary Reason Clin Referral"^PAO^741.4:AEMQZ^S:$D(Y(0))#2 Y=$P(Y(0),U,2)
 ;;1^Reason for Exception^10,2,~.01;"Reason for Exception"^PAO^741.5:AEMQZ^S:$D(Y(0))#2 Y=$P(Y(0),U,2)
 ;;1^Final Peer Review Per Service^10,~9;"Final Peer Rev/Serv"^SO^1:YES;0:NO;^D SET^QAQAHOC2
 ;;1^Committee^17,~.01;"Committee"^PAO^741.97:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Committee Confirmed Issue^17,~4;"Cmte Confirmed Issue"^SO^1:EQUIPMENT PROBLEMS;2:SYSTEM PROBLEMS;3:EQUIPMENT & SYSTEM PROBLEMS;4:NONE;^D SET^QAQAHOC2
 ;;0^Committee Comments^17,~10;"Committee Comments"^
 ;;1^Peer Attrib (Individual)^24,~.01;"Attrib (Individual)"^PAO^200:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Serv Peer Attrib (Individual)^24,~.02;"Serv Peer Attrib (Individual)"^PAO^49:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Peer Attrib (Med Team)^25,~.01;"Attrib (Med Team)"^PAO^200:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Serv Peer Attrib (Med Team)^25,~.02;"Serv Peer Attrib (Med Team)"^PAO^49:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Peer Attrib (Hosp Loc)^26,~.01;"Attrib (Hosp Loc)"^PAO^200:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Serv Peer Attrib (Hosp Loc)^26,~.02;"Serv Peer Attrib (Hosp Loc)"^PAO^49:AEMNQZ^D POINTER^QAQAHOC2
