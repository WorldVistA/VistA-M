SYNTSTRS ; HC/art - HealthConcourse - test rest services ;08/12/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
EN ;Run service tests
 ;
 W #,!,?10,"HealthConcourse Get VistA Data REST Services Unit Tests",!
 ;
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="SO^A:API Unit Tests;G:General Service Testing;I:ICN Batch Tests;U:Service Unit Tests:API Unit Tests"
 S DIR("A")="Type"
 ;S DIR("B")=""
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) QUIT
 N TYPE S TYPE=Y
 ;
 I TYPE="U" D UT
 I TYPE="G" D UI
 I TYPE="A" D EN^SYNTSTAPI
 I TYPE="I" D
 . N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 . S DIR(0)="NAO^0:99999999"
 . S DIR("A")="Number of ICNs, 0 for All: "
 . ;S DIR("B")=""
 . S DIR("?")="Enter the number of ICNs to use for each service call test, or 0 for all ICNs."
 . D ^DIR
 . QUIT:$D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)
 . QUIT:Y=""
 . N NBR S NBR=Y
 . N STARTTM S STARTTM=$$NOW^XLFDT()
 . D ctrl^SYNDTS89(NBR)
 . N ENDTM S ENDTM=$$NOW^XLFDT()
 . N ELAPSED S ELAPSED=$$FMDIFF^XLFDT(ENDTM,STARTTM,3)
 . W !,"Start time:   ",$$FMTE^XLFDT(STARTTM,7),!
 . W "End time:     ",$$FMTE^XLFDT(ENDTM,7),!
 . W "Elapsed time: ",ELAPSED,!
 ;
 QUIT
 ;
 ;--------------------------------------------------------------------------
 ;
