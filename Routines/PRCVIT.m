PRCVIT ;WOIFO/DST - Send ITEM master file update to DYNAMED ; 3/2/05 5:07pm
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
NITECHK ;
 ;    Once a day check
 ;    Compare a checksum and set a record to update
 ;
 ; If not DynaMed, don't do it
 Q:'$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")
 ;
 N PRCND,PRCVL,PRCVP,PRCVAL,PRCVIT,PRCVN,PRCVSTN
 N PRCVFN
 S PRCVP=67280421310721,PRCVN=99999
 S PRCVFN=$O(^PRCV(414.04,"D","ITEM",0))
 ;    Clear old flag
 K ^TMP("PRCVIT",$J)
 S PRCVSTN=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 F  S PRCVN=$O(^PRC(441,PRCVN)) Q:'PRCVN  D
 . S PRCVAL=$$CHKSUM()
 . ;  Compare to existing CheckSum
 . ;  Kick off HL7 interface message to DynaMed, if not the same
 . I PRCVAL,PRCVAL'=$P($G(^PRCV(414.04,PRCVFN,1,PRCVN,0)),U,2) D
 .. S ^PRCV(414.04,PRCVFN,1,PRCVN,0)=PRCVN_U_PRCVAL
 .. D GETDATA(PRCVN)
 .. I $D(^TMP("PRCVIT",$J,PRCVN)) D EN^PRCVIMF(PRCVN)
 .. Q
 . Q
 K ^TMP("PRCVIT",$J)
 Q
 ;
ONECHK(PRCVN) ;
 ;   Checksum to one ITEM only
 Q:PRCVN<99999
 N PRCND,PRCVL,PRCVFN,PRCVP,PRCVAL,PRCVIT
 K ^TMP("PRCVIT",$J,PRCVN)
 S PRCVP=67280421310721
 S PRCVFN=$O(^PRCV(414.04,"D","ITEM",0))
 S PRCVAL=$$CHKSUM()
 ;   If checksum not equal 0, get data to DynaMed
 I PRCVAL,PRCVAL'=$P($G(^PRCV(414.04,PRCVFN,1,PRCVN,0)),U,2) D
 . D GETDATA(PRCVN)
 . S ^PRCV(414.04,PRCVFN,1,PRCVN,0)=PRCVN_U_PRCVAL
 . I $D(^TMP("PRCVIT",$J,PRCVN)) D EN^PRCVIMF(PRCVN)
 . Q
 K ^TMP("PRCVIT",$J,PRCVN)
 Q
INIT ;
 ;   Initialize checksum global at installation
 N PRCVN,PRCVP,RESULT,FDA
 ;
 S FDA(414.04,"?+1,",.01)="ITEM"
 S FDA(414.04,"?+1,",.02)=441
 S FDA(414.04,"?+1,",.03)="Item file checksum (on partial field)"
 D UPDATE^DIE("E","FDA","RESULT")
 S PRCVP=67280421310721,PRCVN=99999
 F  S PRCVN=$O(^PRC(441,PRCVN)) Q:'PRCVN  D
 . S FDA(414.41,"?+1,"_RESULT(1)_",",.01)=PRCVN
 . S FDA(414.41,"?+1,"_RESULT(1)_",",1)=$$CHKSUM()
 . D UPDATE^DIE("E","FDA")
 Q
 ;
