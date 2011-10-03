SDAMQ1 ;ALB/MJK - AM Background Job (cont.) ; 12/1/91
 ;;5.3;Scheduling;**24,132**;Aug 13, 1993
 ;
BULL ; -- send bulletin
 ; use site specified mg
 N SDLN,XMY,XMTEXT,XMSUB,XMDUZ
 D XMY^SDUTL2(+$P($G(^DG(43,1,"SCLR")),U,15),0)
 G BULLQ:'$D(XMY)
 S XMSUB="Outpatient Encounter Status Update"
 K ^TMP("SDAMTEXT",$J) S XMTEXT="^TMP(""SDAMTEXT"",$J,",SDLN=0
 D TEXT,^XMD
BULLQ K ^TMP("SDAMTEXT",$J)
 Q
 ;
TEXT ;
 D SET^SDAMQ3("The 'Outpatient Encounter' status update has been completed.")
 D SET^SDAMQ3(" ")
 D SET^SDAMQ3("            Job STARTED  Date/Time: "_$$FTIME^VALM1(SDSTART))
 D SET^SDAMQ3("            Job FINISHED Date/Time: "_$$FTIME^VALM1(SDFIN))
 D SET^SDAMQ3(" ")
 D SET^SDAMQ3(" ")
 D SET^SDAMQ3("                                 *** Update Summary ***")
 D SET^SDAMQ3(" ")
 D SET^SDAMQ3("      Outpatient encounters from "_$$FDATE^VALM1(SDBEG)_" to "_$$FDATE^VALM1(SDEND)_"@2400:")
 N SDIVNM,SDTOT
 S SDIVNM="" F X="NAT","GRAND" S SDTOT("OVERALL",X)=0
 F  S SDIVNM=$O(^TMP("SDSTATS",$J,SDIVNM)) Q:SDIVNM=""  D
 .F X="NAT","GRAND" S SDTOT("DIV",X)=0
 .D SET^SDAMQ3(""),SET^SDAMQ3(""),SET^SDAMQ3(""),SET^SDAMQ3("    Division: "_SDIVNM)
 .D BULL^SDAMQ3(.SDIVNM,.SDLN,.SDTOT) ; appointments
 .D BULL^SDAMQ4(.SDIVNM,.SDLN,.SDTOT) ; add/edits
 .D BULL^SDAMQ5(.SDIVNM,.SDLN,.SDTOT) ; dispositions
 .D SET^SDAMQ3("         ==============                ===============     =======   =======")
 .D LINE^SDAMQ3("DIVISION TOTAL",SDTOT("DIV","NAT"),SDTOT("DIV","GRAND"))
 .F X="NAT","GRAND" S SDTOT("OVERALL",X)=SDTOT("OVERALL",X)+SDTOT("DIV",X)
 D SET^SDAMQ3("         ==============                ===============     =======   =======")
 D LINE^SDAMQ3("FACILITY TOTAL",SDTOT("OVERALL","NAT"),SDTOT("OVERALL","GRAND"))
 Q
 ;
ADD ; -- add log entries
 N SDDT,X1,X2,X,DR,DA,DIE,DIC
 S SDDT=SDBEG
 F  Q:SDDT>SDEND  S X=SDDT,DIC(0)="LM",DLAYGO=409.65,DIC="^SDD(409.65," D ^DIC K DIC,DLAYGO D
 .I Y>0 S DA=+Y,DR="[SDAM ADD LOG]",DIE="^SDD(409.65," D ^DIE
 .S X1=SDDT,X2=1 D C^%DTC S SDDT=X
 Q
 ;
UPD(SDBEG,SDEND,SDATE,SDFLD,SDADD) ; -- update date fields in 409.65
 ; input:  SDBEG := begin date
 ;         SDEND := end date
 ;         SDATE := date/time of processing(i.e. NOW)
 ;         SDFLD := date field to update
 ;         SDADD := flag to add entry [optional]
 ;
 N SDDT,X1,X2,X,DR,DA,DIE,DIC,SDDR
 I '$D(SDADD) N SDADD S SDADD=0
 S SDDT=SDBEG,SDDR=SDFLD_"////"_SDATE
 F  Q:SDDT>SDEND  D
 .S X=SDDT,DIC(0)="",DIC="^SDD(409.65,"
 .S:SDADD DIC(0)=DIC(0)_"L",DLAYGO=409.65
 .D ^DIC K DIC,DLAYGO
 .I Y>0,$S(SDFLD'=.06:1,1:'$D(^TMP("SDAM NOT UPDATED",$J,SDDT))) S DA=+Y,DR=SDDR,DIE="^SDD(409.65," D ^DIE
 .S X1=SDDT,X2=1 D C^%DTC S SDDT=X
 Q
 ;
