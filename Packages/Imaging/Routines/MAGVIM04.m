MAGVIM04 ;WOIFO/MAT - Utilities for RPC calls for DICOM file processing ; 3 Feb 2012 4:35 AM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
 Q
 ;+++ Importer II Log Reports: Data Delivery
 ;
 ; Internal processing routine for RPC: MAGV IMPORT STUDY LOG REPORT
 ;
 ; Output report data from MAGV IMPORTER LOG File (#2006.9421).
 ;
 ; Inputs:
 ; =======
 ;
 ;  MAGVARY .... Variable for returned data.
 ;  FILE ....... Data source file number.
 ;  REPORT ..... Report selector = {1, 2, 3}
 ;  STARTDT .... Inclusive lower bound of query date range.
 ;  STOPDT ..... Inclusive upper "".
 ;  
 ; Outputs:
 ; ========
 ; 
 ;  Expected: ^(0) 0`Count of lines returned.
 ;             (n) Global array of report data.
 ;             
 ;  On Error: ^(0) <0`Error message.
 ; 
 ; Notes
 ; =====
 ;
 ;  Called by IMPLOGEX^MAGVIM03.
 ;
MAGVQRY(MAGVARY,FILE,REPORT,STARTDT,STOPDT) ;
 ;
 ;--- Initialize counter arrays.
 K MAGVCT,MAGVDT,MAGVLC,MAGVMC,MAGVTP
 S MAGVCT("TOTALDT")=0 ;Hits within date range.
 S MAGVCT("RSELTOT")=0 ;Total ... total what?
 ;--- Initialize overhead counters for SERIES, OBJECTs imported, OBjects FAILED
 N SS F SS="SERIES","OBJECT","OBFAIL" S MAGVCT(SS)=0
 N MAGVNOD S MAGVNOD=$NA(^MAGV(FILE,"B",STARTDT))
 N STOPDT0
 D
 . ;--- Compensate STOPDT for $QS logic. IA #10000
 . N X,X1,X2 S X1=STOPDT,X2=1 D C^%DTC S STOPDT0=X
 F  S MAGVNOD=$Q(@MAGVNOD) Q:+$QS(MAGVNOD,3)]STOPDT0  Q:$QS(MAGVNOD,2)'="B"  D
 . ;
 . S MAGVCT("TOTALDT")=MAGVCT("TOTALDT")+1
 . ;--- Count of imported studies per date.
 . N RECDT S RECDT=$QS(MAGVNOD,3)\1
 . S:'$D(MAGVDT(RECDT)) MAGVDT(RECDT)=0
 . S MAGVDT(RECDT)=MAGVDT(RECDT)+1
 . N MAGVIEN S MAGVIEN=$QS(MAGVNOD,4)
 . ;--- Set working node.
 . N MAGVNOD0 S MAGVNOD0=$G(^MAGV(FILE,MAGVIEN,0))
 . ;
 . ;--- Get counts for this MAGVIEN.
 . ;--- Counts per "Study Performed Location"
 . N MAGVSLOC S MAGVSLOC=$P(MAGVNOD0,U,7)
 . S:MAGVSLOC="" MAGVSLOC="UNSPECIFIED"
 . S:MAGVSLOC?1N.N MAGVSLOC="UNSPECIFIED"
 . S:'$D(MAGVLC(MAGVSLOC)) MAGVLC(MAGVSLOC)=0,MAGVLC(0)=0
 . S MAGVLC(MAGVSLOC)=MAGVLC(MAGVSLOC)+1,MAGVLC(0)=MAGVLC(0)+1
 . ;--- Count of imported studies per study type.
 . N MAGVSTYP S MAGVSTYP=$P(MAGVNOD0,U,8) S:MAGVSTYP="" MAGVSTYP="UNSPECIFIED"
 . S:'$D(MAGVTP(MAGVSTYP)) MAGVTP(MAGVSTYP)=0
 . S MAGVTP(MAGVSTYP)=MAGVTP(MAGVSTYP)+1
 . ;
 . N CTSERIES S CTSERIES=$P(MAGVNOD0,U,9)
 . N CTOBJECT S CTOBJECT=$P(MAGVNOD0,U,10)
 . N CTOBFAIL S CTOBFAIL=$P(MAGVNOD0,U,12)
 . ;
 . F SS="SERIES","OBJECT","OBFAIL" D
 . . ;--- Add each to its overhead counter.
 . . S MAGVCT(SS)=MAGVCT(SS)+@("CT"_SS)
 . . ;
 . . ;--- Add each to its per-date counter.
 . . S:'$D(MAGVDT(RECDT,SS)) MAGVDT(RECDT,SS)=0
 . . S MAGVDT(RECDT,SS)=MAGVDT(RECDT,SS)+@("CT"_SS)
 . . ;
 . . ;--- Add each to its per-location counter.
 . . S:'$D(MAGVLC(MAGVSLOC,SS)) MAGVLC(MAGVSLOC,SS)=0
 . . S MAGVLC(MAGVSLOC,SS)=MAGVLC(MAGVSLOC,SS)+@("CT"_SS)
 . . ;
 . . ;--- Add each to its per-studyType counter.
 . . S:'$D(MAGVTP(MAGVSTYP,SS)) MAGVTP(MAGVSTYP,SS)=0
 . . S MAGVTP(MAGVSTYP,SS)=MAGVTP(MAGVSTYP,SS)+@("CT"_SS)
 . . Q
 . ;--- Count of modalities (only for REPORT=3 right now).
 . I REPORT=3 D  K MAGVA
 . . ;
 . . N CTNDX,SFNDX,SUBFILE
 . . S SUBFILE=2006.94211
 . . ;
 . . ;--- Get number of modality counter subfile entries.
 . . S CTNDX=$P($G(^MAGV(FILE,MAGVIEN,100,0)),U,3)
 . . Q:CTNDX<1
 . . ;
 . . ;--- Grand Total counter ... no filter.
 . . F SFNDX=1:1:CTNDX D
 . . . ;
 . . . N MAGVLB S MAGVLB=$$GET1^DIQ(SUBFILE,SFNDX_","_MAGVIEN_",",.01)
 . . . N MAGVMCT S MAGVMCT=+$$GET1^DIQ(SUBFILE,SFNDX_","_MAGVIEN_",",.02)
 . . . S:'$D(MAGVMC(MAGVLB)) MAGVMC(MAGVLB)=0
 . . . S MAGVMC(MAGVLB)=MAGVMC(MAGVLB)+MAGVMCT
 . . . Q
 . . Q
 . Q
 D MAGVOUTP
 Q
 ;
 ;+++ Internal entry point: Assemble report output.
 ;
