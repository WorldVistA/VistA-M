PSOCPBK5 ;BIR/GN-Back Billing Automated-release refill copay cont. ;10/11/05 1:56pm
 ;;7.0;OUTPATIENT PHARMACY;**217**;DEC 1997
 ;
MAIL ;user mail message
 N TOTAMT,PSOCXPDA
 D NOW^%DTC S Y=% D DD^%DT S PSOEND=Y
 S PSOEND2=$$FMTE^XLFDT(%,"1PS")
 I $G(DUZ) S XMY(DUZ)=""
 S XMDUZ="PSO*7*217 "_JOBN
 S XMSUB="Outpatient Pharmacy Copay "_JOBN
 F PSOCXPDA=0:0 S PSOCXPDA=$O(^XUSEC("PSO COPAY",PSOCXPDA)) Q:'PSOCXPDA  S XMY(PSOCXPDA)=""
 I $O(XMY(""))="" Q  ; no recipients for mail message
 S PSOTEXT(1)="The Rx copay "_JOBN_" job for the Outpatient Pharmacy patch (PSO*7*217)"
 S PSOTEXT(2)="started "_PSOSTART_" and completed "_PSOEND_"."
 I PSOCNT=0 S PSOTEXT(3)="No released unbilled copay fills were found."
 I PSOCNT>0 D
 . S TOTAMT=0
 . F XX="YR2004","YR2005" D
 .. F YY=1:1:3 S PSOAMT(XX,YY)=PSOCNT(XX,YY)*YY*7,TOTAMT=TOTAMT+PSOAMT(XX,YY)
 . S PSOTEXT(3)="Auto-Released refills have now been Billed"
 . S PSOTEXT(4)="There were "_$FN(PSOCNT,",")_" fills successfully Billed for "_$FN(PSOVETS,",")_" veterans."
 . S PSOTEXT(5)=" "
 . S PSOTEXT(6)="Fills back-billing by year:"
 . S PSOTEXT(7)="2004  30-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2004",1),6)
 . S PSOTEXT(7)=PSOTEXT(7)_"     $"_$J($FN(PSOAMT("YR2004",1),","),9)
 . S PSOTEXT(8)="2004  60-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2004",2),6)
 . S PSOTEXT(8)=PSOTEXT(8)_"     $"_$J($FN(PSOAMT("YR2004",2),","),9)
 . S PSOTEXT(9)="2004  90-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2004",3),6)
 . S PSOTEXT(9)=PSOTEXT(9)_"     $"_$J($FN(PSOAMT("YR2004",3),","),9)
 . S PSOTEXT(10)=""
 . S PSOTEXT(11)="2005  30-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2005",1),6)
 . S PSOTEXT(11)=PSOTEXT(11)_"     $"_$J($FN(PSOAMT("YR2005",1),","),9)
 . S PSOTEXT(12)="2005  60-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2005",2),6)
 . S PSOTEXT(12)=PSOTEXT(12)_"     $"_$J($FN(PSOAMT("YR2005",2),","),9)
 . S PSOTEXT(13)="2005  90-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2005",3),6)
 . S PSOTEXT(13)=PSOTEXT(13)_"     $"_$J($FN(PSOAMT("YR2005",3),","),9)
 . S PSOTEXT(14)="                                          =========="
 . S PSOTEXT(15)="                                    TOTAL $"_$J($FN(TOTAMT,","),9)
 . S PSOTEXT(16)=" "
 . S PSOTEXT(17)="To get a report of patients/prescriptions that were billed"
 . S PSOTEXT(18)="as part of this Back Billing, enter D RPT^PSOCPBK4 at the programmer's prompt"
 ;
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
 ;
