EEOEAHOC ;HISC/DAD-AD HOC REPORT INTERFACE FOR THE EEO COMPLAINTS FILE (#785) ;03/02/94  07:44
 ;;2.0;EEO Complaint Tracking;;Apr 27, 1995
 ;;1.6V2;QM Integration Module;;02/22/1994
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S X="QAQAHOC0" X ^%ZOSF("TEST") I $T'=1 W !!!,"The routine ^QAQAHOC0 from the QA Module must be present to run this option.",!! Q
 S DIR(0)="SAO^1:FORMAL;2:COUNSELOR"
 S DIR("B")="FORMAL",DIR("A")="Generate EEO Adhoc report: "
 S DIR("A",1)="  Choose From One of the Following Selections:",DIR("A",1.5)=" "
 S DIR("A",2)="    1.  FORMAL INFORMATION",DIR("A",3)="    2.  COUNSELOR INFORMATION",DIR("A",4)=" " D ^DIR Q:Y["^"
 K DIR I Y>1 D ^EEOEAHO2 Q
 S QAQMRTN="MENU^EEOEAHOC",QAQORTN="OTHER^EEOEAHOC",QAQDIC=785
 S QAQMHDR="EEO ADHOC REPORT",QAQMMAX=73
REUSE D ^QAQAHOC0
 K QAQDIC,QAQFOUND,QAQMENU,QAQMHDR,QAQMMAX,QAQORTN,QA Q
MENU ; *** Build the menu array
 S QAQMENU=1
 F QA=1:1 S X=$P($T(TEXT+QA),";;",2,99) Q:X=""  S QAQMENU(QAQMENU)=X,QAQMENU=QAQMENU+1
 G MENU^EEOEAHO1
OTHER ; *** Set up other (optional) EN1^DIP variables, e.g.
 ; *** DCOPIES,DHD,DHIT,DIOBEG,DIOEND,DIS(),IOP,PG
 K QAQFOUND S QAQFOUND=0,DHIT="S QAQFOUND=1"
 S DIOEND="I 'QAQFOUND W !!,""No data found for this report !!"""
 S DIS(0)="I $P($G(^EEO(785,D0,12)),U,2)'=""D""" Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)
 ;;1^Complainant^~.01;"Complainant"^FAO^1:60^
 ;;1^State^~.09;"State"^PAO^5:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Case^~1.1;"Case"^FAO^1:60^
 ;;1^Oeo Number^~1.2;"Oeo Number"^FAO^1:60^
 ;;1^Case No.^~1.3;"Case No."^FAO^1:60^
 ;;1^Station^~2;"Station"^PAO^4:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Service^~5;"Service"^PAO^730:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Rep's Name^~8;"Rep's Name"^FAO^1:60^
 ;;0^Rep's Phone No.^~9;"Rep's Phone No."^FAO^1:60^
 ;;0^Rep's Street Addr.^~10;"Rep's Street Addr."^FAO^1:60^
 ;;0^Rep's City Addr.^~11;"Rep's City Addr."^FAO^1:60^
 ;;0^Rep's State Addr.^~12;"Rep's State Addr."^PAO^5:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Counselor'S Name^~14;"Counselor'S Name"^PAO^200:AEMNQZ^D POINTER^QAQAHOC2
 ;;0^Rep's Zip Code^~13;"Rep's Zip Code"^FAO^1:60^
 ;;1^Total Counselor Days^~14.1;"Total Counselor Days"^FAO^1:60^
 ;;1^Date Of Incident^~14.5;"Date Of Incident"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Initial Contact/Interview^~14.7;"Date Initial Contact/Interview"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Notice Of Final Interview^~15;"Date Notice Of Final Interview"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Request For Add'l Info^~15.3;"Date Request For Add'l Info"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Of Informal Resoulution^~15.5;"Date Of Informal Resoulution"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Formal Complaint Filed^~16;"Date Formal Complaint Filed"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Dt Filed Union Grievence^~16.05;"Dt Filed Union Grievence"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Dt Filed Appeal With Mspb^~16.07;"Dt Filed Appeal With Mspb"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Office Complaint Filed With^~16.3;"Office Complaint Filed With"^SO^OEO:Office of Equal Opportunity;CO:Central Office;STN:Station;SEC:Secretary;^D SET^QAQAHOC2
 ;;1^Dt Counselor Informed Of F.C.^~16.5;"Dt Counselor Informed Of F.C."^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Dt Counselor Filed Report^~16.7;"Dt Counselor Filed Report"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Dt Complaint Rec'd By Eeo Off.^~16.75;"Dt Complaint Rec'd By Eeo Off."^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Issue Codes^17.5,~.01;"Issue Codes"^PAO^786:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Date Occured^17.5,~1;"Date Occured"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Basis^18.5,~.01;"Basis"^PAO^785.1:AEMNQZ^D POINTER^QAQAHOC2
 ;;0^Issue Code Comments^~19;"Issue Code Comments"^FAO^1:60^
 ;;1^Date Of Letter Of Acknow.^~20;"Date Of Letter Of Acknow."^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date To Ogc For Acc/Rej^~21;"Date To Ogc For Acc/Rej"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Accepted By Ogc^~22;"Date Accepted By Ogc"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Total Days Ogc Acc/Rej^~23;"Total Days Ogc Acc/Rej"^FAO^1:60^
 ;;1^Date Dismissed By Ogc^~22.3;"Date Dismissed By Ogc"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date To Ogc For Final Decision^~23.5;"Date To Ogc For Final Decision"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Total Days/Ogc Final Decision^~23.6;"Total Days/Ogc Final Decision"^FAO^1:60^
 ;;1^Date Complaint Accepted By Stn^~24;"Date Complaint Accepted By Stn"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Total Days Acceptance^~25;"Total Days Acceptance"^FAO^1:60^
 ;;1^Date Investigator Requested^~26;"Date Investigator Requested"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Initial Inv Date Assigned^~29;"Initial Inv Date Assigned"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Inv Rpt Rc'd Date^~32;"Inv Rpt Rc'd Date"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Total Investigation Days^~33;"Total Investigation Days"^FAO^1:60^
