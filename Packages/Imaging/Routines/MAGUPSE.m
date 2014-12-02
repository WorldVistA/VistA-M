MAGUPSE ;WOIFO/MLH - Imaging utility - return pt employee/sensitive status;  3 Feb 2012 06:00 AM
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
 ;
SENSEMP(MAGDFN) ;FUNCTION - return pt employee/sensitive status
 ;input:  MAGDFN       pt's internal entry no. on PATIENT File (#2)
 ;function return:     -1  if DFN is not a positive integer
 ;                      0  if patient not employee or sensitive, or patient not found
 ;                      1  if patient is employee
 ;                      2  if patient is sensitive
 ;                      3  if patient is both employee and sensitive
 N SENSEMP
 I (MAGDFN'>0)!(MAGDFN'?1.N) Q -2 ; improper format
 S SENSEMP=0 ; assume neither employee nor sensitive
 S SENSEMP=SENSEMP+($$EMPL^DGSEC4(MAGDFN)=1) ; employee (ICR #3646)
 S SENSEMP=SENSEMP+(2*($P($G(^DGSL(38.1,MAGDFN,0)),"^",2)=1)) ; sensitive (IA #767)
 Q SENSEMP
