PSOERXU3 ;ALB/BWF - eRx utilities ; 5/26/2017 9:57am
 ;;7.0;OUTPATIENT PHARMACY;**508,591**;DEC 1997;Build 2
 ;
 Q
 ; PSO*508 - Added MEDDIS, RRREQ, and RRRES linetags.
 ; ERXIEN - IEN FROM 52.49
 ; DTYPE - R for REQUESTED, or D for dispensed drugs
MEDDIS(ERXIEN,DTYPE,LINE) ;
 N DRUG,DIEN,QTY,DAYS,WDATE,EFDATE,REFILL,EXDATE,LFDATE,DIRECT,CLQ,USC,PUC,F,IENS,I,LTXT
 N RXIEN,RXNUM,INS,DDAT,PARIEN,OREFILL,DLOOP,DIARY
 N DIRARY
 S F=52.4949
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"****************************MEDICATION DISPENSED****************************")
 S PARIEN=$$RESOLV^PSOERXU2(ERXIEN)
 I PARIEN S RXIEN=$$GET1^DIQ(52.49,PARIEN,.13,"I")
 I $G(RXIEN) S OREFILL=$$GET1^DIQ(52,RXIEN,9,"E")
 S I=0 F  S I=$O(^PS(52.49,ERXIEN,49,I)) Q:'I  D
 .S IENS=I_","_ERXIEN_","
 .Q:$$GET1^DIQ(F,IENS,.02,"I")'=DTYPE
 .D GETS^DIQ(F,IENS,"**","IE","DDAT")
 .S DRUG=$G(DDAT(F,IENS,.01,"E"))
 .S DIEN=$G(DDAT(F,IENS,.03,"I"))
 .S QTY=$G(DDAT(F,IENS,.04,"E"))
 .S DAYS=$G(DDAT(F,IENS,.05,"E"))
 .S REFILL=$G(DDAT(F,IENS,.06,"E"))
 .S DIRECT=$G(DDAT(F,IENS,1,"E"))
 .S WDATE=$G(DDAT(F,IENS,2.1,"E"))
 .S LFDATE=$G(DDAT(F,IENS,2.2,"E"))
 .S EXDATE=$G(DDAT(F,IENS,2.3,"E"))
 .S EFDATE=$G(DDAT(F,IENS,2.4,"E"))
 .S CLQ=$G(DDAT(F,IENS,2.5,"E"))
 .S USC=$G(DDAT(F,IENS,2.6,"E"))
 .S PUC=$G(DDAT(F,IENS,2.7,"E"))
 .; if there is an RX ien, reset the refills to that value - may need to adjust other fields as well
 .I $G(RXIEN) S REFILL=$$GET1^DIQ(52,RXIEN,9,"E")
 .S LINE=LINE+1 D SET^VALM10(LINE,"Vista Drug: "_DRUG)
 .S LINE=LINE+1
 .D ADDITEM^PSOERX1A(.LTXT,"Vista Qty: ",$G(QTY),1,25)
 .D ADDITEM^PSOERX1A(.LTXT,"Vista Refills: ",$G(REFILL),27,18)
 .D ADDITEM^PSOERX1A(.LTXT,"Vista Days Supply: ",$G(DAYS),54,22)
 .D SET^VALM10(LINE,LTXT) S LTXT=""
 .S DIRECT="Vista Sig: "_DIRECT
 .D TXT2ARY^PSOERXD1(.DIRARY,DIRECT," ",75)
 .S DLOOP=0 F  S DLOOP=$O(DIARY(DLOOP)) Q:'DLOOP  D
 ..S LINE=LINE+1
 ..D SET^VALM10(LINE,DIRECT)
 I $G(RXIEN) D
 .S RXNUM=$$GET1^DIQ(52,RXIEN,.01,"E")
 .S INS=0 F  S INS=$O(^PSRX(RXIEN,"INS1",INS)) Q:'INS  D
 ..S LINE=LINE+1 D SET^VALM10(LINE,"Pat Inst: "_$$GET1^DIQ(52.0115,INS_","_RXIEN_",",.01,"E"))
 I '$L($G(RXNUM)) S RXNUM="Unable to resolve."
 S LINE=LINE+1 D SET^VALM10(LINE,"VA Rx#: "_$G(RXNUM))
 Q
 ; refill request information
