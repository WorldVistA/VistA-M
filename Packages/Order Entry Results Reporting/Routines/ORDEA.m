ORDEA ;ISL/TC & JMH & JLC - DEA related items ;05/06/14  06:58
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**306,374**;Dec 17, 1997;Build 9
 ;
 ;Reference to ^PSSOPKI supported by DBIA #3737
 ;Reference to ^PSSUTLA1 supported by DBIA #3373
 ;
 ;
DEATEXT(ORY) ;returns the mandatory dea text to show when a user checks a controlled substance order to be signed on the signature dialog
 N I,ORTY
 D GETWP^XPAR(.ORTY,"SYS","OR DEA TEXT")
 S I=0 F  S I=$O(ORTY(I)) Q:'I  S ORY(I)=ORTY(I,0)
 Q
 ;
CSVALUE(ORY,ORID) ;return 1 if the order (ORID) is a controlled substance, 0 for non-controlled substance
 N OROI,ORPSTYPE,ORRXDG
 S ORY=0,ORPSTYPE=""
 S OROI=$$OI^ORQOR2(+ORID)
 S ORRXDG=$$DGRX^ORQOR2(+ORID)
 I ORRXDG="UNIT DOSE MEDICATIONS" S ORPSTYPE="I"
 I ORRXDG="INPATIENT MEDICATIONS" S ORPSTYPE="I"
 I ORRXDG="IV MEDICATIONS" S ORPSTYPE="I"
 I ORRXDG="OUTPATIENT MEDICATIONS" S ORPSTYPE="O"
 I ORRXDG="PHARMACY" S ORPSTYPE="O"
 Q:ORPSTYPE=""
 D CSCHECK(.ORY,OROI,ORPSTYPE)
 S ORY=+ORY
 Q
 ;
PNDHLD(ORY,ORID) ;return 1 if the order is pending a HOLD, 0 otherwise
 S ORY=0
 N ORLSTACT S ORLSTACT=$O(^OR(100,+ORID,8,"A"),-1)
 I $P(^OR(100,+ORID,8,ORLSTACT,0),U,2)="HD" S ORY=1
 Q
 ;
CSCHECK(ORCSVAL,OROI,ORPSTYPE) ; return 1 if OI is a controlled substance, 0 for non-controlled substance
 ;ORCSVAL=1:controlled substance, 0:non-controlled substance
 ;OROI=OR orderable item
 ;ORPSTYPE="O":Outpatient pharmacy order, "I" or "U":Inpatient med order
 N ORPSOI,ORTPKG,ORDEAFLG,ORDETOX
 S ORCSVAL=0_U_0,ORTPKG=$P($G(^ORD(101.43,+$G(OROI),0)),U,2)
 I ORPSTYPE="I" Q
 Q:ORTPKG'["PS"
 S ORPSOI=+ORTPKG Q:ORPSOI'>0
 I '$L($T(OIDEA^PSSUTLA1)) Q
 S ORDEAFLG=+$$OIDEA^PSSOPKI(ORPSOI,ORPSTYPE)
 I ORDEAFLG'>0 S ORCSVAL=0
 I ORDEAFLG>0 S ORCSVAL=1
 S ORDETOX=0
 ;get detox value either from OIDEA^PSSUTLA1 or from different api or method
 S ORDETOX=$$OIDETOX^PSSOPKI(ORPSOI,ORPSTYPE)
 S ORCSVAL=ORCSVAL_U_ORDETOX
 Q
