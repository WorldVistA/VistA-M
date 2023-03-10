ORCACT01 ;SLC/MKB-Validate order actions cont ;Oct 20, 2020@22:36:08
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**94,116,134,141,163,187,190,213,243,306,374,350,397,377,498,580**;Dec 17, 1997;Build 4
 ;
 ;External reference to $$ORCOPY^PSOORCPY supported by ICR 6719
 ;
ES ; -- sign [on chart]
 I ORDSTS=11,VER<3,PKG'="OR" S ERROR="This order cannot be released and must be discontinued!" Q
 N X I ACTSTS=11!(ACTSTS=10) D  Q:$L($G(ERROR))
 . I $P(ORA0,U,2)="DC",$$DONE^ORCACT0 D CANCEL^ORCSEND(+IFN),UNOTIF^ORCSIGN S OREBUILD=1 Q
 . S X=$$DISABLED^ORCACT0 I X S ERROR=$P(X,U,2) Q
 I ACTION="OC",$G(DG)="NV RX" S:MEDPARM<2 ERROR="You are not authorized to release non-VA med orders!" Q
 S X=$P(ORA0,U,4) I X=3 S:ACTSTS'=11&(ACTSTS'=10) ERROR="This order does not require a signature!" Q
 I X=5 S ERROR="This order has been canceled!" Q  ;p580
 I X'=2 S ERROR="This order has been signed!" Q
 N ORCS D CSVALUE^ORDEA(.ORCS,+IFN)
 I DG="O RX",ACTION="RS",$G(NATR)="I",ORCS=1 S ERROR="Controlled Substance outpatient meds may not be released without a clinician's signature!" Q
 I DG="O RX",ACTION'="ES",ACTION'="DS",$G(NATR)'="I" S ERROR="Outpatient meds may not be released without a clinician's signature!" Q
 I (ACTION="ES"!(ACTION="DS")),$D(^XUSEC("ORELSE",DUZ)),$P(OR0,U,16)'<2 S ERROR="You are not privileged to sign this order!" Q
 ;
 I DG="SPLY" D  Q:$D(ERROR)
 . N ORALLOWED,ORAUTHMEDS,ORHASSUPKEY,ORX
 . ; User must have ORSUPPLY or Auth to Write Meds to release supply items
 . S ORHASSUPKEY=$D(^XUSEC("ORSUPPLY",DUZ))
 . S ORAUTHMEDS=1
 . S ORX=$G(^VA(200,DUZ,"PS"))
 . I '$P(ORX,U)!($P(ORX,U,4)&(DT>$P(ORX,U,4))) S ORAUTHMEDS=0
 . I 'ORHASSUPKEY,'ORAUTHMEDS D  Q
 . . S ERROR="You are not authorized to release supply orders."
 . ; only allow release by policy, signed on chart, or ES
 . ; release via verbal or telephone is not allowed
 . S ORALLOWED=0
 . I ACTION?1(1"ES",1"DS",1"OC") S ORALLOWED=1
 . I ACTION="RS",$G(NATR)?1(1"I",1"W") S ORALLOWED=1
 . I 'ORALLOWED S ERROR="Supplies may not be released with this action."
 ;
 I ACTION="OC" S:MEDPARM<2 ERROR="You are not authorized to release med orders!" Q
 ;
 ; Don't allow DC of lab order to be signed/released if its already been accessioned
 I PKG="LR",$P(ORA0,U,2)="DC",$$COLLECTD^ORCACT0 D  Q:$D(ERROR)
 . S ERROR="This order may not be discontinued.                                                                                "
 . S ERROR=ERROR_"Cancel the discontinue to remove it from the patient's record.                                    "
 . S ERROR=ERROR_$$GET^XPAR("ALL","OR LAB CANCEL ERROR MESSAGE",1,"I")
 ;
 I ACTION="RS" D  Q:$D(ERROR)  Q:$G(NATR)'="I"
 . Q:ACTSTS=11  Q:ACTSTS=10  ;unreleased - ok
 . S ERROR="This order has already been released!"