RRREQ(ERXIEN,LINE) ;
 N REQBY,REQDTTM,REFREQ,COMM,COMMARY,I,COMMBY,COMMDTTM,CTXT,REQIEN
 ; - the next line of code will actually reference the related message for retrieval of the refill request information
 ; - check that this is correct and test.
 S REQIEN=ERXIEN
 I $$GET1^DIQ(52.49,ERXIEN,.08,"I")="RE" S REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 S REQBY=$$GET1^DIQ(52.49,REQIEN,51.1,"E")
 S REFREQ=$$GET1^DIQ(52.49,REQIEN,51.2,"E")
 S REQDTTM=$$GET1^DIQ(52.49,REQIEN,.03,"E")
 S COMM=$$GET1^DIQ(52.49,REQIEN,50,"E")
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"************************REFILL REQUEST INFORMATION**************************")
 S LINE=LINE+1 D SET^VALM10(LINE,"Requested By: "_REQBY)
 S LINE=LINE+1 D SET^VALM10(LINE,"Request Date/Time: "_REQDTTM)
 S LINE=LINE+1 D SET^VALM10(LINE,"# of Refills Requested: "_REFREQ)
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S COMM="Refill Request Comments: "_COMM
 D TXT2ARY^PSOERXD1(.COMMARY,COMM," ",80)
 S I=0 F  S I=$O(COMMARY(I)) Q:'I  D
 .S CTXT=$G(COMMARY(I))
 .S LINE=LINE+1 D SET^VALM10(LINE,CTXT)
 S COMMBY=$$GET1^DIQ(52.49,REQIEN,50.1,"E")
 S COMMDTTM=$$GET1^DIQ(52.49,REQIEN,50.2,"E")
 S LINE=LINE+1 D SET^VALM10(LINE,"Comments By: "_COMMBY)
 S LINE=LINE+1 D SET^VALM10(LINE,"Comments Date/Time: "_COMMDTTM)
 Q
MSGHIS(ERXIEN,LINE) ;
 N ERXREF,RELERX,ERXRES,I,ERXHID,FOUND,REQID,RESID,MTYPE
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 ; refill request
 I MTYPE="RR"!(MTYPE="CA") S REQIEN=ERXIEN,RESIEN=$$GETRESP^PSOERXU2(ERXIEN)
 ; refill response
 I MTYPE="RE"!(MTYPE="CN") S RESIEN=ERXIEN,REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 I MTYPE="IE" S RESIEN=ERXIEN,REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 S RESID=$$GET1^DIQ(52.49,RESIEN,.01,"E")
 S REQID=$$GET1^DIQ(52.49,REQIEN,.01,"E")
 S RELERX=$$GET1^DIQ(52.49,REQIEN,.14)
 S FOUND=0
 ; BWF - consider allowing the loop to continue to the end and find all responses (can there be multiple?)
 S I=ERXIEN F  S I=$O(^PS(52.49,ERXIEN,201,"B",I)) Q:'I!(FOUND)  D
 .I $$GET1^DIQ(52.49,I,.08,"E")="RE",$$GET1^DIQ(52.49,I,.14,"E")=$$GET1^DIQ(52.49,ERXIEN,.01,"E") S ERXRES=$$GET1^DIQ(52.49,I,.14,"E"),FOUND=1
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"*****************************MESSAGE HISTORY********************************")
 S LINE=LINE+1 D SET^VALM10(LINE,"Request Reference #: "_$G(REQID))
 S LINE=LINE+1 D SET^VALM10(LINE,"New eRx Reference #: "_RELERX)
 S LINE=LINE+1 D SET^VALM10(LINE,"Response eRx Reference #: "_$G(RESID))
 Q
 ; refill response information
