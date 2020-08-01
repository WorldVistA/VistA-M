SYNDTS89 ;AFHIL/HC/fjf - HealthConcourse - REST service tester ;03/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ; This routine tests the Health Concourse GETter REST services
 ;
 ; It specifically tests those services that have a request URL in the following format:
 ; http://ip-address-port/endpoint?ICN=icn&JSON=flag
 ; the architecture can be extended to accommodate those REST services
 ; that don't conveniently fit the above pattern
 ;
 ; the routine currently returns the REST call url for json and non-json
 ; plus the relevant data in the appropriate format for the resource
 ;
ctrl(nopats,server) ;
 ; Input:
 ;   nopats - number of patiens per system
 ;     if nopats is not passed or evaluates to 0 then all patiens
 ;     will be tested
 ;   server -
 ;     if server is not defined in url roots then then all servers
 ;     will be tested
 ;
 ;
 ; create array of urls of systems to be tested
 s server=$g(server,"none")
 d urlrts(server)
 ;
 ; create array of patient data endpoints to be tested
 d endpoints
 ;
 ; start of scan by url by patient by endpoint
 s (icn,url,endpoint)=""
 s nopats=$g(nopats)
 s s=";"
 s urlab=""
 f  s urlab=$o(urlrt(urlab)) q:urlab=""  d
 .s url=urlrt(urlab)
 .; find ICN's in namespace denoted by url+port
 .s icns=$$icnstr(url)
 .i +nopats=0 s nopats=$l(icns,s)
 .s icns=$p(icns,s,1,nopats)
 .w !,"icns ",!,icns,!
 .; for namepace (specified by url+port) scan through ICN's
 .s pats=+$g(nopats)
 .i pats=0 s pats=$l(icns,s)
 .f i=1:1:pats s icn=$p(icns,s,i) q:icn=""  d
 ..;for ICN's scan through endpoints
 ..s endpoint=""
 ..f  s endpoint=$o(endpoints(endpoint)) q:endpoint=""  d
 ...f format="","J" d
 ....; build patient getter REST service URL and make call
 ....s RESTurl=$$RESTurl(url,endpoint,icn,,,format)
 ....w !,RESTurl,!
 ....s RET=$$GETURL^XTHC10(RESTurl,,"PDATA")
 ....i RET'="200^OK" w !,RET q
 ....i '$d(PDATA) w !,"no data" q
 ....s datstr=$$xthc2st(.PDATA)
 ....w !,datstr,!
 Q
 ;
icnstr(url) ; create icn string for system at url
 ; invokes DHPPATICNALL service
 ; Input:
 ;   url of system of interest
 ; Ouput:
 ;   semicolon delimited list of ICN's
 ;
 n s,icnurl,RET,icns
 s s=";"
 s icnurl=url_"DHPPATICNALL?JSON=T"
 s RET=$$GETURL^XTHC10(icnurl,,"icnar")
 i RET'="200^OK" q RET
 s icnar=""
 s icns=$$xthc2st(.icnar)
 q icns
 ;
xthc2st(array) ; combines array elements from XTHC10 into a single string
 ; Input
 ;   array passed by reference
 ;
 n string,n,sub
 s sub=$o(array(""))
 s string=array(sub)
 s n=""
 f  s n=$o(array(sub,n)) q:n=""  d
 .s string=string_array(sub,n)
 .k array(sub,n)
 q string
 ;
RESTurl(url,endpoint,icn,fromdt,todt,format) ; create REST service URL
 ;
 s fromdt=$g(fromdt)
 s todt=$g(todt)
 s format=$g(format)
 s url=url_endpoint_"?ICN="_icn
 s:format'="" url=url_"&JSON="_format
 s:fromdt'="" url=url_"&FRDAT="_fromdt
 s:todt'="" url=url_"&TODAT="_todt
 q url
 ;
urlrts(server) ; set up roots urls for healthConcourse dev
 s server=$g(server,"none")
 k urlrt
 n s,t
 s s=";"
 f i=1:1 s t=$t(urlli+i) q:t["urlend"  d
 .s urlrt($p(t,s,4))=$p(t,s,3)
 i $d(urlrt(server)) d
 .s t=urlrt(server)
 .k urlrt
 .s urlrt(server)=t
 q
 ;
urlli ; list of url roots
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
 q
 ;
endpoints ; for patient data by ICN
 ; pattern is DHPPATxxxxxICN
 ;
 n n,s,q,pat
 s n="",s="/",q=""""
 s pat=1_q_"DHPPAT"_q_"2.5e"_1_q_"ICN"_q_".e"
 f  s n=$o(^RGNET(996.52,"B",n)) q:n=""  d
 .i n?@pat s endpoints($p(n,s))=""
 q
 ;;;;
ts ;
 ;
 s url="http://ec2-18-208-29-125.compute-1.amazonaws.com:8001/"
 s endpoint="DHPPATVITICN"
 s icn="9993306312V376330"
 s RESTurl=$$RESTurl(url,endpoint,icn,,,"J")
 s RET=$$GETURL^XTHC10(RESTurl,,"PDATA")
 q
