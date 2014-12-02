MAGVAF04 ;WOIFO/NST - Utilities for RPC calls ; 11 Mar 2010 4:39 PM
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
 ; ++++ Append data from array FROMARR to array TOARR 
 ;      and returns the last node (counter) in TOARR
 ;      e.g FROMARR(1)="Line 3"
 ;       FROMARR(2)="Line 4"
 ;     
 ;       TOARR(1)="Line 1"
 ;      
 ;      Result is
 ;       TOARR(1)="Line 1"
 ;       TOARR(2)="Line 3"
 ;       TOARR(3)="Line 4"
APP2ARR(TOARR,FROMARR) ; Append data from array FROMARR to array TOARR 
 N I,CNT
 S CNT=$O(TOARR(""),-1)
 S I=""
 F  S I=$O(FROMARR(I)) Q:I=""  D
 . S CNT=CNT+1,TOARR(CNT)=FROMARR(I)
 . Q
 Q CNT
 ;
 ; ++++ Returns string with translated special XML characters
 ; 
 ; e.g. IN="< KVALUE="123" />"
 ; 
 ; "&" to "&amp"
 ; "<" to "&lt"
 ; ">" to "&gt"
 ; """ to "&quot" 
 ;  
TRHTML(IN) ; Returns string with translated special XML characters
 N A,I,OUT
 S OUT=""
 F I=1:1:$L(IN) D
 . S A=$A(IN,I)
 . I $C(A)="""" S OUT=OUT_"&quot;" Q
 . I $C(A)="&" S OUT=OUT_"&amp;" Q
 . I $C(A)="<" S OUT=OUT_"&lt;" Q
 . I $C(A)=">" S OUT=OUT_"&gt;" Q
 . I A<31 S OUT=OUT_"&#"_A_";" Q
 . I A>126 S OUT=OUT_"&#"_A_";" Q
 . S OUT=OUT_$C(A)
 . Q
 Q OUT