CHKSUM() ;
 N PRCVST
 S PRCVAL=0
 ;        Node 0
 S PRCVIT=$G(^PRC(441,PRCVN,0))
 ;  Piece 1 - ITEM Number
 ;  Piece 2 - ITEM Short Description
 ;  Piece 3 - FSC - Federal Supply Classification
 ;  Piece 4 - Last vendor ordered
 ;  Piece 5 - NSN - National Stock Number
 ;  Piece 6 - Case/Cart Tray/instrument kit
 ;  Piece 8 - Mandatory Source
 ;  Piece 9 - Date Item Created
 ;  Piece 10 - BOC
 ;  Piece 11 - DUZ
 ;  Piece 13 - Reusable Item
 ;  Piece 14 - Hazardous material
 ;  Piece 15 - NIF ITEM number
 S PRCVI=0
 F PRCVI=1:1:6,8:1:11,13:1:15 D
 . S PRCVST=$P(PRCVIT,U,PRCVI)
 . S PRCVAL=$$CKINC(PRCVAL,PRCVST)
 . Q
 ;        Node 1 - Description
 ;
 S PRCVI=0
 F  S PRCVI=$O(^PRC(441,PRCVN,1,PRCVI)) Q:'PRCVI  D
 . S PRCVST=^PRC(441,PRCVN,1,PRCVI,0)
 . S PRCVAL=$$CKINC(PRCVAL,PRCVST)
 . Q
 ;        Node 2 - Vendors
 S PRCVI=0
 F  S PRCVI=$O(^PRC(441,PRCVN,2,PRCVI)) Q:'PRCVI  D
 . S PRCVST=^PRC(441,PRCVN,2,PRCVI,0)
 . S PRCVAL=$$CKINC(PRCVAL,PRCVST)
 . Q
 ;        Node 3
 ;  Piece 1 - Inactivated ITEM?
 ;  Piece 2 - Date Inactivated
 ;  Piece 3 - Inactivated By
 ;  Piece 4 - Replacement Item
 ;  Piece 5 - MFG Part No.
 ;  Piece 6 - NSN Verified
 ;  Piece 7 - Food Group
 ;  Piece 8 - SKU
 ;  Piece 9 - Drug Type Code
 ;  Piece 10 - SIC Code
 ;
 ; Check the whole node 3
 ;
 S PRCVST=$G(^PRC(441,PRCVN,3))
 I PRCVST]"" S PRCVAL=$$CKINC(PRCVAL,PRCVST)
 ;
 ;        Node 4 - Fund Control Point
 S PRCVI=0
 F  S PRCVI=$O(^PRC(441,PRCVN,4,PRCVI)) Q:'PRCVI  D
 . S PRCVST=$G(^PRC(441,PRCVN,4,PRCVI,0))
 . S PRCVAL=$$CKINC(PRCVAL,PRCVST)
 . Q
 ;        Node 6 - Pre_NIF Long Description
 S PRCVI=0
 F  S PRCVI=$O(^PRC(441,PRCVN,6,PRCVI)) Q:'PRCVI  D
 . S PRCVST=^PRC(441,PRCVN,6,PRCVI,0)
 . S PRCVAL=$$CKINC(PRCVAL,PRCVST)
 . Q
 ;
 Q PRCVAL
 ;
