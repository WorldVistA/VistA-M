ORWD2 ; SLC/KCM/REV - GUI Prints; 28-JAN-1999 12:51 ;1/9/06  00:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,215**;Dec 17, 1997
 ;
 ; PUBLIC CALLS
 ;
DEVINFO(LST,LOC,NATR,ORDERS)       ; Return device info when signing/releasing orders
 ; Y(0)=Prompt Chart ^ Prompt Label ^ Prompt Requisition ^ Prompt Work
 ;      ^ Chart Device ^ Label Device ^ Requisition Device ^ Work Device
 ; for Prompt X: *=no print, 0=autoprint, 1=prompt&dev 2=prompt only 
 ; Y(n)=ORIFN;ACT ^ Chart ^ Label ^ Requisition ^ Service ^ Work
 ; LOC=location (ptr 44), NATR=nature of order (ptr 100.02)
 ; ORDERS=ORIFN;ACT ^ R | S | E (released, signed, error)
 N NATCHT,NATWRK,WHENCHT,PRMTCHT,PRMTLBL,PRMTREQ,PRMTWRK
 N DOCHT,DOLBL,DOREQ,DOWRK,RELEASE,ORDERID,I,J,X
 N NDCR,NODE,NPCC,NPWC
 S (DOCHT,DOLBL,DOREQ,DOWRK,I,J)=0,LOC=+LOC_";SC("
 S NATR=$O(^ORD(100.02,"C",NATR,0))
 S NATCHT=+$P($G(^ORD(100.02,NATR,1)),U,2),NATWRK=+$P($G(^(1)),U,5)
 S WHENCHT=$$GET^XPAR("ALL^"_LOC,"ORPF PRINT CHART COPY WHEN",1,"I")
 I '$L(WHENCHT) S WHENCHT="R"
 S PRMTCHT=$$GET^XPAR("ALL^"_LOC,"ORPF PROMPT FOR CHART COPY",1,"I")
 S PRMTLBL=$$GET^XPAR("ALL^"_LOC,"ORPF PROMPT FOR LABELS",1,"I")
 S PRMTREQ=$$GET^XPAR("ALL^"_LOC,"ORPF PROMPT FOR REQUISITIONS",1,"I")
 S PRMTWRK=$$GET^XPAR("ALL^"_LOC,"ORPF PROMPT FOR WORK COPY",1,"I")
 N BBPKG S BBPKG=+$O(^DIC(9.4,"B","VBECS",0))
 D INSRTBB(.ORDERS) ; insert any blood bank child lab orders into ORDERS array
 F  S I=$O(ORDERS(I)) Q:'I  I $P(ORDERS(I),U,2)'["E" D
 . S ORDERID=$P(ORDERS(I),U),RELEASE=($P(ORDERS(I),U,2)["R")
 . S J=J+1,LST(J)=ORDERID_"^^^^"
 . ;AGP this section check the order for DC Reason and grabs the print requirement
 . ;from the Nature of Order file.
 . S NPCC=1,NPWC=1
 . S NDCR=$P($G(^OR(100,+ORDERID,6)),U) I NDCR>0 D
 . .S NODE=$G(^ORD(100.02,NDCR,1))
 . .S NPCC=+$P(NODE,U,2)
 . .S NPWC=+$P(NODE,U,5)
 . ; skip chart copy if nature doesn't print, no match to 'print when',
 . ; prompt parameter says don't print, or is lab child of blood bank 
 . I NPCC,NATCHT,($P(ORDERS(I),U,2)[WHENCHT),(PRMTCHT'="*"),$$NOTBB(+ORDERS(I)) S $P(LST(J),U,2)=1,DOCHT=1
 . ; skip label if not released, no label format, or prompt parameter
 . ; says don't print
 . I RELEASE,(PRMTLBL'="*"),$$HASFMTL S $P(LST(J),U,3)=1,DOLBL=1
 . ; skip requisition if not released, no requistion format, or the
 . ; prompt parameter says don't print
 . I RELEASE,(PRMTREQ'="*"),$$HASFMTR S $P(LST(J),U,4)=1,DOREQ=1
 . ; skip service copy if not releasing
 . I RELEASE S $P(LST(J),U,5)=1
 . ; skip work copy if nature doesn't print, not released, no work
 . ; copy format, or prompt parameter says don't print
 . I NPWC,NATWRK,RELEASE,(PRMTWRK'="*"),$$HASFMTW,$$NOTBB(+ORDERS(I)) S $P(LST(J),U,6)=1,DOWRK=1
 S LST(0)=$$DEFDEV
 Q
MANUAL(REC,LOC,ORDERS)   ; return device info for manual prints
 N DOCHT,DOLBL,DOREQ,DOWRK,ORDERID,I
 N PRMTCHT,PRMTLBL,PRMTREQ,PRMTWRK  ; (so undefined for DEFDEV call)
 S (DOLBL,DOREQ,DOWRK,I,J)=0,DOCHT=1,LOC=+LOC_";SC("
 N BBPKG S BBPKG=+$O(^DIC(9.4,"B","VBECS",0))
 D INSRTBB(.ORDERS) ; insert any blood bank child lab orders into ORDERS array
 F  S I=$O(ORDERS(I)) Q:'I  D  Q:DOCHT&DOLBL&DOREQ&DOWRK
 . S ORDERID=$P(ORDERS(I),U)
 . I $$HASFMTL S DOLBL=1
 . I $$HASFMTR S DOREQ=1
 . I $$HASFMTW,$$NOTBB(+ORDERS(I)) S DOWRK=1
 S REC=$$DEFDEV
 Q
 ;
 ; PRIVATE CALLS
 ;
DEFDEV()        ; returns string of prompt flags & default devices
 ; called from DEVINFO & MANUAL
 ; expects LOC,DOCHT,DOLBL,DOREQ,DOWRK to be defined
 ; optionally expects PRMTCHT, PRMTLBL, PRMTREQ, PRMTWRK
 N X
 I DOCHT D
 . S $P(X,U,1)=$G(PRMTCHT,1)
 . S $P(X,U,5)=$TR($$GET^XPAR("ALL^"_LOC,"ORPF CHART COPY PRINT DEVICE",1,"B"),U,";")
 E  S $P(X,U,1)="*"
 I DOLBL D
 . S $P(X,U,2)=$G(PRMTLBL,1)
 . S $P(X,U,6)=$TR($$GET^XPAR("ALL^"_LOC,"ORPF LABEL PRINT DEVICE",1,"B"),U,";")
 E  S $P(X,U,2)="*"
 I DOREQ D
 . S $P(X,U,3)=$G(PRMTREQ,1)
 . S $P(X,U,7)=$TR($$GET^XPAR("ALL^"_LOC,"ORPF REQUISITION PRINT DEVICE",1,"B"),U,";")
 E  S $P(X,U,3)="*"
 I DOWRK D
 . S $P(X,U,4)=$G(PRMTWRK,1)
 . S $P(X,U,8)=$TR($$GET^XPAR("ALL^"_LOC,"ORPF WORK COPY PRINT DEVICE",1,"B"),U,";")
 E  S $P(X,U,4)="*"
 Q X
HASFMTL()       ; returns 1 if a label format is available
 ; called from DEVINFO & MANUAL, expects ORDERID & DOLBL to be defined
 I DOLBL=1 Q 1  ; already know we're doing at least 1 label
 N PKG S PKG=+$P($G(^OR(100,+ORDERID,0)),U,14)
 Q ''$$GET^XPAR("SYS","ORPF WARD LABEL FORMAT",PKG,"I")
 ;
HASFMTR()       ; returns 1 if a requisition format is available
 ; called from DEVINFO & MANUAL, expects ORDERID & DOREQ to be defined
 ;I DOREQ=1 Q 1  ; already know we're doing at least 1 requisition
 N PKG,DLG S PKG=+$P($G(^OR(100,+ORDERID,0)),U,14),DLG=+$P($G(^OR(100,+ORDERID,0)),U,5)
 I PKG=$O(^DIC(9.4,"B","DIETETICS",0)),DLG'=$O(^ORD(101.41,"B","FHW SPECIAL MEAL",0)) Q 0 ;no requisitions
 I DOREQ=1 Q 1  ; already know we're doing at least 1 requisition
 Q ''$$GET^XPAR("SYS","ORPF WARD REQUISITION FORMAT",PKG,"I")
 ;
HASFMTW()       ; returns 1 if a work copy format is available
 ; called from DEVINFO & MANUAL, expects ORDERID & DOWRK to be defined
 I DOWRK=1 Q 1  ; already know we're doing at least 1 work copy
 Q ''$$GET^XPAR("SYS","ORPF WORK COPY FORMAT",1,"I") ; not at pkg level
 ;
INSRTBB(ORDRLST) ; Insert child lab orders for any orders going to VBECS
 ; called from DEVINFO, MANUAL
 ; expects BBPKG to be defined
 Q:'BBPKG
 N I,LABPKG,SUBID,CHILD,ACT,KIND
 S LABPKG=+$O(^DIC(9.4,"B","LAB SERVICE",0)) Q:'LABPKG
 S I=0 F  S I=$O(ORDRLST(I)) Q:'I  I $P(ORDRLST(I),U,2)'["E" D
 . I $P($G(^OR(100,+ORDRLST(I),0)),U,14)'=BBPKG Q
 . S SUBID=.0001
 . S CHILD=0 F  S CHILD=$O(^OR(100,+ORDRLST(I),2,CHILD)) Q:'CHILD  D
 . . I $P($G(^OR(100,CHILD,0)),U,14)'=LABPKG Q
 . . S SUBID=SUBID+.0001,ACT=+$P(^OR(100,CHILD,3),U,7),KIND=$P(ORDRLST(I),U,2)
 . . S ORDRLST(I+SUBID)=CHILD_";"_ACT_U_KIND
 . S I=I+SUBID
 Q
NOTBB(CHILD) ; returns 1 if the order is not a blood bank child lab order
 ; called from DEVINFO, MANUAL
 ; expects BBPKG to be defined
 N PARENT S PARENT=$P(^OR(100,CHILD,3),U,9)
 I PARENT,$P(^OR(100,PARENT,0),U,14)=BBPKG Q 0
 Q 1
