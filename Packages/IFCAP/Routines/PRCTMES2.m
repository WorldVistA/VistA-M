PRCTMES2 ;WISC@ALTOONA/RGY-MESSAGE TEXT ;3-7-91/17:48
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
S ;
 W ! F PRCTHLP=1:1 S PRCTHLP1=$P($T(@MES+PRCTHLP),";",3) Q:PRCTHLP1=""  W !,PRCTHLP1
 W ! K MES,PRCTHLP1,PRCTHLP Q
 ;
SP S MES="SP" G S
 ;;Since you have associated a file for this label, you must specify if
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
