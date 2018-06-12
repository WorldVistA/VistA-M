PSORRX1 ;AITC/BWF - Remote RX driver ;8/30/16 12:00am
 ;;7.0;OUTPATIENT PHARMACY;**454,499,509,519**;DEC 1997;Build 5
 ;
 ;Reference ^PSDRUG( supported by DBIA 221
 Q
 ;
REMOTERX(DFN,PSOSITE) ;
 N RXRES,MSG,HLARR,CNT,RXDAT,HLARR,HLPROT,DONE,ORFS,ORCS,ORRS,ORES,ORSS,ORQUIT,HLQUIT,HLDAT,TFLIST,HLP,HLNODE,HLNEXT,HLINSTN
 N PID1,PID4,PID5,PID6,TFDAT,LOOP,RXMSG,PSORRDAT,PSOHCNT,ERR,HL,PSORRDAT,ORERR,SITE
 S HLARR=$NA(^TMP("HLS",$J)) K @HLARR
 S HLDAT=$NA(^XTMP("PSORRX1",$J)) K @HLDAT
 ; moved to PSORX1
 ;I '$$GET1^DIQ(59,PSOSITE,3001,"I") D  Q
 ;.W !!,"The OneVA Pharmacy flag is turned off. Queries will NOT"
 ;.W !,"be made to other VA Pharmacy locations.",!
 ; possibly add error message to be returned if no DFN.
 I 'DFN Q
 S SITE=$P($$SITE^VASITE(),U)
 S TFSTRING=$$GET1^DIQ(2,DFN,991.01,"I")_"^^^USVHA^NI^"_SITE
 S HLPROT="PSO REMOTE RX QBP-Q13 EVENT"
 D INIT^HLFNC2(HLPROT,.HL)
 D BLDPID^PSOTPHL2(DFN,"",.PSORRDAT,.HL,.ERR)
 I $D(ERR) W !,"There was a problem creating the PID segment for this patient.",!,"Please contact technical support.",!
 S @HLARR@(1)="QPD^Q13~Active Prescriptions~HL70471^"
 S DONE=0
 F PSOHCNT=1:1 D  Q:DONE
 .I '$D(PSORRDAT(PSOHCNT)) S DONE=1 Q
 .S @HLARR@(2)=$G(@HLARR@(2))_PSORRDAT(PSOHCNT)
 S @HLARR@(3)="RCP^I"
 S HLP("SUBSCRIBER")="^^^^200HD~HDR.DOMAIN.EXT~DNS"
 D DIRECT^HLMA(HLPROT,"GM",1,.RXDAT,"",.HLP)
 S ORFS=$G(HL("FS")),ORCS=$E($G(HL("ECH")),1),ORRS=$E($G(HL("ECH")),2),ORES=$E($G(HL("ECH")),3),ORSS=$E($G(HL("ECH")),4)
 S HLQUIT=0,ORQUIT="",ORERR=""
 I $P(RXDAT,U,3)="No response"!($P(RXDAT,U,3)="Connection Failed") D  Q
 .W !,"The system is down or not responding.",!,"Could not query prescriptions at other VA Pharmacy locations.",!
 .K DIR S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR
 F  X HLNEXT Q:HLQUIT'>0!(ORQUIT'="")  D
 .N LOOP
 .S LOOP=0 F  S LOOP=$O(HLNODE(LOOP)) Q:LOOP=""  S HLNODE=HLNODE_HLNODE(LOOP)
 .I $E(HLNODE,1,3)="MSA"&(($P(HLNODE,ORFS,2)'="CA")) D LOGERR(DFN,.HLNODE,.HLDAT,$P(HLNODE,ORFS,4)) S ORQUIT=$P(HLNODE,ORFS,4)
 .I $E(HLNODE,1,3)="ERR" D LOGERR(DFN,.HLNODE,.HLDAT) S ORQUIT=$P(HLNODE,ORFS,4)
 .I $E(HLNODE,1,3)="RDT" D
 ..S @HLDAT@(0)=$$FMADD^XLFDT($$NOW^XLFDT,2)_U_$$NOW^XLFDT
 ..D RXPRSE(DFN,.HLNODE,.HLDAT)
 Q
LOGERR(DFN,DATA,HLDAT,NMSG) ;
 N HLERR
 S NMSG=$G(NMSG,"")
 S HLERR=$S(NMSG'="":NMSG,1:$P(DATA,ORFS,9))
 S:'$D(@HLDAT@(0)) @HLDAT@(0)=$$FMADD^XLFDT($$NOW^XLFDT,2)_U_$$NOW^XLFDT
 S @HLDAT@(DFN,"ERR")="<"_HLERR_">"
 W !!,"When trying to query prescriptions at other VA Pharmacy",!,"Locations the following message was encountered:",!,"***",!,HLERR,!,"***",! K DIR S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 Q
 ; parse rx data from RDF segment
RXPRSE(DFN,DATA,HLDAT) ;
 ;RDF|14|Site Number~Rx Number~Drug Name~Quantity~Refills~Days Supply~Expiration Date
 ;~Issue Date~Stop Date~Last Fill Date~Sig~Detail~Status~VA Product ID
 N RXSITE,RXNUM,DNAME,QTY,REFILLS,DSUPP,EXPDT,ISSDATE,STOPDT,LFDT,SIG,DETAIL,STAT,STATNM,STATERR,DDONE,I,VAPID,VAFQDN,DAT
 ; put data into one variable. This handles overflow nodes
 S DAT=0 F  S DAT=$O(DATA(DAT)) Q:'DAT  D
 .S DATA=$G(DATA)_$G(DATA(DAT))
 S RXSITE=$P(DATA,ORFS,2),RXNUM=$P(DATA,ORFS,3),DNAME=$P(DATA,ORFS,4),QTY=$P(DATA,ORFS,5)
 Q:DNAME=""
 S REFILLS=$P(DATA,ORFS,6),DSUPP=$P(DATA,ORFS,7),EXPDT=$P(DATA,ORFS,8),ISSDATE=$P(DATA,ORFS,9)
 S STOPDT=$P(DATA,ORFS,10),LFDT=$P(DATA,ORFS,11),SIG=$P(DATA,ORFS,12),DETAIL=$P(DATA,ORFS,13)
 S STAT=$P(DATA,ORFS,14) Q:STAT=""
 ; VA Product ID
 S VAPID=$P(DATA,ORFS,15)
 S VAFQDN=$P(DATA,ORFS,16)
 Q:STAT=""
 Q:'RXSITE!('RXNUM)
 S @HLDAT@(DFN,RXSITE,STAT,DNAME,0)=RXNUM_U_QTY_U_REFILLS_U_DSUPP_U_EXPDT_U_ISSDATE_U_STOPDT_U_LFDT_U_STAT_U_VAPID_U_DNAME_U_VAFQDN
 S @HLDAT@(DFN,RXSITE,STAT,DNAME,"SIG")=SIG
 S @HLDAT@(DFN,RXSITE,STAT,DNAME,"DETAIL")=DETAIL
 Q
 ; build and send refill request
REFREQ ;
 N PHARM,PHONE,LOCSITE,DSUPP,MW,FILLDT,MSG,RXNUM,HLSTR,REMSITE,PHARMLN,PHARMFN,PHARMMI,TFSTRING,HLPROT,LOCDRUG,REMDRUG,DINACT
 N ORFS,ORCS,ORRS,ORES,ORSS,HLQUIT,ORQUIT,RESP,RETDFN,VAPID,DONE,PSORRDAT,PSOHCNT,DONE,HL,CSVAL,DIR,REMSIEN,PSOHLNK,PSOLNKDN,DOMOVR,RMSDOM
 S HLARR=$NA(^TMP("HLS",$J)) K @HLARR
 S HLDAT=$NA(^XTMP("REFREQ^PSORRX1",$J)) K @HLDAT
 S HLPROT="PSO REMOTE RX RDS-O13 EVENT"
 S MW="W"
 D FULL^VALM1
 S LOCSITE=$$STA^XUAF4(DUZ(2))
 S PHARM=$$GET1^DIQ(200,DUZ,.01,"E"),PHARMLN=$P(PHARM,","),PHARMFN=$P($P(PHARM,",",2)," "),PHARMMI=$P($P(PHARM,",",2)," ",2)
 S PHONE=$$GET1^DIQ(200,DUZ,.132,"E")
 S RXNUM=$P(PSOLST(ORN),U,2) I 'RXNUM S MSG(1)="Invalid Rx #. Please contact technical support." Q
 I SRXSTAT'="ACTIVE" W !!,"Only 'ACTIVE' remote prescriptions may be refilled at this time." S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 S REMSITE=$P(PSOLST(ORN),U,4)   ;,REMSIEN=$O(^DIC(4,"D",REMSITE,0))
 S REMSIEN=$$FIND1^DIC(4,,"X",REMSITE,"D","I $P(^(0),U,11)=""N"",'$P($G(^(99)),U,4)") Q:'REMSIEN
 S PSOREF("DFLG")=""
 S REMDRUG=$P(REMDATA,U,11),VAPID=$P(REMDATA,U,10)
 I '$L(VAPID) W !!,"Missing VA Product ID. Rx# ",RXNUM," cannot be refilled." S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 S LOCDRUG=$$DRUGMTCH(REMDRUG,VAPID)
 I $G(LOCDRUG)=-1 Q  ; user entered no so no reason to prompt again
 I '$G(LOCDRUG) W !!,"Could not match remote drug to a local drug. Cannot refill Rx# ",RXNUM,"." S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 S DINACT=$$GET1^DIQ(50,LOCDRUG,100,"I")
 I DINACT>0,DINACT<$$NOW^XLFDT W !!,"Matched Drug "_$$GET1^DIQ(50,LOCDRUG,.01,"E")_" is inactive.",!,"Cannot refill."  S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 ; ****** controlled substance check
 S CSVAL=$$GET1^DIQ(50,LOCDRUG,3,"E"),CSVAL=$E(CSVAL,1)
 I CSVAL,CSVAL>0,CSVAL<6 W !!,"This is a controlled substance. Cannot refill Rx#",RXNUM,"." S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 ;
 ; if we got this far, fill is most likely happening and remote
 ; worklist needs to be rebuilt when returning so set flag. PSORRBLD
 ; was New'ed in calling routine. May change my mind if we get an
 ; error from host.
 S PSORRBLD=1
 ;
 S (FILLDT,PSOREF("FILL DATE"))=DT
 D INIT^HLFNC2(HLPROT,.HL)
 D BLDPID^PSOTPHL2(DFN,"",.PSORRDAT,.HL,.ERR)
 S DONE=0
 F PSOHCNT=1:1 D  Q:DONE
 .I '$D(PSORRDAT(PSOHCNT)) S DONE=1 Q
 .S @HLARR@(1)=$G(@HLARR@(1))_PSORRDAT(PSOHCNT)
 ;S @HLARR@(2)="ORC^RF^"_RXNUM_"~"_REMSITE_"~"_$$GET1^DIQ(4,REMSIEN,60,"E")_"^^^^^^^"_FILLDT_U_DUZ_"~"_PHARMLN_"~"_PHARMFN_"~"_PHARMMI_"^^^~~~"_LOCSITE_U_PHONE
 S @HLARR@(2)="ORC^RF^"_RXNUM_"~"_REMSITE_"~"_$$FQDN^PSORWRAP(,REMSIEN)_"^^^^^^^"_FILLDT_U_DUZ_"~"_PHARMLN_"~"_PHARMFN_"~"_PHARMMI_"^^^~~~"_LOCSITE_U_PHONE
 S @HLARR@(3)="RXO^^^^^^^^"_MW_"~~~"_LOCSITE
 W !!,"Processing refill request. Please be patient as it may take a moment"
 W !,"for the host site to respond and generate your label data..."
 ;S PSOHLNK=$O(^HLCS(870,"C",REMSIEN,0))
 ;S PSOLNKNM=$$GET1^DIQ(870,PSOHLNK,.01,"E")
 ;S RMSDOM=$$GET1^DIQ(870,PSOHLNK,.03,"E")  ; get domain name
 ;S RMSDOM=$$GET1^DIQ(4,REMSIEN,60,"E")
 ;S:$$PROD^XUPROD() RMSDOM="HL7."_RMSDOM   ; prefix domain name
 S RMSDOM=$$FQDN^PSORWRAP(,REMSIEN)
 S DOMOVR=REMSITE_"~"_RMSDOM_"~DNS"
 S HLP("SUBSCRIBER")="^^^^"_DOMOVR
 D DIRECT^HLMA(HLPROT,"GM",1,.RESP,"",.HLP)
 D READMSG^PSORRX2(.HLDAT,"RF",LOCDRUG)
 K @HLDAT,@HLARR
 Q
 ; build and send partial fill request
PARTIAL() ;
 N DIR,DONE,I,PRMPDAT,VAR,PRXNUM,PHARM,PHARMLN,PHARMFN,PHARMMI,PHONE,RXNUM,HLPROT,TFSTRING,HLARR,PHONE,REMSITE,HLDAT,LOCDRUG,EXIT,VAPID,HL,ERR
 N PSOHCNT,DONE,PSORRDAT,CSVAL,REMSIEN,PSOHLNK,PSOLNKDN,REMDRUG,Y,DINACT,EXE,DOMOVR,RMSDOM
 S HLPROT="PSO REMOTE RX RDS-O13 EVENT"
 S HLDAT=$NA(^XTMP("PARTIAL^PSORRX1",$J)) K @HLDAT
 S HLARR=$NA(^TMP("HLS",$J)) K @HLARR
 D FULL^VALM1
 I SRXSTAT'="ACTIVE" W !!,"Only 'ACTIVE' remote prescriptions may be actioned at this time." S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 S LOCSITE=$$STA^XUAF4(DUZ(2))
 S PHONE=$$GET1^DIQ(200,DUZ,.132,"E")
 S PRXNUM=$P(PSOLST(ORN),U,2) I 'PRXNUM S MSG(1)="Invalid Rx #. Please contact technical support." Q
 S REMSITE=$P(PSOLST(ORN),U,4)
 S REMSIEN=$$FIND1^DIC(4,,"X",REMSITE,"D","I $P(^(0),U,11)=""N"",'$P($G(^(99)),U,4)") Q:'REMSIEN
 S DONE=0,CNT=1
 ; prompt for fields that would normally be prompted for a local partial fill.
 D FULL^VALM1
 S REMDRUG=$P(REMDATA,U,11),VAPID=$P(REMDATA,U,10)
 I '$L(VAPID) W !!,"Missing VA Product ID. Rx# ",PRXNUM," cannot be refilled." S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 S LOCDRUG=$$DRUGMTCH(REMDRUG,VAPID)
 I $G(LOCDRUG)=-1 Q  ; user entered no so no reason to prompt again
 I '$G(LOCDRUG) W !!,"Could not match remote drug to a local drug.",!,"Cannot complete partial fill for Rx# ",PRXNUM,"." S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 S DINACT=$$GET1^DIQ(50,LOCDRUG,100,"I")
 I DINACT>0,DINACT<$$NOW^XLFDT W !!,"Matched Drug "_$$GET1^DIQ(50,LOCDRUG,.01,"E")_" is inactive.",!,"Cannot create partial fill request."  S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 ; controlled substance check
 S CSVAL=$$GET1^DIQ(50,LOCDRUG,3,"E"),CSVAL=$E(CSVAL,1)
 I CSVAL,CSVAL>0,CSVAL<6 W !!,"This is a controlled substance. Cannot refill Rx#",PRXNUM,"." S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 S EXIT=0
 S PDATE=DT
 S MW="W"
 F I=1:1 D  Q:DONE!(EXIT)
 .S PRMPDAT=$T(PRMPTXT+I)
 .S PRMPDAT=$P(PRMPDAT,";;",2)
 .I PRMPDAT="Q" S DONE=1 Q
 .K DIR
 .S DIR(0)=$P(PRMPDAT,"|"),DIR("A")=$P(PRMPDAT,"|",2),VAR=$P(PRMPDAT,"|",4) S:$L($P(PRMPDAT,"|",3)) DIR("B")=$P(PRMPDAT,"|",3)
 .I $G(DIR("B"))["~" D
 ..S EXE=$TR(DIR("B"),"~","^") X EXE S DIR("B")=DEF
 .D ^DIR
 .I Y="^" S EXIT=1 Q
 .S @VAR=$S($P(DIR(0),"^")["P":$P(Y,U,2),1:Y)  ;*499
 K DEF
 I EXIT W !,"Cancelling partial fill request.",! K DIR S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q
 ; if we got this far, fill attempt happening and remote worklist
 ; needs to be rebuilt when returning so set flag. PSORRBLD was New'ed
 ; in calling routine.  May change my mind if we get an error from
 ; host
 S PSORRBLD=1
 S PHARMLN=$P(PHARM,","),PHARMFN=$P($P(PHARM,",",2)," "),PHARMMI=$P($P(PHARM,",",2)," ",2)
 D INIT^HLFNC2(HLPROT,.HL)
 D BLDPID^PSOTPHL2(DFN,"",.PSORRDAT,.HL,.ERR)
 S DONE=0
 F PSOHCNT=1:1 D  Q:DONE
 .I '$D(PSORRDAT(PSOHCNT)) S DONE=1 Q
 .S @HLARR@(1)=$G(@HLARR@(1))_PSORRDAT(PSOHCNT)
 ;S @HLARR@(2)="ORC^PF^"_PRXNUM_"~"_REMSITE_"~"_$$GET1^DIQ(4,REMSIEN,60,"E")_"^^^^^^^"_PDATE_"^"_DUZ_"~"_PHARMLN_"~"_PHARMFN_"~"_PHARMMI_"^^^~~~"_LOCSITE_U_PHONE
 S @HLARR@(2)="ORC^PF^"_PRXNUM_"~"_REMSITE_"~"_$$FQDN^PSORWRAP(,REMSIEN)_"^^^^^^^"_PDATE_"^"_DUZ_"~"_PHARMLN_"~"_PHARMFN_"~"_PHARMMI_"^^^~~~"_LOCSITE_U_PHONE
 S @HLARR@(3)="RXO^1^"_QTY_"^^^^^^"_MW_"~~~"_LOCSITE_"^^^"_DSUPP
 S @HLARR@(4)="NTE^1^L^"_REMARKS
 W !!,"Processing partial fill request. Please be patient as it may take a moment"
 W !,"for the host site to respond and generate your label data...",!
 ;S RMSDOM=$$GET1^DIQ(4,REMSIEN,60,"E")
 ;S PSOHLNK=$O(^HLCS(870,"C",REMSIEN,0)) ; get first entry (should only be one but you never know)
 ;S RMSDOM=$$GET1^DIQ(870,PSOHLNK,.03,"E")  ; get domain name
 ;S:$$PROD^XUPROD() RMSDOM="HL7."_RMSDOM   ; prefix domain name
 S RMSDOM=$$FQDN^PSORWRAP(,REMSIEN)
 S DOMOVR=REMSITE_"~"_RMSDOM_"~DNS"
 S HLP("SUBSCRIBER")="^^^^"_DOMOVR
 D DIRECT^HLMA(HLPROT,"GM",1,.HL,"",.HLP)
 I $P(HL,U,2) D  Q
 . W !,"An error was encountered when trying to process the results",!,"from the refill/partial fill request.",!!,$P(HL,U,3)
 . K DIR S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR
 . D CL
 ; clean up variables used
 D READMSG^PSORRX2(.HLDAT,"PR",LOCDRUG)
CL ;
 K PDATE,QTY,DSUPP,PHARM,REMARKS,MW
 K @HLDAT,@HLARR
 Q
 ;
DRUGMTCH(DRGNM,VAPID) ;
 ; returns -1 if a match was found but user said NO
 N LDIEN,MATCH,EXIT,VAPIDSTR,DRL,VAPIEN,VAGENER,FOUND,CHECK,DIC,DRGARY,LDNAME,Y,DRGNM2,VAPSTR,MTCHSTR,DRLCNT
 S CHECK=""
 S VAPIEN=$O(^PSNDF(50.68,"C",VAPID,0))
 I 'VAPIEN Q ""  ; ID from HDR not found - most likely CMOP ID/VA PID mismatch
 S VAPSTR=$$GET1^DIQ(50.68,VAPIEN,2,"E")
 S VAPIDSTR=$$GET1^DIQ(50.68,VAPIEN,.01,"E")
 W !!,"Remote site drug name: "_DRGNM
 I $D(^PSDRUG("B",DRGNM)) S LDIEN=$O(^PSDRUG("B",DRGNM,0))
 I $D(LDIEN) D
 .S LDNAME=$$GET1^DIQ(50,LDIEN,.01,"E")
 .W !,"Matching Drug Found for Dispensing: "_LDNAME
 .S CHECK=$$DIR
 I $D(LDIEN),'CHECK Q -1  ; match was found but user said NO
 I $D(LDIEN) Q LDIEN
 S VAGENER=$$GET1^DIQ(50.68,VAPIEN,.05,"I")
 ; loop through AND index to find drugs associated with this va generic product.
 S FOUND=0
 S (DRL,DRLCNT)=0 F  S DRL=$O(^PSDRUG("AND",VAGENER,DRL)) Q:'DRL!(FOUND)  D
 .S MTCHSTR=$$GET1^DIQ(50,DRL,901,"E")
 .I VAPSTR]"" Q:MTCHSTR'=VAPSTR
 .S DRGARY(DRL)="",DRLCNT=DRLCNT+1
 ; only one match found.
 I DRLCNT=1 S LDIEN=$O(DRGARY(0))
 I 'DRLCNT W !!,"No local match could be found for "_DRGNM_".",! K DIR S DIR(0)="FO",DIR("A")="Press RETURN to continue" D ^DIR Q -1
 I $D(LDIEN) D
 .S LDNAME=$$GET1^DIQ(50,LDIEN,.01,"E")
 .W !,"Matching Drug Found for Dispensing: "_LDNAME
 .S CHECK=$$DIR()
 I $D(LDIEN),'CHECK Q -1  ; match was found but user said NO
 I $D(LDIEN) Q LDIEN
 ; list the items that match strength
 S (MATCH,EXIT)=0
 N PSODRGL,PSODRGLI,PSODRGL0,PSODRGID,PSODRGC S DIR(0)=""
 F PSODRGLI=0:0 S PSODRGLI=$O(DRGARY(PSODRGLI)) Q:'PSODRGLI  D
 .S PSODRGL0=$G(^PSDRUG(PSODRGLI,0)),PSODRGID=$G(^PSDRUG(PSODRGLI,"I"))
 .Q:$TR(PSODRGL0,"^")=""  S PSODRGC=$G(PSODRGC)+1
 .S DIR(0)=DIR(0)_$S(DIR(0)]"":";",1:"")
 .S DIR(0)=DIR(0)_$G(PSODRGC)_":"_PSODRGLI_"  "_$E($P(PSODRGL0,"^"),1,30)_"  "_$J($P(PSODRGL0,"^",2),7)_"  "_$S(PSODRGID:$E(PSODRGID,4,5)_"-"_$E(PSODRGID,6,7)_"-"_$E(PSODRGID,2,3)_"  ",1:"")_$P(PSODRGL0,"^",10)
 .S DIR("L",PSODRGC)=PSODRGC_".  "_PSODRGLI_"  "_$E($P(PSODRGL0,"^"),1,30)_"  "_$J($P(PSODRGL0,"^",2),7)_"  "_$S(PSODRGID:$E(PSODRGID,4,5)_"-"_$E(PSODRGID,6,7)_"-"_$E(PSODRGID,2,3)_"  ",1:"")_$P(PSODRGL0,"^",10)
 S DIR(0)="SO^"_DIR(0),DIR("L")=""  ;1:$G(PSODRGC)"
 S DIR("A")="Select matching local drug"
 D ^DIR K DIR
 I +Y<1!($D(DUOUT))!($D(DTOUT)) S Y=-1  ;*519
 I Y=-1 Q Y
 S LDIEN=+Y(0)
 I $G(LDIEN) K DIR S DIR(0)="Y",DIR("A")="Would you like to use this drug" D ^DIR I +Y<1!($D(DUOUT))!($D(DTOUT)) Q -1  ;*509 CHECK FOR Y<1 INSTEAD OF Y<0
 Q $G(LDIEN)
 ; TEXT to build prompts
 ;;DIR(0)|DIR(A)|DIR(B)|VARIABLE
PRMPTXT ;
 ;;N^^I $D(X),X>$P(REMDATA,U,2) D EN^DDIOL("QTY CANNOT BE GREATER THAN THE ORIGINAL QTY OF "_$P(REMDATA,U,2)) K X|Enter Quantity||QTY
 ;;N|DAYS SUPPLY||DSUPP
 ;;P^200:QEAMZ|Select PHARMACIST Name|S DEF=$$GET1~DIQ(200,DUZ,.01,"E")|PHARM
 ;;F^0:60|REMARKS||REMARKS
 ;;Q
 Q
DIR() ;
 N DIR,Y
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A",1)="Would you like to use the system matched drug for this"
 S DIR("A")="refill/partial fill"
 D ^DIR
 Q Y
POST ; post init for PSO*7*454
 N LIEN,OPSITE,DOMAIN,VAL
 ; add TCP/IP address for EMI
 ;S DOMAIN=$$GET1^DIQ(4,DUZ(2),60,"E")
 S DOMAIN=$$FQDN^PSORWRAP(,DUZ(2))
 S VAL="PSORRXSEND"
 S LIEN=$$FIND1^DIC(870,,"B",.VAL) Q:'LIEN
 S FDA(870,LIEN_",",.08)=DOMAIN
 S FDA(870,LIEN_",",400.01)="vaaussoalebp2.aac.domain.ext" D FILE^DIE(,"FDA") K FDA
 ; turn off the OneVA Pharmacy flag for all outpatient sites.
 S OPSITE=0 F  S OPSITE=$O(^PS(59,OPSITE)) Q:'OPSITE  D
 .S FDA(59,OPSITE_",",3001)="" D FILE^DIE(,"FDA") K FDA
 Q
