PSOCIDC4 ;BIR/LE - continuation of Copay Correction of erroneous billed copays ;11/08/05 1:56pm
 ;;7.0;OUTPATIENT PHARMACY;**226**;DEC 1997
 ;
MAIL ;user mail message
 N TOTAMT,TOTUAMT,TOTCAMT,PSOCXPDA,PSOCHRG
 D NOW^%DTC S Y=% D DD^%DT S PSOEND=Y
 S PSOEND2=$$FMTE^XLFDT(%,"1PS")
 I $G(DUZ) S XMY(DUZ)=""
 S XMDUZ="PSO*7*226 "_JOBN
 S XMSUB="Outpatient Pharmacy PSO*7*226 "_JOBN
 S XMY("ELLZEY.LINDA@FORUM.VA.GOV")=""
 F PSOCXPDA=0:0 S PSOCXPDA=$O(^XUSEC("PSO COPAY",PSOCXPDA)) Q:'PSOCXPDA  S XMY(PSOCXPDA)=""
 I $O(XMY(""))="" Q  ; no recipients for mail message
 S PSOTEXT(1)="The Rx "_JOBN_" job for the Outpatient Pharmacy patch (PSO*7*226)"
 S PSOTEXT(2)="started "_PSOSTART_" and completed "_PSOEND_"."
 S PSOTEXT(3)=" "
 I PSOCCNT=0 S PSOTEXT(4)="No erroneously billed copay fills were found."
 I PSOCNT=0 S PSOTEXT(5)="No released prescriptions were found that needed IBQ node corrections."
 I PSOUCNT=0 S PSOTEXT(6)="No un-released prescription were found that needed IBQ node corrections."
 I PSOCNT>0!(PSOUCNT>0)!(PSOCCNT>0) D
 . S (TOTUAMT,TOTAMT,TOTCAMT)=0
 . F XX="YR2004","YR2005","YR2006" D
 .. S PSOCHRG=7 S:XX="YR2006" PSOCHRG=8
 .. F YY=1:1:3 S PSOAMT(XX,YY)=PSOCNT(XX,YY)*YY*PSOCHRG,TOTAMT=TOTAMT+PSOAMT(XX,YY)
 .. F YY=1:1:3 S PSOUAMT(XX,YY)=PSOUCNT(XX,YY)*YY*PSOCHRG,TOTUAMT=TOTUAMT+PSOUAMT(XX,YY)
 .. F YY=1:1:3 S PSOCAMT(XX,YY)=PSOCCNT(XX,YY)*YY*PSOCHRG,TOTCAMT=TOTCAMT+PSOCAMT(XX,YY)
 . S PSOTEXT(4)="Erroneously billed prescriptions and copay related fields have been corrected."
 . S PSOTEXT(5)="There were "_$FN(PSOCNT,",")_" released fills successfully updated for "_$FN(PSOVETS,",")_" veterans."
 . S PSOTEXT(6)=" "
 . S PSOTEXT(7)="Released fills corrected by year:"
 . S PSOTEXT(8)="2004  30-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2004",1),6)
 . S PSOTEXT(8)=PSOTEXT(8)_"     $"_$J($FN(PSOAMT("YR2004",1),","),9)
 . S PSOTEXT(9)="2004  60-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2004",2),6)
 . S PSOTEXT(9)=PSOTEXT(9)_"     $"_$J($FN(PSOAMT("YR2004",2),","),9)
 . S PSOTEXT(10)="2004  90-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2004",3),6)
 . S PSOTEXT(10)=PSOTEXT(10)_"     $"_$J($FN(PSOAMT("YR2004",3),","),9)
 . S PSOTEXT(11)=""
 . S PSOTEXT(12)="2005  30-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2005",1),6)
 . S PSOTEXT(12)=PSOTEXT(12)_"     $"_$J($FN(PSOAMT("YR2005",1),","),9)
 . S PSOTEXT(13)="2005  60-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2005",2),6)
 . S PSOTEXT(13)=PSOTEXT(13)_"     $"_$J($FN(PSOAMT("YR2005",2),","),9)
 . S PSOTEXT(14)="2005  90-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2005",3),6)
 . S PSOTEXT(14)=PSOTEXT(14)_"     $"_$J($FN(PSOAMT("YR2005",3),","),9)
 . S PSOTEXT(15)=""
 . S PSOTEXT(16)="2006  30-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2006",1),6)
 . S PSOTEXT(16)=PSOTEXT(16)_"     $"_$J($FN(PSOAMT("YR2006",1),","),9)
 . S PSOTEXT(17)="2006  60-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2006",2),6)
 . S PSOTEXT(17)=PSOTEXT(17)_"     $"_$J($FN(PSOAMT("YR2006",2),","),9)
 . S PSOTEXT(18)="2006  90-DAY EQUIVALENT FILLS: "_$J(PSOCNT("YR2006",3),6)
 . S PSOTEXT(18)=PSOTEXT(18)_"     $"_$J($FN(PSOAMT("YR2006",3),","),9)
 . S PSOTEXT(19)="                                          =========="
 . S PSOTEXT(20)="                                    TOTAL $"_$J($FN(TOTAMT,","),9)
 . S PSOTEXT(21)=" "
 . S PSOTEXT(22)="Out of the above total, there were "_$FN(PSOCCNT,",")_" cancelled copays for "_$FN(PSOCVETS,",")_" veterans."
 . S PSOTEXT(23)=" "
 . S PSOTEXT(24)="COPAY cancelled fills by year:"
 . S PSOTEXT(25)="2004  30-DAY EQUIVALENT FILLS: "_$J(PSOCCNT("YR2004",1),6)
 . S PSOTEXT(25)=PSOTEXT(25)_"     $"_$J($FN(PSOCAMT("YR2004",1),","),9)
 . S PSOTEXT(26)="2004  60-DAY EQUIVALENT FILLS: "_$J(PSOCCNT("YR2004",2),6)
 . S PSOTEXT(26)=PSOTEXT(26)_"     $"_$J($FN(PSOCAMT("YR2004",2),","),9)
 . S PSOTEXT(27)="2004  90-DAY EQUIVALENT FILLS: "_$J(PSOCCNT("YR2004",3),6)
 . S PSOTEXT(27)=PSOTEXT(27)_"     $"_$J($FN(PSOCAMT("YR2004",3),","),9)
 . S PSOTEXT(28)=""
 . S PSOTEXT(29)="2005  30-DAY EQUIVALENT FILLS: "_$J(PSOCCNT("YR2005",1),6)
 . S PSOTEXT(29)=PSOTEXT(29)_"     $"_$J($FN(PSOCAMT("YR2005",1),","),9)
 . S PSOTEXT(30)="2005  60-DAY EQUIVALENT FILLS: "_$J(PSOCCNT("YR2005",2),6)
 . S PSOTEXT(30)=PSOTEXT(30)_"     $"_$J($FN(PSOCAMT("YR2005",2),","),9)
 . S PSOTEXT(31)="2005  90-DAY EQUIVALENT FILLS: "_$J(PSOCCNT("YR2005",3),6)
 . S PSOTEXT(31)=PSOTEXT(31)_"     $"_$J($FN(PSOCAMT("YR2005",3),","),9)
 . S PSOTEXT(32)=" "
 . S PSOTEXT(33)="2006  30-DAY EQUIVALENT FILLS: "_$J(PSOCCNT("YR2006",1),6)
 . S PSOTEXT(33)=PSOTEXT(33)_"     $"_$J($FN(PSOCAMT("YR2006",1),","),9)
 . S PSOTEXT(34)="2006  60-DAY EQUIVALENT FILLS: "_$J(PSOCCNT("YR2006",2),6)
 . S PSOTEXT(34)=PSOTEXT(34)_"     $"_$J($FN(PSOCAMT("YR2006",2),","),9)
 . S PSOTEXT(35)="2006  90-DAY EQUIVALENT FILLS: "_$J(PSOCCNT("YR2006",3),6)
 . S PSOTEXT(35)=PSOTEXT(35)_"     $"_$J($FN(PSOCAMT("YR2006",3),","),9)
 . S PSOTEXT(36)="                                          =========="
 . S PSOTEXT(37)="                                    TOTAL $"_$J($FN(TOTCAMT,","),9)
 . S PSOTEXT(38)=" "
 . S PSOTEXT(39)="There were "_$FN(PSOUCNT,",")_" unreleased fills successfully updated for "_$FN(PSOUVETS,",")_" veterans."
 . S PSOTEXT(40)=" "
 . S PSOTEXT(41)="Unreleased fills corrected by year:"
 . S PSOTEXT(42)="2004  30-DAY EQUIVALENT FILLS: "_$J(PSOUCNT("YR2004",1),6)
 . S PSOTEXT(42)=PSOTEXT(42)_"     $"_$J($FN(PSOUAMT("YR2004",1),","),9)
 . S PSOTEXT(43)="2004  60-DAY EQUIVALENT FILLS: "_$J(PSOUCNT("YR2004",2),6)
 . S PSOTEXT(43)=PSOTEXT(43)_"     $"_$J($FN(PSOUAMT("YR2004",2),","),9)
 . S PSOTEXT(44)="2004  90-DAY EQUIVALENT FILLS: "_$J(PSOUCNT("YR2004",3),6)
 . S PSOTEXT(44)=PSOTEXT(44)_"     $"_$J($FN(PSOUAMT("YR2004",3),","),9)
 . S PSOTEXT(45)=""
 . S PSOTEXT(46)="2005  30-DAY EQUIVALENT FILLS: "_$J(PSOUCNT("YR2005",1),6)
 . S PSOTEXT(46)=PSOTEXT(46)_"     $"_$J($FN(PSOUAMT("YR2005",1),","),9)
 . S PSOTEXT(47)="2005  60-DAY EQUIVALENT FILLS: "_$J(PSOUCNT("YR2005",2),6)
 . S PSOTEXT(47)=PSOTEXT(47)_"     $"_$J($FN(PSOUAMT("YR2005",2),","),9)
 . S PSOTEXT(48)="2005  90-DAY EQUIVALENT FILLS: "_$J(PSOUCNT("YR2005",3),6)
 . S PSOTEXT(48)=PSOTEXT(48)_"     $"_$J($FN(PSOUAMT("YR2005",3),","),9)
 . S PSOTEXT(49)=" "
 . S PSOTEXT(50)="2006  30-DAY EQUIVALENT FILLS: "_$J(PSOUCNT("YR2006",1),6)
 . S PSOTEXT(50)=PSOTEXT(50)_"     $"_$J($FN(PSOUAMT("YR2006",1),","),9)
 . S PSOTEXT(51)="2006  60-DAY EQUIVALENT FILLS: "_$J(PSOUCNT("YR2006",2),6)
 . S PSOTEXT(51)=PSOTEXT(51)_"     $"_$J($FN(PSOUAMT("YR2006",2),","),9)
 . S PSOTEXT(52)="2006  90-DAY EQUIVALENT FILLS: "_$J(PSOUCNT("YR2006",3),6)
 . S PSOTEXT(52)=PSOTEXT(52)_"     $"_$J($FN(PSOUAMT("YR2006",3),","),9)
 . S PSOTEXT(53)="                                          =========="
 . S PSOTEXT(54)="                                    TOTAL $"_$J($FN(TOTUAMT,","),9)
 . S PSOTEXT(55)=" "
 . S PSOTEXT(56)="To get a report of patients/prescriptions that were affected as"
 . S PSOTEXT(57)="part of this process, contact your IRM to enter D RPT^PSOCIDC3 at"
 . S PSOTEXT(58)="the programmer's prompt."
 ;
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
 ;