RRRES(ERXIEN,LINE) ;
 N RESVAL,RESNOTE,I,RESCODE,RESDTTM,RESDESC,ERXDAT,IENS,RESIEN,RECODE,RESTEXT,MTYPE,REQIEN,CODEIEN
 N STR1ARY,STR2ARY,J,STR1,STR2,DELTA,FN,COMM,COMMARY,COMMBY,COMMDTTM,ERESCODE
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I MTYPE="RE"!(MTYPE="CN") S RESIEN=ERXIEN,REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 I MTYPE="RR"!(MTYPE="CA") S REQIEN=ERXIEN,RESIEN=$$GETRESP^PSOERXU2(ERXIEN) Q:'RESIEN
 S IENS=RESIEN_","
 D GETS^DIQ(52.49,RESIEN,".03;.13;52.1;52.2;52.3","IE","ERXDAT")
 S RESVAL=$G(ERXDAT(52.49,IENS,52.1,"E"))
 S RESCODE=$G(ERXDAT(52.49,IENS,52.1,"I"))
 S RESNOTE=$G(ERXDAT(52.49,IENS,52.2,"E"))
 S RESDTTM=$G(ERXDAT(52.49,IENS,.03,"E"))
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"************************REFILL RESPONSE INFORMATION**************************")
 S LINE=LINE+1 D SET^VALM10(LINE,RESVAL),CNTRL^VALM10(LINE,1,$L(RESVAL),IORVON,IORVOFF)
 S LINE=LINE+1 D SET^VALM10(LINE,"Response Date/Time: "_RESDTTM)
 S LINE=LINE+1 D SET^VALM10(LINE,"Note: "_RESNOTE)
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S COMM=$$GET1^DIQ(52.49,ERXIEN,50,"E")
 S COMM="Refill Response Comments: "_COMM
 D TXT2ARY^PSOERXD1(.COMMARY,COMM," ",80)
 S I=0 F  S I=$O(COMMARY(I)) Q:'I  D
 .S CTXT=$G(COMMARY(I))
 .S LINE=LINE+1 D SET^VALM10(LINE,CTXT)
 S COMMBY=$$GET1^DIQ(52.49,ERXIEN,50.1,"E")
 S COMMDTTM=$$GET1^DIQ(52.49,ERXIEN,50.2,"E")
 S LINE=LINE+1 D SET^VALM10(LINE,"Comments By: "_COMMBY)
 S LINE=LINE+1 D SET^VALM10(LINE,"Comments Date/Time: "_COMMDTTM)
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S I=0 F  S I=$O(^PS(52.49,ERXIEN,55,I)) Q:'I  D 
 .S ERESCODE=$$GET1^DIQ(52.4955,I_","_IENS,.01,"E")
 .S CODEIEN=$$GET1^DIQ(52.4955,I_","_IENS,.01,"I")
 .S RESDESC=$$GET1^DIQ(52.45,CODEIEN,.02,"E")
 .S RESTEXT=RESVAL_" reason code: "_ERESCODE
 .S LINE=LINE+1 D SET^VALM10(LINE,RESTEXT),CNTRL^VALM10(LINE,1,$L(RESTEXT),IORVON,IORVOFF)
 .S LINE=LINE+1 D SET^VALM10(LINE,"Code Description: "_RESDESC)
 .S LINE=LINE+1 D SET^VALM10(LINE,"")
 I RESCODE="AWC"!(RESCODE="A") D
 .D RRDELTA^PSOERXU2(.DELTA,REQIEN,RESIEN) Q:'$D(DELTA)
 .S LINE=LINE+1 D SET^VALM10(LINE,"********************************CHANGED ITEMS***********************************")
 .S I=0 F  S I=$O(DELTA(I)) Q:'I  D
 ..S FN="" F  S FN=$O(DELTA(I,FN)) Q:FN=""  D
 ...K STR1ARY,STR2ARY
 ...S LINE=LINE+1 D SET^VALM10(LINE,"Field: "_FN),CNTRL^VALM10(LINE,1,$L(FN)+7,IORVON,IORVOFF)
 ...S STR1="Refill Request Value  : "_$P(DELTA(I,FN),U)
 ...D TXT2ARY^PSOERXD1(.STR1ARY,STR1," ",78)
 ...S STR2="Refill Response Value : "_$P(DELTA(I,FN),U,2)
 ...D TXT2ARY^PSOERXD1(.STR2ARY,STR2," ",78)
 ...S J=0 F  S J=$O(STR1ARY(J)) Q:'J  D
 ....S LINE=LINE+1 D SET^VALM10(LINE,"  "_$G(STR1ARY(J)))
 ...S J=0 F  S J=$O(STR2ARY(J)) Q:'J  D
 ....S LINE=LINE+1 D SET^VALM10(LINE,"  "_$G(STR2ARY(J)))
 ...S LINE=LINE+1 D SET^VALM10(LINE,"")
 Q
