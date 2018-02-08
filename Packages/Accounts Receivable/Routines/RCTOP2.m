RCTOP2 ;WASH IRMFO@ALTOONA,PA/TJK-TOP TRANSMISSION ;2/11/00  3:25 PM
V ;;4.5;Accounts Receivable;**141,169,333**;Mar 20, 1995;Build 7
 ;;Per VA Directive 6402, this routine should not be modified
EN1(DEBTOR,CODE,FILE) ;entry point to compile type 2 documents into global
 ;called from RCTOPD
 ;needs debtor internal number and code:"M" or "U"
 ;
 ;PRC*4.5*333 Modify routine to handle foreign addressing
 ;            correctly for transmitting to Treasury.
 ;
 I $P($G(^RCD(340,DEBTOR,1)),U,9)=1 G QUIT
 N DEBTOR5,ADDR,LENGTH,DEBNR
 ;
 ;get debtor ar address, compare to top address for 'update' documents
 ;
 S DEBTOR5=$G(^RCD(340,DEBTOR,5))
 S ADDR=$$DADD(DEBTOR),ADDR=$P(ADDR,U,1,2)_U_$P(ADDR,U,4,8)
 I +$P(ADDR,U,7)'<2 S $P(ADDR,U,4)="",$P(ADDR,U,5)=""
 S $P(ADDR,U,7)=$$COUNTRY($P(ADDR,U,7))
 I CODE="U",ADDR=DEBTOR5 G QUIT
 ;
 ;set record in temporary global
 ;
 S REC="04      "_$P(^RC(342,1,3),U,5)_"      "
 S DEBNR=$E(SITE,1,3)_$S(FILE=2:0,FILE=440:"V",1:"E")_$TR($J(DEBTOR,14)," ",0),REC=REC_DEBNR
 S REC=REC_$S(CODE="M":"A",1:"U")_2
 F I=1:1:5,7 D
 . S ADDR(I)=$P(ADDR,U,I),LENGTH=$S(I<3:30,I=3:25,I=4:2,I=7:3,1:9)
 . S:I=5 ADDR(5)=$P(ADDR(5),"-")_$P(ADDR(5),"-",2)
 . S REC=REC_$$LJ^XLFSTR($E(ADDR(I),1,LENGTH),LENGTH)
 S REC=REC_$$BLANK^RCTOP1(68)
 S CNTR(2)=CNTR(2)+1,^XTMP("RCTOPD",$J,2,CNTR(2))=REC
 ;
 ;set TOP address in ar debtor file
 ;
 S ^RCD(340,DEBTOR,5)=ADDR
 ;
QUIT Q
DADD(RCDB,RCCONF) ;
 N X
 S X="" G:$G(RCDB)="" Q
 I RCDB?1N.N S RCDB=$P($G(^RCD(340,RCDB,0)),"^")
 ; the confidential address has greatest priority for mailing
 I $G(RCCONF),RCDB["DPT(" S X=$$PAT^RCAMADD(+RCDB,1) I X'="" G Q
 ; the AR DEBTOR address (if exists) has a greater priority the permanent address in PATIENT file.
 I RCDB["DPT(" S X=$$ARDEB(+$O(^RCD(340,"B",RCDB,0))) S:$P(X,U)]"" $P(X,U,8)=$P(^DPT(+RCDB,.11),U,10) I ($P(X,U)'=""),($P(X,U,4)'=""),($P(X,U,5)'=""),(($P(X,U,6)'="")!($P(X,U,8)'="")) G Q
 I RCDB["DPT(" S X=$$PAT(+RCDB,0) G Q
 I RCDB["DIC(4" S X=$$INST^RCAMADD(+RCDB) G Q
 I RCDB["PRC(440," S X=$$VEN^RCAMADD(+RCDB) G Q
 I RCDB["DIC(36," S X=$$INSUR^RCAMADD(+RCDB) G Q
 I RCDB["VA(200," S X=$$PER^RCAMADD(+RCDB)
Q Q X
ARDEB(RCDB) ;Get address from AR Debtor file (340)
 NEW X,Y
 S X="" G:'$D(^RCD(340,+$G(RCDB),0)) Q6 S X=$P($G(^RCD(340,RCDB,1)),U,1,8)
 S:$P(X,U,5) $P(X,U,5)=$P($G(^DIC(5,+$P(X,U,5),0)),U,2)
Q6 Q X
PAT(RCDB,RCCONF) ;Get patient address as "Str1^Str2^Str3^City^State^ZIP^Telephone" from ^DPT
 ; if RCCONF=0 (default), then return patients permanent address
 ; if RCCONF=1, then return confidential address, or NULL
 N DFN,RCX,RCY,II,RCTRY
 I '$D(^DPT(+$G(RCDB),0)) S RCX="" G Q3
 S DFN=RCDB S RCY=$G(^DPT(DFN,.11)) I RCY="" S RCX="" G Q3
 S RCX=""
 I $P(RCY,U,10)<2 D  G Q3
 . S RCX=$P(RCY,U,1,6)
 . S:$P(RCX,U,5) $P(RCX,U,5)=$P($G(^DIC(5,+$P(RCX,U,5),0)),U,2)
 . I $D(^DPT(DFN,.13)) S $P(RCX,U,7)=$P(^DPT(DFN,.13),U)
 . S $P(RCX,U,8)="",$P(RCX,U,9)=$S($P(RCY,U,16):1,1:0)
 S RCX=$P(RCY,U,1,3),$P(RCX,U,4)=$E($P(RCY,U,4)_" "_$E($P(RCY,U,8),1,2)_" "_$P(RCY,U,9),1,25)
 S $P(RCX,U,8)=$P(RCY,U,10)
 I $D(^DPT(DFN,.13)) S $P(RCX,U,7)=$P(^DPT(DFN,.13),U)
 S $P(RCX,U,9)=$S($P(RCY,U,16):1,1:0)
Q3 Q RCX
COUNTRY(Z) ;
 N PRCACC
 ;get TOP country code
 I +Z<2 S PRCACC="US" G COUNTRYQ
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
