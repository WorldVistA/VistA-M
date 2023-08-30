PSOEPED ;JLI/FO-OAKLAND-RPC to handle epcs data changes ;7/29/21  09:53
 ;;7.0;OUTPATIENT PHARMACY;**545**;DEC 1997;Build 270
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 ;External reference to XUEPCS DATA file (#8991.6) is supported by DBIA 7015
 ;External reference to XUEPCS PSDRPH AUDIT file (#8991.7) is supported by DBIA 7016
 ;External reference to KEYS sub-file (#200.051) is supported by DBIA 7054
 Q
 ;
ENTRY(RESULT,INPUT) ;.remoteprocedure
 NEW I,NOW
 SET NOW=$P($$HTE^XLFDT($H),":",1,2)
 FOR I=-1:0 SET I=$O(INPUT(I)) QUIT:I=""  DO RECORD(INPUT(I),NOW)
 SET RESULT=1
 QUIT
 ;
RECORD(LINE,NOW) ;
 N FDA,VALUE,IEN,MSG,I
 FOR I=1:1:5 SET VALUE=$P(LINE,U,I),FDA(8991.6,"+1,",(I/100))=VALUE
 SET FDA(8991.6,"+1,",.06)=NOW
 SET FDA(8991.6,"+1,",.07)=$P(LINE,U,6)
 SET FDA(8991.6,"+1,",.08)=$P(LINE,U,7)
 DO UPDATE^DIE("E","FDA","IEN","MSG")
 QUIT
 ;
PRINT ; print audit logs as indicated
 NEW DIR,I,VAL,X,Y,BY,DIC,FLDS,L
 SET DIR(0)="S^"
 FOR I=1:1:6 SET X=$T(SORTTYPE+I),DIR(0)=DIR(0)_$SELECT(I>1:";",1:"")_I_":"_$PIECE(X,";",3),VAL(I)=$PIECE(X,";",4)
 SET DIR("A")="SORT BY" DO ^DIR IF +$GET(Y)'>0 QUIT
 SET BY=VAL(+Y),FLDS=".06,.01,.02,.03,.04,.05",DIC=8991.6,L="" DO EN1^DIP
 QUIT
 ;
SORTTYPE ; specifies sort types for selection
 ;;Sort by Edited By then Date/time;.02,.06,.01
 ;;Sort by Edited By then User Edited;.02,.01,.06
 ;;Sort by Date/time then Edited By;.06,.02,.01
 ;;Sort by Date/time then User Edited;.06,.01,.02
 ;;Sort by User Edited then Edited By;.01,.02,.06
 ;;Sort by User Edited then Date;.01,.06,.02
 ;      .01        .02         .06
 ; User Edited, Edited by, Date/Time Edited
