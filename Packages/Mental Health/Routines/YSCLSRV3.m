YSCLSRV3 ;DALOI/RLM,HEC/hrubovcak - Clozapine data server ;16 Oct 2019 19:31:54
 ;;5.01;MENTAL HEALTH;**74,90,92,154**;Dec 30, 1994;Build 48
 ; Reference to ^%ZOSF supported by IA #10096
 ; Reference to ^DPT supported by IA #10035
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to ^PSDRUG supported by IA #25
 ; Reference to ^PSRX supported by IA #780
 ; Reference to ^VA(200 supported by IA #10060
 ; Reference to ^XUSEC supported by IA #10076
 ;
 D DT^DICRW
 K ^TMP($J,"YSCLXMSG"),^TMP($J,"YSRXPTLST")  ; message text & patient list
 D ADD2TXT^YSCLSERV("This is a list of all active Clozapine prescriptions.")
 D ADD2TXT^YSCLSERV("An asterisk in the first column indicates that the prescription is over")
 D ADD2TXT^YSCLSERV("28 days old.  The second column is the Patient Name.  The third is the")
 D ADD2TXT^YSCLSERV("Issue Date.  The fourth column is the Prescription Number. The final")
 D ADD2TXT^YSCLSERV("column is the CLOZAPINE STATUS indicator.")
 ;
 N C,DFN,DRUGIEN,RXPTR,X,YSLN,YSPT,YSRX,YSV
 S YSV("t-28")=$$HTFM^XLFDT($H-28)  ; 28 days ago
 ; ^PS(55,D0,P,D1,0)= (#.01) PRESCRIPTION PROFILE [1P:52]
 ; loop through CLOZAPINE REGISTRATION NUMBER cross-ref
 S DFN=0 F  S DFN=$O(^PS(55,"ASAND",DFN)) Q:'DFN  I $D(^DPT(DFN,0)),$D(^PS(55,DFN,"SAND")) D
 . K YSPT S YSPT(55,"SAND")=$G(^PS(55,DFN,"SAND")) S YSPT(0)=$G(^DPT(DFN,0))
 . S RXPTR=0 F  S RXPTR=$O(^PS(55,DFN,"P",RXPTR)) Q:'RXPTR  K DRUGIEN,YSRX S YSRX=+$G(^PS(55,DFN,"P",RXPTR,0)) I YSRX>0,$D(^PSRX(YSRX,0)) D:'$$RXACTV(YSRX)
 ..  S YSRX(0)=$G(^PSRX(YSRX,0)),DRUGIEN=+$P(YSRX(0),U,6) Q:'($P($G(^PSDRUG(DRUGIEN,"CLOZ1")),U)="PSOCLO1")  ; (#17.5) MONITOR ROUTINE [1F]
 ..  Q:'$D(^PSDRUG(DRUGIEN,"CLOZ"))  ; (#17.2) LAB TEST MONITOR [1P:60]
 ..  S YSLN=$S(YSV("t-28")>$P(YSRX(0),U,13):"*",1:" ")_U_$P(^DPT($P(YSRX(0),U,2),0),U)_U_$$FMTE^XLFDT($P(YSRX(0),U,13))_U_$P(YSRX(0),U)_U_$P(YSPT(55,"SAND"),U,2)
 ..  S X=$P(YSPT(0),U)_U_DFN,C=$G(^TMP($J,"YSRXPTLST",X,0))+1,^TMP($J,"YSRXPTLST",X,0)=C,^TMP($J,"YSRXPTLST",X,C)=YSLN  ; sort by "patient name^DFN"
 ; add sorted patient list to the message
 S X="" F  S X=$O(^TMP($J,"YSRXPTLST",X)) Q:X=""  S C=0 F  S C=$O(^TMP($J,"YSRXPTLST",X,C)) Q:'C  D ADD2TXT^YSCLSERV(^TMP($J,"YSRXPTLST",X,C))
 K ^TMP($J,"YSRXPTLST")
 G EXIT^YSCLSERV
 ;
RXACTV(YSRXIEN) ; (#100) STATUS [1S], '0' FOR ACTIVE;
 N YSFMERR
 Q $$GET1^DIQ(52,YSRXIEN_",",100,"I","YSFMERR")
 ;
DEMOG ;
 S YSCLA=0 F  S YSCLA=$O(^YSCL(603.01,"C",YSCLA)) Q:'YSCLA  D
  . I $D(^PS(55,YSCLA,"SAND")),$P(^PS(55,YSCLA,"SAND"),"^",4)=0 S YSCLC=$G(YSCLC)+1
  . I $D(^PS(55,YSCLA,"SAND")),$P(^PS(55,YSCLA,"SAND"),"^",4) S $P(^PS(55,YSCLA,"SAND"),"^",4)=0,YSCLB=$G(YSCLB)+1
 D ADD2TXT^YSCLSERV(+$G(YSCLB)_" record"_$S(+$G(YSCLB)=1:"",1:"s")_" reset at ("_YSCLST_") "_YSCLSTN)
 D ADD2TXT^YSCLSERV(+$G(YSCLC)_" record"_$S(+$G(YSCLC)=1:"",1:"s")_" not reset at ("_YSCLST_") "_YSCLSTN)
 G EXIT^YSCLSERV
 Q
LOCK ;Lock out ability to dispense Clozapine
 X XMREC Q:XMER<0  S X=XMRG
 I X="LOCK DOWN ON" S $P(^YSCL(603.03,1,1),"^",1)=1 D ADD2TXT^YSCLSERV("Clozapine dispensing prohibited at "_YSCLST)
 I X="LOCK DOWN OFF" S $P(^YSCL(603.03,1,1),"^",1)=0 D ADD2TXT^YSCLSERV("Clozapine dispensing enabled at "_YSCLST)
 G EXIT^YSCLSERV
 Q
AUTH ;List authorized Clozapine providers
 I YSCLSUB["LIST" D  G EXIT^YSCLSERV
  . D ADD2TXT^YSCLSERV("The following providers are authorized to override Clozapine lockouts (PSOLOCKCLOZ)")
  . S YSCLLN=2
  . S YSCLA="" F  S YSCLA=$O(^XUSEC("PSOLOCKCLOZ",YSCLA)) Q:YSCLA=""  D
  . . Q:'$D(^VA(200,YSCLA,0))
  . . D ADD2TXT^YSCLSERV($P(^VA(200,YSCLA,0),"^",1)_"  "_$S($P(^VA(200,YSCLA,0),"^",7)=1:"Ina",1:"A")_"ctive")
  . D ADD2TXT^YSCLSERV(" "),ADD2TXT^YSCLSERV(" "),ADD2TXT^YSCLSERV(" ")  ; 3 blank lines
  . D ADD2TXT^YSCLSERV("The following providers are authorized to access the Pharmacy Clozapine Manager Menu (PSZ CLOZAPINE)")
  . S YSCLA="" F  S YSCLA=$O(^XUSEC("PSZ CLOZAPINE",YSCLA)) Q:YSCLA=""  D
  . . Q:'$D(^VA(200,YSCLA,0))
  . . D ADD2TXT^YSCLSERV($P(^VA(200,YSCLA,0),"^",1)_"  "_$S($P(^VA(200,YSCLA,0),"^",7)=1:"Ina",1:"A")_"ctive")
  . D ADD2TXT^YSCLSERV(" "),ADD2TXT^YSCLSERV(" "),ADD2TXT^YSCLSERV(" ")  ; 3 blank lines
  . D ADD2TXT^YSCLSERV("The following providers are authorized to prescribe Clozapine (YSCL AUTHORIZED)")
  . S YSCLA=0 F  S YSCLA=$O(^XUSEC("YSCL AUTHORIZED",YSCLA)) Q:'YSCLA  D  ;??? Use FileMan lookup on 200
  . . S YSCLDEA=$$DEA^XUSER(1,YSCLA),YSCLYN=1,YSPT("ssn")=$P(^VA(200,YSCLA,1),"^",9)
  . . D ADD2TXT^YSCLSERV($P($G(^VA(200,YSCLA,0)),"^",1)_" - "_YSPT("ssn")_" - "_$S(YSCLDEA="":"*NONE*",1:YSCLDEA)_" - "_$S(YSCLYN=1:"Yes",1:"NO"))
 ;Holders of YSCL AUTHORIZED key
 ;
 ;
 D ADD2TXT^YSCLSERV("Clinician Authorization Results at "_YSCLST)
 K ^TMP("DIERR",$J)
 F  X XMREC Q:XMER<0  S X=XMRG X ^%ZOSF("UPPERCASE") S X=Y D
  . S YSPT("ssn")=$P(X,"^",1),YSCLDEA=$P(X,"^",2),YSCLYN=$P(X,"^",3),YSCLDUZ="",YSCLDEA1="",YSCLIEN=""
  . I YSCLLN=""!("YESNO"'[YSCLYN) D ADD2TXT^YSCLSERV("Clinician Authorization instructions invalid ("_YSCLYN_") at "_YSCLST)
  . S YSCLYN=$S(YSCLYN="YES":1,1:0)
  . I '$D(^VA(200,"BS5",YSPT("ssn"))) D ADD2TXT^YSCLSERV("Clinician ("_YSPT("ssn")_") does not exist at "_YSCLST) Q
  . I $D(^VA(200,"BS5",YSPT("ssn"))) S YSCLAA="" F  S YSCLAA=$O(^VA(200,"BS5",YSPT("ssn"),YSCLAA)) Q:YSCLAA=""  I $$DEA^XUSER(1,YSCLAA)=YSCLDEA S YSCLDUZ=YSCLAA Q
  . I YSCLDUZ="" D ADD2TXT^YSCLSERV("Clinician ("_YSPT("ssn")_") with DEA# "_YSCLDEA_" does not exist at "_YSCLST) Q
  . S YSCLDEA1=$$DEA^XUSER(1,YSCLDUZ)
  . I YSCLDEA1="" D ADD2TXT^YSCLSERV("Clinician with DEA# "_YSCLDEA_" does not exist at "_YSCLST) Q
  . I YSCLDEA'=YSCLDEA1 D ADD2TXT^YSCLSERV("Clinician SSN ("_YSPT("ssn")_") - DEA ("_YSCLDEA_") mismatch at "_YSCLST) Q
  . D OWNSKEY^XUSRB(.RET,"YSCL AUTHORIZED",YSCLDUZ)
  . I RET(0),YSCLYN D ADD2TXT^YSCLSERV("Clinician ("_YSPT("ssn")_") already authorized at "_YSCLST) Q
  . I 'RET(0),'YSCLYN D ADD2TXT^YSCLSERV("Clinician ("_YSPT("ssn")_") not authorized at "_YSCLST) Q
  . I 'RET(0),YSCLYN S YSCLDUZ(0)=DUZ,DUZ(0)="@" D  S DUZ(0)=YSCLDUZ(0)
  . . S YSCLFDA(200,"?1,",.01)="`"_YSCLDUZ
  . . S YSCLFDA(200.051,"+2,?1,",.01)="YSCL AUTHORIZED" D UPDATE^DIE("E","YSCLFDA",,"YSCLERR")
  . . I $D(YSCLERR) D ADD2TXT^YSCLSERV("Clinician SSN "_YSPT("ssn")_" authorization failed at "_YSCLST) Q
  . . I '$D(YSCLERR) D ADD2TXT^YSCLSERV("Clinician SSN "_YSPT("ssn")_" authorization set to "_$S(YSCLYN=1:"Yes",1:"No")_" at "_YSCLST) Q
  . I RET(0),'YSCLYN S YSCLDUZ(0)=DUZ,DUZ(0)="@" D  S DUZ(0)=YSCLDUZ(0)
  . . S DA=$$FIND1^DIC(200.051,","_YSCLDUZ_",","A","YSCL AUTHORIZE")
  . . I DA<1 D ADD2TXT^YSCLSERV("Clinician SSN "_YSPT("ssn")_" authorization removal failed at "_YSCLST) Q
  . . S DA(1)=YSCLDUZ,DIK="^VA(200,"_DA(1)_",51," D ^DIK
  . . D ADD2TXT^YSCLSERV("Clinician SSN "_YSPT("ssn")_" authorization removed at "_YSCLST) Q
 G EXIT^YSCLSERV
 Q
 ;
LKUP ; lookup patients in file #603.01
 K ^TMP($J,"YSCLXMSG")  ; message text
 N X,YSFMERR,YSFMRSLT,YSPT,YSXMINST,YSXMY,YSXMZ
 S X=$$SITE^VASITE
 D ADD2TXT^YSCLSERV("Site "_$P(X,U,2)_" ("_$P(X,U,3)_") inquiry to file #603.01"),ADD2TXT^YSCLSERV(" ")
 F  X XMREC Q:XMER<0  D:XMRG]""  ; process list of SSNs
 . K YSFMERR,YSPT,YSFMRSLT
 . S YSPT("ssn")=$TR(XMRG," -","")  ; strip spaces and hyphens
 . I '(YSPT("ssn")?9N) D ADD2TXT^YSCLSERV("Error: "_XMRG_" is not a valid SSN."),ADD2TXT^YSCLSERV(" ") Q
 . D LIST^DIC(2,,".01;.09",,,,YSPT("ssn"),"SSN",,,"YSFMRSLT","YSFMERR")
 . S YSPT("name")=$G(YSFMRSLT("DILIST","ID",1,.01))
 . I '$L(YSPT("name")) D  Q
 ..  D ADD2TXT^YSCLSERV("Error: SSN "_YSPT("ssn")_" not found in the PATIENT file (#2)"),ADD2TXT^YSCLSERV(" ")
 . K YSFMERR,YSFMRSLT
 . D LIST^DIC(603.01,,".01E;1E;2E;3E",,,,YSPT("name"),"C",,,"YSFMRSLT","YSFMERR")
 . I '$G(YSFMRSLT("DILIST",2,1)) D  Q
 ..  D ADD2TXT^YSCLSERV("SSN "_YSPT("ssn")_" not found in file #603.01"),ADD2TXT^YSCLSERV(" ")
 . ; put each entry in the message
 . N FLD,YSIEN
 . S YSIEN=0 F  S YSIEN=$O(YSFMRSLT("DILIST","ID",YSIEN)) Q:'YSIEN  D
 ..  D ADD2TXT^YSCLSERV("IEN in file #603.01: "_YSFMRSLT("DILIST",2,YSIEN)_" for SSN "_YSPT("ssn"))
 ..  ; send only fields with data
 ..  S FLD=0 F  S FLD=$O(YSFMRSLT("DILIST","ID",YSIEN,FLD)) Q:'FLD  D:$L(YSFMRSLT("DILIST","ID",YSIEN,FLD))
 ...   N YSERR,YSLBL
 ...   D FIELD^DID(603.01,FLD,"N","LABEL","YSLBL","YSERR") Q:'$L($G(YSLBL("LABEL")))
 ...   D ADD2TXT^YSCLSERV(YSLBL("LABEL")_": "_YSFMRSLT("DILIST","ID",YSIEN,FLD))
 ..  ; blank line after each entry
 ..  D ADD2TXT^YSCLSERV(" ")
 ; done with lookups
 D ADD2TXT^YSCLSERV($J("* END OF REPORT *",35))
 S X=$$GET1^DIQ(603.03,1,3,"I")  ; debug?
 S YSXMSUB=$S(X:"DEBUG ",1:"")_"NCCC PATIENT LOOKUP "_$$FMTE^XLFDT($$NOW^XLFDT)
 S X=$$GET1^DIQ(8989.3,1,501,"I")  ; production?
 S:X YSXMY("G.CLOZAPINE ROLL-UP@DOMAIN.EXT")=""
 S:'X YSXMY("G.CLOZAPINE ROLL-UP")=""
 S YSXMINST("FROM")="CLOZAPINE SERVER"
 ; Mail the report
 D SENDMSG^XMXAPI(DUZ,YSXMSUB,$NA(^TMP($J,"YSCLXMSG")),.YSXMY,.YSXMINST,.YSXMZ)
 Q
 ;
