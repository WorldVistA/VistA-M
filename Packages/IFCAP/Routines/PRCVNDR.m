PRCVNDR ;WOIFO/AS-SEND VENDOR UPDATE INFOMATION TO DYNAMED ; 2/21/05 5:07pm
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
NITECHK ;
 ;    Once a day check
 ;    Compare checksum and set flag to updated record
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1)'=1 Q
 N PRCVP,PRCVP2,PRCVAL,PRCVND,PRCVN,NOD,PRCVST,PRCVCNT
 S PRCVP=67280421310721,PRCVP2=2147483647,PRCVN=0
 S NOD=+$O(^PRCV(414.04,"D","VENDOR",0))
 F  S PRCVN=$O(^PRC(440,PRCVN)) Q:'PRCVN  D
 . S PRCVAL=$$CHKSUM()
 . ;  Compare to existing CheckSum
 . ;  Set a flag if the not the same
 . I PRCVAL,PRCVAL'=$P($G(^PRCV(414.04,NOD,1,PRCVN,0)),"^",2) D
 .. S ^PRCV(414.04,NOD,1,PRCVN,0)=PRCVN_"^"_PRCVAL
 .. D GETDATA(PRCVN)
 .. I $D(^TMP("PRCVNDR",$J,PRCVN)) D EN^PRCVVMF(PRCVN)
 .. K ^TMP("PRCVNDR",$J)
 Q
ONECHK(PRCVN) ;
 ;   Checksum to one vendor only
 N PRCVP,PRCVP2,PRCVAL,PRCVND,NOD,PRCVST,PRCVCNT
 S PRCVP=67280421310721,PRCVP2=2147483647
 S NOD=+$O(^PRCV(414.04,"D","VENDOR",0))
 S PRCVAL=$$CHKSUM
 ;   If checksum not equal to original record, get data to DynaMed
 I PRCVAL,PRCVAL'=$P($G(^PRCV(414.04,NOD,1,PRCVN,0)),"^",2) D
 . S ^PRCV(414.04,NOD,1,PRCVN,0)=PRCVN_"^"_PRCVAL
 . D GETDATA(PRCVN)
 . I $D(^TMP("PRCVNDR",$J,PRCVN)) D EN^PRCVVMF(PRCVN)
 . K ^TMP("PRCVNDR",$J)
 Q
INIT ;
 ;   Initialize checksum global at installation
 NEW FDA,RESULT,PRCVN,PRCVP,PRCVP2,PRCVAL,PRCVST,PRCVCNT
 S FDA(414.04,"?+1,",.01)="VENDOR"
 S FDA(414.04,"?+1,",.02)=440
 S FDA(414.04,"?+1,",.03)="Vendor file checksum (on partial field)"
 D UPDATE^DIE("E","FDA","RESULT")
 S PRCVP=67280421310721,PRCVP2=2147483647,PRCVN=0
 F  S PRCVN=$O(^PRC(440,PRCVN)) Q:'PRCVN  D
 . S FDA(414.41,"?+1,"_RESULT(1)_",",.01)=PRCVN
 . S FDA(414.41,"?+1,"_RESULT(1)_",",1)=$$CHKSUM()
 . D UPDATE^DIE("E","FDA")
 Q
CHKSUM() ;
 S PRCVAL=0
 ;        Node 0
 S PRCVND=$G(^PRC(440,PRCVN,0))
 ;  Vendor Name
 S PRCVST=$P(PRCVND,"^",1),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Ordering Address 1
 S PRCVST=$P(PRCVND,"^",2),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Ordering Address 2
 S PRCVST=$P(PRCVND,"^",3),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Ordering Address 3
 S PRCVST=$P(PRCVND,"^",4),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Ordering Address 4
 S PRCVST=$P(PRCVND,"^",5),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Ordering City
 S PRCVST=$P(PRCVND,"^",6),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Ordering State
 S PRCVST=$P(PRCVND,"^",7),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Ordering Zip Code
 S PRCVST=$P(PRCVND,"^",8),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Contact Person
 S PRCVST=$P(PRCVND,"^",9),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Contact Phone Number
 S PRCVST=$P(PRCVND,"^",10),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;
 ;        Node 3
 S PRCVND=$G(^PRC(440,PRCVN,3))
 ;  Vendor EDI Indicator
 S PRCVST=$P(PRCVND,"^",2),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  EDI Vendor Number
 S PRCVST=$P(PRCVND,"^",3),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  FMS Vendor ID
 S PRCVST=$P(PRCVND,"^",4),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Alternate Address Indicator
 S PRCVST=$P(PRCVND,"^",5),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;
 ;        Node 10
 S PRCVND=$G(^PRC(440,PRCVN,10))
 ;  Contact FAX Number
 S PRCVST=$P(PRCVND,"^",6),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Inactivated Vendor Indicator
 S PRCVST=$P(PRCVND,"^",5),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Date Inactivated
 S PRCVST=$P(PRCVND,"^",3),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;
 ;  Dun and Bradstreet Vendor ID
 S PRCVST=$P($G(^PRC(440,PRCVN,7)),"^",12),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;  Account Number
 S PRCVST=$P($G(^PRC(440,PRCVN,2)),"^",1),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;
 ;        Node 4
 S PRCVCNT=0 F  S PRCVCNT=$O(^PRC(440,PRCVN,4,PRCVCNT)) Q:'PRCVCNT  D
 . S PRCVND=$G(^PRC(440,PRCVN,4,PRCVCNT,0))
 . ; Contract Number
 . S PRCVST=$P(PRCVND,"^",1),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 . ; Contract Expiration Date
 . S PRCVST=$P(PRCVND,"^",2),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 . ; Contract Beginning Date
 . S PRCVST=$P(PRCVND,"^",3),PRCVAL=$$CKINC(PRCVAL,PRCVST)
 Q PRCVAL
 ;
