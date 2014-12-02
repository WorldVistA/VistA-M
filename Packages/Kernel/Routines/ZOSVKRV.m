%ZOSVKR ;SF/KAK/RAK - ZOSVKRV - Collect RUM Statistics for VAX-DSM;8/20/99  08:44 ;7/29/10  09:57
 ;;8.0;KERNEL;**90,94,107,122,143,186,550**;July 7, 2010 10:10 am;Build 23
 ;
RO(OPT) ; Record option resource usage in ^KMPTMP("KMPR"
 ;
 Q
 ;
RP(PRTCL) ; Record protocol resource usage in ^KMPTMP("KMPR"
 ; Variable PRTCL = option_name^protocol_name
 Q
 ;
RU(KMPROPT,KMPRTYP,KMPRSTAT) ;-- set resource usage into ^KMPTMP("KMPR"
 Q
 ;
EN ;
  Q
 ;
STATS() ;-- extrinsic - return current stats for this $job
 ;
 Q ""
