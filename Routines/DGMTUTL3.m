DGMTUTL3 ;ALB/GTS - Means Test generic utilities ; 12/16/05 2:53pm
 ;;5.3;Registration;**688**;Aug 13, 1993;Build 29
 ;
VER(DGINC) ;* Return the version of Individual Annual Income records (0 or 1)
 ; Input:  DGINC   Individual Annual Income IEN Array
 ; Output: 1 - version 1 1010EZ form Feb, 2005
 ;         0 - version 0 1010EZ form pre Feb, 2005
 ;        -1 - Annual Means Test record is associated and it is not a
 ;              Means/Co-Pay test
 ;
 ;  Example on input array:
 ;       DGINC("D",#) = 408.21 record IENs for dependents.  # 1 node 
 ;                       for each Dependent
 ;       DGINC("S") = 408.21 record IEN for active Spouse
 ;       DGINC("V") = 408.21 record IEN for Veteran
 ;
 N MTVER,RECTYP,IAIIEN,CONVRT,FORM,IAIVER
 S MTVER=1 ;Version returned from API.  If IAI rec's are for LTC tests,
 ;           then VER exits and returns -1
 ;
 ;If a veteran DGINC node is not defined, then there is no IAI records
 ; for last year (current MT) and new (version 1) records will be entered
 ;QUIT!!
 I '$G(DGINC("V")) Q MTVER
 ;
 S CONVRT=-1 ;Indicates record is converted.
 ;             (-1: LTC rec 0: 408.21/2.11 is null or 0;
 ;               1: 408.21/2.11 is 1)
 ; Version returned from IAIWALK.  Any value of 0 causes VER to exit and return 0
 S IAIVER=1
 ;            
 ;
 ; MTVER could be 0 because the IAI node is walked or is found to either
 ;  have a 0 or null in 2.11.  If 2.11 is null, the record has not been reviewed
 ;  and a version not indicated.
 ;
 ; Check type of test associated with IAI records
 I (+$P($G(^DGMT(408.31,+$G(^DGMT(408.21,DGINC("V"),"MT")),0)),"^",19)>2) DO
 . W !!,"Income Records are for Long Term Care type tests.  This data can not be edited."
 . S MTVER=-1
 ;
 Q:(MTVER=-1) MTVER  ;QUIT if IAI records are for LTC type tests
 ;
 ; Quit loop if version is found to be 0 or the MT record has been
 ;  verified and a version indicated
 F RECTYP="V","S","D"  Q:(+MTVER=0)  Q:(+CONVRT=1)  DO
 . I RECTYP'="D" DO
 . . I $D(DGINC(RECTYP)) DO
 . . . S IAIIEN=DGINC(RECTYP)
 . . . ;Check 2.11 on related MT record in 408.31
 . . . ; (CONVRT=-1 : Conversion check not yet completed)
 . . . ;MTRECVER will return a value of 0 or 1 for CONVRT
 . . . D:(+CONVRT=-1) MTRECVER(IAIIEN,.FORM,.CONVRT) ;Assume all IAI rec's have #31 or don't
 . . . S:(CONVRT=1) MTVER=FORM ;If 408.31 rec has a version,
 . . . ;                         set MTVER and Quit with that value
 . . . I CONVRT=0 S IAIVER=$$IAIWALK(IAIIEN) ;IAIVER = 0 when version 0 IAI rec found
 . . . S:(IAIVER=0) MTVER=0
 . ;
 . ;Review Dependent IAI records
 . I RECTYP="D" DO
 . . N DEPNUM
 . . S DEPNUM=""
 . . ;QUIT 'D' IEN loop when all have been reviewed or related 408.31
 . . ; record has a version in 2.11
 . . F  S DEPNUM=$O(DGINC("D",DEPNUM))  Q:DEPNUM=""  Q:CONVRT=1  Q:IAIVER=0  DO
 . . . S IAIIEN=DGINC("D",DEPNUM)
 . . . ;Check 2.11 on related MT record in 408.31
 . . . ; (CONVRT=-1 : conversion check not yet completed)
 . . . ; MTRECVER will return a value of 0 or 1 for CONVRT
 . . . D:(+CONVRT=-1) MTRECVER(IAIIEN,.FORM,.CONVRT) ;Assume all IAI rec's have #31 or don't
 . . . S:(CONVRT=1) MTVER=FORM ;if 408.31 rec has a version, set MTVER and Quit with that value
 . . . I CONVRT=0 S IAIVER=$$IAIWALK(IAIIEN) ;IAIVER = 0 when version 0 IAI record is found
 . . . S:(IAIVER=0) MTVER=0
 Q MTVER
 ;
MTRECVER(IAI,VER211,CONVRT) ;* Return the version indicated in 408.31 Means Test Version field (2.11)
 ; Input:  IAI - Individual Annual Income entry IEN
 ;
 ; Output (passed by reference):
 ;    VER211: 1 - version 1 1010EZ form Feb, 2005
 ;            0 - version 0 1010EZ form pre Feb, 2005
 ;         NULL - version not indicated on 408.31
 ;
 ;    CONVRT: 0 - Means Test Version field (2.11) is not defined
 ;            1 - Means Test Version field is defined with a value (0 or 1)
 ;
 S CONVRT=0
 S VER211=$P($G(^DGMT(408.31,+$G(^DGMT(408.21,IAI,"MT")),2)),"^",11)
 S:(VER211'["") CONVRT=1
 S VER211=+VER211
 Q
 ;
IAIWALK(IAI) ;* Return the version per findings in 408.21 record
 ; Input:  IAI - Individual Annual Income entry IEN
 ; Returned value:
 ;            0 - Record contains data defined for version 0 (pre Feb, 2005)
 ;                  Form (pce's 9-13, 15, 16)
 ;            1 - Record contains data defined for version 1 (Feb, 2005) Form
 ;
 N RECVER,IAIREC,NULLVAL,PCE
 S NULLVAL=""
 S PCE=""
 S RECVER=1
 S IAIREC=$G(^DGMT(408.21,IAI,0))
 F PCE=9:1:13,15,16 I $P(IAIREC,"^",PCE)'=NULLVAL S RECVER=0
 Q RECVER
