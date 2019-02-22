XOBWTGUX ; OSERHA/SMH - Unit Test Routines for HWSC Port to GT.M;Sep 25, 2018@10:25
 ;;1.0;HwscWebServiceClient;**10001**;September 13, 2010;Build 39
 ;
 ; (c) Sam Habiel 2018
 ; Licensed under Apache 2
 ;
 do EN^%ut($t(+0),3) quit
 ;
STARTUP ; Create HTTPBIN, HTTPBINS Server and post and get services
 ;
 D SHUTDOWN
 N FDA,IEN,DIERR
 S FDA(18.12,"?+1,",.01)="HTTPBIN"
 S FDA(18.12,"?+1,",.03)="80"
 S FDA(18.12,"?+1,",.04)="httpbin.org"
 S FDA(18.12,"?+1,",.06)=1
 ;
 D UPDATE^DIE("E","FDA","IEN")
 ;
 I $D(DIERR) S $EC=",U-FAIL,"
 ;
 D REGREST^XOBWLIB("HTTPBIN-GET","get","ip")
 D REGREST^XOBWLIB("HTTPBIN-POST","post","ip")
 D REGREST^XOBWLIB("HTTPBIN-STREAM","stream","ip")
 ;
 K FDA
 S FDA(18.121,"?+10,"_IEN(1)_",",.01)="HTTPBIN-GET"
 S FDA(18.121,"?+10,"_IEN(1)_",",.06)=1
 S FDA(18.121,"?+11,"_IEN(1)_",",.01)="HTTPBIN-POST"
 S FDA(18.121,"?+11,"_IEN(1)_",",.06)=1
 S FDA(18.121,"?+12,"_IEN(1)_",",.01)="HTTPBIN-STREAM"
 S FDA(18.121,"?+12,"_IEN(1)_",",.06)=1
 ;
 D UPDATE^DIE("E","FDA")
 ;
 I $D(DIERR) S $EC=",U-FAIL,"
 ;
 ; 3.01      SSL ENABLED (S), [3;1]
 ; 3.02      SSL CONFIGURATION (FX), [3;2]
 ; 3.03      SSL PORT (NJ5,0), [3;3]
 ;
 N FDA,IEN,DIERR
 S FDA(18.12,"?+1,",.01)="HTTPBINS"
 S FDA(18.12,"?+1,",.03)="443"
 S FDA(18.12,"?+1,",.04)="httpbin.org"
 S FDA(18.12,"?+1,",3.01)=1
 S FDA(18.12,"?+1,",3.03)=443
 S FDA(18.12,"?+1,",.06)=1
 ;
 D UPDATE^DIE("E","FDA","IEN")
 ;
 I $D(DIERR) S $EC=",U-FAIL,"
 ;
 K FDA
 S FDA(18.121,"?+10,"_IEN(1)_",",.01)="HTTPBIN-GET"
 S FDA(18.121,"?+10,"_IEN(1)_",",.06)=1
 S FDA(18.121,"?+11,"_IEN(1)_",",.01)="HTTPBIN-POST"
 S FDA(18.121,"?+11,"_IEN(1)_",",.06)=1
 S FDA(18.121,"?+12,"_IEN(1)_",",.01)="HTTPBIN-STREAM"
 S FDA(18.121,"?+12,"_IEN(1)_",",.06)=1
 ;
 D UPDATE^DIE("E","FDA")
 ;
 I $D(DIERR) S $EC=",U-FAIL,"
 ;
 N FDA,IEN,DIERR
 S FDA(18.12,"?+1,",.01)="CERT-CHECK"
 S FDA(18.12,"?+1,",.03)=443
 S FDA(18.12,"?+1,",.04)="prod.idrix.eu"
 S FDA(18.12,"?+1,",3.01)=1
 S FDA(18.12,"?+1,",3.03)=443
 S FDA(18.12,"?+1,",.06)=1
 ;
 D UPDATE^DIE("E","FDA","IEN")
 ;
 I $D(DIERR) S $EC=",U-FAIL,"
 ;
 D REGREST^XOBWLIB("CERT-CHECK-URL","secure/")
 ;
 K FDA
 S FDA(18.121,"?+10,"_IEN(1)_",",.01)="CERT-CHECK-URL"
 S FDA(18.121,"?+10,"_IEN(1)_",",.06)=1
 ;
 D UPDATE^DIE("E","FDA")
 ;
 I $D(DIERR) S $EC=",U-FAIL,"
 ;
 quit
 ;
