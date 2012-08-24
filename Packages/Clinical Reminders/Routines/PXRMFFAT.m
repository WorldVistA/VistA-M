PXRMFFAT ;SLC/PKR - Function Finding argument type routines. ;05/02/2011
 ;;2.0;CLINICAL REMINDERS;**4,6,18**;Feb 04, 2005;Build 152
 ;
 ;============================================
ARGTYPE(FUNCTION,AN) ;Given a FUNCTION and argument number return the
 ;corresponding argument type. Possible argument types are:
 ; F - finding
 ; N - number
 ; S - string
 ; U - undefined
 N ROUTINE
 ;The routine for any function is determined by first removing
 ;the "_" character from the function name and then taking the
 ;first 8 characters. The first 8 character of a function must
 ;be unique.
 S ROUTINE="$$"_$E($TR(FUNCTION,"_",""),1,8)_"(AN)"
 Q @ROUTINE
 ;
 ;============================================
COUNT(AN) ;
 Q $S(AN=1:"F",1:"U")
 ;
 ;===========================================
DIFFDATE(AN) ;
 Q $S(AN=1:"F",AN=2:"F",AN=3:"S",1:"U")
 ;
 ;===========================================
DTIMEDIF(AN) ;
 Q $S(AN=1:"F",AN=2:"N",AN=3:"S",AN=4:"F",AN=5:"N",AN=6:"S",AN=7:"S",AN=8:"S",1:"U")
 ;
 ;===========================================
DUR(AN) ;
 Q $S(AN=1:"F",1:"U")
 ;
 ;============================================
FI(AN) ;
 Q $S(AN=1:"F",1:"U")
 ;
 ;============================================
MAXDATE(AN) ;
 I AN>0,AN<100 Q "F"
 E  Q "U"
 ;
 ;============================================
MAXVALUE(AN) ;
 Q $S(AN#2=1:"F",AN#2=0:"S",1:"U")
 ;
 ;============================================
MINDATE(AN) ;
 I AN>0,AN<100 Q "F"
 E  Q "U"
 ;
 ;============================================
MINVALUE(AN) ;
 Q $S(AN#2=1:"F",AN#2=0:"S",1:"U")
 ;
 ;============================================
MRD(AN) ;
 I AN>0,AN<100 Q "F"
 E  Q "U"
 ;
 ;============================================
NUMERIC(AN) ;
 Q $S(AN=1:"F",AN=2:"N",AN=3:"S",1:"U")
 ;
 ;============================================
VALUE(AN) ;
 Q $S(AN=1:"F",AN=2:"N",AN=3:"S",1:"U")
 ;
