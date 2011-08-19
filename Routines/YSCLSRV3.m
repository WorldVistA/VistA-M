YSCLSRV3 ;DALOI/RLM-Clozapine data server ;24 APR 1990
 ;;5.01;MENTAL HEALTH;**74,90,92**;Dec 30, 1994;Build 7
 ; Reference to ^%ZOSF supported by IA #10096
 ; Reference to ^DPT supported by IA #10035
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to ^PSDRUG supported by IA #25
 ; Reference to ^PSRX supported by IA #780
 ; Reference to ^VA(200 supported by IA #10060
 ; Reference to ^XUSEC supported by IA #10076
 ;
 S ^TMP($J,"YSCLDATA",1)="This routine will print a list of all active Clozapine prescriptions."
 S ^TMP($J,"YSCLDATA",2)="An asterisk in the first column indicates that the prescription is over"
 S ^TMP($J,"YSCLDATA",3)="28 days old.  The second column is the Patient Name.  The third is the"
 S ^TMP($J,"YSCLDATA",4)="Issue Date.  The fourth column is the Prescription Number. The final"
 S ^TMP($J,"YSCLDATA",5)="column is the CLOZAPINE STATUS indicator."
 S X1=DT,X2=-28 D C^%DTC S YSCL28=X
 S DFN=0,YSCLLN=6
 F  K YSCLA S DFN=$O(^PS(55,"ASAND",DFN)),YSCLLD=0 Q:'DFN  I $D(^DPT(DFN,0)),$D(^PS(55,DFN,"SAND")) S YSCLSAND=^("SAND"),YSCL=^DPT(DFN,0),YSCLX=$E($P($P(YSCL,"^"),",",2))_$E(YSCL)_"^"_$P(YSCL,"^",9) D
  . F YSCL=0:0 S YSCL=$O(^PS(55,DFN,"P",YSCL)) Q:'YSCL  I $D(^(YSCL,0)) S YSCL1=^(0) I $D(^PSRX(YSCL1,0)) D ACTIVE I 'YSACT S YSCLRX=^PSRX(YSCL1,0) I $P($G(^PSDRUG(+$P(YSCLRX,"^",6),"CLOZ1")),"^")="PSOCLO1",$D(^("CLOZ")) S YSCLLAB=^("CLOZ") D
  . . ;W !,DFN," - ",YSCL1
  . . S ^TMP($J,"YSCLDATA",YSCLLN)=$S(YSCL28>$P(YSCLRX,"^",13):"*",1:" ")_"^"_$P(^DPT($P(YSCLRX,"^",2),0),"^")_"^"_$$FMTE^XLFDT($P(YSCLRX,"^",13))_"^"_$P(YSCLRX,"^")_"^"_$P(YSCLSAND,"^",2)
  . . S YSCLLN=YSCLLN+1
 G EXIT^YSCLSERV
 Q
ACTIVE ;
 S YSACT=$$GET1^DIQ(52,YSCL1_",",100,"I","ERR")
 Q
DEMOG ;
 S YSCLA=0 F  S YSCLA=$O(^YSCL(603.01,"C",YSCLA)) Q:'YSCLA  D
  . I $D(^PS(55,YSCLA,"SAND")),$P(^PS(55,YSCLA,"SAND"),"^",4)=0 S YSCLC=$G(YSCLC)+1
  . I $D(^PS(55,YSCLA,"SAND")),$P(^PS(55,YSCLA,"SAND"),"^",4) S $P(^PS(55,YSCLA,"SAND"),"^",4)=0,YSCLB=$G(YSCLB)+1
 S ^TMP($J,"YSCLDATA",2)=+$G(YSCLB)_" record"_$S(+$G(YSCLB)=1:"",1:"s")_" reset at ("_YSCLST_") "_YSCLSTN
 S ^TMP($J,"YSCLDATA",3)=+$G(YSCLC)_" record"_$S(+$G(YSCLC)=1:"",1:"s")_" not reset at ("_YSCLST_") "_YSCLSTN
 G EXIT^YSCLSERV
 Q
LOCK ;Lock out ability to dispense Clozapine
 X XMREC Q:XMER<0  S X=XMRG
 I X="LOCK DOWN ON" S $P(^YSCL(603.03,1,1),"^",1)=1 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="Clozapine dispensing prohibited at "_YSCLST
 I X="LOCK DOWN OFF" S $P(^YSCL(603.03,1,1),"^",1)=0 S YSCLLNT=$G(YSCLLNT)+1,^TMP($J,"YSCLDATA",YSCLLNT)="Clozapine dispensing enabled at "_YSCLST
 G EXIT^YSCLSERV
 Q
AUTH ;List authorized Clozapine providers
 I YSCLSUB["LIST" D  G EXIT^YSCLSERV
  . S ^TMP($J,"YSCLDATA",1)="The following providers are authorized to override Clozapine lockouts (PSOLOCKCLOZ)"
  . S YSCLLN=2
  . S YSCLA="" F  S YSCLA=$O(^XUSEC("PSOLOCKCLOZ",YSCLA)) Q:YSCLA=""  D
  . . Q:'$D(^VA(200,YSCLA,0))
  . . S ^TMP($J,"YSCLDATA",YSCLLN)=$P(^VA(200,YSCLA,0),"^",1)_"  "_$S($P(^VA(200,YSCLA,0),"^",7)=1:"Ina",1:"A")_"ctive",YSCLLN=YSCLLN+1
  . S ^TMP($J,"YSCLDATA",YSCLLN)="",YSCLLN=YSCLLN+1
  . S ^TMP($J,"YSCLDATA",YSCLLN)="",YSCLLN=YSCLLN+1
  . S ^TMP($J,"YSCLDATA",YSCLLN)="",YSCLLN=YSCLLN+1
  . S ^TMP($J,"YSCLDATA",YSCLLN)="The following providers are authorized to access the Pharmacy Clozapine Manager Menu (PSZ CLOZAPINE)",YSCLLN=YSCLLN+1
  . S YSCLA="" F  S YSCLA=$O(^XUSEC("PSZ CLOZAPINE",YSCLA)) Q:YSCLA=""  D
  . . Q:'$D(^VA(200,YSCLA,0))
  . . S ^TMP($J,"YSCLDATA",YSCLLN)=$P(^VA(200,YSCLA,0),"^",1)_"  "_$S($P(^VA(200,YSCLA,0),"^",7)=1:"Ina",1:"A")_"ctive",YSCLLN=YSCLLN+1
  . S ^TMP($J,"YSCLDATA",YSCLLN)="",YSCLLN=YSCLLN+1
  . S ^TMP($J,"YSCLDATA",YSCLLN)="",YSCLLN=YSCLLN+1
  . S ^TMP($J,"YSCLDATA",YSCLLN)="",YSCLLN=YSCLLN+1
  . S ^TMP($J,"YSCLDATA",YSCLLN)="The following providers are authorized to prescribe Clozapine (YSCL AUTHORIZED)",YSCLLN=YSCLLN+1
  . S YSCLA=0 F  S YSCLA=$O(^XUSEC("YSCL AUTHORIZED",YSCLA)) Q:'YSCLA  D  ;??? Use FileMan lookup on 200
  . . S YSCLDEA=$$DEA^XUSER(1,YSCLA),YSCLYN=1,YSCLSSN=$P(^VA(200,YSCLA,1),"^",9)
  . . S ^TMP($J,"YSCLDATA",YSCLLN)=$P($G(^VA(200,YSCLA,0)),"^",1)_" - "_YSCLSSN_" - "_$S(YSCLDEA="":"*NONE*",1:YSCLDEA)_" - "_$S(YSCLYN=1:"Yes",1:"NO"),YSCLLN=YSCLLN+1
 ;Holders of YSCL AUTHORIZED key
 ;=============================================
 ;
 S YSCLLN=1,^TMP($J,"YSCLDATA",YSCLLN)="Clinician Authorization Results at "_YSCLST,YSCLLN=YSCLLN+1
 K ^TMP("DIERR",$J)
 F  X XMREC Q:XMER<0  S X=XMRG X ^%ZOSF("UPPERCASE") S X=Y D
  . S YSCLSSN=$P(X,"^",1),YSCLDEA=$P(X,"^",2),YSCLYN=$P(X,"^",3),YSCLDUZ="",YSCLDEA1="",YSCLIEN=""
  . I YSCLLN=""!("YESNO"'[YSCLYN) S ^TMP($J,"YSCLDATA",YSCLLN)="Clinician Authorization instructions invalid ("_YSCLYN_") at "_YSCLST,YSCLLN=YSCLLN+1
  . S YSCLYN=$S(YSCLYN="YES":1,1:0)
  . I '$D(^VA(200,"BS5",YSCLSSN)) S ^TMP($J,"YSCLDATA",YSCLLN)="Clinician ("_YSCLSSN_") does not exist at "_YSCLST,YSCLLN=YSCLLN+1 Q
  . I $D(^VA(200,"BS5",YSCLSSN)) S YSCLAA="" F  S YSCLAA=$O(^VA(200,"BS5",YSCLSSN,YSCLAA)) Q:YSCLAA=""  I $$DEA^XUSER(1,YSCLAA)=YSCLDEA S YSCLDUZ=YSCLAA Q
  . I YSCLDUZ="" S ^TMP($J,"YSCLDATA",YSCLLN)="Clinician ("_YSCLSSN_") with DEA# "_YSCLDEA_" does not exist at "_YSCLST,YSCLLN=YSCLLN+1 Q
  . S YSCLDEA1=$$DEA^XUSER(1,YSCLDUZ)
  . I YSCLDEA1="" S ^TMP($J,"YSCLDATA",YSCLLN)="Clinician with DEA# "_YSCLDEA_" does not exist at "_YSCLST,YSCLLN=YSCLLN+1 Q
  . I YSCLDEA'=YSCLDEA1 W ^TMP($J,"YSCLDATA",YSCLLN)="Clinician SSN ("_YSCLSSN_") - DEA ("_YSCLDEA_") mismatch at "_YSCLST,YSCLLN=YSCLLN+1 Q
  . D OWNSKEY^XUSRB(.RET,"YSCL AUTHORIZED",YSCLDUZ)
  . I RET(0),YSCLYN S ^TMP($J,"YSCLDATA",YSCLLN)="Clinician ("_YSCLSSN_") already authorized at "_YSCLST,YSCLLN=YSCLLN+1 Q
  . I 'RET(0),'YSCLYN S ^TMP($J,"YSCLDATA",YSCLLN)="Clinician ("_YSCLSSN_") not authorized at "_YSCLST,YSCLLN=YSCLLN+1 Q
  . I 'RET(0),YSCLYN S YSCLDUZ(0)=DUZ,DUZ(0)="@" D  S DUZ(0)=YSCLDUZ(0)
  . . S YSCLFDA(200,"?1,",.01)="`"_YSCLDUZ
  . . S YSCLFDA(200.051,"+2,?1,",.01)="YSCL AUTHORIZED" D UPDATE^DIE("E","YSCLFDA",,"YSCLERR")
  . . I $D(YSCLERR) S ^TMP($J,"YSCLDATA",YSCLLN)="Clinician SSN "_YSCLSSN_" authorization failed at "_YSCLST,YSCLLN=YSCLLN+1 Q
  . . I '$D(YSCLERR) S ^TMP($J,"YSCLDATA",YSCLLN)="Clinician SSN "_YSCLSSN_" authorization set to "_$S(YSCLYN=1:"Yes",1:"No")_" at "_YSCLST,YSCLLN=YSCLLN+1 Q
  . I RET(0),'YSCLYN S YSCLDUZ(0)=DUZ,DUZ(0)="@" D  S DUZ(0)=YSCLDUZ(0)
  . . S DA=$$FIND1^DIC(200.051,","_YSCLDUZ_",","A","YSCL AUTHORIZE")
  . . I DA<1 S ^TMP($J,"YSCLDATA",YSCLLN)="Clinician SSN "_YSCLSSN_" authorization removal failed at "_YSCLST,YSCLLN=YSCLLN+1 Q
  . . S DA(1)=YSCLDUZ,DIK="^VA(200,"_DA(1)_",51," D ^DIK
  . . S ^TMP($J,"YSCLDATA",YSCLLN)="Clinician SSN "_YSCLSSN_" authorization removed at "_YSCLST,YSCLLN=YSCLLN+1 Q
 G EXIT^YSCLSERV
 Q
ZEOR ;YSCLSRV3
