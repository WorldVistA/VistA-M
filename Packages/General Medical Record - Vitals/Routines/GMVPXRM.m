GMVPXRM ;HIOFO/FT-API to return FILE 120.5 data ;01/20/09  13:11
 ;;5.0;GEN. MED. REC. - VITALS;**6,23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ;  #4113 - ^PXRMSXRM routine    (controlled) 
 ;  #4114 - ^PXRMINDX global     (controlled)
 ;  #5076 - ^MDCLIO1 calls       (private)
 ; #10103 - ^XLFDT calls         (supported)
 ; #10040 - FILE 44 references   (supported)
 ; #10141 - ^XPDUTL calls        (supported)
 ;
 ; Entry point(s) available for use by other packages:
 ;      EN is documented in IA #3647
 ;  VITALS is documented in IA #3647
 ;
EN(GMVDATA,GMVIEN,GMVIB) ; Returns data for a single FILE 120.5 entry.
 ; Input:
 ;   GMVDATA = Array name passed by reference       (required)
 ;    GMVIEN = IEN for FILE 120.5 or GUID for FILE 704.117    (required)
 ;     GMVIB = "I" for Internal value only
 ;             "B" for Internal and External values (default = B)
 ; 
 ; If GMVIB = "I", then
 ;   Output = GMVDATA(n)=internal value
 ; 
 ; If GMVIB = "B", then 
 ; Output: GMVDATA(n)=internal value^external value 
 ;
 ; where:
 ; GMVDATA(1)=.01 (DATE/TIME VITALS TAKEN)
 ; GMVDATA(2)=.02 (PATIENT)
 ; GMVDATA(3)=.03 (VITAL TYPE)
 ; GMVDATA(4)=.04 (DATE/TIME VITALS ENTERED)
 ; GMVDATA(5)=.05 (HOSPITAL LOCATION)
 ; GMVDATA(6)=.06 (ENTERED BY)
 ; GMVDATA(7)=1.2 (RATE)
 ; GMVDATA(8)=1.4 (SUPPLEMENTAL O2)
 ; GMVDATA(9)=2   (ENTERED IN ERROR)
 ; GMVDATA(10)=3  (ERROR ENTERED BY)
 ; GMVDATA(11,n)=4 (REASON ENTERED IN ERROR)  <--multiple
 ; GMVDATA(12,n)=5 (QUALIFIER)                <--multiple
 ;
 ; If the lookup failed then: GMVDATA(1)=-1^error text
 ;
 N GMVCNT,GMVIEN1,GMVLIST,GMVLEN,GMVLOOP,GMVTEMP,TEMP,TEMP2,TEMP5,TP,EM
 I $G(GMVIB)'="I",$G(GMVIB)'="B" S GMVIB="B"
 I $G(GMVIEN)="" S GMVDATA(1)="-1^Record Number is Null" Q
 I GMVIEN=+GMVIEN D
 .D F1205^GMVUTL(.GMVTEMP,GMVIEN,1)
 .S TEMP=$G(GMVTEMP(0))
 .S TEMP2=$G(GMVTEMP(2))
 .S TEMP5=$G(GMVTEMP(5))
 .Q
 I GMVIEN'=+GMVIEN D
 .D CLIO^GMVUTL(.GMVTEMP,GMVIEN)
 .S TEMP=$G(GMVTEMP(0))
 .S TEMP2=$G(GMVTEMP(2))
 .S TEMP5=$G(GMVTEMP(5))
 .Q
 I TEMP="" D  Q
 .S GMVDATA(1)="-1^The entry does not exist"
 .Q
 ;
 S GMVDATA(1)=$P(TEMP,U,1)
 S GMVDATA(2)=$P(TEMP,U,2)
 S GMVDATA(3)=$P(TEMP,U,3)
 S GMVDATA(4)=$P(TEMP,U,4)
 S GMVDATA(5)=$P(TEMP,U,5)
 I '$D(^SC(+GMVDATA(5),0)) S GMVDATA(5)=0
 S GMVDATA(6)=$P(TEMP,U,6)
 S GMVDATA(7)=$P(TEMP,U,8)
 S GMVDATA(8)=$P(TEMP,U,10)
 S GMVDATA(9)=$P(TEMP2,U,1)
 S GMVDATA(10)=$P(TEMP2,U,2)
 S GMVCNT=0
 S GMVLIST=$P(TEMP2,U,3)
 S GMVLEN=$L(GMVLIST,"~")
 F GMVCNT=1:1:GMVLEN D
 .S GMVDATA(11,GMVCNT)=$P(GMVLIST,"~",GMVCNT)
 .Q
 I GMVCNT=0 S GMVDATA(11,1)=""
 S GMVLIST=$G(TEMP5),GMVCNT=0
 F GMVLOOP=1:1 Q:$P(GMVLIST,U,GMVLOOP)=""  D
 .S GMVCNT=GMVCNT+1
 .S GMVDATA(12,GMVCNT)=$P(GMVLIST,U,GMVLOOP)
 .Q
 I GMVCNT=0 S GMVDATA(12,1)=""
 ;
 Q:GMVIB="I"
 ;
 S GMVDATA(1)=$P(GMVDATA(1),U,1)_U_$$EXTERNAL^DILFD(120.5,.01,"",$P(GMVDATA(1),U,1),.EM)
 S GMVDATA(2)=$P(GMVDATA(2),U,1)_U_$$EXTERNAL^DILFD(120.5,.02,"",$P(GMVDATA(2),U,1),.EM)
 S GMVDATA(3)=$P(GMVDATA(3),U,1)_U_$$EXTERNAL^DILFD(120.5,.03,"",$P(GMVDATA(3),U,1),.EM)
 S GMVDATA(4)=$P(GMVDATA(4),U,1)_U_$$EXTERNAL^DILFD(120.5,.04,"",$P(GMVDATA(4),U,1),.EM)
 S GMVDATA(5)=$P(GMVDATA(5),U,1)_U_$$EXTERNAL^DILFD(120.5,.05,"",$P(GMVDATA(5),U,1),.EM)
 S GMVDATA(6)=$P(GMVDATA(6),U,1)_U_$$EXTERNAL^DILFD(120.5,.06,"",$P(GMVDATA(6),U,1),.EM)
 S GMVDATA(7)=$P(GMVDATA(7),U,1)_U_$P(GMVDATA(7),U,1) ;same
 S GMVDATA(8)=$P(GMVDATA(8),U,1)_U_$P(GMVDATA(8),U,1) ;same
 S GMVDATA(9)=$P(GMVDATA(9),U,1)_U_$$EXTERNAL^DILFD(120.5,2,"",$P(GMVDATA(9),U,1),.EM)
 S GMVDATA(10)=$P(GMVDATA(10),U,1)_U_$$EXTERNAL^DILFD(120.5,3,"",$P(GMVDATA(10),U,1),.EM)
 ;
 ;loop through entered-in-error reason multiple
 S (GMVCNT,GMVIEN1)=0
 F  S GMVIEN1=$O(GMVDATA(11,GMVIEN1)) Q:'GMVIEN1  D
 .S TP=+$P(GMVDATA(11,GMVIEN1),U,1)
 .Q:'TP
 .S GMVDATA(11,GMVIEN1)=TP_U_$$EXTERNAL^DILFD(120.506,.01,"",TP,.EM)
 .S GMVCNT=1
 .Q
 I GMVCNT=0 S GMVDATA(11,1)="^"
 ;loop through qualifier multiple
 S (GMVCNT,GMVIEN1)=0
 F  S GMVIEN1=$O(GMVDATA(12,GMVIEN1)) Q:'GMVIEN1  D
 .S TP=+$P(GMVDATA(12,GMVIEN1),U,1)
 .Q:'TP
 .S GMVDATA(12,GMVIEN1)=TP_U_$P($G(^GMRD(120.52,+TP,0)),U,1)
 .S GMVCNT=1
 .Q
 I GMVCNT=0 S GMVDATA(12,1)="^"
 Q
 ;