SHUTDOWN ;
 D UNREG^XOBWLIB("HTTPBIN-GET")
 D UNREG^XOBWLIB("HTTPBIN-POST")
 D UNREG^XOBWLIB("HTTPBIN-STREAM")
 D UNREG^XOBWLIB("CERT-CHECK-URL")
 N X F X="HTTPBIN","HTTPBINS","CERT-CHECK" D
 . N FDA,IEN,DIERR
 . S IEN=$$FIND1^DIC(18.12,,"QX",X,"B")
 . I 'IEN QUIT
 . S FDA(18.12,IEN_",",.01)="@"
 . D FILE^DIE("E",$NA(FDA))
 . I $D(DIERR) S $EC=",U-FAIL,"
 quit
 ;
T1 ; @TEST POST Test w/ HTTP to httpbin.org
 N ZZZ,PAYLOAD
 S PAYLOAD(1)="test"
 N STATUS S STATUS=$$POSTGTM^XOBWLIB(.ZZZ,,"HTTPBIN","HTTPBIN-POST",,"application/text",.PAYLOAD)
 D ASSERT(STATUS=200)
 N OUT,ERR
 D DECODE^XLFJSON("ZZZ","OUT","ERR")
 D ASSERT('$D(ERR))
 N DATA S DATA=$TR(OUT("data"),$C(10,13))
 D ASSERT(DATA="test")
 quit
 ;
T2 ; @TEST POST Test w/ HTTPS to httpbin.org
 N ZZZ,PAYLOAD
 S PAYLOAD(1)="test"
 N STATUS S STATUS=$$POSTGTM^XOBWLIB(.ZZZ,,"HTTPBINS","HTTPBIN-POST",,"application/text",.PAYLOAD)
 D ASSERT(STATUS=200)
 N OUT,ERR
 D DECODE^XLFJSON("ZZZ","OUT","ERR")
 D ASSERT('$D(ERR))
 N DATA S DATA=$TR(OUT("data"),$C(10,13))
 D ASSERT(DATA="test")
 quit
 ;
T3 ; @TEST GET Stream Test w/ HTTP to httpbin.org
 N RTN,H
 N STATUS S STATUS=$$GETGTM^XOBWLIB(.RTN,.H,"HTTPBIN","HTTPBIN-STREAM","/20","application/text")
 N CNT S CNT=0
 N I F I=0:0 S I=$O(RTN(I)) Q:'I  S CNT=CNT+1
 D CHKTF^%ut(CNT=20,"20 lines are supposed to be returned")
 D CHKTF^%ut(H("STATUS")=200,"Status is supposed to be 200")
 quit
 ;
T4 ; @TEST GET Test w/ HTTPS to httpbin.org
 N RTN,H
 N STATUS S STATUS=$$GETGTM^XOBWLIB(.RTN,.H,"HTTPBINS","HTTPBIN-GET")
 D ASSERT(STATUS=200)
 D CHKTF^%ut(H("STATUS")=200,"Status is supposed to be 200")
 N OUT,ERR
 D DECODE^XLFJSON("RTN","OUT","ERR")
 D ASSERT(OUT("url")["get")
 quit
 ;
T5 ; @TEST HTTP-AUTH over HTTPS test to httpbin.org
 N FDA,DIERR,IEN
 S FDA(18.12,"?+1,",.01)="HTTPBINS"
 S FDA(18.12,"?+1,",.03)="443"
 S FDA(18.12,"?+1,",.04)="httpbin.org"
 S FDA(18.12,"?+1,",1.01)=1 ; Login Required
 S FDA(18.12,"?+1,",200)="samboo" ; Username
 S FDA(18.12,"?+1,",300)=$$ENCRYP^XOBWPWD("what-a-system") ; Password ; Homage to GFT!
 D UPDATE^DIE("E",$NA(FDA),$NA(IEN))
 D ASSERT('$D(DIERR))
 D REGREST^XOBWLIB("HTTPBIN-AUTH","basic-auth/samboo/what-a-system","ip")
 ;
 K FDA
 S FDA(18.121,"?+10,"_IEN(1)_",",.01)="HTTPBIN-AUTH"
 S FDA(18.121,"?+10,"_IEN(1)_",",.06)=1
 D UPDATE^DIE("E","FDA")
 D ASSERT('$D(DIERR))
 ;
 N RTN,H
 N STATUS S STATUS=$$GETGTM^XOBWLIB(.RTN,,"HTTPBINS","HTTPBIN-AUTH")
 D ASSERT(STATUS=200)
 ; 
 K FDA S FDA(18.12,IEN(1)_",",300)="not-a-system"
 D FILE^DIE("",$NA(FDA))
 D ASSERT('$D(DIERR))
 N ECODE,RTN,H
 D
 . N $ET,$ES S $ET="Q:$ES  S ECODE=$EC,$EC="""""
 . D GETGTM^XOBWLIB(.RTN,.H,"HTTPBINS","HTTPBIN-AUTH")
 D ASSERT(H("STATUS")=401)
 D ASSERT(ECODE=",UXOBWHTTP,")
 ;
 ; Undo
 D UNREG^XOBWLIB("HTTPBIN-AUTH")
 K FDA
 S FDA(18.12,IEN(1)_",",200)="@"
 S FDA(18.12,IEN(1)_",",300)="@"
 D FILE^DIE("",$NA(FDA))
 D ASSERT('$D(DIERR))
 ;
 QUIT
 ;
T6 ; @TEST Test TLS with a Client Cert s/ password
 ;
 ; Create the certificates!
 N %CMD
 S %CMD="openssl req -x509 -nodes -days 365 -sha256 -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -newkey rsa:2048 -keyout /tmp/mycert.key -out /tmp/mycert.pem"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 S %CMD="openssl req -new -nodes -newkey rsa:2048 -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -keyout /tmp/client.key -out /tmp/client.csr"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 S %CMD="openssl x509 -req -in /tmp/client.csr -CA /tmp/mycert.pem -CAkey /tmp/mycert.key -CAcreateserial -out /tmp/client.pem -days 1024 -sha256"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 ; 
 ; Get w/o the certificate
 N H,RTN
 D GETGTM^XOBWLIB(.RTN,.H,"CERT-CHECK","CERT-CHECK-URL")
 D ASSERT($$FIND(.RTN,"Error: No SSL client certificate presented"))
 ;
 N FDA,DIERR
 S FDA(18.12,"?+1,",.01)="CERT-CHECK"
 S FDA(18.12,"?+1,",3.01)=1
 S FDA(18.12,"?+1,",3.02)="/tmp/client.pem"
 S FDA(18.12,"?+1,",3.03)=443
 ;
 D UPDATE^DIE("E",$NA(FDA))
 D ASSERT('$D(DIERR))
 ;
 N H,RTN
 D GETGTM^XOBWLIB(.RTN,.H,"CERT-CHECK","CERT-CHECK-URL")
 D ASSERT($$FIND(.RTN,"www.smh101.com"))
 ;
 ; Clean-up
 N A
 S A("client.pem")=""
 S A("client.csr")=""
 S A("client.key")=""
 S A("mycert.srl")=""
 S A("mycert.key")=""
 S A("mycert.pem")=""
 N % S %=$$DEL^%ZISH("/tmp/",$NA(A))
 D ASSERT(%=1)
 QUIT
 ;
T7 ; #TEST Test TLS with a Client Cert w/ password
 ; NB: This test is disabled as it only works on Ubuntu right now
 ; It fails on Cygwin and CentOS due to how OpenSSL/cURL are compiled.
 ;
 ; Create the certificates (client cert has password now)
 N %CMD
 S %CMD="openssl req -x509 -nodes -days 365 -sha256 -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -newkey rsa:2048 -keyout /tmp/mycert.key -out /tmp/mycert.pem"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 S %CMD="openssl req -new -newkey rsa:2048 -passout pass:monkey1234 -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -keyout /tmp/client.key -out /tmp/client.csr"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 S %CMD="openssl x509 -req -in /tmp/client.csr -CA /tmp/mycert.pem -CAkey /tmp/mycert.key -CAcreateserial -out /tmp/client.pem -days 1024 -sha256"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 ;
 ; Try to curl w/o the password. Curl is supposed to error out.
 N ECODE,RTN,H
 D
 . N $ET,$ES S $ET="Q:$ES  S ECODE=$EC,$EC="""""
 . D GETGTM^XOBWLIB(.RTN,.H,"CERT-CHECK","CERT-CHECK-URL")
 D ASSERT(ECODE=",U-CURL-35,")
 ;
 ; Add the password.
 N FDA,DIERR
 S FDA(18.12,"?+1,",.01)="CERT-CHECK"
 S FDA(18.12,"?+1,",300)=$$ENCRYP^XOBWPWD("monkey1234")
 D UPDATE^DIE("E",$NA(FDA))
 D ASSERT('$D(DIERR))
 ;
 ; Run again. Should work this time.
 D GETGTM^XOBWLIB(.RTN,.H,"CERT-CHECK","CERT-CHECK-URL")
 D ASSERT($$FIND(.RTN,"www.smh101.com"))
 ;
 ; Clean-up
 N A
 S A("client.pem")=""
 S A("client.csr")=""
 S A("client.key")=""
 S A("mycert.srl")=""
 S A("mycert.key")=""
 S A("mycert.pem")=""
 N % S %=$$DEL^%ZISH("/tmp/",$NA(A))
 D ASSERT(%=1)
 QUIT
 ;
T8 ; @TEST - Test Availability checker
 N DIQUIET S DIQUIET=1
 N % S %=$$FIND1^DIC(18.12,,"QX","HTTPBINS","B")
 I '% QUIT
 N VALMCNT,VALMAR,BOO
 S VALMCNT=0,VALMAR="BOO" D AVAILGTM^XOBWU1(%)
 D ASSERT(BOO(1,0)[" OK")
 D ASSERT(BOO(2,0)[" OK")
 D ASSERT(BOO(3,0)[" OK")
 quit
 ;
T9 ; @TEST - RxNorm Interaction API 
 ; curl https://rxnav.nlm.nih.gov/REST/interaction/list.json?rxcuis=207106+152923+656659
 ;
 ; Create Server
 N FDA,IEN,DIERR
 S FDA(18.12,"?+1,",.01)="RXNORM"
 S FDA(18.12,"?+1,",.03)=443
 S FDA(18.12,"?+1,",.04)="rxnav.nlm.nih.gov"
 S FDA(18.12,"?+1,",3.01)=1
 S FDA(18.12,"?+1,",3.03)=443
 S FDA(18.12,"?+1,",.06)=1
 ;
 D UPDATE^DIE("E","FDA","IEN")
 I $D(DIERR) D FAIL^%ut("Fileman Error") QUIT
 ;
 ; Add Service
 D REGREST^XOBWLIB("RXNORM-IXN","REST/interaction/list.json")
 ;
 ; Enable service under server.
 K FDA
 S FDA(18.121,"?+10,"_IEN(1)_",",.01)="RXNORM-IXN"
 S FDA(18.121,"?+10,"_IEN(1)_",",.06)=1
 D UPDATE^DIE("E","FDA")
 I $D(DIERR) D FAIL^%ut("Fileman Error") QUIT
 ;
 N RTN,H
 N STATUS
 S STATUS=$$GETGTM^XOBWLIB(.RTN,.H,"RXNORM","RXNORM-IXN","?rxcuis=207106+152923+656659")
 ;
 D ASSERT(STATUS=200)
 ;
 N OUT,ERR
 D DECODE^XLFJSON("RTN","OUT","ERR")
 ;
 D ASSERT('$D(ERR))
 D ASSERT(OUT("fullInteractionTypeGroup",2,"fullInteractionType",1,"interactionPair",1,"description")]"")
 ;
 ; Delete the Service from everywhere
 D UNREG^XOBWLIB("RXNORM-IXN")
 ;
 ; Delete the Server
 N X F X="RXNORM" D
 . N FDA,IEN,DIERR
 . S IEN=$$FIND1^DIC(18.12,,"QX",X,"B")
 . I 'IEN QUIT
 . S FDA(18.12,IEN_",",.01)="@"
 . D FILE^DIE("E",$NA(FDA))
 . I $D(DIERR) D FAIL^%ut("Fileman Error") QUIT
 quit
 ;
FIND(arr,str) ; [Private] Does arr contain str?
 n i f i=0:0 s i=$o(arr(i)) q:'i  i arr(i)[str quit
 i i'="" q 1
 q 0
 ;
ASSERT(X,Y) ; Shim to M Unit; or not
 I $T(^%ut)]"" D CHKTF^%ut(X,$G(Y)) quit
 I 'X S $EC=",U-FAIL,"
 QUIT
