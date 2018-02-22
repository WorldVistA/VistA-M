XVEMDH5 ;DJB/VEDD**Help Text - Field Global Location [11/05/94];2017-08-15  12:07 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
VEDD2 ;;;
 ;;;
 ;;;    G         Goto a REF number. Select a REF number from the left hand
 ;;;              column, and that field will be positioned at the top of the
 ;;;              display. If you select a REF number that has not yet been
 ;;;              displayed, the last field viewed will be positioned at the top
 ;;;              of the display. G 1 to return to the beginning display.
 ;;;
 ;;; <HOME>       Returns you to beginning dislay. Since your terminal emulation
 ;;;              software may use the <HOME> key for other purposes, you may
 ;;;              type the word HOME for the same effect.
 ;;;
 ;;; <END>        Returns you to the highest field that's been displayed. You
 ;;;              may type the word END for the same effect.
 ;;;
 ;;;    N         Allows you to do a look up by global node. At the 'Select
 ;;;              NODE:' prompt type '?' to see all nodes, or enter node. If
 ;;;              that node is a multiple you will be asked for subnode. You
 ;;;              will then get a list of all fields that are contained by
 ;;;              that node. You may then do an 'Individual Field Summary' on
 ;;;              any field listed.
 ;;;              Example: If you wanted to know what fields are contained
 ;;;                         in ^DPT(34,"DA",3,"T",0) you would enter '^DPT' at
 ;;;                         the 'Select FILE:' prompt, select option 7, enter
 ;;;                         'N' for node, and then enter the following:
 ;;;                              Select NODE: 'DA'
 ;;;                              Select 'DA' SUBNODE: 'T'
 ;;;                              Select 'T' SUBNODE: '0'
 ;;;                         VEDD will now display all the fields contained in
 ;;;                         the selected node and allow you to do an 'Individual
 ;;;                         Field Summary'.
 ;;;
 ;;;    P         Allows you to branch off to a pointed-to file. P will prompt
 ;;;              you for a REF number from the left hand column. If the
 ;;;              field you select is a pointer field, the display will branch
 ;;;              to that file. Pointer fields are marked with "<-Pntr".
 ;;;
 ;;;   VGL        Victory Global Lister
 ;;;***