MAGVOUTP ;
 ;
 N CT S CT=0
 ;
 N TIME S TIME=$$NOW^XLFDT,TIME=$$FMTE^XLFDT(TIME)
 N LNA S LNA="" S $P(LNA,"*",81)=""
 N LNH S LNH="" S $P(LNH,"-",81)=""
 N LNS S LNS="" S $P(LNS," ",81)=""
 N LNU S LNU="" S $P(LNU,"_",81)=""
 ;--- Output general header.
 S CT=CT+1,@MAGVARY@(CT)="Imaging Importer II Report: "_TIME
 ;
 D ZRUCR(2)
 D
 . S CT=CT+1
 . I STARTDT=STOPDT D  Q
 . . S @MAGVARY@(CT)="  Imported on "_$$FMTE^XLFDT(STARTDT,5)_":"
 . S @MAGVARY@(CT)="  Imported between "_$$FMTE^XLFDT(STARTDT,5)_" and "_$$FMTE^XLFDT(STOPDT,5)_":"
 D ZRUCR(2)
 S CT=CT+1,@MAGVARY@(CT)=$E(LNS,1,23)_$J(MAGVCT("TOTALDT"),10)_"  Studies"
 S CT=CT+1,@MAGVARY@(CT)=$E(LNS,1,23)_$J(MAGVCT("SERIES"),10)_"  Series"
 S CT=CT+1,@MAGVARY@(CT)=$E(LNS,1,23)_$J(MAGVCT("OBJECT"),10)_"  Objects"
 S CT=CT+1,@MAGVARY@(CT)=$E(LNS,1,23)_$J(MAGVCT("OBFAIL"),10)_"  Objects Failed"
 S CT=CT+1,@MAGVARY@(CT)=$E(LNU,1,56)
 D ZRUCR(1)
 ;--- Branch to specific report.
 D
 . I REPORT=1 D REPDAT Q
 . I REPORT=2 D REPLCN Q
 . I REPORT=3 D REPMOD Q
 S CT=CT+1,@MAGVARY@(CT)=$E(LNA,1,6)_" END OF REPORT "_$E(LNA,1,6)
 Q
 ;
