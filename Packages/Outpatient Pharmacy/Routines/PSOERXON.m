PSOERXON ;ALB/BWF - eRx parsing Utilities ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**581**;DEC 1997;Build 126
 ;
 Q
 ;
MEDCODES(GL,CNT,DATA) ;
 N MRC,MRSC
 S MRC=$G(DATA("MRCODE"))
 D BL(GL,.CNT,"MessageRequestCode",MRC)
 S MRSC=$G(DATA("MRSCODE"))
 D BL(GL,.CNT,"MessageRequestSubCode",MRSC)
 Q
 ; MEDREQ(I,"MEDICATION")=MEDREQ_U_NDC_U_NDCQ
 ; MEDREQ(I,"NOTE")=NOTE
 ; MEDREQ(I,"OTHER")=REF_U_DAYS_U_QTY_U_$P(CLQ,U)_U_$P(QUOM,U)
 ; MEDREQ(I,"SIG")=^TMP("PSOERXA6",$J)
MEDREQ(GL,CNT,DATA) ;
 N REQ,DRUGDAT,DRUG,DNDC,DNDCQ,ODATA,REF,DAYS,QTY,CLQ,QUOM,SIG,ODATA,NOTE,S
 S REQ=0 F  S REQ=$O(DATA(REQ)) Q:'REQ  D
 .S DRUGDAT=$G(DATA(REQ,"MEDICATION"))
 .S DRUG=$P(DATA(REQ,"MEDICATION"),U)
 .S DNDC=$P(DATA(REQ,"MEDICATION"),U,2)
 .S DNDCQ=$P(DATA(REQ,"MEDICATION"),U,3)
 .S ODATA=$G(DATA(REQ,"OTHER"))
 .S SIG=""
 .S S=0 F  S S=$O(DATA(REQ,"SIG",S)) Q:'S  D
 ..S SIG=$G(SIG)_$G(DATA(REQ,"SIG",S,0))
 .S REF=$P(ODATA,U)
 .S DAYS=$P(ODATA,U,2)
 .S QTY=$P(ODATA,U,3)
 .S CLQ=$P(ODATA,U,4)
 .S QUOM=$P(ODATA,U,5)
 .S SUBS=$P(ODATA,U,6)
 .S NOTE=$G(DATA(REQ,"NOTE"))
 .D C S @GL@(CNT,0)="<MedicationRequested>"
 .D BL(GL,.CNT,"DrugDescription",DRUG)
 .D C S @GL@(CNT,0)="<DrugCoded>"
 .D C S @GL@(CNT,0)="<ProductCode>"
 .D BL(GL,.CNT,"Code",DNDC)
 .D BL(GL,.CNT,"Qualifier",DNDCQ)
 .D C S @GL@(CNT,0)="</ProductCode>"
 .D C S @GL@(CNT,0)="</DrugCoded>"
 .I QTY D
 ..D C S @GL@(CNT,0)="<Quantity>"
 ..D BL(GL,.CNT,"Value",QTY)
 ..D BL(GL,.CNT,"CodeListQualifier",CLQ)
 ..I $L(QUOM) D
 ...D C S @GL@(CNT,0)="<QuantityUnitOfMeasure>"
 ...D BL(GL,.CNT,"Code",QUOM)
 ...D C S @GL@(CNT,0)="</QuantityUnitOfMeasure>"
 ..D C S @GL@(CNT,0)="</Quantity>"
 .D BL(GL,.CNT,"DaysSupply",DAYS)
 .D BL(GL,.CNT,"Substitutions",SUBS)
 .D BL(GL,.CNT,"NumberOfRefills",REF)
 .D BL(GL,.CNT,"Note",NOTE)
 .I $L(SIG) D
 ..D C S @GL@(CNT,0)="<Sig>"
 ..D BL(GL,.CNT,"SigText",SIG)
 ..D C S @GL@(CNT,0)="</Sig>"
 .D C S @GL@(CNT,0)="</MedicationRequested>"
 Q
