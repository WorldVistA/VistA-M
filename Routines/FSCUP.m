FSCUP ;SLC/STAFF-NOIS Utilities Parameters ;1/11/98  15:25
 ;;1.1;NOIS;;Sep 06, 1998
 ;
WEDATE() ; $$ -> workload edit date
 N WED
 S WED=+$P($G(^FSC("PARAM",1,0)),U,10)
 Q $$FMADD^XLFDT(DT,-WED)
 ;
MAXCALL() ; $$ -> max calls allowed in a list
 N MAXCALL
 S MAXCALL=$P($G(^FSC("PARAM",1,0)),U,11)
 I 'MAXCALL Q 1000000
 Q MAXCALL
 ;
MAXLINE() ; $$ -> max lines allowed in viewing calls
 N MAXLINE
 S MAXLINE=$P($G(^FSC("PARAM",1,0)),U,12)
 I 'MAXLINE S MAXLINE=1000000
 Q MAXLINE
 ;
NSALERT() ; $$ -> non spec entry alert (I,P, or F)
 N NSALERT
 S NSALERT=$P($G(^FSC("PARAM",1,0)),U,13)
 I '$L(NSALERT) Q "P"
 Q NSALERT
 ;
CONALERT() ; $$ -> contact alert (I,P, or F)
 N CONALERT
 S CONALERT=$P($G(^FSC("PARAM",1,0)),U,14)
 I '$L(CONALERT) Q "P"
 Q CONALERT