SIGINFO(ORY,ORDFN,ORPROV) ;returns the provider/patient info that must be displayed when signing controlled substance orders
 N ORI S ORI=0
 ;patient name
 S ORI=ORI+1,ORY(ORI)=$P(^DPT(+ORDFN,0),U)
 ;date of issuance
 S ORI=ORI+1,ORY(ORI)="Date of Issuance: "_$$FMTE^XLFDT($$DT^XLFDT)
 ;provider name
 S ORI=ORI+1,ORY(ORI)="Provider: "_$$GET1^DIQ(200,ORPROV,.01,"E")
 ;provider address (facility address)
 N ORINST
 D GETS^DIQ(4,DUZ(2),".01;.02;1.01;1.02;1.03;1.04","E","ORINST")
 N ORADDNUM S ORADDNUM=0
 I $L(ORINST(4,DUZ(2)_",",1.01,"E"))>0 S ORI=ORI+1,ORY(ORI)=ORINST(4,DUZ(2)_",",1.01,"E"),ORADDNUM=ORADDNUM+1
 I $L(ORINST(4,DUZ(2)_",",1.02,"E"))>0 S ORI=ORI+1,ORY(ORI)=ORINST(4,DUZ(2)_",",1.02,"E"),ORADDNUM=ORADDNUM+1
 I $L(ORINST(4,DUZ(2)_",",1.03,"E"))>0 S ORI=ORI+1,ORY(ORI)=ORINST(4,DUZ(2)_",",1.03,"E"),ORADDNUM=ORADDNUM+1
 I $L(ORINST(4,DUZ(2)_",",.02,"E"))>0 S ORY(ORI)=ORY(ORI)_", "_ORINST(4,DUZ(2)_",",.02,"E"),ORADDNUM=ORADDNUM+1
 I $L(ORINST(4,DUZ(2)_",",1.04,"E"))>0 S ORY(ORI)=ORY(ORI)_"  "_ORINST(4,DUZ(2)_",",1.04,"E"),ORADDNUM=ORADDNUM+1
 I ORADDNUM=0 D
 .S ORI=ORI+1,ORY(ORI)="No Address on record"
 .I $L(ORINST(4,DUZ(2)_",",.01,"E"))>0 S ORI=ORI+1,ORY(ORI)="for "_ORINST(4,DUZ(2)_",",.01,"E")
 ;dea #
 S ORI=ORI+1,ORY(ORI)="DEA: "_$$DEA^XUSER(,ORPROV)
 ;detox #
 N ORDETOX S ORDETOX=$$DETOX^XUSER(ORPROV)
 I $L(ORDETOX)>0 S ORI=ORI+1,ORY(ORI)="Detox: "_ORDETOX
 Q
HASHINFO(ORY,ORDFN,ORPROV) ;basic data for all orders getting signed
 N ORI S ORI=0
 ;patient name
 S ORI=ORI+1,ORY(ORI)="PatientName:"_$P(^DPT(+ORDFN,0),U)
 ;patient address
 N VAPA,DFN,ORPATADD
 S DFN=ORDFN
 D ADD^VADPT
 S ORPATADD=VAPA(1)_U_VAPA(2)_U_VAPA(3)_U_VAPA(4)_U_$P(VAPA(5),"^")_U_$P(VAPA(5),"^",2)_U_VAPA(6)_U_VAPA(7)
 S ORI=ORI+1,ORY(ORI)="PatientAddress:"_ORPATADD
 ;date of issuance
 S ORI=ORI+1,ORY(ORI)="IssuanceDate:"_$$FMTE^XLFDT($$DT^XLFDT)
 S ORI=ORI+1,ORY(ORI)="IssuanceInt:"_$$DT^XLFDT
 ;provider name
 S ORI=ORI+1,ORY(ORI)="ProviderName:"_$$GET1^DIQ(200,ORPROV,.01,"E")
 S ORI=ORI+1,ORY(ORI)="ProviderNumber:"_ORPROV
 ;provider address (facility address)
 N ORINST
 D GETS^DIQ(4,DUZ(2),".01;.02;1.01;1.02;1.03;1.04","E","ORINST")
 S ORI=ORI+1,ORY(ORI)="ProviderAddress:"_ORINST(4,DUZ(2)_",",1.01,"E")_U_ORINST(4,DUZ(2)_",",1.02,"E")_U_ORINST(4,DUZ(2)_",",1.03,"E")_U_ORINST(4,DUZ(2)_",",.02,"E")_U_ORINST(4,DUZ(2)_",",1.04,"E")
 S ORI=ORI+1,ORY(ORI)="ProviderAdd1:"_ORINST(4,DUZ(2)_",",.01,"E")
 ;dea #
 S ORI=ORI+1,ORY(ORI)="DeaNumber:"_$$DEA^XUSER(,ORPROV)
 ;detox #
 N ORDETOX S ORDETOX=$$DETOX^XUSER(ORPROV)
 I $L(ORDETOX)>0 S ORI=ORI+1,ORY(ORI)="DetoxNumber:"_ORDETOX
 Q
