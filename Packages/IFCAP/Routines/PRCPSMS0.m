PRCPSMS0 ;WISC/RFJ-isms trans, build segments: control, line count  ;21 Oct 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CONTROL(V1,V2,V3) ;  build control segment
 ;  v1=station number, v2=transaction code, v3=reference number
 ;  returns 'string' of segment
 I 'V1!(V2="") S STRING="" Q
 N %,%H,%I,DATE,NOW,TIME,X,Y
 D NOW^%DTC S NOW=%,Y=%_"000000" D DD^%DT S TIME=$TR($P(Y,"@",2),":"),X1=$P(NOW,"."),X2=$E(NOW,1,3)_"0101" D ^%DTC S X=X+1,X=$E("000",$L(X)+1,3)_X,DATE=($E(NOW)+17)_$E(NOW,2,3)_X
 S V3=V3_$E("           ",$L(V3)+1,11)
 S STRING="ISM^"_V1_"^^"_V2_"^"_DATE_"^"_TIME_"^"_V3_"^001^001^040^|"
 Q
 ;
 ;
LINECNT(V1,V2) ;  line count segment
 ;  v1=line count, v2=reference number
 ;  returns 'string("lc")' of data
 I $L(V1)>3!($L(V2)>11) S STRING("LC")="" Q
 S STRING("LC")="LC^"_V1_"^"_V2_"^|"
 Q
 ;
 ;
DELETE(DATA) ;  delete segment
 ;  data=itemda
 ;  returns 'string("id")' of data
 N NSN S NSN=$$NSN^PRCPUX1(DATA) I NSN="" S STRING("ID")="" Q
 S STRING("ID")="ID^"_$TR(NSN,"-")_"^|"
 Q
