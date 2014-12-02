MAGVD004 ;WOIFO/BT,NST,MLH - Delete Study By Accession Number - display outputs; [ 02/03/2012 10:50 ]
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
SHOWINFO(ACCNUM,MAGARR) ; show patient name, procedures, studies, series, #of images/series
 N MAGARRIX,MAGARRKT
 D EN^DDIOL("Information on Study(ies) to be deleted for accession number "_ACCNUM_":","","!!")
 D EN^DDIOL("------------------------------------------------------------------------","","!")
 S MAGARRIX=0 F MAGARRKT=0:1 S MAGARRIX=$O(MAGARR(MAGARRIX)) Q:'MAGARRIX
 S MAGARRIX=0
 F  S MAGARRIX=$O(MAGARR(MAGARRIX)) Q:'MAGARRIX  D
 . N DFN,VADM,STYSERKT,I
 . D:MAGARRKT>1 EN^DDIOL("GROUP "_MAGARRIX_":","","!!")
 . S DFN=$G(MAGARR(MAGARRIX,"MAGDFN")) D DEM^VADPT
 . D EN^DDIOL("PATIENT: "_$G(VADM(1)),"","!")
 . D EN^DDIOL(" SSN: "_$P($G(VADM(2)),"^",2),"","?30")
 . D EN^DDIOL(" DOB: "_$P($G(VADM(3)),"^",2),"","?55")
 . D EN^DDIOL("PROCEDURE: "_$G(MAGARR(MAGARRIX,"PROC")),"","!")
 . D STYSERKT^MAGVD010(.STYSERKT,$NA(MAGARR(MAGARRIX,"IMAGES"))) ; count studies & series
 . D EN^DDIOL("STUDIES: "_$G(STYSERKT("STUDY")))
 . D EN^DDIOL(" SERIES: "_$G(STYSERKT("SERIES")),"","?15")
 . D EN^DDIOL(" IMAGES: "_$G(STYSERKT("IMAGE")),"","?30")
 . Q
 Q