GETCODES(ERXIEN,MCODES) ;
 N ERXIENS,MRC,MRCC,MRSC,NOTE,I,CONT
 S ERXIENS=ERXIEN_","
 D DERX1^PSOERXD2(ERXIEN,ERXIENS,1)
 S MRC=$$MRC(ERXIEN) Q:'MRC!(MRC<0) ""
 I MRC=U Q ""
 S MRCC=$P(MRC,U,2)
 ; if the message request code us 'U' - Prescriber Authorization, message request subcode is required
 S MCODES("MRCODE")=MRCC
 I "PU"'[MRCC Q 1
 I MRCC="U" D
 .S MRSC=$$MRSC()
 .S MCODES("MRSCODE")=$P(MRSC,U,2)
 I MRCC="U",(MRSC<0) Q ""
 I MRCC="P"!(MRCC="U") D
 .S NOTE=$$GNOTE()
 .S MCODES("NOTE")=NOTE
 Q:NOTE=U ""
 S CONT=$$CONFIRM("Would you like to send this Rx Change Request?")
 Q CONT
CRALLOW(ERXIEN) ;
 N ESTAT
 I $$GET1^DIQ(52.49,ERXIEN,.08,"I")'="N" Q 0
 S ESTAT=$$GET1^DIQ(52.49,ERXIEN,1,"E")
 I ESTAT="RJ"!(ESTAT="RM")!(ESTAT="CAN")!(ESTAT="CAC") Q 0
 I $$GET1^DIQ(52.49,ERXIEN,312.1,"I")'=1 Q 0
 Q 1