ERRDISP(ERXIEN,LINE) ;
 N ECODE,ETEXT,EDECODE,EDICODE,I,ERRDTTM
 S ECODE=$$GET1^DIQ(52.49,ERXIEN,60.1,"E")
 S ETEXT=$$GET1^DIQ(52.49,ERXIEN,60,"E")
 S ERRDTTM=$$GET1^DIQ(52.49,ERXIEN,.03,"E")
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"*****************************ERROR DETAILS********************************")
 S LINE=LINE+1 D SET^VALM10(LINE,"Error Date/Time: "_ERRDTTM)
 S LINE=LINE+1 D SET^VALM10(LINE,"Code: "_ECODE)
 S LINE=LINE+1 D SET^VALM10(LINE,"Details: "_ETEXT)
 I $D(^PS(52.49,ERXIEN,61)) D
 .S LINE=LINE+1 D SET^VALM10(LINE,"")
 .S LINE=LINE+1 D SET^VALM10(LINE,"Description Codes")
 .S LINE=LINE+1 D SET^VALM10(LINE,"=================")
 .S LINE=LINE+1 D SET^VALM10(LINE,"")
 S I=0 F  S I=$O(^PS(52.49,ERXIEN,61,I)) Q:'I  D
 .S EDECODE=$$GET1^DIQ(52.4961,I_","_ERXIEN_",",.01,"E")
 .S EDICODE=$$GET1^DIQ(52.4961,I_","_ERXIEN_",",.01,"I")
 .S LINE=LINE+1 D SET^VALM10(LINE,EDICODE_" - "_EDECODE)
 Q
 ; displays processing errors
PROCERR(ERXIEN,LINE) ;
 N ERRIEN,ERRIENS,ERRTXT,ERRTARY
 ; quit if there are no processing errors
 Q:'$D(^PS(52.49,ERXIEN,100,"C","PX"))
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"****************************PROCESSING ERRORS*******************************")
 S ERRIEN=0 F  S ERRIEN=$O(^PS(52.49,ERXIEN,100,ERRIEN)) Q:'ERRIEN  D
 .S ERRIENS=ERRIEN_","_ERXIEN_","
 .S ERRTXT=$$GET1^DIQ(52.49101,ERRIENS,1,"E")
 .S ERRTXT="Error Details: "_ERRTXT
 .D TXT2ARY^PSOERXD1(.ERRTARY,ERRTXT," ",78)
 .S I=0 F  S I=$O(ERRTARY(I)) Q:'I  D
 ..S LINE=LINE+1 D SET^VALM10(LINE,$G(ERRTARY(I)))
 .K ERRTXT,ERRTARY
 Q
 ; automatically DC a prescription if a denied, new prescription to follow is recieved
