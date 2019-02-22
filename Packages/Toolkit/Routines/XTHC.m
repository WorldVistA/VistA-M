XTHC ;HCIOFO/SG - HTTP 1.0 CLIENT ; 12/5/18 8:02pm
 ;;7.3;TOOLKIT;**123,10002**;Apr 25, 1995;Build 1
 ;
 ; *10002* changes (c) Sam Habiel 2015-2018
 ; See repository for license terms.
 ; *10002* - TLS/libcurl on GTM/YDB support
 ; ALL CODE IS NEW. Previously routine only had comments.
 ;
 ; API ENTRY POINTS ---- DESCRIPTIONS
 ;
 ;   $$GETURL^XTHC10     Gets the data from the provided URL
 ;
 ;       DEMO^XTHCDEM    Demonstartion entry point
 ;
 ;   $$ENCODE^XTHCURL    Encodes the string
 ;  $$MAKEURL^XTHCURL    Creates a URL from components
 ; $$PARSEURL^XTHCURL    Parses the URL into components
 ; $$NORMPATH^XTHCURL    Returns "normalized" path
 ;
 ;   $$DECODE^XTHCUTL    Decodes one string replacing
 ;                       &lt; <, &gt; >, &amp; &, &nbsp; " ".
 ;
 ; INTERNAL TOOLS ------ DESCRIPTIONS
 ;
 ;  $$RECEIVE^XTHC10A    Reads the HTTP response
 ;  $$REQUEST^XTHC10A    Sends the HTTP request
 ;
 Q
 ;
TEST D EN^%ut($T(+0),3) QUIT
 ;
TGET1 ; @TEST GET via TLS
 N SSS,XXX
 N STATUS S STATUS=$$GETURL^XTHC10("https://httpbin.org/stream/20",1,$NA(SSS),.XXX)
 D CHKTF^%ut(+STATUS=200)
 N CNT S CNT=0
 N I F I=0:0 S I=$O(SSS(I)) Q:'I  I SSS(I)]"" S CNT=CNT+1
 D CHKTF^%ut(CNT=20)
 QUIT
 ;
TGET2 ; @TEST GET example.com
 N STATUS,SSS,XXX S STATUS=$$GETURL^XTHC10("https://example.com",1,$NA(SSS))
 D CHKTF^%ut(+STATUS=200)
 QUIT
 ;
TPOST ; @TEST Test Post
 N PAYLOAD,RTN,H,RET
 N R S R=$R(123423421234)
 S PAYLOAD(1)="KBANTEST ; VEN/SMH - Test routine for Sam ;"_R
 S PAYLOAD(2)=" QUIT"
 N STATUS S STATUS=$$GETURL^XTHC10("https://httpbin.org/post",1,$NA(RTN),.H,$NA(PAYLOAD))
 D CHKTF^%ut(+STATUS=200)
 N DATALINE N I F I=0:0 S I=$O(RTN(I)) Q:'I  I RTN(I)["""data""" S DATALINE=RTN(I)
 D CHKTF^%ut($G(DATALINE)[R)
 QUIT
 ;
TESTH ; @TEST Unit Test with headers
 N RTN
 N HEADER
 S HEADER("DNT")=1
 N STATUS S STATUS=$$GETURL^XTHC10("https://httpbin.org/headers",1,$NA(RTN),,,.HEADER)
 N OK S OK=0
 N I F I=0:0 S I=$O(RTN(I)) Q:'I  I $$UP^XLFSTR(RTN(I))["DNT" S OK=1
 D CHKTF^%ut(+STATUS=200,"Status code is supposed to be 200")
 D CHKTF^%ut(OK,"Couldn't get the sent header back")
 QUIT
 ;
TMI ; @TEST Multiple GETs from Single Domain - Init
 D INIT^XTHC10(0) ; 0 = Don't auto close
 quit
TM1 ; @TEST Multiple GETs from Single Domain - First
 n sss,zzz,status
 s status=$$GETURL^XTHC10("https://rxnav.nlm.nih.gov/REST/ndcstatus.json?ndc=00143314501",1,$NA(sss))
 d CHKEQ^%ut(+status,200)
 quit
TM2 ; @TEST Multiple GETs from Single Domain - Second
 n sss,zzz,status
 s status=$$GETURL^XTHC10("https://rxnav.nlm.nih.gov/REST/drugs?name=cymbalta",1,$NA(sss))
 d CHKEQ^%ut(+status,200)
 quit
TM3 ; @TEST Multiple GETs from Single Domain - Third
 n sss,zzz,status
 s status=$$GETURL^XTHC10("https://rxnav.nlm.nih.gov/REST/termtypes",1,$NA(sss))
 d CHKEQ^%ut(+status,200)
 quit
TM4 ; @TEST Multiple GETs from Single Domain - Fourth
 n sss,zzz,status
 s status=$$GETURL^XTHC10("https://rxnav.nlm.nih.gov/REST/brands?ingredientids=8896+20610",1,$NA(sss))
 d CHKEQ^%ut(+status,200)
 quit
TM5 ; @TEST Multiple GETs from Single Domain - Fifth
 n sss,zzz,status
 s status=$$GETURL^XTHC10("https://rxnav.nlm.nih.gov/REST/brands?ingredientids=8896+20610",1,$NA(sss))
 d CHKEQ^%ut(+status,200)
 quit
TM6 ; @TEST Mulitple GETs from Single Domain - Sixth
 n sss,zzz,status
 s status=$$GETURL^XTHC10("https://rxnav.nlm.nih.gov/REST/approximateTerm?term=zocor%2010%20mg&maxEntries=4",1,$NA(sss))
 d CHKEQ^%ut(+status,200)
 quit
TMC ; @TEST Multiple GETs from Single Domain - Cleanup
 d CLEANUP^XTHC10
 quit
 ;
