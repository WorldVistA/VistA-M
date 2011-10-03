PRCAMESG ;SF-ISC/YJK-AR PROGRAM MESSAGES ;4/24/92  8:50 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;LIST OF THE MESSAGES USED IN THE AR PROGRAM.
M1 W !,"Answer 'Y' or 'YES' if the data displayed above is correct,",!
 W "answer 'N' or 'NO' if not correct.",! Q
M2 W !,"Answer 'Y' or 'YES' if you want to edit the data,"
 W !,"answer 'N' or 'NO' if you don't want to.",! Q
YN W !,"Answer 'Y' (YES) or 'N' (NO).",! Q