AUTODC(ERXIEN) ;
 N PSODFN,RXIEN,PSOLST,ORN,PSOOPT,PSOSITE,PSODIV,PSOSYS,PSODIV,PSOSYS,NERXIEN,REQIEN,ERRSEQ,VALMSG,ERXIENS,RXSTAT,PSTAT
 Q:'ERXIEN
 S ERXIENS=ERXIEN_","
 ; get the RXIEN
 S REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 I REQIEN S NERXIEN=$$RESOLV^PSOERXU2(REQIEN)
 Q:'$P(NERXIEN,U)
 S RXIEN=$$GET1^DIQ(52.49,NERXIEN,.13,"I") Q:RXIEN=""
 ;S PENDIEN=$$GET1^DIQ(52.49,NERXIEN,.1,"E")
 ; if already DC'd, do not try to DC again
 S RXSTAT=$$GET1^DIQ(52,RXIEN,100,"I")
 I (RXSTAT=12)!(RXSTAT=14)!(RXSTAT=15) D  Q
 .S ERRSEQ=$$ERRSEQ^PSOERXU1(ERXIEN) Q:'ERRSEQ
 .S VALMSG="eRx auto-discontinue failed. Prescription is already discontinued."
 .D FILERR^PSOERXU1(ERXIENS,ERRSEQ,"PX","V",$G(VALMSG))
 .I REQIEN,$$GET1^DIQ(52.49,REQIEN,1,"E")'="RRR" D UPDSTAT^PSOERXU1(REQIEN,"RRR",$G(VALMSG))
 .D UPDSTAT^PSOERXU1(ERXIEN,"RXF",$G(VALMSG))
 S PSOSITE=$$GET1^DIQ(52,RXIEN,20,"I")
 S PSOSYS=$G(^PS(59.7,1,40.1)) Q:PSOSYS=""
 ; FUTURE ENHANCEMENT/CONSIDERATION- SET PSODIV - PSODIV IS 0 in the test account. need to determine what it is set to.
 S PSODFN=$$GET1^DIQ(52,RXIEN,2,"I") Q:'PSODFN
 ; ORN is set to 1 since we are only building one item into the list. this makes the dc function use PSOLST(ORN)
 ; or PSOLST(1)
 S PSOLST(1)=52_U_RXIEN_U_$$GET1^DIQ(52,RXIEN,100,"E")
 S ORN=1
 ; PSODIV, PSOSITE, AND PSOSYS are used by LMNO^PSOCAN and DIV^PSOCAN - consider setting these if possible 
 ; PSOOPT is checked against a value of 3. find out if we need to set this to a certain value before calling psocan3
 S PSOOPT=0
 D OERR^PSOCAN3(NERXIEN)
 S PSTAT=$$GET1^DIQ(52,RXIEN,100,"I")
 I PSTAT<12!(PSTAT>15) D  Q
 .I '$L($G(VALMSG)) S VALMSG="eRx auto-discontinue failed."
 .D UPDSTAT^PSOERXU1(ERXIEN,"RXF",$G(VALMSG))
 .I REQIEN,$$GET1^DIQ(52.49,REQIEN,.08,"I")'="RRR" D UPDSTAT^PSOERXU1(REQIEN,"RRR",$G(VALMSG))
 .S ERRSEQ=$$ERRSEQ^PSOERXU1(ERXIEN) Q:'ERRSEQ
 .D FILERR^PSOERXU1(ERXIENS,ERRSEQ,"PX","V",$G(VALMSG))
 D UPDSTAT^PSOERXU1(ERXIEN,"RXD")
 I REQIEN,$$GET1^DIQ(52.49,REQIEN,.08,"I")="RR" D UPDSTAT^PSOERXU1(REQIEN,"RRP")
 Q
 ; screen out options that do not apply to refill request or refill response
