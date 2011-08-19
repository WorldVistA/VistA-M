RORXU004 ;HCIOFO/SG - REPORT UTILITIES (STATISTICS) ; 9/23/03 10:51am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** CALCULATES THE MEDIAN VALUE OF THE CROSS-REFERENCE
 ;
 ; XREFNODE      Root node of the old-style cross-reference
 ; NUM           Total number of elements in the array
 ;
 ; Return Values:
 ;       ""  Error (or an empty array)
 ;     '=""  Median Value
 ;
XREFMDNV(XREFNODE,NUM) ;
 Q:NUM'>0 ""
 N FLT,FLTL,I,MV,N,PI,VPOS
 S FLTL=$L(XREFNODE)-1,FLT=$E(XREFNODE,1,FLTL)
 S N=(NUM+1)\2,VPOS=$QL(XREFNODE)+1
 ;--- Find the median value
 S PI=XREFNODE
 F I=1:1:N  S PI=$Q(@PI)  Q:$E(PI,1,FLTL)'=FLT
 Q:$E(PI,1,FLTL)'=FLT ""
 ;--- Calculate median value if NUM is even
 S MV=$QS(PI,VPOS)
 I '(NUM#2)  D  Q:I="" ""  S MV=(MV+I)/2
 . S PI=$Q(@PI),I=$S($E(PI,1,FLTL)=FLT:$QS(PI,VPOS),1:"")
 Q MV
