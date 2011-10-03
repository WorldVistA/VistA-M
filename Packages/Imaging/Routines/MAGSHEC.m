MAGSHEC ;WOIFO/JSL - IMAGING UTILITY PROGRAM ; 11 June 2010 1:33 PM
 ;;3.0;IMAGING;**98**;Mar 19, 2002;Build 1849;Sep 22, 2010
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
DTRANGE(OUT,IN,LMT) ;RPC - MAG UTIL DT2IEN
 ;; Using DATE to find first close MAG(2005 IEN
 ;; OUT : result - code,message
 ;; IN : Input DATE range to begin with
 ;; LMT : 0:=limit one year, 1:NONE, 2:EndDate
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 N DAY,DT0,IEN,YR,X,Y,FW
 S OUT(1)="0"
 I $G(IN)="" S OUT(1)="-1,? Enter any Date, e.g.: Jan 1 2008 or 1/1/08" Q
 S X=IN D ^%DT S DT0=Y I DT0<0 S OUT(1)="-1,Invalid date or date format entered" Q
 I DT0>$$NOW^XLFDT S OUT(1)="-1,No future date" Q
 I $G(LMT)=2 I ($$NOW^XLFDT-DT0)<1 S OUT(1)="-1,images from today`s date will not be copied" Q  ;no today image
 I '$G(LMT) D  Q:OUT(1)["-1"
 . S YR=($$NOW^XLFDT()-10000\10000),X=YR_"0101"  ;HEC only accepts up to last FY Jan 01
 . ;S X=$$NOW^XLFDT()-10000\1 ;one year old
 . I DT0<X S OUT(1)="-1,Cannot request HEC 10-10 forms prior to Jan 1 of previous calendar year." Q
 . Q
 S IEN=$O(^MAG(2005,"AD",Y,0)) S:$G(LMT)=2 IEN=$O(^MAG(2005,"AD",Y," "),-1) ;EndDate get last IEN
 I 'IEN S DT0=Y,FW=$S('$O(^MAG(2005,"AD",DT0)):-1,$G(LMT)=2:-1,1:1) D  ;no image for the date DT0
 . F DAY=1:1:7 S DT0=$O(^MAG(2005,"AD",DT0),FW) Q:'DT0  D  Q:IEN        ;find near DATE
 . . S IEN=$S($G(LMT)=2:$O(^MAG(2005,"AD",DT0," "),-1),1:$O(^MAG(2005,"AD",DT0,0)))  ;last/1st IEN of DATE
 . Q
 I ((DT0-Y)>39999)!((Y-DT0)>39999) D  ;3 YR possible range
 . S DAY=$O(^MAG(2005,"AD","")) I (Y<DAY) S IEN=$O(^MAG(2005,"AD",DAY,0)) I IEN S Y=DAY Q  ;1st IEN
 . S IEN=0,OUT(1)="-1,No image for the date entered."
 S:IEN OUT(1)=IEN,OUT(2)=$P($$FMTE^XLFDT(Y,5),"@"),OUT(3)=$P($$FMTE^XLFDT(DT0,5),"@") ;MM/DD/YYYY
 Q
 ;
ERR ; ERROR TRAP FOR RPC
 N ERR S ERR=$$EC^%ZOSV
 S OUT(0)="0,ETRAP: "_ERR
 D @^%ZOSF("ERRTN")
 Q
