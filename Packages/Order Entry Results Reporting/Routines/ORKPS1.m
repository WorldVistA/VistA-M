ORKPS1 ; SLC/CLA - Order checking support procedures for medications ;03/29/13  09:01
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**232,272,346,352,345,311,402,457**;Dec 17, 1997;Build 2
 Q
PROCESS(OI,DFN,ORKDG,ORPROSP,ORGLOBL) ;process data from pharmacy order check API
 ;ORPROSP = pharmacy orderable item ien [file #50.7] ^ drug ien [file #50]
 ;          NOTE: PIECE 1 WILL ONLY BE FILLED IN FOR ORDERABLE ITEMS THAT RESOLVE TO SUPPLY ITEMS
 Q:'$D(^TMP($J))
 N II,XX,ZZ,ZZD,ORMTYPE,ORN,ORZ,RCNT,GL,I,J,K,L,M,TDATA,VADMVT,ORX,ORY
 S II=1,XX=0,ZZ="",ZZD="",RCNT=0
 I $G(^TMP($J,ORGLOBL,"OUT",0))<0 D  Q
 .S YY(II)="ERR^Drug-Drug order checks (Duplicate Therapy, Duplicate Drug, Drug Interaction) were not able to be performed. "_$P($G(^TMP($J,ORGLOBL,"OUT",0)),U,2)
 .S II=II+1
 I $D(^TMP($J,ORGLOBL,"OUT","EXCEPTIONS")) D
 .S ORX="" F  S ORX=$O(^TMP($J,ORGLOBL,"OUT","EXCEPTIONS",ORX)) Q:'$L(ORX)  D
 ..S ORY=0 F  S ORY=$O(^TMP($J,ORGLOBL,"OUT","EXCEPTIONS",ORX,ORY)) Q:'ORY  D
 ...I $L($G(ORIFN))>0,$G(ORIFN)=$P($G(^TMP($J,ORGLOBL,"OUT","EXCEPTIONS",ORX,ORY)),U,5) Q
 ...S YY(II)="ERR^"_$P($G(^TMP($J,ORGLOBL,"OUT","EXCEPTIONS",ORX,ORY)),U,7)
 ...I $L($P($G(^TMP($J,ORGLOBL,"OUT","EXCEPTIONS",ORX,ORY)),U,10))>0 S YY(II)=YY(II)_"("_$P($G(^TMP($J,ORGLOBL,"OUT","EXCEPTIONS",ORX,ORY)),U,10)_")"
 ...S II=II+1
 S ORX="" F ORX="DRUGDRUG","THERAPY" D
 .Q:'$D(^TMP($J,ORGLOBL,"OUT",ORX,"ERROR"))
 .S ORY="" F  S ORY=$O(^TMP($J,ORGLOBL,"OUT",ORX,"ERROR",ORY)) Q:'$L(ORY)  D
 ..S ORZ=0 F  S ORZ=$O(^TMP($J,ORGLOBL,"OUT",ORX,"ERROR",ORY,ORZ)) Q:'ORZ  D
 ...S YY(II)="ERR^"_$$UPPER^ORWDPS32($G(^TMP($J,ORGLOBL,"OUT",ORX,"ERROR",ORY,ORZ,"SEV")))_": "_$P($G(^TMP($J,ORGLOBL,"OUT",ORX,"ERROR",ORY,ORZ,0)),U)_" - "_$G(^TMP($J,ORGLOBL,"OUT",ORX,"ERROR",ORY,ORZ,"TEXT"))
 ...S II=II+1
 I +$P(ORPROSP,U,2) D
 .;set info about the drug being ordered
 .S TDATA("NEW","TXT")=""
 .S I="" F  S I=$O(^TMP($J,ORGLOBL,"IN","PROSPECTIVE",I)) Q:'$L(I)  D
 ..I $P($G(^TMP($J,ORGLOBL,"IN","PROSPECTIVE",I)),U,3)=+$P(ORPROSP,U,2) D
 ...S TDATA("NEW","TXT")=$P($G(^TMP($J,ORGLOBL,"IN","PROSPECTIVE",I)),U,4)
 ...S TDATA("NEW","PROSP")=$P(I,";",3,4)
 .S TDATA("NEW","PTYPE")=$S($G(ORKDG)="PSI":"I",$G(ORKDG)="PSO":"O",$G(ORKDG)="PSIV":"I",$G(ORKDG)="PSH":"O",1:"")
 .S TDATA("NEW","OTYPE")=$S($G(ORKDG)="PSI":"UD",$G(ORKDG)="PSO":"OP",$G(ORKDG)="PSIV":"IV",$G(ORKDG)="PSH":"NV",1:"")
 .I '$L(TDATA("NEW","PTYPE")) D  ;if no display group
 ..D ADM^VADPT2
 ..S TDATA("NEW","PTYPE")=$S(+$G(VADMVT)>0:"I",1:"O")
 ..K VADMVT
 D DD(.TDATA,$S(+ORPROSP>0:0,1:1))
 Q:'$L($G(TDATA("NEW","PROSP")))
 D DI(.TDATA)
 I $G(TDATA("NEW","OTYPE"))="UD" D  ;p402 Set OTYPE to C to distinguish the prospect as an IMO or clinical order if outpatient
 .D ADM^VADPT2 S TDATA("NEW","PTYPE")=$S(+$G(VADMVT)>0:"I",1:"O")
 .I $G(TDATA("NEW","PTYPE"))="O" S TDATA("NEW","OTYPE")="C"
 .K VADMVT
 D DT(.TDATA)
 Q
 ;
DI(TDATA) ;add drug interaction checks
 N GL,ORSEV,ORDRUG,ORTXT,ORIEN
 S GL=$NA(^TMP($J,ORGLOBL,"OUT","DRUGDRUG"))
 S J="" F  S J=$O(@GL@(J)) Q:'$L(J)  D
 .S K="" F  S K=$O(@GL@(J,K)) Q:'$L(K)  D
 ..S L=0 F  S L=$O(@GL@(J,K,L)) Q:'$L(L)  D
 ...S M=0 F  S M=$O(@GL@(J,K,L,M)) Q:'M  D
 ....N ORNUM,ORSEV,ORDNAME,ORZ,CNT,ORSTAT,ORMON,ORWHICH,ORLINE,ORIDX
 ....;get the associated order number
 ....S ORNUM=$P(L,";",1,2)
 ....;if the status of the associated order is DISCONTINUED then don't add
 ....S ORSTAT=$$PHSTAT(DFN,ORNUM)
 ....Q:ORSTAT="DISCONTINUED"
 ....S ORWHICH=""
 ....I $P($P(@GL@(J,K,L,M),U),";",3,4)=TDATA("NEW","PROSP") D
 .....S ORWHICH=K_" ["_$S($P(L,";",3)="PROSPECTIVE":"UNRELEASED",1:ORSTAT)_"]"
 ....I $P(L,";",3,4)=TDATA("NEW","PROSP") D
 .....S ORWHICH=$P(@GL@(J,K,L,M),U,4)_" ["
 .....S ORWHICH=ORWHICH_$S($P($P(@GL@(J,K,L,M),U),";",3)="PROSPECTIVE":"UNRELEASED",1:$$PHSTAT(DFN,$P($P(@GL@(J,K,L,M),U),";",1,2)))
 .....S ORWHICH=ORWHICH_"]"
 ....Q:$L(ORWHICH)<2
 ....;get text
 ....S ORTXT(J,K_";"_ORNUM)=$S($G(ORTXT(J,K))'="":ORTXT(J,K)_" ",1:"")_$P($G(@GL@(J,K,L,M,"CLIN")),"CLINICAL EFFECTS:  ",2),ORTXT(J,K_";"_ORNUM,"ORWHICH")=ORWHICH ;*457
 ....;set the monograph into the temp global
 ....I $D(@GL@(J,K,L,M,"PMON")) D
 .....S ^TMP($J,"ORMONOGRAPH")=1+$G(^TMP($J,"ORMONOGRAPH"))
 .....S ORMON=^TMP($J,"ORMONOGRAPH")
 .....S ^TMP($J,"ORMONOGRAPH",ORMON,"INT")=@GL@(J,K,L,M,"INT")
 .....S ORIDX="",ORLINE=1 F  S ORIDX=$O(@GL@(J,K,L,M,"PMON",ORIDX)) Q:+$G(ORIDX)=0  D
 ......S ^TMP($J,"ORMONOGRAPH",ORMON,"DATA",ORLINE,0)=@GL@(J,K,L,M,"PMON",ORIDX,0),ORLINE=ORLINE+1
 .....S ORTXT(J,K_";"_ORNUM,"MONOGRAPH")=1,ORTXT(J,K_";"_ORNUM,"ORMON",ORMON)="" ;*457
 ....;get the severity
 ....S ORSEV=$$UPPER^ORU($G(@GL@(J,K,L,M,"SEV")))
 ....;get the drug name
 ....S ORDNAME=K
 ....S ORTXT(J,K_";"_ORNUM,"YY")="DI^"_ORSEV_U_ORNUM_U_ORDNAME_U_U_$G(@GL@(J,K,L,M,"INT")) ;*457
 ;RETURN DATA IN EXPECTED FORMAT
 S ORSEV="" F  S ORSEV=$O(ORTXT(ORSEV)) Q:$G(ORSEV)=""  D
 .S ORDRUG="" F  S ORDRUG=$O(ORTXT(ORSEV,ORDRUG)) Q:$G(ORDRUG)=""  D
 ..S YY(II)=ORTXT(ORSEV,ORDRUG,"YY")
 ..S $P(YY(II),U,5)=TDATA("NEW","TXT")_" and "_ORTXT(ORSEV,ORDRUG,"ORWHICH")_" - "_ORTXT(ORSEV,ORDRUG)
 ..S ORIEN=0 F  S ORIEN=$O(ORTXT(ORSEV,ORDRUG,"ORMON",ORIEN)) Q:+$G(ORIEN)=0  D
 ...S ^TMP($J,"ORMONOGRAPH",ORIEN,"OC")=$P(YY(II),U,5)
 ..S:$G(ORTXT(ORSEV,ORDRUG,"MONOGRAPH")) $P(YY(II),U,5)=$P(YY(II),U,5)_" - Monograph Available"
 ..S II=II+1
 Q
 ;
DD(TDATA,ORDPROSP) ;add duplicate drug checks
 ;ORDPROSP: PERFORM PROSPECTIVE DRUG CHECK
 ;          1 FOR YES
 ;          0 FOR NO
 S XX=0,ZZ=""
 F  S XX=$O(^TMP($J,"DD",XX)) Q:XX<1  D
 .N ORREM
 .S ZZ=$G(^TMP($J,"DD",XX,0)),ORMTYPE=$P($P(ZZ,U,4),";",2)
 .S ORREM=$P($P(ZZ,U,4),";") I (ORREM["Z"),$D(^TMP($J,ORGLOBL,"OUT","REMOTE",+ORREM)) D
 ..N ORTXT,ORREM1,ORREMSIG
 ..S ORREM1=$G(^TMP($J,ORGLOBL,"OUT","REMOTE",+ORREM))
 ..S ORREMSIG=$G(^TMP($J,ORGLOBL,"OUT","REMOTE",+ORREM,"SIG",0))
 ..S ORTXT=" "_ORREMSIG_" ["_$P(ORREM1,U,4)_" -  Last Fill: "_$P(ORREM1,U,6)_"  Quantity Dispensed: "_$P(ORREM1,U,8)_"] >>"_$P(ORREM1,U)
 ..S $P(ZZ,U,2)=$P(ZZ,U,2)_ORTXT
 .I +ORDPROSP,$G(TDATA("NEW","PTYPE"))'=$G(ORMTYPE) Q
 .S ORN=$P($P(ZZ,U,3),";"),ORZ=""
 .I $L($G(ORN))>0,+$G(ORN)=+$G(ORIFN) Q  ;QUIT if dup med ord # = current ord #
 .I +$G(ORIFN),+$G(ORN)=$P(^OR(100,+ORIFN,3),U,5) Q  ;QUIT if dup med ord # = the current order #'s REPLACED ORDER (changing an order)
 .I +ORDPROSP,+$P(ORPROSP,U,2)'=+ZZ Q
 .I $L(ORN),$D(^OR(100,ORN,8,0)) S ORZ=^OR(100,ORN,8,0)
 .I $L($G(ORZ)),($P(^OR(100,ORN,8,$P(ORZ,U,3),0),U,2)="DC") Q
 .I $L(ORN),$P(^ORD(100.01,$P(^OR(100,ORN,3),U,3),0),U)="DISCONTINUED" Q
 .I ZZ'="" S YY(II)="DD^"_ZZ,II=II+1
 .S ^TMP($J,"DD",XX,"OC")="" ;set this if this DD entry turned into an OC
 Q
 ;
DT(TDATA) ;add duplicate therapy checks
 N I
 S GL=$NA(^TMP($J,ORGLOBL,"OUT","THERAPY"))
 S I=0 F  S I=$O(@GL@(I)) Q:'I  D
 .;get all drug names
 .N ORDRUGS,ORCLASS,ORF,ORPROSCNT,ORPROFCNT,DRUGS,ORRETSTR S ORDRUGS="",ORCLASS="",ORF=0,ORPROSCNT=0,ORPROFCNT=0
 .S J=0 F  S J=$O(@GL@(I,"DRUGS",J)) Q:'J  D
 ..;keep count of PROSPECTIVE drugs
 ..I $P($P($G(@GL@(I,"DRUGS",J)),U),";",3,4)=TDATA("NEW","PROSP") S ORF=1
 ..I $P($P($G(@GL@(I,"DRUGS",J)),U),";",3)="PROSPECTIVE" D
 ...S ORPROSCNT=1+$G(ORPROSCNT)
 ...I $P($P($G(@GL@(I,"DRUGS",J)),U),";",3,4)'=TDATA("NEW","PROSP") S ORDRUGS=ORDRUGS_$S($L(ORDRUGS):", ",1:"")_$P($G(@GL@(I,"DRUGS",J)),U,3)_" [UNRELEASED]",DRUGS($P($G(@GL@(I,"DRUGS",J)),U,3))=""
 ..;-check each PROFILE drug to see if it is not the same order as the prospective (ORIFN)
 ..I $P($P($G(@GL@(I,"DRUGS",J)),U),";",3)="PROFILE" D
 ...;if not the same then set ORNUM=THE PROFILE DRUG "O;PSNUM"
 ...I $P($P($G(@GL@(I,"DRUGS",J)),U),";",2)'=$G(^OR(100,+$G(ORIFN),4)) D
 ....I $L($P($G(@GL@(I,"DRUGS",J)),U,4))>0,(+$P($G(@GL@(I,"DRUGS",J)),U,4)=$P($G(^OR(100,+$G(ORIFN),3)),U,5)) Q
 ....I $L($P($G(@GL@(I,"DRUGS",J)),U,4))>0,(+$P($G(@GL@(I,"DRUGS",J)),U,4)=+$G(ORIFN)) Q
 ....I $E($G(@GL@(I,"DRUGS",J)),1)="R" S $P(@GL@(I,"DRUGS",J),U,5)="O"
 ....I $E($G(@GL@(I,"DRUGS",J)),1)="C" S $P(@GL@(I,"DRUGS",J),U,5)="O" ; p402 IMO or CLINIC ORDER
 ....I $G(TDATA("NEW","PTYPE"))'=$P($G(@GL@(I,"DRUGS",J)),U,5) Q
 ....S ORNUM=$P($P($G(@GL@(I,"DRUGS",J)),U),";",1,2)
 ....I $$INDD($P($G(@GL@(I,"DRUGS",J)),U,3))=0 D
 .....S ORDRUGS=ORDRUGS_$S($L(ORDRUGS):", ",1:"")_$P($G(@GL@(I,"DRUGS",J)),U,3)_" ["_$$PHSTAT(DFN,ORNUM)_"]"
 .....S DRUGS($P($G(@GL@(I,"DRUGS",J)),U,3)_";"_ORNUM)=$P($G(@GL@(I,"DRUGS",J)),U,4),ORPROFCNT=ORPROFCNT+1 ;*457
 .Q:'$$CHKDD(.DRUGS)
 .;quit if ORNUM is not set and PROSPECTIVE count <=1
 .Q:('$L($G(ORNUM))&(ORPROSCNT<2))
 .;get all classes
 .I ORF S J=0 F  S J=$O(@GL@(I,J)) Q:'J  D
 ..S ORCLASS=ORCLASS_$S($L(ORCLASS):", ",1:"")_$G(@GL@(I,J,"CLASS"))
 .;assemble return string ("DC"+ORNUM_U_Classes_U_Classes (drugs))
 .S ORRETSTR="Duplicate Therapy: Order(s) exist for {"_ORDRUGS_"} in the same therapeutic categor(ies): "_ORCLASS
 .I ORF S YY(II)="DC"_U_$G(ORNUM)_U_ORCLASS_U_ORRETSTR,II=II+1
 Q
 ;
PHSTAT(DFN,ORNUM) ;get the status of the order
 N RET,J,I
 S RET=""
 I $P(ORNUM,";")="P" S RET="PENDING"
 I $P(ORNUM,";")="N" S RET="ACTIVE NON-VA"
 I $P(ORNUM,";")="O" D
 .K ^TMP($J,"OROCLST") D RX^PSO52API(DFN,"OROCLST",$P(ORNUM,";",2),,"ST")
 .S RET=$P($G(^TMP($J,"OROCLST",DFN,$P(ORNUM,";",2),100)),U,2)
 .K ^TMP($J,"OROCLST")
 I $P(ORNUM,";")="I"!($E($P(ORNUM,";"),1)="C") D
 .N ORLAST,ORPHNUM
 .I $E($P(ORNUM,";"),1)="C" S ORLAST=$S($E($P(ORNUM,";"),2)=1:"V",$E($P(ORNUM,";"),2)=2:"U",1:"NV")
 .E  S ORLAST=$E(ORNUM,$L(ORNUM))
 .I ORLAST="P" S RET="PENDING" Q
 .S ORPHNUM=+$P(ORNUM,";",2)
 .I ORLAST="U" D
 ..K ^TMP($J,"OR GET STATUS") D PSS431^PSS55(DFN,ORPHNUM,"","","OR GET STATUS")
 ..S RET=$P($G(^TMP($J,"OR GET STATUS",ORPHNUM,28)),U,2)
 .I ORLAST="V" D
 ..K ^TMP($J,"OR GET STATUS") D PSS436^PSS55(DFN,ORPHNUM,"OR GET STATUS")
 ..S RET=$P($G(^TMP($J,"OR GET STATUS",ORPHNUM,100)),U,2)
 .I ORLAST="NV" D
 ..K ^TMP($J,"OR GET STATUS") D PSJ^PSJ53P1(ORPHNUM,"OR GET STATUS")
 ..S RET=$P($G(^TMP($J,"OR GET STATUS",ORPHNUM,28)),U,2)
 .S:$E($P(ORNUM,";"),1)="C" RET=RET_" CLINIC ORDER"
 I $P(ORNUM,";")="R" D
 .N ORREMOTE S ORREMOTE=$G(^TMP($J,ORGLOBL,"OUT","REMOTE",$P(ORNUM,";",2)))
 .S RET=$P(ORREMOTE,U,4)_" >> "_$P(ORREMOTE,U)
 I "^PENDING^NON-VERIFIED^NON VERIFIED^INCOMPLETE^DRUG INTERACTIONS^"[(U_RET_U) S RET="PENDING"
 Q RET
 ;
CHKDD(DARRAY) ;check the duplicate drug OCs returned
 ;if all drugs in DARRAY are already displayed in a DD OC then don't show the DT OC (return 0)
 ;check the ^TMP($J,"DD",I,"OC") node to see if the DD entry turned into an OC
 N I S I=0 F  S I=$O(^TMP($J,"DD",I)) Q:'I  D
 .I $D(DARRAY($P($G(^TMP($J,"DD",I,0)),U,2))),$D(^TMP($J,"DD",I,"OC")) D
 ..K DARRAY($P($G(^TMP($J,"DD",I,0)),U,2))
 .N J S J=0 F  S J=$O(DARRAY(J)) Q:'$L(J)  D
 ..I DARRAY(J)=$P($G(^TMP($J,"DD",I,0)),U,3),($L(DARRAY(J))>0) D
 ...K DARRAY(J)
 Q $D(DARRAY)
 ;
INDD(ORDRUG) ;checks if ORDRUG is in the duplicate drug OCs returned
 N RET S RET=0
 N I S I=0 F  S I=$O(^TMP($J,"DD",I)) Q:'I  D
 .I ORDRUG=$P($G(^TMP($J,"DD",I,0)),U,2),$D(^TMP($J,"DD",I,"OC")) S RET=1
 Q RET
 ;
