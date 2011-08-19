IBDFDE10 ;ALB/AAS - AICS Data entry utility ; 5-MAR-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
SCREEN(Y,IBDDT) ; -- Copy of provider screen from sdutl2
 ;
 ; INPUT:      Y = ien of file 200
 ;         IBDDT = today's date
 ;
 ; OUTPUT: 1 to select; 0 to not select
 ;
 N IBDINACT,IBDT,IBDY S IBDY=0
 S:'+$G(IBDDT) IBDDT=DT
 I '+$G(Y) G SCRNQ
 ;
 S IBDINACT=$G(^VA(200,+Y,"PS"))
 I '$S(IBDINACT']"":1,'+$P(IBDINACT,"^",4):1,DT<+$P(IBDINACT,"^",4):1,1:0) G SCRNQ
 S IBDT=+$P($G(^VA(200,+Y,0)),U,11)
 I $S('IBDT:0,(IBDT<DT):1,1:0) G SCRNQ
 I $$GET^XUA4A72(Y,IBDDT)>0 S IBDY=1
SCRNQ Q IBDY
