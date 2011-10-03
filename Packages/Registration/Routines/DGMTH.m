DGMTH ;ALB/CJM/TDM MEANS TEST HARDSHIP ; 8/29/02 4:54pm
 ;;5.3;Registration;**182,456**;Aug 13, 1993
 ;
FIND(DFN,DATE,STATUS) ;
 ;Finds the primary means test for the specified patient and date.
 ;
 ;Input:
 ;  DFN
 ;  DATE - date to look for the MT, DT assumed if not passed (optional)
 ;Output:
 ;  Function Value - 0 if no MT found, the ien otherwise
 ;  STATUS - the status code of the MT (optional, pass by reference)
 ;
 N NODE
 ;
 S NODE=$$LST^DGMTU(DFN,$G(DATE),1)
 S STATUS=$P(NODE,"^",4)
 Q +NODE
 ;
GET(MTIEN,HARDSHIP) ;
 ;Given the ien of a MT (MTIEN), returns the hardship information
 ;
 ;Output:
 ;  Function Value - returns 0 if there is no hardship determination, 1 otherwise
 ;  HARDSHIP(
 ;  "HARDSHIP?") - 0 or 1, corresponding to the HARDSHIP? field
 ;  "EFFECTIVE") - the effective date of the hardship
 ;  "SITE") - the stations number of the site that granted the hardship
 ;  "BY") - the DUZ of the person that entered the hardship
 ;  "REVIEW") - the review date
 ;  "CURRENT STATUS") - patient's current MT status
 ;  "DFN") - patient's DFN
 ;  "TEST DATE") - DATE OF TEST
 ;  "CTGRY CHNGD BY") - DUZ of person who last changed the category
 ;  "DT/TM CTGRY CHNGD") -
 ;  "AGREE") - AGREED TO PAY DEDUCTIBLE
 ;  "MTIEN") - IEN of the means test
 ;  "TEST STATUS") - TEST DETERMINED STATUS
 ;  "REASON") - Hardship Reason
 ;
 N NODE0,NODE2
 S (NODE0,NODE2)=""
 I MTIEN D
 .S NODE0=$G(^DGMT(408.31,MTIEN,0))
 .S NODE2=$G(^DGMT(408.31,MTIEN,2))
 S HARDSHIP("MTIEN")=MTIEN
 S HARDSHIP("TEST DATE")=$P(NODE0,"^")
 S HARDSHIP("CURRENT STATUS")=$P(NODE0,"^",3)
 S HARDSHIP("CTGRY CHNGD BY")=$P(NODE0,"^",8)
 S HARDSHIP("DT/TM CTGRY CHNGD")=$P(NODE0,"^",9)
 S HARDSHIP("AGREE")=$P(NODE0,"^",11)
 S HARDSHIP("TEST STATUS")=$P(NODE2,"^",3)
 S HARDSHIP("DFN")=$P(NODE0,"^",2)
 S HARDSHIP("EFFECTIVE")=$P(NODE2,"^")
 S HARDSHIP("SITE")=$P(NODE2,"^",4)
 S HARDSHIP("BY")=$P(NODE0,"^",22)
 S HARDSHIP("HARDSHIP?")=$P(NODE0,"^",20)
 S HARDSHIP("REVIEW")=$P(NODE0,"^",21)
 S HARDSHIP("YEAR")=$S(+NODE0:($E(NODE0,1,3)-1),1:"")
 S HARDSHIP("REASON")=$P(NODE2,"^",9)
 Q +HARDSHIP("HARDSHIP?")
 ;
FIELD(SUB) ;
 ;Given the subscript used, returns the field number
 I SUB="EFFECTIVE" Q 2.01
 I SUB="SITE" Q 2.04
 I SUB="BY" Q .22
 I SUB="REASON" Q 2.09
 Q $S(SUB="HARDSHIP?":.2,SUB="REVIEW":.21,SUB="DFN":.02,SUB="CURRENT STATUS":.03,SUB="TEST STATUS":2.03,SUB="TEST DATE":.01,SUB="CTGRY CHNGD BY":.08,SUB="DT/TM CTGRY CHNGD":.09,SUB="AGREE":.11,1:"")
 ;
