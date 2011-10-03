FBMRASV2 ;AISC/TET - Server routine (Cont'd) ;8/29/97
 ;;3.5;FEE BASIS;**9**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EXIT S XMSER="S."_XQSOP,XMZ=XQMSG D REMSBMSG^XMA1C
 K I,XMER,XMRG,FBI,FBID,FBER,FBERR,FBSITE,FBPOP,FBSN,FBAASN,FBJ,FBRT,FBAC,FBSTN,FBVID,FBCHAIN,FBFEEO,FBVNAME,FBADD1,FBADD2,FBCITY,FBST,FBZIP,FBMRC,FBCC,FBPC,FBTID,FB1099,FBVT,FBICN,FBSC,FBPART,FBSTATE,FBICN1,K,DIE,DA,DR,X,DLAYGO
 K FBOGN,DIC,FBNGN,%X,%Y,DIK,FBTMP,FBMRA,FBCNT,FBATOT,FBCTOT,FBFTOT,FBQTOT,FBZIP1,FBCHK,FBOUT,XMSER,XMZ,^TMP("FBMRA",$J),^TMP("FBER",$J)
 Q
EDIT ;edit check if fbac=q
 ;INPUT:  FBAC = action code; should only come here if = 'Q'
 ;        FBVID = vendor tax id number
 ;        FBCHAIN = chain store (optional - only if pharmacy record type)
 ;        FBICN = internal control number
 ;        FBVNAME = vendor name from autsin transmission
 ;OUTPUT: FBAC may be changed from 'Q' to 'C' if id's have not changed,
 ;         or if venid exists on file and austin name matches FBVNAME
 ;         to avoid leaving duplicate vendors in site's vendor file. 
 ;VAR:  FBI = internal entry of vendor in vendor file with same id as FBVID
 ;  FBVC = internal entry of vendor in vendor correction file (with station number stripped)
 N FBI,FBVCI S FBI=0,FBVCI=$E(FBICN,4,$L(FBICN))
 S:FBVID=$P($G(^FBAAV(+FBVCI,0)),U,2) FBAC="C" I FBAC="Q" S FBI=$O(^FBAAV("C",FBVID,0)) I FBI,FBVNAME=$P($G(^FBAAV(FBI,"AMS")),U) S FBAC="C"
 Q
TRAP ;trap error, have bulletin message record error, send server message to group and reset trap to server error trap and exit.
 D @^%ZOSF("ERRTN")
 S XQSTXT(0)=""
 S XQSTXT(1)="*** Error detected by FEE while processing the above server message. ***"
 S XQSTXT(2)="Details recorded in the Kernel error trap."
 S XQSTXT(3)="Please contact your IRM representative immediately."
 S XQSTXT(4)="",XQSTXT(5)="The above message # has been forwarded to the FEE mail group."
 S XQSTXT(6)="Once the problem has been identified AND corrected, forward the server message"
 S XQSTXT(7)=$S($G(FBPAID):"  to S.FBAA PAID SERVER",1:"  to S.FBAA MRA SERVER")_" server to complete processing."
 ;S %ZTERLGR=$$LGR^%ZOSV D ^%ZTER
 ;S X="ERROR^XQSRV2",@^%ZOSF("TRAP")
SEND K XMY S XMY("G.FEE")="" D ENT1^XMD ;send message to be processed
 D EXIT
 Q
MSG ;set up server bulletin upon successful completion of processing
 S XQSTXT(0)="",XQSTXT(1)="Total Vendor MRA's Received: "_(FBATOT+FBCTOT+FBFTOT+FBQTOT)_"     Processed: "_FBCNT_"     Errors: "_FBER
 S XQSTXT(2)="ADDS: "_FBATOT,XQSTXT(3)="CHANGES:  "_FBCTOT,XQSTXT(4)="UNSOLICITED ADDS: "_FBQTOT,XQSTXT(5)="FPDS-ONLY CHANGES:  "_FBFTOT
 I +FBER S XQSTXT(6)="",XQSTXT(7)="*** "_FBER_" Error"_$S(FBER>1:"s",1:"")_" detected by FEE while processing the above server message. ***",XQSTXT(8)="" D
 .N EC,QCT
 .S QCT=8,EC="" F  S EC=$O(^TMP("FBER",$J,EC)) Q:EC']""  D  S QCT=QCT+1,XQSTXT(QCT)=""
 ..N I,DATA
 ..S QCT=QCT+1,XQSTXT(QCT)="ERROR CODE "_EC_":  "
 ..I EC<4 S XQSTXT(QCT)=XQSTXT(QCT)_$S(EC=1:"Invalid Vendor ID",EC=2:"Invalid Record Length",EC=3:"Invalid Station Number",1:"")
 ..I EC'<4 S XQSTXT(QCT)=XQSTXT(QCT)_$S(EC=4:"Vendor names do not match",EC=4.1:"Vendor not found in file or vendor in delete status",EC=5:"Vendor change already processed",1:"")
 ..S XQSTXT(QCT)=" ===> "_XQSTXT(QCT)
 ..S QCT=QCT+1,XQSTXT(QCT)="       "_$S(EC<3:"Action necessary.",EC=3:"Action may be necessary.",1:"Information only.")_"  Refer to the Vendor Error Code documentation."
 ..S QCT=QCT+1,XQSTXT(QCT)="",I=0 F  S I=$O(^TMP("FBER",$J,EC,I)) Q:'I  S DATA=^(I),QCT=QCT+1,XQSTXT(QCT)=DATA
 G EXIT
ER(EC,J,FBER) ;set error & error count
 ;INPUT:  EC = error code
 ;            1 = invalid vendor id (action needed)
 ;            2 = invalid record length (action needed)
 ;            3 = invalid station number (action may be necessary)
 ;            4 = vendor names do not match (ignore)
 ;           4.1 = vendor not found or in delete status (ignore)
 ;            5 = record already processed (ignore)
 ;        J = data string from message/mra record
 ;        FBER = error count
 ;OUTPUT: FBER updated
 I $S($G(FBER)']"":1,J']"":1,'+$G(EC):1,1:0) Q
 N FBCHAIN,FBRT,FBVID,FBVNAME
 I EC'=2 S FBRT=$E(J,1),FBVID=$S(FBRT=1:$E(J,9,19),1:$E(J,9,17)),FBVNAME=$S(FBRT=1:$E(J,27,56),1:$E(J,23,52)),FBCHAIN=$S(FBRT=1:"",1:" "_$E(J,18,21))
 S FBER=FBER+1,^TMP("FBER",$J,EC,FBER)=$S(EC=2:J,1:FBVNAME_"     "_FBVID_FBCHAIN)
 Q