RRRESCR(ERXIEN,OPT) ;
 N MTYPE,REFREQ,REFRES,OK,DELTAS
 S OK=1
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I MTYPE="RR"!(MTYPE="CA")!(MTYPE="CN") S OK=0 Q OK
 ; if this is a refill response, and we are screening the provider action
 I MTYPE="RE" D  Q OK
 .; if opt is not passed, this is PSO ERX VALIDATE PATIENT
 .I '$D(OPT) S OK=0 Q
 .I $$GET1^DIQ(52.49,ERXIEN,52.1,"I")["D" S OK=0 Q
 .I "RXP,RXC,RXF"[$$GET1^DIQ(52.49,ERXIEN,1,"E") S OK=0 Q
 .S REFRES=ERXIEN,REFREQ=$$RESOLV^PSOERXU2(ERXIEN)
 .I 'REFREQ!('REFRES) S OK=0 Q
 .D RRDELTA^PSOERXU2(.DELTAS,REFREQ,REFRES)
 .I OPT="PROVIDER",$D(DELTAS(52.49,"EXTERNAL PROVIDER")),'$$GET1^DIQ(52.49,ERXIEN,.13,"I") S OK=1
 .; if there were changes to the provider, user will need to revalidate and accept
 .; only unlock if there were deltas on the provider and the provider has been validated on this message
 .I OPT="ACCEPT",'$D(DELTAS(52.49,"EXTERNAL PROVIDER")) S OK=0 Q
 .I OPT="ACCEPT",$D(DELTAS(52.49,"EXTERNAL PROVIDER")),$$GET1^DIQ(52.49,ERXIEN,1.3,"I"),'$$GET1^DIQ(52.49,ERXIEN,.13,"I") S OK=1
 .; if changes are in the drug segment only, no validations or other pharmacist actions needed
 .I OPT="DRUG" S OK=0
 I MTYPE="RE",OPT="DRUG" S OK=0 Q OK
 ;I "RERR"[$$GET1^DIQ(52.49,ERXIEN,.08,"I") Q 0
 Q OK
 ;
 ;Process refill response into pending outpatient orders
PREFRES(PSOIEN,PSOHY,PSOEXCNT,PSOEXMS,PSODAT) ;
 N REQIEN,ORXIEN,PROVIEN,VADRG,PRMVAL,DMVAL,PMVAL,RXIEN,RESTYPE,DELTA,PSOIENS
 S PSOIENS=PSOIEN_","
 ; first check all 3 validations on the refill response
 S RESTYPE=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 S REQIEN=$$RESOLV^PSOERXU2(PSOIEN) I REQIEN S ORXIEN=$$RESOLV^PSOERXU2(REQIEN)
 I '$G(ORXIEN) S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Could not resolve original eRx. Cannot process response." Q
 S RXIEN=$$GET1^DIQ(52.49,ORXIEN,.13,"I") I 'RXIEN S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Could not resolve original eRx. Cannot process response." Q
 ; for approved response types, rebuild PSOHY and quit, using original Rx for all fields except written date and # of refills
 I RESTYPE="A" D PSOHY(.PSOHY,PSOIEN,ORXIEN,RXIEN) Q
 ; process 'approved with changes' response types
 ; FUTURE CONSIDERATION - if the patient on the response is not the same as the patient on the original Rx, we need to quit and log an error
 ;I $$GET1^DIQ(52.49,PSOIEN,.04,"I")'=$$GET1^DIQ(52.49,ORXIEN,.04,"I") S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="External Patient mismatch. Cannot process response." Q
 ; if this refill response has any validations/linkages, use them. Otherwise, use the validations/linkages from the original (new) rx.
 D RRDELTA^PSOERXU2(.DELTA,REQIEN,PSOIEN)
 S PROVIEN=""
 I $D(DELTA(52.49,"EXTERNAL PROVIDER")) D
 .S PROVIEN=$G(PSODAT(F,PSOIENS,2.3,"I")) ; response message provider IEN
 .I 'PROVIEN S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Provider not linked. Cannot process renewal request." Q
 .; if the provider or drug has been linked, then a change has occured in one of those segments, so they must be validated
 .S PRMVAL=$G(PSODAT(F,PSOIENS,1.3,"I")) I 'PRMVAL S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Provider not validated. Cannot process renewal request." Q
 Q:$O(PSOEXMS(0))
 D PSOHY(.PSOHY,PSOIEN,ORXIEN,RXIEN,PROVIEN) Q
 Q
 ; ERXIEN - refill response IEN from 52.49
 ; ORXIEN - newRx IEN from 52.49
 ; RXIEN - prescription entry from file #52
 ; PROVOVR - provider override, when approved with changes included a change to the provider
PSOHY(PSOHY,ERXIEN,ORXIEN,RXIEN,PROVOVR) ;
 N RXDAT,ERXRFLS,ERXWDATE,LOC,ERXNUM,RXIENS,VAROUT,PROVIEN,EFFDT,VAOI,VADRUG,VAREF,PATIEN,VAPRIOR,ORDERTYP,VADAYS,VQTY
 N WRITDT,SLOOP,SCNT,SLOOP2
 S RXIENS=RXIEN_","
 S ERXNUM=$$GET1^DIQ(52.49,ERXIEN,.01,"E")
 D GETS^DIQ(52,RXIEN,"**","IE","RXDAT")
 S LOC=$G(RXDAT(52,RXIENS,5,"I"))
 S VAROUT=$G(RXDAT(52,RXIENS,11,"I"))
 S PROVIEN=$S($G(PROVOVR):PROVOVR,1:$G(RXDAT(52,RXIENS,4,"I")))
 ; effective date CANNOT be null.. make sure it is set to something. written date is the first fall back, then todays date
 S EFFDT=$$GET1^DIQ(52.49,ERXIEN,6.3,"I") I 'EFFDT S EFFDT=$$GET1^DIQ(52.49,ERXIEN,5.9,"I")
 I 'EFFDT S EFFDT=DT
 S VAOI=$G(RXDAT(52,RXIENS,39.2,"I"))
 S VQTY=$G(RXDAT(52,RXIENS,7,"E"))
 S VADRUG=$G(RXDAT(52,RXIENS,6,"I"))
 ; always decrement 1 from # of refills, because refills is actually total # of fills.
 S VAREF=$$GET1^DIQ(52.49,ERXIEN,5.6,"E")
 I VAREF>0 S VAREF=VAREF-1
 S PATIEN=$G(RXDAT(52,RXIENS,2,"I"))
 ; for now, set priority to routine
 S VAPRIOR="R"
 S VADAYS=$G(RXDAT(52,RXIENS,8,"E"))
 S WRITDT=$$GET1^DIQ(52.49,ERXIEN,5.9,"I")
 S ORDERTYP="RNW"
 S PSOHY("PREVORD")=RXIEN
 S PSOHY("LOC")=LOC,PSOHY("CHNUM")=$G(ERXNUM)
 S PSOHY("PICK")=VAROUT,PSOHY("ENTER")=PROVIEN
 S PSOHY("PROV")=PROVIEN,PSOHY("SDT")=EFFDT
 S PSOHY("ITEM")=VAOI,PSOHY("DRUG")=VADRUG
 S PSOHY("QTY")=VQTY,PSOHY("REF")=VAREF
 ; DFN cannot be newed/killed here because it needs to exist for the subsequent call.
 S (PSOHY("PAT"),DFN)=PATIEN,PSOHY("OCC")=ORDERTYP
 ; login date will always be the written date. if there is no written date by chance, use the received date
 ;S PSOHY("EDT")=$S(WRITDT'="":$P(WRITDT,"."),1:$P($$GET1^DIQ(52.49,PSOIEN,.03,"I"),"."))
 S PSOHY("EDT")=DT,PSOHY("PRIOR")=VAPRIOR
 ; ALWAYS PSO as the external application
 S PSOHY("EXAPP")="PHARMACY"
 S PSOHY("DAYS")=VADAYS
 ; sig from eRx - not needed for rewewal - leave logic here as it may be needed for change response
 ;S (SLOOP,SCNT)=0 F  S SLOOP=$O(^PS(52.49,PSOIEN,"SIG",SLOOP)) Q:'SLOOP  D
 ;.S SIGDAT=$G(^PS(52.49,PSOIEN,"SIG",SLOOP,0))
 ;.S SCNT=SCNT+1,PSOHY("SIG",SCNT)=SIGDAT
 ;S SLOOP2=0 F  S SLOOP2=$O(PINARY(SLOOP2)) Q:'SLOOP2  D
 ;.S SCNT=SCNT+1,PSOHY("SIG",SCNT)=$G(PINARY(SLOOP2))
 Q
