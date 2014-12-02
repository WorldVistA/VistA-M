DVBACER1 ;BEST/JFW - DEMTRAN CONTRACTED EXAM REPORTS ; 6/27/12 3:56pm
 ;;2.7;AMIE;**178,185,186**;Apr 10, 1995;Build 21
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  - RPC: DVBAD CONTRACTED EXAM REPORTS
 ;  
 ;  Creates Detailed, Summary, or Timeliness Contracted Exam Reports
 ;  for the Disability Examination Management Tracking, Referral and
 ;  Notification application (demTRAN).
 ;
 ;Input:
 ;     DVBALST:   Global array to hold results to be returned
 ;     DVBARTYP:  Report Type to Generate (Required)
 ;                 D : Detailed
 ;                 S : Summary
 ;                 T : Timeliness
 ;     DVBAFLTRS: Report Filters (Optional)
 ;        ("DATE")       = FM From Date ^ FM To Date (Inclusive) 
 ;        ("CONTRACTOR") = IEN of Contractor in 396.45
 ;        ("PENDING")    = 1 indicating Pending Exams Only ^
 ;                         # of Days Referral Exceeded (Optional)
 ;        ("SORT")       = 1 indicating Contractor sorted else
 ;                         Request DTM sorted (Detailed Reports Only)
 ;        ("DELIMITTED") = 1 indicating Report returned Delimitted
 ;                         (Detailed Reports Only)
 ;
