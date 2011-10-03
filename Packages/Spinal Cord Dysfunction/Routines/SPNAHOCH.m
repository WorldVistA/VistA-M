SPNAHOCH ;HISC/DAD-AD HOC REPORTS: HELP TEXT ;9/9/96  09:27
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
EN(SPNLABEL) ; *** Print the help text
 N SP,X Q:$T(@SPNLABEL)=""
 F SP=1:1 S X=$P($T(@SPNLABEL+SP),";;",2,99) Q:X=U  W !,X
 Q
H1 ;; *** Sort help
 ;;Macro functions:          [L  Load sort macro        [S  Save sort macro
 ;;   [O  Output macro       [I  Inquire sort macro     [D  Delete sort macro
 ;;
 ;;Sort prefixes:   (e.g. enter +1 to turn on totaling for field 1)
 ;;   +  Totalled fields      -  Reverse sort order      !  Sequence/ranking number
 ;;   #  New page on sort     @  Suppress sub-header     '  Range without sorting
 ;;
 ;;Sort suffixes:   (e.g. enter 1;C5 to print the field 1 sub-header at column 5)
 ;;   ;Cn  -  Start the sub-header         ;Ln    -  Use the first n characters of
 ;;           caption at column n                    a field value for sorting
 ;;   ;Sn  -  Skip n lines every time the  ;"xxx" -  Use xxx as the sub-header
 ;;           sort field value changes               caption, for no caption ;""
 ;;   ;TXT -  Force digits to be sorted
 ;;           as strings not as numbers 
 ;;^
H2 ;; *** Print help
 ;;Macro functions:        [L  Load print macro         [S  Save print macro
 ;;   [O  Output macro     [I  Inquire print macro      [D  Delete print macro
 ;;
 ;;Print prefixes:   (e.g. enter !1 to turn on counting for field 1)
 ;;   &  Total              !  Count                     +  Total, Count & Mean
 ;;   #  Total, Count, Mean, Maximum, Minimum, and Standard Deviation
 ;;
 ;;Print suffixes:   (e.g. enter 1;C5 to print the field 1 value at column 5)
 ;;   ;Cn  -  Start output at column n       ;Yn    -  Start output at line n
 ;;           Use ;C-n to start output n               Use ;Y-n to start output n
 ;;           columns from the right margin            lines from the bottom margin
 ;;   ;Ln  -  Left justify data in an        ;Rn    -  Right justify data in an
 ;;           output field of n characters             output field of n characters
 ;;           Will truncate the output                 Will not truncate the output
 ;;   ;Wn  -  Wrap output in a field of n    ;X     -  Omit spaces between print
 ;;           characters, breaks at word               fields and suppress the
 ;;           divisions, default wrap ;W               column header
 ;;   ;Sn  -  Skip n lines before printing   ;Dn    -  Output numeric value with n
 ;;           Use ;S to skip one line                  decimal places (rounds off)
 ;;   ;N   -  Do not print duplicated data   ;T     -  Use field Title as header
 ;;   ;""  -  Suppress column header         ;"xxx" -  Use xxx as column header 
 ;;^
H3 ;; *** Beginning sort help
 ;;
 ;;       Enter the beginning sort value or press <RETURN> to start with BEGINNING.
 ;;^
H4 ;; *** Ending sort help
 ;;
 ;;       Enter the ending sort value or press <RETURN> to stop with ENDING.
 ;;^
H5 ;; *** Report header help
 ;;        Enter header (60 characters maximum), press <RETURN>
 ;;        for standard VA FileMan header, ^ to exit.
 ;;^
H6 ;; *** Routine name
 ;;
 ;;     Enter the name of a MUMPS routine that will be used
 ;;     by the Ad Hoc Report Generator.  The routine name must
 ;;     start with an uppercase letter and may continue with
 ;;     numbers and uppercase letters.  The routine name must
 ;;     be from 2 to 8 characters in length.
 ;;^
H7 ;; *** Field name
 ;;
 ;;     Enter the menu text that will appear on the Ad Hoc
 ;;     sort/print menus.  Must be 2 to 30 characters.
 ;;^
H8 ;; *** No records to print message help
 ;;
 ;;     If no data is found that meets the user's sort criteria a
 ;;     'NO RECORDS TO PRINT' message will automatically be produced.
 ;;     Answer 'NO' to this question to suppress this message.
 ;;^
H9 ;; *** Menu header help
 ;;
 ;;     Enter the text you want displayed at the top of the sort
 ;;     and print menu screens.  The header will be 'Text' followed
 ;;     by 'Ad Hoc Report Generator'.  The header text is optional
 ;;     and may be null.  To suppress the header altogether enter '@'.
 ;;     The header text must be from 0 to 45 characters in length.
 ;;^
H10 ;; *** Check/update macro checksum help
 ;;
 ;;     Enter 'YES' to change the checksum for this macro.
 ;;     Enter 'NO' to leave the checksum for this macro as is.
 ;;     Enter 'ALL' to change the checksum for all macros.
 ;;     Enter '^' to exit.
 ;;^
H11 ;; *** Sort criteria in header
 ;;
 ;;     Answer 'YES' to include the sort criteria
 ;;     in the report header, otherwise answer 'NO'.
 ;;^
H12 ;; *** Sort from/to look-up screen
 ;;
 ;;     Enter MUMPS code that contains an IF statement.  After execution,
 ;;     if $T is set to 1 the entry is selectable, otherwise it is not.
 ;;     For pointers, the naked indicator will equal the zero node of
 ;;     the entry being screened.  The variable Y represents the record
 ;;     number for pointers, and the internal code for sets of codes.
 ;;^
