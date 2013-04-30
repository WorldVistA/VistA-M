PRCHJS05 ;OI&T/KCL - IFCAP/ECMS INTERFACE 2237 SEND SEG BUILDERS;6/12/12
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
ORC(PRCWRK,PRCHLO,PRCER,PRCTOARY) ;Build ORC segment
 ;This function builds the ORC segment and adds it
 ;to the msg being built using HLO APIs. Any data
 ;manipulation or conversions are performed as needed.
 ;
 ; Supported ICR:
 ;   #10060: Allows retrieval of NAME (#.01) field from
 ;           NEW PERSON (#200) file using FM read.
 ;
 ;  Input:
 ;    PRCWRK - (required) name of work global containing 2237 data elements
 ;    PRCHLO - (required) HLO workspace used to build message, pass by ref
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned, pass by ref
 ;         PRCTOARY - (optional, pass by ref) returns the built segment in this format:
 ;                       PRCTOARY(1)
 ;
 N PRCSEG   ;contains the segment's data
 N PRCNAME  ;input array for $$HLNAME^XLFNAME
 N PRCNCOMP ;name components in HL7 format
 N PRCRSLT  ;function result
 ;
 ;init vars
 K PRCSEG S PRCSEG="" ;the segment should start off blank
 S PRCNAME("FIELD")=.01
 S PRCNAME("FILE")=200
 S PRCRSLT=1
 ;
 D SET^HLOAPI(.PRCSEG,"ORC",0)
 D SET^HLOAPI(.PRCSEG,"NW",1) ;new order/service
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("TRANUM")),U,2),2,1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("PRI")),U,1),5)
 D SET^HLOAPI(.PRCSEG,$$FMTHL7^XLFDT($P($G(@PRCWRK@("RQSTDT")),U,1)),9,1)
 ;
 ;get Accountable Officer name components
 S PRCNAME("IENS")=$P($G(@PRCWRK@("AO")),U,1)_","
 S PRCNCOMP=$$HLNAME^XLFNAME(.PRCNAME)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("AO")),U,1),11,1) ;duz
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,1),11,2,1) ;last
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,2),11,3) ;first
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,3),11,4) ;middle
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,4),11,5) ;suffix
 ;
 S ^TMP("KCLTST","AOESIG",$J)=$G(@PRCWRK@("AOESIG"))
 D SET^HLOAPI(.PRCSEG,$$FMTHL7^XLFDT($P($G(@PRCWRK@("AOESIG")),U,1)),11,19,1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("AOTITLE")),U,2),11,21)
 ;
 ;get Requestor name components
 S PRCNAME("IENS")=$P($G(@PRCWRK@("REQ")),U,1)_","
 S PRCNCOMP=$$HLNAME^XLFNAME(.PRCNAME)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("REQ")),U,1),12,1) ;duz
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,1),12,2,1) ;last
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,2),12,3) ;first
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,3),12,4) ;middle
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,4),12,5) ;suffix 
 ;
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("REQTITLE")),U,2),12,21)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("INVPT")),U,2),17,1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("INVABREV")),U,2),17,2)
 ;
 ;get Approving Official name components
 S PRCNAME("IENS")=$P($G(@PRCWRK@("APOF")),U,1)_","
 S PRCNCOMP=$$HLNAME^XLFNAME(.PRCNAME)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("APOF")),U,1),19,1) ;duz
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,1),19,2,1) ;last
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,2),19,3) ;first
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,3),19,4) ;middle
 D SET^HLOAPI(.PRCSEG,$P($G(PRCNCOMP),U,4),19,5) ;suffix
 ;
 D SET^HLOAPI(.PRCSEG,$$FMTHL7^XLFDT($P($G(@PRCWRK@("ESIGDT")),U,1)),19,19,1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("APOFTIT")),U,2),19,21)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("RQSRV")),U,2),21,1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("STANUM")),U,2),21,3)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("SUBSTA")),U,2),21,8,2)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("DELIVTO")),U,2),22,1,1)
 D SET^HLOAPI(.PRCSEG,$$FMTHL7^XLFDT($P($G(@PRCWRK@("DTREQ")),U,1)),27,1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("FRMTYP")),U,1),29,1)
 ;
 ;add segment to message being built
 I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER,.PRCTOARY) D
 . S PRCRSLT=0
 . S PRCER="ORC segment not built"
 ;
 Q PRCRSLT
 ;
 ;
