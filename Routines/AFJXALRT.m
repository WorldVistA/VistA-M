AFJXALRT ;FO-OAKLAND/GMB-PROCESS INFO AND ALERT USER ;3/17/99  13:42
 ;;5.1;Network Health Exchange;**6,15,17,23,31,32**;Jan 23, 1996
 ; Totally rewritten 11/2001.  (Previously FJ/CWS.)
 ; ENTER - Invoked by server option AFJXSERVER
 ;
 ; DBIAs:
 ;   1092 - Call DSD^ZISPL and DSDOC^ZISPL1 (Kernel)
 ;   3587 - Read fields 2 and 9 of file 3.51 (Kernel)
 ;   3774 - Read field .04 of file 142.99 (Health Summary)
 ;   3779 - Search file 4.2, read field 1 (MailMan)
ENTER ;
 N XMZ,XMSER
 D:'$$CLOSED(XQSND) PROCESS(XQMSG) ; Ignore if sending site is closed.
 S XMSER="S.AFJXSERVER",XMZ=XQMSG D REMSBMSG^XMA1C
 Q
CLOSED(AXFROM) ; Returns 1 if sending site is closed; 0 otherwise.
 I AXFROM'["@" Q 0
 N AXDOMIEN
 S AXDOMIEN=$$FIND1^DIC(4.2,"","MX",$P($P(AXFROM,"@",2),">",1),"B^C")
 Q:'AXDOMIEN 0
 Q $$GET1^DIQ(4.2,AXDOMIEN_",",1)["C"
PROCESS(AXRQXMZ) ; Process data incoming
 N AXPID,AXSENSIT,AXDFN,AXDOMIEN,AXABORT,AXSPDOC,AXSPDATA,AXTI
 N AXRQREC,AXRQSSN,AXRQDUZ,AXRQNAME,AXRQWHEN,AXRQSITE,AXRQTYPE,AXRQFROM
 D INIT
 I 'AXABORT D
 . D GATHER
 . D TRANSFER
 D FINISH
 Q
INIT ;
 S (AXABORT,AXTI)=0
 K ^TMP("AFJX",$J)
 D ^%ZISC ; Make sure all devices are closed
 S AXRQREC=$G(^XMB(3.9,AXRQXMZ,2,1,0))
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=AXRQREC
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)="***CONFIDENTIAL Patient Data from "_^XMB("NETNAME")_"*** "_$$FMTE^XLFDT(DT,"2Z")
 S AXRQSSN=$P(AXRQREC,U,1)  ; Patient SSN
 S AXRQDUZ=$P(AXRQREC,U,2)  ; Requestor's DUZ
 S AXRQNAME=$P(AXRQREC,U,3) ; Requestor's name
 S AXRQWHEN=$P(AXRQREC,U,4) ; Date/Time request was made
 S AXRQSITE=$P(AXRQREC,U,5) ; Requestor's site
 S AXRQTYPE=$P(AXRQREC,U,6) ; Type of request
 S AXRQFROM=AXRQNAME_"@"_AXRQSITE
 S AXDOMIEN=$$FIND1^DIC(4.2,"","MX",AXRQSITE,"B^C")
 I 'AXDOMIEN D FAIL("Site not found in DOMAIN file: "_AXRQSITE) Q
 I 'AXRQSSN D FAIL("SSN not supplied.") Q
 S AXDFN=$$FIND1^DIC(2,"","X",AXRQSSN,"SSN")
 I 'AXDFN D FAIL("SSN not found in PATIENT file: "_AXRQSSN) Q
 D PERSON(AXDFN) Q:AXABORT
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=AXPID("INFO")
 D CHKSEGS Q:AXABORT
 D OPENDEV Q:AXABORT
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=""
 S AXSENSIT=+$P($G(^DGSL(38.1,AXDFN,0)),U,2)
 Q
GATHER ; Gather the requested data on the patient (it is sent to spool)
 N AXDAYS,AXABBR,AXSEG,AXCHK
 U IO
 D @AXRQTYPE ; One of "TOTAL", "PHARM", "NHBP", or "BRIEF"
 D CLOSDEV
 Q
