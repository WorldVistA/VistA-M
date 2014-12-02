IBCNEHL5 ;DALOI/KML - HL7 Process Incoming RPI Msgs (cont.) ;1-APRIL-2013
 ;;2.0;INTEGRATED BILLING;**497**;21-MAR-94;Build 120
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 Q  ; No direct calls
 ;
GZRF(ERROR,IBSEG,RIEN) ; Process Group level ZRF Reference identification segment (x12 loops 2100C and 2100D)
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N IENSTR,RSUPDT,QUAL,VALUE
 S IENSTR="+1,"_RIEN_","
 S RSUPDT(365.09,IENSTR,.01)=+$O(^IBCN(365,RIEN,9,"B",""),-1)+1  ; node 9 sequence #
 ; Reference id & qualifier
 S QUAL=$P($G(IBSEG(3)),HLCMP),VALUE=$G(IBSEG(4))
 I VALUE'="",QUAL'="" S RSUPDT(365.09,IENSTR,.02)=VALUE,RSUPDT(365.09,IENSTR,.03)=QUAL
 S RSUPDT(365.09,IENSTR,.04)=$G(IBSEG(5)) ; Description
 D CODECHK^IBCNEHLU(.RSUPDT)  ;check for new coded values
 D UPDATE^DIE("E","RSUPDT",,"ERROR")
 Q
 ;
ZMP(ERROR,IBSEG,RIEN) ; Process Military Personnel Information that comes from X12 271 MPI segment of the 2100C and 2100D  loops 
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N IENSTR,RSUPDT,QUAL,VALUE
 S IENSTR=RIEN_","
 S RSUPDT(365,IENSTR,12.01)=$G(IBSEG(3)) ; information status code
 S RSUPDT(365,IENSTR,12.02)=$G(IBSEG(4))  ;employment status code
 S RSUPDT(365,IENSTR,12.03)=$G(IBSEG(5))  ; government service affiliation code
 S RSUPDT(365,IENSTR,12.04)=$G(IBSEG(6))  ; description
 S RSUPDT(365,IENSTR,12.05)=$G(IBSEG(7))  ; Military service rank code
 ;Date time period format qualifier and Date time period
 S QUAL=$P($G(IBSEG(8)),HLCMP),VALUE=$G(IBSEG(9))
 I VALUE'="",QUAL'="" S RSUPDT(365,IENSTR,12.06)=QUAL,RSUPDT(365,IENSTR,12.07)=VALUE
 D CODECHK^IBCNEHLU(.RSUPDT)  ;check for new coded values
 D UPDATE^DIE("E","RSUPDT",,"ERROR")
 Q
 ;
ROL(ERROR,IBSEG,RIEN) ; process group level Provider Information in the X12 271 PRV segment of X12 loops: 2100B, 2100C, 2100D
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N IENSTR,RSUPDT,QUAL,VALUE
 S IENSTR="+1,"_RIEN_","
 S RSUPDT(365.04,IENSTR,.01)=+$O(^IBCN(365,RIEN,10,"B",""),-1)+1  ; node 10 sequence #
 S RSUPDT(365.04,IENSTR,.02)=$P($G(IBSEG(4)),HLCMP)  ; provider code
 S RSUPDT(365.04,IENSTR,.03)=$P($G(IBSEG(5)),HLCMP)   ; reference ID
 D CODECHK^IBCNEHLU(.RSUPDT)  ;check for new coded values
 D UPDATE^DIE("E","RSUPDT",,"ERROR")
 Q
 ;
DG1(ERROR,IBSEG,RIEN) ; process DIAGNOSIS codes in the X12 271 HI segment of X12 loops: 2100C, 2100D
 ;
 ; Input:
 ; IBSEG,RIEN
 ;
 ; Output:
 ; ERROR
 ;
 N IENSTR,RSUPDT,DCODE
 S IENSTR="+1,"_RIEN_","
 S RSUPDT(365.01,IENSTR,.01)=+$O(^IBCN(365,RIEN,11,"B",""),-1)+1  ; node 11 sequence #
 S DCODE=$P($G(IBSEG(4)),HLCMP)
 S RSUPDT(365.01,IENSTR,.02)=$E(DCODE,1,3)_"."_$E(DCODE,4,99)  ; diagnosis code
 S RSUPDT(365.01,IENSTR,.03)=$P($G(IBSEG(4)),HLCMP,3) ; diagnosis code qualifier
 S RSUPDT(365.01,IENSTR,.04)=$S($P($G(IBSEG(16)),HLCMP)=1:"P",1:"S")  ; primary or secondary diagnosis code
 I $D(RSUPDT) D UPDATE^DIE("E","RSUPDT",,"ERROR")
 Q
 ;
