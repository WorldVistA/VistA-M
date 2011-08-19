PRCB8A2 ;WISC/PLT-PRCB8A CONTINUED ; 08/16/95  3:54 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;.X = record id of file 2100.1 if generated, "" if fail
 ;A is ^1 = FMS documents (fileman) date, ^2 = doc year, ^3 = doc quarter
 ;     ^4 = SITE #, ^5 = transfer from fund control point #, ^6 = $amount
 ;     ^7 = BBFY, ^8 = to fund control point, ^9=fiscal accounting period (mmyy), ^10=cal acct per
 ;PRCID=FMS document id if regenerated
 ;
AT(X,PRCFC,PRCID) ;AT auto document
 N PRCA,PRCB,PRCC,PRCDDT,PRCF,PRCF1,PRCQ,PRCRI,PRCSITE,PRCY,GECSFMS,PRCAP
 N B,Z
 S PRCDDT=$P(PRCFC,"^"),PRCY=$P(PRCFC,"^",2),PRCQ=$P(PRCFC,"^",3)
 S PRCSITE=+$P(PRCFC,"^",4),PRCRI(420.01)=+$P(PRCFC,"^",5),PRCAMT=$P(PRCFC,"^",6)
 S PRCRI("420.01A")=$P(PRCFC,"^",8),PRCAP=$P(PRCFC,"^",9)_"/"_$P(PRCFC,"^",10)
 I $G(PRCID)]"" S PRCRI(2100.1)=+PRCID,PRCID=$P(PRCID,"^",2)
 I $G(PRCID)="" S (X,Z)=PRCSITE_"-FC" D EN1^PRCSUT3 S X="0000"_+$P(X,"-",3),PRCID=PRCSITE_"FC"_$E(X,$L(X)-3,$L(X))
 S PRCY=$$YEAR^PRC0C(PRCY)+0
 I $G(PRCRI(2100.1)) D REBUILD^GECSUFM1(PRCRI(2100.1),"I",$$SEC1^PRC0C(PRCSITE),"Y","Edited Rejected Auto AT Document")
 ;add entry in file 2100.1 if not rejected process
 D:$G(PRCRI(2100.1))=""  G EXIT:PRCRI(2100.1)<1
 . D CONTROL^GECSUFMS("I",PRCSITE,PRCID,"AT",$$SEC1^PRC0C(PRCSITE),0,"Y","Original Auto AT Document")
 . S PRCRI(2100.1)=GECSFMS("DA")
 . QUIT
 D SETPARAM^GECSSDCT(PRCRI(2100.1),$P($TR(PRCFC,"^","/"),"/",1,8)_"//"_PRCAP)
 S PRCC=1,PRCB(PRCC)=""
 D ATDOC,DLM("~")
 D ATLIN,DLM("~{")
 S PRCA="" F  S PRCA=$O(PRCB(PRCA)) Q:'PRCA  D SETCS^GECSSTAA(PRCRI(2100.1),PRCB(PRCA))
 D SETSTAT^GECSSTAA(PRCRI(2100.1),"Q")
EXIT S X=$G(PRCRI(2100.1))_"^"_PRCID
 QUIT
ATDOC ;assemble AT doc
 D DOCREQ^PRC0C("^"_PRCSITE_"^"_PRCRI(420.01)_"^"_$E(PRCY,3,4)_"^"_$P(PRCFC,"^",7),"AB","PRCF")
 D DOCREQ^PRC0C("^"_PRCSITE_"^"_PRCRI("420.01A")_"^"_$E(PRCY,3,4)_"^"_$P(PRCFC,"^",7),"AB","PRCF1")
 D STR("AT1",3),STR("AT",2),STR(PRCID,11)
 D STR($E(PRCDDT,4,5),2),STR($E(PRCDDT,6,7),2),STR($E(PRCDDT,2,3),2)
 D STR($E(PRCAP,1,2),2),STR($E(PRCAP,3,4),2),STR($E($P(PRCF,"^",6),3,4),2),STR($S($P(PRCF,"^",6)=$P(PRCF,"^",7):"",1:$E($P(PRCF,"^",7),3,4)),2)
 D STR($P(PRCF,"^",5),6)
 QUIT
 ;
ATLIN ;assemble AT line
 D STR("LIN",3),DLM("~")
 D STR("ATA",3)
 D STR($S($G(PRCF("AO"))="N":"",1:$P(PRCF,"^")),4)
 D STR($S($G(PRCF("SITE"))="N":"",1:PRCSITE),7)
 D STR($S($G(PRCF("PGM"))="N":"",1:$P(PRCF,"^",2)),9)
 D STR($S($G(PRCF("OC"))="N":"",1:$P(PRCF,"^",4)),4)
 D STR(PRCQ,1)
 S X=$$DATE^PRC0C(PRCDDT,"I"),X=$S(PRCY_"^"_PRCQ]$P(X,"^",1,2):"A",1:"Y") D STR(X,1)
 D STR($S($G(PRCF1("AO"))="N":"",1:$P(PRCF1,"^")),4)
 D STR($S($G(PRCF1("SITE"))="N":"",1:PRCSITE),7)
 D STR($S($G(PRCF1("PGM"))="N":"",1:$P(PRCF1,"^",2)),9)
 D STR($S($G(PRCF1("OC"))="N":"",1:$P(PRCF1,"^",4)),4)
 D STR(PRCQ,1),STR($FN(PRCAMT,"-",2),15)
 QUIT
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
FMSACC(A,B) ;convert to field .01 in file 420.141 format
 N C
 S C=A,$P(C,"~",2)=$P(B,"^",6),$P(C,"~",3)=$P(B,"^",5)
 S $P(C,"~",4)=$P(B,"^"),$P(C,"~",5)=$P(B,"^",2),$P(C,"~",6)=$P(B,"^",3)
 S $P(C,"~",7)=$P(B,"^",4),$P(C,"~",8)=$P(B,"^",10)
 QUIT C
 ;
