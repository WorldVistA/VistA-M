EEOEAHO2 ;HISC/DAD-AD HOC REPORT INTERFACE FOR THE EEO INFORMAL COMPLAINTS FILE (#785.5) ;02/16/95  11:03
 ;;2.0;EEO Complaint Tracking;**7**;Apr 27, 1995
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 S QAQMRTN="MENU^EEOEAHO2",QAQORTN="OTHER^EEOEAHO2",QAQDIC=785.5
 S QAQMHDR="EEO INFORMAL",QAQMMAX=30
 D REUSE^EEOEAHOC
 Q
MENU ; *** Build the menu array
 S QAQMENU=1
 F QA=1:1 S X=$P($T(TEXT+QA),";;",2,99) Q:X=""  S QAQMENU(QAQMENU)=X,QAQMENU=QAQMENU+1
 Q
OTHER ; *** Set up other (optional) EN1^DIP variables, e.g.
 ; *** DCOPIES,DHD,DHIT,DIOBEG,DIOEND,DIS(),IOP,PG
 K QAQFOUND S QAQFOUND=0,DHIT="S QAQFOUND=1"
 S DIOEND="I 'QAQFOUND W !!,""No data found for this report !!"""
 S DIS(0)="I $P($G(^EEO(785,D0,12)),U,2)'=""D""" Q
 Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)
 ;;1^Complainant^~.01;"Complainant"^FAO^1:60^
 ;;1^Case No.^~1.3;"Case No."^FAO^1:60^
 ;;1^Station^~2;"Station"^PAO^4:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Service^~5;"Service"^PAO^730:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Position/Grade^~6;"Position/Grade"^FAO^1:60^
 ;;1^Job Title^~6.5;"Job Title"^FAO^1:60^
 ;;1^Rep'S Name^~8;"Rep'S Name"^FAO^1:60^
 ;;0^Rep'S Phone No.^~9;"Rep'S Phone No."^FAO^1:60^
 ;;0^Rep'S Street Addr.^~10;"Rep'S Street Addr."^FAO^1:60^
 ;;0^Rep'S City Addr.^~11;"Rep'S City Addr."^FAO^1:60^
 ;;0^Rep'S State Addr.^~12;"Rep'S State Addr."^PAO^5:AEMNQZ^D POINTER^QAQAHOC2
 ;;0^Rep'S Zip Code^~13;"Rep'S Zip Code"^FAO^1:60^
 ;;1^Counselor'S Name^~14;"Counselor'S Name"^PAO^200:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Date Of Incident^~14.5;"Date Of Incident"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Initial Contact/Interview^~14.7;"Date Initial Contact/Interview"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Notice Of Final Interview^~15;"Date Notice Of Final Interview"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Of Informal Resolution^~15.5;"Date Of Informal Resolution"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Extension Requested^~15.7;"Date Extension Requested"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Length Of Extension Granted^~15.9;"Length Of Extension Granted"^NAO^-999999999:999999999:9^
 ;;1^Date Formal Complaint Filed^~16;"Date Formal Complaint Filed"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Union Grievence Filed^~16.05;"Date Union Grievence Filed"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Mspb Appeal Filed^~16.07;"Date Mspb Appeal Filed"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Couns. Informed Of F.C.^~16.5;"Date Couns. Informed Of F.C."^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Counselor Filed Report^~16.7;"Date Counselor Filed Report"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Issue Codes^17.5,~.01;"Issue Codes"^PAO^786:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Basis^18.5,~.01;"Basis"^PAO^785.1:AEMNQZ^D POINTER^QAQAHOC2
 ;;0^Issue Code Comments^~19;"Issue Code Comments"^FAO^1:60^
 ;;0^Narrative Information^~60;"Narrative Information"^
 ;;1^Corrective Action^61,~.01;"Corrective Action"^PAO^785.2:AEMNQZ^D POINTER^QAQAHOC2
 ;;0^Counselor Security^~98;"Counselor Security"^FAO^1:60^
