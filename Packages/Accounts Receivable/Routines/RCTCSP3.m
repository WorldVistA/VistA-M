RCTCSP3 ;ALBANY/BDB-CROSS-SERVICING TRANSMISSION ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**301**;Mar 20, 1995;Build 144
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
ENTER ;Entry point from the post initialization
RCCSTUP I '$D(^XTMP("REJCDCONV")) D
 . D NOW^%DTC S RCCSTART=%
 . S ^XTMP("REJCDCONV","START COMPILE")=RCCSTART
 . S ^XTMP("REJCDCONV","STATUS")="RUNNING"
 . S ^XTMP("REJCDCONV",0)=$$FMADD^XLFDT(RCCSTART,730)_"^"_RCCSTART
 S RCCCMPLT=0 I $G(^XTMP("REJCDCONV","STATUS"))="COMPLETE" S RCCCMPLT=1
AA N DEBTOR
 S DEBTOR=0
 F  S DEBTOR=$O(^PRCA(430,"C",DEBTOR)) Q:DEBTOR'?1N.N  D
 .N X,RCDFN,DEMCS,DEBTOR0,DEBTOR1,DEBTOR7,BILL
 .S DEBTOR0=^RCD(340,DEBTOR,0),DEBTOR1=$G(^(1)),DEBTOR7=$G(^(7))
 .S RCDFN=+DEBTOR0
 .S DEMCS=$$DEM^RCTCSP1(RCDFN) Q:$E($P(DEMCS,U,3),1,5)="00000"
 .Q:+$P(DEMCS,U,4)  ;deceased patient
 .S BILL=0
 .F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:BILL'?1N.N  D
 ..N B0,B6,B7,B14,CAT,TOTAL
 ..S B0=$G(^PRCA(430,BILL,0)),B6=$G(^(6)),B7=$G(^(7)),B14=$G(^(14))
 ..I 'RCCCMPLT,$D(^PRCA(430,BILL,18)) D REJCODE
 ..I $D(^PRCA(430,"TCSP",BILL)) Q  ;no dpn for cs bills
 ..Q:'$P(B0,U,2)  ;no category
 ..S CAT=$P($G(^PRCA(430.2,$P(B0,U,2),0)),U,7)
 ..Q:'CAT
 ..I ",4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,25,26,27,28,33,34,35,36,37,38,39,"[(","_CAT_",") Q  ;1st party check
 ..I +$P(B14,U,1) Q  ;bill referred to TOP
 ..S TOTAL=$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 ..I TOTAL'>0 Q  ;total must be greater than zero
 ..I '$P(B0,U,8) Q  ;if no current status
 ..I $P(B0,U,8)=23 Q  ;quit if write-off
 ..I $P(B0,U,8)=26 Q  ;quit if cancelled
 ..I $P(B0,U,8)=39 Q  ;quit if cancellation
 ..I TOTAL<25 S $P(^PRCA(430,BILL,20),U,3,8)="1^^^^^" ;set dpn flag
 ..Q
 .Q
 I RCCCMPLT'=1 D
 . D NOW^%DTC S RCCEND=%
 . S ^XTMP("REJCDCONV","END REJ CODE CONV")=RCCEND
 . S ^XTMP("REJCDCONV","STATUS")="COMPLETE"
 Q
 ;  
DUEPROC ; called from rctcspd
 N TOTAL
 S TOTAL=$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 I TOTAL<25 Q  ;no dpn record for bills less than $25
 I $P($G(DEBTOR3),U,10) Q  ;check site delete flag null
 I +$P(B12,U,1) Q  ;check date bill sent to dmc
 I $P(B6,U,4),($P(B6,U,5)="DOJ") Q  ;bill referred to doj
 I $P(B0,U,8)'=16 Q  ;status active
 I '$P(B6,U,3) Q  ;must have a 3rd letter
 D RECDPN ;create a dpn record
 Q
 ;
RECDPN ;
 N KNUM,NAME
 S REC="C"
 S REC=REC_$$RJZF(BILL,10)
 S REC=REC_$$TAXID(DEBTOR)
 S NAME=$$NAMEFF(+DEBTOR0),NAME=$P(NAME,U)
 S REC=REC_$$LJSF(NAME,30)
 S RCDFN=+DEBTOR0
 S ADDRCS=$$ADDR(RCDFN)
 S REC=REC_$$LJSF($P(ADDRCS,U,1),35)_$$LJSF($P(ADDRCS,U,2),35)_$$LJSF($P(ADDRCS,U,3),15)
 S REC=REC_$$LJSF($P(ADDRCS,U,8),20)
 S REC=REC_$$BLANK(5)
 S REC=REC_$$LJSF($P(ADDRCS,U,4),2)_$$LJSF($P(ADDRCS,U,5),9)
 S REC=REC_$$COUNTRY^RCTCSP1($P(ADDRCS,U,7))
 S TOTAL=$P(B7,U)+$P(B7,U,2)+$P(B7,U,3)+$P(B7,U,4)+$P(B7,U,5)
 S REC=REC_$$BLANK(9)
 S REC=REC_$$DATE8(+$P(B6,U,21))
 S KNUM=$P($P(B0,U,1),"-",2)
 S REC=REC_$E(SITE,1,3)_$$LJSF(KNUM,7)
 S REC=REC_$$AMOUNT9(TOTAL)
 S REC=REC_$$LJSF($P(ADDRCS,U,9),10)
 S REC=REC_$S($P(ADDRCS,U,9)="":" ",$P(ADDRCS,U,9)="US":" ",1:"F")
 S REC=REC_$$BLANK(250-$L(REC))
 S $P(^PRCA(430,BILL,20),U,4)=DT ;set the dpn request date
 S $P(^PRCA(430,BILL,20),U,5,8)="^^^" ;clear the print date and error codes
 S ^XTMP("RCTCSPDN",$J,BILL,"DPN",1)=REC
 S ^XTMP("RCTCSPDN",$J,"BILL","DPN",BILL)=$$TAXID(DEBTOR)_"^"_+$E(REC,201,207)_"."_$E(REC,208,209) ;sends mailman message of documents sent to user
 Q
 ;
COMPILED ;
 N RCMSG,BCNTR,REC,RECC,AMOUNT,AMOUNT,RCNTR,ACTION,SEQ,EOF
 S BCNTR=0,REC=0,RECC=0,AMOUNT=0,SEQ=0,EOF=0
 F  S BCNTR=$O(^XTMP("RCTCSPDN",$J,BCNTR)) S:+BCNTR'>0 EOF=1 Q:+BCNTR'>0  D
 .I REC>120 D
 ..D TRAILERD
 ..D AITCMSGD
 ..S REC=0,RECC=0
 ..Q
 .S ACTION="DPN"
 .I REC=0 D HEADERD
 .S RCNTR=1 I $D(^XTMP("RCTCSPDN",$J,BCNTR,ACTION,RCNTR)) D
 ..S REC=REC+1
 ..S RECC=RECC+1 ;record count for 'c' records on trailer record
 ..S ^XTMP("RCTCSPDN",$J,SEQ,"BUILD",REC)=^XTMP("RCTCSPDN",$J,BCNTR,ACTION,RCNTR)_$C(126)
 ..S AMOUNT=AMOUNT+$E(^XTMP("RCTCSPDN",$J,BCNTR,ACTION,RCNTR),201,209)
 ..Q
 .Q
 D TRAILERD
 D AITCMSGD
 D USRMSGD
 Q
 ;
AITCMSGD ;
 N XMY,XMDUZ,XMSUB,XMTEXT
 Q:'$D(^XTMP("RCTCSPDN",$J))
 S CNTLID=$$JD()_$$RJZF(SEQ,4)
 S XMDUZ="AR PACKAGE"
 S XMY("XXX@Q-TPL.domain.ext")=""
 S XMY("G.TCSP")=""
 S XMSUB=SITE_"/DPN TRANSMISSION/BATCH#: "_CNTLID
 S XMTEXT="^XTMP(""RCTCSPDN"","_$J_","""_SEQ_""",""BUILD"","
 D ^XMD
 Q
 ;
USRMSGD ;sends mailman message of documents sent to user
 N XMY,XMDUZ,XMSUB,XMTEXT,X,RCNT,RCDAT1,RCDAT2
 Q:'$D(^XTMP("RCTCSPDN",$J))
 S ACTION="DPN"
 K ^XTMP("RCTCSPDN",$J,"BILL","MSG")
 S XMDUZ="AR PACKAGE"
 S XMY("G.TCSP")=""
 S XMSUB="CS DUE PROCESS"_" SENT ON "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)_" BATCH ID: "_CNTLID
 S ^XTMP("RCTCSPDN",$J,"BILL","MSG",1)="Bill#                            TIN         TYPE       AMOUNT"
 S ^XTMP("RCTCSPDN",$J,"BILL","MSG",2)="-----                            ---         ----       ------"
 S X=0,RCNT=2 F  S X=$O(^XTMP("RCTCSPDN",$J,"BILL",ACTION,X)) Q:X=""  D
 .S RCNT=RCNT+1
 .S RCDAT1=$P(^XTMP("RCTCSPDN",$J,"BILL",ACTION,X),U,1)
 .S RCDAT2=$P(^XTMP("RCTCSPDN",$J,"BILL",ACTION,X),U,2)
 .S ^XTMP("RCTCSPDN",$J,"BILL","MSG",RCNT)=$$RJZF($P($G(^PRCA(430,X,0)),U,1),7)_$$BLANK(22)_RCDAT1_"   "_ACTION_"        "_$S(RCDAT2]"":RCDAT2,1:"")
 .Q
 S ^XTMP("RCTCSPDN",$J,"BILL","MSG",RCNT+1)="Total Bills: "_(RCNT-2)
 S XMTEXT="^XTMP(""RCTCSPDN"","_$J_",""BILL"",""MSG"","
 D ^XMD
 K ^XTMP("RCTCSPDN",$J,"BILL","MSG")
 Q
 ;
HEADERD ;
 ;increment batch sequence number, build new header
 N RCMSG
 S SEQ=SEQ+1
 S CNTLID=$$JD()_$$RJZF(SEQ,4)
 K ^XTMP("RCTCSPDN",$J,ACTION,"BUILD",SEQ)
 S RCMSG="H"_CNTLID_$$BLANK(14)_"3636001200" ;header is record type H
 S RCMSG=RCMSG_$$BLANK(250-$L(RCMSG))
 S REC=REC+1
 S ^XTMP("RCTCSPDN",$J,SEQ,"BUILD",REC)=RCMSG_$C(126)
 Q
 ;
TRAILERD ;
 ;trailer is type Z record
 I REC=0 K ^XTMP("RCTCSPDN",$J,SEQ,"BUILD") Q  ;delete batch if no records processed
 N RCMSG
 S CNTLID=$$JD()_$$RJZF(SEQ,4)
 S RCMSG="Z"_$$RJZF(RECC,8)_$$AMOUNT(AMOUNT/100)_CNTLID_$$BLANK(14)_"3636001200"
 S RCMSG=RCMSG_$$BLANK(250-$L(RCMSG))
 S:EOF $E(RCMSG,229,236)="0001"_$$RJZF(SEQ,4)
 S REC=REC+1
 S ^XTMP("RCTCSPDN",$J,SEQ,"BUILD",REC)=RCMSG_$C(126)
 S REC=0,RECC=0,AMOUNT=0
 Q
 ;
DATE8(X) ;changes fileman date into 8 digit date yyyymmdd
 I +X S X=X+17000000
 S X=$E(X,1,8)
 Q X
 ;
AMOUNT(X) ;changes amount to zero filled, right justified, 14 characters
 S:X<0 X=-X
 S X=$TR($J(X,0,2),".")
 S X=$E("000000000000",1,14-$L(X))_X
 Q X
 ;
AMOUNT9(X) ;changes amount to zero filled, right justified
 S:X<0 X=-X
 S X=$TR($J(X,0,2),".")
 S X=$E("000000000000",1,9-$L(X))_X
 Q X
 ;
BLANK(X) ;returns 'x' blank spaces
 N BLANK
 S BLANK="",$P(BLANK," ",X+1)=""
 Q BLANK
 ;
RJZF(X,Y) ;right justify zero fill width Y
 S X=$E("000000000000",1,Y-$L(X))_X
 Q X
 ;
LJSF(X,Y) ;left justified space filled
 S X=$E(X,1,Y)
 S X=X_$$BLANK(Y-$L(X))
 Q X
 ;
LJZF(X,Y) ;x left justified, y zero filled
 S X=X_"0000000000"
 S X=$E(X,X,Y)
 Q X
 ;
TAXID(DEBTOR) ;computes TAXID to place on documents
 N TAXID,DIC,DA,DR,DIQ
 S TAXID=$$SSN^RCFN01(DEBTOR)
 S TAXID=$$LJSF(TAXID,9)
 Q TAXID
 ;
JD() ; returns today's Julian date YDOY
 N XMDDD,XMNOW,XMDT
 S XMNOW=$$NOW^XLFDT
 S XMDT=$E(XMNOW,1,7)
 S XMDDD=$$RJ^XLFSTR($$FMDIFF^XLFDT(XMDT,$E(XMDT,1,3)_"0101",1)+1,3,"0")
 Q $E(DT,3)_XMDDD
 ;
NAMEFF(DFN) ;returns name for document and name in file
 N FN,LN,MN,NM,DOCNM,VA,VADM
 S NM=""
 D DEM^VADPT
 I $D(VADM) S NM=VADM(1)
 S LN=$TR($P(NM,",")," .'-"),MN=$P($P(NM,",",2)," ",2)
 I ($E(MN,1,2)="SR")!($E(MN,1,2)="JR")!(MN?2.3"I")!(MN?0.1"I"1"V"1.3"I") S MN=""
 S FN=$P($P(NM,",",2)," ")
 S DOCNM=LN_", "_FN_" "_MN
 Q DOCNM
 ;
ADDR(RCDFN) ; returns patient file address
 N DFN,ADDRCS,STATEIEN,STATEAB,VAPA
 S DFN=RCDFN
 D ADD^VADPT
 S STATEIEN=+VAPA(5),STATEAB=$$GET1^DIQ(5,STATEIEN,1)
 S ADDRCS=VAPA(1)_U_VAPA(2)_U_VAPA(4)_U_STATEAB_U_VAPA(6)_U_VAPA(8)_U_+VAPA(25)_U_VAPA(23)_U_VAPA(24) ;25-country,23-province,24-postal code
 I $L(DEBTOR1)>0 I $P(DEBTOR1,U,1,5)'?1"^"."^" D
 .N ADDR340
 .S ADDR340=$P($$DADD^RCAMADD(DEBTOR),U,1,7)_"^"_1
 .S ADDR340=$P(ADDR340,U,1,2)_"^"_$P(ADDR340,U,4,99)
 .I $P(ADDR340,U,6)="" S $P(ADDR340,U,6)=$P(ADDRCS,U,6)
 .S ADDRCS=ADDR340
 Q ADDRCS
 ;
REJCODE ;Converts AITC reject codes in reject multiple to pointer to file 348.5
 N RRI,REJI,REJCD,HREJREC,REJREC S RRI=0
REJA S RRI=$O(^PRCA(430,BILL,18,RRI)) Q:'RRI
 S REJREC=$G(^PRCA(430,BILL,18,RRI,0)),HREJREC=REJREC,REJI=3 G REJA:REJREC=""
 I $D(^XTMP("REJCDCONV","BB",BILL,18,RRI,0)) G REJA
 F REJI=REJI:1:13 S REJCD=$P(REJREC,U,REJI) I REJCD'="" D
 . I REJI=12,$D(^RC(348.7,"B",REJCD)) S $P(REJREC,U,REJI)=$O(^RC(348.7,"B",REJCD,0)) Q
 . I REJI=13,$D(^RC(348.6,"B",REJCD)) S $P(REJREC,U,REJI)=$O(^RC(348.6,"B",REJCD,0)) Q
 . I REJI>11 S ^XTMP("REJCDCONV","XX",BILL,18,RRI,0)=REJI_U_HREJREC Q
 . I REJCD>9,REJCD<100 Q
 . I REJCD?1.N,((REJCD>"00")&(REJCD<"10"))!((+REJCD>0)&(+REJCD<10)) S $P(REJREC,U,REJI)=+REJCD Q
 . I $D(^RC(348.5,"B",REJCD)) S $P(REJREC,U,REJI)=$O(^RC(348.5,"B",REJCD,0)) Q
 . S $P(REJREC,U,REJI)=298,^XTMP("REJCDCONV","ZZ",BILL,18,RRI,0)=$P(HREJREC,U,REJI)
 . Q
 I HREJREC'=REJREC S ^XTMP("REJCDCONV","BB",BILL,18,RRI,0)=HREJREC,^XTMP("REJCDCONV","BB",BILL,18,RRI,1)=REJREC,^PRCA(430,BILL,18,RRI,0)=REJREC
 G REJA
