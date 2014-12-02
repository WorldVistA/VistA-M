XUEPCSED ;JLI/FO-OAKLAND-RPC to handle epcs data changes ;08/24/12  11:56
 ;;8.0;KERNEL;**580**;Jul 10, 1995;Build 46
 ;Per VHA Directive 2004-038, this routine should not be modified.
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