MAIL2 ;management mail message
 N J,I,LIN
 S LIN="",$P(LIN," ",85)=""
 D NOW^%DTC S PSOTIME=$$FMDIFF^XLFDT(%,$G(PSOS1),2)
 S PSOINST=$P($G(^DIC(4,+$P($G(^XMB(1,1,"XUS")),"^",17),99)),"^")
 S PSOSTNM=$P($G(^DIC(4,PSOINST,0)),"^")
 K PSOTEXT
 K PSOUTC,PSOTC,PSOCTC,PSOUCNTS,PSOCCNTS,PSOCNTS
 I $G(DUZ) S XMY(DUZ)=""
 S (PSOUTC,PSOTC,PSOCTC)=0,(PSOUCNTS,PSOCNTS,PSOCCNTS)=""
 F J="YR2004","YR2005","YR2006" F I=1:1:3 D
 .S PSOTC=PSOTC+$G(PSOCNT(J,I))
 .S PSOCNTS=PSOCNTS_","_$G(PSOCNT(J,I))
 F J="YR2004","YR2005","YR2006" F I=1:1:3 D
 .S PSOUTC=PSOUTC+$G(PSOUCNT(J,I))
 .S PSOUCNTS=PSOUCNTS_","_$G(PSOUCNT(J,I))
 F J="YR2004","YR2005","YR2006" F I=1:1:3 D
 .S PSOCTC=PSOCTC+$G(PSOCCNT(J,I))
 .S PSOCCNTS=PSOCCNTS_","_$G(PSOCCNT(J,I))
 S XMY("ELLZEY.LINDA@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("ELLZEY.LINDA@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("G.BILLING AWARENESS@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("G.PATCHES@FORUM.VA.GOV")=""
 S XMDUZ="PSO*7*226 "_JOBN
 S XMSUB="STATION "_$G(PSOINST)
 S XMSUB=XMSUB_$S($$PROD^XUPROD(1):" (Prod)",1:" (Test)")
 S XMSUB=XMSUB_" Summary of updates FOR PRESCRIPTION FILLS"
 S PSOTEXT(1)="               Start time: "_PSOSTRT2
 S PSOTEXT(2)="           Completed time: "_PSOEND2
 S PSOTEXT(3)="             Elapsed Time: "_$$ETIME^PSOCIDC3(PSOTIME)
 S PSOTEXT(4)=""
 S PSOTEXT(5)="               Total RX's processed: "_$J($FN(PSOTRX,","),8)
 S PSOTEXT(6)="            Total Refills processed: "_$J($FN(PSOTRF,","),8)
 S PSOTEXT(7)="     Total released fills corrected: "_$J($FN(PSOTC,","),8)
 S PSOTEXT(8)="            Total cancelled refills: "_$J($FN(PSOCTC,","),8)
 S PSOTEXT(9)="   Total unreleased fills corrected: "_$J($FN(PSOUTC,","),8)
 S PSOTEXT(10)="               Total number of vets: "_$J($FN(PSOVETS,","),8)
 S PSOTEXT(11)=""
 S PSOTEXT(12)=""
 S PSOTEXT(13)="Excel comma delimited data below, Two heading, three data line"
 S PSOTEXT(14)=""
 S PSOTEXT(15)=$E(("Type of,Station,Station,,2004,,,2005,,,2006"_LIN),1,85)
 S PSOTEXT(16)=$E(("Rx,Name,#,30 days,60 days,90 days,30 days,60 days,90 days,30 days,60 days,90 days"_LIN),1,85)
 S PSOTEXT(17)=$E(("Released"_","_PSOSTNM_","_PSOINST_PSOCNTS_LIN),1,85)
 S PSOTEXT(18)=$E(("Cancelled Copays"_","_PSOSTNM_","_PSOINST_PSOCCNTS_LIN),1,85)
 S PSOTEXT(19)=$E(("Un-released"_","_PSOSTNM_","_PSOINST_PSOUCNTS_LIN),1,85)
 S PSOTEXT(20)=""
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
 ;
