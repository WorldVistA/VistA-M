%INDX1 ;ISC/REL,GRK,RWF - ERROR ROUTINE ;1/9/95  15:19
 ;;7.3;TOOLKIT;;Apr 25, 1995
A N %,%1
 S ERTX=LAB_$S(LABO:"+"_LABO,1:""),ERTX=$E(ERTX_"           ",1,11),%1=$T(ERROR+ERR),ERTX=ERTX_"  "_$S(ERR:$P(%1,";",4,9),1:ERR)
 I ERTX["|" F %=1:1 S ERTX=$P(ERTX,"|")_$S($D(ERR(%)):ERR(%),1:"??")_$P(ERTX,"|",%+1,99) Q:ERTX'["|"
B I $P(%1,";",3)]"" D  Q:%1]""  ;Don't flag kernel doing kernel.
 . S %1=$P(%1,";",3)
 . F  Q:RTN[$P(%1,",")  S %1=$P(%1,",",2,99) ;quit if RTN[%1 or null.
 . Q
 I ERR=17,$E(RTN)'="%",$E(LAB)="%" Q  ;Don't flag %RTN w/o %.
 S %=$G(^UTILITY($J,1,RTN,"E",0))+1,^(0)=%,^(%)=ERTX Q
 ;
E(ERR) ;
 G A Q
 ;
ERROR ;
1 ;;;F - UNDEFINED COMMAND (rest of line not checked).
2 ;;;F - Non-standard (Undefined) 'Z' command.
3 ;;;F - Undefined Function.
4 ;;;F - Undefined Special Variable.
5 ;;;F - Unmatched Parenthesis.
6 ;;;F - Unmatched Quotation Marks.
7 ;;;F - ELSE Command followed by only one space.
8 ;;;F - FOR Command did not contain '='.
9 ;;;W - QUIT Command followed by only one space.
10 ;;;F - Unrecognized argument in SET command.
11 ;;;W - Invalid local variable name.
12 ;;;W - Invalid global variable name.
13 ;;;F - Blank(s) at end of line.
14 ;;;F - Missing LABEL, REFERENCED in this routine.
15 ;;;W - Duplicate label.
16 ;;;F - Error in pattern code.
17 ;;;W - First line tag NOT routine name.
18 ;;;W - Line contains a CONTROL (non-graphic) character.
19 ;;;S - Line is longer than 245 bytes.
20 ;;;S - View command used.
21 ;;;F - General Syntax Error.
22 ;;;S - Exclusive Kill.
23 ;;;S - Unargumented Kill.
24 ;;;S - Kill of an unsubscripted global.
25 ;;;S - Break command used.
26 ;;;S - Exclusive or Unargumented NEW command.
27 ;;;S - $View function used.
28 ;;;S - Non-standard $Z special variable used.
29 ;;ZIS;S - 'Close' command should be invoked through 'D ^%ZISC'.
30 ;;;S - TAG+OFFSET syntax.
31 ;;;S - Non-standard $Z function used.
32 ;;;S - 'HALT' command should be invoked through 'G ^XUSCLEAN'.
33 ;;;S - Read command doesn't have a timeout.
34 ;;ZIS;S - 'OPEN' command should be invoked through ^%ZIS.
35 ;;;S - Routine exceeds SACC maximum size of 5000 (|).
36 ;;ZTM;S - Should use 'TASKMAN' instead of 'JOB' command.
37 ;;;F - Tag is not valid.
38 ;;;F - Call to this MISSING LABEL (see INVOKED BY list).
39 ;;;S - Kill of a protected variable (|).
40 ;;;S - Space where a command should be.
41 ;;;S - Star or pound READ used.
42 ;;;F - Null line (no commands or comment).
43 ;;;F - Invalid or wrong number of arguments to a function.
44 ;;;S - Version number not found on 2nd line of routine.
45 ;;ZTM,ZTLO,ZIS;S - Set to a '%' global.
46 ;;;F - Quoted string not followed by a separator.
47 ;;;S - Lowercase command(s) used in line.
48 ;;;F - Missing argument to a command post-conditional.
49 ;;;F - Command missing an argument.
50 ;;ZTM;S - Extended reference.
51 ;;;F - Block structure mismatch.
52 ;;;F - Reference to routine '^|'. That isn't in this UCI.
53 ;;;F - Bad Number