GETDATA(PRCVNM) ;
 ;     Get all field required, 
 ;        Node 0
 S PRCVND=$G(^PRC(440,PRCVNM,0))
 ;  State
 S $P(PRCVND,"^",7)=$P($G(^DIC(5,+$P(PRCVND,"^",7),0)),"^",2)
 ;  Name, Address 1, 2, 3, 4, City, State, Zip, Contact Person, Phone
 S ^TMP("PRCVNDR",$J,PRCVNM,0)=$P(PRCVND,"^",1,10)
 ;  Station number
 S $P(^TMP("PRCVNDR",$J,PRCVNM,0),"^",11)=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 ;
 ;        Node 3
 S PRCVND=$G(^PRC(440,PRCVNM,3))
 ;  Vendor EDI Indicator, EDI Number, FMS ID, ALT address indicator
 S ^TMP("PRCVNDR",$J,PRCVNM,1)=$P(PRCVND,"^",2,5)
 ;
 ;        Node 10
 S PRCVND=$G(^PRC(440,PRCVNM,10))
 ;  Date inactivated
 S $P(^TMP("PRCVNDR",$J,PRCVNM,2),"^",1)=$P(PRCVND,"^",3)
 ;  Inactivated Vendor Indicator
 S $P(^TMP("PRCVNDR",$J,PRCVNM,2),"^",2)=$P(PRCVND,"^",5)
 ;  Contact FAX Number
 S $P(^TMP("PRCVNDR",$J,PRCVNM,2),"^",3)=$P(PRCVND,"^",6)
 ;  Dun and Bradstreet Vendor ID
 S $P(^TMP("PRCVNDR",$J,PRCVNM,2),"^",4)=$P($G(^PRC(440,PRCVNM,7)),"^",12)
 ;  Account Number
 S $P(^TMP("PRCVNDR",$J,PRCVNM,2),"^",5)=$P($G(^PRC(440,PRCVNM,2)),"^")
 ;
 ;        Node 4
 S PRCVCNT=0 F  S PRCVCNT=$O(^PRC(440,PRCVNM,4,PRCVCNT)) Q:'PRCVCNT  D
 . S PRCVND=$G(^PRC(440,PRCVNM,4,PRCVCNT,0))
 . ; Contract Number, Expiration Date, Beginning Date
 . S ^TMP("PRCVNDR",$J,PRCVNM,3,PRCVCNT)=$P(PRCVND,"^",1,3)
 Q
CKINC(PRCVF,PRCVS) ;incremental checksum
 N PRCVL,PRCVB,PRCVC,PRCVI,PRCVAL
 S PRCVF=+$G(PRCVF)
 S PRCVS=$G(PRCVS)
 ;No change on null input
 Q:PRCVS="" PRCVF
 S PRCVL=$L(PRCVS)
 S PRCVAL=0
 S PRCVB(1)=1,PRCVB(2)=1
 F PRCVI=1:1:PRCVL D
 .S PRCVC=$E(PRCVS,PRCVI)
 .S:PRCVI>2 PRCVB(PRCVI)=(PRCVB(PRCVI-1)+PRCVB(PRCVI-2))#PRCVP2
 .S PRCVAL=(PRCVF+PRCVAL+($A(PRCVC)*PRCVB(PRCVI)))#PRCVP
 Q PRCVAL
