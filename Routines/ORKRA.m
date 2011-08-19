ORKRA ; slc/CLA - Order checking support procedure for Radiology ;12/15/97
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**6,92,105**;Dec 17, 1997
 Q
RECENTBA(ORDFN,ORHRS) ; extrinsic function to return the most recent radiology procedure using barium within the past ORHRS in the format:
 ; order #^order text (first 60 chars) order effective date/time
 N BDT,EDT,INBDT,XDT,X,ORDT,HDT,ORN,OROI,ORCM,TOT,ORQ,ORDG
 S X="",ORDT="",HDT="",ORN="",TOT=0,ORQ=""
 Q:+$G(ORDFN)<1 ORQ
 Q:+$G(ORHRS)<1 ORQ
 D NOW^%DTC S EDT=% K %
 S BDT=$$FMADD^XLFDT(EDT,"","-"_ORHRS,"","")
 Q:+$G(BDT)<1 ORQ
 S ORDG=$$DG^ORQOR1("GENERAL RADIOLOGY")
 Q:+$G(ORDG)<1 ORQ
 K ^TMP("ORR",$J)
 D EN^ORQ1(ORDFN_";DPT(",ORDG,1,"",BDT,EDT,0,0)
 S HDT=$O(^TMP("ORR",$J,HDT)) Q:HDT="" ORQ S TOT=^(HDT,"TOT") I TOT>0 D
 .F X=1:1:TOT Q:+$G(ORQ)>0  D  ;quit on 1st barium found (most recent)
 ..S ORN=+^TMP("ORR",$J,HDT,X)
 ..S OROI=$G(^OR(100,ORN,.1,1,0))
 ..Q:+$G(OROI)<1
 ..S ORCM=$$CM^ORQQRA(OROI)
 ..I $G(ORCM)["B" D
 ...S ORDT=$G(^OR(100,ORN,0)) S:$L($G(ORDT)) ORDT=$P(ORDT,U,8)
 ...S ORDT=$$FMTE^XLFDT(ORDT,"2P")
 ...S ORQ=ORN_U_$P($$TEXT^ORKOR(ORN,60),U,2)_" "_$G(ORDT)
 K ^TMP("ORR",$J)
 Q ORQ
RECENTCH(ORDFN,ORDAYS) ;extrinsic function to return the most recent cholecystogram procedure within the past ORDAYS in the format:
 ; order #^order text (first 60 chars) order effective date/time
 N BDT,EDT,INBDT,XDT,X,ORDT,HDT,ORN,OROI,ORCM,TOT,ORQ,ORDG
 S X="",ORDT="",HDT="",ORN="",TOT=0,ORQ=""
 Q:+$G(ORDFN)<1 ORQ
 Q:+$G(ORDAYS)<1 ORQ
 D NOW^%DTC S EDT=% K %
 S BDT=$$FMADD^XLFDT(EDT,"-"_ORDAYS,"","","")
 Q:+$G(BDT)<1 ORQ
 S ORDG=$$DG^ORQOR1("GENERAL RADIOLOGY")
 Q:+$G(ORDG)<1 ORQ
 K ^TMP("ORR",$J)
 D EN^ORQ1(ORDFN_";DPT(",ORDG,1,"",BDT,EDT,0,0)
 S HDT=$O(^TMP("ORR",$J,HDT)) Q:HDT="" ORQ S TOT=^(HDT,"TOT") I TOT>0 D
 .F X=1:1:TOT Q:+$G(ORQ)>0  D  ;quit on 1st cholecyst found (most recent)
 ..S ORN=+^TMP("ORR",$J,HDT,X)
 ..S OROI=$G(^OR(100,ORN,.1,1,0))
 ..Q:+$G(OROI)<1
 ..S ORCM=$$CM^ORQQRA(OROI)
 ..I $G(ORCM)["C" D  ;cholecystogram
 ...S ORDT=$G(^OR(100,ORN,0)) S:$L($G(ORDT)) ORDT=$P(ORDT,U,8)
 ...S ORDT=$$FMTE^XLFDT(ORDT,"2P")
 ...S ORQ=ORN_U_$P($$TEXT^ORKOR(ORN,60),U,2)_" "_$G(ORDT)
 K ^TMP("ORR",$J)
 Q ORQ
TYPE(OI) ;extrinisic function which returns the imaging type for an orderable item
 ;returned as 'RAD','CT','MRI','ANI','CARD','NM','US', or 'VAS'
 N ORTYPE S ORTYPE=""
 S ORTYPE=$G(^ORD(101.43,OI,"RA"))
 S:$L($G(ORTYPE)) ORTYPE=$P(ORTYPE,U,3)
 Q ORTYPE
CMCDAYS(DFN) ;extrinsic function to return number of days to look for 
 ; contrast media serum creatinine result
 Q:'$L(DFN) ""
 N ORLOC,ORENT,ORDAYS
 ;get patient's location flag (INPATIENT ONLY - outpt locations cannot be
 ;reliably determined, and many simultaneous outpt locations can occur):
 S VA200="" D OERR^VADPT
 S ORLOC=+$G(^DIC(42,+VAIN(4),44))
 K VA200,VAIN
 S ORENT=+$G(ORLOC)_";SC(^DIV^SYS^PKG"
 S ORDAYS=$$GET^XPAR(ORENT,"ORK CONTRAST MEDIA CREATININE",1,"I")
 Q:$L(ORDAYS) ORDAYS
 Q ""
