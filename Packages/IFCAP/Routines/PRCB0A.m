PRCB0A ;WISC/PLT-Help Execution Utility ;7/24/00  23:24
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
HE(X) ;Help Execution
 N A,B
 F A=0:1 S @("B=$P($T("_X_"+A),"";"",3,999)") Q:B=""  D EN^DDIOL(B)
 D EN^DDIOL(" ")
 QUIT
 ;
BBFY ;;This is the beginning year of a Fund.  For example, If the Fund is a
 ;;multi-year fund, good from 1992-1994, the beginning year would be
 ;;1992. If the Fund is a single year Fund, good for 1992 only, the
 ;;beginning year would be 1992.
 ;
