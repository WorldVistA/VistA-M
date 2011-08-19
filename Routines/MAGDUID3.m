MAGDUID3 ;WOIFO/EdM - UID Table Management - Server Part ; 11/09/2007 07:11
 ;;3.0;IMAGING;**54**;03-July-2009;;Build 1424
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
SERVER(OUT,OFFSET,MAX) ; RPC = MAG DICOM GET UID TABLE
 N BEGIN,COUNT,LAST,REF
 S REF=$G(OFFSET) S:$TR(REF,"^")="" REF="^MAGDICOM(2006.539)"
 S BEGIN="^MAGDICOM(2006.539,"
 S LAST="",COUNT=0 F  S REF=$Q(@REF) Q:REF=""  Q:$E(REF,1,$L(BEGIN))'=BEGIN  D  Q:COUNT>MAX
 . S COUNT=COUNT+1,OUT(COUNT)=REF,LAST=REF
 . S COUNT=COUNT+1,OUT(COUNT)=@REF
 . QUIT
 S:$E(REF,1,$L(BEGIN))'=BEGIN COUNT=COUNT+1,OUT(COUNT)="^"
 S OUT(0)=COUNT
 Q
 ;
