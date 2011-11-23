EEOEAHO1 ;HISC/DAD-AD HOC REPORT INTERFACE FOR THE EEO COMPLAINTS FILE (#785) ;03/02/94  07:44
 ;;2.0;EEO Complaint Tracking;;Apr 27, 1995
 ;;1.6V2;QM Integration Module;;02/22/1994
MENU ; *** Build the menu array
 F QA=1:1 S X=$P($T(TEXT+QA),";;",2,99) Q:X=""  S QAQMENU(QAQMENU)=X,QAQMENU=QAQMENU+1
 Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)
 ;;1^Investigator's Name^27.5,~.01;"Investigator's Name"^PAO^787.5:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Type^27.5,~2;"Type"^SO^1:ADHOC;2:RETIRED ANNUITANT;3:REGIONAL SPECIALIST;^D SET^QAQAHOC2
 ;;1^Investigator Dt Assigned^27.5,~1;"Investigator Dt Assigned"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Inv Finding^27.5,~4;"Inv Finding"^SO^F:Findings of Discrimination;N:No Findings of Discrimination;^D SET^QAQAHOC2
 ;;1^Inv Review Assigned To^27.5,~5;"Inv Review Assigned To"^PAO^787.5:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Dt Complainant Sent Adv/Rights^~41;"Dt Complainant Sent Adv/Rights"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Dt Compl Rec'd Advise/Rights^~40.5;"Dt Compl Rec'd Advise/Rights"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Compl. Makes Election^~40.6;"Date Compl. Makes Election"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Total Days Assign Inv.^~42;"Total Days Assign Inv."^FAO^1:60^
 ;;1^Date Eeoc Hearing Requested^~44;"Date Eeoc Hearing Requested"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Eeoc Hearing Conducted^~45;"Date Eeoc Hearing Conducted"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Total Days For Eeoc Hearing^~46;"Total Days For Eeoc Hearing"^FAO^1:60^
 ;;1^Eeoc Appeal^~46.2;"Eeoc Appeal"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Eeoc Appeal #2^~46.4;"Eeoc Appeal #2"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Final Agency Dec. Issued^~46.5;"Date Final Agency Dec. Issued"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Civil Action Filed^~47;"Date Civil Action Filed"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Closed^~48;"Date Closed"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Reason Closed^~49;"Reason Closed"^SO^1:SETTLEMENT;2:AGENCY DECISION;3:REJECTION BY OGC;4:CIVIL ACTION FILED;5:WITHDRAWAL;6:CANCELLATION;7:FAILURE TO PROSECUTE;8:OTHER;^D SET^QAQAHOC2
 ;;1^Total Processing Days^~50;"Total Processing Days"^FAO^1:60^
 ;;1^Total Counselor Report Days^~51;"Total Counselor Report Days"^FAO^1:60^
 ;;1^Total Days For Advise/Rights^~53;"Total Days For Advise/Rights"^FAO^1:60^
 ;;1^Total Days To Req Eeoc Hearing^~54;"Total Days To Req Eeoc Hearing"^FAO^1:60^
 ;;1^Total Days To Make Election^~55;"Total Days To Make Election"^FAO^1:60^
 ;;1^Total Days For Fad Decision^~56;"Total Days For Fad Decision"^FAO^1:60^
 ;;1^180 Days^~57;"180 Days"^FAO^1:60^
 ;;0^Recommended Info. Gathering^~60;"Recommended Info. Gathering"^
 ;;1^Corrective Action^61,~.01;"Corrective Action"^PAO^785.2:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Complaint Status^~63;"Complaint Status"^FAO^1:60^
 ;;1^180 Days off Site Processing^~64