MAIL2 ;management mail message
 N J
 S LIN="",$P(LIN," ",80)=""
 D NOW^%DTC S PSOTIME=$$FMDIFF^XLFDT(%,$G(PSOS1),2)
 S PSOINST=$P($G(^DIC(4,+$P($G(^XMB(1,1,"XUS")),"^",17),99)),"^")
 S PSOSTNM=$P($G(^DIC(4,PSOINST,0)),"^")
 K PSOTEXT
 S XMY(DUZ)="",PSOTC=0,PSOCNTS=""
 F J="YR2004","YR2005" F I=1:1:3 D
 .S PSOTC=PSOTC+PSOCNT(J,I)
 .S PSOCNTS=PSOCNTS_","_PSOCNT(J,I)
 S XMY("NAPOLIELLO.GREG@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("WHITE.ELAINE@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("WILLIAMSON.ERIC@FORUM.VA.GOV")=""
 S XMDUZ="PSO*7*217 "_JOBN
 S XMSUB="STATION "_$G(PSOINST)
 S XMSUB=XMSUB_$S($$PROD^XUPROD(1):" (Prod)",1:" (Test)")
 S XMSUB=XMSUB_" BACK BILLED COPAYS FOR PRESCRIPTION REFILLS"
 S PSOTEXT(1)="               Start time: "_PSOSTRT2
 S PSOTEXT(2)="           Completed time: "_PSOEND2
 S PSOTEXT(3)="             Elapsed Time: "_$$ETIME^PSOCPBK4(PSOTIME)
 S PSOTEXT(4)=""
 S PSOTEXT(5)="     Total RX's processed: "_$J($FN(PSOTRX,","),8)
 S PSOTEXT(6)="  Total Refills processed: "_$J($FN(PSOTRF,","),8)
 S PSOTEXT(7)="   Total billable refills: "_$J($FN(PSOTC,","),8)
 S PSOTEXT(8)="      Total billable vets: "_$J($FN(PSOVETS,","),8)
 S PSOTEXT(9)=""
 S PSOTEXT(10)=""
 S PSOTEXT(11)="Excel comma delimited data below, Two heading, one data line"
 S PSOTEXT(12)=""
 S PSOTEXT(13)=$E(("Station,Station,,2004,,,2005"_LIN),1,79)
 S PSOTEXT(14)=$E(("Name,#,30 days,60 days,90 days,30 days,60 days,90 days"_LIN),1,79)
 S PSOTEXT(15)=$E((PSOSTNM_","_PSOINST_PSOCNTS_LIN),1,79)
 S PSOTEXT(16)=""
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
 ;
MAIL3(MSG) ;management mail message
 S PSOINST=$P($G(^DIC(4,+$P($G(^XMB(1,1,"XUS")),"^",17),99)),"^")
 D NOW^%DTC S Y=% D DD^%DT S PSOEND=Y
 K PSOTEXT
 S XMY(DUZ)=""
 S XMY("NAPOLIELLO.GREG@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("WHITE.ELAINE@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("WILLIAMSON.ERIC@FORUM.VA.GOV")=""
 S XMDUZ="PSO*7*217 "_JOBN
 S XMSUB="STATION "_$G(PSOINST)
 S XMSUB=XMSUB_$S($$PROD^XUPROD(1):" (Prod)",1:" (Test)")
 S XMSUB=XMSUB_" BACK BILLED COPAYS FOR PRESCRIPTION REFILLS"
 S PSOTEXT(1)=""
 S PSOTEXT(2)="Started "_PSOSTART
 S PSOTEXT(3)=""
 S PSOTEXT(4)="   "_MSG
 S PSOTEXT(5)=""
 S PSOTEXT(6)="NO FURTHER ACTION REQUIRED."
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
 ;
MAILAAC ;send name info to AAC for mail stuffers
 N VA
 K XMY,^TMP(NAMSP)
 S PSOCNT=0
 S PSOINST=$P($G(^DIC(4,+$P($G(^XMB(1,1,"XUS")),"^",17),99)),"^")
 S XMY(DUZ)=""
 S XMY("NAPOLIELLO.GREG@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("WHITE.ELAINE@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("WILLIAMSON.ERIC@FORUM.VA.GOV")=""
 S XMDUZ="PSO*7*217 "_JOBN
 S XMSUB=$G(PSOINST)_$S($$PROD^XUPROD(1):" (Prod)",1:" (Test)")
 S XMSUB=XMSUB_" - BACK BILLED COPAYS AAC DATA"
 S PSONAM=""
 F  S PSONAM=$O(^XTMP(NAMSP,"BILLED",PSONAM)) Q:PSONAM=""  D
 .S PSODFN=""
 .F  S PSODFN=$O(^XTMP(NAMSP,"BILLED",PSONAM,PSODFN)) Q:PSODFN=""  D
 ..N DFN S DFN=PSODFN D DEM^VADPT
 ..S PSOCNT=PSOCNT+1,^TMP(NAMSP,PSOCNT)=PSOINST_"^"_$G(VA("BID"))_$E($P(PSONAM,","),1,5)
 I '$D(^TMP(NAMSP)) S ^TMP(NAMSP,1)="NO BILLED FILLS FOR INSTITUTION: "_PSOINST
 S XMTEXT="^TMP(NAMSP," N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 K ^TMP(NAMSP)
 Q