ORDHINFO(ORY,ORIFN,HASH,OHINFO) ;
 N IENS
 D BUILDFDA(ORIFN,.ORDFDA,.ORY,$G(HASH),.OHINFO)
 Q
BUILDFDA(ORIFN,ORDFDA,OROUT,HASH,OHD) ;
 ;ORIFN is the CPRS order number to use
 ;this will need to be updated once we have a way to store DEA and DETOX
 ;numbers that are retrieved during validation
 ;returns 0 if not successful, 1 if successful
 N ERROR,ORDIALOG,A,PIEN,DFN,S1,DOSE,SCHED,ROUTE,I
 N CONJ,INSTR,SCHED,DUR,DOSE,VADM
 I $G(ORIFN)="" Q 0
 K ^TMP($J,"ORDEA")
 S ORDIALOG=$$GET1^DIQ(100,ORIFN_",",2,"I") I ORDIALOG="" Q 0
 D GETDLG^ORCD(+ORDIALOG),GETORDER^ORCD("^OR(100,"_ORIFN_",4.5)")
 S INSTR=$$PTR("INSTRUCTIONS"),SCHED=$$PTR("SCHEDULE"),DUR=$$PTR("DURATION"),DOSE=$$PTR("DOSE")
 S CONJ=$$PTR("AND/THEN"),ROUTE=$$PTR("ROUTE")
 S IENS="+1,"
 F I=1:1 Q:'$D(OHD(I))  D
 . I $G(OHD(I))["IssuanceInt" S ORDFDA(101.52,IENS,4)=$P(OHD(I),":",2,99) Q
 . I $G(OHD(I))["ProviderNumber" S ORDFDA(101.52,IENS,31)=$P(OHD(I),":",2,99) Q
 . I $G(OHD(I))["ProviderName" S ORDFDA(101.52,IENS,12)=$P(OHD(I),":",2,99) Q
 . I $G(OHD(I))["DeaNumber" S ORDFDA(101.52,IENS,10)=$P(OHD(I),":",2,99) Q
 . I $G(OHD(I))["DetoxNumber" S ORDFDA(101.52,IENS,11)=$P(OHD(I),":",2,99) Q
 . I $G(OHD(I))["ProviderAdd1" S ORDFDA(101.52,IENS,13)=$P(OHD(I),":",2,99) Q
 . I $G(OHD(I))["ProviderAddress" D
 .. S A=$P(OHD(I),":",2,99)
 .. S ORDFDA(101.52,IENS,14)=$P(A,"^"),ORDFDA(101.52,IENS,15)=$P(A,"^",2)
 .. S ORDFDA(101.52,IENS,16)=$P(A,"^",3),ORDFDA(101.52,IENS,17)=$P(A,"^",4)
 .. S ORDFDA(101.52,IENS,17.5)=$P(A,"^",5)
 . I $G(OHD(I))["PatientAddress" D
 .. S A=$P(OHD(I),":",2,99)
 .. S ORDFDA(101.52,IENS,21)=$P(A,"^"),ORDFDA(101.52,IENS,22)=$P(A,"^",2),ORDFDA(101.52,IENS,24)=$P(A,"^",3)
 .. S ORDFDA(101.52,IENS,25)=$P(A,"^",4),ORDFDA(101.52,IENS,26)=$P(A,"^",6),ORDFDA(101.52,IENS,27)=$P(A,"^",7)
 S ORDFDA(101.52,IENS,.01)=ORIFN
 S A=$P($G(ORDIALOG("B","DISPENSE DRUG")),"^",2),PIEN=$G(ORDIALOG(A,1)) D
 . I PIEN="" S OROUT(1)="DrugName:" Q
 . D DATA^PSS50(PIEN,"","","","","ORDEA")
 . S ORDFDA(101.52,IENS,6)=^TMP($J,"ORDEA",PIEN,.01),ORDFDA(101.52,IENS,29)=PIEN,ORDFDA(101.52,IENS,30)=^TMP($J,"ORDEA",PIEN,3)
 . S OROUT(1)="DrugName:"_^TMP($J,"ORDEA",PIEN,.01)
 S INSTR=$O(^ORD(101.41,"AB","OR GTX INSTRUCTIONS",0))
 S A=$P($G(ORDIALOG("B","QUANTITY")),"^",2),ORDFDA(101.52,IENS,8)=$G(ORDIALOG(A,1))
 S OROUT(2)="Quantity:"_$G(ORDIALOG(A,1))
 S A=$P($G(ORDIALOG("B","REFILLS")),"^",2),ORDFDA(101.52,IENS,28)=$G(ORDIALOG(A,1))
 S S1=0 F I=1:1 Q:'$D(ORDIALOG(INSTR,I))  D
 . S A=$P($G(ORDIALOG(DOSE,I)),"&",1,6)_"|"_$G(ORDIALOG(SCHED,I))_"|"_$$DUR($G(ORDIALOG(DUR,I)))_"|"_$$CONJ($G(ORDIALOG(CONJ,I)))_"|"_$G(ORDIALOG(ROUTE,I))
 . S ORDFDA(101.529,"+"_(I+1)_","_IENS,.01)=A
 . I '$D(OROUT(3)) S OROUT(3)="Directions:"_A
 . E  S OROUT(3)=OROUT(3)_A
 S A=+$$GET1^DIQ(100,ORIFN_",",6,"I"),A=$$GET1^DIQ(44,A,3,"I")
 S DFN=+$$GET1^DIQ(100,ORIFN_",",.02,"I"),A=$$GETICN^MPIF001(DFN),ORDFDA(101.52,IENS,20)=$S(A["^":"",1:A)
 D DEM^VADPT S ORDFDA(101.52,IENS,18)=VADM(1),ORDFDA(101.52,IENS,19)=DFN
 S ORDFDA(101.52,IENS,2)=$G(HASH)
 Q
BUILD(ORIFN) ;Build ARCHIVE entry for CPRS order number
 N ORDFDA,OROUT,ERROR
 D BUILDFDA(ORIFN,.ORDFDA,.OROUT)
 D UPDATE^DIE("","ORDFDA","ORIEN","ERROR")
 Q 1
SUBSCRIB(ORIFN,RXN) ;API for Pharmacy to subscribe to an archive entry
 ;ORIFN is the CPRS order number of the archive Pharmacy wants to use
 ;RXN is the Pharmacy prescription number that is subscribing to the archive
 ;returns a 0 if not successful
 ;returns a 1 if successful
 N A,IEN,ORDFDA,ERROR
 I $G(ORIFN)=""!($G(RXN)="") Q 0
 S IEN=$$FIND1^DIC(101.52,"","MXQ",ORIFN,"","","ERR")
 I 'IEN Q 0
 S A=$$GET1^DIQ(101.52,IEN_",",1,"I") I A]"",A'=RXN Q 0
 S ORDFDA(101.52,IEN_",",1)=RXN
 D FILE^DIE("","ORDFDA","ERROR")
 I $D(ERROR) Q 0
 Q 1
ARCHIVE(ORIFN) ;retrieve archive for specified order number
 ;ORIFN is the CPRS order number whose archive is requested
 I $G(ORIFN)="" Q
 K ^TMP($J,"ORDEA",ORIFN) N IEN,ERROR,ORDEA,A,I,S1
 S IEN=$$FIND1^DIC(101.52,"","MXQ",ORIFN,"","","ERR")
 I 'IEN Q
 S IEN=IEN_","
 D GETS^DIQ(101.52,IEN,"**","IE","ORDEA","ERROR") I $D(ERROR) Q
 S A(1)="" F I=1,4,6,29,30,8,28 S A(1)=A(1)_$G(ORDEA(101.52,IEN,I,"I"))_"^"
 S A(1)=$P(A(1),"^",1,7)
 S A(2)="" F I=10,11,12,31 S A(2)=A(2)_$G(ORDEA(101.52,IEN,I,"I"))_"^"
 S A(2)=$P(A(2),"^",1,4)
 S A(3)="" F I=13,14,15,16,17,17.5 S A(3)=A(3)_$G(ORDEA(101.52,IEN,I,"I"))_"^"
 S A(3)=$P(A(3),"^",1,6)
 S A(4)="" F I=18,19,20 S A(4)=A(4)_$G(ORDEA(101.52,IEN,I,"I"))_"^"
 S A(4)=$P(A(4),"^",1,3)
 S A(5)="" F I=21,22,24,25,26,27 S A(5)=A(5)_$G(ORDEA(101.52,IEN,I,"I"))_"^"
 S A(5)=$P(A(5),"^",1,6)
 F I=1:1:5 S ^TMP($J,"ORDEA",ORIFN,I)=A(I)
 S S1=0 F  S S1=$O(ORDEA(101.529,S1)) Q:'S1  S ^TMP($J,"ORDEA",ORIFN,6,$P(S1,","))=ORDEA(101.529,S1,.01,"I")
 Q
HASHRTN(ORIFN) ;returns hash of a specified archive entry
 ;ORIFN is the CPRS order number for the archive
 N IEN,ORHASH,ERR,ERROR
 S IEN=$$FIND1^DIC(101.52,"","MXQ",ORIFN,"","","ERR")
 I 'IEN Q 0
 S IEN=IEN_","
 S ORHASH=$$GET1^DIQ(101.52,IEN,2,"I","","ERROR") I $D(ERROR) Q 0
 Q ORHASH
BACKDOOR(ORIFN,ORPROV,ORD) ;create archive for new backdoor order
 ;called from ORMPS
 N DFN,OHD,OUT,ORDFDA,PIEN,A,ORSCHED,S1
 K ^TMP($J,"ORDEAB")
 Q:$G(ORIFN)=""  I '$D(^OR(100,ORIFN,0)) Q
 I $P($G(^ORD(101.41,+ORD,0)),"^")'="PSO OERR" Q
 S S1=0 F  S S1=$O(ORD(S1)) Q:'S1  I $P(ORD(S1),"^",2)["DRUG" S PIEN=$G(ORD(S1,1)) I PIEN]"" Q
 I $G(PIEN)="" Q
 D DATA^PSS50(PIEN,"","","","","ORDEAB") S ORSCHED=$G(^TMP($J,"ORDEAB",PIEN,3))
 I ORSCHED'?1N.E Q
 I ",2,3,4,5,"'[$E(ORSCHED) Q
 S DFN=+$P($G(^OR(100,ORIFN,0)),"^",2)
 D HASHINFO(.OHD,DFN,ORPROV)
 D BUILDFDA(ORIFN,.ORDFDA,.OUT,"",.OHD)
 S ORDFDA(101.52,IENS,1)=$G(^OR(100,ORIFN,4))
 D UPDATE^DIE("","ORDFDA","","ERROR")
 Q
PINLKCHK(ORY) ;check if the current user has an active PIN lock
 ;ORY=1 if there is an active lock and ORY=0 if no active lock
 S ORY=0
 Q:'$D(^XTMP("OR DEA PIN LOCK",DUZ))
 N ORDIFF
 S ORDIFF=$$FMDIFF^XLFDT($$NOW^XLFDT,$G(^XTMP("OR DEA PIN LOCK",DUZ)),2)
 ;CHECK IF LOCK IS LESS THAN 15 MINUTES OLD
 I ORDIFF<900 S ORY=1
 Q
PINLKSET(ORY) ;set a PIN lock on the current user
 S ^XTMP("OR DEA PIN LOCK",0)=$$FMADD^XLFDT($$NOW^XLFDT,2)_U_$$NOW^XLFDT
 S ^XTMP("OR DEA PIN LOCK",DUZ)=$$NOW^XLFDT
 S ORY=^XTMP("OR DEA PIN LOCK",DUZ)
 Q
LNKMSG(ORY) ;message to display after successful PIV link for admin contact person
 N I,ORTY
 D GETWP^XPAR(.ORTY,"DIV^SYS^PKG","OR DEA PIV LINK MSG")
 S I=0 F  S I=$O(ORTY(I)) Q:'I  S ORY(I)=ORTY(I,0)
 Q
PTR(NAME) ; -- Returns ptr value of prompt in Dialog file
 Q +$O(^ORD(101.41,"AB",$E("OR GTX "_NAME,1,63),0))
DUR(DUR) ;
 Q $S(DUR="":"",DUR=0:"",1:$E($P(DUR," ",2))_+DUR)
CONJ(CNJ) ;
 Q $S(CNJ="":"",CNJ'="T":CNJ,1:"S")
