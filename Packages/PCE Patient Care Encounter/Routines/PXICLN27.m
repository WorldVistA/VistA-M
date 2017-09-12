PXICLN27 ;ISL/dee - Cleanup providers, routine for PX*1.0*27 ;3/26/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27**;Aug 12, 1996
ENV N PXIPRVLR,PXIPC1,PXIPC2,PXACTIVE,PXIPAT9
 S PXIPAT9=$P($G(^PX(815,1,"PATCH")),"^",1)
 I $O(^AUPNVSIT(PXIPAT9),-1)>0!'(+PXIPAT9) D
 . S XPDABORT=2
 . W !!,"It looks like the cleanup routine in PCE patch PX*1.0*9 did not finish."
 . W !,"The cleanup in patch 9 needs to be restarted so that it can finish."
 . W !,"To restart, enter D QUE^PXICLN9 from the programmers prompt."
 S PXIPRVLR=+$G(^LAB(69.9,1,12))
 I PXIPRVLR<1 D  Q
 . S XPDABORT=2
 . W !!,"The default Lab provider that was added in Lab patch LR*5.2*158"
 . W !,"has not been set up.  This provider must be setup before installing"
 . W !,"this patch."
 S PXIPC1=$$GET^XUA4A72(+PXIPRVLR,DT)
 S PXIPC2=$$GET^XUA4A72(+PXIPRVLR,2961001)
 S PXACTIVE=$P(^VA(200,+PXIPRVLR,0),"^",11)
 I PXIPC1<1!(PXIPC2<1)!(PXACTIVE'="") D
 . S XPDABORT=2
 . W !!,"The default Lab provider that was added in Lab patch LR*5.2*158"
 . W !,"is not a valid provider.  Either they have been terminated or"
 . W !,"they do not have a valid person class from 10/1/96 through now."
 Q
 ;
QUE ; Queue job to cleanup Lab Providers.
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,ZTSAVE,ZTCPU,ZTUCI
 D BMES^XPDUTL("Job to cleanup Lab and other Providers.")
 S ZTRTN="TASKED^PXICLN27"
 S ZTIO=""
 S ZTDESC="PX*1.0*27 tasked cleanup job"
 S ZTDTH=$H
 S ZTSAVE("DUZ")=DUZ,ZTSAVE("DUZ(")=""
 D ^%ZTLOAD
 I $D(ZTSK) D MES^XPDUTL("The job is task # "_ZTSK)
 I '$D(ZTSK) D MES^XPDUTL("Could not start the task job.") D BMES^XPDUTL("You should start it by doing:  D QUE^PXICLN27  at the programmers prompt.")
 Q
 ;
TASKED ;
 D CLEANUP
 D MAIL
 Q
 ;
MAIL ;Send mail messge that job is done.
 N XMY,XMSUB,PXTEXT,XMTEXT
 S XMY(DUZ)=""
 ;S XMY("G.PCEINSTAL@ISC-SLC.DOMAIN.EXT")=""
 S XMSUB="PX*1.0*27 Cleanup is finished"
 S PXTEXT(1)="PX*1.0*27 job to cleanup Lab Providers is done."
 S:$D(ZTQUEUED) PXTEXT(2)="The task job number "_ZTQUEUED_" is finished."
 S PXTEXT(3)=" "
 S PXTEXT(4)="Visit ID for this site is:  "_$P($G(^VSIT(150.2,+$P($G(^DIC(150.9,1,4)),"^",2),0)),"^",2)
 S XMTEXT="PXTEXT("
 D ^XMD
 Q
 ;
REPORT ;Send mail messge of what was done.
 N XMY,XMSUB,XMTEXT
 S XMY(DUZ)=""
 S PXIPART=PXIPART+1
 S XMSUB="PX*1.0*27 Cleanup Results Part "_PXIPART
 S ^TMP("PXTEXT",$J,1)="PX*1.0*27 job to cleanup Lab Providers."
 S:$D(ZTQUEUED) ^TMP("PXTEXT",$J,2)="The task job number "_ZTQUEUED
 S ^TMP("PXTEXT",$J,3)=" "
 S ^TMP("PXTEXT",$J,4)="IEN      Patient           Encounter Date/Time"
 S ^TMP("PXTEXT",$J,5)="  Provider      What was done or found."
 S ^TMP("PXTEXT",$J,6)=" "
 S ^TMP("PXTEXT",$J,7)="   * in front of the IEN means was not able to cleanup."
 S ^TMP("PXTEXT",$J,8)=" "
 S XMTEXT="^TMP(""PXTEXT"",$J,"
 D ^XMD
 K ^TMP("PXTEXT",$J)
 Q
 ;
CLEANUP ;
 N PXIVSIT,PXIVSTDT,PXIPRV,PXICOUNT
 N PXISORLR,PXIPKGLR,PXIPRVLR,PXILRNAM
 N PXISORPX,PXIPKGPX,PXIPC
 N PXACTIVE,PXIPRV0,PXI,PXISOR,PXIPKG
 N PXIFDA,PXIDIERR,PXICPT,PXICPTC
 N PXIMSG,PXIVSIT0,PXIPART
 ;
 ;Set up report mail message
 S PXIPART=0
 S PXIMSG=8
 K ^TMP("PXTEXT",$J)
 ;
 ;Set up package and source for PCE and Lab
 ;S PXISORLR=$$SOURCE^PXAPIUTL("LAB DATA")
 S PXIPKGLR=$$PKG2IEN^VSIT("LR")
 S PXISORPX=$$SOURCE^PXAPIUTL("CLEANUP IN PCE PATCH 27")
 S PXIPKGPX=$$PKG2IEN^VSIT("PX")
 ;
 ;get Provider for lab data
 S PXIPRVLR=+$G(^LAB(69.9,1,12))
 S PXILRNAM=$P($G(^VA(200,+PXIPRVLR,0)),"^",1)
 ;
 ;Where to start?
 S PXIVSTDT=$P($G(^PX(815,1,"PATCH")),"^",2)
 ;
 ;*R "Visit ien: ",PXIVSIT ;*
 ;*S PXIVSTDT=+^AUPNVSIT(PXIVSIT,0)
 ;*D  ;*
 ;*.D  ;*
 F  S PXIVSTDT=$O(^AUPNVSIT("B",PXIVSTDT),-1) Q:'PXIVSTDT!(PXIVSTDT<2961001)  D
 . S PXIVSIT=0
 . F  S PXIVSIT=$O(^AUPNVSIT("B",PXIVSTDT,PXIVSIT)) Q:'PXIVSIT  D
 .. K PXISOR,PXIPKG,PXI
 .. S PXICOUNT=0
 .. S PXIPRV=0
 .. F  S PXIPRV=$O(^AUPNVPRV("AD",PXIVSIT,PXIPRV)) Q:'PXIPRV  D
 ... S PXIPRV0=$G(^AUPNVPRV(PXIPRV,0))
 ... S PXIPC=$$GET^XUA4A72(+PXIPRV0,PXIVSTDT)
 ... S PXACTIVE=$P(^VA(200,+PXIPRV0,0),"^",11)
 ... I $P($G(^AUPNVPRV(PXIPRV,812)),"^",2)=PXIPKGLR D
 .... ;Lab
 .... I $P(PXIPRV0,"^",6)>0,(PXACTIVE=""!(PXACTIVE>PXIVSTDT)) Q  ;this one is ok
 .... I +PXIPC>0,'$P(PXIPRV0,"^",6),(PXACTIVE=""!(PXACTIVE>PXIVSTDT)) D
 ..... ;This one need the Person class added
 ..... S PXICOUNT=PXICOUNT+1
 ..... S PXI("PROVIDER",PXICOUNT,"NAME")=$P(PXIPRV0,"^",1)
 ..... S PXIVSIT0=$G(^AUPNVSIT(PXIVSIT,0))
 ..... S PXIMSG=PXIMSG+1
 ..... S ^TMP("PXTEXT",$J,PXIMSG)=PXIVSIT_"    "_$P($G(^DPT($P(PXIVSIT0,"^",5),0)),"^")_"    "_$$FDTTM^VALM1(+PXIVSIT0)
 ..... S PXIMSG=PXIMSG+1
 ..... S ^TMP("PXTEXT",$J,PXIMSG)="  "_$P($G(^VA(200,+PXIPRV0,0)),"^",1)_"    "_"Added person class"
 ..... I '$D(PXIPKG) D
 ...... S PXIPKG=$P($G(^AUPNVPRV(+PXIPRV,812)),"^",2)
 ...... S PXISOR=$P($G(^AUPNVPRV(+PXIPRV,812)),"^",3)
 .... E  D
 ..... ;This one needs replaced.
 ..... ;Delete this one
 ..... S PXICOUNT=PXICOUNT+1
 ..... S PXI("PROVIDER",PXICOUNT,"NAME")=$P(PXIPRV0,"^",1)
 ..... S PXI("PROVIDER",PXICOUNT,"DELETE")=1
 ..... ;Add default one
 ..... S PXICOUNT=PXICOUNT+1
 ..... S PXI("PROVIDER",PXICOUNT,"NAME")=PXIPRVLR
 ..... S PXI("PROVIDER",PXICOUNT,"PRIMARY")=1
 ..... S PXIVSIT0=$G(^AUPNVSIT(PXIVSIT,0))
 ..... S PXIMSG=PXIMSG+1
 ..... S ^TMP("PXTEXT",$J,PXIMSG)=PXIVSIT_"    "_$P($G(^DPT($P(PXIVSIT0,"^",5),0)),"^")_"    "_$$FDTTM^VALM1(+PXIVSIT0)
 ..... S PXIMSG=PXIMSG+1
 ..... S ^TMP("PXTEXT",$J,PXIMSG)="  Change Provider "_$P($G(^VA(200,+PXIPRV0,0)),"^",1)_"    to Provider "_PXILRNAM
 ..... I '$D(PXIPKG) D
 ...... S PXIPKG=$P($G(^AUPNVPRV(+PXIPRV,812)),"^",2)
 ...... S PXISOR=$P($G(^AUPNVPRV(+PXIPRV,812)),"^",3)
 ..... ;Fix all V CPT that have this as the encounter provider
 ..... S PXICPT=0
 ..... F  S PXICPT=$O(^AUPNVCPT("AD",PXIVSIT,PXICPT)) Q:'PXICPT  D
 ...... I $P($G(^AUPNVCPT(PXICPT,12)),"^",4)=+PXIPRV0 D
 ....... K PXIFDA,PXIDIERR
 ....... S PXICPTC=PXICPT_","
 ....... S PXIFDA(9000010.18,PXICPTC,1204)=PXIPRVLR
 ....... D FILE^DIE("","PXIFDA","PXIDIERR")
 ... E  D
 .... ;not lab
 .... I '$P(PXIPRV0,"^",6) D
 ..... I +PXIPC>0 D
 ...... ;Need to add Person Class
 ...... S PXICOUNT=PXICOUNT+1
 ...... S PXI("PROVIDER",PXICOUNT,"NAME")=$P(PXIPRV0,"^",1)
 ...... S PXIVSIT0=$G(^AUPNVSIT(PXIVSIT,0))
 ...... S PXIMSG=PXIMSG+1
 ...... S ^TMP("PXTEXT",$J,PXIMSG)=PXIVSIT_"    "_$P($G(^DPT($P(PXIVSIT0,"^",5),0)),"^")_"    "_$$FDTTM^VALM1(+PXIVSIT0)
 ...... S PXIMSG=PXIMSG+1
 ...... S ^TMP("PXTEXT",$J,PXIMSG)="  "_$P($G(^VA(200,+PXIPRV0,0)),"^",1)_"    "_"Added person class"
 ...... I '$D(PXIPKG) D
 ....... S PXIPKG=$P($G(^AUPNVPRV(+PXIPRV,812)),"^",2)
 ....... S PXISOR=$P($G(^AUPNVPRV(+PXIPRV,812)),"^",3)
 ..... E  D
 ...... ;Needs Person Class but none to add
 ...... S PXIVSIT0=$G(^AUPNVSIT(PXIVSIT,0))
 ...... S PXIMSG=PXIMSG+1
 ...... S ^TMP("PXTEXT",$J,PXIMSG)="*"_PXIVSIT_"    "_$P($G(^DPT($P(PXIVSIT0,"^",5),0)),"^")_"    "_$$FDTTM^VALM1(+PXIVSIT0)
 ...... S PXIMSG=PXIMSG+1
 ...... S ^TMP("PXTEXT",$J,PXIMSG)="  "_$P($G(^VA(200,+PXIPRV0,0)),"^",1)_"    "_"STILL NEEDS A PERSON CLASS"
 .. ;
 .. I $D(PXI) D
 ... ;Process
 ... I $G(PXIPKG)<1 S PXIPKG=PXIPKGPX
 ... I $G(PXISOR)<1 S PXISOR=PXISORPX
 ... I $$DATA2PCE^PXAPI("PXI",PXIPKG,PXISOR,PXIVSIT)
 .. I PXIMSG>2000 D REPORT S PXIMSG=8
 . ;
 . S $P(^PX(815,1,"PATCH"),"^",2)=PXIVSTDT
 I PXIMSG>8 D REPORT
 Q
 ;
