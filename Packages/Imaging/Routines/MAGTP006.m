MAGTP006 ;WOIFO/FG,JSL - TELEPATHOLOGY TAGS ; 25 Jul 2013 5:07pm
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
 Q  ;
 ;
 ;+++++ SET CONTEXT
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; LRSS          AP Section
 ;
 ; YEAR          Accession Year (Two figures)
 ;
 ; LRAN          Accession Number
 ;
 ; Return Values
 ; =============
 ;
 ; If MAGRY(0) 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure: 0^0^ ERROR explanation
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 1
 ;                ^02: 0
 ;
 ; "LRSF,LRI,LRDFN,"     if successful
 ; ""                    if error
 ;
 ; Where:
 ;
 ; LRSF          Subfield Number in LAB DATA file (#63)
 ;
 ; LRI           Reverse Date entry in LAB DATA file (#63)
 ;
 ; LRDFN         DFN from LAB DATA file (#63) for a patient
 ;
CONTEXT(MAGRY,LRSS,YEAR,LRAN) ;
 K MAGRY
 N LRX,LRSF,LRDFN,LRI,IEN,LRAA,LRYR
 I '$D(LRSS) S MAGRY(0)="0^0^Missing AP Section" Q ""
 I '$D(YEAR) S MAGRY(0)="0^0^Missing Year" Q ""
 I '$D(LRAN) S MAGRY(0)="0^0^Missing Accession Number" Q ""
 ; Only these three AP Sections considered
 S LRSF=$S(LRSS="CY":63.09,LRSS="EM":63.02,LRSS="SP":63.08,1:"")
 I LRSF="" S MAGRY(0)="0^0^Invalid AP Section" Q ""
 S LRAA=$O(^LRO(68,"B",LRSS,0))
 I LRAA="" S MAGRY(0)="0^0^Accession Area Not Found" Q ""
 ; Find year in index
 S LRYR=YEAR_"0000"
 S LRYR=$S($D(^LRO(68,LRAA,1,2E6+LRYR)):2E6+LRYR,$D(^LRO(68,LRAA,1,3E6+LRYR)):3E6+LRYR,1:"")
 I LRYR="" S MAGRY(0)="0^0^Invalid Year" Q ""
 I +LRAN=0 S MAGRY(0)="0^0^Invalid Accession Number" Q ""
 D  Q:$D(MAGRY(0)) "" ; look up by accession number; crawl if necessary
 . N ACCID
 . S ACCID=LRSS_" "_YEAR_" "_LRAN
 . I $D(^LRO(68,LRAA,1,LRYR,1,LRAN)),$P($G(^(LRAN,.2)),"^",1)=ACCID Q  ; found
 . D  ; try to crawl, redefine LRAN (accession serial IEN)
 . . S LRAN=0 F  S LRAN=$O(^LRO(68,LRAA,1,LRYR,1,LRAN)) Q:'LRAN  I $P($G(^(LRAN,.2)),"^",1)=ACCID Q
 . . S:LRAN="" MAGRY(0)="0^0^Accession Record Not Found"
 . . Q
 . Q
 S LRDFN=$P($G(^LRO(68,LRAA,1,LRYR,1,LRAN,0)),"^",1)
 I LRDFN="" S MAGRY(0)="0^0^LAB DATA Patient Index Not Found" Q ""
 I '$D(^LR(LRDFN)) S MAGRY(0)="0^0^LAB DATA Patient Record Not Found" Q ""
 S LRI=$P($G(^LRO(68,LRAA,1,LRYR,1,LRAN,3)),"^",5)
 I LRI="" S MAGRY(0)="0^0^LAB DATA Order Index Not Found" Q ""
 I '$D(^LR(LRDFN,LRSS,LRI)) S MAGRY(0)="0^0^LAB DATA Order Record Not Found" Q ""
 S IEN=LRI_","_LRDFN_","
 S MAGRY(0)="1^0"
 Q LRSF_","_IEN