TRANSFER ; Transfer the spool data to the temp global
 D SPL2TMP^AFJXTRF
 D DSDOC^ZISPL(AXSPDOC),DSD^ZISPL(AXSPDATA) ; Delete spool doc and data
 Q
FINISH ; Send the data and clean up.
 S AXTI=$O(^TMP("AFJX",$J,""),-1)
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=""
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=$$CJ^XLFSTR("End of CONFIDENTIAL Patient Data from "_^XMB("NETNAME"),79,"*")
 D SEND
 K ^TMP("AFJX",$J)
 I $G(AXSENSIT),'AXABORT D SENSIT
 D AUDIT
 Q
SEND ; Send the data to the requestor
 N XMZ,XMSUB,XMY,XMTEXT
 S XMSUB="Reply for <"_AXRQTYPE_"> "_$E($P($G(AXPID("NAME"),"*UNKNOWN*"),",",1),1,15)_" "_AXRQSSN_" "_^XMB("NETNAME")
 S XMY("NETWORK,HEALTH EXCHANGE@"_AXRQSITE)=""
 S XMY("S.AFJXNHDONE@"_AXRQSITE)=""
 S XMTEXT="^TMP(""AFJX"",$J,"
 D ^XMD
 Q
PERSON(DFN) ; Get personal demographic info about the patient
 N VA,VADM,VAERR
 D DEM^VADPT
 S AXPID("NAME")=VADM(1)      ; Name - last,first
 S AXPID("SSN")=$P(VADM(2),U) ; SSN  - nnnnnnnnn
 S AXPID("S-S-N")=VA("PID")   ; SSN  - nnn-nn-nnnn
 S AXPID("DOB")=$$FMTE^XLFDT(+VADM(3),"5Z")  ; Date of birth - mm/dd/yyyy
 S AXPID("INFO")=$$LJ^XLFSTR(AXPID("NAME")_"  "_AXPID("S-S-N"),55)_" DOB: "_AXPID("DOB")
 Q
OPENDEV ; Set IOP to a unique name to avoid duplicates
 N AXSPDEV
 S AXSPDEV=$$GET1^DIQ(142.99,"1,",.04)
 I AXSPDEV']"" D FAIL("Can't get spool device name from file 142.99") Q
 S (IOP,AXSPDEV)=AXSPDEV_";NHE"_AXDFN_"-"_$P($H,",",2)
 S %ZIS=0
 D ^%ZIS Q:'POP
 D ^%ZISC
 D FAIL("Can't open spool device: "_AXSPDEV)
 Q
CLOSDEV ; Close the spooler device and get device info
 ; AXSPDOC  = IEN in file 3.51 of the Spool Document
 ; AXSPDATA = IEN in file 3.519 of the Spool Data
 S AXSPDOC=IO("SPOOL")
 D ^%ZISC
 F  Q:$$GET1^DIQ(3.51,AXSPDOC_",",2,"I")="r"  H 5  ; Wait until "ready"
 S AXSPDATA=$$GET1^DIQ(3.51,AXSPDOC_",",9,"I")
 Q
CHKSEGS ; Check to see if all components exist before proceeding
 N AXSEG,AXABBR,AXCHK
 S AXCHK=1
 D @AXRQTYPE ; "TOTAL", "PHARM", "NHBP", or "BRIEF"
 Q:'$D(AXCHK("NF"))
 D FAIL("Can't find segment(s) in file 142.1: "_$E(AXCHK("NF"),2,999))
 Q
BRIEF ; MED12 - EXTRACT 12 MONTHS OF ALL SEGMENTS
 S AXDAYS=365
TOTAL ; EXTRACT ALL SEGMENTS WITH NO TIME LIMITATION
 F AXABBR="DEM","ADC","DC","DS","PRC","OPC","CVF","CVP","ADR","DI","VS","PN","RXOP","RXIV","RXUD","BT","CH","MIC","SP","CY","MEDS","IP","IS","SR","CW","CN","DCS","ORC","CP","NSR","ONC" D EXTRACT
 Q
NHBP ; PHAR12 - EXTRACT 12 MONTHS OF PHARMACY INFORMATION
 S AXDAYS=365