VITALS ; This entry point is for use by the Clinical Reminders package
 ; to re-index the ACR cross-reference nodes for FILE 120.5.
 ;
 ; a) This entry point kills the ACR cross-reference nodes for ^PXRMINDX(120.5).
 ; b) Re-builds the ACR cross-reference nodes.
 ; c) Calls the Clinical Reminders package to generate a mail message
 ;    summarizing the rebuilding of the ACR cross-reference.
 ;
 N DAS,DATE,DFN,END,ENTRIES,ETEXT,GLOBAL,IND,NE,NE1,NE2,NERROR
 N START,TEMP,TENP,TEXT,VT,GMVCLIO,GMVTYPE,GMVLOOP,GMVIEN
 S GLOBAL=$$GET1^DID(120.5,"","","GLOBAL NAME")
 ; Don't leave any old cross-reference nodes around.
 K ^PXRMINDX(120.5)
 S ENTRIES=$P(^GMR(120.5,0),U,4)
 S TENP=ENTRIES/10
 S TENP=+$P(TENP,".",1)
 D BMES^XPDUTL("Building index for VITALS DATA.")
 ;S TEXT="There are "_ENTRIES_" entries to process."
 ;D MES^XPDUTL(TEXT)
 S START=$H
 S (DAS,IND,NE,NE1,NE2,NERROR)=0
 F  S DAS=+$O(^GMR(120.5,DAS)) Q:DAS=0  D
 . S IND=IND+1
 . I IND#TENP=0 D
 .. S TEXT="Processing entry "_IND
 .. D MES^XPDUTL(TEXT)
 . I IND#10000=0 W "."
 . S TEMP=^GMR(120.5,DAS,0)
 . I $P(TEMP,U,1)'?7N1"."1.6N S NE1=NE1+1 Q
 . I $P(TEMP,U,2)'>0 S NE1=NE1+1 Q
 . I $P(TEMP,U,3)'>0 S NE1=NE1+1 Q
 . S DATE=$P(TEMP,U,1),DFN=$P(TEMP,U,2),VT=$P(TEMP,U,3)
 .;If this entry is marked as entered-in-error do not index it.
 . I $P($G(^GMR(120.5,DAS,2)),U,1) S NE2=NE2+1 Q
 . S ^PXRMINDX(120.5,"IP",VT,DFN,DATE,DAS)=""
 . S ^PXRMINDX(120.5,"PI",DFN,VT,DATE,DAS)=""
 . S NE=NE+1
 . Q
 ; Get vital type iens
 F GMVLOOP="BP","CG","CVP","HT","P","PN","PO2","R","T","WT" D
 .S GMVIEN=$O(^GMRD(120.51,"C",GMVLOOP,0))
 .Q:'GMVIEN
 .S GMVTYPE(GMVIEN)=""
 .Q
 K ^TMP($J)
 ; get records from Clinical Observations
 I $T(QRYDATE^MDCLIO1)]"" D
 .D QRYDATE^MDCLIO1("^TMP($J)",3070101,$$FMADD^XLFDT($$NOW^XLFDT(),,24))
 .S GMVLOOP=0
 .F  S GMVLOOP=$O(^TMP($J,GMVLOOP)) Q:'GMVLOOP  D
 ..S DAS=^TMP($J,GMVLOOP)
 ..Q:DAS=""
 ..D CLIO^GMVUTL(.GMVCLIO,DAS)
 ..S GMVCLIO(0)=$G(GMVCLIO(0))
 ..I GMVCLIO(0)="" S NE1=NE1+1 Q
 ..I $P(GMVCLIO(0),U,1)'?7N1"."1.6N S NE1=NE1+1 Q
 ..I $P(GMVCLIO(0),U,2)'>0 S NE1=NE1+1 Q
 ..I $P(GMVCLIO(0),U,3)'>0 S NE1=NE1+1 Q
 ..I '$D(GMVTYPE($P(GMVCLIO(0),U,3))) Q  ;not a vitals entry
 ..S DATE=$P(GMVCLIO(0),U,1),DFN=$P(GMVCLIO(0),U,2),VT=$P(GMVCLIO(0),U,3)
 ..S ^PXRMINDX(120.5,"IP",VT,DFN,DATE,DAS)=""
 ..S ^PXRMINDX(120.5,"PI",DFN,VT,DATE,DAS)=""
 ..S NE=NE+1
 ..Q
 .Q
 S END=$H
 S TEXT="  VITAL MEASUREMENTS entries indexed: "_NE
 D BMES^XPDUTL(TEXT)
 S TEXT="             Bad entries not indexed: "_NE1
 D MES^XPDUTL(TEXT)
 S TEXT="Entered-in-Error entries not indexed: "_NE2
 D MES^XPDUTL(TEXT)
 S TEXT=" "
 D MES^XPDUTL(TEXT)
 D DETIME^PXRMSXRM(START,END)
 ;Send a MailMan message with the results.
 D COMMSG^PXRMSXRM(GLOBAL,START,END,NE,NERROR)
 S ^PXRMINDX(120.5,"GLOBAL NAME")=$$GET1^DID(120.5,"","","GLOBAL NAME")
 S ^PXRMINDX(120.5,"BUILT BY")=DUZ
 S ^PXRMINDX(120.5,"DATE BUILT")=$$NOW^XLFDT
 Q
 ;
SVITAL(X,DA) ; Set ACR index entry
 ; X(1)=DATE/TIME, X(2)=DFN, X(3)=VITAL TYPE, X(4)=ENTERED IN ERROR
 ; Do not index entries that are marked as entered-in-error.
 I $G(X(4)) Q
 S ^PXRMINDX(120.5,"IP",X(3),X(2),X(1),DA)=""
 S ^PXRMINDX(120.5,"PI",X(2),X(3),X(1),DA)=""
 Q
 ;
KVITAL(X,DA) ; Delete ACR index entry
 K ^PXRMINDX(120.5,"IP",X(3),X(2),X(1),DA)
 K ^PXRMINDX(120.5,"PI",X(2),X(3),X(1),DA)
 Q
