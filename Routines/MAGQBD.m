MAGQBD ;WOIFO/PMK/RMP - Arbitrary file deletion ; 18 Jan 2011 4:18 PM
 ;;3.0;IMAGING;**20,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
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
ENTRY(RESULT,QPTR) ; entry point from MAGQBTM
 N FILE,X,IEN,FN,ARCH,NODE,PLACE,GB,CJB,CJBP
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2))),(GB,ARCH)=""
 S U="^",X=^MAGQUEUE(2006.03,QPTR,0)
 S FILE=$P(X,"^",10)
 S FN=$P(FILE,"\",$L(FILE,"\"))
 S IEN=$O(^MAG(2005.1,"F",$P(FN,"."),""))
 I 'IEN S RESULT="-1"_U_QPTR_U_"No 2005.1 Entry established for Image file: "_$P(FN,".")_U_U Q
 S NODE=$G(^MAG(2005.1,IEN,0))
 I $P(FILE,".",2)'["BIG" S ARCH=$S($P(NODE,U,5):$P(NODE,U,5),1:"")
 E  S ARCH=$S($P($G(^MAG(2005.1,IEN,"FBIG")),U,2):$P($G(^MAG(2005.1,IEN,"FBIG")),U,2),1:"")
 S CJB=$$JBPTR^MAGBAPI($$PLACE^MAGBAPI(+$G(DUZ(2))))
 S CJBP=$$UPPER^MAGQE4($P($G(^MAG(2005.2,CJB,0)),U,2)_$$DIRHASH^MAGFILEB(FN,CJB))
 S GB=$S(ARCH:$$UPPER^MAGQE4($P($G(^MAG(2005.2,ARCH,0)),U,2)_$$DIRHASH^MAGFILEB(FN,ARCH)),1:"")
 I ($L(GB)<1)&($L(CJBP)<1) S RESULT="-1"_U_QPTR_U_"No Archive Global established for entry: "_IEN_U_QPTR_U_U
 E  S RESULT="1"_U_FILE_U_QPTR_U_+$P(X,U,9)_U_GB_U_IEN_U_ARCH_U_CJB_U_CJBP
 Q
