XINDX1 ;ISC/REL,GRK,RWF - ERROR ROUTINE ;08/05/08  13:59
 ;;7.3;TOOLKIT;**20,61,66,68,110,121,128,133**;Apr 25, 1995;Build 15
 ; Per VHA Directive 2004-038, this routine should not be modified.
 G A
E(ERR) ;
A N %,%1 ;TXT is the line of the error.
 S ERTX=LAB_$S(LABO:"+"_LABO,1:"")_$C(9),%1=$T(ERROR+ERR),ERTX=ERTX_$S(ERR:$P(%1,";",4,9),1:ERR) ;p110
 I ERTX["|" F %=1:1 S ERTX=$P(ERTX,"|")_$S($D(ERR(%)):ERR(%),1:"??")_$P(ERTX,"|",%+1,99) Q:ERTX'["|"
 ;check exclude rtn list
B I $P(%1,";",3)]"" D  Q:%1]""  ;Don't flag kernel doing kernel.
 . S %1=$P(%1,";",3)
 . F  Q:RTN[$P(%1,",")  S %1=$P(%1,",",2,99) ;quit if RTN[%1 or null.
 . Q
 I ERR=17,$E(RTN)'="%",$E(LAB)="%" Q  ;Don't flag %RTN w/o %.
 ;Global is Error Line,tab,error tag,tab,error text
 S %=$G(^UTILITY($J,1,RTN,"E",0))+1,^(0)=%,^(%)=TXT_$C(9)_ERTX
 Q
 ;
 ;F = Fatal, S = Standard, W = Warning, I = Info
 ;;exclude rtn;error text
ERROR ;
1 ;;;F - UNDEFINED COMMAND (rest of line not checked).
2 ;;X,Z,DI,DD,KMP;F - Non-standard (Undefined) 'Z' command.
3 ;;X,Z,DI,DD,KMP;F - Undefined Function.
4 ;;;F - Undefined Special Variable.
5 ;;;F - Unmatched Parenthesis.
6 ;;;F - Unmatched Quotation Marks.
7 ;;;F - ELSE Command followed by only one space.
8 ;;;F - FOR Command did not contain '='.
9 ;;;I - QUIT Command followed by only one space.
10 ;;;F - Unrecognized argument in SET command.
11 ;;;W - Invalid local variable name.
12 ;;;W - Invalid global variable name.
13 ;;;W - Blank(s) at end of line.
14 ;;;F - Call to missing label '|' in this routine.
15 ;;;W - Duplicate label. (M57)
16 ;;;F - Error in pattern code.
17 ;;Z;W - First line label NOT routine name.
18 ;;;W - Line contains a CONTROL (non-graphic) character.
19 ;;;S - Line is longer than 245 bytes.
20 ;;X,Z,DI,DD,KMP;S - View command used.
21 ;;;F - General Syntax Error.
22 ;;X,Z,DI,DD,KMP;S - Exclusive Kill.
23 ;;X,Z,DI,DD,KMP;S - Unargumented Kill.
24 ;;;S - Kill of an unsubscripted global.
25 ;;;S - Break command used.
26 ;;X,Z,DI,DD,KMP;S - Exclusive or Unargumented NEW command.
27 ;;X,Z,DI,DD,KMP;S - $View function used.
28 ;;X,Z,DI,DD,KMP;S - Non-standard $Z special variable used.
29 ;;X,Z,DI,DD,KMP;S - 'Close' command should be invoked through 'D ^%ZISC'.
30 ;;;S - LABEL+OFFSET syntax.
31 ;;X,Z,DI,DD,KMP;S - Non-standard $Z function used.
32 ;;X,Z,DI,DD,KMP;S - 'HALT' command should be invoked through 'G ^XUSCLEAN'.
33 ;;X,Z,DI,DD,KMP;S - Read command doesn't have a timeout.
34 ;;X,Z,DI,DD,KMP;S - 'OPEN' command should be invoked through ^%ZIS.
35 ;;;S - Routine exceeds SACC maximum size of 20000 (|).
36 ;;X,Z,DI,DD,KMP;S - Should use 'TASKMAN' instead of 'JOB' command.
37 ;;;F - Label is not valid.
38 ;;;F - Call to this |
39 ;;X,Z,DI;S - Kill of a protected variable (|).
40 ;;;S - Space where a command should be.
41 ;;X,Z,DI,DD,KMP;I - Star or pound READ used.
42 ;;;W - Null line (no commands or comment).
43 ;;;F - Invalid or wrong number of arguments to a function.
44 ;;;S - 2nd line of routine violates the SAC.
45 ;;X,Z,DI,DD,KMP;S - Set to a '%' global.
46 ;;;F - Quoted string not followed by a separator.
47 ;;;S - Lowercase command(s) used in line.
48 ;;;F - Missing argument to a command post-conditional.
49 ;;;F - Command missing an argument.
50 ;;Z;S - Extended reference.
51 ;;;F - Block structure mismatch.
52 ;;;F - Reference to routine '^|'. That isn't in this UCI.
53 ;;;F - Bad Number.
54 ;;X,Z,DI,DD,KMP;S - Access to SSVN's or $SYSTEM restricted to Kernel.
55 ;;;S - Violates VA programming standards.
56 ;;;S - Patch number '|' missing from second line.
57 ;;;S - Lower/Mixed case Variable name used.
58 ;;;S - Routine code exceeds SACC maximum size of 15000 (|).
59 ;;;F - Bad WRITE syntax.
60 ;;X,Z,DI,DD,KMP;S - Lock missing Timeout.
61 ;;X,Z,DI,DD,KMP;S - Non-Incremental Lock.
62 ;;;S - First line of routine violates the SAC.
63 ;;;F - GO or DO mismatch from block structure (M45).
64 ;;;F - Cache Object doesn't exist.