UT ;unit test for get VistA data REST services
 ; The SYN REST UNIT TESTS FILE (#2002.1) contains a record for each unit test URL
 ;  .01   URL (RFJ245), [0;1]
 ;  1     PASS/FAIL (RS), [0;2]
 ;
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="SABO^A:All services;O:One service"
 S DIR("A")="Mode (A)ll or (O)ne: "
 ;S DIR("B")=""
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) QUIT
 N MODE S MODE=Y
 ;
 N SERVER S SERVER=$$GETSERVER()
 I MODE="O" N ONAME S ONAME=$$GETSERVICE()
 ;
 K ^synUnitTestLog
 N LASTRS S LASTRS=""
 N CNTKER S CNTKER=0
 N CNTERR S CNTERR=0
 N TOTTEST S TOTTEST=0
 N CNTPASS S CNTPASS=0
 N TOTPASS S TOTPASS=0
 N TOTFAIL S TOTFAIL=0
 N STARTTM S STARTTM=$$NOW^XLFDT()
 ;
 N RET,RETDATA,RETHDR,STR,URL,URLNAME,URLIEN,URLDESC,URLSTR,URLSRVC,PF,IENS,IDX,TIMEOUT,POS,ANOMALY
 N IEN S IEN=0
 ;F  S IEN=$O(^SYN(2002.1,IEN)) QUIT:IEN>274  D
 F  S IEN=$O(^SYN(2002.1,IEN)) QUIT:'+IEN  D
 . S URL=$$GET1^DIQ(2002.1,IEN,.01)
 . S URLNAME=$P($P(URL,"/",4),"?",1)
 . S URLSRVC=($P(URL,"/",4))
 . S URLSTR=SERVER_URLSRVC
 . I MODE="O",URLNAME'=ONAME QUIT
 . S TOTTEST=TOTTEST+1
 . S PF=$$GET1^DIQ(2002.1,IEN,1,"I")
 . S:PF="P" TOTPASS=TOTPASS+1
 . S:PF="F" TOTFAIL=TOTFAIL+1
 . S URLDESC=""
 . I URLNAME'="" D
 . . S URLIEN=$O(^RGNET(996.52,"B",URLNAME,""))
 . . S IENS=1_","_URLIEN_","
 . . S URLDESC=$$GET1^DIQ(996.52099,IENS,.01)
 . W:URLNAME'=LASTRS !,"-------------------------------------------------------------------",!
 . S LASTRS=URLNAME
 . W !,"***** ",IEN," * ",URLNAME," * ",URLDESC,$S(URL["JSON=J":" (JSON)",1:""),$S(PF="F":" * (Fail)",1:" * (Pass)"),!!
 . W "URL: ",URLSTR,!
 . ; call the service
 . S TIMEOUT=30
 . I (URL["DEMRNG")!(URL["DEMALL") S TIMEOUT=600
 . ;                    (URL,XT8FLG,XT8RDAT,XT8RHDR,XT8SDAT,XT8SHDR,REDIR)
 . S RET=$$GETURL^XTHC10(URLSTR,TIMEOUT,"RETDATA","RETHDR")
 . ; check status of web call
 . I +RET'=200 D  QUIT
 . . W ">>Error from Kernel call: ",+RET_":"_$P(RET,U,2),!!
 . . S CNTKER=CNTKER+1
 . . S:PF="P" ANOMALY(IEN)="Test should pass"
 . . S ^synUnitTestLog(IEN)=">>Error from Kernel call: "_+RET_":"_$P(RET,U,2)_$S(PF="P":"  Test should pass",1:"")
 . S POS=$O(RETDATA(""))
 . I POS="" D  QUIT
 . . W ">>Error: no data returned: ",RET,!!
 . . S CNTERR=CNTERR+1
 . . S:PF="P" ANOMALY(IEN)="Test should pass"
 . . S ^synUnitTestLog(IEN)=$S(PF="F":"Expected ",1:"")_">>Error: no data returned: "_RET_$S(PF="P":"  Test should pass",1:"")
 . I ($P(RETDATA(POS),U,1)=-1)!(RETDATA(POS)["error")!(RETDATA(POS)["ERROR") D  QUIT
 . . W ">>Error from service: ",RETDATA(POS),!!
 . . S CNTERR=CNTERR+1
 . . S:PF="P" ANOMALY(IEN)="Test should pass"
 . . S ^synUnitTestLog(IEN)=$S(PF="F":"Expected ",1:"")_">>Error from service: "_RETDATA(POS)_$S(PF="P":"  Test should pass",1:"")
 . S:PF="F" ANOMALY(IEN)="Test should fail"
 . I MODE="O" D
 . . W "Returned data:",!
 . . N x S x=""
 . . F  S x=$O(RETDATA(x)) QUIT:x=""  D
 . . . W RETDATA(x)
 . . . N y S y=""
 . . . F  S y=$O(RETDATA(x,y)) QUIT:y=""  D
 . . . . W RETDATA(x,y)
 . . W !!
 . E  D
 . . W $S($D(RETDATA(POS,1)):"Partial return data: ",1:"Returned data: "),RETDATA(POS),!!
 . S ^synUnitTestLog(IEN)="Passed"
 . S CNTPASS=CNTPASS+1
 ;
 N ENDTM S ENDTM=$$NOW^XLFDT()
 N ELAPSED S ELAPSED=$$FMDIFF^XLFDT(ENDTM,STARTTM,3)
 W !,"-------------------------------------------------------------------",!!
 W "Total tests:   ",$J(TOTTEST,6),!
 W "Total to pass: ",$J(TOTPASS,6),?33,"Passed: ",$J(CNTPASS,6),!
 W "Total to fail: ",$J(TOTFAIL,6),?33,"Failed: ",$J(CNTKER+CNTERR,6),!
 W ?35,"Kernel call:  ",$J(CNTKER,6),!
 W ?35,"Service call: ",$J(CNTERR,6),!
 ;
 W !,"Start time:   ",$$FMTE^XLFDT(STARTTM,7),!
 W "End time:     ",$$FMTE^XLFDT(ENDTM,7),!
 W "Elapsed time: ",ELAPSED,!
 ;
 S ^synUnitTestLog(0)="HealthConcourse Get VistA Data REST Services Unit Tests"
 S ^synUnitTestLog(.01)="System: "_SERVER
 S ^synUnitTestLog(.1)="Total tests:   "_$J(TOTTEST,6)
 S ^synUnitTestLog(.2)="Total to pass: "_$J(TOTPASS,6)_"    Passed: "_$J(CNTPASS,6)
 S ^synUnitTestLog(.3)="Total to fail: "_$J(TOTFAIL,6)_"    Failed: "_$J(CNTKER+CNTERR,6)
 S ^synUnitTestLog(.4)="Kernel call errors:  "_$J(CNTKER,6)
 S ^synUnitTestLog(.5)="Service call errors: "_$J(CNTERR,6)
 S ^synUnitTestLog(.6)="Start time:   "_$$FMTE^XLFDT(STARTTM,7)
 S ^synUnitTestLog(.7)="End time:     "_$$FMTE^XLFDT(ENDTM,7)
 S ^synUnitTestLog(.8)="Elapsed time: "_ELAPSED
 ;
 I $D(ANOMALY) D
 . W !,"Anomalies:",!
 . W "Test",?9,"Comment",!
 . S x=""
 . F  S x=$O(ANOMALY(x)) QUIT:x=""  D
 . . W "  ",x,?9,ANOMALY(x),!
 . . S ^synUnitTestLog(.9,x)=ANOMALY(x)_" - "_x
 ;
 QUIT
 ;
 ;--------------------------------------------------------------------------
 ;
UI ;User Interface to run service tests
 ;
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="SB^P:Pick from lists;U:Enter URL"
 S DIR("A")="Mode: (P)ick from lists, or enter (U)RL"
 ;S DIR("B")=""
 S DIR("?")="Enter P or U"
 S DIR("??")="Enter P or U"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) QUIT
 N MODE S MODE=Y
 ;
 N URL S URL=""
 I MODE="P" D
 . N SERVER S SERVER=$$GETSERVER()
 . QUIT:SERVER=""
 . N SERVICE S SERVICE=$$GETSERVICE()
 . QUIT:SERVICE=""
 . N PARAMS S PARAMS=$$GETPARAMS()
 . S URL=SERVER_SERVICE_PARAMS
 E  D
 . S URL=$$GETURL()
 ;
 QUIT:URL=""
 ;
 W !!,"URL: ",URL,!
 ;
 N TIMEOUT S TIMEOUT=30
 I (URL["DEMRNG")!(URL["DEMALL") S TIMEOUT=300
 N RETDATA,RETHDR
 N RET S RET=$$GETURL^XTHC10(URL,TIMEOUT,"RETDATA","RETHDR")
 ; check status of web call
 I +RET'=200 D  QUIT
 . W ">>Error from Kernel call: ",+RET_":"_$P(RET,U,2),!!
 N POS S POS=$O(RETDATA(""))
 I POS="" D  QUIT
 . W ">>Error: no data returned: ",RET,!!
 I ($P(RETDATA(POS),U,1)=-1)!(RETDATA(POS)["error")!(RETDATA(POS)["ERROR") D  QUIT
 . W ">>Error from service: ",RETDATA(POS),!!
 W "Returned data:",!
 N x S x=""
 F  S x=$O(RETDATA(x)) QUIT:x=""  D
 . W RETDATA(x)
 . N y S y=""
 . F  S y=$O(RETDATA(x,y)) QUIT:y=""  D
 . . W RETDATA(x,y)
 W !!
 ;
 QUIT
 ;
 ;----------------- functions -----------------
 ;
GETSERVER() ;Choose a server name
 ;Returns a server name
 ;
 N STR,n,SERVERS,SERVER,DESC
 S SERVERS(1)="http://localhost:9080/"_U_"localhost"
 W !,"Servers:",!
 W 1,?3,$P(SERVERS(1),"/",3),!
 ;F n=1:1 S STR=$P($T(urlli+n),";;",2) QUIT:STR["urlend"  D
 F n=1:1 S STR=$P($T(urlli+n^SYNDTS89),";;",2) QUIT:STR["urlend"  D
 . S SERVER=$$TRIM^XLFSTR($P(STR,";",1))
 . S DESC=$$TRIM^XLFSTR($P(STR,";",2))
 . S SERVERS(n+1)=SERVER_U_DESC
 . W n+1,?3,$P(STR,"/",3),"   (",$P(SERVERS(n+1),U,2),")",!
 ;
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="LA^1:"_n
 S DIR("A")="Choose a Server: "
 ;S DIR("B")=""
 S DIR("?")="Enter Server Number (1-"_n_")"
 S DIR("??")="Enter Server Number (1-"_n_")"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) QUIT ""
 N SERVNBR S SERVNBR=+Y
 W !
 ;
 QUIT $P($G(SERVERS(SERVNBR)),U,1)
 ;
GETSERVICE() ;Choose a service name
 ;Returns a service name
 ;
 N RSNBR S RSNBR=0
 N RSCNT,RSNAMES
 N RSNAME S RSNAME=""
 F  S RSNAME=$O(^RGNET(996.52,"B",RSNAME)) QUIT:RSNAME=""  D
 . QUIT:$E(RSNAME,1,3)'="DHP"
 . QUIT:RSNAME["/"
 . S RSNBR=RSNBR+1
 . S RSNAMES(RSNBR)=RSNAME
 . ;W !,RSNBR,"  ",RSNAMES(RSNBR)
 ;
 N RSLAST S RSLAST=0
 N ITEMCNT S ITEMCNT=0
 S RSNBR=""
 W !!,"Service Names:"
 F  S RSNBR=$O(RSNAMES(RSNBR)) QUIT:RSNBR=""  D
 . S ITEMCNT=ITEMCNT+1
 . S RSLAST=RSNBR
 . I ITEMCNT=3 D
 . . W !,RSNBR-2,"  ",RSNAMES(RSNBR-2),?26,RSNBR-1,"  ",RSNAMES(RSNBR-1),?52,RSNBR,"  ",RSNAMES(RSNBR)
 . . S ITEMCNT=0
 W:ITEMCNT=1 !,RSLAST,"  ",RSNAMES(RSLAST)
 W:ITEMCNT=2 !,RSLAST-1,"  ",RSNAMES(RSLAST-1),?26,RSLAST,"  ",RSNAMES(RSLAST)
 W !
 ;
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="LA^1:"_RSLAST
 S DIR("A")="Choose a Service: "
 ;S DIR("B")=""
 S DIR("?")="Enter Service Number (1-"_RSLAST_")"
 S DIR("??")="Enter Service Number (1-"_RSLAST_")"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) QUIT ""
 N RSNBR S RSNBR=+Y
 ;
 QUIT RSNAMES(RSNBR)
 ;
GETPARAMS() ;Define the Parameter(s)
 ;Returns a parameter list
 ;
 W !!,"Define Parameter(s)",!
 N PARAMS S PARAMS=""
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 N PNBR
 F PNBR=1:1 D  QUIT:Y=""
 . S DIR(0)="FAO^3:50"
 . S DIR("A")="P"_PNBR_": "
 . ;S DIR("B")=""
 . S DIR("?")="Enter NAME=VALUE"
 . S DIR("??")="Enter NAME=VALUE"
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) S Y="" QUIT
 . N PARAM S PARAM=Y
 . I PARAM'="",PARAMS'="" S PARAMS=PARAMS_"&"_PARAM
 . I PARAM'="",PARAMS="" S PARAMS="?"_PARAM
 ;
 QUIT PARAMS
 ;
GETURL() ;Enter a URL
 ;Returns a string that should be a URL
 ;
 W !!,"Enter a URL",!
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FAO^0:245"
 S DIR("A")="URL: "
 ;S DIR("B")=""
 S DIR("?")="Enter a URL"
 S DIR("??")="Enter a URL - server/service?parameters"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) S Y="" QUIT ""
 N URL S URL=Y
 ;
 QUIT URL
 ;
 ;------------------- data -------------------
 ;
urlli ; list of url roots
 ;;http://localhost:9080/;   AWS dev %webreq
 ;;http://ec2-18-208-29-125.compute-1.amazonaws.com:8001/;awsdev;                AWS dev
 ;;http://ec2-18-208-29-125.compute-1.amazonaws.com:9080/;awsdevshm;             AWS dev shim
 ;;https://vista.dev.openplatform.healthcare/rgnet-web/;k8dev;                   k8 dev
 ;;https://vista.dev.openplatform.healthcare/vpr-web/;k8devshm;                  k8 dev shim
 ;;https://vista.demo-staging.openplatform.healthcare/rgnet-web/;k8demstag;      k8 demo-staging
 ;;https://vista.demo-staging.openplatform.healthcare/rgnet-web/;k8demstagshm;   k8 demo-staging shim
 ;;https://vista.demo.openplatform.healthcare/rgnet-web/;k8demo;                 k8 demo
 ;;https://vista.demo.openplatform.healthcare/vpr-web/;k8demoshm;                k8 demo shim
 ;;https://vista-general.dev.openplatform.healthcare/rgnet-web/;targen;          tardis general
 ;;https://vista-general.dev.openplatform.healthcare/vpr-web/;targenshm;         tardis general shim
 ;;https://vista-emergency.dev.openplatform.healthcare/rgnet-web/;taremer;       tardis emergency
 ;;https://vista-emergency.dev.openplatform.healthcare/vpr-web/;taremershm;      tardis emergency shim
 ;;https://vista-specialization.dev.openplatform.healthcare/rgnet-web/;tarspec;  tardis specialization
 ;;https://vista-specialization.dev.openplatform.healthcare/vpr-web/;tarspecshm; tardis specialization shim
 ;;http://shadow.vistaplex.org/;shadvplex;                                       GT.M server
 ;;http://syn.vistaplex.org/;synvplex;                                           GT.M server
 ;;http://localhost:8001/;localhost;                                             localhost
 ;;http://localhost:9080/;localhostshm;localhost shim
 ;;https://vista-sync.dev.openplatform.healthcare/rgnet-web/;gold;
 ;;https://vista-sync.dev.openplatform.healthcare/vpr-web/;goldshm;
 ;;urlend
 Q
 ;