ES1 I PKG="PS" D  ;authorized to write meds?
 . N TYPE,OI,PSOI,DEAFLG,PKI,IVERROR,ORDGNM
 . S X=$G(^VA(200,DUZ,"PS"))
 . I DG'="SPLY",'$P(X,U) S ERROR="You are not authorized to sign med orders!" Q
 . I DG'="SPLY",$P(X,U,4),$$NOW^XLFDT>$P(X,U,4) S ERROR="You are no longer authorized to sign med orders!" Q
 . ;Q:DG="IV RX"  Q:$P(ORA0,U,2)="DC"  ;don't need to ck DEA#
 . Q:$P(ORA0,U,2)="DC"
 . S ORDGNM=$$GET1^DIQ(100,+IFN_",",2)
 . I ORDGNM["FLUID OE" D  Q
 . .S FAIL=$$IVDEACHK(+IFN) I FAIL'=0 S ERROR=FAIL
 . S OI=+$$VALUE^ORX8(+IFN,"ORDERABLE")
 . S PSOI=+$P($G(^ORD(101.43,OI,0)),U,2) Q:PSOI'>0
 . S TYPE=$S($P(DG," ")="O":"O",1:"I"),DEAFLG=$P($$OIDEA^PSSOPKI(PSOI,TYPE),";",2)
 . S DETFLAG=$$OIDETOX^PSSOPKI(PSOI,TYPE)
 . S DETPRO=$$DETOX^XUSER(+$G(DUZ))
 . I DETFLAG,DETPRO="" S ERROR=3 Q
 . I DETFLAG,DETPRO>0 S Y=DETPRO X ^DD("DD") S ERROR="5^"_Y Q
 . I (DEAFLG>0!($$ISCLOZ^ORALWORD(OI))) D  I $G(ERROR)]"" Q
 .. N RET
 .. I $$ISCLOZ^ORALWORD(OI) D  Q
 ... S RET=$$DEA^XUSER(,DUZ) I RET="" S ERROR=1
 .. S RET=$$SDEA^XUSER(,DUZ,DEAFLG)
 .. I RET=1 S ERROR=1 Q
 .. I RET=2 S ERROR="2^"_$$UP^XLFSTR(DEAFLG) Q
 .. I RET?1"4".E S ERROR=RET Q
 .. I RET?1N.E S ERROR=RET
 . D PKISITE^ORWOR(.PKI)
 . I $G(PKI),ACTION="RS",DEAFLG=1 S ERROR="This order cannot be released without a Digital Signature" Q
 Q
 ;
