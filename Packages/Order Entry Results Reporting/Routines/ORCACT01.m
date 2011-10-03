ORCACT01 ;SLC/MKB-Validate order actions cont ;03/28/2008
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**94,116,134,141,163,187,190,213,243**;Dec 17, 1997;Build 242
 ;
ES ; -- sign [on chart]
 I ORDSTS=11,VER<3,PKG'="OR" S ERROR="This order cannot be released and must be discontinued!" Q
 N X I ACTSTS=11!(ACTSTS=10) D  Q:$L($G(ERROR))
 . I $P(ORA0,U,2)="DC",$$DONE^ORCACT0 D CANCEL^ORCSEND(+IFN),UNOTIF^ORCSIGN S OREBUILD=1 Q
 . S X=$$DISABLED^ORCACT0 I X S ERROR=$P(X,U,2) Q
 I ACTION="OC",$G(DG)="NV RX" S:MEDPARM<2 ERROR="You are not authorized to release non-VA med orders!" Q
 S X=$P(ORA0,U,4) I X=3 S:ACTSTS'=11&(ACTSTS'=10) ERROR="This order does not require a signature!" Q
 I X'=2 S ERROR="This order has been signed!" Q
 I DG="O RX",ACTION'="ES",ACTION'="DS",$G(NATR)'="I" S ERROR="Outpatient meds may not be released without a clinician's signature!" Q
 I (ACTION="ES"!(ACTION="DS")),$D(^XUSEC("ORELSE",DUZ)),$P(OR0,U,16)'<2 S ERROR="You are not privileged to sign this order!" Q
 I ACTION="OC" S:MEDPARM<2 ERROR="You are not authorized to release med orders!" Q
 I ACTION="RS" D  Q:$D(ERROR)  Q:$G(NATR)'="I"
 . Q:ACTSTS=11  Q:ACTSTS=10  ;unreleased - ok
 . S ERROR="This order has already been released!"
ES1 I PKG="PS" D  ;authorized to write meds?
 . N TYPE,OI,PSOI,DEAFLG,PKI,IVERROR
 . S X=$G(^VA(200,DUZ,"PS"))
 . I '$P(X,U) S ERROR="You are not authorized to sign med orders!" Q
 . I $P(X,U,4),$$NOW^XLFDT>$P(X,U,4) S ERROR="You are no longer authorized to sign med orders!" Q
 . ;Q:DG="IV RX"  Q:$P(ORA0,U,2)="DC"  ;don't need to ck DEA#
 . Q:$P(ORA0,U,2)="DC"
 . I DG="IV RX" D  Q
 . .I $$IVDEACHK(+IFN)=1 S ERROR="You must have a valid DEA# or VA# to sign this order!"
 . S OI=+$$VALUE^ORX8(+IFN,"ORDERABLE")
 . S PSOI=+$P($G(^ORD(101.43,OI,0)),U,2) Q:PSOI'>0
 . S TYPE=$S($P(DG," ")="O":"O",1:"I"),DEAFLG=$$OIDEA^PSSUTLA1(PSOI,TYPE)
 . I (DEAFLG>0||$$ISCLOZ^ORALWORD(OI)),'$L($$DEA^XUSER()) S ERROR="You must have a valid DEA# or VA# to sign this order!" Q
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
 ..D FAILDEA^ORWDPS1(.FAIL,Y,ORNP,"I") I FAIL=1 S RESULT=1
 .S DIAL=+$P(^OR(100,+IFN,4.5,I,0),U,2)
 .S DIALTYP=$S($P(^ORD(101.41,DIAL,0),U)["ADDITIVE":"A",1:"S")
 .D FDEA1^ORWDPS1(.FAIL,Y,DIALTYP,ORNP)
 .I FAIL=1 S RESULT=1
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
 Q
 ;
RW ; -- rewrite/copy
 I ACTSTS=12 S ERROR="Orders that have been dc'd due to editing may not be copied!" Q
 I DG="NV RX" S ERROR="Non-VA Med orders cannot be copied!" Q
 I DG="TPN" S ERROR="TPN orders may not be rewritten!" Q
 I DG="UD RX",$$NTBG^ORCACT03(+IFN) S ERROR="This order has been marked 'Not to be Given' and may not be rewritten!" Q
 I $$INACTIVE^ORCACT03 S ERROR="Orders for inactive orderables may not be copied; please enter a new order!" Q
 I PKG="PS",'$$MEDOK^ORCACT03 S ERROR="This drug may not be ordered!" Q
 I DG="O RX",$O(^OR(100,+IFN,4.5,"ID","MISC",0)) D DOSES^ORCACT02(+IFN) ;old form
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
RN1 N PSIFN S PSIFN=$G(^OR(100,+IFN,4))
 I PSIFN<1,'$O(^OR(100,+IFN,2,0)) S ERROR="Missing or invalid order number!" Q
 I DG="O RX" D  Q  ;Outpt Meds
 . N ORZ,ORD S ORZ=$L($T(RENEW^PSORENW),",")
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
 I DG="O RX",$O(^OR(100,+IFN,4.5,"ID","MISC",0)) D DOSES^ORCACT02(+IFN) ;old form
 Q
 ;
