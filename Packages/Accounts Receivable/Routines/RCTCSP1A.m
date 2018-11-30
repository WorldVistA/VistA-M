RCTCSP1A ;ALBANY/PAW-CROSS-SERVICING REPORT ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**315,341**;Mar 20, 1995;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CSRPRTH1 ;header for cross-servicing print report 1
 W @IOF
 S PAGE=PAGE+1,EXCEL=$G(EXCEL)
 I 'EXCEL D  Q
 .W !,"PAGE "_PAGE,?16,"BILLS AT CROSS-SERVICING (SORTED BY BILL NO.)",?68,$$FMTE^XLFDT(DT,"2Z")
 .W !,DASH
 .W !,"BILL NO.",?14,"DEBTOR",?35,"Pt ID",?43,"ORIG AMT",?55,"CS REF DATE",?67," CURR AMT"  ; limited SSN to 4 char - (as per PRCA*4.5*315)
 .W !,"---- ---",?14,"------",?35,"-----",?43,"---- ---",?55,"-- --- ----",?67," ---- ---"
 ;EXCEL FORMAT
 W !,"PAGE "_PAGE_U_U_"BILLS AT CROSS-SERVICING (SORTED BY BILL NO.)"_U_U_$$FMTE^XLFDT(DT,"2Z")
 W !,"BILL NO."_U_"DEBTOR"_U_"Pt ID"_U_"ORIG AMT"_U_"CS REF DATE"_U_" CURR AMT"  ; limited SSN to 4 char - (as per PRCA*4.5*315)
 Q
 ;
CSRPRTH2 ;header for cross-servicing print report 2
 W @IOF
 S PAGE=PAGE+1,EXCEL=$G(EXCEL)
 I 'EXCEL D  Q
 .W !,"PAGE "_PAGE,?16,"BILLS AT CROSS-SERVICING (SORTED BY DEBTOR)",?68,$$FMTE^XLFDT(DT,"2Z")
 .W !,DASH
 .W !,"DEBTOR",?21,"BILL NO.",?35,"Pt ID",?43,"ORIG AMT",?55,"CS REF DATE",?67," CURR AMT"  ;limited SSN to 4 char - (as per PRCA*4.5*315)
 .W !,"------",?21,"---- ---",?35,"-----",?43,"---- ---",?55,"-- --- ----",?67," ---- ---"
 ;EXCEL FORMAT
 W !,"PAGE "_PAGE_U_U_"BILLS AT CROSS-SERVICING (SORTED BY DEBTOR)"_U_U_$$FMTE^XLFDT(DT,"2Z")
 W !,"DEBTOR"_U_"BILL NO."_U_"Pt ID"_U_"ORIG AMT"_U_"CS REF DATE"_U_" CURR AMT"  ; limited SSN to 4 char - (as per PRCA*4.5*315)
 Q
 ;
CSRPRTH3 ;header for cross-servicing print report 3
 W @IOF
 S PAGE=PAGE+1,EXCEL=$G(EXCEL)
 I 'EXCEL D  Q
 .W !,"PAGE "_PAGE,?11,"BILLS AT CROSS-SERVICING (SORTED BY CS REFERRED DATE)",?68,$$FMTE^XLFDT(DT,"2Z")
 .W !,DASH
 .W !,"CS REF DT",?12,"DEBTOR",?34,"BILL NO.",?49,"Pt ID",?58,"ORIG AMT",?67," CURR AMT"  ;limited SSN to 4 char - (as per PRCA*4.5*315)
 .W !,"-- --- ----",?12,"------",?34,"---- ---",?49,"-----",?58,"---- ---",?67," ---- ---"
 ;EXCEL FORMAT
 W !,"PAGE "_PAGE_U_U_"BILLS AT CROSS-SERVICING (SORTED BY CS REFERRED DATE)"_U_U_$$FMTE^XLFDT(DT,"2Z")
 W !,"CS REF DATE"_U_"DEBTOR"_U_"BILL NO."_U_"Pt ID"_U_"ORIG AMT"_U_" CURR AMT"  ; limited SSN to 4 char - (as per PRCA*4.5*315)
 Q
 ;
COUNTRY(Z) ;
 N PRCACC
 ;get treasury country code - moved out of RCTCSP1, due to SACC size limitation error PRCA*4.5*315
 I Z<3 S PRCACC="US" G COUNTRYQ
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
HEADER ;
 ;increment batch sequence number, build new header
 N RCMSG
 S SEQ=SEQ+1
 S CNTLID=$$JD()_$$RJZF^RCTCSP1(SEQ,4)
 K ^XTMP("RCTCSPD",$J,ACTION,"BUILD",SEQ)
 ;header is record type H
 S RCMSG="H"_CNTLID_$$BLANK^RCTCSP1(14)_"3636001200"
 S RCMSG=RCMSG_$$BLANK^RCTCSP1(450-$L(RCMSG))
 S REC=REC+1
 S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(RCMSG,1,225)_$C(94)
 S REC=REC+1
 S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(RCMSG,226,999)_$C(126)
 Q
 ;
TRAILER ;
 ;trailer is type Z record
 N X
 I REC=0 K ^XTMP("RCTCSPD",$J,SEQ,"BUILD") Q  ;delete batch if no records processed
 N RCMSG
 S CNTLID=$$JD()_$$RJZF^RCTCSP1(SEQ,4)
 S RCMSG="Z"_$$RJZF^RCTCSP1(RECC,8)
 S X=$TR($J(AMOUNT/100,0,2),".")
 S X=$E("00000000000",1,14-$L(X))_X ;341/DRF Remove AMOUNT function
 S RCMSG=RCMSG_X
 S RCMSG=RCMSG_CNTLID_$$BLANK^RCTCSP1(14)_"3636001200"
 S RCMSG=RCMSG_$$BLANK^RCTCSP1(450-$L(RCMSG))
 S REC=REC+1
 S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(RCMSG,1,225)_$C(94)
 S REC=REC+1
 S ^XTMP("RCTCSPD",$J,SEQ,"BUILD",REC)=$E(RCMSG,226,999)_$C(126)
 S REC=0,RECC=0,AMOUNT=0
 Q
 ;
JD() ; returns today's Julian date YDOY
 N XMDDD,XMNOW,XMDT
 S XMNOW=$$NOW^XLFDT
 S XMDT=$E(XMNOW,1,7)
 S XMDDD=$$RJ^XLFSTR($$FMDIFF^XLFDT(XMDT,$E(XMDT,1,3)_"0101",1)+1,3,"0")
 Q $E(DT,3)_XMDDD
 ;