IVDEACHK(IFN) ; -- Returns value of prompt by ID
 I '$G(IFN)!('$D(^OR(100,+$G(IFN),0))) Q ""
 N I,DIAL,DIALTYP,FAIL,PATCLASS,RESULT,Y
 S PATCLASS=$P(^OR(100,+IFN,0),U,12)
 S RESULT=0
 ;if ORNP is not set then assume this is called from VistA not CPRS
 I $G(ORNP)="" S ORNP=DUZ
 S I=0,Y="" S:'$G(INST) INST=1
 F  S I=$O(^OR(100,+IFN,4.5,"ID","ORDERABLE",I)) Q:I'>0!(RESULT=1)  D
 .S Y=$G(^OR(100,+IFN,4.5,I,1)) Q:Y'>0
 .;S PSOI=+$P($G(^ORD(101.43,Y,0)),U,2) Q:PSOI'>0
 .I PATCLASS="I" D  Q
 ..D FAILDEA^ORWDPS1(.FAIL,Y,ORNP,"I") I FAIL'=0 S RESULT=FAIL
 .S DIAL=+$P(^OR(100,+IFN,4.5,I,0),U,2)
 .S DIALTYP=$S($P(^ORD(101.41,DIAL,0),U)["ADDITIVE":"A",1:"S")
 .D FDEA1^ORWDPS1(.FAIL,Y,DIALTYP,ORNP)
 .I FAIL'=0 S RESULT=FAIL
 .;I $$OIDEA^PSSUTLA1(PSOI,"I")>0 S RESULT=1 Q
 Q RESULT
 ;
XFR ; -- transfer to inpt/outpt [IFN=order to be transferred]
 N OI,PS I DG="TPN" S ERROR="TPN orders may not be copied!" Q
 I $$INACTIVE^ORCACT03 S ERROR="Orders for inactive orderables may not be transferred; please enter a new order!" Q
 S OI=+$O(^OR(100,+IFN,.1,"B",0)),ORPS=$G(^ORD(101.43,OI,"PS"))
 I DG="UD RX",'$P(ORPS,U,2) S ERROR="This drug may not be ordered for an outpatient!" Q
 I DG="O RX" D  Q:$L($G(ERROR))
 . I '$P(ORPS,U) S ERROR="This drug may not be ordered for an inpatient!" Q
 . D:$O(^OR(100,+IFN,4.5,"ID","MISC",0)) DOSES^ORCACT02(+IFN)
 ;
 ; Really this check should not be needed, as in BLDQRSP^ORWDXM1 if the urgency is not valid
 ; it returns a 0, so that the GUI does not auto-accept the order. However, a bug in the GUI
 ; is preventing that from happening. Once that bug is fixed, this check can be removed.
 I PKG="RA" D  Q:$D(ERROR)
 . N ORURG
 . S ORURG=$$VALUE^ORCSAVE2(+IFN,"URGENCY")
 . I ORURG,'$$RADURG^ORWDRA32(+ORURG) S ERROR="Invalid urgency. Cannot transfer!"
 Q
 ;
RW ; -- rewrite/copy
 N ORISCL D ISCLORD^ORUTL(.ORISCL,+IFN)
 I ORISCL S ERROR="Cannot copy Clinic Medication or Clinic Infusion orders!"
 I ACTSTS=12 S ERROR="Orders that have been dc'd due to editing may not be copied!" Q
 I DG="NV RX" S ERROR="Non-VA Med orders cannot be copied!" Q
 I DG="TPN" S ERROR="TPN orders may not be rewritten!" Q
 I DG="UD RX",$$NTBG^ORCACT03(+IFN) S ERROR="This order has been marked 'Not to be Given' and may not be rewritten!" Q
 I $$INACTIVE^ORCACT03 S ERROR="Orders for inactive orderables may not be copied; please enter a new order!" Q
 I PKG="PS",'$$MEDOK^ORCACT03 S ERROR="This drug may not be ordered!" Q
 I DG="O RX" D
 . N ORX,PSIFN
 . I $O(^OR(100,+IFN,4.5,"ID","MISC",0)) D DOSES^ORCACT02(+IFN) ;old form
 . ;
 . ;p377 LMT - check with pharmacy that order can be copied
 . S PSIFN=$G(^OR(100,+IFN,4))
 . I PSIFN="" Q  ; If does not have package ref yet (i.e., unsigned order) let it be copied w/o ORCOPY^PSOORCPY check
 . S ORX=$$ORCOPY^PSOORCPY(PSIFN)  ;ICR #6719
 . I ORX<1 S ERROR=$P(ORX,U,2) Q
 Q
 ;
RN ; -- renew
 I PKG'="PS",PKG'="OR" S ERROR="This order may not be renewed!" Q
 I (ORDSTS=11)!(ORDSTS=10) S ERROR="This order has not been released to the service." Q
 I ACTSTS=12 S ERROR="Orders that have been dc'd due to editing may not be renewed!" Q
 I $P(OR3,U,6) S ERROR="This order has already been "_$S($P($G(^OR(100,+$P(OR3,U,6),3)),U,11)=1:"changed!",1:"renewed!") Q
 I PKG="OR" D  Q  ;Generic orders
 . I $$INACTIVE^ORCACT03 S ERROR="Orders for inactive orderables may not be renewed!" Q
 . I DG="ADT" S ERROR="M.A.S. orders may not be renewed!" Q
 . I "^1^2^6^7^"[(U_ORDSTS_U) Q  ;ok
 . S ERROR="This order may not be renewed!"
 I (PKG="PS"),$$INACTIVE^ORCACT03 S ERROR="Orders for inactive orderables may not be renewed!" Q
 I '$$MEDOK^ORCACT03 S ERROR="This drug may not be ordered!" Q
RN1 N PSIFN,OROI
 S PSIFN=$G(^OR(100,+IFN,4))
 I PSIFN<1,'$O(^OR(100,+IFN,2,0)) S ERROR="Missing or invalid order number!" Q
 S OROI=$G(^OR(100,+IFN,.1,1,0))
 I $$ISCLOZ^ORALWORD(OROI) S ERROR="Cannot renew Clozapine orders!" Q
 I DG="O RX"!(DG="SPLY") D  Q  ;Outpt Meds
 . N ORZ,ORD
 . I $$XCONJ(+IFN) S ERROR="Orders with a conjunction of 'EXCEPT' may not be renewed!" Q
 . S ORZ=$L($T(RENEW^PSORENW),",")
 . I ORZ>1 S ORD=+$$VALUE^ORX8(+IFN,"DRUG"),X=$$RENEW^PSORENW(PSIFN,ORD)
 . S:ORZ'>1 X=$$RENEW^PSORENW(PSIFN) I X<1 S ERROR=$P(X,U,2) Q
 . S X=+$P(X,U,2) D:X RESET^ORCACT03(+IFN,X)
 . I $O(^OR(100,+IFN,4.5,"ID","MISC",0)) D DOSES^ORCACT02(+IFN) ;old format
 I DG="UD RX",$$NTBG^ORCACT03(+IFN) S ERROR="This order has been marked 'Not to be Given' and may not be renewed!" Q
 I ORDSTS=7,'$$IV^ORCACT03,$P(OR0,U,9)<$$FMADD^XLFDT(DT,-4)  S ERROR="Inpatient med orders may not be renewed more than 4 days after expiration!" Q
 I ORDSTS'=6,ORDSTS'=7 S ERROR="This order may not be renewed!" Q
RN2 I $O(^OR(100,+IFN,2,0))!$P(OR3,U,9) D  Q:$D(ERROR)!'PSIFN
 . I $P(OR3,U,9),$$VALUE^ORX8(+IFN,"SCHEDULE",1,"E")="NOW" S ERROR="One-time NOW orders may not be renewed!" Q
 . N DAD,ORD3,I,Y S DAD=$S($P(OR3,U,9):+$P(OR3,U,9),1:+IFN),Y=0
 . S ORD3=$G(^OR(100,DAD,3)) I $P(ORD3,U,6) S ERROR="This complex order has already been renewed!" Q
 . I $P(ORD3,U,3)'=6 S ERROR="This complex order is not active and may not be renewed!" Q
 . I '$$AND^ORX8(DAD) S ERROR="Complex orders with sequential doses may not be renewed!" Q
 . S I=0 F  S I=+$O(^OR(100,DAD,2,I)) Q:I<1  D  Q:Y
 .. I I=+$O(^OR(100,DAD,2,0)),$$VALUE^ORX8(I,"SCHEDULE",1,"E")="NOW",$$VALUE^ORX8(DAD,"NOW") Q  ;ignore NOW orders
 .. I $P($G(^OR(100,I,3)),U,3)'=6 S Y=1,ERROR="Complex orders with terminated doses may not be renewed!" Q
 .. I PSIFN<1 S X=$$ACTIVE^PSJORREN(+ORVP,$G(^OR(100,I,4))) I +X'=1 S ERROR="This order may not be renewed: "_$S(+X>1:"Inactive orderable item",1:$P(X,U,2)) Q
 ;I DG="TPN" S ERROR="TPN orders may not be renewed!" Q
 S X=$$ACTIVE^PSJORREN(+ORVP,PSIFN) Q:+X=1  ;Ok
 I +X>1,$P(X,U,2) D RESET^ORCACT03(+IFN,+$P(X,U,2)) Q  ;replace OI
 S ERROR="This order may not be renewed: "_$P(X,U,2)
 Q
 ;
XX ; -- edit/change--
 I PKG="RA",ORDSTS'=11,ORDSTS'=10 S ERROR="Orders released to Radiology cannot be changed!" Q
 I PKG="LR",ORDSTS'=11,ORDSTS'=10 S ERROR="Orders released to Lab cannot be changed!" Q
 I PKG="FH",ORDSTS'=11,ORDSTS'=10 S ERROR="Orders released to Dietetics cannot be changed!" Q
 I PKG="GMRC",ORDSTS'=11,ORDSTS'=10 S ERROR="Orders released to Consults cannot be changed!" Q
 I DG="TPN" S ERROR="TPN orders may not be changed!" Q
 I ORDSTS=3 S ERROR="Orders on hold may not be changed!" Q
 I DG="UD RX",$$NTBG^ORCACT03(+IFN) S ERROR="This order has been marked 'Not to be Given' and may not be changed!" Q
 I $O(^OR(100,+IFN,2,0)) S ERROR="Complex orders may not be changed!" Q
 I $P(OR3,U,9) D  Q:$D(ERROR)
 . Q:$$VALUE^ORX8(+IFN,"SCHEDULE",1,"E")="NOW"  ;NOW ok
 . Q:'$O(^OR(100,+$P(OR3,U,9),4.5,"ID","CONJ",0))  ;no conj=1dose/ok
 . S ERROR="Complex orders may not be changed!" Q
 I $P(OR3,U,6) S ERROR="This order may not be changed - a "_$S($P($G(^OR(100,+$P(OR3,U,6),3)),U,11)=1:"change",1:"renewal")_" order already exists!" Q
 I $P(OR3,U,11)=2 D  Q:$D(ERROR)
 . I (ORDSTS=10!(ORDSTS=11)),DG'="O RX" S ERROR="Unreleased renewals may not be changed!" Q
 . I PKG="PS",ORDSTS=5 S ERROR="Pending renewals may not be changed!" Q
 I $$INACTIVE^ORCACT03 S ERROR="Orders for inactive orderables may not be changed; please enter a new order!" Q
 I PKG="PS",'$$MEDOK^ORCACT03 S ERROR="This drug may not be ordered!" Q
 I DG="O RX",$$XCONJ(+IFN) S ERROR="Orders with a conjunction of 'EXCEPT' may not be changed!" Q
 I DG="O RX",$O(^OR(100,+IFN,4.5,"ID","MISC",0)) D DOSES^ORCACT02(+IFN) ;old form
 Q
 ;
XCONJ(ORIFN) ; check if Responses multiple has an OR GTX AND/THEN entry with value of X:EXCEPT
 N ORI,ORRESULT
 S ORRESULT=0
 S ORI=""
 F  S ORI=$O(^OR(100,ORIFN,4.5,"ID","CONJ",ORI)) Q:'ORI  D
 . I $G(^OR(100,ORIFN,4.5,ORI,1))="X" S ORRESULT=1
 Q ORRESULT
