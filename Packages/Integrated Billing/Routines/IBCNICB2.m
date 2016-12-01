IBCNICB2 ;FA/ALB - Update utilities for the ICB interface ;1 SEP 2009
 ;;2.0;INTEGRATED BILLING;**549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IB*2.0*549 - New routine because of routine size of IBCNICB
 ;
EXACTM(IBINSDA,IBBUFDA) ;EP
 ; Check for an exact match on an existing group plan  when trying to add a
 ; new one
 ; IB*2.0*549 - Added method
 ; Input:   IBINSDA     - IEN of the Insurance Company (file 36) associated
 ;                        with the group plan being added
 ;          IBBUFDA     - IEN of the Insurance Buffer entry (file 355.33)
 ; Returns: 1 - Exact match found on Insurance Company, Group Name and Group Number
 ;          0 - Otherwise
 N BGRPNM,BGRPNUM,FOUND,GRPNM,GRPNUM,IEN
 S BGRPNM=$$GET1^DIQ(355.33,IBBUFDA_",",90.01)      ; External Group Name from buffer
 S BGRPNM=$$UP^XLFSTR(BGRPNM)                       ; Convert to Upper case
 S BGRPNM=$$TRIM^XLFSTR(BGRPNM,"R"," ")             ; Strip Trailing spaces
 S BGRPNUM=$$GET1^DIQ(355.33,IBBUFDA_",",90.02)     ; External Group Number from buffer
 S BGRPNUM=$$UP^XLFSTR(BGRPNUM)                     ; Convert to Upper case
 S BGRPNUM=$$TRIM^XLFSTR(BGRPNUM,"R"," ")           ; Strip Trailing spaces
 S FOUND=0,IEN=""
 ;
 ; No need to execute for loop if no group name and no group number
 I BGRPNM="",BGRPNUM="" Q FOUND
 F  D  Q:IEN=""!FOUND
 . S IEN=$O(^IBA(355.3,"B",IBINSDA,IEN))
 . Q:IEN=""
 . S GRPNM=$$GET1^DIQ(355.3,IEN_",",2.01)           ; External Group Name from group plan
 . S GRPNM=$$UP^XLFSTR(GRPNM)                       ; Convert to Upper case
 . S GRPNM=$$TRIM^XLFSTR(GRPNM,"R"," ")             ; Strip Trailing spaces
 . Q:GRPNM'=BGRPNM                                  ; Not an 'exact' match
 . S GRPNUM=$$GET1^DIQ(355.3,IEN_",",2.02)          ; External Group Number from group plan
 . S GRPNUM=$$UP^XLFSTR(GRPNUM)                     ; Convert to Upper case
 . S GRPNUM=$$TRIM^XLFSTR(GRPNUM,"R"," ")           ; Strip Trailing spaces
 . Q:GRPNUM'=BGRPNUM                                ; Not an 'exact' match
 . S FOUND=1
 Q FOUND
 ; 