CHREQ(GL,ERXIEN,CNT,MEDREQ,MRC) ;
 N DIR,DIC,Y,X,DONE,NDC,NDCQ,SUBS,NOTE,REF,DAYS,QTY,CLQ,QUOM,SIG,SEQ,DNAME,QUOMINFO,CLQCODE,QTYDSRFL,MCNT,CLQARY
 N PSODRUG,NDC,DOSE,VERB,TSIG,UPD,QTYDSRFL,AGAIN,NOTEARY,RESP,PRCODE,PRCQUAL,CONTINUE,I,CRFOUND,MRCIEN,CL,ENDONE,NDCQUIT,NL,SL
 S CRFOUND=0
 S MRCIEN=$$PRESOLV^PSOERXA1(MRC,"MRC")
 ; TYPES P AND U are confirmed above.
 I MRC="P"!(MRC="U") Q 1
 S ERXIENS=ERXIEN_","
 D DERX1^PSOERXD2(ERXIEN,ERXIENS,1)
 S (ENDONE,DONE)=0,MCNT=1
 F I=1:1 D  Q:DONE!(MCNT>3)!(ENDONE)
 .S NDCQUIT=0 K ^TMP("PSOERXA6",$J)
 .; initialize variables to ensure they do not fall through to the next entry
 .S (NOTE,DNAME,NDC,NDCQ,SUBS,QTY,CLQ,CLQCODE,QUOM,QUOMINFO,DAYS,REF,MEDREQ)=""
 .K NOTEARY,CLARY
 .S NOTE=$$GNOTE() I NOTE=U S DONE=1 Q
 .S MEDREQ=$$SDRG(ERXIEN) I MEDREQ=U S DONE=1 Q
 .S DNAME=$P(MEDREQ,U,2)
 .I $P(MEDREQ,U)="E" S PRCODE=$P(MEDREQ,U,3),PRCQUAL=$P(MEDREQ,U,4)
 .S MEDREQ=$P(MEDREQ,U) I MEDREQ="" S DONE=1 Q
 .I MEDREQ'="E" D  Q:NDCQUIT
 ..;Reference to $$GETNDC^PSSNDCUT supported by IA 4707
 ..S NDC=$$GETNDC^PSSNDCUT(MEDREQ,$G(PSOSITE)),NDC=$TR(NDC,"-","")
 ..I NDC']"" S NDCQUIT=1 W !!,"Missing NDC. Please select a different drug.",! Q
 ..; VA eRx will always be using NDC for the code and ND for the product code qualifier, hence the hard-coded value
 ..S NDCQ="ND"
 .S SUBS=$$GSUBS() I SUBS=U S DONE=1 Q
 .S SUBS=$S(SUBS="Y":0,1:1)
 .D TXT2ARY^PSOERXD1(.NOTEARY,"Note: "_NOTE)
 .S QTY=$$GQTY() I QTY=U S DONE=1 Q
 .I QTY D
 ..S CLQ=$$GCLQ() I CLQ=U S DONE=1 Q
 ..S CLQCODE=$P(CLQ,U,2)_" - "_$$GET1^DIQ(52.45,$P(CLQ,U),.02,"E")
 ..D TXT2ARY^PSOERXD1(.CLQARY,"Code List Qualifier: "_CLQCODE)
 ..S QUOM=$$GQUOM() I QUOM=U S DONE=1 Q
 ..S QUOMINFO=$P(QUOM,U,2)_" - "_$$GET1^DIQ(52.45,$P(QUOM,U),.02,"E")
 .;/JSG/ PSO*7.0*581 - BEGIN CHANGE (INITIALIZE VARIABLES)
 .I 'QTY D
 ..S (CLQ,CLQCODE,QUOM,QUOMINFO)="" K CLQARY
 .;/JSG/ - END CHANGE
 .Q:DONE
 .S DAYS=$$GDAYS() I DAYS=U S DONE=1 Q
 .S REF=$$GREF() I REF=U S DONE=1 Q
 .D GSIG
 .W !!,"***************************  DETAILS ***************************"
 .W !,"Message Request Code: "_MRC_" - "_$$GET1^DIQ(52.45,MRCIEN,.02,"E")
 .W !,"Drug: "_DNAME
 .I MEDREQ'="E" W !,"NDC:  "_NDC
 .I MEDREQ="E" D
 ..W !,"Product Code: "_PRCODE
 ..W !,"Product Code Qualifier: "_PRCQUAL
 .W !,"Substitutions? "_$S(SUBS=0:"Yes",1:"No")
 .S NL=0 F  S NL=$O(NOTEARY(NL)) Q:'NL  D
 ..W !,NOTEARY(NL)
 .W !,"Refills: "_$G(REF),?25,"Days Supply: "_$G(DAYS),?55,"Quantity: "_$G(QTY)
 .;/JSG/ PSO*7.0*581 - BEGIN CHANGE (Allow for empty Code List Qualifier)
 .I $D(CLQARY)\10 D
 ..S CL=0 F  S CL=$O(CLQARY(CL)) Q:'CL  D
 ...W !,$G(CLQARY(CL))
 .I $D(CLQARY)<10 D
 ..W !,"Code List Qualifier:"
 .;/JSG/ - END CHANGE
 .W !,"Quantity Unit Of Measure: "_$G(QUOMINFO)
 .W !!,"Sig: "
 .S SL=0 F  S SL=$O(^TMP("PSOERXA6",$J,SL)) Q:'SL  D
 ..W !,^TMP("PSOERXA6",$J,SL,0)
 .W !!,"****************************************************************",!!
 .S RESP=$$CONFIRM("Would you like to use the requested medication?") I RESP=U S DONE=1 Q
 .Q:'RESP
 .I MEDREQ'="E" S MEDREQ(MCNT,"MEDICATION")=DNAME_U_NDC_U_NDCQ
 .I MEDREQ="E" S MEDREQ(MCNT,"MEDICATION")=DNAME_U_PRCODE_U_PRCQUAL
 .S MEDREQ(MCNT,"NOTE")=NOTE
 .S MEDREQ(MCNT,"OTHER")=REF_U_DAYS_U_QTY_U_$P($G(CLQ),U,2)_U_$P($G(QUOM),U,2)_U_SUBS
 .M MEDREQ(MCNT,"SIG")=^TMP("PSOERXA6",$J) K ^TMP("PSOERXA6",$J)
 .S MCNT=MCNT+1 Q:MCNT>3
 .S AGAIN=$$CONFIRM("Would you like to enter another requested medication?") I AGAIN=U!(AGAIN=0) S ENDONE=1 Q
 .W !!,"Now Entering a New Medication Requested:"
 I DONE=1 Q 0
 S CONTINUE=$$CONFIRM("Would you like to send this Rx Change Request?")
 I 'CONTINUE W !,"RxChangeRequest Cancelled." D DIRE^PSOERXX1 Q 0
 D MEDREQ(GL,.CNT,.MEDREQ)
 K ^TMP("PSOERXA6",$J)
 Q 1
