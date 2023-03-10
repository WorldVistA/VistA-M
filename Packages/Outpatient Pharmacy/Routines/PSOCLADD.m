PSOCLADD ;BHAM ISC/DMA - Clozapine Registration Pharmacy Auto Update ;18 May 2020 12:29:40
 ;;7.0;OUTPATIENT PHARMACY;**612,613**;DEC 1997;Build 10
 ;
 ; External reference ^YSCL(603.01 supported by DBIA 2697
 ; External reference ^PS(55 supported by DBIA 2228
 ; External reference ^XUSEC( is supported by DBIA 10076
 ;
 ;
TRGR(DFN,PSOCLZNW) ; Register/Re-Register Clozapine Patient
 Q:'$G(PSOCLZNW)?2U.N
 Q:'$G(DFN)
 Q:'$D(^DPT(DFN,0))
 ;
 N %,%Y,C,D,D0,DA,DI,DQ,DIC,DIE,DR,PSO,PSO1,PSO2,PSO3,PSO4,PSOC,PSOLN,PSONAME,PSONO,PSOT,R,SSNVAERR,XMDUZ,XMSUB,XMTEXT,Y
 ;
 N DIC,DIR,PSOCZPTS,PSONAME,PSOTHZP,PSOTHZPF,PSOZST,PSOERR,PSOSSN
 K ^TMP($J,"PSOCLMSG")
 S PSO1=+DFN,PSONAME=$$GET1^DIQ(2,PSO1,.01),PSOSSN=$$GET1^DIQ(2,PSO1,.09)
 N PSOEX S PSOEX=$$FIND1^DIC(55,,"X",PSOCLZNW,"ASAND1")      ; Is Clozapine number Registered in 55 to a different patient?
 I $G(PSOEX) I PSOEX'=DFN D  Q  ; The NCCC # is already registered to different patient - should never happen but...
 .D ADD2TXT("NCCC # "_PSOCLZNW_" is already registered to "_$$GET1^DIQ(2,PSOEX,.01)_"("_$$GET1^DIQ(2,PSOEX,.09)_")")
 .D ADD2TXT("NCCC # "_PSOCLZNW_" not registered to "_PSONAME_"("_PSOSSN_")")
 .D SEND
 D FIND^DIC(603.01,"","","QX",DFN,"","C","I $P($G(^(0)),""^"")=$G(PSOCLZNW)","","PSOCZPTS","PSOERR")
 I '$D(PSOCZPTS("DILIST",1,1)) D  Q  ; The Clozapine Number is not in 603.01 for this patient, don't update 55
 .N PSONFILE S PSONFILE=$$FIND1^DIC(603.01,,"X",PSOCLZNW,"B") ; The Clozapine number is on file in 603.01 for a different patient
 .I $G(PSONFILE) S PSOTHZP=$$GET1^DIQ(603.01,+$G(PSONFILE),1,"I") I PSOTHZP,(PSOTHZP'=DFN) S PSOTHZPF=1 D  ; The Clozapine Number is assigned by NCCC to a patient
 ..D ADD2TXT(PSOCLZNW_" is assigned to "_$S($G(PSOTHZP):$$GET1^DIQ(2,PSOTHZP,.01)_" ("_$$GET1^DIQ(2,PSOTHZP,.09)_")",1:" a patient other than "_PSONAME_" ("_PSOSSN_")"))
 .I 'PSONFILE D ADD2TXT("The NCCC in Dallas has not authorized "_PSOCLZNW_" for use at this facility.")
 .D ADD2TXT("Clozapine Number "_PSOCLZNW_" not registered to patient "_PSONAME)
 .D SEND
 ; Now we know the Clozapine Number PSOCLZNW is in 603.01 for patient DFN
SAVE ; Save new NCCC number and Active status to File 55
 ; If patient has never been added to Pharmacy Patient file, add them now
 N PSOERMSG
 I '$D(^PS(55,DFN,0)) D
 .N DFNIEN S DFNIEN(1)=DFN
 .N PSOFDA S PSOFDA(55,"+1,",.01)=DFN D UPDATE^DIE("","PSOFDA","DFNIEN","PSOERMSG")
 I $D(PSOERMSG)>1 D  Q
 .S PSOERR=$G(PSOERR)+1
 N PSOFDA
 S PSOFDA(55,DFN_",",53)=PSOCLZNW
 S PSOFDA(55,DFN_",",54)="A"
 S PSOFDA(55,DFN_",",58)=$$DT^XLFDT ; $$NOW^XLFDT - PSO*7*613
 D FILE^DIE("","PSOFDA","PSOERMSG")
 I $D(PSOERMSG)=10!($D(PSOERMSG)=11) D ADD2TXT(PSOCLZNW_" could not be registered to patient "_PSONAME_" ("_PSOSSN_")") D
 .N TXTLN S TXTLN=0 F  S TXTLN=$O(PSOERMSG("DIERR",1,"TEXT",TXTLN)) Q:'TXTLN  D ADD2TXT(PSOERMSG("DIERR",1,"TEXT",TXTLN))
 I $D(PSOERMSG)<10 D ADD2TXT(PSOCLZNW_" successfully registered to patient "_PSONAME_" ("_PSOSSN_")") D
 .K ^XTMP("PSJ4D-"_DFN) K ^XTMP("PSO4D-"_DFN)  ; New NCCC Clozapine Authorization makes previous local overrides obsolete
 D SEND
 Q
 ;
ADD2TXT(L) ; add line L to the Message text
 Q:'$D(L)  I L="" S L=" "
 N C S C=$G(^TMP($J,"PSOCLMSG",0))+1,^(0)=C,^TMP($J,"PSOCLMSG",C,0)=L
 Q
 ;
SEND ; Send Message to PSOCLZAU mail group
 N %,%DT,%H,D,DA,DD,DIC,DIE,DIK,RET,X,XMDUN,XMDUZ,XMER,XMFROM
 N XMREC,XMRG,XMSUB,XMTEXT,XMY,XMZ,XQDATE,XQSUB
 ;
 S XMDUN="NCCC LOGGER",XMDUZ=".5",XMSUB=$P($$SITE^VASITE,U,3)_" NCCC ENROLLER ("_$$NOW^XLFDT_")"
 K XMY N YSPROD,YSXMZ
 ;S PSOYSPRD=$$GET1^DIQ(8989.3,1,501,"I")
 S XMY("G.PSOCLOZ")=""
 ;
 ; add mail group info to message text
 D ADD2TXT(" ")
 N G S G="G." F  S G=$O(XMY(G)) Q:G=""  D ADD2TXT(" Sent to: "_G)
 D ADD2TXT(" "),ADD2TXT($J("*** END OF REPORT ***",45))
 ; Mail the errors and successes to the local Clozapine Pharmacy Registration Mail Group
 D SENDMSG^XMXAPI(DUZ,XMSUB,$NA(^TMP($J,"PSOCLMSG")),.XMY,"",.YSXMZ)
 K ^TMP($J,"PSOCLMSG")
 Q
 ; PSO*7*613 - Called from AC Cross Reference of file 52.52
OVR5252(B5252,RXIEN) ; File fields into CLOZAPINE PRESCRIPTION OVERRIDES file (#52.52)
 ; Input:  B5252 = IEN of current entry from CLOZAPINE PRESCRIPTION OVERRIDES (#52.52)
 ;         RXIEN = IEN from PRESCRIPTION file #52 associated with current entry from CLOZAPINE PRESCRIPTRION OVERRIDES (#52.52)
 ; Output: OVERRIDE PROVIDER Field (#8) in CLOZAPINE PRESCRIPTION OVERRIDES (#52.52)
 ;         ORDER Field (#9) CLOZAPINE PRESCRIPTION OVERRIDES (#52.52)
 N PSI5252,PSFDA,X,Y,DIC,DIR,PSOVRTM
 N PSORX,PSERR,PSOPR,PSOPRCHK,PSORN,PSORNCHK
 Q:'$G(RXIEN)  Q:'$G(^PSRX(RXIEN,0))
 S PSI5252=$O(^PS(52.52,"B",$G(B5252),0))  ; $$FIND1^DIC(52.52,,"BOX",B5252,"B")
 Q:'PSI5252  Q:$P($G(^PS(52.52,PSI5252,0)),"^",2)'=RXIEN   ; Only updating existing records
 S PSOPR="",PSORN=""
 D FIND^DIC(52,,"@;1I;4I;39.3I","Q","`"_RXIEN,,"B",,,"PSORX","PSERR")
 S PSOPRCHK=$$GET1^DIQ(200,$G(PSORX("DILIST","ID",1,4)),.01)
 I $L(PSOPRCHK)>2 S PSOPR=$G(PSORX("DILIST","ID",1,4))
 S PSORNCHK=$$GET1^DIQ(100,$G(PSORX("DILIST","ID",1,39.3)),33,"I")
 I PSORNCHK>0 S PSORN=PSORX("DILIST","ID",1,39.3)
 D OVERONE(PSI5252,RXIEN,PSOPR,PSORN,.PSOVRTM)
 Q:'$G(PSOVRTM)&'$G(PSOPR)&'$G(PSORN)  ; Nothing to file
 I $G(PSOVRTM) S PSFDA(52.52,PSI5252_",",7)=PSOVRTM
 I $G(PSOPR) S PSFDA(52.52,PSI5252_",",8)=PSOPR
 I $G(PSORN) S PSFDA(52.52,PSI5252_",",9)=PSORN
 D FILE^DIE(,"PSFDA") K PSFDA
 Q
 ;
OVERONE(PSI5252,RXIEN,PSOPR,PSORN,PSOVRTM) ; Update previously filed override entry for the same RX
 N PS1IEN52,PS1RXIEN,PSFDA
 S PS1IEN52=$O(^PS(52.52,"A",RXIEN,PSI5252),-1)
 S PS1RXIEN=$$GET1^DIQ(52.52,PS1IEN52,1,"I")
 Q:'$G(PS1RXIEN)  Q:'$G(^PSRX(PS1RXIEN,0))
 Q:PS1RXIEN'=RXIEN  ; Quit if not associated with same prescription RXIEN
 Q:'$G(PSOPR)&'$G(PSORN)  ; Nothing to file
 I $G(PSOPR) S PSFDA(52.52,PS1IEN52_",",8)=PSOPR
 I $G(PSORN) S PSFDA(52.52,PS1IEN52_",",9)=PSORN
 D FILE^DIE(,"PSFDA")
 ; Get Override Team Member from first entry for this Rx
 S PSOVRTM=$$GET1^DIQ(52.52,PS1IEN52,7,"I")
 Q
