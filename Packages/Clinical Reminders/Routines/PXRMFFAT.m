PXRMFFAT ;SLC/PKR - Function Finding argument type routines. ;09/11/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;============================================
ARGTYPE(FUNCTION,AN) ;Given a FUNCTION and argument number return the
 ;corresponding argument type. Possible argument types are:
 ; F - finding
 ; N - number
 ; S - string
 ; U - undefined
 N ROUTINE
 ;The routine for any function is the same as the name of the
 ;function except for functions with "_" in the name. In that
 ;case the "_" is removed.
 S ROUTINE="$$"_$TR(FUNCTION,"_","")_"(AN)"
 Q @ROUTINE
 ;
 ;============================================
COUNT(AN) ;
 Q $S(AN=1:"F",1:"U")
 ;
 ;===========================================
DIFFDATE(AN) ;
 Q $S(AN=1:"F",AN=2:"F",1:"U")
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
MINDATE(AN) ;
 I AN>0,AN<100 Q "F"
 E  Q "U"
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
