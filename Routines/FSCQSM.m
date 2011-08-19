FSCQSM ;SLC/STAFF-NOIS Query Search Multiple ;8/18/98  12:07
 ;;1.1;NOIS;;Sep 06, 1998
 ;
MULT(CALL) ; from execution of ACTION variable, setup in FSCQS
 ; go thru secondary checks
 N SEQ,SEQ1,OK S OK=1 S SEQ=0 F  S SEQ=$O(CRITERIA("O",SEQ)) Q:SEQ<1  D  Q:'OK
 .S SEQ1=0 F  S SEQ1=$O(CRITERIA("O",SEQ,"AND",SEQ1)) Q:SEQ1<1  D  Q:'OK
 ..X CRITERIA("O",SEQ,"AND",SEQ1) I '$T S OK=0
 Q
MMULT(CALL) ;
 ; go thru secondary checks
 N SEQ,SEQ1,OK S OK=1 S SEQ=0 F  S SEQ=$O(CRITERIA("O",SEQ)) Q:SEQ<1  D  Q:$D(^TMP("FSC NEWLIST",$J,CALL))
 .S OK=1 S SEQ1=0 F  S SEQ1=$O(CRITERIA("O",SEQ,"AND",SEQ1)) Q:SEQ1<1  D  Q:'OK
 ..X CRITERIA("O",SEQ,"AND",SEQ1) I '$T S OK=0
 Q
