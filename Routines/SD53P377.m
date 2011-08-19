SD53P377 ;BP OIFO/TEH - POST INIT FOR PHY LOC SORT ; 4/24/01 3:10pm
 ;;5.3;Scheduling;**377**;Aug 13, 1993
 ;
 ;This routine creates a report of clinics without physical
 ;locations.
 ;
 ;
EN N SC,SCPL,SDI,SDR K ^TMP("SD53P377")
 S SC=0 F  S SC=$O(^SC(SC)) Q:SC<1  D
 .I $P(^SC(SC,0),"^",3)'="C" Q
 .I $D(^SC(SC,"I")) S SDI=$P($G(^SC(SC,"I")),"^",1),SDR=$P($G(^("I")),"^",2)
 .I $D(^SC(SC,"I")),SDI'="",SDR="" Q
 .S SCPL=$P($G(^SC(SC,0)),"^",11) I SCPL="" D
 ..S ^TMP("SD53P377",SC)=$P(^SC(SC,0),"^")
PRINT ;
 N SDCLIN,SDPAGE,SDEND
 W !,"Clinics W/O Physical Location Report",!
 S SDPAGE=0,SDEND="",%ZIS="Q" D ^%ZIS
 I POP Q
 I $G(IO("Q"))=1 D  Q
 .N ZTRTN,ZTDESC,ZTSAVE
 .S ZTRTN="PRINT1^SD53P377",ZTDESC="Clinics W/O Physical Location"
 .S ZTSAVE("SD*")=""
 .D ^%ZTLOAD K IO("Q")
 ;
PRINT1 ;
 U IO
 D HDR
 S SDCLIN=0
 F  S SDCLIN=$O(^TMP("SD53P377",SDCLIN)) Q:SDCLIN=""!(SDEND)  D
 .W !,?15,$G(^TMP("SD53P377",SDCLIN))
 .D HDR:$Y+3>IOSL Q:SDEND
 W @IOF
 D ^%ZISC
 Q
HDR ;
 I SDPAGE>0,$E(IOST,1,2)="C-" S SDEND=$$EOP() Q:SDEND
 S SDPAGE=SDPAGE+1
 W:SDPAGE'=1 @IOF
 W !,?10,"Clinics W/O Physical Location"
 W !,?10,"-----------------------------",!
 Q
EOP() ;End of page check
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 I $E(IOST,1,2)'="C-" Q 0  ;not a terminal
 S DIR(0)="E"
 D ^DIR
 Q 'Y
 ;
 ;MAIL MESSAGE
 ;
 ;N XMSUB,XMY,XMTEXT,XMDUZ
 ;S XMSUB="Scheduling 5.3 - Clinic Without Phyiscal Locations for Routing Slip Sort."
 ;S XMY("G.APPOINTMENT MANAGEMENT")=""
 ;K ^TMP("SD53P377",$J)
 ;I '$D(^TMP("SD53P377",$J)) D
 ;.S ^TMP("SD53P377",$J,999999)="All Phys Locations are populated."
 ;S XMTEXT="^TMP(""SD53P377"",$J,"
 ;S XMDUZ="POSTMASTER"
 ;D ^XMD
 Q
