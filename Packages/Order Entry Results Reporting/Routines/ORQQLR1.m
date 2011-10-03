ORQQLR1 ; slc/CLA - Extrinsic functions and procedures which return patient lab results ;7/23/96  12:47
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**6,51,74,143**;Dec 17, 1997
OETOLAB(ORNUM) ;extrinsic funct to get a lab order number from an oe/rr number
 N LRNUM
 S LRNUM=$G(^OR(100,ORNUM,4))
 Q +LRNUM
 ;
PRINTNAM(LRIEN) ;extrinsic function to return the print name for an entry in the Lab file [#60]
 Q:+$G(LRIEN)<1 ""
 N NODE,NAME
 S NODE=$G(^LAB(60,LRIEN,.1))
 Q:'$L(NODE) ""
 S NAME=$P(NODE,U)
 Q NAME
 ;
OIRES(PT,OILR,SPEC) ;extrinsic function to return pt's most recent lab results for a lab orderable item in the format:
 ; test id^abbrev test name^result^units^flag^collection d/t
 N RSLT,ORZ
 S ORZ=""
 S RSLT=$$GETDATA^OCXCACHE(.ORZ,"$$OIRESC^ORQQLR1("_PT_","_OILR_","_SPEC_")",PT,)
 Q ORZ
 ;
OIRESC(PT,OILR,SPEC) ;extrinsic function to return pt's most recent lab results for a lab orderable item in the format:
 ; test id^abbrev test name^result^units^flag^collection d/t
 N ORY,ORX,ORN,ORLR,SUB,INVDT,SEQ,ORDG,RESULT
 S SUB="",INVDT=0,SEQ=0,ORY=""
 ;check to make sure the OI is in DG lab
 Q:'$L($G(PT))!('$L($G(OILR))) ORY
 Q:'$L($G(^ORD(101.43,OILR,0))) ORY
 I +$G(SPEC)<1 S SPEC=""
 S ORDG=$$DG^ORQOR1("LAB")
 Q:'$L($G(ORDG)) ORY
 Q:$P(^ORD(101.43,OILR,0),U,5)'=ORDG ORY  ;quit if display grp is not lab
 ;get lab test ien
 S ORX=$P(^ORD(101.43,OILR,0),U,2)
 S ORLR=$S(ORX["~":$P(ORX,"~"),1:$P(ORX,";"))
 ;get lab results
 K ^TMP("LRRR",$J)
 D RR^LR7OR1(PT,"","","","",ORLR,"L",1,SPEC) I $D(^TMP("LRRR",$J,PT)) D
 .S SUB=$O(^TMP("LRRR",$J,PT,SUB)) Q:SUB=""
 .S INVDT=$O(^TMP("LRRR",$J,PT,SUB,INVDT)) Q:'INVDT
 .S SEQ=$O(^TMP("LRRR",$J,PT,SUB,INVDT,SEQ)) Q:'SEQ  D
 ..S RESULT=^(SEQ),ORY=$P(RESULT,U)_U_$P(RESULT,U,15)_U_$P(RESULT,U,2)_U_$P(RESULT,U,4)_U_$P(RESULT,U,3)_U_$P(RESULT,U,5)_U_(9999999-INVDT)
 K ^TMP("LRRR",$J)
 Q ORY
 ;
NATL(PT,NID,SPEC) ;extrinsic function to return pt's most recent lab results for a lab national id in the format:
 ; test id^abbrev test name^result^units^flag^collection d/t
 N RSLT,ORZ
 S ORZ=""
 S RSLT=$$GETDATA^OCXCACHE(.ORZ,"$$NATLC^ORQQLR1("_PT_","_NID_","_SPEC_")",PT,)
 Q ORZ
 ;
NATLC(PT,NID,SPEC) ;extrinsic function to return pt's most recent lab results for a lab national id in the format:
 ; test id^abbrev test name^result^units^flag^collection d/t
 N ORY,ORX,ORN,ORLR,SUB,INVDT,SEQ,ORDG
 S SUB="",INVDT=0,SEQ=0,ORY=""
 I +$G(SPEC)<1 S SPEC=""
 ;get lab results
 K ^TMP("LRRR",$J)
 D RR^LR7OR1(PT,"","","","",NID,"N",1,SPEC) I $D(^TMP("LRRR",$J,PT)) D
 .S SUB=$O(^TMP("LRRR",$J,PT,SUB)) Q:SUB=""
 .S INVDT=$O(^TMP("LRRR",$J,PT,SUB,INVDT)) Q:'INVDT
 .S SEQ=$O(^TMP("LRRR",$J,PT,SUB,INVDT,SEQ)) Q:'SEQ  D
 ..S RESULT=^(SEQ),ORY=$P(RESULT,U)_U_$P(RESULT,U,15)_U_$P(RESULT,U,2)_U_$P(RESULT,U,4)_U_$P(RESULT,U,3)_U_$P(RESULT,U,5)_U_(9999999-INVDT)
 K ^TMP("LRRR",$J)
 Q ORY
 ;
LOCL(PT,LID,SPEC) ;extrinsic function to return pt's most recent lab results for a lab local id in the format:
 ; test id^abbrev test name^result^units^flag^collection d/t
 N RSLT,ORZ
 S ORZ=""
 S RSLT=$$GETDATA^OCXCACHE(.ORZ,"$$LOCLC^ORQQLR1("_PT_","_LID_","_SPEC_")",PT,)
 Q ORZ
 ;
LOCLC(PT,LID,SPEC) ;extrinsic function to return pt's most recent lab results for a lab local id in the format:
 ; test id^abbrev test name^result^units^flag^collection d/t
 N ORY,ORX,SUB,INVDT,SEQ,RESULT
 S SUB="",INVDT=0,SEQ=0,ORY=""
 ;get lab results
 I +$G(SPEC)<1 S SPEC=""
 K ^TMP("LRRR",$J)
 D RR^LR7OR1(PT,"","","","",LID,"L",1,SPEC) I $D(^TMP("LRRR",$J,PT)) D
 .S SUB=$O(^TMP("LRRR",$J,PT,SUB)) Q:SUB=""
 .S INVDT="" F  S INVDT=$O(^TMP("LRRR",$J,PT,SUB,INVDT)) Q:'INVDT  D
 ..S SEQ="" F  S SEQ=$O(^TMP("LRRR",$J,PT,SUB,INVDT,SEQ)) Q:'SEQ!(+$G(RESULT)>0)  D
 ...S ORX=^(SEQ)
 ...I $P(ORX,U,2)'="canc" D  ;if results were not cancelled in lab:
 ....S RESULT=$P(ORX,U,2)
 ....S ORY=$P(ORX,U)_U_$P(ORX,U,15)_U_$P(ORX,U,2)_U_$P(ORX,U,4)
 ....S ORY=ORY_U_$P(ORX,U,3)_U_$P(ORX,U,5)_U_(9999999-INVDT)
 K ^TMP("LRRR",$J)
 Q ORY
 ;
LOCLFORM(PT,LID,SPEC) ;extrinsic function to return formatted most recnt lab
 ;rtn format: 1 (if results)^<print name> <value> <units> <high/low flag>
 ;               (<reference range>) <collection date/time>
 N FRCNT,X
 S X=$$LOCL(PT,LID,SPEC)
 Q:'$L(X) "^No results found."
 S FRCNT="1^"_$P(X,U,2)_" "_$P(X,U,3)_" "_$P(X,U,4)_" "_$P(X,U,5)
 S FRCNT=FRCNT_" ("_$P(X,U,6)_") "_$$FMTE^XLFDT($P(X,U,7),"2P")
 Q FRCNT
