QAQAHOCH ;HISC/DAD-AD HOC REPORTS: HELP TEXT [ 10/20/92  7:11 pm ] ;10/28/92  12:43
 ;;1.7;QM Integration Module;;07/25/1995
EN(QAQLABEL) ; *** Print the help text
 N QA,X Q:$T(@QAQLABEL)=""
 F QA=1:1 S X=$P($T(@QAQLABEL+QA),";;",2,99) Q:X="^"  W !,X
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
 ;;     as the interface to the Ad Hoc Report Generator.
 ;;     The routine name must start with an uppercase letter
 ;;     and may continue with numbers and uppercase letters.
 ;;     The routine name must be from 2 to 8 characters in length.
 ;;^
H7 ;; *** Field name 
 ;;
 ;;     Enter the menu text that will appear on the Ad Hoc
 ;;     sort/print menus.  Must be 2 to 30 characters.
 ;;^
H8 ;; *** No data found message help
 ;;
 ;;     No output will occur if there is no data found that meets the
 ;;     user's sort specifications.  Answering Y(es) to this question will
 ;;     produce a "No data found..." message under these circumstances.
 ;;^
H9 ;; *** Menu header help
 ;;
 ;;     Enter the text you want displayed at the top of the sort
 ;;     and print menu screens.  The header will be 'Text' followed
 ;;     by 'Ad Hoc Report Generator'.  The header text is optional
 ;;     and may be null.  To suppress the header altogether enter '@'.
 ;;     The header text must be from 0 to 45 characters in length.
 ;;^