EXT(SUB,VAL) ;
 ;Returns the external value of a field, given the subscript and the internal value
 ;
 Q:$$FIELD(SUB) $$EXTERNAL^DILFD(408.31,$$FIELD(SUB),"F",VAL)
 Q:((SUB="YEAR")&(VAL)) (+VAL)+1700
 Q ""
 ;
STORE(HARDSHIP,ERROR) ;
 ;Stores the hardship
 ;
 ;Input:
 ;  HARDSHIP -  array containing hardship determination
 ;Output:
 ;  Function Value - 0 on failure, 1 on success
 ;  ERROR -an error message upon failure (optional,pass by reference)
 ;
 N DATA,SUB
 S SUB=""
 F SUB="EFFECTIVE","SITE","BY","HARDSHIP?","REVIEW","CURRENT STATUS","CTGRY CHNGD BY","DT/TM CTGRY CHNGD","AGREE","REASON" S DATA($$FIELD(SUB))=HARDSHIP(SUB)
 Q $$UPD^DGENDBS(408.31,HARDSHIP("MTIEN"),.DATA,.ERROR)
 ;
DELETE(HARDSHIP,NOTIFY,ERROR) ;
 ;Deletes the hardship, then calls MT Event Driver
 ;Input:
 ;  HARDSHIP - hardship array, pass by reference
 ;  NOTIFY - if NOTIFY=1, means to notify HEC of deletion
 ;Output: 
 ;  Function Value - 1 on success, 0 on failure
 ;  ERROR - error message (pass by reference)
 ;
 N SUB,CURSTAT,TESTSTAT,SUCCESS
 S SUCCESS=0
 D PRIOR^DGMTHL1(.HARDSHIP)
 S CURSTAT=$$GETCODE(HARDSHIP("CURRENT STATUS"))
 S TESTSTAT=$$GETCODE(HARDSHIP("TEST STATUS"))
 S SUB=""
 F SUB="EFFECTIVE","SITE","BY","REVIEW","REASON" S HARDSHIP(SUB)=""
 S HARDSHIP("HARDSHIP?")=0
 I (CURSTAT="A")!(CURSTAT="G") D
 .I (TESTSTAT="")!(TESTSTAT="C")!(TESTSTAT="P")!(TESTSTAT="G") D
 ..I (TESTSTAT'="") S HARDSHIP("CURRENT STATUS")=HARDSHIP("TEST STATUS") Q
 ..N NODE0
 ..S NODE0=$G(^DGMT(408.31,HARDSHIP("MTIEN"),0))
 ..I CURSTAT="A",(($P(NODE0,U,4)-$P(NODE0,U,15))'>$P(NODE0,U,27)) S HARDSHIP("CURRENT STATUS")=$$GETSTAT("G",1) Q     ;Income <= GMT Threshold
 ..S HARDSHIP("CURRENT STATUS")=$$GETSTAT("C",1)
 .S HARDSHIP("AGREE")=1
 .S HARDSHIP("CTGRY CHNGD BY")=$G(DUZ)
 .S HARDSHIP("DT/TM CTGRY CHNGD")=$$NOW^XLFDT
 I $$STORE(.HARDSHIP,.ERROR) S SUCCESS=1 D AFTER^DGMTHL1(.HARDSHIP) I ($G(NOTIFY)=1) D DELETE^IVMPLOG(HARDSHIP("DFN"),HARDSHIP("TEST DATE"),,,1)
 Q SUCCESS
 ; 
GETCODE(STATUS) ;
 ;Gets the means test status code given the ien
 Q:'$G(STATUS) ""
 Q $P($G(^DG(408.32,STATUS,0)),"^",2)
 ;
GETNAME(STATUS) ;
 ;Gets the means test status name given the ien
 Q:'$G(STATUS) ""
 Q $P($G(^DG(408.32,STATUS,0)),"^")
 ;
GETSTAT(CODE,TYPE) ;
 ;Given the code and type of test, returns the ien of the status as the function value
 ;
 Q:(CODE="") ""
 ;
 N STATUS,NODE
 S STATUS=0
 F  S STATUS=$O(^DG(408.32,STATUS)) Q:'STATUS  S NODE=$G(^DG(408.32,STATUS,0)) I $P(NODE,"^",2)=CODE,$P(NODE,"^",19)=TYPE Q
 Q $S(STATUS:STATUS,1:"")