TQ1(PRCWRK,PRCHLO,PRCLINE,PRCER) ;Build TQ1 segment
 ;This function builds a TQ1 segment for each delivery
 ;schedule associated with a line item and adds it to
 ;the msg being built using HLO APIs. Any data manipulation
 ;or conversions are performed as needed.
 ;
 ;  Input:
 ;    PRCWRK - (required) name of work global containing 2237 data elements
 ;    PRCHLO - (required) HLO workspace used to build message, pass by ref
 ;   PRCLINE - (required) line item number
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned, pass by ref
 ;
 N PRCSEG  ;contains the segment's data
 N PRCSUB  ;array subscript
 N PRCRSLT ;function result
 ;
 ;init vars
 K PRCSEG S PRCSEG="" ;the segment should start off blank
 S PRCLINE=+$G(PRCLINE)
 S PRCSUB=0
 S PRCRSLT=0
 ;
 I PRCLINE'>0 S PRCER="TQ1 segment not built - no line item passed" Q PRCRSLT
 I '$O(@PRCWRK@(PRCLINE,PRCSUB)) S PRCER="TQ1 segment not built - no delivery schedule for item" Q PRCRSLT
 ;
 S PRCRSLT=1
 ;
 ;loop thru delivery schedules for the line item
 F  S PRCSUB=$O(@PRCWRK@(PRCLINE,PRCSUB)) Q:('$G(PRCSUB)!('PRCRSLT))  D
 . D SET^HLOAPI(.PRCSEG,"TQ1",0)
 . D SET^HLOAPI(.PRCSEG,PRCSUB,1) ;Delivery Schedule #
 . D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,PRCSUB,"DELQTY")),U,2),2,1)
 . D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"UNITNM")),U,2),2,2,1)
 . D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"UNITFNM")),U,2),2,2,2)
 . D SET^HLOAPI(.PRCSEG,$$FMTHL7^XLFDT($P($G(@PRCWRK@(PRCLINE,PRCSUB,"DELDT")),U)),7,1)
 . D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,PRCSUB,"DELLOC")),U,2),10)
 . D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,PRCSUB,"DELREF")),U,2),11)
 . ;
 . ;add segment to message being built
 . I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER) D
 . . S PRCRSLT=0
 . . S PRCER="TQ1 segment not built"
 ;
 Q PRCRSLT
 ;
 ;
RQD(PRCWRK,PRCHLO,PRCLINE,PRCER,PRCTOARY) ;Build RQD segment
 ;This function builds the RQD segment and adds it to the
 ;msg being built using HLO APIs. Any data manipulation
 ;or conversions are performed as needed.
 ;
 ;  Input:
 ;    PRCWRK - (required) name of work global containing 2237 data elements
 ;    PRCHLO - (required) HLO workspace used to build message, pass by ref
 ;   PRCLINE - (required) line item number
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned, pass by ref
 ;         PRCTOARY - (optional, pass by ref) returns the built segment in this format:
 ;                       PRCTOARY(1)
 ;
 N PRCSEG  ;contains the segment's data
 N PRCRSLT ;function result
 ;
 ;init vars
 K PRCSEG S PRCSEG="" ;the segment should start off blank
 S PRCLINE=+$G(PRCLINE)
 S PRCRSLT=0
 ;
 I PRCLINE'>0 S PRCER="RQD segment not built - no line item passed" Q PRCRSLT
 I +$G(@PRCWRK@(PRCLINE,"ITLINE"))'>0 S PRCER="RQD segment not built - line item not found" Q PRCRSLT
 ;
 S PRCRSLT=1
 ;
 D SET^HLOAPI(.PRCSEG,"RQD",0)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"ITLINE")),U,2),1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"ITMFN")),U,2),2,1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMNSN")),U,2),2,4)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMFSC")),U,2),2,5)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"ITSTOCK")),U,2),3,1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"ITQTY")),U,2),5)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"UNITNM")),U,2),6,1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"UNITFNM")),U,2),6,2)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMPKGM")),U,2),6,4)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("COSTCTR")),U,2),7)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"ITBOC")),U,2),8)
 ;
 ;add segment to message being built
 I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER,.PRCTOARY) D
 . S PRCRSLT=0
 . S PRCER="RQD segment not built"
 ;
 Q PRCRSLT
 ;
 ;
RQ1(PRCWRK,PRCHLO,PRCLINE,PRCER,PRCTOARY) ;Build RQ1 segment
 ;This function builds the RQ1 segment and adds it to the
 ;msg being built using HLO APIs. Any data manipulation
 ;or conversions are performed as needed.
 ;
 ;  Input:
 ;    PRCWRK - (required) name of work global containing 2237 data elements
 ;    PRCHLO - (required) HLO workspace used to build message, pass by ref
 ;   PRCLINE - (required) line item number
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned, pass by ref
 ;         PRCTOARY - (optional, pass by ref) returns the built segment in this format:
 ;                       PRCTOARY(1)
 ;
 N PRCSEG  ;contains the segment's data
 N PRCRSLT ;function result
 ;
 ;init vars
 K PRCSEG S PRCSEG="" ;the segment should start off blank
 S PRCLINE=+$G(PRCLINE)
 S PRCRSLT=0
 ;
 I PRCLINE'>0 S PRCER="RQ1 segment not built - no line item passed" Q PRCRSLT
 I +$G(@PRCWRK@(PRCLINE,"ITLINE"))'>0 S PRCER="RQ1 segment not built - line item not found" Q PRCRSLT
 ;
 S PRCRSLT=1
 ;
 D SET^HLOAPI(.PRCSEG,"RQ1",0)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"ITCOST")),U,2),1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMMFG")),U,2),2,1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VENDPT")),U),4,1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VENDNM")),U,2),4,2)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMCTRCT")),U,2),4,4)
 D SET^HLOAPI(.PRCSEG,$$FMTHL7^XLFDT($P($G(@PRCWRK@(PRCLINE,"IMEXPDT")),U,1)),4,5)
 ;
 ;add segment to message being built
 I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER,.PRCTOARY) D
 . S PRCRSLT=0
 . S PRCER="RQ1 segment not built"
 ;
 Q PRCRSLT
 ;
 ;