GETDATA(PRCVNM) ;
 ;     Get all field required, 
 ;        Node 0
 ;
 N PRCVND,PRCVI,PRCVJ,PRCVCON,PRCVERR
 S PRCVERR=0
 S PRCVIT=$G(^PRC(441,PRCVNM,0))
 S PRCVND=$P(PRCVIT,U,1,6)
 S PRCVJ=6
 F PRCVI=8:1:11,13,14,15 D
 . S PRCVJ=PRCVJ+1
 . S $P(PRCVND,U,PRCVJ)=$P(PRCVIT,U,PRCVI)
 . Q
 S $P(PRCVND,U,11)="N"
 S:$P(PRCVIT,U,13)="Y"!("y") $P(PRCVND,U,11)="Y"
 S ^TMP("PRCVIT",$J,PRCVNM,0)=PRCVND
 ;
 ;        Node 1 - Description
 S PRCVI=0
 F  S PRCVI=$O(^PRC(441,PRCVNM,1,PRCVI)) Q:'PRCVI  D
 . S ^TMP("PRCVIT",$J,PRCVNM,1,PRCVI)=^PRC(441,PRCVNM,1,PRCVI,0)
 . Q
 ;        Node 2 - Vendors
 S PRCVI=0
 F  S PRCVI=$O(^PRC(441,PRCVNM,2,PRCVI)) Q:'PRCVI  D
 . S PRCVND=^PRC(441,PRCVNM,2,PRCVI,0)
 . ; Check if the contract exists in Vendor File
 . ; If not, send a message to Control Point officer
 . I $P(PRCVND,U)']"" S $P(PRCVND,U)=0
 . I $P(PRCVND,U,3)']"" S $P(PRCVND,U,3)=0
 . S PRCVCON=$G(^PRC(440,$P(PRCVND,U),4,$P(PRCVND,U,3),0))
 . I $P(PRCVND,U)>0,($P(PRCVND,U,3)>0),($P(PRCVCON,U)']"") D
 .. S PRCVERR=PRCVERR+1
 .. S PRCVERR(PRCVERR)="Contract # "_$P(PRCVND,U,3)_" of VENDOR - "_$P(PRCVND,U)_", "_$P($G(^PRC(440,$P(PRCVND,U),0)),U)_", for ITEM # "_PRCVNM_" does not exist in IFCAP Vendor file."
 .. S $P(PRCVND,U,3)=""
 .. Q
 . ; Check exp. date of contract, QUIT if expired more than 365 days
 . I $P(PRCVCON,U,3)]"",($P(PRCVCON,U,3)<$$FMADD^XLFDT(DT,-365)) S $P(PRCVND,U,3)=""
 . ; Conversion on PRCVND
 . S:$P(PRCVND,U,2)="" $P(PRCVND,U,2)=0
 . S:$P(PRCVND,U,8)="" $P(PRCVND,U,8)=1
 . S ^TMP("PRCVIT",$J,PRCVNM,2,PRCVI)=PRCVND
 . Q
 ;        Node 3
 I $D(^PRC(441,PRCVNM,3)) S ^TMP("PRCVIT",$J,PRCVNM,3)=^PRC(441,PRCVNM,3)
 ;
 ;        Node 4 - Fund Control Point
 S PRCVI=0
 F  S PRCVI=$O(^PRC(441,PRCVNM,4,PRCVI)) Q:'PRCVI  D
 . S PRCVND=^PRC(441,PRCVNM,4,PRCVI,0)
 . S $P(PRCVND,U)=$E($P(PRCVND,U),4,7)
 . S ^TMP("PRCVIT",$J,PRCVNM,4,PRCVI)=PRCVND
 . Q
 ;
 ;        Node 6 - Pre_NIF Long Description
 S PRCVI=0
 F  S PRCVI=$O(^PRC(441,PRCVNM,6,PRCVI)) Q:'PRCVI  D
 . S ^TMP("PRCVIT",$J,PRCVNM,6,PRCVI)=^PRC(441,PRCVNM,6,PRCVI,0)
 . Q
 ; If there are error(s), inform user by e-mail 
 I PRCVERR>0 D XMD
 Q
 ;
XMD ; Send a message to Control Point officer/clerk for data mismatch
 ;
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ
 S XMSUB="Inventory System ITEM Update Info "_$$HTE^XLFDT($H)
 S XMDUZ="IFCAP/COTS Inventory Interface"
 S XMTEXT="PRCVERR("
 ; S PRCVERR(1)="Contract "_PRCVCON_" of VENDOR # "_$P(PRCVND,U)_" for ITEM # "_PRCVNM_" does not existed in IFCAP Vendor file."
 S XMY("G.PRCV Item Vendor Edits")=""
 D ^XMD
 Q
 ;
CKINC(PRCVF,PRCVS) ;incremental checksum
 N LEN,FIB,C,I,PRCVAL,TEST
 S TEST=PRCVF
 S PRCVF=+$G(PRCVF)
 S PRCVS=$G(PRCVS)
 ;No change on null input
 Q:PRCVS="" PRCVF
 S LEN=$L(PRCVS)
 S PRCVAL=0
 S FIB(1)=1,FIB(2)=1
 F I=1:1:LEN D
 .S C=$E(PRCVS,I)
 .S:I>2 FIB(I)=FIB(I-1)+FIB(I-2)#2147483647
 .S PRCVAL=(PRCVF+PRCVAL+($A(C)*FIB(I)))#PRCVP
 Q PRCVAL
