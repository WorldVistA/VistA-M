ALPBUTL2 ;OIFO-DALLAS MW,SED,KC-BCBU BACKUP REPORT FUNCTIONS AND UTILITIES  ;01/01/03
 ;;3.0;BAR CODE MED ADMIN;**8**;Mar 2004
 ;
DELALG(IEN) ; delete allergies...
 ; IEN = the patient's record number in file 53.7
 ; deletes any allergies in the patient's record -- returns nothing
 I +$G(IEN)=0 Q
 I +$O(^ALPB(53.7,IEN,1,0))=0 Q
 N ALPBX,DA,DIK,X,Y
 S ALPBX=0
 F  S ALPBX=$O(^ALPB(53.7,IEN,1,ALPBX)) Q:'ALPBX  D
 .S DA=ALPBX
 .S DA(1)=IEN
 .S DIK="^ALPB(53.7,"_DA(1)_",1,"
 .D ^DIK
 .K DA,DIK
 Q
 ;
GETPID(DATA,FS,CS,ECH,RESULTS) ; retrieve specific patient ID data from
 ; PID segment...
 ; DATA    = HL7 data string
 ; FS      = HL7 field separator character
 ; CS      = HL7 component separator character
 ; ECH     = HL7 separators string
 ; RESULTS = an array passed by reference into which retrieved data
 ;           is returned patient's DFN
 S RESULTS(1)=$P($P(DATA,FS,4),CS,1)
 ; name...
 S RESULTS(2)=$$FMNAME^HLFNC($P(DATA,FS,6),ECH)
 ; ssn (strip any dashes)...
 S RESULTS(3)=$$STRIP^XLFSTR($P($P(DATA,FS,3),CS,1),"-")
 ; dob...
 S RESULTS(4)=$$FMDATE^HLFNC($P(DATA,FS,8))
 ; gender...
 S RESULTS(5)=$P(DATA,FS,9)
 Q
 ;
GETORC(DATA,FS,CS,RESULTS) ; retrieve order number, date, type, and
 ; CPRS order number from ORC segment...
 ; DATA    = HL7 data string
 ; FS      = HL7 field separator character
 ; CS      = HL7 component separator character
 ; RESULTS = an array passed by reference into which retrieved data
 ;           is returned order action
 S RESULTS(0)=$P(DATA,FS,2)
 ; order number...
 S RESULTS(1)=$P($P(DATA,FS,4),CS,1)
 ; order date/time...
 S RESULTS(2)=$S($P(DATA,FS,16)'="":$$FMDATE^HLFNC($P(DATA,FS,16)),$P(DATA,FS,10)'="":$$FMDATE^HLFNC($P(DATA,FS,10)),1:"")
 ; CPRS order number...
 S RESULTS(3)=+$P(DATA,FS,3)
 ; order type...
 S RESULTS(4)=$E(RESULTS(1),$L(RESULTS(1)))
 Q
 ;
DELERR(IEN) ; delete an entry from the Error Log...
 ; IEN = the Error Log record number
 N ALPBPARM,DA,DIK,X,Y
 S ALPBPARM=+$O(^ALPB(53.71,0))
 I ALPBPARM'>0 Q
 S DA=IEN
 S DA(1)=ALPBPARM
 S DIK="^ALPB(53.71,"_DA(1)_",1,"
 D ^DIK
 Q
 ;
ERRCT() ; fetch and return count of errors in the log in BCMA BACKUP PARAMETERS
 ; file...
 ; returns count of errors
 N ALPBPARM,ALPBCNT,ALPBX
 S ALPBPARM=+$O(^ALPB(53.71,0))
 I ALPBPARM'>0 Q 0
 S (ALPBCNT,ALPBX)=0
 F  S ALPBX=$O(^ALPB(53.71,ALPBPARM,1,"B",ALPBX)) Q:'ALPBX  S ALPBCNT=ALPBCNT+1
 Q ALPBCNT
 ;
REPL(X,Y) ; replace non-alpha and non-numeric characters...
 ; X = a string to examine
 ; Y = a character to use as the replacment
 ; returns a string with any non-alpha and non-numeric characters
 ; converted to the character passed in Y
 I $G(X)=""!($G(Y)="") Q X
 N I,NEWSTR,NEWX,Z
 S NEWSTR=""
 F I=1:1:$L(X) D
 .S (NEWX,Z)=$E(X,I)
 .I $A(Z)<48&($A(Z)'=44) S NEWX=Y
 .I $A(Z)>57&($A(Z)<65) S NEWX=Y
 .I $A(Z)>90&($A(Z)<97) S NEWX=Y
 .I $A(Z)>122 S NEWX=Y
 .S NEWSTR=NEWSTR_NEWX
 Q NEWSTR
 ;
CLORD(IEN,OIEN) ; delete drug(s), additive(s) and/or solution(s) entries
 ; for a specified order...
 ; IEN  = patient's record number in file 53.7
 ; OIEN = order's sub-record number in file 53.7
 ; returns nothing
 I +$G(IEN)=0!(+$G(OIEN)=0) Q
 N DA,DIK,SUB,X,XIEN,Y
 F SUB=7,8,9 D
 .S XIEN=0
 .F  S XIEN=$O(^ALPB(53.7,IEN,2,OIEN,SUB,XIEN)) Q:'XIEN  D
 ..S DA=XIEN
 ..S DA(1)=OIEN
 ..S DA(2)=IEN
 ..S DIK="^ALPB(53.7,"_DA(2)_",2,"_DA(1)_","_SUB_","
 ..D ^DIK
 ..K DA,DIK
 .K XIEN
 Q
