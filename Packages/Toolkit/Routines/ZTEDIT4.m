ZTEDIT4 ;SF/RWF - VA EDITOR ? help message ;7/9/90  07:47 ;
 ;;7.3;TOOLKIT;**16,120**;Apr 25, 1995
 K ^%Z("?") S %X=$T(QUES),^%Z("?")=$P(%X," ",2,99),%X=$T(QUESA),^%Z("?A")=$P(%X," ",2,99)
 F %I=1:1 S %X=$T(%+%I),%Y=$P(%X,";;",2,999) S:%X %Z=+%X,%1=1 Q:%X=""  S ^%Z("?",%Z,%1)=%Y,%1=%1+1
 Q
CHECK W !,"Checking ZTEDIT4" S A="I %Y]"""",%Y'=%X W !,""Tag: ?,"",%I,"","",%I1,"" is not the same"""
 S %I1=1,%I="",%X=$P($T(QUES)," ",2,99),%Y=$S($D(^%Z("?")):^("?"),1:"") X A
 F %=1:1 S %Z=$T(%+%) Q:%Z=""  S:%Z %I=+%Z,%I1=1 S %X=$P(%Z,";;",2,99),%Y=$S($D(^%Z("?",%I,%I1)):^(%I1),1:" ") X A S %I1=%I1+1
 Q
QUES S %NX=1 F %X=1,$S(XY]"":2,1:3) F %=0:0 S %=$O(^%Z("?",%X,%)) Q:%=""  W !,^(%)
QUESA S %NX="ACTION" F %=0:0 S %=$O(^%Z("?",99,%)) Q:%=""  W !,^(%)
% ;;
1 ;;.ACTION menu              .BREAK line              .CHANGE every
 ;;.FILE routine             .INSERT after            .JOIN lines
 ;;.MOVE lines               .REMOVE lines            .SEARCH for
 ;;.TERMinal type            .XY change to/from replace-with
 ;;. -TO EXIT THE EDITOR
 ;;""+n Absolute line n    +n To advance n lines   -n To backup n lines
 ;; use '*' to get last line
 ;;
 ;;^NAME - to edit a GLOBAL node             *NAME - to edit a LOCAL variable
 ;;MUMPS command line (mumps command <space> or Z command <space>)
 ;;
2 ;;In the line mode,
 ;;Spacebar moves to the next space or comma. Dot to the next char.
 ;;'>' To move forward 80 char or to end of line.
 ;;Backspace to back up one char. E to enter new char's at the cursor.
 ;;CR to exit enter mode, return to start of line or EDIT prompt.
 ;;D to delete from the cursor to the next space or comma.
 ;;Delete (Rub) to delete the char under the cursor.
 ;;CTRL-R to restore line and start back at the beginning.
 ;; 
3 ;;In the replace/with mode,
 ;;SPECIAL <REPLACE> STRINGS:
 ;;  END    -to add to the END of a line
 ;;  ...    -to replace a line
 ;;  A...B  -to specify a string that begins with "A" and ends with "B"
 ;;  A...   -to specify a string that begins with "A" to the end of the line 
 ;;CTRL-R to restore line.
99 ;;Bytes in routine           Checksum                 Restore lines
 ;;Save lines                 Version #
