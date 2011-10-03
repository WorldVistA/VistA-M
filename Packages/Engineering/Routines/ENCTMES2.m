ENCTMES2 ;(WASH ISC)/RGY-Bar Code Label Help Text ;1-11-90
 ;;7.0;ENGINEERING;;Aug 17, 1993
 ;Copy of PRCTMES2 ;DH-WASH ISC
S ;
 W ! F ENCTHLP=1:1 S ENCTHLP1=$P($T(@MES+ENCTHLP),";",3) Q:ENCTHLP1=""  W !,ENCTHLP1
 W ! K MES,ENCTHLP1,ENCTHLP Q
 ;
SP S MES="SP" G S
 ;;Since you have assoicated a file for this label, you must specify if
 ;;you want to SEARCH the file specified before SORTING or you just
 ;;want to SORT from the file.
 ;;
NOFIL S MES="NOFIL" G S
 ;;  Opps, you have defined this parameter as TYPE of FIELD but you have
 ;;  not defined the FILE for this label.  Before you can input an actual
 ;;  FIELD to print you need to define the FILE.
 ;;
COPY S MES="COPY" G S
 ;;Enter the number of copies that you want to print from 1-1000.
 ;;
