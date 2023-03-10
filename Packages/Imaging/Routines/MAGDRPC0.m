MAGDRPC0 ;WOIFO/EdM - Convert RPC response to MUMPS ; Mar 19, 2020@14:50:13
 ;;3.0;IMAGING;**11,51,50,49,123,110,231**;Mar 19, 2002;Build 9;Aug 30, 2013
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
 ;
 ; Notice: This routine is on both VistA and the DICOM Gateway
 ;
 Q
 ;
VADPT(IN) N I,N,S,X
 ; The RPC delivered its message in array IN
 ; The output arrays are conform the VADPT API documentation
 K VA,VADM,VAPA,VAIN,VASD,VAICN
 F I=1:1:11 S (VADM(I),VAIN(I),VAPA(I))=""
 S VADM(12)=""
 S I="" F  S I=$O(IN(I)) Q:I=""  D
 . S X=IN(I),N=$P(X,"^",1),S=$P(X,"^",2),X=$P(X,"^",3,$L(X)+2)
 . Q:S=""                         ;P123 avoid null but allow letters or numbers
 . S:N="DEM" @("VADM("_S_")")=X
 . S:N="ADD" @("VAPA("_S_")")=X
 . S:N="INP" @("VAIN("_S_")")=X
 . S:N="SDA" @("VASD("_S_")")=X
 . S:N="ID" @("VA("""_S_""")")=X  ;P123 patient ID
 . S:N="ICN" VAICN=X
 . S:N="Site-DFN" SITEDFN=X
 . Q
 Q
