PSOVEXR1 ;BIRM/KML - PHARMACY TELEPHONE REFILLS - CONTINUED ; 06/07/18 08:47am
 ;;7.0;OUTPATIENT PHARMACY;**653**;Dec 1997;Build 14
 ;
PSOBLD ; This will transfer entries from the vendor daily telephone refill requests global when the pharmacy audio refills option is accessed.
 ;VEXHRX(19080,PSOSITE,"PSODFN-PSORXIEN")=PSORDT_"^"_PSOSTAT_"^"_PSOP3_"^"_PSOP4_"^"_PSOORF_"^"_PSORSLT_"^"_PSOUSER_"^"_PSOPRF
 ;each time the option is accessed it will add new RXs to the class I ^PS(52.444 file.
 ;below is a breakdown of the vendor ^VEXHRX(19080 global contents. 
 ;PSOSITE= Outpatient site number of refill request i.e. 442 for cheyenne VAMC 
 ;PSODFN=patient dfn from file #2
 ;PSORXIEN=the ien of the prescription file. Not the prescription #. the prescription number is actually piece one of the PSRX global 
 ;PSORDT=the date processed needs to also be set back into vexhrx for clean up.
 ;PSOSTAT=status of "NOT FILLED"
 ;PSOP3=PIECE NOT USED
 ;PSOP4=PIECE NOT USED
 ;PSOORF=ORDER RENEW FLAG - SET OF CODES 'N' for NoN Renewable or 'U' unsigned orders allowed and 'I' Incomplete because Unsigned orders not allowed.
 ;PSORSLT=RENEW PROCESSING RESULT - ORAREN SET OF CODES '0' is processing problem., '1' for OK, '2' for user stopped, '3' not from primary care provider. '5' provider on order terminated no one to send order to.
 ;PSOUSER=IEN OF NEW PERSON file (#200). User that processed the order, i.e. Auto refills could be  USER,AUDIOCARE
 ;PSOPRF=PROVIDER RENEW FLAG - 'P' FOR restricts renewals to THE PATIENTS PRIMARY CARE PROVIDER; 'A' FOR ANY PROVIDER CAN RENEW;
 N PSOORF,PSODFN,PSODFNRX,PSOGET,PSOPRF,PSORDT,PSORSLT,PSOUSER,PSOSITE,PSOSITID,PSOXCNT,PSOXPTRN
 K FDA,PSOERR
 S (PSOORF,PSOPRF,PSORSLT,PSORDT,PSOSTAT,PSOUSER)=""
 K ^XTMP("PSOVEXRX",$J)
 L +^XTMP("PSOVEXRX"):5 I '$T W !,"Process Telephone Refills is not available.  Please try again later." S QUIT=1 Q
 M ^XTMP("PSOVEXRX",$J)=^VEXHRX(19080)   ; populate XTMP with AUDIOCARE vendor array data for further processing
 S PSOSITE=0 F  S PSOSITE=$O(^XTMP("PSOVEXRX",$J,PSOSITE)) Q:'PSOSITE  D
 . S PSODFNRX=0 F  S PSODFNRX=$O(^XTMP("PSOVEXRX",$J,PSOSITE,PSODFNRX)) Q:'PSODFNRX  D
 . . S PSODFN=$P(PSODFNRX,"-",1)
 . . S PSORXIEN=$P(PSODFNRX,"-",2)
 . . S PSOSITID=$P($G(^PSRX(PSORXIEN,2)),U,9)
 . . I PSORXIEN Q:$D(^PS(52.444,"B",PSORXIEN))  ;This checks to see is a prescription ien is already recorded.
 . . S PSOGET=$G(^XTMP("PSOVEXRX",$J,PSOSITE,PSODFNRX))
 . . S:$D(PSOGET) PSORDT=$P(PSOGET,U,1),PSOSTAT=$P(PSOGET,U,2),PSOORF=$P(PSOGET,U,5),PSORSLT=$P(PSOGET,U,6),PSOUSER=$P(PSOGET,U,7),PSOPRF=$P(PSOGET,U,8) Q:$G(PSORDT)
 . . ;QUIT ABOVE If a date is already in piece one of the vendor global means the order has been processed.
 . . ;code below this line adds new RX information to the Class I file 52.444
 . . S FDA(1,52.444,"?+1,",.01)=PSORXIEN
 . . S FDA(1,52.444,"?+1,",1)=PSOSITID
 . . S FDA(1,52.444,"?+1,",2)=PSODFN
 . . I $D(PSOSTAT) S FDA(1,52.444,"?+1,",4)=PSOSTAT
 . . I $D(PSOORF) S FDA(1,52.444,"?+1,",5)=PSOORF
 . . I $D(PSORSLT) S FDA(1,52.444,"?+1,",6)=PSORSLT
 . . I $G(PSOUSER) S FDA(1,52.444,"?+1,",7)=PSOUSER
 . . I $D(PSOPRF) S FDA(1,52.444,"?+1,",8)=PSOPRF
 . . D UPDATE^DIE("","FDA(1)",,"PSOERR")
 . . W:$D(PSOERR) !,"Prescription Internal Record number "_PSORXIEN_" failed to UPDATE file 52.444"
 Q
 ;
CLEAN ;delete completed records from the new file 52.444.
 ;scheduled to run daily
 N PSORDT,PSORXEN
 K ^XTMP("PSOVEXRX",$J)
 L +^XTMP("PSOVEXRX"):5 I '$T Q
 M ^XTMP("PSOVEXRX",$J)=^VEXHRX(19080)   ; populate XTMP with AUDIOCARE vendor array data for further processing
 D SETVEN
 S PSORDT=0 F  S PSORDT=$O(^PS(52.444,"E",PSORDT)) Q:'PSORDT  D
 . S PSORXEN=0 F  S PSORXEN=$O(^PS(52.444,"E",PSORDT,PSORXEN)) Q:'PSORXEN  D
 . . S DIK="^PS(52.444,",DA=PSORXEN D ^DIK K DIK,DA
 K XMY N XMDUZ,XMSUB,XMTEXT,XMT
 S XMDUZ="AUTO,RENEWAL",XMY(DUZ)="",XMY("G.AUTORENEWAL")="",XMSUB="Purge PHARMACY TELEPHONE REFILLS file (#52.444)."
 S XMT(1,0)="Purge of processed entries in the "
 S XMT(2,0)="PHARMACY TELEPHONE REFILLS file (#52.444) completed."
 S XMTEXT="XMT("
 D ^XMD
 Q
 ;
SETVEN ;adds fill date, status and processing result to vendor global to facilitate completion in their process.
 N PSODATA,PSODFN,PSORDT,PSORSLT,PSORGET,PSORX,PSORXEN,PSORXIEN,PSOSITE,PSOSTAT
 S PSOSITE=$$GET1^DIQ(4,$P(^XMB(1,1,"XUS"),"^",17),99,"I") ;ICR 10090 and 10091 retrieve parent institution for the site
 S (PSOCNT,PSORDT)=0 F  S PSORDT=$O(^PS(52.444,"E",PSORDT)) Q:'PSORDT  D
 . S PSORXEN=0 F  S PSORXEN=$O(^PS(52.444,"E",PSORDT,PSORXEN)) Q:'PSORXEN  D
 . . S PSORGET=$G(^PS(52.444,PSORXEN,0))
 . . S PSORXIEN=$P(PSORGET,U,1)
 . . S PSOSTAT=$P(PSORGET,U,5),PSORSLT=$P(PSORGET,U,7)
 . . S IENS=PSORXIEN_","
 . . D GETS^DIQ(52,IENS,".01;2;6","","PSORX")
 . . S PSODFN=$P(PSORGET,U,3)
 . . S PSODATA=""_PSODFN_""_"-"_""_PSORXIEN_""
 . . Q:'$D(^XTMP("PSOVEXRX",$J,PSOSITE,PSODATA))
 . . Q:$P(^XTMP("PSOVEXRX",$J,PSOSITE,PSODATA),"^")
 . . I $G(PRINT) W !,"RX #: "_$P(PSORX(52,IENS,".01"),U,1)_"  RX IEN: "_IENS_" was marked processed in the ^VEXHRX Global. "
 . . S $P(^XTMP("PSOVEXRX",$J,PSOSITE,PSODATA),"^")=PSORDT ;direct set required due to non fileman vendor global for Audiocare maintenance
 . . I $D(PSOSTAT) S $P(^XTMP("PSOVEXRX",$J,PSOSITE,PSODATA),"^",2)=PSOSTAT ;direct set required due to non fileman vendor global Audiocare maintenance
 . . I $G(PSORSLT)'="" S $P(^XTMP("PSOVEXRX",$J,PSOSITE,PSODATA),"^",6)=PSORSLT ;direct set required due to non fileman vendor global Audiocare maintenance
 . . S PSOCNT=PSOCNT+1
 M ^VEXHRX(19080)=^XTMP("PSOVEXRX",$J)
 K ^XTMP("PSOVEXRX",$J)
 L -^XTMP("PSOVEXRX")
 Q
 ;
TILDECHK(PSORXIEN,PSORXEN) ;check for the tilde character (~) in the free text dosage field of the medications instructions
 ; PSORXIEN = input - ien of RX in PRESCRIPTION file (#52)
 ; PSORXEN  = input - ien of RX in PHARMACY TELEPHONE REFILLS file (#52.444)
 ; RSLT = return as output
 N TILDECHK,IENS,I,J,RSLT,CS,DRGIEN
 S IENS=PSORXIEN_","
 D GETS^DIQ(52,IENS,"113*","","TILDECHK")
 S DRGIEN=+$P($G(^PSRX(PSORXIEN,0)),U,6)
 S CS=$$CSDRUG(DRGIEN)
 S RSLT=0
 S I=0 F  S I=$O(TILDECHK(52.0113,I)) Q:I=""  S J=0 F  S J=$O(TILDECHK(52.0113,I,J)) Q:J=""  I TILDECHK(52.0113,I,J)["~" S RSLT=1
 I RSLT D
 . S IENS=PSORXEN_","
 . S FDA(52.444,IENS,3)=DT D FILE^DIE(,"FDA","PSOERR") ; update the entry with the date processed
 S RSLT=RSLT_"^"_CS
 Q RSLT
 ;
CSDRUG(IEN) ;Controlled Substance drug?
 ; Input: IEN - DRUG file (#50) pointer 
 ;Output: $$CS - 1:YES / 0:NO
 N DEA
 Q:'IEN 0
 S DEA=$P($G(^PSDRUG(IEN,0)),U,3)
 I (DEA["2")!(DEA["3")!(DEA["4")!(DEA["5") Q 1
 Q 0
 ;
