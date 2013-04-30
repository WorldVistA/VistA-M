EDPRPT13 ;SLC/BWF - Removed in Error Report ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
 Q
 ; INPUT:
 ;    BEG   - Beginning Date
 ;    END   - Ending Date
EN(BEG,END,CSV) ; Get report of patients removed in error
 N CHKDT,LOG,ROW,TAB,X0,X1,X3,CNT,I,LOGH,FOUND,X
 S CNT("ALL")=0 ; set counter to 0
 D:'$G(CSV) XML^EDPX("<removedInErrorEntries>") I $G(CSV) D  ;headers
 . S TAB=$C(9)
 . S X="ED IEN"_TAB_"Time In"_TAB_"Time Out"_TAB_"Restored to Board"_TAB_"Restored Date/Time"_TAB_"Restored By"_TAB_"Closed By"_TAB_"Closed Date/Time" ;_TAB_"ER Spec Visit"
 . D ADD^EDPCSV(X)
 S CHKDT=$G(BEG)-.000001
 F  S CHKDT=$O(^EDP(230,"ARIE",CHKDT)) Q:'CHKDT!(CHKDT>END)  D
 .S LOG=0 F  S LOG=$O(^EDP(230,"ARIE",CHKDT,LOG)) Q:'LOG  D
 ..S X0=^EDP(230,LOG,0),X1=$G(^(1)),X3=$G(^(3))
 ..N ROW S ROW("ID")=LOG
 ..S ROW("patientName")=$$GET1^DIQ(2,$P(X0,U,6),.01)
 ..S ROW("timeInED")=$P(X0,U,8)
 ..S ROW("timeOutED")=$p(X0,U,9)
 ..S ROW("restored")=$P(X0,U,17)
 ..S ROW("restoredDateTime")=$P(X0,U,19)
 ..S ROW("restoredBy")=$$GET1^DIQ(200,$P(X0,U,18),.01)
 ..; initialize closedby and closedDateTime
 ..S (ROW("closedBy"),ROW("closedDateTime"))=""
 ..; look at the appropriate log history entry to get who closed this record
 ..S FOUND=0
 ..S LOGH="A" F  S LOGH=$O(^EDP(230.1,"B",LOG,LOGH),-1) Q:'LOGH!(FOUND)  D
 ...S X3=$G(^EDP(230.1,LOGH,3))
 ...I $P(X3,U,9) D
 ....S ROW("closedBy")=$$GET1^DIQ(200,$P(X3,U,11),.01),ROW("closedDateTime")=$P(X3,U,10)
 ....S FOUND=1
 ..;S ROW("closedBy")=$$GET1^DIQ(200,$P(X0,U,16),.01)
 ..;S ROW("closedDateTime")=$P(X0,U,15)
 ..S ROW("ssn")=$S($P(X0,U,5):$P(X0,U,5),'$P(X0,U,5):$$SSN^DPTLK1($P(X0,U,6)),1:"")
 ..I '$G(CSV) S X=$$XMLA^EDPX("log",.ROW) D XML^EDPX(X) Q
 ..S X=ROW("id")
 ..F I="patientName","timeInED","timeOutED","restored","restoredDateTime","restoredBy","closedBy","closedDateTime"  D
 ...S X=X_$C(9)_$G(ROW(I)) D ADD^EDPCSV(X)
 D:'$G(CSV) XML^EDPX("</removedInErrorEntries>")
 Q
 ;
INIT ;
 Q
