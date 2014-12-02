MAGVAG01 ;WOIFO/NST - Utilities for RPC calls ; 13 Feb 2012 4:18 PM
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
 ;*****  Returns all records in RETENTION POLICY file (#2006.914)
 ;       
 ; RPC: MAGVA GET ALL RETPOLS
 ; 
 ; if error found during execution
 ;   MAGRY(0) = Failure status ^ "Error getting the list"
 ; if success
 ;   MAGRY(0)    = Success status ^^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "^" delimited string with all field names in RETENTION POLICY file (#2006.914)
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
GETRP(MAGRY) ; RPC [MAGVA GET ALL RETPOLS]
 D GALLLST^MAGVAF03(.MAGRY,2006.914,"")
 Q
 ;
 ;*****  Returns all records in ARTIFACT DESCRIPTOR file (#2006.915)
 ;       
 ; RPC: MAGVA GET ALL ADS
 ; 
 ; if error found during execution
 ;   MAGRY(0) = "0^Error getting the list"
 ; if success
 ;   MAGRY(0)    = "1^^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "^" delimited string with all field names in ARTIFACT DESCRIPTOR file (#2006.915)
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
GETAD(MAGRY) ; RPC [MAGVA GET ALL ADS]
 D GALLLST^MAGVAF03(.MAGRY,2006.915,"")
 Q
 ;
 ;*****  Returns all records in STORAGE PROVIDER AVAILABILITY file (#2006.924)
 ;       
 ; RPC: MAGVA GET ALL PROVAVAILS
 ; 
 ; if error found during execution
 ;   MAGRY(0) = Failure status ^ "Error getting the list"
 ; if success
 ;   MAGRY(0)    = Success status ^^ #CNT - where #CNT is a number of records returned
 ;   MAGRY(1)    = "^" delimited string with all field names in STORAGE PROVIDER AVAILABILITY file (#2006.924)
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
GETPA(MAGRY) ; RPC [MAGVA GET ALL PROVAVAILS]
 D GALLLST^MAGVAF03(.MAGRY,2006.924,"")
 Q
 ;
 ;*****  Returns all records in STORAGE PROVIDER file (#2006.917)
 ;       
 ; RPC: MAGVA GET ALL PROVIDERS
 ; 
 ; if error found during execution
 ;   MAGRY(0) = Failure status ^ "Error getting the list"
 ; if success
 ;   MAGRY(0)    = Success status^^#CNT - where #CNT is a number of records returned
 ;   MAGRY(1)    = "^" delimited string with all field names in STORAGE PROVIDER file (#2006.917)
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
GETP(MAGRY) ; RPC [MAGVA GET ALL PROVIDERS]
 D GALLLST^MAGVAF03(.MAGRY,2006.917,"")
 Q
 ;
 ;*****  Returns all records in RETENTION POLICY STORAGE PROVIDER MAP file (#2006.923)
 ;       
 ; RPC: MAGVA GET ALL RETPOL PROV MAPS
 ; 
 ; if error found during execution
 ;   MAGRY(0) = Failure status ^ "Error getting the list"
 ; if success
 ;   MAGRY(0)    = Success status ^^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "^" delimited string with all field names in 
 ;                     RETENTION POLICY STORAGE PROVIDER MAP file (#2006.923) 
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
GETRPPM(MAGRY) ; RPC [MAGVA GET ALL RETPOL PROV MAPS]
 D GALLLST^MAGVAF03(.MAGRY,2006.923,"")
 Q
