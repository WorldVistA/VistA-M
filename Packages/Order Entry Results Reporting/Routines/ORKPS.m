ORKPS ; slc/CLA - Order checking support procedures for medications ;12/29/17  11:58
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**6,32,74,94,123,141,190,232,316,272,346,345,382,469**;Dec 17, 1997;Build 3
 Q
CHECK(YY,DFN,MED,OI,ORKDG,OROIL,ORSUPPLY,ORIVTYPE,ORIVRAN,ORDODSG) ; return drug order checks
 ;YY:    returned array of data
 ;DFN:   patient id
 ;MED:   drug ien [file #50] ^ generic name [file #50]
 ;OI:    orderable item ien [file #101.43]
 ;ORKDG: display group (should be PSI, PSIV, PSO or PSH)
 ;OROIL: list of items ordered
 ;ORSUPPLY: pharmacy orderable item ien [file #50.7] if it resolves to one or more supply items
 ;          0 if the pharmacy orderable item does not resolve to any supply items
 ;ORIVTYPE: the MED type as sent from Infusion Order Dialog
 ;          A for additive
 ;          B for base
 ;ORIVRAN: FLAG THAT DENOTES IF ALL COMPONENTS OF INFUSION ORDER HAVE ALREADY BEEN PROCESSED
 ;         1 FOR ALREADY PROCESSED
 ;         EMPTY STRING FOR NOT YET PROCESSED
 ;ORDODSG: FLAG THAT DENOTES IF DOSAGE CHECKS SHOULD BE PERFORMED
 ;         1 FOR PERFORM DOSAGE CHECKS
 ;         0 FOR DO NOT PERFORM DOSAGE CHECKS
 ; returned info: varies for ^TMP($J x-ref - refer to listings below
 N OR2CRITN,OR2CRITF,OR2CRITD,OR2SIGN,OR2SIGF,OR2SIGD,OR2DUPN,OR2DUPF,OR2DUPD,OR2DUPCN,OR2DUPCF,OR2DUPCD
 N ORPHDG,ORKSOIA,ORDOCHKS
 D PARAMS^ORKCHK6("CRITICAL DRUG INTERACTION",.OR2CRITN,.OR2CRITF,.OR2CRITD)
 D PARAMS^ORKCHK6("SIGNIFICANT DRUG INTERACTION",.OR2SIGN,.OR2SIGF,.OR2SIGD)
 D PARAMS^ORKCHK6("DUPLICATE DRUG THERAPY",.OR2DUPCN,.OR2DUPCF,.OR2DUPCD)
 N ORDFN,ORKA,ORPTY,ORPHOI,OROILI,ORKAI S ORDFN=DFN
 S ORPHOI=+$P($G(^ORD(101.43,+OI,0)),U,2)
 S ORPTY=$S($G(ORKDG)="PSI":"I;",$G(ORKDG)="PSIV":"I;",$G(ORKDG)="PSO":"O;",$G(ORKDG)="PSH":"O;",1:"O;")
 S ORPHDG=$S(ORKDG="PSI":"U",ORKDG="PSIV":"I",ORKDG="PSO":"O",ORKDG="PSH":"N",1:"")
 I $G(ORIVTYPE)'="A" D  Q:'ORDOCHKS  ; Don't do checks if pharmacy does not want us to
 .S ORDOCHKS=$$PRE^PSSDSAPK(ORPHOI,ORPHDG)
 .S:'ORDODSG ORDODSG=ORDOCHKS
 S:$G(ORIVTYPE)="A" ORDODSG=1
 I +MED,('ORIVRAN) S ORKA(1)=MED_U_$$GETPSNM(+MED),ORKAI=1
 ;ADD ALL COMPONENTS OF IV ORDER SO WE ONLY HAVE TO DO A SINGLE PRE CALL
 I ORKDG="PSIV",('ORIVRAN) D
 .S ORIVRAN=1,OROILI=0 F  S OROILI=$O(OROIL(OROILI)) Q:'OROILI  D
 ..N OR2OI,OR2PSOI,OR2PHDG
 ..I 'OROIL(OROILI) Q
 ..I +OROIL(OROILI)=OI Q
 ..S OR2OI=+OROIL(OROILI)
 ..S OR2PSOI=+$P($G(^ORD(101.43,+OR2OI,0)),U,2)
 ..S OR2PHDG=$P(OROIL(OROILI),U,2)
 ..S OR2PHDG=$S(OR2PHDG="PSI":"U",OR2PHDG="PSIV":"I",OR2PHDG="PSO":"O",OR2PHDG="PSH":"N",1:"")
 ..Q:OR2PHDG'="I"
 ..I $P($P(OROIL(OROILI),U,3),";")="B",$$PRE^PSSDSAPK(OR2PSOI,OR2PHDG)=0 Q
 ..I $P($P(OROIL(OROILI),U,3),";")="B",$P($P(OROIL(OROILI),U,3),";",2)="",$G(ORREN)=1 D
 ...N ORVOLID,ORVOLVAL S ORVOLVAL="",ORVOLID=$O(^OR(100,+$G(ORIFN),4.5,"ID","VOLUME",""))
 ...I ORVOLID>0 S ORVOLVAL=$G(^OR(100,+$G(ORIFN),4.5,ORVOLID,1))
 ...S OROIL(OROILI)=OROIL(OROILI)_ORVOLVAL
 ..N ORUSID
 ..S ORUSID=$$USID^ORWDXC(OROIL(OROILI))
 ..S ORKAI=ORKAI+1,ORKA(ORKAI)=$P(ORUSID,U,4)_U_$$GETPSNM($P(ORUSID,U,4))
 D:$D(ORKA) CPRS^PSODDPR4(ORDFN,"OROCOUT"_ORPTY,.ORKA,ORPTY_+$G(^OR(100,+$G(ORIFN),4)))
 I +ORSUPPLY D
 .S ORKSOIA(+ORSUPPLY)=$G(ORIFN)
 .D CPRS^PSODDPR8(ORDFN,"OROCOUT"_ORPTY,.ORKSOIA,ORPHDG_";"_+$G(^OR(100,+$G(ORNUM),4)),$S($D(ORKA):1,1:""))
 I $D(ORKA)!($D(ORKSOIA))!(ORIVRAN) D
 .S:OR2CRITF_OR2SIGF_OR2DUPCF["E" ^TMP($J,"ORENHCHK")=1
 .D PROCESS^ORKPS1(OI,ORDFN,ORKDG,+ORSUPPLY_U_+MED,"OROCOUT"_ORPTY)
 Q
CHKSESS(YY,DFN,MED,OI,ORKPDATA,ORKDG,ORSUPPLY,ORIVTYPE) ; return drug order checks for session
 ;ORSUPPLY: pharmacy orderable item ien [file #50.7] if it resolves to one or more supply items
 ;          0 if the pharmacy orderable item does not resolve to any supply items
 ;ORIVTYPE: the MED type as sent from Infusion Order Dialog
 ;          A for additive
 ;          B for base
 N ORKDGI,ORKDRUG,ORKDRUGA,ORKORN,HOR,SEQ,CNT,CNTX,ORKOI,ORPHOI
 N ORKFLG,ORSESS,ORPSPKG,ORPSA,ORSNUM,ORNUM,DUPX,DUPORN,ORPTY
 N ORKSOIA,ORRET,ORDFN,ORPHDG S ORDFN=DFN
 S ORPTY=$S($G(ORKDG)="PSI":"I;",$G(ORKDG)="PSIV":"I;",$G(ORKDG)="PSO":"O;",$G(ORKDG)="PSH":"O;",1:"O;")
 S ORPHDG=$S(ORKDG="PSI":"U",ORKDG="PSIV":"I",ORKDG="PSO":"O",ORKDG="PSH":"N",1:"")
 I '$D(^TMP($J,"OROCOUT"_ORPTY)) D
 .S ORKFLG=0
 .S ORNUM=$P(ORKA,"|",5)
 .S ORPHOI=+$P($G(^ORD(101.43,+OI,0)),U,2)
 .I $G(ORIVTYPE)'="A",'$$PRE^PSSDSAPK(ORPHOI,ORPHDG) Q  ; Don't do checks if pharmacy does not want us to
 .;get unsigned medication orders:
 .S HOR=0,SEQ=0
 .S HOR=$O(^TMP("ORR",$J,HOR))
 .I +$G(HOR)>0 D
 ..F  S SEQ=$O(^TMP("ORR",$J,HOR,SEQ)) Q:+SEQ<1  D
 ...S ORKORN=+$P(^TMP("ORR",$J,HOR,SEQ),U),DUPORN=0
 ...Q:+$G(ORKORN)<1
 ...Q:+ORKORN=+ORNUM
 ...Q:$P(^OR(100,+ORKORN,8,$P(^OR(100,+ORKORN,8,0),U,3),0),U,2)="DC"
 ...Q:$P(^ORD(100.01,$P(^OR(100,+ORKORN,3),U,3),0),U)="DISCONTINUED"
 ...S ORKDRUG=$$VALUE^ORCSAVE2(+ORKORN,"DRUG") ;get disp drug for order
 ...S ORPSPKG=$$DGRX^ORQOR2(+ORKORN)
 ...S:ORPSPKG="CLINIC INFUSIONS" ORPSPKG="IV MEDICATIONS" ; OR*3*430
 ...S ORPSPKG=$S(ORPSPKG="UNIT DOSE MEDICATIONS":"PSI",ORPSPKG="OUTPATIENT MEDICATIONS":"PSO",ORPSPKG="IV MEDICATIONS":"PSIV",ORPSPKG="NON-VA MEDICATIONS":"PSH",1:"")
 ...S DUPX="" F  S DUPX=$O(ORKDRUGA(DUPX)) Q:'DUPX!(DUPORN=1)  D
 ....S:ORKORN=ORKDRUGA(DUPX) DUPORN=1
 ...Q:DUPORN=1  ;quit if already processed drug order
 ...I +$G(ORKDRUG)<1,$L(ORPSPKG)>0 D
 ....N OROI S OROI=$$OI^ORX8(+ORKORN)
 ....S ORRET=$$OI2DD(+OROI,$S($G(ORKDG)="PSI":"I",$G(ORKDG)="PSIV":"I",$G(ORKDG)="PSO":"O",$G(ORKDG)="PSH":"O",1:"O"),1)
 ....I +$P(ORRET,";",4) S ORKSOIA(+$P(ORRET,";",4))=ORKORN
 ....I +ORRET S ORKDRUG=+ORRET
 ...;only process vs. unsigned med order if disp drug is assoc w/order:
 ...Q:+$G(ORKDRUG)<1
 ...I ORPSPKG="PSIV" D
 ....;loop through each OI in the IV order
 ....N OR2I
 ....S OR2I=0 F  S OR2I=$O(^OR(100,+ORKORN,4.5,"ID","ORDERABLE",OR2I)) Q:'OR2I  D
 .....N OR2OI,OR2DRUG
 .....S OR2OI=$G(^OR(100,+ORKORN,4.5,OR2I,1))
 .....Q:'OR2OI
 .....;get the drug for each OI
 .....S OR2DRUG=$$OI2DD(+OR2OI,"I",1)
 .....;check if drug should be add it and add it if so
 .....I $$IVADD(OR2DRUG,OR2OI) S ORKDRUGA(+OR2DRUG_";"_ORPSPKG_";"_ORKORN)=ORKORN_U_$$GETPSNM(+OR2DRUG)
 ...I ORPSPKG'="PSIV" S ORKDRUGA(+ORKDRUG_";"_ORPSPKG_";"_ORKORN)=ORKORN_U_$$GETPSNM(+ORKDRUG)
 ...; OR*3*469 - Load all components (solution and additive) of IV for order checking
 ... I ORPSPKG="PSIV" D
 .... N ORX,ORRET S ORX=0 F  S ORX=+$O(^OR(100,ORKORN,4.5,"ID","ORDERABLE",ORX)) Q:'ORX   D
 ..... S ORRET=$$OI2DD(+$G(^OR(100,ORKORN,4.5,ORX,1)),"I",1) Q:'ORRET
 ..... I +$P(ORRET,";",4) S ORKSOIA(+$P(ORRET,";",4))=ORKORN
 ..... I '$D(ORKDRUGA(+ORRET_";PSIV;"_ORKORN)) S ORKDRUGA(+ORRET_";PSIV;"_ORKORN)=ORKORN_U_$$GETPSNM(+ORRET)
 .... Q  ; end of OR*3*469 change
 .N ORPROSP,CNT
 .S CNT=1
 .S:+MED ORPROSP(CNT)=MED_U_$$GETPSNM(+MED)_U_+$G(ORNUM),CNT=CNT+1
 .N I S I="" F  S I=$O(ORKDRUGA(I)) Q:'I  S ORPROSP(CNT)=+I_U_$P(ORKDRUGA(I),U,2)_U_U_$P(ORKDRUGA(I),U,1),CNT=CNT+1
 .D SHRNKPR
 .D CPRS^PSODDPR4(DFN,"OROCOUT"_ORPTY,.ORPROSP,ORPTY_+$G(^OR(100,+$G(ORNUM),4)))
 .I +ORSUPPLY D
 ..S ORKSOIA(+ORSUPPLY)=$G(ORNUM)
 ..D:$D(ORKSOIA)>9 CPRS^PSODDPR8(DFN,"OROCOUT"_ORPTY,.ORKSOIA,ORPHDG_";"_+$G(^OR(100,+$G(ORNUM),4)),1)
 D PROCESS^ORKPS1(OI,ORDFN,ORKDG,+ORSUPPLY_U_+MED,"OROCOUT"_ORPTY)
 Q
IVADD(ORDRUG,OROI) ;RETURN YES OR NO IF SHOULD ADD THE IV ITEM
 N ORRET
 ;default is yes to add it, will always be 1 for an additive
 S ORRET=1
 ;check if drug is a base
 K ^TMP($J,"ORBASECHECK")
 D DRGIEN^PSS52P7(ORDRUG,,"ORBASECHECK")
 I $P($G(^TMP($J,"ORBASECHECK",0),0),U)>0 D  ;GOT A BASE HERE
 .;if drug is a base, check if pharmacy says we can add it or not
 .N ORPHOI
 .S ORPHOI=+$P($G(^ORD(101.43,+OROI,0)),U,2)
 .S ORRET=$$PRE^PSSDSAPK(ORPHOI,"I")
 K ^TMP($J,"ORBASECHECK")
 Q ORRET
SHRNKPR ;REMOVE DUPLICATS FROM PROSPECTIVE LIST
 Q:'$D(ORPROSP)
 N ORX,ORI S ORI=0 F  S ORI=$O(ORPROSP(ORI)) Q:'ORI  S ORX=ORPROSP(ORI) D
 .N ORJ S ORJ=ORI F  S ORJ=$O(ORPROSP(ORJ)) Q:'ORJ  I ORX=ORPROSP(ORJ) K ORPROSP(ORJ)
 Q
GETPSNM(ORIEN) ;GET THE FILE 50 .01 FIELD FROM A FILE 50 IEN
 N RET K ^TMP($J,"ORRETNM")
 D NDF^PSS50(ORIEN,,,,,"ORRETNM") S RET=$G(^TMP($J,"ORRETNM",ORIEN,.01))
 K ^TMP($J,"ORRETNM")
 Q RET
TAKEMED(ORKDFN,ORKMED) ;extrinsic function returns med orderable item if any
 ;active med patient is taking contains any piece of ORKMED
 ;ORKDFN   patient DFN
 ;ORKMED   meds to check vs. active med list in format MED1^MED2^MED3...
 Q:'$L($G(ORKDFN)) "0^Patient not identified."
 Q:'$L($G(ORKMED)) "0^Medication not identified."
 N ORKARX,ORKY,ORI,ORJ,ORCNT,ORKMEDP,ORKRSLT
 D LIST^ORQQPS(.ORKY,ORKDFN,"","")
 Q:$P(ORKY(1),U)="" "0^No active meds found."
 S ORKRSLT="0^No matching meds found."
 S ORCNT=$L(ORKMED,U)
 S ORI=0 F  S ORI=$O(ORKY(ORI)) Q:ORI<1  D
 .S ORKARX=$P(ORKY(ORI),U,2)
 .F ORJ=1:1:ORCNT S ORKMEDP=$P(ORKMED,U,ORJ) D
 ..I $L(ORKMEDP),($$UP^XLFSTR(ORKARX)[ORKMEDP) S ORKRSLT="1^"_ORKARX ;DJE/VM *316 use uppercase in comparison
 Q ORKRSLT
POLYRX(DFN) ;extrins funct rtns 1 if patient exceeds polypharmacy, 0 if not
 N ORSLT,ORENT,ORLOC,ORPAR,ORMEDS
 S ORSLT=0
 Q:'$L(DFN) ORSLT
 S VA200="" D OERR^VADPT
 S ORLOC=+$G(^DIC(42,+VAIN(4),44))
 K VA200,VAIN
 S ORENT=+$G(ORLOC)_";SC(^DIV^SYS^PKG"
 S ORPAR=$$GET^XPAR(ORENT,"ORK POLYPHARMACY",1,"I")
 S ORMEDS=$$NUMRX(DFN)
 I $G(ORMEDS)>$G(ORPAR) S ORSLT=1
 Q ORSLT
GLCREAT(DFN) ;extrinsic function returns patient's (DFN) most recent serum
 ; creatinine within # of days from parameter ORK GLUCOPHAGE CREATININE
 ; results format: test id^result units flag ref range collect d/t^result
 ; used by order check GLUCOPHAGE-LAB RESULTS
 N ORLOC,ORPAR,ORDAYS
 N BDT,CDT,ORY,ORX,ORZ,TEST,ORI,ORJ,CREARSLT,LABFILE,SPECFILE,SPECIMEN,VAIN,VADM,RSLTS
 Q:'$L(DFN) "0^"
 S ORDAYS=$$GCDAYS(DFN)
 Q:'$L(ORDAYS) "0^"
 D NOW^%DTC
 S BDT=$$FMADD^XLFDT(%,"-"_ORDAYS,"","","")
 K %
 Q:'$L($G(BDT)) "0^"
 S LABFILE=$$TERMLKUP^ORB31(.ORY,"SERUM CREATININE")
 Q:'$D(ORY) "0^" ;no link between SERUM CREATININE and local lab test
 Q:$G(LABFILE)'=60 "0^"
 S SPECFILE=$$TERMLKUP^ORB31(.ORX,"SERUM SPECIMEN")
 Q:'$D(ORX) "0^" ;no link between SERUM SPECIMEN and local specimen
 Q:$G(SPECFILE)'=61 "0^"
 F ORI=1:1:ORY D
 .S TEST=$P(ORY(ORI),U)
 .Q:+$G(TEST)<1
 .F ORJ=1:1:ORX D
 ..S SPECIMEN=$P(ORX(ORJ),U)
 ..Q:+$G(SPECIMEN)<1
 ..S ORZ=$$LOCL^ORQQLR1(DFN,TEST,SPECIMEN)
 ..Q:'$L($G(ORZ))
 ..S CDT=$P(ORZ,U,7)
 ..I CDT'<BDT S RSLTS(CDT)=ORZ,CREARSLT=1  ;*SMT Use RSLTS as array.
 Q:+$G(CREARSLT)<1 "0^"
 S CDT=$O(RSLTS(0)),ORZ=RSLTS(CDT)  ;*SMT
 Q $P(ORZ,U)_U_$P(ORZ,U,3)_" "_$P(ORZ,U,4)_" "_$P(ORZ,U,5)_" ("_$P(ORZ,U,6)_")  "_$$FMTE^XLFDT(CDT,"2P")_U_$P(ORZ,U,3)
GCDAYS(DFN) ;extrinsic function to return number of days to look for
 ; glucophage serum creatinine result
 Q:'$L(DFN) ""
 N ORLOC,ORENT,ORDAYS
 ;get patient's location flag (INPATIENT ONLY - outpt locations cannot be
 ;reliably determined, and many simultaneous outpt locations can occur):
 S VA200="" D OERR^VADPT
 S ORLOC=+$G(^DIC(42,+VAIN(4),44))
 K VA200,VAIN
 S ORENT=+$G(ORLOC)_";SC(^DIV^SYS^PKG"
 S ORDAYS=$$GET^XPAR(ORENT,"ORK GLUCOPHAGE CREATININE",1,"I")
 Q:$L(ORDAYS) ORDAYS
 Q ""
SUPPLY(OI) ;extrinsic function returns 1 (true) if the orderable item is
 ; a supply
 Q:+$G(OI)<1 ""
 N OITEXT
 S OITEXT=$G(^ORD(101.43,OI,0))
 Q:'$L(OITEXT) ""
 S OITEXT=$P(OITEXT,U)
 Q:$D(^ORD(101.43,"S.SPLY",OITEXT)) 1
 Q ""
NUMRX(DFN) ;extrinsic funct returns number of active meds patient is taking
 N NUMRX,ORPTYPE,ORX,ORY,ORS,ORNUM,ORPRENEW,VADMVT
 S NUMRX=0
 Q:+$G(DFN)<1 NUMRX
 ;check to determine if inpatient or outpatient:
 D ADM^VADPT2
 S ORPTYPE=$S(+$G(VADMVT)>0:"I",1:"O")
 K ^TMP("PS",$J)
 D OCL^PSOORRL(DFN,"","")  ;if no date range, returns active meds for pt
 N X
 S X=0
 F  S X=$O(^TMP("PS",$J,X)) Q:X<1  D
 .S ORX=$G(^TMP("PS",$J,X,0))
 .S ORY=$P(ORX,U)
 .S ORNUM=$P(ORX,U,8) ;order entry order number
 .S ORS=$P(ORX,U,9) ;medication status from pharmacy
 .S ORPRENEW=$P(ORX,U,14)  ;pending renewal flag (1: pending renewal)
 .Q:+ORX<1
 .Q:$P(ORY,";",2)'=ORPTYPE  ;quit if med is not pt type (inpt/outpt)
 .;quit if status is a non-active type:
 .Q:$G(ORS)="EXPIRED"
 .Q:$G(ORS)["DISCONTINUE"
 .Q:$G(ORS)="DELETED"
 .Q:+$G(ORPRENEW)>0
 .Q:$$SUPPLY($$OI^ORQOR2(ORNUM))=1  ;quit if a supply
 .S NUMRX=NUMRX+1
 K ^TMP("PS",$J)
 Q NUMRX
OI2DD(OROI,ORPSPKG,ORCHKTYP)       ;rtn dispense drugs for a PS OI
 ;ORCHKTYP: TYPE OF ORDER CHECK SYSTEM IS PERFORMING
 ;          1 FOR ENHANCED ORDER CHECKS
 ;          2 FOR DOSAGE ORDER CHECK
 N PSOI,ORRET
 Q:'$D(^ORD(101.43,OROI,0)) ""
 S PSOI=+$P(^ORD(101.43,OROI,0),U,2)
 Q:PSOI<1 ""
 S:ORPSPKG="H" ORPSPKG="X"  ;if non-va med need to pass api "X"
 S ORRET=$$DRG^PSSDSAPM(PSOI,ORPSPKG,ORCHKTYP)
 I ORCHKTYP=1,(+$P(ORRET,";",4)) S $P(ORRET,";",4)=PSOI
 Q ORRET
