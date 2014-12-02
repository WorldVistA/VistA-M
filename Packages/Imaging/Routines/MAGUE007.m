MAGUE007 ;WOIFO/MLH - database encapsulation - sensitive/employee patient lookup ; 13-Mar-2013 04:03 pm
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ;
 ; +++++ RETURN SENSITIVE/EMPLOYEE FLAG FOR A PATIENT
 ; 
 ; MAGDFN        Patient's internal entry number on PATIENT File (#2)
 ; 
 ; RETURN VALUES
 ; =============
 ; 
 ; MAGRY(0)      One of the following values:
 ;                 -4^^DFN parameter missing or empty
 ;                 -3^^DFN not numeric
 ;                 -2^^DFN not found on PATIENT File
 ;                 -1^^ERROR [MUMPS error]
 ;                 0^^Not employee, not sensitive
 ;                 1^^Employee, not sensitive
 ;                 2^^Not employee, sensitive
 ;                 3^^Employee, sensitive
 ; 
EMPSENS(MAGRY,MAGDFN) ;
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGUTERR"
 N SENSFLAG ; sum of values returned from utility calls
 I $G(MAGDFN)="" D  Q
 . S MAGRY(0)="-4^^DFN parameter missing or empty"
 . Q
 I MAGDFN'?.N D  Q
 . S MAGRY(0)="-3^^DFN not numeric"
 . Q
 I '$D(^DPT(MAGDFN)) D  Q  ; ICR ???
 . S MAGRY(0)="-2^^DFN not found on PATIENT File"
 . Q
 S:$$EMPL^DGSEC4(MAGDFN)=1 SENSFLAG=$G(SENSFLAG)_"E" ; ICR #3646
 S:$P($G(^DGSL(38.1,MAGDFN,0)),"^",2)=1 SENSFLAG=$G(SENSFLAG)_"S" ; ICR #767
 I $G(SENSFLAG)="" S MAGRY(0)="0^^Not employee, not sensitive" Q
 I SENSFLAG="E" S MAGRY(0)="1^^Employee, not sensitive" Q
 I SENSFLAG="S" S MAGRY(0)="2^^Not employee, sensitive" Q
 I SENSFLAG="ES" S MAGRY(0)="3^^Employee, sensitive" Q
 Q
