SDAMA304 ;BPOIFO/ACS-Filter API Apply Filters ; 6/21/05 1:50pm
 ;;5.3;Scheduling;**301,347,508**;13 Aug 1993
 ;PER VHA DIRECTIVE 2004-038, DO NOT MODIFY THIS ROUTINE
 ;
 ;*****************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -----------------------------------------
 ;12/04/03  SD*5.3*301    ROUTINE COMPLETED
 ;08/06/04  SD*5.3*347    ADDITION OF A NEW FILTER - DATE APPOINTMENT
 ;                        MADE (FIELD #16) AND 2 NEW FIELDS TO RETURN:
 ;                        1) AUTO-REBOOKED APPT DATE/TIME (FIELD #24)
 ;                        2) NO-SHOW/CANCEL APPT DATE/TIME (FIELD #25)
 ;02/22/07  SD*5.3*508    SEE SDAMA301 FOR CHANGE LIST
 ;*****************************************************************
 ;
 ;*****************************************************************
 ;
 ;                  APPLY FILTERS (Extrinsic call)
 ;
 ;INPUT
 ;  SDFTYPE    Filter Type (P-patient or C-clinic)
 ;  SDARRAY    Appointment Filter array
 ;  SDFLTR     Filter Flags array
 ;  SDDV       Appointment Data Values array
 ;  
 ;OUTPUT
 ;  SDMATCH   -1 if no match
 ;             1 if match
 ;*****************************************************************
MATCH(SDFTYPE,SDARRAY,SDFLTR,SDDV) ;
 N SDMATCH,SDX,SDCLIEN
 S SDMATCH=0
 ;apply patient or clinic filters
 I SDFTYPE="P" D PMATCH(.SDARRAY,.SDMATCH)
 I SDFTYPE="C" D CMATCH(.SDARRAY,.SDMATCH)
 Q SDMATCH
PMATCH(SDARRAY,SDMATCH) ;Apply ^DPT-related filters
 S SDMATCH=1
 ;Clinic
 I SDFLTR(2) D
 . S SDDV(2)=$P($G(SDARRAY("DPT0")),"^",1)
 . I SDDV(2)']"" S SDMATCH=0 Q
 . ;apply filter to list or global
 . I SDARRAY("CLNGBL")=1 D
 .. S SDX=SDARRAY(2),SDCLIEN=SDDV(2)
 .. I '$D(@(SDX_"SDCLIEN)")) S SDMATCH=0
 . I SDARRAY("CLNGBL")=0 D
 .. I ((";"_$G(SDARRAY(2))_";")'[(";"_SDDV(2)_";")) S SDMATCH=0
 Q:'SDMATCH
 ;Appointment Status
 I SDFLTR(3) D
 . N SDSTAT,SDTEMP
 . S SDTEMP=$P($G(SDARRAY("DPT0")),"^",2)
 . S SDSTAT=$S($G(SDTEMP)="":"R",SDTEMP="I":"I",SDTEMP="C":"CC",1:"X")
 . I SDSTAT="X" S SDSTAT=$S(SDTEMP="CA":"CCR",SDTEMP="PC":"CP",1:"X")
 . I SDSTAT="X" S SDSTAT=$S(SDTEMP="PCA":"CPR",SDTEMP="N":"NS",1:"X")
 . I SDSTAT="X" S SDSTAT=$S(SDTEMP="NA":"NSR",SDTEMP="NT":"NT",1:"X")
 . S SDDV(3)=SDSTAT
 . I ((";"_$G(SDARRAY(3))_";")'[(";"_SDDV(3)_";")) S SDMATCH=0
 Q:'SDMATCH
 ;Encounter Exists (DEPRECATED 11/10/06 JFW)
 ;I SDFLTR(12) D
 ;.;get appointment encounter information
 ;.S SDDV(12)=$P($G(SDARRAY("DPT0")),"^",20)
 ;.;compare encounter information to filter value
 ;.;      Y AND NULL match or N and NOT NULL match
 ;.I (((SDARRAY("ENCTR")["Y")&(SDDV(12)']""))!((SDARRAY("ENCTR")["N")&(SDDV(12)]""))) D
 ;..S SDMATCH=0
 ;Date Appointment Made
 I SDFLTR(16) D
 .;get date appointment made from specific appt
 .S SDDV(16)=$P($G(SDARRAY("DPT0")),"^",19)
 .;compare date with range of dates specified
 .I $S(+SDDV(16)=SDARRAY("DAMFR"):0,+SDDV(16)=SDARRAY("DAMTO"):0,1:1) D
 ..I ((+SDDV(16)'>SDARRAY("DAMFR"))!(+SDDV(16)'<SDARRAY("DAMTO"))) D
 ...S SDMATCH=0
 Q
 ;       
CMATCH(SDARRAY,SDMATCH) ;Apply ^SC-related filters
 N SDAMCLIN,SDSTOP
 S SDMATCH=1
 ;Primary Stop Code
 I SDFLTR(13) D
 . S SDAMCLIN=+$G(SDARRAY("DPT0"))
 . I $G(SDAMCLIN)="" S SDMATCH=0 Q
 . S SDSTOP=$P($G(^SC(SDAMCLIN,0)),"^",7)
 . I $G(SDSTOP)="" S SDMATCH=0 Q
 . S SDDV(13)=$P($G(^DIC(40.7,SDSTOP,0)),"^",2)
 . I $G(SDDV(13))="" S SDMATCH=0 Q
 . I ((";"_$G(SDARRAY(13))_";")'[(";"_SDDV(13)_";")) S SDMATCH=0
 Q
