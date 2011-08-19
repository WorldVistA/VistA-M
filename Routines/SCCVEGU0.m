SCCVEGU0 ;ALB/JRP - UTILS FOR ENCNTR CNVRSN GLBL ESTMTR;11-JAN-1996
 ;;5.3;Scheduling;**211**;Aug 13, 1993
INSERT(INSTR,OUTSTR,COLUMN,LENGTH) ;INSERT A STRING INTO ANOTHER
 ;INPUT  : INSTR - String to insert
 ;         OUTSTR - String to insert into
 ;         COLUMN - Where to begin insertion (defaults to end of OUTSTR)
 ;         LENGTH - Number of characters to clear from OUTSTR
 ;                  (defaults to length of INSTR)
 ;OUTPUT : s - INSTR will be placed into OUTSTR starting at COLUMN
 ;             using LENGTH characters
 ;         "" - Error (bad input)
 ;
 ;NOTE : This module is based on $$SETSTR^VALM1
 ;
 N STRING
 Q:'$D(INSTR)!'$D(OUTSTR) ""
 I '$G(COLUMN) N COLUMN S COLUMN=$L(OUTSTR)+1
 I '$G(LENGTH) N LENGTH S LENGTH=$L(INSTR)
 S INSTR=$S($L(INSTR)<LENGTH:INSTR_$J("",LENGTH-$L(INSTR)),1:INSTR)
 S $E(OUTSTR,COLUMN,COLUMN+LENGTH-1)=INSTR
 Q OUTSTR
 ;
CENTER(CNTRSTR,MARGIN) ;CENTER A STRING
 ;INPUT  : CNTRSTR - String to center
 ;         MARGIN - Margin width to center within (defaults to 80)
 ;OUTPUT : s - INSTR will be centered in a margin width of MARGIN
 ;         "" - Error (bad input)
 ;NOTES  : A margin width of 80 will be used when MARGIN<1
 ;       : CNTRSTR will be returned when $L(CNTRSTR)>MARGIN
 ;
 N STRING,FROM
 ;Check input
 Q:($G(CNTRSTR)="") ""
 I $G(MARGIN)<1 N MARGIN S MARGIN=80
 Q:($L(CNTRSTR)>MARGIN) CNTRSTR
 S STRING="",$P(STRING," ",MARGIN+1)="",FROM=(MARGIN\2)-($L(CNTRSTR)\2)+1
 S $E(STRING,FROM,FROM+$L(CNTRSTR)-1)=CNTRSTR
 Q STRING
 ;
