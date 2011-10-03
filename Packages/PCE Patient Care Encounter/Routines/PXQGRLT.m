PXQGRLT ;ISL/PKR - MAXIUM EVALUATED LENGTH OF GLOBAL REFERENCE;8/29/96  10:32
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**4**;Aug 12, 1996
 ;
 N BL,I,I1
 S BL=$L($J)+7
 W !,"Determine the maximum global reference length"
 S I1=""
 F I=1:1:300 D
 . S I1=I1_"A"
 . W !,"The length of I1 is ",I,", total length is ",I+BL
 . S ^TMP($J,I1)=I
 . K ^TMP($J,I1)
 Q