ZA1(PRCWRK,PRCHLO,PRCLINE,PRCER,PRCTOARY) ;Build ZA1 segment
 ;This function builds the ZA1 segment and adds it to the
 ;msg being built using HLO APIs. Any data manipulation
 ;or conversions are performed as needed.
 ;
 ;  Input:
 ;    PRCWRK - (required) name of work global containing 2237 data elements
 ;    PRCHLO - (required) HLO workspace used to build message, pass by ref
 ;   PRCLINE - (required) line item number
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned, pass by ref
 ;         PRCTOARY - (optional, pass by ref) returns the built segment in this format:
 ;                       PRCTOARY(1)
 ;
 N PRCSEG  ;contains the segment's data
 N PRCRSLT ;function result
 ;
 K PRCSEG S PRCSEG="" ;the segment should start off blank
 S PRCLINE=+$G(PRCLINE)
 S PRCRSLT=0
 ;
 I PRCLINE'>0 S PRCER="ZA1 segment not built - no line item passed" Q PRCRSLT
 I +$G(@PRCWRK@(PRCLINE,"ITLINE"))'>0 S PRCER="ZA1 segment not built - line item not found" Q PRCRSLT
 ;
 S PRCRSLT=1
 ;
 D SET^HLOAPI(.PRCSEG,"ZA1",0)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMNDC")),U,2),1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMFOOD")),U,1),2)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMNIF")),U,2),3)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMMIN")),U,2),4)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMMAX")),U,2),5)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMREQ")),U,2),6)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"IMUCF")),U,2),7)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@(PRCLINE,"ITDMID")),U,2),8)
 ;
 ;add segment to message being built
 I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER,.PRCTOARY) D
 . S PRCRSLT=0
 . S PRCER="ZA1 segment not built"
 ;
 Q PRCRSLT
 ;
 ;
NTEITEM(PRCWRK,PRCHLO,PRCLINE,PRCER) ;Build NTE segments for item description
 ;This function builds repeating NTE segments for the
 ;description of the item being ordered and adds it
 ;to the msg being built using HLO APIs.
 ;
 ;  Input:
 ;    PRCWRK - (required) name of work global containing 2237 data elements
 ;    PRCHLO - (required) HLO workspace used to build message, pass by ref
 ;   PRCLINE - (required) line item number
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned, pass by ref
 ;
 N PRCSETID ;segment set id
 N PRCSUB   ;array subscript
 N PRCSEG   ;contains the segment's data
 N PRCRSLT  ;function result
 ;
 ;init vars
 K PRCSEG S PRCSEG="" ;the segment should start off blank
 S PRCLINE=+$G(PRCLINE)
 S PRCRSLT=0
 ;
 I PRCLINE'>0 S PRCER="NTE item segment not built - no line item passed" Q PRCRSLT
 I +$G(@PRCWRK@(PRCLINE,"ITLINE"))'>0 S PRCER="NTE item segment not built - line item not found" Q PRCRSLT
 ;
 S PRCRSLT=1
 ;
 ;loop thru Description nodes for the Line Item
 S (PRCSUB,PRCSETID)=0
 F  S PRCSUB=$O(@PRCWRK@(PRCLINE,"ITDESC",PRCSUB)) Q:'$G(PRCSUB)!('PRCRSLT)  D
 . S PRCSETID=PRCSETID+1
 . D SET^HLOAPI(.PRCSEG,"NTE",0)
 . D SET^HLOAPI(.PRCSEG,PRCSETID,1)
 . D SET^HLOAPI(.PRCSEG,"P",2) ;P for Placer (Orderer) 
 . D SET^HLOAPI(.PRCSEG,$G(@PRCWRK@(PRCLINE,"ITDESC",PRCSUB,0)),3)
 . D SET^HLOAPI(.PRCSEG,"LD",4,1) ;LD for Line Item Description
 . ;
 . ;add segment to message being built
 . I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER) D
 . . S PRCRSLT=0
 . . S PRCER="NTE segment not built"
 ;
 Q PRCRSLT
