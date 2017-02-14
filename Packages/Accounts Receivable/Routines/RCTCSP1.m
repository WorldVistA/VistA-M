RCTCSP1 ;ALBANY/BDB-CROSS-SERVICING TRANSMISSION ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**301**;Mar 20, 1995;Build 144
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
BILLREP ;cross-servicing bill report, prints individual bills that make up a cross-servicing account
 N DIC,DEBTOR,ZTSAVE,ZTDESC,ZTRTN,POP
 S DIC=340,DIC(0)="AEQM",DIC("S")="I $D(^RCD(340,""TCSP"",+Y))" D ^DIC
 Q:Y<1  S DEBTOR=+Y
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" D ^%ZIS G:POP BILLREPQ S IOP=ION_";"_IOM_";"_IOSL
 I $D(IO("Q")) D  G BILLREPQ
    .S ZTSAVE("DEBTOR")=""
    .S ZTRTN="BILLREPP^RCTCSP1",ZTDESC="CROSS-SERVICING BILL REPORT"
    .D ^%ZTLOAD,HOME^%ZIS
    .Q
 ;
BILLREPP ;Call to build array of bills referred
 U IO
 N BILL,B7,B14,B15,B16,D4,FND,BAMT,TAMT,DIRUT,TNM,TID,TDT,DASH,CSTAT,PAGE,DASH,TMP,I
 S DASH="",$P(DASH,"-",81)=""
 S (BAMT,TAMT,BILL,PAGE)=0 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:('BILL)!($D(DIRUT))  D
 .Q:'+$G(^PRCA(430,BILL,15))
 .S B7=$G(^PRCA(430,BILL,7))
 .S BAMT=0 F I=1:1:5 S BAMT=BAMT+$P(B7,U,I)
 .S TAMT=TAMT+BAMT
 D BILLREPH
 S (FND,BILL)=0 F  S BILL=$O(^PRCA(430,"C",DEBTOR,BILL)) Q:('BILL)!($D(DIRUT))  D
    .Q:'+$G(^PRCA(430,BILL,15))
    .S FND=1 W !,$P(^PRCA(430,BILL,0),U) S CSTAT=$P(^(0),U,8),B7=$G(^(7)),B15=$G(^(15)),B16=$G(^(16))
    .W ?13,$P(^PRCA(430.3,CSTAT,0),U,2)
    .W ?17,$J($P(B16,U,9),8,2)
    .S BAMT=0 F I=1:1:5 S BAMT=BAMT+$P(B7,U,I)
    .W ?27,$J(BAMT,8,2)
    .W $J($P(B7,U,1),10,2)
    .W $J($P(B7,U,2),7,2)
    .W $J($P(B7,U,3),7,2)
    .W $J($P(B7,U,4),8,2)
    .S TMP=$$UPPER^VALM1($$FMTE^XLFDT($P(B15,U,1)))
    .W ?69,$P(TMP,", ",1)_","_$P(TMP,", ",2)
    .;check for end of page here, if necessary form feed and print header
    .I ($Y+3)>IOSL D
    ..I $E(IOST,1,2)="C-" S DIR(0)="E" K DIRUT D ^DIR Q:$D(DIRUT)
    ..D BILLREPH
 I $E(IOST,1,2)="C-" R !!,"END OF REPORT...PRESS RETURN TO CONTINUE",X:DTIME W @IOF
 D:'$D(ZTQUEUED) ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 K IOP,%ZIS,ZTQUEUED
BILLREPQ Q
 ;
BILLREPH ;header for cross-servicing bill report
 W @IOF
 S PAGE=PAGE+1
 W "PAGE "_PAGE,?24,"CROSS-SERVICING BILL REPORT",?68,$$UPPER^VALM1($$FMTE^XLFDT(DT))
 W !,DASH
 N RCHDR
 S RCHDR=$$ACCNTHDR^RCDPAPLM(DEBTOR)
 W !!,"DEBTOR: ",$E($P(RCHDR,U,1),1,18),?32,"SSN: ",$E($P(RCHDR,U,2),2,$L($P(RCHDR,U,2))-1),?55,"CURRENT CS DEBT: ",$J(TAMT,8,2)
 W !,DASH
 W !,"BILL NO.",?13,"ST",?17,"ORIG AMT",?27,"CURR AMT",?41,"PRIN",?49,"INT",?54,"ADMIN",?62,"COURT",?69,"CS REF DATE"
 W !,"---- ---",?13,"--",?17,"---- ---",?27,"---- ---",?41,"----",?49,"---",?54,"-----",?62,"-----",?69,"-- --- ----"
 Q
 ;
CSRPRT ;print cross-servicing report, prints sorted individual bills that make up a cross-servicing account
 N DIC,RCSORT,PAGE,DASH,DTOUT,DUOUT,DIROUT,BY,FROM,TO,FLDS,L
 S PAGE=0,DASH="",$P(DASH,"-",81)=""
 W !
 S DIR(0)="S^1:Bill Number;2:Debtor Name;3:CS Referred Date",DIR("A")="Sort by" D ^DIR K DIR
 S RCSORT=Y Q:($D(DTOUT)!$D(DUOUT)!$D(DIROUT))
 I RCSORT=1 D
 .S DIC="^PRCA(430,",L=0,L(0)=1,BY(0)="^PRCA(430,""TCSP"","
 .S FLDS=".01;L12,9;L18,161;R10,169;R9,151;R12,11;R9",DHD="W ?0 D CSRPRTH1^RCTCSP1"
 .D EN1^DIP
 .Q
 ;
 I RCSORT=2 D
 .S DIC="^PRCA(430,",L=0,L(0)=1,BY(0)="^PRCA(430,""TCSP"",",BY=9,(FR,TO)=""
 .S FLDS="9;L18,.01;R12,161;R10,169;R9,151;R12,11;R9",DHD="W ?0 D CSRPRTH2^RCTCSP1"
 .D EN1^DIP
 .Q
 ;
 I RCSORT=3 D
 .S DIC="^PRCA(430,",L=0,L(0)=1,BY(0)="^PRCA(430,""TCSP"",",BY=151,(FR,TO)=""
 .S FLDS="151;L12,9;L18,.01;R12,161;R10,169;R9,11;R9",DHD="W ?0 D CSRPRTH3^RCTCSP1"
 .D EN1^DIP
 .Q
 Q
 ;
CSRPRTH1 ;header for cross-servicing print report 1
 W @IOF
 S PAGE=PAGE+1
 W !,"PAGE "_PAGE,?16,"BILLS AT CROSS-SERVICING (SORTED BY BILL NO.)",?68,$$UPPER^VALM1($$FMTE^XLFDT(DT))
 W !,DASH,!
 W !,"BILL NO.",?14,"DEBTOR",?35,"SSN",?47,"ORIG AMT",?58,"CS REF DATE",?71," CURR AMT"
 W !,"---- ---",?14,"------",?35,"---",?47,"---- ---",?58,"-- --- ----",?71," ---- ---",!
 Q
 ;
CSRPRTH2 ;header for cross-servicing print report 2
 W @IOF
 S PAGE=PAGE+1
 W !,"PAGE "_PAGE,?16,"BILLS AT CROSS-SERVICING (SORTED BY DEBTOR)",?68,$$UPPER^VALM1($$FMTE^XLFDT(DT))
 W !,DASH,!
 W !,"DEBTOR",?21,"BILL NO.",?35,"SSN",?47,"ORIG AMT",?58,"CS REF DATE",?71," CURR AMT"
 W !,"------",?21,"---- ---",?35,"---",?47,"---- ---",?58,"-- --- ----",?71," ---- ---",!
 Q
 ;
CSRPRTH3 ;header for cross-servicing print report 3
 W @IOF
 S PAGE=PAGE+1
 W !,"PAGE "_PAGE,?11,"BILLS AT CROSS-SERVICING (SORTED BY CS REFERRED DATE)",?68,$$UPPER^VALM1($$FMTE^XLFDT(DT))
 W !,DASH,!
 W !,"CS REF DATE",?14,"DEBTOR",?35,"BILL NO.",?49,"SSN",?61,"ORIG AMT",?71," CURR AMT"
 W !,"-- --- ----",?14,"------",?35,"---- ---",?49,"---",?61,"---- ---",?71," ---- ---",!
 Q
 ;
CSRCLRT ;cross-servicing recall report, prints sorted individual bills that make up a cross-servicing account
 N DIC,RCSORT,PAGE,DASH,DTOUT,DUOUT,DIROUT,DHD,FLDS,L,BY,FR,TO,DIS
 S PAGE=0,DASH="",$P(DASH,"-",81)=""
 W !
 S DIR(0)="S^1:Bill Number;2:Debtor Name",DIR("A")="Sort by" D ^DIR K DIR
 S RCSORT=Y Q:($D(DTOUT)!$D(DUOUT)!$D(DIROUT))
 I RCSORT=1 D
 .S DIC="^PRCA(430,",DIS(0)="I ($P($G(^PRCA(430,D0,15)),U,2)>0)!((+$P($G(^RCD(340,+$P(^PRCA(430,D0,0),U,9),7)),U,2))&$D(^PRCA(430,""TCSP"",D0)))",L=0,BY=.01,(FR,TO)=""
 .S FLDS="[PRCA TCSP RECALLB]",DHD="W ?0 D CSRCLH1^RCTCSP1"
 .D EN1^DIP
 .Q
 ;
 I RCSORT=2 D
 .S DIC="^PRCA(430,",DIS(0)="I ($P($G(^PRCA(430,D0,15)),U,2)>0)!((+$P($G(^RCD(340,+$P(^PRCA(430,D0,0),U,9),7)),U,2))&$D(^PRCA(430,""TCSP"",D0)))",L=0,BY=9,(FR,TO)=""
 .S FLDS="[PRCA TCSP RECALLD]",DHD="W ?0 D CSRCLH2^RCTCSP1"
 .D EN1^DIP
 .Q
 Q
 ;
CSRCLH1 ;header for cross-servicing recall report 1
 W @IOF
 S PAGE=PAGE+1
 W !,"PAGE "_PAGE,?12,"CROSS-SERVICING RECALL REPORT (SORTED BY BILL NUMBER)",?68,$$UPPER^VALM1($$FMTE^XLFDT(DT))
 W !,DASH,!
 W !,"BILL NO.",?13,"DEBTOR",?33,"SSN",?44,"RCLL AMT",?54,"RECALL DATE",?67,"RECALL RSN"
 W !,"---- ---",?13,"------",?33,"---",?44,"---- ---",?54,"------ ----",?67,"------ ---",!
 Q
 ;
CSRCLH2 ;header for cross-servicing recall report 2
 W @IOF
 S PAGE=PAGE+1
 W !,"PAGE "_PAGE,?14,"CROSS-SERVICING RECALL REPORT (SORTED BY DEBTOR)",?68,$$UPPER^VALM1($$FMTE^XLFDT(DT))
 W !,DASH,!
 W !,"DEBTOR",?20,"BILL NO.",?33,"SSN",?44,"RCLL AMT",?54,"RECALL DATE",?67,"RECALL RSN"
 W !,"------",?20,"--------",?33,"---",?44,"---- ---",?54,"------ ----",?67,"------ ---",!
 Q
 ;
HEADER ;
 ;increment batch sequence number, build new header
 N RCMSG
 S SEQ=SEQ+1
 S CNTLID=$$JD()_$$RJZF(SEQ,4)
 K ^XTMP("RCTCSPD",$J,ACTION,"BUILD",SEQ)
 ;header is record type H
 S RCMSG="H"_CNTLID_$$BLANK(14)_"3636001200"
 S RCMSG=RCMSG_$$BLANK(450-$L(RCMSG))
 S REC=REC+1
 S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(RCMSG,1,225)_$C(94)
 S REC=REC+1
 S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(RCMSG,226,999)_$C(126)
 Q
 ;
TRAILER ;
 ;trailer is type Z record
 I REC=0 K ^XTMP("RCTCSPD",$J,SEQ,"BUILD") Q  ;delete batch if no records processed
 N RCMSG
 S CNTLID=$$JD()_$$RJZF(SEQ,4)
 S RCMSG="Z"_$$RJZF(RECC,8)_$$AMOUNT(AMOUNT/100)_CNTLID_$$BLANK(14)_"3636001200"
 S RCMSG=RCMSG_$$BLANK(450-$L(RCMSG))
 S REC=REC+1
 S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(RCMSG,1,225)_$C(94)
 S REC=REC+1
 S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(RCMSG,226,999)_$C(126)
 S REC=0,RECC=0,AMOUNT=0
 Q
 ;
REC5B ;
 ;  trnnum     transaction number file #433 pass in
 ;  trntyp     transaction type pointer to 430.3
 ;  trntypa    aia transaction type  (aio: dmc agency internal offset, abal: decrease adjustment) 
 N REC,KNUM,DEBTNR,DEBTORNB,TAMOUNT,TAMTPBAL,TAMTIBAL,TAMTABAL,TAMTFBAL,TAMTCBAL,AMTRFRRD,TRNTYP,TRNTYPA,TRANSNB
 N AMTPBAL,AMTIBAL,AMTABAL,AMTFBAL,AMTCBAL,TRN3,TRNNUME
 S TRNTYPA="AIO"
 S REC="C5B"_ACTION_"3636001200"_"DM1D "_"L"
 S KNUM=$P($P(B0,U,1),"-",2)
 S DEBTNR=$E(SITE,1,3)_$$RJZF(KNUM,7)_$TR($J(BILL,20)," ",0),REC=REC_DEBTNR
 S DEBTORNB=$E(SITE,1,3)_$TR($J(DEBTOR,12)," ",0)
 S REC=REC_DEBTORNB
 S TRNTYP=$P($G(^PRCA(433,TRNNUM,1)),U,2) I TRNTYP=35 S TRNTYPA="ABAL"
 S REC=REC_$$LJSF(TRNTYPA,9)
 S TRNNUME=$$RJZF(TRNNUM,10)
 S TRNNUME=$E(TRNNUME,5,10) ;max is 999999
 I TRNNUME="000000" S TRNNUME="000001" ;min is 1
 S REC=REC_$$RJZF(TRNNUME,10)
 S REC=REC_$$DATE8(DT)
 S TRANSNB=$E(SITE,1,3)_$TR($J(TRNNUM,12)," ",0)
 S REC=REC_TRANSNB
 S REC=REC_$$BLANK(9)
 S TRN3=$G(^PRCA(433,TRNNUM,3))
 S TAMTPBAL=$P(TRN3,U,1) ;transaction principle balance
 S TAMTIBAL=$P(TRN3,U,2) ;transaction interest balance
 S TAMTABAL=$P(TRN3,U,3) ;transaction administrative balance
 S TAMTFBAL=$P(TRN3,U,4) ;transaction marshal fee
 S TAMTCBAL=$P(TRN3,U,5) ;transaction court cost
 I (TAMTPBAL+TAMTIBAL+TAMTABAL+TAMTFBAL+TAMTCBAL)=0 S TAMTPBAL=TRNAMT
 S TAMOUNT=$S(+TAMTPBAL:"-",1:"0")_$E($$AMOUNT(TAMTPBAL),2,14)
 S TAMOUNT=TAMOUNT_$S(+TAMTIBAL:"-",1:"0")_$E($$AMOUNT(TAMTIBAL),2,14)
 S TAMOUNT=TAMOUNT_$S(+TAMTABAL:"-",1:"0")_$E($$AMOUNT(TAMTABAL),2,14)
 S TAMOUNT=TAMOUNT_$S(+(TAMTFBAL+TAMTCBAL):"-",1:"0")_$E($$AMOUNT(TAMTFBAL+TAMTCBAL),2,14)
 S REC=REC_TAMOUNT
 S REC=REC_"-"_$E($$AMOUNT(TRNAMT),2,14)
 S REC=REC_$$BLANK(450-$L(REC))
 S AMTPBAL=$P(B7,U,1) ;principle balance
 S AMTIBAL=$P(B7,U,2) ;interest balance
 S AMTABAL=$P(B7,U,3) ;administrative balance
 S AMTFBAL=$P(B7,U,4) ;marshal fee
 S AMTCBAL=$P(B7,U,5) ;court cost
 S AMTRFRRD=AMTPBAL+AMTIBAL+AMTABAL+AMTFBAL+AMTCBAL
 I ACTION="U" S $P(^PRCA(430,BILL,16),U,10)=AMTRFRRD
 S ^XTMP("RCTCSPD",$J,BILL,ACTION,"5B",TRNNUM)=REC
 S ^XTMP("RCTCSPD",$J,"BILL",ACTION,BILL)=$$TAXID(DEBTOR)_"^-"_+$E(REC,174,184)_"."_$E(REC,185,186)
 Q
 ;
DATE8(X) ;changes fileman date into 8 digit date yyyymmdd
 I +X S X=X+17000000
 S X=$E(X,1,8)
 Q X
 ;
AMOUNT(X) ;changes amount to zero filled, right justified
 S:X<0 X=-X
 S X=$TR($J(X,0,2),".")
 S X=$E("000000000000",1,14-$L(X))_X
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
ADDR(RCDFN) ; returns patient file address
 N DFN,ADDRCS,STATEIEN,STATEAB,VAPA
 S DFN=RCDFN
 D ADD^VADPT
 S STATEIEN=+VAPA(5),STATEAB=$$GET1^DIQ(5,STATEIEN,1)
 S ADDRCS=VAPA(1)_U_VAPA(2)_U_VAPA(4)_U_STATEAB_U_VAPA(6)_U_VAPA(8)_U_+VAPA(25)
 I $L(DEBTOR1)>0 I $P(DEBTOR1,U,1,5)'?1"^"."^" D
 .N ADDR340
 .S ADDR340=$P($$DADD^RCAMADD(DEBTOR),U,1,7)_"^"_1
 .S ADDR340=$P(ADDR340,U,1,2)_"^"_$P(ADDR340,U,4,99)
 .I $P(ADDR340,U,6)="" S $P(ADDR340,U,6)=$P(ADDRCS,U,6)
 .S ADDRCS=ADDR340
 Q ADDRCS
 ;
DEM(RCDFN) ; returns patient file gender and dob
 N DFN,VADM
 S DFN=RCDFN
 D DEM^VADPT
 ; return string   sex:m/f ^ dob: yyyymmdd ^ ssn ^ deceased
 Q $P(VADM(5),U,1)_U_$P(VADM(3),U,1)_U_$P(VADM(2),U,1)_U_VADM(6)
 ; 
COUNTRY(Z) ;
 N PRCACC
 ;get treasury country code
 I Z=1 S PRCACC="US" G COUNTRYQ
 I Z="" S PRCACC="US" G COUNTRYQ
 S PRCACC=$S(Z=4:"AF",Z=5:"AL",Z=7:"DZ",Z=8:"AD",Z=9:"AO",Z=180:"AI",Z=10:"AG",Z=12:"AR",Z=18:"AM",Z=151:"AW",Z=13:"AU",Z=14:"AT",Z=11:"AZ",Z=15:"BS",Z=16:"BH",Z=17:"BD",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=19:"BB",Z=36:"BY",Z=20:"BE",Z=28:"BZ",Z=61:"BJ",Z=21:"BM",Z=22:"BT",Z=23:"BO",Z=24:"BA",Z=25:"BW",Z=27:"BR",Z=29:"IO",Z=32:"BN",Z=33:"BG",Z=223:"Faso",Z=35:"BI",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=37:"KH",Z=38:"CM",Z=39:"CA",Z=40:"CV",Z=41:"KY",Z=42:"CF",Z=44:"TD",Z=45:"CL",Z=46:"CN",Z=50:"CO",Z=51:"KM",Z=53:"CG",Z=54:"CD",Z=55:"CK",Z=56:"CR",Z=109:"CI",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=57:"HR",Z=58:"CU",Z=59:"CY",Z=60:"CZ",Z=115:"KP",Z=62:"DK",Z=80:"DJ",Z=63:"DM",Z=64:"DO",Z=172:"TP",Z=65:"EC",Z=220:"EG",Z=66:"SV",Z=67:"GQ",Z=69:"ER",Z=70:"EE",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=68:"ET",Z=72:"FK",Z=71:"FO",Z=74:"FJ",Z=75:"FI",Z=76:"FR",Z=77:"GF",Z=78:"PF",Z=79:"TF",Z=81:"GA",Z=83:"GM",Z=82:"GE",Z=84:"DE",Z=85:"GH",Z=86:"GI",Z=221:"GB",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=88:"GR",Z=89:"GL",Z=90:"GD",Z=91:"GP",Z=92:"GT",Z=93:"GN",Z=171:"GW",Z=94:"GY",Z=95:"HT",Z=98:"HN",Z=99:"HK",Z=100:"HU",Z=101:"IS",Z=102:"IN",Z=103:"ID",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=105:"IQ",Z=106:"IE",Z=107:"IL",Z=108:"IT",Z=110:"JM",Z=111:"JP",Z=113:"JO",Z=112:"KZ",Z=114:"KE",Z=87:"KI",Z=116:"KR",Z=117:"KW",Z=118:"KG",Z=119:"LA",Z=122:"LV",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=120:"LB",Z=121:"LS",Z=123:"LR",Z=124:"LY",Z=125:"LI",Z=126:"LT",Z=127:"LU",Z=128:"MO",Z=129:"MG",Z=130:"MW",Z=131:"MY",Z=132:"MV",Z=133:"ML",Z=134:"MT",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=999:"MH",Z=135:"MQ",Z=136:"MR",Z=137:"MU",Z=52:"YT",Z=138:"MX",Z=161:"FM",Z=141:"MD",Z=139:"MC",Z=140:"MN",Z=142:"MS",Z=143:"MA",Z=144:"MZ",Z=34:"MM",Z=146:"NA",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=147:"NR",Z=148:"NP",Z=149:"NL",Z=150:"AN",Z=152:"NC",Z=154:"NZ",Z=155:"NI",Z=156:"NE",Z=157:"NG",Z=158:"NU",Z=159:"NF",Z=160:"NO",Z=145:"OM",Z=162:"PK",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=999:"PW",Z=163:"PA",Z=164:"PG",Z=165:"PY",Z=166:"PE",Z=167:"PH",Z=168:"PN",Z=169:"PL",Z=170:"PT",Z=173:"QA",Z=999:"RE",Z=175:"RO",Z=176:"RU",Z=177:"RW",Z=178:"SH",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=179:"KN",Z=181:"LC",Z=183:"VC",Z=999:"WS",Z=184:"SM",Z=185:"ST",Z=186:"SA",Z=187:"SN",Z=188:"SC",Z=189:"SL",Z=190:"SG",Z=191:"SK",Z=193:"SI",Z=30:"SB",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=194:"SO",Z=195:"ZA",Z=197:"ES",Z=43:"LK",Z=199:"SD",Z=200:"SR",Z=201:"SZ",Z=202:"SE",Z=203:"CH",Z=204:"SY",Z=205:"TJ",Z=222:"TZ",Z=182:"PM",Z=206:"TH",Z=219:"MK",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=207:"TG",Z=208:"TK",Z=209:"TO",Z=210:"TT",Z=212:"TN",Z=213:"TR",Z=214:"TM",Z=215:"TC",Z=216:"TV",Z=217:"UG",Z=218:"UA",Z=211:"AE",Z=1:"US",Z=224:"UY",1:"  ") G:PRCACC'="  " COUNTRYQ
 S PRCACC=$S(Z=104:"IR",Z=225:"UZ",Z=153:"VU",Z=97:"VA",Z=226:"VE",Z=183:"VN",Z=31:"VG",Z=227:"WF",Z=228:"YE",Z=229:"YU",Z=230:"ZM",Z=196:"ZW",1:"  ") G:PRCACC'="  " COUNTRYQ
COUNTRYQ ;
 Q PRCACC
 ;
