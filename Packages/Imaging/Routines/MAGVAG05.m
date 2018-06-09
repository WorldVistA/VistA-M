MAGVAG05 ;WOIFO/NST - Utilities for RPC calls ; 02 Oct 2017 4:18 PM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 4525;May 01, 2013
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
 ;*****  Returns all records in NETWORK LOCATION file (#2005.2)
 ;       
 ; RPC: MAGVA GET ALL NETWORK LOCATIONS
 ; 
 ; if error found during execution
 ;   MAGRY(0) = Failure status ^ "Error getting the list"
 ; if success
 ;   MAGRY(0)    = Success status ^^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "^" delimited string with all field names in NETWORK LOCATION file (#2005.2)
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
GETNL(MAGRY) ; RPC [MAGVA GET ALL NETWORK LOCATION]
 D GALLLST^MAGVAF03(.MAGRY,2005.2,"")
 Q
