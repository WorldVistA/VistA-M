ORKPS ; slc/CLA - Order checking support procedures for medications ;07/27/11  07:10
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**6,32,74,94,123,141,190,232,316,272,346**;Dec 17, 1997;Build 5
 Q
CHECK(YY,DFN,MED,OI,ORKDG) ; return drug order checks
 ;YY:    returned array of data
 ;DFN:   patient id
 ;MED:   drug ien [file #50]
 ;OI:    orderable item ien [file #101.43
 ;ORKDG: display group (should be PSI, PSIV, PSO or PSH)
 ; returned info: varies for ^TMP($J x-ref - refer to listings below
 K ^TMP($J,"OROCOUT"),^TMP($J,"DD")
 N ORDFN,ORKA,ORPTY,ORPHOI S ORDFN=DFN
 S ORPHOI=+$P($G(^ORD(101.43,+OI,0)),U,2)
 S ORPTY=$S($G(ORKDG)="PSI":"I;",$G(ORKDG)="PSIV":"I;",$G(ORKDG)="PSO":"O;",$G(ORKDG)="PSH":"O;",1:"O;")
 I $$PRE^PSSDSAPK(ORPHOI)=0,($$SOLUT^ORKPS(OI)) Q  ; Dont do checks if the drug is a solution but not a premix
 ;I $D(ORMOCHAT) N ORMOCHAN S ORMOCHAN=$O(@ORMOCHAT@("ENH",""),-1)+1,$P(@ORMOCHAT@("ENH",ORMOCHAN),U,1)=$ZH
 S ORKA(1)=MED_U_$$GETPSNM(+MED) D CPRS^PSODDPR4(ORDFN,"OROCOUT",.ORKA,ORPTY_+$G(^OR(100,+$G(ORIFN),4)))
 ;I $D(ORMOCHAT) S $P(@ORMOCHAT@("ENH",ORMOCHAN),U,2)=$ZH
 D PROCESS^ORKPS1(OI,ORDFN,ORKDG,+ORKA(1),"OROCOUT")
 K ^TMP($J,"OROCOUT"),^TMP($J,"DD")
 Q
CHKSESS(YY,DFN,MED,OI,ORKPDATA,ORKDG) ; return drug order checks for session
 N ORKDGI,ORKDRUG,ORKDRUGA,ORKORN,HOR,SEQ,CNT,CNTX,ORKOI,ORPHOI
 N ORKFLG,ORSESS,ORPSPKG,ORPSA,ORKDD,ORSNUM,ORNUM,DUPX,DUPORN,ORPTY
 N ORDFN S ORDFN=DFN
 S ORPTY=$S($G(ORKDG)="PSI":"I;",$G(ORKDG)="PSIV":"I;",$G(ORKDG)="PSO":"O;",$G(ORKDG)="PSH":"O;",1:"O;")
 I '$D(^TMP($J,"OROCOUT"_ORPTY)) D
 .S ORKFLG=0
 .S ORNUM=$P(ORKA,"|",5)
 .S ORPHOI=+$P($G(^ORD(101.43,+OI,0)),U,2)
 .I $$PRE^PSSDSAPK(ORPHOI)=0,($$SOLUT^ORKPS(OI)) Q  ; Dont do checks if the drug is a solution but not a premix
 .;
 .;get other session med orders:
 .I $D(^TMP("ORKA",$J)) D
 ..S CNT=^TMP("ORKA",$J) F CNTX=1:1:CNT D
 ...S ORSESS=$G(^TMP("ORKA",$J,CNTX))
 ...Q:'$L(ORSESS)
 ...S ORPSPKG=$P(ORSESS,"|",2)
 ...Q:'$L(ORPSPKG)
 ...Q:$E(ORPSPKG,1,2)'="PS"
 ...S ORSNUM=$P(ORSESS,"|",5)
 ...S ORKOI=$P(ORSESS,"|")
 ...;quit if same order/oi:
 ...Q:((+$G(ORNUM)=+$G(ORSNUM))&(+$G(OI)=+$G(ORKOI)))
 ...S:ORPSPKG="PSJ" ORPSPKG="PSI"
 ...S ORKDRUG=$P($P(ORSESS,"|",3),U,4)
 ...;
 ...;if no disp drug selected get disp drug(s) from OI:
 ...I +$G(ORKDRUG)<1,$L(ORKOI) D
 ....I "IOH"[$E(ORPSPKG,3) D OI2DD(.ORPSA,ORKOI,$E(ORPSPKG,3)) D
 .....S ORKDD=0 F  S ORKDD=$O(ORPSA(ORKDD)) Q:'ORKDD  D
 ......S ORKDRUG=+ORKDD
 ......S:+$G(ORKDRUG)>0 ORKDRUGA(ORKDRUG_";"_ORPSPKG_";"_ORSNUM)=ORSNUM_U_$P($G(^ORD(101.43,ORKOI,0)),U),ORKDRUG=0
 ....K ORPSA  ;need to clean out between calls to OI2DD
 ...;
 ...Q:+$G(ORKDRUG)<1
 ...;if dispense drug selected add to array:
 ...S ORKDRUGA(ORKDRUG_";"_ORPSPKG_";"_ORSNUM)=ORSNUM_U_$$GETPSNM(+ORKDRUG)
 .;
 .;get unsigned medication orders:
 .S HOR=0,SEQ=0
 .S HOR=$O(^TMP("ORR",$J,HOR)) I +$G(HOR)>0 D
 ..F  S SEQ=$O(^TMP("ORR",$J,HOR,SEQ)) Q:+SEQ<1  D
 ...S ORKORN=+$P(^TMP("ORR",$J,HOR,SEQ),U),DUPORN=0
 ...Q:+$G(ORKORN)<1
 ...Q:+ORKORN=+ORNUM
 ...Q:$P(^OR(100,+ORKORN,8,$P(^OR(100,+ORKORN,8,0),U,3),0),U,2)="DC"
 ...Q:$P(^ORD(100.01,$P(^OR(100,+ORKORN,3),U,3),0),U)="DISCONTINUED"
 ...S ORKDRUG=$$VALUE^ORCSAVE2(+ORKORN,"DRUG") ;get disp drug for order
 ...;only process vs. unsigned med order if disp drug is assoc w/order:
 ...Q:+$G(ORKDRUG)<1
 ...S ORPSPKG=$$DGRX^ORQOR2(+ORKORN)
 ...S ORPSPKG=$S(ORPSPKG="UNIT DOSE MEDICATIONS":"PSI",ORPSPKG="OUTPATIENT MEDICATIONS":"PSO",ORPSPKG="IV MEDICATIONS":"PSIV",ORPSPKG="NON-VA MEDICATIONS":"PSH",1:"")
 ...S DUPX="" F  S DUPX=$O(ORKDRUGA(DUPX)) Q:'DUPX!(DUPORN=1)  D
 ....S:ORKORN=ORKDRUGA(DUPX) DUPORN=1
 ...Q:DUPORN=1  ;quit if already processed drug order
 ...S ORKDRUGA(+ORKDRUG_";"_ORPSPKG_";"_ORKORN)=ORKORN_U_$$GETPSNM(+ORKDRUG)
 .;S ORPTY=$S($G(ORKDG)="PSI":"I;",$G(ORKDG)="PSIV":"I;",$G(ORKDG)="PSO":"O;",$G(ORKDG)="PSH":"O;",1:"O;")
 .K ^TMP($J,"DD"),^TMP($J,"OROCOUT")
 .N ORPROSP,CNT
 .S CNT=1
 .S ORPROSP(CNT)=MED_U_$$GETPSNM(+MED)_U_+$G(ORNUM)
 .;N I S I="" F  S I=$O(ORKDRUGA(I)) Q:'I  S CNT=CNT+1,ORPROSP(CNT)=+I_U_$$GETPSNM(+I)
 .N I S I="" F  S I=$O(ORKDRUGA(I)) Q:'I  S CNT=CNT+1,ORPROSP(CNT)=+I_U_$P(ORKDRUGA(I),U,2)_U_$P(ORKDRUGA(I),U,1)
 .;I $D(ORMOCHAT) N ORMOCHAN S ORMOCHAN=$O(@ORMOCHAT@("ENH",""),-1)+1,$P(@ORMOCHAT@("ENH",ORMOCHAN),U,1)=$ZH
 .D SHRNKPR
 .D CPRS^PSODDPR4(DFN,"OROCOUT"_ORPTY,.ORPROSP,ORPTY_+$G(^OR(100,+$G(ORNUM),4)))
 .;I $D(ORMOCHAT) S $P(@ORMOCHAT@("ENH",ORMOCHAN),U,2)=$ZH
 D PROCESS^ORKPS1(OI,ORDFN,ORKDG,+MED,"OROCOUT"_ORPTY)
 Q
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
SOLUT(OI) ;extrinsic function returns 1 (true) if the orderable item is
 ; a solution (IV Base)
 Q:+$G(OI)<1 ""
 N OITEXT
 S OITEXT=$G(^ORD(101.43,OI,0))
 Q:'$L(OITEXT) ""
 S OITEXT=$P(OITEXT,U)
 Q:$D(^ORD(101.43,"S.IVB RX",OITEXT)) 1
 Q ""
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
 N BDT,CDT,ORY,ORX,ORZ,TEST,ORI,ORJ,CREARSLT,LABFILE,SPECFILE,SPECIMEN
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
 F ORI=1:1:ORY I +$G(CREARSLT)<1 D
 .S TEST=$P(ORY(ORI),U)
 .Q:+$G(TEST)<1
 .F ORJ=1:1:ORX I +$G(CREARSLT)<1 D
 ..S SPECIMEN=$P(ORX(ORJ),U)
 ..Q:+$G(SPECIMEN)<1
 ..S ORZ=$$LOCL^ORQQLR1(DFN,TEST,SPECIMEN)
 ..Q:'$L($G(ORZ))
 ..S CDT=$P(ORZ,U,7)
 ..I CDT'<BDT S CREARSLT=1
 Q:+$G(CREARSLT)<1 "0^"
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
 N NUMRX,ORPTYPE,ORX,ORY,ORS,ORNUM,ORPRENEW
 S NUMRX=0
 Q:+$G(DFN)<1 NUMRX
 ;
 ;check to determine if inpatient or outpatient:
 D ADM^VADPT2
 S ORPTYPE=$S(+$G(VADMVT)>0:"I",1:"O")
 ;
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
OI2DD(ORPSA,OROI,ORPSPKG)       ;rtn dispense drugs for a PS OI
 N PSOI,ORTMP1,ORTMP2,ORRET
 Q:'$D(^ORD(101.43,OROI,0))
 S PSOI=$P($P(^ORD(101.43,OROI,0),U,2),";")
 Q:+$G(PSOI)<1
 S:ORPSPKG="H" ORPSPKG="X"  ;if non-va med need to pass api "X"
 S ORRET=$$DRG^PSSDSAPM(PSOI,ORPSPKG)
 I +ORRET S ORPSA(ORRET)=""
 Q
