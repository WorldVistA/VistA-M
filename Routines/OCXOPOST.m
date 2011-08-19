OCXOPOST ;SLC/RJS,CLA - ORDER CHECK INSTALL POST INIT ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
EN ;
 ;
 N OCXOETIM S OCXOETIM=$H
 ;
 I $L($T(AUTO^OCXDIAG)) D
 .;
 .N OCXOETIM,OCXF,OCXR,OCXC,OCXTT,OCXTC
 .D BMES^XPDUTL("---Order Check Integrity Check------------------------------------")
 .D AUTO^OCXDIAG
 .D BMES^XPDUTL("---Retotaling Order Check files-----------------------------------")
 .F OCXGL="^OCXD","^OCXS" D
 ..S OCXF=0 F OCXTT=0:1 S OCXF=$O(@OCXGL@(OCXF)) Q:'OCXF
 ..S OCXF=0 F OCXTC=0:1 S OCXF=$O(@OCXGL@(OCXF)) Q:'OCXF  D
 ...D STATUS(OCXTC,OCXTT)
 ...S OCXR=0 F OCXC=0:1 S OCXR=$O(@OCXGL@(OCXF,OCXR)) Q:'OCXR
 ...Q:'OCXC
 ...S $P(@OCXGL@(OCXF,0),U,3,4)=OCXC_U_$O(@OCXGL@(OCXF,"A"),-1)
 ;
 I $L($T(AUTO^OCXOCMP)) D
 .;
 .N OCXOETIM
 .D BMES^XPDUTL("---Creating Order Check Routines-----------------------------------")
 .D AUTO^OCXOCMP
 ;
 I $L($T(^XMB)) D
 .;
 .N XMB,XMDUZ,XMY,OCXTIME
 .S OCXTIME=$H-OCXOETIM*86400
 .S OCXTIME=OCXTIME+($P($H,",",2)-$P(OCXOETIM,",",2))
 .S XMB="OCX POSTINIT COMPLETE"
 .S XMB(1)=$P($T(+3),";;",3)
 .S XMB(2)=$$CONV($$DATE)
 .S XMB(3)="["_DUZ_"]  "_$P($G(^VA(200,DUZ,0)),U,1)
 .S XMB(4)=(OCXTIME\60)_" minutes "_(OCXTIME#60)_" seconds "
 .S XMY("G.OCX DEVELOPERS@ISC-SLC.VA.GOV")=""
 .S XMY("G.OCX DEVELOPERS")=""
 .S XMDUZ=.5
 .S XMDT="N"
 .D ^XMB
 ;
 Q
 ;
DATE() N X,Y,%DT S X="N",%DT="T" D ^%DT X ^DD("DD") Q Y
 ;
CONV(Y) Q:'(Y["@") Y Q $P(Y,"@",1)_" at "_$P(Y,"@",2,99)
 ;
STATUS(CURRENT,XPDIDTOT) ;
 ;
 I '$D(XPDIDVT) N XPDIDVT
 S XPDIDVT=$G(XPDIDVT)
 D UPDATE^XPDID(CURRENT)
 ;
 Q
 ;
