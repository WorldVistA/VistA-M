QACADHOC ;HISC/DAD-AD HOC REPORT INTERFACE FOR THE CONSUMER CONTACT FILE (#745.1) ;6/13/95  13:2
 ;;2.0;Patient Representative;**1,3,5,6,8,10,12,17**;07/25/1995
 ;;1.6;QM Integration Module;;03/28/1994
 ; *** Set up required and optional variables and call Ad Hoc Rpt Gen
 N DHIT,DIOEND,QA,QAQDIC,QAQMENU,QAQMHDR,QAQMRTN,QAQORTN,X
 S QAQMRTN="MENU^QACADHOC",QAQORTN="OTHER^QACADHOC",QAQDIC=745.1
 S QAQMHDR="Patient Representative"
 D ^QAQAHOC0
 Q
MENU ; *** Build the menu array
 S QAQMENU=1
 F QA=1:1 S X=$P($T(TEXT+QA),";;",2,99) Q:X=""  S QAQMENU(QAQMENU)=X,QAQMENU=QAQMENU+1
 Q
OTHER ; *** Set up other (optional) EN1^DIP variables, e.g.
 ; *** DCOPIES,DHD,DHIT,DIOBEG,DIOEND,DIS(),IOP,PG
 K QAQFOUND S QAQFOUND=0,DHIT="S QAQFOUND=1"
 S DIOEND="I 'QAQFOUND W !!,""No data found for this report !!"""
 Q
TEXT ;;*** Sort Yes/No ^ Menu Text ^ ~Field # ^ DIR(0)
 ;;0^Contact Number^~.01;"Contact Number"^NAO^-999999999:999999999:9^
 ;;1^Date of Contact^~1;"Date Of Contact"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Patient Name^~2;"Patient Name"^PAO^2:AEMQZ^D POINTER^QAQAHOC2
 ;;1^SSN^~3^FAO^1:60^
 ;;1^Date of Birth^~4;"Date of Birth"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Sex^~5;"Sex"^SOA^M:MALE;F:FEMALE;^I $D(Y(0)) S Y=Y(0)
 ;;1^Eligibility Status^~6;"Eligibility Status"^PAO^8:AEMQZ^D POINTER^QAQAHOC2
 ;;1^Category^~7;"Category"^PAO^408.32:AEMQZ^D POINTER^QAQAHOC2
 ;;1^Info Taken by^~8;"Info Taken by"^PAO^200:AEMQZ^D POINTER^QAQAHOC2
 ;;1^Entered by^~9;"Entered by"^PAO^200:AEMQZ^D POINTER^QAQAHOC2
 ;;0^Name of Contact^~10;"Name of Contact"^FAO^1:60^
 ;;0^Phone of Contact^~11;"Phone of Contact"^FAO^1:60^
 ;;1^Contact Made by^~12;"Contact Made by"^SOA^PA:Patient;RE:Relative;FR:Friend;CO:Congressional;VH:VISN/HQ;VO:Veterans Service Org.;AT:Atty/Guard/Consv/Trustee;DI:Director's Office - VAMC;ST:Staff - VAMC;OT:Other;^D SET^QAQAHOC2
 ;;1^Source of Contact(to 10/1/97)^~13;"Source of Contact"^SOA^L:Letter;W:Ward Visit;V:Visit;P:Phone;S:Survey;^D SET^QAQAHOC2
 ;;1^Source(s) of Contact^30,~.01;"Source(s) of Contact (after 9/1/97)"^SOA^L:Letter;W:Ward Visit;V:Visit;P:Phone;S:Survey;I:Internet;^D SET^QAQAHOC2
 ;;1^Location of Event^~14;"Location of Event"^PAO^44:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Treatment Status^~16.5;"Treatment Status"^SOA^I:Inpatient;O:Outpatient;D:Domiciliary;N:NHCU;L:Long Term Psych;E:Extended/Intermed. Care;H:HBHC;^D SET^QAQAHOC2
 ;;1^Employee^17,~.01;"Employee"^PAO^200:AEMQZ^D POINTER^QAQAHOC2
 ;;1^Refer Contact to^28,~.01;"Refer Contact to"^PAO^200:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Congressional Contact^~29;"Congressional Contact"^PAO^745.4:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Date Sent^~19;"Date Sent"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Date Due^~20.1;"Date Due"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Issue Codes^21,.01:,~.01;"Issue Codes"^PAO^745.2:AEMNQZ^I $D(Y(0)) S Y=$P(Y(0),U)
 ;;1^Serv/Sect Involved(to 10/1/97)^21,1,~.01;"Serv/Sect Involved"^POA^49:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Serv/Discipline Involved^21,3,~.01;"Section/Discipline Involved"^POA^745.55:AEMNQZ^D POINTER^QAQAHOC2
 ;;1^Disciplines^21,3,~1;"Discipline"^PAO^745.5:AEMZQ^D POINTER^QAQAHOC2
 ;;0^Issue Text^~22;"Issue Text"^
 ;;1^Qm Involvement^24,~.01;"QM Involvement"^SOA^1:Tort Claim;2:Incident Report (10-2633);3:Peer Review;4:Board of Investigation;5:Other;^D SET^QAQAHOC2
 ;;0^Resolution Comments^~25;"Resolution Comments"^
 ;;1^Date Resolved^~26;"Date Resolved"^DAO^::AETS^D DATE^QAQAHOC2
 ;;1^Status^~27;"Status"^SOA^O:Open;C:Closed;^D SET^QAQAHOC2
 ;;1^Code Status^21,~.01:4;"Code Status"^SOA^1:INACTIVE;N:NATIONAL;L:LOCATION;^D SET^QAQAHOC2
 ;;0^Code Definition^21,~.01:5;"Code Definition"
        ;;1^Refer to SEAT^~33;"Referred to SEAT"^SOA^Y:YES;N:NO;^D SET^QAQAHOC2
 ;;1^Division^~37;"Division"^PAO^4:AEMNQZ^D POINTER^QAQAHOC2
        ;;1^Level of Satisfaction^~36;"Level of Satisfaction"^SOA^1:Not at all satisfied;2:Slightly satisfied;3:Somewhat satisfied;4:Pretty satisfied;5:Very satisfied;6:Extremely satisifed;^D SET^QAQAHOC
 ;;1^Persian Gulf Service?^~32;"Persian Gulf Service?"^SOA^Y:YES;N:NO;^D SET^QAQAHOC2
 ;;1^Period of Service^~31;"Period of Service"^POA^21:AEMNQZ^D POINTER^QAQAHOC2
 ;;0^Issue Code Name^21,.01:2;"Issue Code Name"^PAO^745.2:AEMNQZ^
 ;;1^Internal Appeal^~43;"Internal Appeal"^SOA^Y:YES;N:NO;^D SET^QAQAHOC2
