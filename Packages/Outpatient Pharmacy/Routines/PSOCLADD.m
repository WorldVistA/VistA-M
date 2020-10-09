PSOCLADD ;BHAM ISC/DMA - Clozapine Registration Pharmacy Auto Update ;18 May 2020 12:29:40
 ;;7.0;OUTPATIENT PHARMACY;**612**;DEC 1997;Build 23
 ;External reference ^YSCL(603.01 supported by DBIA 2697
 ;External reference ^PS(55 supported by DBIA 2228
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
 S PSOFDA(55,DFN_",",58)=$$NOW^XLFDT
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
