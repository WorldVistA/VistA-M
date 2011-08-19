PRCPSFIU ;WISC/RFJ/DGL-fms utility (lookup fcp data) ; 7/22/99 1:50pm
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
IVDATA(TRANDA,INVPT) ;  get fund control point data for iv doc
 ;  tranda=issue book ien; invpt=whse inventory point
 N PRC,TRANNO
 S TRANNO=$P($G(^PRCS(410,TRANDA,0)),"^")
 ;  seller=whse data
 S PRCPWSTA=$P($P($G(^PRCP(445,INVPT,0)),"^"),"-")
 S PRCPWFCP=+$O(^PRC(420,"AE",PRCPWSTA,INVPT,0)) ; Multiple FCP not supported
 S PRCPWBFY=$$BBFY^PRCSUT(PRCPWSTA,$P(TRANNO,"-",2),PRCPWFCP)
 ;  buyer data
 S PRCPPSTA=$P(TRANNO,"-")
 S PRCPPFCP=+$P($G(^PRCS(410,TRANDA,3)),"^") I 'PRCPPFCP S PRCPPFCP=+$P(TRANNO,"-",4)
 S PRCPPBFY=$P($G(^PRCS(410,TRANDA,3)),"^",11) I PRCPPBFY'="" S PRCPPBFY=(17+$E(PRCPPBFY))_$E(PRCPPBFY,2,3)
 I PRCPPBFY="" S PRCPPBFY=$$BBFY^PRCSUT(PRCPPSTA,$P(TRANNO,"-",2),PRCPPFCP)
 Q
 ;
 ;
SVDATA(INVPT) ;  get fund control point data for sv doc
 ;  invpt=whse inventory point
 N PRC
 S PRCPWSTA=$P($P($G(^PRCP(445,INVPT,0)),"^"),"-")
 S PRCPWFCP=+$O(^PRC(420,"AE",PRCPWSTA,INVPT,0)) ; Multiple FCP not supported
 S PRCPWBFY=$$BBFY^PRCSUT(PRCPWSTA,$E(DT,2,3),PRCPWFCP)
 Q