REPDAT ;
 ;--- Output date specific column headers.
 S CT=CT+1,@MAGVARY@(CT)=$E(LNS,1,45)_"Failed"
 S CT=CT+1,@MAGVARY@(CT)="DATE______"_"     Studies"_"   Series"_"   Objects"_"   Objects"
 D ZRUCR(1)
 ;
 ;--- Tabular output by date.
 N DATE S DATE=""
 F  S DATE=$O(MAGVDT(DATE)) Q:DATE=""  D
 . ;
 . S CT=CT+1
 . N OUTDATE S OUTDATE=$$FMTE^XLFDT(DATE,5)
 . S @MAGVARY@(CT)=$J(OUTDATE,10)_"    "_$J(MAGVDT(DATE),8)_" "_$J(MAGVDT(DATE,"SERIES"),8)
 . S @MAGVARY@(CT)=@MAGVARY@(CT)_"  "_$J(MAGVDT(DATE,"OBJECT"),8)_"  "_$J(MAGVDT(DATE,"OBFAIL"),8)
 . Q
 D ZRUCR(1)
 Q
 ;
REPLCN ;
 ;--- Output location specific column headers.
 S CT=CT+1,@MAGVARY@(CT)=$E(LNS,1,50)_"Failed"
 S CT=CT+1,@MAGVARY@(CT)="LOCATION_______"_"     Studies"_"   Series"_"   Objects"_"   Objects"
 D ZRUCR(2)
 ;
 ;--- Tabular output by location.
 N LOCN S LOCN=$O(MAGVLC(""))
 F  S LOCN=$O(MAGVLC(LOCN)) Q:LOCN=""  D
 . ;
 . ;--- Pad a location under 15 characters.
 . N LLOCN S LLOCN=$L($E(LOCN,1,15))
 . N SPAD S SPAD=3+(15-LLOCN)
 . ;
 . S CT=CT+1
 . S @MAGVARY@(CT)=$E(LOCN,1,15)_":"_$E(LNS,1,SPAD)_$J(MAGVLC(LOCN),8)_" "_$J(MAGVLC(LOCN,"SERIES"),8)
 . S @MAGVARY@(CT)=@MAGVARY@(CT)_"  "_$J(MAGVLC(LOCN,"OBJECT"),8)_"  "_$J(MAGVLC(LOCN,"OBFAIL"),8)
 . ;
 . D ZRUCR(1)
 . S CT=CT+1,@MAGVARY@(CT)=$E(LNH,1,56)
 . D ZRUCR(2)
 D ZRUCR(1)
 Q
 ;
REPMOD ;
 S CT=CT+1,@MAGVARY@(CT)=$E(LNS,1,27)_"COUNT ... MODALITY"
 D ZRUCR(1)
 S SS="" F  S SS=$O(MAGVMC(SS)) Q:SS=""  D
 . S CT=CT+1,@MAGVARY@(CT)=$E(LNS,1,22)_$J(MAGVMC(SS),10)_" ... "_SS
 D ZRUCR(1)
 Q
 ;+++ Routine utility: Output 'Carriage Return'
ZRUCR(REP) ;
 N X F X=1:1:REP S CT=CT+1,@MAGVARY@(CT)=""
 Q
 ;
 ; MAGVIM04
