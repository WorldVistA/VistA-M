RMPREXDS ;PHX/HNB -National Data Extract Pros Disability Codes - 10/30/96
 ;;3.0;PROSTHETICS;**18**;Feb 09, 1996
 ;can't enter from top
 Q
EN(RMPRDT1,RMPRDT2) ;entry point
 ;send message to chief prosthetics notify of activation
 D NOT
 S RMPRB=0,CNT=1
 K ^TMP($J),^TMP("RMPR",$J),^TMP("RMPRF",$J)
 F  S RMPRB=$O(^RMPR(660,"B",RMPRB)) Q:(RMPRB>RMPRDT2)!(RMPRB'>0)  D
 .Q:RMPRB<RMPRDT1
 .S RMPRA=0
 .F  S RMPRA=$O(^RMPR(660,"B",RMPRB,RMPRA)) Q:RMPRA'>0  D
 . .S DFN=$P($G(^RMPR(660,RMPRA,0)),U,2)
 . .Q:DFN=""
 . .Q:$D(^TMP("RMPR",$J,DFN))
 . .;leave out historical records
 . .Q:$P(^RMPR(660,RMPRA,0),U,15)
 . .S STN=$P(^RMPR(660,RMPRA,0),U,10)
 . .Q:STN=""
 . .S STN=$P($G(^DIC(4,STN,99)),U,1)
 . .Q:STN=""
 . .D SSN
 . .D DS
 . .D CK
 D:$D(^TMP($J)) MAIL1
 D MAILS
 Q
DS ;patients disability codes/records
 Q:$D(^TMP("RMPR",$J,DFN))
 D GETS^DIQ(665,DFN_",","**","","RDIS")
 MERGE R19=RDIS(665.01)
 K RDIS
 Q:'$D(R19)
 S B1=0
 F  S B1=$O(R19(B1)) Q:B1=""  D
 .S B2=0
 .F  S B2=$O(R19(B1,B2)) Q:B2=""  D
 . .;format for mailman ^TMP($J,counter)=station number^ssn^field^value
 . .Q:B2=1
 . .Q:B2>5
 . .S ^TMP($J,CNT)=STN_U_RMPRSSN_U_B2_U_R19(B1,B2)
 . .S ^TMP("RMPR",$J,DFN)=""
 . .S CNT=CNT+1
 K R19,RMPRSSN,STN
 Q
SSN ;pull ssn
 D DEM^VADPT
 S RMPRSSN=+VADM(2)
 K VADM
 Q
NOT ;send notificaton to mail group
 S Y=RMPRDT1 D DD^%DT S RMPRDAT1=Y
 S Y=RMPRDT2 D DD^%DT S RMPRDAT2=Y
 S XMDUZ=.5
 S XMY("G.RMPR SERVER")=""
 S XMSUB="Prosthetics Data Extract "_RMPRDAT1_" to "_RMPRDAT2
 S RMPRMSG(1)="The National Data Server has been activated today by Prosthetics HQ."
 S RMPRMSG(2)="Data has been collected for the date range "_RMPRDAT1_" to "_RMPRDAT2_"."
 S RMPRMSG(3)="Disability Code information will be transmitted."
 S RMPRMSG(4)="This was activated by "_$P(XMFROM,"@",1)
 S RMPRMSG(5)=""
 S XMTEXT="RMPRMSG("
 D ^XMD
 K RMPRMSG,RMPRDAT1,RMPRDAT2
 Q
CK ;check line length to send
 I CNT>4999 D MAIL1 S CNT=1 Q
 Q
MAIL1 ;send message
 S XMTEXT="^TMP($J,"
 S XMDUZ=.5
 S XMY("G.PROSTHETICS@PSAS.MED.VA.GOV")=""
 S XMSUB="PSAS National Extract From "_$P($$SITE^VASITE,U,2)
 D ^XMD S RMPRXMZ(XMZ)=XMZ
 K ^TMP($J)
 Q
MAIL ;send it
 S CNT=1
 F  S RMPRA=$O(^TMP($J,RMPRA)) Q:RMPRA=""  D
 .S ^TMP("RMPRF",$J,CNT)=^TMP($J,RMPRA)
 .K ^TMP($J,RMPRA)
 .S CNT=CNT+1
 .I CNT>4999 D
 . .S XMTEXT="^TMP(""RMPRF"",$J,"
 . .S XMDUZ=.5
 . .S XMY("G.PROSTHETICS@PSAS.MED.VA.GOV")=""
 . .S XMSUB="PSAS National Extract From "_$P($$SITE^VASITE,U,2)
 . .D ^XMD K ^TMP("RMPRF",$J) S RMPRXMZ(XMZ)=XMZ,CNT=1
 S XMTEXT="^TMP(""RMPRF"",$J,"
 S XMDUZ=.5
 S XMY("G.PROSTHETICS@PSAS.MED.VA.GOV")=""
 S XMSUB="PSAS National Extract From "_$P($$SITE^VASITE,U,2)
 D ^XMD K ^TMP("RMPRF",$J) S RMPRXMZ(XMZ)=XMZ
MAILS ;mail summary message
 Q:'$D(RMPRXMZ)
 S RMPRB=0,RMPRTOT=0
 F  S RMPRB=$O(^TMP("RMPR",$J,RMPRB)) Q:RMPRB=""  S RMPRTOT=RMPRTOT+1
 S XMTEXT="RMPRXMZ("
 S RMPRXMZ(1)="Total Number of Unique SSN's for this site: "_RMPRTOT
 S XMDUZ=.5
 S XMY("G.PROSTHETICS@PSAS.MED.VA.GOV")=""
 S XMSUB="PSAS Summary National Extract From "_$P($$SITE^VASITE,U,2)
 D ^XMD
 ;END