PHARM ; EXTRACT THE WHOLE PHARMACY
 F AXABBR="DEM","ADR","RXOP","RXIV","RXUD" D EXTRACT
 Q
EXTRACT ; Extract one component
 S AXSEG=$$FIND1^DIC(142.1,"","OX",AXABBR,"C")
 I $G(AXCHK) S:'AXSEG AXCHK("NF")=$G(AXCHK("NF"))_","_AXABBR Q
 N DFN,GMTSEG,GMTSEGI,GMTSEGC,GMTSTITL,GMTSDLM,GMTSNDM
 S DFN=AXDFN,GMTSDLM=$G(AXDAYS),GMTSTITL="NHE EXTRACT"
 S GMTSEG(1)="1^"_AXSEG_"^^"_GMTSDLM_"^^N^L^Y"
 S (GMTSEGI(AXSEG),GMTSEGC)=1
 D EN^GMTS1
 Q
FAIL(AXERR) ; Note the error.
 S AXABORT=1
 S AXTI=$O(^TMP("AFJX",$J,""),-1)
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=""
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=$$CJ^XLFSTR(" PROBLEM REPORT ",79,"-")
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=""
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)="We couldn't process your NHE request, because of the following problem:"
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=""
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=AXERR
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=""
 S AXTI=AXTI+1,^TMP("AFJX",$J,AXTI,0)=$$REPEAT^XLFSTR("-",79)
 Q
SENSIT ; Data for sensitive patient was accessed,
 ; so notify DG SENSITIVITY MAILGROUP
 N XMZ,XMSUB,XMTEXT,XMY,AXTEXT,AXGRP,XMDUZ,AXNHEDUZ
 S AXNHEDUZ=$$FIND1^DIC(200,"","X","NETWORK,HEALTH EXCHANGE","B")
 I 'AXNHEDUZ S AXNHEDUZ=.5
 S AXTEXT(1)=$$REPEAT^XLFSTR("@",48)
 S AXTEXT(2)=$$CJ^XLFSTR("SENSITIVE PATIENT DATA REQUESTED",48)
 S AXTEXT(3)=$$REPEAT^XLFSTR("@",48)
 S AXTEXT(4)=""
 S AXTEXT(5)="Data for SENSITIVE patient: "_AXPID("NAME")_"  "_AXRQSSN
 S AXTEXT(6)="has been requested by:  "_AXRQFROM
 S AXGRP=$$GET1^DIQ(43,"1,",509)
 I AXGRP'="" S XMY("G."_AXGRP)="" ;CFB/SF/TUSC MOD TO USE MAS PAT SENSIT MG.
 S XMSUB="NETWORK HEALTH EXCHANGE REQUESTED FOR SENSITIVE PATIENT"
 S XMY(AXNHEDUZ)=""
 S XMTEXT="AXTEXT("
 S XMDUZ=.5
 D ^XMD
 Q
AUDIT ;
 N AXSUCCES
 S AXSUCCES=$S(AXABORT:"N",1:"Y")
 I $D(^AFJ(537000,"B",AXRQXMZ)) D DUPLI Q
 D NEW
 Q
DUPLI ; Look for the same message number to avoid duplicate tracking entries
 N AXIEN
 S AXIEN=""
 F  S AXIEN=$O(^AFJ(537000,"B",AXRQXMZ,AXIEN)) Q:AXIEN=""  D
 . N DIE,DA,DR
 . S DIE="^AFJ(537000,"
 . S DA=AXIEN
 . S DR="9////"_AXSUCCES_";10////"_+$G(AXSENSIT)_";12////"_$$NOW^XLFDT
 . D ^DIE
 Q
NEW ;
 N DIC,X,Y,DLAYGO,DD,DO
 S DIC="^AFJ(537000,",DLAYGO=537000
 S DIC(0)="L"
 S X=AXRQXMZ
 S DIC("DR")="1////"_AXRQWHEN_";2////"_AXRQTYPE_";3////"_AXRQSSN_";6////"_AXRQDUZ_";7////"_AXRQNAME_";8////"_AXDOMIEN_";9////"_AXSUCCES_";10////"_+$G(AXSENSIT)_";12////"_$$NOW^XLFDT
 D FILE^DICN
 Q
