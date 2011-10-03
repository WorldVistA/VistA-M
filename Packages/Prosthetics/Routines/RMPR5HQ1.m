RMPR5HQ1 ;HCIOFO/RVD - USAGE REPORT FOR HQ ; 04 AUG 00
 ;;3.0;PROSTHETICS;**51**;Feb 09, 1996
TASK ;task the option to create a mail message to PSAS HQ.
 ;PIP data will come from a ^TMP( global.
 ;variables rmprpip1 and rmprpip2 are date range from the server.
 Q:RMPRPIP2<RMPRPIP1
 S X1=RMPRPIP2,X2=RMPRPIP1
 D ^%DTC S RMCALDAY=X+1
 D NATION^RMPR5HQ5
 D PROC
 D CLEAN
 Q
 ;
PROC ;process the PIP reports and e-mail to NPPD DATABASE
 S RMQMAIL=$$GETADDR()
 S RMQSUBJ="Prosthetics PIP Extract"
 S Y=RMPRPIP1 D DD^%DT S RMBDT=Y
 S Y=RMPRPIP2 D DD^%DT S RMEDT=Y
 S RD=$O(^TMP($J,"RMPR5A",0))
 D SEND(RMQMAIL,RMQSUBJ) G:$D(RQUIT) CLEAN
 ;S RMQMES=XMZ
 D SENDCONF(RMQSUBJ,RMBDT,RMEDT) G:$D(RQUIT) CLEAN
 F RI=0:0 S RI=$O(^RMPR(669.9,RI)) Q:RI'>0  S $P(^RMPR(669.9,RI,"INV"),U,5)=DT
 Q
 ;
SEND(RMQMAIL,RMQSUBJ) ; Send mail from ^TMP($J,"RMPR5A")
 ; Send mail to defined recipient(s) in RMQMAIL
 S XMSUB=RMQSUBJ_" from "_$P($$SITE^VASITE,U,2),XMDUZ=.5
 S X=RMQMAIL,XMY(X)=""
 S XMTEXT="^TMP($J,""RMPR5A"","
 D ^XMD
 Q
 ;
SENDCONF(RMQSUBJ,RMBDT,RMEDT) ; Send Confirmation to User
 ;
 K ^TMP($J,"CONFIRM")
 S XMSUB=RMQSUBJ,XMDUZ=.5,XMY("G.RMPR SERVER")=""
 S X(1)="The Prosthetics PIP Inventory Data was transmitted to PSAS HQ today."
 S X(2)="The dates used for Days On-Hand, and Days Average Usage Rate calculations"
 S X(3)="were "_RMBDT_" to "_RMEDT_"."
 S X(4)=""
 S X(5)="The server was activated by "_$P(XMFROM,"@",1)
 S Y=""
 F  S Y=$O(X(Y)) Q:Y=""  D
 .S ^TMP($J,"CONFIRM",Y)=X(Y)
 S XMTEXT="^TMP($J,""CONFIRM"","
 D ^XMD
 Q
 ;
NOADDR() ;print a No Address message in the screen.
 W !!,"No HQ mail address is defined in your PROSTHETICS SITE"
 W !,"  PARAMETERS file for the PIP report.  The PIP report"
 W !,"  will not be run.  Please contact your system administrator"
 W !,"  or enter a NOIS in Forum for the NVS Team.",!!
 S RQUIT="^"
 Q
 ;
GETADDR() ;get PSAS HQ e-mail address from #669.9
 N RMA,RI
 F RI=0:0 S RI=$O(^RMPR(669.9,RI)) Q:RI'>0  S RMA=$P($G(^RMPR(669.9,RI,"INV")),U,4) Q:RMA'=""
 Q RMA
 ;
ADDHQ ;update HQ MAIL ADDRESS & VISN in file 669.9
 S DIE="^RMPR(669.9,",DR="38////^S X=""VHACOPSASPIPReport@med.va.gov"""
 F RI=0:0 S RI=$O(^RMPR(669.9,RI)) Q:RI'>0  S DA=RI D ^DIE
 K RI,DIE,DA,DR
 Q
 ;
CLEAN ; Clean
 I $D(ZTQUEUED) S ZTREQ="@" Q
 N RMPR,RMPRSITE
 K ^TMP($J)
 Q
