YSCLHLOP ; HEC/hrubovcak clozapine HL7 option support ;19 May 2020 14:13:48
 ;;5.01;MENTAL HEALTH;**149**;Dec 30, 1994;Build 72
 ; 
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to ^PSDRUG supported by IA #221
 ; Reference to ^PSRX supported by IA #780
 ; Reference to ^PSO52API supported by IA #4820
 ; Reference to ^DIE supported by IA #2053
 ; Reference to ^DICRW supported by IA #1005
 ; Reference to ^%ZTLOAD supported by IA #10063
 ; Reference to ^DIQ supported by DBIA #2056
 ; Reference to ^XLFDT supported by DBIA #10103
 ; Reference to ^VASITE supported by DBIA #10112
 ;
 Q
 ;
RETRANS ; entry point from TaskMan to retransmit HL7 messages
 ;
 Q:'$G(ZTSK)  ; must be queued
 N YSHL7
 S YSHL7("allowDups")=1
 ;
 ; fall through to transmit the messages
DLYHL7 ; Clozapine HL7 Message Transmission [YSCL HL7 CLOZ TRANSMISSION] TaskMan entry point
 D DT^DICRW
 K ^TMP($J)  ; clear any residue
 N N,X,Y,YSCLABRT,YSCLZDRUG,YSDFN,YSFMERR,YSFMFDA,YSILENT,YSNOW,YSORLST,YSPSRX,YSRXIEN,YSRXLST
 ; only one process can run at a time
 S N=$$NOW^XLFDT L +^XTMP("YSCLHL7",0):DILOCKTM E  D  Q
 . S ^XTMP("YSCLHL7",0,"LOCK FAILED")=N_U_$S($G(ZTSK):"Task #"_ZTSK,1:"no task")_U_"Job #"_$J
 ; (#20.01) HL7 TRANSMISSION START [1D] ^ (#20.02) HL7 TRANSMISSION END [2D]
 S YSFMFDA(603.03,"1,",20.01)=$$NOW^XLFDT,YSFMFDA(603.03,"1,",20.02)="@"
 D FILE^DIE("","YSFMFDA","YSFMERR")
 ; update zero node at beginning
 D XTMPZRO S ^XTMP("YSCLHL7",0,"RUNNING")=$G(ZTSK)_U_N K ^XTMP("YSCLHL7",0,"LOCK FAILED")
 S YSCLABRT=0  ; if true transmission aborted
 S X=0 F  S X=$O(^PSDRUG("ACLOZ",X)) Q:'X  S YSCLZDRUG(X)=""  ; Clozapine IEN list
 I '$O(YSCLZDRUG(0)) S YSCLABRT=1 D  Q
 . S YSCLABRT(1)="* No Clozapine entries found in the DRUG file (#55). *"
 . D SNDMSG  ; 
 D BLDPTLST  ; list of active clozapine patients
 I '$O(^TMP($J,"YSCLOZDFN",0)) S YSCLABRT=1 D  Q
 . S YSCLABRT(1)="* No active Clozapine patients found in file #603.01. *"
 . D SNDMSG
 ;
 S YSNOW=$$NOW^XLFDT,YSDFN=0
 K ^TMP($J,"YS HL7LST") S ^TMP($J,"YS HL7LST",0)=0  ; list for MailMan report
 F  S YSDFN=$O(^TMP($J,"YSCLOZDFN",YSDFN)) Q:'YSDFN  D
 . D GETCLZRX(.YSRXLST,YSDFN) S YSRXIEN=0 F  S YSRXIEN=$O(YSRXLST(YSRXIEN)) Q:'YSRXIEN  D
 ..  N HLO,YSCLARR,YSHLRSLT,YSNWIEN
 ..  S HLO("Rx#")=$P(YSRXLST(YSRXIEN),U)  ; prescription # may contain letters
 ..  I '$G(YSHL7("allowDups")) Q:$O(^YSCL(603.05,"RX",HLO("Rx#"),0))  ; already transmitted
 ..  D GET^YSCLHLGT(.YSCLARR,YSDFN,0,YSRXIEN)  ; data for HL7 message
 ..  I $G(YSCLARR("MED_RX#/ORDER#"))="" S YSCLARR("MED_RX#/ORDER#")=$G(HLO("Rx#"))
 ..  Q:YSCLARR("MED_RX#/ORDER#")=""
 ..  D XMI1PT^YSCLHLMA(.YSCLARR,.YSHLRSLT,1)  ; "1" is for YSILENT, no writes to device
 ..  Q:'$O(YSHLRSLT(0))  ; nothing sent
 ..  D UPDT4RX(.YSHLRSLT,YSDFN,.HLO)
 ; now do orders
 S YSORDT=$$HTFM^XLFDT($H-90)  ; default to 90 days
 N YSUNSNT S YSUNSNT=0  ; true if messages not sent
 ; ^PS(55,"AUDS",start date/time,dfn,order#) cross-ref
 F  S YSORDT=$O(^PS(55,"AUDS",YSORDT)) Q:'YSORDT!(YSORDT>YSNOW)  D  ; skip future orders
 . S YSORDT("LAST")=YSORDT
 . S YSDFN=0 F  S YSDFN=$O(^PS(55,"AUDS",YSORDT,YSDFN)) Q:'YSDFN   D:$D(^TMP($J,"YSCLOZDFN",YSDFN))
 ..  N YSUDSIEN
 ..  S YSUDSIEN=0 F  S YSUDSIEN=$O(^PS(55,"AUDS",YSORDT,YSDFN,YSUDSIEN)) Q:'YSUDSIEN  D
 ...   N YSCLARR,YSGORD,YSUNSNT
 ...   S YSUNSNT=0
 ...   D GETCLZOR^YSCLHLGT(.YSCLARR,YSDFN,YSUDSIEN) Q:'$D(YSCLARR("*RPT"))
 ...   ; ajf ; check for order number
 ...   N YSORNUM S YSORNUM=YSCLARR("MED_RX#/ORDER#")
 ...   S YSGORD=YSUDSIEN Q:YSGORD=""
 ...   I '$G(YSHL7("allowDups")) Q:$O(^YSCL(603.05,"ON",YSCLARR("MED_RX#/ORDER#"),0))  ; already transmitted
 ...   D GET^YSCLHLGT(.YSCLARR,YSDFN,YSGORD,0)  ; data for HL7 message
 ...   N HLO,YSHLRSLT D XMI1PT^YSCLHLMA(.YSCLARR,.YSHLRSLT,1)  ; "1" is for YSILENT, no writes to terminal
 ...   I '$O(YSHLRSLT(0)) S YSUNSNT=YSUNSNT+1  Q  ; nothing sent
 ...   ;ajf ; SET YSGORD = YSORNUM
 ...   S YSGORD=YSORNUM
 ...   D UPDT4OR(.YSHLRSLT,YSDFN,YSGORD)
 ; all done
 D SNDMSG
 ; (#20.02) HL7 TRANSMISSION END [2D]
 K YSFMERR,YSFMFDA S YSFMFDA(603.03,"1,",20.02)=$$NOW^XLFDT
 D FILE^DIE("","YSFMFDA","YSFMERR")
 ; transmission finished, update ^XTMP zero node, delete "RUNNING" node, release LOCK, exit
 D XTMPZRO K ^XTMP("YSCLHL7",0,"RUNNING") L -^XTMP("YSCLHL7",0)
 K ^TMP($J),YSORDT  ; clean up
 Q
 ;
GETCLZRX(RXRSLT,DFN) ; RXRSLT passed by ref., get clozapine prescriptions
 ; YSRXIEN is IEN in PRESCRIPTION file (#52)
 N DRUGIEN,PRFLIEN,YSRXIEN K RXRSLT S RXRSLT=0
 ; ^PS(55,D0,P,D1,0)= (#.01) PRESCRIPTION PROFILE [1P:52]
 S PRFLIEN=0 F  S PRFLIEN=$O(^PS(55,DFN,"P",PRFLIEN)) Q:'PRFLIEN  K DRUGIEN,YSRXIEN S YSRXIEN=+$G(^PS(55,DFN,"P",PRFLIEN,0)) I YSRXIEN>0,$D(^PSRX(YSRXIEN,0)) D
 . S YSRXIEN(0)=$G(^PSRX(YSRXIEN,0)),DRUGIEN=+$P(YSRXIEN(0),U,6) Q:'(DRUGIEN>0)  ; must have drug pointer
 . Q:'$D(^PSDRUG("ACLOZ",DRUGIEN))  ; not Clozapine
 . K YSFMERR Q:$$GET1^DIQ(52,YSRXIEN_",",100,"I","YSFMERR")  ; (#100) STATUS [1S], '0' FOR ACTIVE
 . S RXRSLT(YSRXIEN)=YSRXIEN(0),RXRSLT=RXRSLT+1
 ;
 Q
 ;
 ;
UPDT4RX(YSHLRST,YSDFN,HLO) ;  update file #603.05 for prescriptions, save MailMan text
 ; YSHRSLT, HLO both passed by ref.
 N YSNWIEN S YSNWIEN=0 F  S YSNWIEN=$O(YSHLRSLT(YSNWIEN)) Q:'YSNWIEN  D
 . ; save info for MailMan message
 . S HLO("type")=$P(YSHLRSLT(YSNWIEN),U,2)  ; type of message
 . S HLO("ien")=$P(YSHLRSLT(YSNWIEN),U) Q:'HLO("ien")  ; must have IEN
 . D HLOCNTR
 . S ^TMP($J,"YS HL7LST","Rx",HLO("ien"))=HLO("type")_U_HLO("Rx#")
 . N YSFMUPDT
 . S YSFMUPDT(603.51,.01)=YSNOW  ; (#.01) DATE/TIME OF TRANSMISSION [1D]
 . S YSFMUPDT(603.51,.02)=HLO("ien")  ; (#.02) HLO IEN [2N]
 . S YSFMUPDT(603.51,.03)=HLO("type")  ; (#.03) MESSAGE TYPE [3F]
 . S YSFMUPDT(603.51,.04)=HLO("Rx#")  ; (#.04) PRESCRIPTION # [4F]
 . D UPDTFL(YSDFN,.YSFMUPDT) ; update subfile
 ;
 Q
 ;
UPDT4OR(YSHRLST,YSDFN,YSGORD) ; update file #603.05 for orders, save MailMan text
 ; YSHRSLT passed by ref.
 N HLO,YSNWIEN
 S YSNWIEN=0 F  S YSNWIEN=$O(YSHLRSLT(YSNWIEN)) Q:'YSNWIEN  D
 . ; save info for MailMan message
 . S HLO("type")=$P(YSHLRSLT(YSNWIEN),U,2)  ; type of message
 . S HLO("ien")=$P(YSHLRSLT(YSNWIEN),U) Q:'HLO("ien")  ; must have IEN
 . D HLOCNTR
 . S ^TMP($J,"YS HL7LST","Order",HLO("ien"))=HLO("type")_U_YSGORD
 . N YSFMUPDT
 . S YSFMUPDT(603.52,.01)=YSNOW  ; (#.01) DATE/TIME OF TRANSMISSION [1D]
 . S YSFMUPDT(603.52,.02)=HLO("ien")  ; (#.02) HLO IEN [2N]
 . S YSFMUPDT(603.52,.03)=HLO("type")  ; (#.03) MESSAGE TYPE [3F]
 . S YSFMUPDT(603.52,.04)=YSGORD  ; (#.04) ORDER # [4F]
 . D UPDTFL(YSDFN,.YSFMUPDT) ; update subfile
 Q
 ;
HLOCNTR ; count of HLO messages sent
 N NHL7 S NHL7=$G(^TMP($J,"YS HL7LST",0))+1,^(0)=NHL7  ; message count
 Q
ASK2QUE ;
 N DTOUT,DUOUT
 Q:$G(ZTSK)  ; can't be queued
 D DT^DICRW
 Q:$$RUNCHK  ; already running
 ;
 K DIR S DIR(0)="YA",DIR("A")="Are you sure you want to continue? ",DIR("B")="NO"
 S DIR("A",1)=" "  ; skip a line
 S DIR("A",2)="This will queue the HL7 messages for all active Clozapine patients."
 S DIR("A",3)="If HL7 messages have already been sent for a prescription or order"
 S DIR("A",4)="they will NOT be retransmitted."
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 I 'Y D  Q
 . K DIR S DIR(0)="EA",DIR("A")="Nothing queued.  Press enter: ",DIR("A",1)=" " D ^DIR
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 S ZTIO="",ZTRTN="DLYHL7^"_$T(+0),ZTDTH=$H,ZTDESC="Clozapine HL7 transmission"
 D ^%ZTLOAD
 ;
 K DIR S DIR(0)="EA",DIR("A")="Press enter: ",DIR("A",1)=" "
 S DIR("A",2)=$S($G(ZTSK):"Queued as task #"_ZTSK,1:"NOT queued!")
 D ^DIR
 Q
 ;
RETRHL7 ; Retransmit Clozapine HL7 Messages [YSCL HL7 CLOZ RETRANSMIT]
 ;
 D DT^DICRW N DIR,V,X,Y,DTOUT,DUOUT
 ; this cannot be queued
 I $G(ZTSK) S ^XTMP("YSCLHL7",0,"RETRANSMIT QUEUE ATTEMPT")=ZTSK_U_$$NOW^XLFDT Q
 ; only one at a time
 Q:$$RUNCHK
 ;
 K DIR S DIR(0)="YA",DIR("A")="Are you sure you want to continue? ",DIR("B")="NO"
 S DIR("A",1)=" "  ; skip a line
 S DIR("A",2)="This will retransmit HL7 messages for all active Clozapine patients."
 S DIR("A",3)="If a Prescription or Order is found messages will be sent."
 S DIR("A",4)="Duplicate HL7 messages could be transmitted."
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 I 'Y D  Q
 . K DIR S DIR(0)="EA",DIR("A")="Nothing queued.  Press enter: ",DIR("A",1)=" " D ^DIR
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 S ZTIO="",ZTRTN="RETRANS^"_$T(+0),ZTDTH=$H,ZTDESC="Clozapine HL7 retransmit"
 D ^%ZTLOAD
 ;
 K DIR S DIR(0)="EA",DIR("A")="Press enter: ",DIR("A",1)=" "
 S DIR("A",2)=$S($G(ZTSK):"Queued as task #"_ZTSK,1:"NOT queued!")
 D ^DIR
 Q
 ;
BLDPTLST  ; build list of Clozapine Patients
 N YSIEN,X,YSDFN,YSRXPT,YSFLD
 ; get file 55 data
 ;^PS(55,D0,SAND)= (#53) CLOZAPINE REGISTRATION NUMBER [1F] ^ (#54) CLOZAPINE STATUS [2S] ^ (#55) DATE OF LAST CLOZAPINE RX [3D] ^
 ;             ==>(#56) DEMOGRAPHICS SENT [4S] ^ (#57) RESPONSIBLE PROVIDER [5P:200] ^ (#58) REGISTRATION DATE [6D] ^
 S YSIEN=0 F  S YSIEN=$O(^YSCL(603.01,YSIEN)) Q:'YSIEN  D
 . S X=$G(^YSCL(603.01,YSIEN,0)),YSDFN=+$P(X,U,2) Q:'YSDFN  ; must have patient pointer
 . K YSRXPT S YSRXPT(54)=$$GET1^DIQ(55,YSDFN,54,"I")
 . ; only active patients on list
 . Q:'(YSRXPT(54)="A")  F YSFLD=53,55:1:58 S YSRXPT(YSFLD)=$$GET1^DIQ(55,YSDFN,YSFLD,"I")
 . M ^TMP($J,"YSCLOZDFN",YSDFN,"FILE55")=YSRXPT
 ;
 Q
 ;
UPDTFL(YSDFN,YSFMUPDT) ; update file & sub-file
 ; YSFMUPDT - data for ^DIE, passed by ref.
 N J,YSFMERR,YSFMIEN,YSFMROOT,YSIENS,YSUBFL
 ; add patient if not in file #603.05
 I '$D(^YSCL(603.05,YSDFN)) D
 . S YSFMROOT(603.05,"+1,",.01)=YSDFN,YSFMIEN(1)=YSDFN  ; entry is DINUM pointer
 . D UPDATE^DIE("","YSFMROOT","YSFMIEN","YSFMERR")
 . K YSFMERR,YSFMIEN,YSFMROOT
 ; sub-file 603.51 or 603.52
 S YSUBFL=+$O(YSFMUPDT(0)),YSIENS="+1,"_YSDFN_","  ; adding to multiple
 S J=0 F  S J=$O(YSFMUPDT(YSUBFL,J)) Q:'J  S YSFMROOT(YSUBFL,YSIENS,J)=YSFMUPDT(YSUBFL,J)
 D UPDATE^DIE("","YSFMROOT","YSFMIEN","YSFMERR")
 Q
 ;
SNDMSG ; send MailMan message
 N CNT,HLIEN,L,NHL7,X,Y,YSFROM,YSITE,YSXMBODY,YSXMSUBJ,YSXMTO,YSXMZ
 K ^TMP("XMERR",$J),^TMP($J,"YSXMTXT")
 S YSITE=$$SITE^VASITE,NHL7=+$G(^TMP($J,"YS HL7LST",0))
 S YSXMBODY=$NA(^TMP($J,"YSXMTXT"))  ; mail message text
 D ADD2TXT(" HL7 transmission report "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ADD2TXT(" Site: "_$P(YSITE,U,2)_" ("_$P(YSITE,U,3)_")"),ADD2TXT(" ")
 I $G(YSHL7("allowDups"))  D
 . S X=$$GET1^DIQ(200,DUZ_",",.01)
 . D ADD2TXT(" NOTE: This is a requested retransmission.")
 . D ADD2TXT(" Requested by: "_X_" (#"_DUZ_")")
 ;
 I $G(YSCLABRT) D  ; process aborted
 . D ADD2TXT(" *** ERROR: The Clozapine HL7 transmission process aborted. ***")
 . S X=0 F  S X=$O(YSCLABRT(X)) Q:'X  D ADD2TXT(YSCLABRT(X))
 ;
 D ADD2TXT(" Total messages sent: "_NHL7),ADD2TXT(" ")
 S CNT=0  ; counter for Mail message
 D:NHL7  ; ^TMP($J,"YS HL7LST","Rx",HLIEN)=HLO("type")_U_HLO("Rx#")
 . D ADD2TXT("     Message ID          Type     Prescription"),ADD2TXT(" ")
 . S HLIEN=0 F  S HLIEN=$O(^TMP($J,"YS HL7LST","Rx",HLIEN)) Q:'HLIEN  D
 ..  S CNT=CNT+1
 ..  N HLO S HLO("msgId")=$$GET1^DIQ(778,HLIEN_",",.01)  ; (#.01) MESSAGE ID [1F]
 ..  S HLO("body")=$$GET1^DIQ(778,HLIEN_",",.02,"I")  ; (#.02) MESSAGE BODY [2P:777] internal format
 ..  ; (#.03) MESSAGE TYPE [3F] ^ (#.04) EVENT [4F]
 ..  S HLO("type")=$$GET1^DIQ(777,HLO("body")_",",.03)_U_$$GET1^DIQ(777,HLO("body")_",",.04)
 ..  S L=$J(CNT,3)_". "_HLO("msgId")_$J(" ",19-$L(HLO("msgId"))),L=L_HLO("type")_$J(" ",10-$L(HLO("type")))
 ..  S X=^TMP($J,"YS HL7LST","Rx",HLIEN)
 ..  D ADD2TXT(L_$P(X,U,2))  ; add Rx #
 . ; add order info
 . D ADD2TXT(" "),ADD2TXT("     Message ID          Type     Order Number"),ADD2TXT(" ")
 . S HLIEN=0 F  S HLIEN=$O(^TMP($J,"YS HL7LST","Order",HLIEN)) Q:'HLIEN  D
 ..  S CNT=CNT+1
 ..  N HLO S HLO("msgId")=$$GET1^DIQ(778,HLIEN_",",.01)  ; (#.01) MESSAGE ID [1F]
 ..  S HLO("body")=$$GET1^DIQ(778,HLIEN_",",.02,"I")  ; (#.02) MESSAGE BODY [2P:777] internal format
 ..  ; (#.03) MESSAGE TYPE [3F] ^ (#.04) EVENT [4F]
 ..  S HLO("type")=$$GET1^DIQ(777,HLO("body")_",",.03)_U_$$GET1^DIQ(777,HLO("body")_",",.04)
 ..  S L=$J(CNT,3)_". "_HLO("msgId")_$J(" ",19-$L(HLO("msgId"))),L=L_HLO("type")_$J(" ",10-$L(HLO("type")))
 ..  S X=^TMP($J,"YS HL7LST","Order",HLIEN)
 ..  D ADD2TXT(L_$P(X,U,2))  ; add Order #
 ;
 S YSXMTO(DUZ)="",YSXMTO("G.YSCLHL7 LOGS")=""  ; recipients
 D ADD2TXT(" ")
 ; add Mail Groups, etc. to message
 S X=" " F  S X=$O(YSXMTO(X)) Q:X=""  D ADD2TXT(" Sent to: "_X)
 D ADD2TXT($$EOR^YSCLHLPR)
 S YSXMSUBJ="Clozapine HL7 report "_$P(YSITE,U,2)_" ("_$P(YSITE,U,3)_")"
 D SENDMSG^XMXAPI(DUZ,YSXMSUBJ,YSXMBODY,.YSXMTO,"",.YSXMZ)
 Q
 ;
ADD2TXT(TXLN) ; add TXLN to MailMan message text
 N C S C=$G(^TMP($J,"YSXMTXT",0))+1,^(0)=C
 S ^TMP($J,"YSXMTXT",C,0)=TXLN Q
 ;
RUNCHK(YSRSLT) ; Boolean function, zero if transmission NOT running
 ; there is user interaction if ZTSK not true
 S YSRSLT=0
 L +^XTMP("YSCLHL7",0):DILOCKTM E  D  ; cant't LOCK if running
 . S YSRSLT=1  ; return true
 . Q:$G(ZTSK)  ; queued
 . N DIR,V,X
 . S DIR(0)="EA",DIR("A")="Press enter: "
 . S DIR("A",1)="The Clozapine HL7 Message Transmission appears to be running."
 . S V=$NA(^XTMP("YSCLHL7",0,"RUNNING")),X=$G(@V),DIR("A",2)=V_" node: "
 . S DIR("A",2)=$S('$D(@V):" Is not defined.",1:" Task #"_$P(X,U)_" started "_$$FMTE^XLFDT($P(X,U,2)))
 . D ^DIR
 ;
 L -^XTMP("YSCLHL7",0)
 Q YSRSLT
 ;
XTMPZRO ;set zero node in ^XTMP("YSCLHL7")
 ; update ^XTMP("YSCLHL7",0) with purge date and $$NOW
 N C,J,N
 S N=$$NOW^XLFDT,C=$$FMADD^XLFDT($$DT^XLFDT,90)  ; 90 days in the future
 S J=C,$P(J,U,2)=N,$P(J,U,3)="YSCL Clozapine Daily HL7 Transmission Data",^XTMP("YSCLHL7",0)=J
 I $G(ZTSK) S ^XTMP("YSCLHL7",0,"TASK #")=ZTSK_U_N
 Q
 ;
