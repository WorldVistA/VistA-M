PRCSRDIS ;WISC/KMB/CODE FOR CROSS REF CREATION ;11/28/94  12:01 PM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;   place existing temp trans from last 180 days on "K" cross ref
 S (PRC("CP"),PRC("SITE"))=0,U="^"
 D:'$D(DT) DT^DICRW S XTEST=$$FMADD^XLFDT(DT,-180,0,0,0)
 S (PZIP,PZIP1)=0 F II=0:0 S PZIP=$O(^PRCS(410,"H",PZIP)) Q:PZIP=""  D
 .S PZIP1=$O(^PRCS(410,"H",PZIP,PZIP1)) Q:PZIP1=""  D
 ..N REF,REF1 S REF=$P($G(^PRCS(410,PZIP1,0)),"^"),REF1=$P($G(^PRCS(410,PZIP1,0)),"^",3) Q:REF'=REF1
 ..S XCP=+$P($G(^PRCS(410,PZIP1,3)),"^"),CDATE=$P($G(^PRCS(410,PZIP1,1)),"^")
 ..I CDATE<XTEST Q
 ..S ^PRCS(410,"K",XCP,PZIP1)="",$P(^PRCS(410,PZIP1,6),"^",4)=XCP
 K REF,REF1,XTEST,II,XCP,CDATE,PZIP,PZIP1,PRC Q
TEMPDIS ;  display temp. trans to clerks
 ; is this subroutine used?  may be beneficial for testing clerk display
 N PRCSI,PRCSJ,COUNT
 Q:'$D(DUZ)  S (PRC("CP"),PRC("SITE"))=0,U="^"
 F PRCSI=0:0 S PRC("SITE")=$O(^PRC(420,"A",DUZ,PRC("SITE"))) Q:PRC("SITE")'>0  F PRCSJ=0:0 S PRC("CP")=$O(^PRC(420,"A",DUZ,PRC("SITE"),+PRC("CP"))) Q:PRC("CP")'>0  D CHECK
 QUIT
CHECK ; this subroutine is called from PRCSUT1
 S COUNT=0
 F LOOP1=0:0 S LOOP1=$O(^PRCS(410,"K",+PRC("CP"),LOOP1)) Q:LOOP1=""  D
 .I +$P(^PRCS(410,LOOP1,0),"^",5)=+PRC("SITE") S COUNT=COUNT+1
 I COUNT>0 W !,"You have ",COUNT," request(s) to process in station "_PRC("SITE")_", CP ",PRC("CP")
 Q
