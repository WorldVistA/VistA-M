PRCHJS06 ;OI&T/KCL - IFCAP/ECMS INTERFACE 2237 SEND SEG BUILDERS CONT.;6/12/12
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
NTE(PRCWRK,PRCHLO,PRCER) ;Build NTE segments
 ;This function builds repeating NTE segments for the 2237
 ;word processing fields Special Remarks, Justification,
 ;and Comments. Segments are built and added to the msg
 ;being built using HLO APIs.
 ;
 ;  Input:
 ;   PRCWRK - (required) name of work global containing 2237 data elements
 ;   PRCHLO - (required) HLO workspace used to build message, pass by ref
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned, pass by ref
 ;
 N PRCSETID ;segment set id
 N PRCSUB   ;array subscript
 N PRCSEG   ;contains the segment data
 N PRCRSLT  ;function result
 ;
 ;init vars
 K PRCSEG S PRCSEG="" ;the segment should start off blank
 S PRCSETID=0
 S PRCRSLT=1
 ;
 D  ;drops out of DO block on failure
 . ;
 . ;loop thru Special Remarks nodes and put into NTE seg
 . S PRCSUB=0
 . F  S PRCSUB=$O(@PRCWRK@("REMARKS",PRCSUB)) Q:'$G(PRCSUB)  D
 . . S PRCSETID=PRCSETID+1
 . . D SET^HLOAPI(.PRCSEG,"NTE",0)
 . . D SET^HLOAPI(.PRCSEG,PRCSETID,1)
 . . D SET^HLOAPI(.PRCSEG,"P",2) ;P for Placer Order
 . . D SET^HLOAPI(.PRCSEG,$G(@PRCWRK@("REMARKS",PRCSUB,0)),3)
 . . D SET^HLOAPI(.PRCSEG,"RR",4,1) ;RR for Request Remarks
 . . ;
 . . ;add segment to message being built
 . . I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER) S PRCRSLT=0,PRCER="NTE remarks segment not built"
 . ;
 . Q:'PRCRSLT
 . ;
 . ;loop thru Justification nodes and put into NTE seg
 . S PRCSUB=0
 . F  S PRCSUB=$O(@PRCWRK@("JUSTIF",PRCSUB)) Q:'$G(PRCSUB)  D
 . . S PRCSETID=PRCSETID+1
 . . D SET^HLOAPI(.PRCSEG,"NTE",0)
 . . D SET^HLOAPI(.PRCSEG,PRCSETID,1)
 . . D SET^HLOAPI(.PRCSEG,"P",2) ;P for Placer Order
 . . D SET^HLOAPI(.PRCSEG,$G(@PRCWRK@("JUSTIF",PRCSUB,0)),3)
 . . D SET^HLOAPI(.PRCSEG,"RJ",4,1) ;RJ for Request Justification
 . . ;
 . . ;add segment to message being built
 . . I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER) S PRCRSLT=0,PRCER="NTE justification segment not built"
 . ;
 . Q:'PRCRSLT
 . ;
 . ;loop thru Comments nodes and put into NTE seg
 . S PRCSUB=0
 . F  S PRCSUB=$O(@PRCWRK@("COMMENT",PRCSUB)) Q:'$G(PRCSUB)  D
 . . S PRCSETID=PRCSETID+1
 . . D SET^HLOAPI(.PRCSEG,"NTE",0)
 . . D SET^HLOAPI(.PRCSEG,PRCSETID,1)
 . . D SET^HLOAPI(.PRCSEG,"P",2) ;P for Placer Order
 . . D SET^HLOAPI(.PRCSEG,$G(@PRCWRK@("COMMENT",PRCSUB,0)),3)
 . . D SET^HLOAPI(.PRCSEG,"RC",4,1) ;RC for Request Comments
 . . ;
 . . ;add segment to message being built
 . . I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER) S PRCRSLT=0,PRCER="NTE comments segment not built"
 ;
 Q PRCRSLT
 ;
 ;
