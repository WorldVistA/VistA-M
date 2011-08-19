RMPRESRV ;PHX/HNC - SERVER ROUTINE FOR NATIONAL DATA EXTRACT ; 1/19/2005
 ;;3.0;PROSTHETICS;**12,18,24,51,59,103,125**;Feb 09, 1996;Build 21
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;DBIA # 10072 - for routine REMSBMSG^XMA1C
 ;
 ;HCPCS SERVER - patch 103, HNC 1/19/2005
 ;
 ;modified to include the PIP extract 9/28/00
 X XMREC D
 .;disability codes
 .I XMRG["DS1" S RMPRDS1=$P(XMRG,"*",2)
 .I XMRG["DS2" S RMPRDS2=$P(XMRG,"*",4)
 .;new and repair worksheets
 .I XMRG["DT1" S RMPRDT1=$P(XMRG,"*",2)
 .I XMRG["DT2" S RMPRDT2=$P(XMRG,"*",4)
 .;suspense delayed order report
 .I XMRG["DOR1" S RMPRDOR1=$P(XMRG,"*",2)
 .I XMRG["DOR1" S RMPRDORS=$P(XMRG,"*",3)
 .I XMRG["DOR1" S RMPRDORW=$P(XMRG,"*",4)
 .I XMRG["DOR1" D A1^RMPR9DO("00","99","ALL",RMPRDORS,RMPRDOR1,RMPRDORW) S XMSER="S."_XQSOP,XMZ=XQMSG D REMSBMSG^XMA1C Q
 ;new items to file 661.1
 I XMRG="ITEM SERVER 661.1" G EN^RMPRET
 ;retransmit a date for patient notification patch 125
 I XMRG="RETRANS NOTIFICATION INFO" D  G IN1^RMPRDVN
 . X XMREC S BDATE=$P(XMRG,"*",2)
 . ;Send message to local VAMC staff and to PCM VACO Staff on Outlook
 . S XMDUZ=.5
 . S XMY("G.RMPR SERVER")=""
 . S XMY("VHACOPSASPIPReport@med.va.gov")=""
 . S XMSUB="Retransmit Patient Notification Data "_$P($$SITE^VASITE,U,2)
 . S RMPRMSG(1)="The National PSAS Server has been activated today by Prosthetics HQ."
 . S RMPRMSG(2)="Please note data for Patient Notification was not received"
 . S RMPRMSG(3)=""
 . S RMPRMSG(4)="This was activated by "_$P(XMFROM,"@",1)
 . S RMPRMSG(5)=""
 . S XMTEXT="RMPRMSG("
 . D ^XMD
 . ;call routine to gather data
 . Q
 ;pip EXCEL extract
 I $P(XMRG,"*",1)="PIP ROLL-UP" S RMPRPIP1=$P(XMRG,"*",2),RMPRPIP2=$P(XMRG,"*",3) G ^RMPR5HQ1
 ;pip REPORT extract
 I $P(XMRG,"*",1)="PIP REPORT" S RMPRPIP1=$P(XMRG,"*",2),RMPRPIP2=$P(XMRG,"*",3),RMPRDET=$P(XMRG,"*",4) G ^RMPR5HQA
 ;open obligations
 I XMRG="PR2" G PR2^RMPREXT
 I $D(RMPRDS1)&($D(RMPRDS2)) D EN^RMPREXDS(RMPRDS1,RMPRDS2) G EXIT
 I '$D(RMPRDT1)!('$D(RMPRDT2)) G EXIT
 ;dates for message subject
 S Y=RMPRDT1 D DD^%DT S RMPRDAT1=Y
 S Y=RMPRDT2 D DD^%DT S RMPRDAT2=Y
 ;send message to group so they know the server was activated
 S XMDUZ=.5
 S XMY("G.RMPR SERVER")=""
 S XMSUB="Prosthetics Data Extract "_RMPRDAT1_" to "_RMPRDAT2
 S RMPRMSG(1)="The National Data Server has been activated today by Prosthetics HQ."
 S RMPRMSG(2)="Data has been collected for the date range "_RMPRDAT1_" to "_RMPRDAT2_"."
 S RMPRMSG(3)=""
 S RMPRMSG(4)="This was activated by "_$P(XMFROM,"@",1)
 S RMPRMSG(5)=""
 S XMTEXT="RMPRMSG("
 D ^XMD
 ;refresh amis codes in file 660
 D ^RMPREXR
 ;gather and send the raw data
 ;add additional extract here if needed
 D EN1^RMPREXT
EXIT ;common exit point
 S XMSER="S."_XQSOP,XMZ=XQMSG D REMSBMSG^XMA1C
 K RMPRDAT1,RMPRDAT2,RMPRDT1,XMRG,XMSUB
 K RMPRDET,RMPRDOR1,RMPRDORS,RMPRDORW,RMPRDS1,RMPRDS2,RMPRDT2,RMPRMSG
 K RMPRPIP1,RMPRPIP2,XMDUZ,XMFROM,XMREC,XMSER,XMTEXT,XMY,XMZ,XQMSG,XQSOP,Y
 ;END
