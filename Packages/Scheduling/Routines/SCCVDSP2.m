SCCVDSP2 ; ALB/TMP - SCHED VSTS CST/AST SCREEN UTILITIES ; 25-NOV-97
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
EXPAND(FILE,FIELD,VALUE) ; -- return external value of a FM field
 N Y
 K ^TMP("DIERR",$J)
 I 'FILE!('FIELD)!(VALUE="") G EXPQ
 S Y=$$EXTERNAL^DILFD(FILE,FIELD,"L",VALUE)
EXPQ I $G(Y)="" S Y=VALUE
 Q $G(Y)
 ;
NONE(FILE,FIELD,VALUE,DEFAULT) ; -- return external value of a FM field or 'None'
 N Y
 S Y=$$EXPAND(FILE,FIELD,VALUE)
 IF Y="" S Y=$G(DEFAULT,"NONE")
 Q Y
 ;
REV(SCCVZ,LINE,COL) ; -- Set reverse video for a line
 D CNTRL^VALM10(LINE,COL,$L(SCCVZ),IORVON,IORVOFF)
 Q
 ;