MRC(ERXIEN) ;
 N DIR,DIC,Y,X,DONE,MRC,MRCO,ESUBS,MIEN
 S DIC("A")="Select RX change message request code: "
 S DIC="^PS(52.45,",DIC(0)="AEMQ"
 ; Surescripts 
 ; "G" (Generic Substitution), may be used to request a prescriber allow the dispensing of a generic
 ;  medication when substitution is not allowed by prescriber or regulations.
 ; substitutions = 0 - do not allow G
 ;               = 1 - allow G
 S MIEN=$O(^PS(52.49,ERXIEN,311,"C","P",0))
 S ESUBS=$$GET1^DIQ(52.49311,MIEN_","_ERXIEN_",",2.7,"I")
 I 'ESUBS S DIC("S")="I $D(^PS(52.45,""TYPE"",""MRC"",Y)),$P(^PS(52.45,Y,0),U)'=""G"""
 I ESUBS S DIC("S")="I $D(^PS(52.45,""TYPE"",""MRC"",Y))"
 D ^DIC K DIC
 I $D(DUOUT)!(Y<1) Q Y
 S MRC=Y,MRCO=$$GET1^DIQ(52.45,MRC,.01,"E"),DONE=1
 I $G(MRC) Q MRC_U_MRCO
 I $D(DUOUT) Q U
 Q Y
MRSC() ;
 N DIR,DIC,Y,X,DONE,MRC,MRCO
 S DIC("A")="Select RX change message request sub-code: "
 S DIC="^PS(52.45,",DIC(0)="AEMQ",DIC("S")="I $D(^PS(52.45,""TYPE"",""MRSC"",Y))"
 D ^DIC K DIC
 I $D(DUOUT)!(Y<1) Q Y
 S MRC=Y,MRCO=$$GET1^DIQ(52.45,MRC,.01,"E"),DONE=1
 I $G(MRC) Q MRC_U_MRCO
 I $D(DUOUT) Q U
 Q Y
SDRG(ERXIEN) ;
 N DIC,DIR,MPIEN,ERXDRUG,DPRCODE,DPRCQUAL,ERET,Y,DUOUT,MPIENS
 S MPIEN=$O(^PS(52.49,ERXIEN,311,"C","P",0)) Q:'MPIEN ""
 S MPIENS=MPIEN_","_ERXIEN_","
 I MPIEN S ERXDRUG=$$GET1^DIQ(52.49311,MPIENS,.03,"E")
 W !!,"eRx Drug: "_ERXDRUG
 S DIR(0)="S^E:Use eRx Drug;S:Select from drug file" D ^DIR
 I $D(DUOUT) Q U
 I Y="E" D  Q ERET
 .S DPRCODE=$$GET1^DIQ(52.49311,MPIENS,1.1,"E")
 .S DPRCQUAL=$$GET1^DIQ(52.49311,MPIENS,1.2,"E")
 .S ERET="E"_U_ERXDRUG_U_DPRCODE_U_DPRCQUAL
 S DIC(0)="AEMQ",DIC=50,DIC("S")="I $$ACTIVE^PSOERXA0(Y),($$OUTPAT^PSOERXA0(Y)),('$$INVCOMP^PSOERXA0(Y)),('$$CS^PSOERXA0(Y))"
 D ^DIC K DIC
 I $D(DUOUT) Q U
 Q Y
GSUBS() ;
 N DIR,Y
 S DIR(0)="S^Y:YES;N:NO",DIR("A")="Substitutions?"
 S DIR("B")="N"
 D ^DIR
 I $D(DUOUT) Q U
 Q Y
GNOTE() ;
 N DIR,Y
 S DIR(0)="FO^1:210",DIR("A")="Note"
 D ^DIR
 I $D(DUOUT) Q U
 Q Y
PATSTATS(ERXIEN) ;
 N PATIEN,Y,DIE,DR,DA,FDA,ANS,PATSTAT,DONE,PSODFN,STAT
 S PATIEN=$$GET1^DIQ(52.49,ERXIEN,.05,"I")
 I 'PATIEN W !!,"Patient has not been validated, cannot edit patient status",! Q ""
 S PSODFN=$$GET1^DIQ(52.49,ERXIEN,.05,"I")
 S PATSTAT=$$GET1^DIQ(55,ERXIEN,3,"E")
 S DIR("B")=PATSTAT
 S DONE=0
 F  D  Q:DONE
 .S DIR(0)="55,3",DIR("A")="PATIENT STATUS" D ^DIR K DIR
 .I Y="" W !,"This is a required response. Enter '^' to exit" Q
 .I +Y S DONE=1 Q
 .I Y["^" S DONE=1 Q
 S STAT=$P(Y,"^",1)
 Q STAT
GQTY() ; 
 N DIR,Y
 S DIR(0)="NO^1:99999",DIR("A")="Quantity"
 D ^DIR
 I $D(DUOUT) Q U
 Q Y
GDAYS() ;
 N DIR,Y
 S DIR(0)="NO^1:365",DIR("A")="Days Supply"
 D ^DIR
 I $D(DUOUT) Q U
 Q Y
GREF() ;
 N DIR,Y
 S DIR(0)="NO^1:99",DIR("A")="Refills"
 D ^DIR
 I $D(DUOUT) Q U
 Q Y
GCLQ() ;
GCLQA N DIR,DIC,Y,X,DONE,MRC,MRCO
 S DIC(0)="A"
 S DIC("A")="Quantity Code List Qualifier: "
 S DIC="^PS(52.45,",DIC(0)="AEMQ",DIC("S")="I $D(^PS(52.45,""TYPE"",""QCQ"",Y))"
 D ^DIC K DIC
 I $D(DUOUT) Q U
 I Y<0 W !,"Response is required. Enter a value or '^' to quit." G GCLQA
 S MRC=Y,MRCO=$$GET1^DIQ(52.45,MRC,.01,"E"),DONE=1
 I $G(MRC) Q MRC_U_MRCO
 Q Y
GQUOM() ;
GQUOMA N DIR,DIC,Y,X,DONE,MRC,MRCO
 S DIC(0)="A"
 S DIC("A")="Quantity Unit Of Measure: "
 S DIC="^PS(52.45,",DIC(0)="AEMQ",DIC("S")="I $$CODES^PSOERXON(Y)"
 D ^DIC K DIC
 I $D(DUOUT) Q U
 I Y<0 W !,"Response is required. Enter a value or '^' to quit." G GQUOMA
 S MRC=Y,MRCO=$$GET1^DIQ(52.45,MRC,.01,"E"),DONE=1
 I $G(MRC) Q MRC_U_MRCO
 Q Y
CODES(IEN) ;
 N DESC
 ; must be an NCI code
 I '$D(^PS(52.45,"TYPE","NCI",IEN)) Q 0
 ; codes Milliliter, Unspecified, and Gram are stored with a subtype of StrengthUnitOfMeasure, but need to be included.
 S DESC=$$GET1^DIQ(52.45,IEN,.02,"E"),DESC=$$UP^XLFSTR(DESC)
 I $D(^PS(52.45,"TYPE","NCI",IEN)),"UNSPECIFIED,GRAM"[DESC Q 1
 I $D(^PS(52.45,"TYPE","NCI",IEN)),DESC="MILLILITER" Q 1
 I '$D(^PS(52.45,"E","QuantityUnitOfMeasure",IEN)) Q 0
 Q 1
GSIG ;
 N DIC,DWLW,DWPK,DWDISABL,DIWESUB,TLEN,EDIT,X
 S EDIT=0
 S DIC="^TMP(""PSOERXA6"""_",$J,"
 S DWLW=80,DWPK=1,DWDISABL="P"
 S DIWESUB="Enter Sig Text"
 D EN^DIWE
 S X=0 F  S X=$O(^TMP("PSOERXA6",$J,X)) Q:'X  D
 .S TLEN=$G(TLEN)+$L(^TMP("PSOERXA6",$J,X,0))
 .I TLEN>1000 S EDIT=1
 I EDIT W !,"Sig must be 1000 characters or less.",! D DIRE^PSOERXX1 G GSIG
 Q
CONFIRM(TEXT) ;
 N DIR,Y
 S DIR(0)="Y"
 S DIR("A")=TEXT
 D ^DIR
 I $D(DUOUT) Q U
 Q Y
BL(GBL,CNT,TAG,VAR) ;
 Q:VAR=""
 D C S @GBL@(CNT,0)="<"_TAG_">"_$$SYMENC^MXMLUTL(VAR)_"</"_TAG_">"
 Q
 ;
C ;
 S CNT=$G(CNT)+1
 Q
