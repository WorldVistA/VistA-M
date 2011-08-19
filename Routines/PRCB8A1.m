PRCB8A1 ;WISC/PLT-PRCB8A CONTINUED ; 08/16/95  3:29 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;.X = record id of file 2100.1 if generated, "" if fail
 ;PRCFC is ^1 = FMS documents (fileman) date, ^2 = doc year, ^3 = doc quarter
 ;     ^4 = SITE #
 ;     ^5 = transfer from control point #, ^6 = $amount, 
 ;     ^7 = BBFY, ^8 = to fund control point #, ^9=fiscal accounting period (mmyy), ^10=Cal acct per
 ;PRCID=FMS document id if regenerated
ST(X,PRCFC,PRCID) ;ST auto document
 N PRCA,PRCB,PRCC,PRCDDT,PRCF,PRCF1,PRCQ,PRCRI,PRCSITE,PRCY,GECSFMS,PRCAP
 N A,B,Z
 S PRCDDT=$P(PRCFC,"^"),PRCY=$P(PRCFC,"^",2),PRCQ=$P(PRCFC,"^",3)
 S PRCSITE=+$P(PRCFC,"^",4),PRCRI(420.01)=+$P(PRCFC,"^",5),PRCAMT=$P(PRCFC,"^",6)
 S PRCRI("420.01A")=$P(PRCFC,"^",8),PRCAP=$P(PRCFC,"^",9)_"/"_$P(PRCFC,"^",10)
 I $G(PRCID)]"" S PRCRI(2100.1)=+PRCID,PRCID=$P(PRCID,"^",2)
 I $G(PRCID)="" S (X,Z)=PRCSITE_"-FC" D EN1^PRCSUT3 S X="0000"_+$P(X,"-",3),PRCID=PRCSITE_"FC"_$E(X,$L(X)-3,$L(X))
 S PRCY=$$YEAR^PRC0C(PRCY)+0
 I $G(PRCRI(2100.1)) D REBUILD^GECSUFM1(PRCRI(2100.1),"I",$$SEC1^PRC0C(PRCSITE),"Y","Edited Rejected Auto ST Document")
 ;add entry in file 2100.1 if not rejected process
 D:$G(PRCRI(2100.1))=""  G EXIT:PRCRI(2100.1)<1
 . D CONTROL^GECSUFMS("I",PRCSITE,PRCID,"ST",$$SEC1^PRC0C(PRCSITE),0,"Y","Original Auto ST Document")
 . S PRCRI(2100.1)=GECSFMS("DA")
 . QUIT
 D SETPARAM^GECSSDCT(PRCRI(2100.1),$P($TR(PRCFC,"^","/"),"/",1,8)_"//"_PRCAP)
 S PRCC=1,PRCB(PRCC)=""
 D STDOC,DLM("~")
 D STLIN,DLM("~{")
 S PRCA="" F  S PRCA=$O(PRCB(PRCA)) Q:'PRCA  D SETCS^GECSSTAA(PRCRI(2100.1),PRCB(PRCA))
 D SETSTAT^GECSSTAA(PRCRI(2100.1),"Q")
EXIT S X=$G(PRCRI(2100.1))_"^"_PRCID
 QUIT
 ;
STDOC ;assemble ST doc
 D DOCREQ^PRC0C("^"_PRCSITE_"^"_PRCRI(420.01)_"^"_$E(PRCY,3,4)_"^"_$P(PRCFC,"^",7),"SAB","PRCF")
 D DOCREQ^PRC0C("^"_PRCSITE_"^"_PRCRI("420.01A")_"^"_$E(PRCY,3,4)_"^"_$P(PRCFC,"^",7),"SAB","PRCF1")
 D STR("ST2",3),STR($E(PRCDDT,4,5),2),STR($E(PRCDDT,6,7),2),STR($E(PRCDDT,2,3),2)
 D STR($E(PRCAP,1,2),2),STR($E(PRCAP,3,4),2),STR($E($P(PRCF,"^",6),3,4),2),STR($S($P(PRCF,"^",6)=$P(PRCF,"^",7):"",1:$E($P(PRCF,"^",7),3,4)),2)
 D STR($P(PRCF,"^",5),6)
 QUIT
 ;
STLIN ;assemble ST line
 D STR("LIN",3),DLM("~"),STR("STA",3)
 D STR($S($G(PRCF("AO"))="N":"",1:$P(PRCF,"^")),4)
 D STR($S($G(PRCF("SITE"))="N":"",1:PRCSITE),7)
 D STR($S($G(PRCF("FCPRJ"))="N":"",1:$P(PRCF,"^",3)),9)
 D STR($S($G(PRCF("OC"))="N":"",1:$P(PRCF,"^",4)),4)
 D STR(PRCQ,1)
 S X=$$DATE^PRC0C(PRCDDT,"I"),X=$S(PRCY_"^"_PRCQ]$P(X,"^",1,2):"A",1:"Y") D STR(X,1)
 D STR($S($G(PRCF1("AO"))="N":"",1:$P(PRCF1,"^")),4)
 D STR($S($G(PRCF1("SITE"))="N":"",1:PRCSITE),7)
 D STR($S($G(PRCF1("FCPRJ"))="N":"",1:$P(PRCF1,"^",3)),9)
 D STR($S($G(PRCF1("OC"))="N":"",1:$P(PRCF1,"^",4)),4)
 D STR(PRCQ,1),STR($FN(PRCAMT,"-",2),15)
 QUIT
 ;
 ;
 ;A = data, B = field length
STR(A,B) ;store data in node/piece
 S:$L(PRCB(PRCC))+$L(A)>230 PRCC=PRCC+1,PRCB(PRCC)=""
 S PRCB(PRCC)=PRCB(PRCC)_$E(A,1,B)_"^"
 QUIT
 ;
DLM(A) ;store seg ~ or txn { delimiters
 S PRCB(PRCC)=PRCB(PRCC)_A
 QUIT
 ;
