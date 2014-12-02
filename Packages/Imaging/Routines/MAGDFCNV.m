MAGDFCNV ;WOIFO/PMK - Read HL7 and generate DICOM ; 03 Sep 2013 10:12 AM
 ;;3.0;IMAGING;**11,51,141,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 ; This routine needs to be on both the Gateway and on the VistA HIS.
 ;
 ; The M-to-M Broker Gateway can't use $$CONSOLID^MAGBAPI since is
 ; doesn't have DDP.
 ;
 ; Note: The ^MAGOSFIL routine can never be on the VistA HIS.
 ;
CONSOLID() ; check if this is a consolidated site or not
 ; return 0 = non-consolidated (normal) site
 ; return 1 = consolidated site
 ;
 ; code for the main VistA HIS
 Q $GET(^MAG(2006.1,"CONSOLIDATED"))="YES"
 ;
ACQDEV(MFGR,MODEL,SITE) ; get pointer to the Acquisition Device file
 N ACQDEV ;--- name of acquisition device
 N ACQDEVP ;-- pointer to acquisition device file (#2006.04)
 ;
 S ACQDEV=$$UP^MAGDFCNV(MFGR_" ("_MODEL_")")
 S ACQDEVP=$O(^MAG(2006.04,"B",ACQDEV,""))
 I 'ACQDEVP D  ; create the entry
 . L +^MAG(2006.04,0):1E9 ; serialize name generation code
 . I '$D(^MAG(2006.04,0)) S ^(0)="ACQUISITION DEVICE^2006.04^^"
 . S ACQDEVP=$P(^MAG(2006.04,0),"^",3)+1
 . S ^MAG(2006.04,ACQDEVP,0)=ACQDEV_"^"_SITE_"^" ; 3rd piece is null
 . S ^MAG(2006.04,"B",ACQDEV,ACQDEVP)=""
 . S $P(^MAG(2006.04,0),"^",3)=ACQDEVP
 . S $P(^MAG(2006.04,0),"^",4)=ACQDEVP
 . L -^MAG(2006.04,0) ; clear the serial name generation code
 Q ACQDEVP
 ;
EQUIVGRP(P1,P2) ; see if two SOP Class pointers are in equivalent groups
 N G1,G2
 Q:'$G(P1) 0
 Q:'$G(P2) 0
 S G1=$P($G(^MAG(2006.532,P1,0)),"^",3) S:G1="" G1=P1
 S G2=$P($G(^MAG(2006.532,P2,0)),"^",3) S:G2="" G2=P2
 Q G1=G2
 ;
UP(X) ; special UPPER CASE function -- removes redundant blanks as well
 F  Q:X'["  "  S $E(X,$F(X,"  ")-1)=""  ; remove redundant blank
 I $E(X)=" " S $E(X)=""  ; remove leading blank
 I $E(X,$L(X))=" " S $E(X,$L(X))=""  ; remove trailing blank
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz^|","ABCDEFGHIJKLMNOPQRSTUVWXYZ~~")
 ;
STATNUMB() ; return numeric 3-digit station number for the VA
 N STATNUMB
 S STATNUMB=$$STA^XUAF4($$KSP^XUPARAM("INST")) ; station number
 ; station number is 3 digits, exclusive of any modifiers or full station number for IHS
 Q $S($$ISIHS^MAGSPID():STATNUMB,1:$E(STATNUMB,1,3))
 ;
GMRCACN(GMRCIEN) ; return a site-specific accession number for clinical specialties
 ; GMRCIEN is the CPRS Consult Request Tracking GMRC IEN - REQUEST/CONSULTATION file(#123)
 N ACNUMB ; accession number for a consult/procedure request
 ; Format: <sss>-GMR-<gmrcien>, where <sss> is station number, and <gmrcien>
 ;         is the internal entry number of the request, up to 8 digits (100 million) 
 S ACNUMB=$$STATNUMB()_"-GMR-"_GMRCIEN
 Q ACNUMB
 ;
GMRCIEN(ACNUMB) ; return the GMRC IEN, given a consult/procedure accession number
 ; ACNUMB is the accession number for a consult/procedure request
 ; OLD Format: GMRC-<gmrcien>, where <gmrcien>is the internal entry number of the request
 ; New Format: <sss>-GMR-<gmrcien>, where <sss> is station number, and <gmrcien>
 ;             is the internal entry number of the request, up to 8 digits (100 million)
 N GMRCIEN ; CPRS Consult Request Tracking GMRC IEN - REQUEST/CONSULTATION file(#123)
 I ACNUMB?1"GMRC-"1N.N S GMRCIEN=$P(ACNUMB,"-",2) ; return the second piece
 E  I ACNUMB?1N.N1"-GMR-"1N.N S GMRCIEN=$P(ACNUMB,"-",3) ; return the third piece
 E  S GMRCIEN="" ; invalid consult request tracking accession number format
 Q GMRCIEN