ZZ1(PRCWRK,PRCHLO,PRCER,PRCTOARY) ;Build ZZ1 segment
 ;This function builds the ZZ1 segment and adds it to the
 ;msg being built using HLO APIs. Any data manipulation
 ;or conversions are performed as needed.
 ;
 ; Supported ICR:
 ;   #10056: Allows retrieval of ABBREVIATION (#1) field from STATE (#5)
 ;           file using FM read.
 ;
 ;  Input:
 ;   PRCWRK - (required) name of work global containing 2237 data elements
 ;   PRCHLO - (required) HLO workspace used to build message, pass by ref
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned, pass by ref
 ;         PRCTOARY - (optional, pass by ref) returns the built segment in this format:
 ;                       PRCTOARY(1)
 ;
 N PRCSEG   ;contains the segment's data
 N PRCSTATE ;state abbreviation
 N PRCRSLT  ;function result
 ;
 ;init vars
 K PRCSEG S PRCSEG="" ;the segment should start off blank
 S PRCRSLT=1
 ;
 D SET^HLOAPI(.PRCSEG,"ZZ1",0)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VENDAD1")),U,2),1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VENDAD2")),U,2),2)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VENDAD3")),U,2),3)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VENDAD4")),U,2),4)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VENDCTY")),U,2),5)
 ;
 ;retrieve State Abbreviation from (#5) file and set into seg
 S PRCSTATE=$$GET1^DIQ(5,+$G(@PRCWRK@("VENDST"))_",",1)
 D SET^HLOAPI(.PRCSEG,$G(PRCSTATE),6)
 ;
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VENDZIP")),U,2),7)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VENDCON")),U,2),8)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VENDPH")),U,2),9)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VACT")),U,2),10)
 ;
 ;add segment to message being built
 I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER,.PRCTOARY) D
 . S PRCRSLT=0
 . S PRCER="ZZ1 segment not built"
 ;
 Q PRCRSLT
 ;
 ;
ZZ2(PRCWRK,PRCHLO,PRCER,PRCTOARY) ;Build ZZ2 segment
 ;This function builds the ZZ2 segment and adds it to the
 ;msg being built using HLO APIs. Any data manipulation
 ;or conversions are performed as needed.
 ;
 ; Supported ICR:
 ;   #10056: Allows retrieval of ABBREVIATION (#1) field from STATE (#5)
 ;           file using FM read.
 ;
 ;  Input:
 ;   PRCWRK - (required) name of work global containing 2237 data elements
 ;   PRCHLO - (required) HLO workspace used to build message, pass by ref
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;            PRCER - (optional) on failure, an error message is returned, pass by ref
 ;         PRCTOARY - (optional, pass by ref) returns the built segment in this format:
 ;                       PRCTOARY(1)
 ;
 N PRCSEG   ;contains the segment's data
 N PRCSTATE ;state abbreviation
 N PRCRSLT  ;function result
 ;
 ;init vars
 K PRCSEG S PRCSEG="" ;the segment should start off blank
 S PRCRSLT=1
 ;
 D SET^HLOAPI(.PRCSEG,"ZZ2",0)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VPAYCON")),U,2),1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VPAYPH")),U,2),2)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VPAYAD1")),U,2),3)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VPAYAD2")),U,2),4)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VPAYAD3")),U,2),5)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VPAYAD4")),U,2),6)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VPAYCTY")),U,2),7)
 ;
 ;retrieve State Abbreviation from (#5) file and set into seg
 S PRCSTATE=$$GET1^DIQ(5,+$G(@PRCWRK@("VPAYST"))_",",1)
 D SET^HLOAPI(.PRCSEG,$G(PRCSTATE),8)
 ;
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VPAYZIP")),U,2),9)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VEDI")),U,1),10)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VGDV")),U,1),11)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VDUNS")),U,2),12)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VFMSNM")),U,2),13)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VFAX")),U,2),14)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("VID")),U,2),15)
 ;
 ;add segment to message being built
 I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER,.PRCTOARY) D
 . S PRCRSLT=0
 . S PRCER="ZZ2 segment not built"
 ;
 Q PRCRSLT
 ;
 ;
ZZ3(PRCWRK,PRCHLO,PRCER,PRCTOARY) ;Build ZZ3 segment
 ;This function builds the ZZ3 segment and adds it to the
 ;msg being built using HLO APIs. Any data manipulation
 ;or conversions are performed as needed.
 ;
 ;  Input:
 ;   PRCWRK - (required) name of work global containing 2237 data elements
 ;   PRCHLO - (required) HLO workspace used to build message, pass by ref
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
 S PRCRSLT=1
 ;
 D SET^HLOAPI(.PRCSEG,"ZZ3",0)
 D SET^HLOAPI(.PRCSEG,$$FMTHL7^XLFDT($P($G(@PRCWRK@("COMMITDT")),U,1)),1)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("COMMIT")),U,2),2)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("TRANSAMT")),U,2),3)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("ACTDATA")),U,2),4)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("FCPPRJ")),U,2),5)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("ESTSHIP")),U,2),6)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("CTRLPT")),U,2),7)
 D SET^HLOAPI(.PRCSEG,$P($G(@PRCWRK@("EXPEND")),U,1),8)
 D SET^HLOAPI(.PRCSEG,$E($P($G(@PRCWRK@("BBFY")),U,2),1,4),9)
 ;
 ;add segment to message being built
 I '$$ADDSEG^HLOAPI(.PRCHLO,.PRCSEG,.PRCER,.PRCTOARY) D
 . S PRCRSLT=0
 . S PRCER="ZZ3 segment not built"
 ;
 Q PRCRSLT