CERPTS(DVBALST,DVBARTYP,DVBAFLTRS) ;Contracted Exam Reports
 N DVBAQ,DVBASDTE,DVBAEDTE,DVBACIEN,DVBAPEXMS,DVBAPDAYS,DVBAHFS
 N DVBARIEN,DVBAEIEN,DVBAENDE,DVBAGLBL,DVBARSLTS,DVBASCRH
 N DVBACSRT,DVBADLMT,X1,X2,X,%H,%Y
 N GETARY,ERARY,RSTAT
 K ^TMP($J,"DVBACER1")
 S DVBAHFS=$$GETHFS()
 S DVBASCRH=$NA(^TMP($J,"DVBASCRATCH"))
 S DVBAGLBL=$NA(^TMP($J,"DVBA"_$G(DVBARTYP)_"RPTS"))
 S DVBARSLTS=$NA(^TMP("DVBA"_$G(DVBARTYP)_"RSLTS",$J,1))
 K @DVBAGLBL,@DVBARSLTS,@DVBASCRH
 Q:($$OPENHFS("DVBRP",DVBAHFS,"W",DVBARSLTS))  ;Quit if error
 U IO
 ; Initial start values if filters undefined
 S (DVBAEDTE,DVBACIEN)=""
 S (DVBASDTE,DVBAPEXMS,DVBAPDAYS,DVBACSRT,DVBADLMT)=0
 ;
 ;Date filter defined, set loop conditions
 D:($D(DVBAFLTRS("DATE")))
 .S DVBASDTE=$P($G(DVBAFLTRS("DATE")),"^")_".2359"
 .S X1=DVBASDTE,X2=-1 D C^%DTC S DVBASDTE=X
 .S DVBAEDTE=$P($G(DVBAFLTRS("DATE")),"^",2)_".2359"
 ;Contractor filter defined
 S:($D(DVBAFLTRS("CONTRACTOR"))) DVBACIEN=$G(DVBAFLTRS("CONTRACTOR"))
 ;Pending Exam filter defined
 D:($D(DVBAFLTRS("PENDING")))
 .S DVBAPEXMS=1,DVBAPDAYS=+$P($G(DVBAFLTRS("PENDING")),"^",2)
 ;Sorting (Contractor or Request DTM - for Detailed Reports Only)
 S:($D(DVBAFLTRS("SORT"))) DVBACSRT=1
 ;Delimitted Output (for Detailed Reports Only)
 S:($D(DVBAFLTRS("DELIMITTED"))) DVBADLMT=1
 ;
 ;Get Contractor(s) list for Timeliness and Summary Reports
 ; if specific contractor NOT defined
 D:(($G(DVBARTYP)'="D")&(DVBACIEN']"")) CONLST(DVBACIEN,DVBARSLTS)
 ;
 ;Use "C" X-REF so results are in Date/Time Order
 F  S DVBASDTE=$O(^DVB(396.3,"C",DVBASDTE)) Q:('+DVBASDTE)!((DVBAEDTE]"")&(DVBASDTE>DVBAEDTE))  D
 .S DVBARIEN=""  ;In case there is more than 1 request ien for dtm
 .F  S DVBARIEN=$O(^DVB(396.3,"C",DVBASDTE,DVBARIEN)) Q:'+DVBARIEN  D
 ..;Use "C" X-REF for retrieving exams for request IEN
 ..I ($G(DVBARTYP)="T") D CERPTS2 Q
 ..S DVBAEIEN=""
 ..F  S DVBAEIEN=$O(^DVB(396.4,"C",DVBARIEN,DVBAEIEN)) Q:'+DVBAEIEN  D
 ...S DVBAENDE=$G(^DVB(396.4,DVBAEIEN,"CNTRCTR"))
 ...;Ignore exams that have NOT been contracted out
 ...;Q:($P(DVBAENDE,"^",2)']"")
 ...I ($P(DVBAENDE,"^",2)']"") Q
 ...;Ignore exams NOT for specified contractor if defined
 ...;Q:((DVBACIEN]"")&(DVBACIEN'=(+DVBAENDE)))
 ...I ((DVBACIEN]"")&(DVBACIEN'=(+DVBAENDE))) Q
 ...;DETAILED & SUMMARY REPORTING
 ...D:($G(DVBARTYP)'="T")
 ....S DVBAQ=0
 ....I (DVBAPEXMS) D  Q:(DVBAQ)  ;Pending Exams
 .....;Ignore Exams NOT received back from contractor
 .....S:($P(DVBAENDE,"^",3)]"") DVBAQ=1
 .....D:(('DVBAQ)&(DVBAPDAYS]""))
 ......;Ignore Pending Exams less than requested days
 ......S X1=DT,X2=$P(DVBAENDE,"^",2) D ^%DTC
 ......S:(X<=DVBAPDAYS) DVBAQ=1
 ....D:($G(DVBARTYP)="D") DRPTS(DVBACSRT,DVBARIEN,DVBAEIEN,DVBASCRH)
 ....D:($G(DVBARTYP)="S") SRPTS(DVBARIEN,DVBAENDE,DVBAGLBL,DVBARSLTS)
 ..D:($G(DVBARTYP)="T") TRPTS3(DVBAGLBL,DVBARSLTS)
 D:($G(DVBARTYP)="D") DSPLYDTL(DVBACSRT,DVBACIEN,DVBAPEXMS,DVBASCRH,DVBADLMT)  ;Rpt Details
 D CLOSEHFS("DVBRP",DVBAHFS,DVBARSLTS)
 S DVBALST=$NA(@DVBARSLTS)
 K @DVBAGLBL,@DVBASCRH
 Q
 ;
 ;
CERPTS2 ;Logic for timeliness report
 N EXSTAT
 K ^TMP($J,"DVBACER1")
 S DVBAEIEN=""
 F  S DVBAEIEN=$O(^DVB(396.4,"C",DVBARIEN,DVBAEIEN)) Q:'+DVBAEIEN  D
 .S DVBAENDE=$G(^DVB(396.4,DVBAEIEN,"CNTRCTR"))
 .;Ignore exams that have NOT been contracted out
 .Q:($P(DVBAENDE,"^",2)']"")
 .;Ignore exams NOT for specified contractor if defined
 .Q:((DVBACIEN]"")&(DVBACIEN'=(+DVBAENDE)))
 .;TIMELINESS REPORTING
 .;Innore exams that have been canceled
 .S EXSTAT=$P(^DVB(396.4,DVBAEIEN,0),"^",4)
 .Q:EXSTAT="X"!(EXSTAT="RX") 
 .D TRPTS2(DVBAENDE)
 D TRPTS3(DVBAGLBL,DVBARSLTS)
 Q
 ;
 ;Input  DVBACIEN - Specific Contrator Data Requested
 ;       DVBARSLTS - Global Refernece for results
 ;Output Global Array Entries Added for Contractor(s)
 ;       ^TMP("DVBATRSLTS",$J)
CONLST(DVBACIEN,DVBARSLTS) ;Get Contractor List
 ;Used in Timeliness and Summary Reports
 N DVBACNDE
 ;Specific Contractor Info Requested
 I (DVBACIEN]"") D  Q
 .S DVBACNDE=$G(^DVB(396.45,DVBACIEN,0))
 .S @DVBARSLTS@(DVBACIEN)=$P(DVBACNDE,"^")_"^"_$P(DVBACNDE,"^",3)_"^"
 ;All Contractor Info Requested
 S DVBACIEN=0 F  S DVBACIEN=$O(^DVB(396.45,DVBACIEN)) Q:'+DVBACIEN  D
 .S DVBACNDE=$G(^DVB(396.45,DVBACIEN,0))
 .;Create list of contractor info and initialize counters
 .; for the specific report to 0
 .S @DVBARSLTS@($P(DVBACNDE,"^"),DVBACIEN)=$P(DVBACNDE,"^")_"^"_$P(DVBACNDE,"^",3)_"^0"
 .S:($G(DVBARTYP)="S") @DVBARSLTS@($P(DVBACNDE,"^"),DVBACIEN)=@DVBARSLTS@($P(DVBACNDE,"^"),DVBACIEN)_"^0"
 Q
 ;
 ;Input  DVBACSRT - 1/0 if report should be sorted by Contractor
 ;                  Name (1) or by Request Date (0)
 ;       DVBARIEN - IEN of Request (396.3) associated with Exam
 ;       DVBAEIEN - IEN of Exam (396.4)
 ;       DVBASCRH - Global Reference for results (Scratch Global)
 ;Output Global Array Entry Added (Sorted) - ^TMP($J,"DVBASCRH")
DRPTS(DVBACSRT,DVBARIEN,DVBAEIEN,DVBASCRH) ; Detailed Report Processing
 N DVBACNME,DVBAENME,DVBARDTM,DVBAEXM
 ;Retrieve Exam Info
 D GETS^DIQ(396.4,DVBAEIEN_",",".03;100","E","DVBAEXM")
 S DVBACNME=$G(DVBAEXM(396.4,DVBAEIEN_",",100,"E"))  ;Contractor
 S:(DVBACNME']"") DVBACNME="UNKNOWN"
 S DVBAENME=$G(DVBAEXM(396.4,DVBAEIEN_",",.03,"E"))  ;Exam Name
 S:(DVBAENME']"") DVBAENME="UNKNOWN"
 S DVBAENME=$TR(DVBAENME,","," ")  ;Remove Commas
 S DVBARDTM=$P($G(^DVB(396.3,DVBARIEN,0)),"^",2)  ;Request DateTime
 S:('DVBACSRT) @DVBASCRH@(DVBARDTM,DVBARIEN,DVBAENME,DVBAEIEN)=""
 S:(DVBACSRT) @DVBASCRH@($TR(DVBACNME,","," "),DVBARDTM,DVBARIEN,DVBAENME,DVBAEIEN)=DVBACNME
 Q
 ;
 ;Input  DVBACSRT - 1/0 if report should be sorted by Contractor
 ;                  Name (1) or by Request Date (0)
 ;       DVBAEIEN  - IEN of Exam (396.4)
 ;       DVBAPEXMS - 1/0 Indicates if only pending exams report
 ;       DVBASCRH  - Global Reference for results (Scratch Global)
 ;       DVBADLMT  - 1/0 if report output should be delimitted
 ;                   Delimitted Output (1) or Formatted Output (0)
 ;Output Write Report Details
DSPLYDTL(DVBACSRT,DVBACIEN,DVBAPEXMS,DVBASCRH,DVBADLMT) ;Display Sorted Detailed Report Info
 N DVBAREF,DVBACNME,DVBARIEN,DVBAINFO,DVBAOFST
 N DVBASPCG,DVBALNE,DFN,VADM,X
 D DRPTSPCG(DVBACSRT,DVBADLMT,.DVBASPCG)
 S DVBAREF=DVBASCRH,DVBAOFST=0,(DVBACNME,DVBARIEN)=""
 S:('DVBACSRT) DVBAOFST=1
 ;Quit if no results found
 Q:('$D(@DVBASCRH))
 ;Report Column Header Info
 W:((DVBACIEN']"")&(DVBACSRT)) "Contractor",$S(DVBADLMT:"^",1:"")
 W:((DVBACIEN']"")&(DVBACSRT)&('DVBADLMT)) !
 W ?DVBASPCG(1),"Request Date",$S(DVBADLMT:"^",1:""),?DVBASPCG(2),"SSN",$S(DVBADLMT:"^",1:"")
 W ?DVBASPCG(3),"Patient Name",$S(DVBADLMT:"^",1:""),?DVBASPCG(4),"Status",$S(DVBADLMT:"^",1:"")
 W:('DVBADLMT) !
 W ?DVBASPCG(5),"Examinations",$S(DVBADLMT:"^",1:"")
 W:(('DVBACSRT)&(DVBACIEN']"")) ?DVBASPCG(6),"Contractor",$S(DVBADLMT:"^",1:"")
 W ?DVBASPCG(7),"Referred"
 S DVBALNE=(DVBASPCG(7)+18)
 D:('DVBAPEXMS) 
 .W ?DVBASPCG(8),$S(DVBADLMT:"^",1:""),"Received"
 .S DVBALNE=(DVBASPCG(8)+12)
 S X="" S $P(X,"-",DVBALNE)="-" W:('DVBADLMT) !,X  ;Header Line
 F  S DVBAREF=$Q(@DVBAREF) Q:(DVBAREF'[$P(DVBASCRH,")"))  D
 .;Display Contractor Name, if NOT specific contractor report
 .D:((DVBACIEN']"")&(DVBACSRT)&(DVBADLMT))  ; Delimitted Output
 ..W !,@DVBAREF_"^"
 .D:((DVBACNME'=@DVBAREF)&(DVBACIEN']"")&(DVBACSRT)&('DVBADLMT))  ;Formatted Output
 ..W:(DVBACNME]"") !  ;Extra Line Space between Contractors
 ..S DVBACNME=@DVBAREF
 ..W !,DVBACNME
 .;Display Request Info (Multiple Exams)
 .D:(DVBARIEN'=$P(DVBAREF,",",(5-DVBAOFST)))
 ..S DVBARIEN=$P(DVBAREF,",",(5-DVBAOFST))
 ..S DFN=+$G(^DVB(396.3,DVBARIEN,0))  ; Patient
 ..D DEM^VADPT  ;DBIA: 10061
 ..D GETS^DIQ(396.3,DVBARIEN_",","17","E","DVBAINFO")
 ..D:('DVBADLMT)  ;Formatted Report
 ...W !?DVBASPCG(1),$$FMTE^XLFDT($P(DVBAREF,",",(4-DVBAOFST)),"M")  ;No Seconds
 ...W ?DVBASPCG(2),$P($G(VADM(2)),"^",2),?DVBASPCG(3),$G(VADM(1))
 ...W ?DVBASPCG(4),$G(DVBAINFO(396.3,DVBARIEN_",",17,"E"))
 .D:(DVBADLMT)  ;Detailed Report
 ..W:'((DVBACIEN']"")&(DVBACSRT)) !
 ..W $$FMTE^XLFDT($P(DVBAREF,",",(4-DVBAOFST)),"M")_"^"  ;No Seconds
 ..W $P($G(VADM(2)),"^",2)_"^"_$G(VADM(1))_"^"
 ..W $G(DVBAINFO(396.3,DVBARIEN_",",17,"E"))_"^"
 .;Exam Info for Request
 .D EXMINFO(DVBAPEXMS,+$P(DVBAREF,",",(7-DVBAOFST)),DVBACSRT,DVBADLMT,.DVBASPCG)
 K DVBAINFO,VADM
 Q
 ;
 ;Input  DVBAPEXMS - 1/0 Indicates if only pending exams report
 ;       DVBAEIEN  - IEN of Exam (396.4)
 ;       DVBACSRT  - 1/0 if report should be sorted by Contractor
 ;                   Name (1) or by Request Date (0)
 ;       DVBADLMT  - 1/0 if report output should be delimitted
 ;                   Delimitted Output (1) or Formatted Output (0)
 ;       DVBASPCG  - Array to store spacing (By Ref)
 ;Output Write EXAM Info for request to report
EXMINFO(DVBAPEXMS,DVBAEIEN,DVBACSRT,DVBADLMT,DVBASPCG) ;Display Exam Info
 N DVBAEXM
 ;Retrieve exam info for display on report
 D GETS^DIQ(396.4,DVBAEIEN_",",".03;100;101;102","EI","DVBAEXM")
 W:('DVBADLMT) !
 W ?DVBASPCG(5),$G(DVBAEXM(396.4,DVBAEIEN_",",.03,"E")),$S(DVBADLMT:"^",1:"")
 W:('DVBACSRT) ?DVBASPCG(6),$G(DVBAEXM(396.4,DVBAEIEN_",",100,"E")),$S(DVBADLMT:"^",1:"")
 W ?DVBASPCG(7),$$FMTE^XLFDT($P($G(DVBAEXM(396.4,DVBAEIEN_",",101,"I")),"@"),"M"),$S(DVBADLMT:"^",1:"")
 W:('DVBAPEXMS) ?DVBASPCG(8),$P($G(DVBAEXM(396.4,DVBAEIEN_",",102,"E")),"@")
 Q
 ;
 ;Input  DVBACSRT - 1/0 if report should be sorted by Contractor
 ;                  Name (1) or by Request Date (0)
 ;       DVBADLMT - 1/0 if report output should be delimitted
 ;                  Delimitted Output (1) or Formatted Output (0)
 ;       DVBASPCG - Array to store spacing (By Ref)
DRPTSPCG(DVBACSRT,DVBADLMT,DVBASPCG) ;Setup Detailed Report Spacing
 N DVBAOFST,DVBAI
 S DVBAOFST=0 S:('DVBACSRT&'DVBADLMT) DVBAOFST=3
 K DVBASPCG
 D:(DVBADLMT)
 .F DVBAI=1:1:8  S DVBASPCG(DVBAI)=0
 D:('DVBADLMT)
 .S DVBASPCG(1)=3-DVBAOFST,DVBASPCG(2)=23-DVBAOFST
 .S DVBASPCG(3)=36-DVBAOFST,DVBASPCG(4)=68-DVBAOFST
 .S DVBASPCG(5)=5-DVBAOFST,DVBASPCG(6)=70-DVBAOFST
 .S:(DVBACSRT) DVBASPCG(7)=70-DVBAOFST,DVBASPCG(8)=91-DVBAOFST
 .S:('DVBACSRT) DVBASPCG(7)=101,DVBASPCG(8)=121
 Q
 ;
 ;Input  DVBARIEN - IEN of Request (396.3) associated with Exam
 ;       DVBACNDE - CNTRCTR Node for Exam IEN in 396.4
 ;       DVBAGLBL - Global Reference for Requests Counted
 ;       DVBARSLTS - Global Reference for results
 ;Output Global Array Entries Updated for Contractor if applicable
 ;       ^TMP($J,"DVBATRPTS") / ^TMP("DVBATRSLTS",$J)
SRPTS(DVBARIEN,DVBACNDE,DVBAGLBL,DVBARSLTS) ;Summary Report Processing
 N DVBACNTR,DVBACNME
 S DVBACNME=$P($G(^DVB(396.45,+$P(DVBACNDE,"^"),0)),"^")
 ;Retrieve current number of exams referred by contractor
 S DVBACNTR=$P($G(@DVBARSLTS@(DVBACNME,+$P(DVBACNDE,"^"))),"^",3)
 ;Increment Number of Exams referred for contractor
 S $P(@DVBARSLTS@(DVBACNME,+$P(DVBACNDE,"^")),"^",3)=DVBACNTR+1
 ;Increment 2507 Request Counter if IEN NOT already counted for Contractor
 D:('$D(@DVBAGLBL@(+$P(DVBACNDE,"^"),DVBARIEN)))
 .S @DVBAGLBL@(+$P(DVBACNDE,"^"),DVBARIEN)=""  ;Add request IEN to list
 .S DVBACNTR=$P($G(@DVBARSLTS@(DVBACNME,+$P(DVBACNDE,"^"))),"^",4)
 .;Increment # of 2507 Request referred to contractor
 .S $P(@DVBARSLTS@(DVBACNME,+$P(DVBACNDE,"^")),"^",4)=DVBACNTR+1
 Q
 ;
 ;Input  DVBACNDE - CNTRCTR Node for Exam IEN in 396.4
 ;       DVBAGLBL - Global Reference for Timeliness counters
 ;       DVBARSLTS - Global Reference for results
 ;Output Global Array Entries Updated for Contractor if applicable
 ;       ^TMP($J,"DVBATRPTS") / ^TMP("DVBATRSLTS",$J)
TRPTS(DVBACNDE,DVBAGLBL,DVBARSLTS,DVBATVAL) ;Timeliness Report Processing
 N DVBACNME,DVBANDAYS,DVBANEXMS
 ;Ignore Exams NOT returned (Checked-In) by Contractor
 S DVBANDAYS=+$G(@DVBAGLBL@(+$P(DVBACNDE,"^"),"DAYS"))
 S DVBANEXMS=+$G(@DVBAGLBL@(+$P(DVBACNDE,"^"),"EXMS"))
 ;Increment Timeliness Counter (Total # of Days)
 S @DVBAGLBL@(+$P(DVBACNDE,"^"),"DAYS")=DVBANDAYS+DVBATVAL
 ;Increment Number of Exams Found
 S @DVBAGLBL@(+$P(DVBACNDE,"^"),"EXMS")=DVBANEXMS+1
 S DVBACNME=$P($G(^DVB(396.45,+$P(DVBACNDE,"^"),0)),"^")
 ;Update Average Timeliness result for Contractor
 S $P(@DVBARSLTS@(DVBACNME,+$P(DVBACNDE,"^")),"^",3)=$FN((DVBANDAYS+DVBATVAL)/(DVBANEXMS+1),"",0)
 Q
 ;
TRPTS2(DVBACNDE) ;Timeliness include logic
 N DVBACNME,DVBATVAL,DVBANDAYS,DVBANEXMS,X1,X2,X,%Y
 N DVBAEXM2,STAT
 K ^TMP($J,"DVBACER1.FLAG")
 D GETS^DIQ(396.4,DVBAEIEN_",",".03;.04;100;101;102","EI","DVBAEXM2")
 S STAT=$G(DVBAEXM2(396.4,DVBAEIEN_",",.04,"I"))
 S CNTR=$G(DVBAEXM2(396.4,DVBAEIEN_",",100,"I")) S:$G(CNTR)="" CNTR="X"
 S X1=$P(DVBACNDE,"^",3),X2=$P(DVBACNDE,"^",2) D ^%DTC
 I $P(DVBACNDE,"^",3)="" S ^TMP($J,"DVBACER1.FLAG",CNTR)=1
 S DVBATVAL=X  ;# Days between CheckIn and CheckOut
 S:DVBATVAL="" DVBATVAL=0
 S ^TMP($J,"DVBACER1",CNTR,DVBATVAL)=DVBACNDE_"|"_STAT
 Q
 ;
TRPTS3(DVBAGLBL,DVBARSLTS) ;Timeliness calculation section
 Q:'$D(^TMP($J,"DVBACER1"))
 N OPENEXM,CNTR,DVBATVAL
 S CNTR="" F  S CNTR=$O(^TMP($J,"DVBACER1",CNTR)) Q:CNTR=""  D
 .Q:CNTR="X"
 .Q:$G(^TMP($J,"DVBACER1.FLAG",CNTR))=1
 .S OPENEXM(CNTR)=0
 .S DVBATVAL="" F  S DVBATVAL=$O(^TMP($J,"DVBACER1",CNTR,DVBATVAL)) Q:DVBATVAL=""!(OPENEXM(CNTR)=1)  D
 ..I $P(^TMP($J,"DVBACER1",CNTR,DVBATVAL),"|",2)'="C" S OPENEXM(CNTR)=1 Q
 S CNTR="" F  S CNTR=$O(OPENEXM(CNTR)) Q:CNTR=""  D
 .Q:OPENEXM(CNTR)=1
 .S DVBATVAL=$O(^TMP($J,"DVBACER1",CNTR,""),-1),DVBACNDE=$P(^TMP($J,"DVBACER1",CNTR,DVBATVAL),"|",1) D 
 ..Q:DVBATVAL=0
 ..D TRPTS(DVBACNDE,DVBAGLBL,DVBARSLTS,DVBATVAL)
 K ^TMP($J,"DVBACER1")
 K ^TMP($J,"DVBACER1.FLAG")
 ;
GETHFS() ;Get HFS File Name
 N DVBAH
 S DVBAH=$H
 Q "DVBA_"_$J_"_"_$P(DVBAH,",")_"_"_$P(DVBAH,",",2)_".DAT"
 ;
OPENHFS(DVBAHNDL,DVBAHFS,DVBAMODE,DVBARSLTS) ;Open HFS File
 N DVBAERR,POP
 S DVBAERR=0
 D OPEN^%ZISH(DVBAHNDL,,DVBAHFS,$G(DVBAMODE,"W")) D:POP  Q:POP
 .S DVBAERR=1,@DVBARSLTS@(1)="0^Unable to open HFS file."
 Q DVBAERR
 ;
CLOSEHFS(DVBAHNDL,DVBAHFS,DVBARSLTS) ;Close HFS and unload data
 N DVBADEL,X,%ZIS
 D CLOSE^%ZISH(DVBAHNDL)
 S DVBADEL(DVBAHFS)=""
 S X=$$FTG^%ZISH(,DVBAHFS,$NA(@DVBARSLTS@(1)),4)
 S X=$$DEL^%ZISH(,$NA(DVBADEL))
 Q
 ;
