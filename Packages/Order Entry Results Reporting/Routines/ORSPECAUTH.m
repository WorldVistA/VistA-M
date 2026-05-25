ORSPECAUTH ;SLC/AGP/GSN - Ordering Special Authorities ;Dec 03, 2025@07:24:59
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
 ; Reference to SETARRAY, $$GETVALUE, $$GETDISPLAYNAME, $$SETVALUE, $$FINDBYCODE, GETSADEF^PXSPECAUTH in ICR #7506
 ; Reference to DECODE, ENCODE^XLFJSON in ICR #6682
 ; Reference to $$SHOWSA^GMPLSPECAUTH in ICR #7586
 ;
 Q
 ;
RETURNPARAMS(RESULT) ;
 S RESULT("specialAuthority","addProbToVisit")=$$GET^XPAR("ALL","OR SPECAUTH ADD PROB TO VISIT")
 S RESULT("specialAuthority","orderUnansweredToValue")=$$GET^XPAR("ALL","OR SPECAUTH UNANSWERD TO VALUE")
 S RESULT("saOnProblems")=$S($$SHOWSA^GMPLSPECAUTH:"true",1:"false")
 I RESULT("saOnProblems")="false" S RESULT("specialAuthority","addProbToVisit")="no"
 Q
 ;
CHECKORDER(ORIFN,ORDA,ORPSO) ;Order checks
 N ACT,OR3,PRIO
 S ORPSO=$G(ORPSO)
 I 'ORIFN!('ORDA) Q 0                                                     ;missing param
 I '$D(^OR(100,ORIFN,0)) Q 0                                              ;bad 0 node
 I $P(^OR(100,ORIFN,0),U,14)'=ORPSO Q 0
 I $P($G(^OR(100,ORIFN,8,ORDA,0)),U,2)'="NW" Q 0                          ;not new
 S OR3=$G(^OR(100,ORIFN,3)),ACT=$P(OR3,U,11)
 I (ACT'=0)&(ACT'=1)&((ACT'=2)&(ACT'="C")) Q 0                            ;not the following (std, edit, renew, copy)
 Q 1
 ;
GETENVIND(RESULTS,ORIEN,CHECKMULT) ;Get SA indicators for this order
 N CNT,NODE,X,Y
 I $D(^OR(100,ORIEN,112)) D GETFROMMULT(.RESULTS,ORIEN) Q  ;if New mult exist use it instead of old fixed fields
 S NODE=$G(^OR(100,ORIEN,5))
 S CNT=0
 F X=1:1:8 S Y=$P(NODE,U,X) I Y S CNT=CNT+1,RESULTS(CNT)=$$OLDSC(X)
 Q
 ;
GETFROMMULT(RESULTS,ORIEN) ;Build SA new mult structure
 N CNT,DISPNAME,EIDX,IFN,NODE,SEQ,SEQMAP,SPECAUTH
 S (CNT,IFN)=0
 F  S IFN=$O(^OR(100,ORIEN,112,IFN)) Q:'IFN  D
 .S NODE=$G(^OR(100,ORIEN,112,IFN,0)) I '$P(NODE,U,2) Q   ;skip answer No SAs
 .S DISPNAME=$$GETDISPLAYNAME^PXSPECAUTH($P(NODE,U))
 .S CNT=CNT+1,RESULTS(CNT)=$TR(DISPNAME,"&","")  ;Remove GUI hotkey symbol for report
 Q
 ;
GETHL7(ORMSG,ORIFN) ;Receive from OP pharm ZSC HL7 order add/update ZSC Segs(s) (old and/or new SA structures)
 ; New mult ZSC array structure example      Old single ZSC fixed fields structure example
 ;    4 pcs  ZSC|1|SC|1                           9 pcs       ZSC|1|1||||||0
 ;           ZSC|2|MST|0
 ;           ZSC|3|AO|1
 N CNT,CODE,FDA,FLD,ERROR,ID,IDNM,IDX,IENS,CURSA,NODE112,VALUE,OLDST,OLDSA,ORSAMSG,QQ,TMPARR,ZSC,ZSCX,ZSEG
 I $G(ORMSG)'="" M ORSAMSG=@ORMSG
 I $G(ORMSG)="" M ORSAMSG=ORMSG
 S ZSC=$$ZSC(.ORSAMSG) Q:'ZSC   ;Quit if No ZSC seg found
 ; Always update SAs to the new mult SA structure in #100.0112, Whether the Old single ZSC array (8 ind) or the New mult ZSC array elements are sent
 I $P(ZSC,U,2)>5 D                                ;If Old SA ZSC string (i.e. more than 5 pcs)
 .S ZSEG=ORSAMSG($P(ZSC,U))
 .S OLDST=$TR($P(ZSEG,"|",2,9),"|","^")
 .F QQ=1:1:8 S VALUE=$P(OLDST,U,QQ),IDNM=$$OLDCODE(QQ),ID=$$FINDBYCODE^PXSPECAUTH(IDNM) D     ;convert old SA fixed piece to new SA .01 ID value file #820
 ..D UPDATE112(ORIFN,ID,VALUE,.TMPARR)
 E  D                                             ;Else New SA mult ZSC strings (4 pcs)
 .S ZSCX=+ZSC-1
 .F  S ZSCX=$O(ORSAMSG(ZSCX)) Q:ZSCX'>0  D  Q:$E(ORSAMSG(ZSCX),1,3)'="ZSC"
 ..S CODE=$P(ORSAMSG(ZSCX),"|",3),VALUE=$P(ORSAMSG(ZSCX),"|",4)
 ..S ID=$$FINDBYCODE^PXSPECAUTH(CODE)
 ..D UPDATE112(ORIFN,ID,VALUE,.TMPARR)
 S FDA(100,ORIFN_",",.01)=$P($G(^OR(100,ORIFN,0)),U)
 F FLD=51:1:58 S FDA(100,ORIFN_",",FLD)="@"
 D UPDATE^DIE("","FDA","","ERROR")
 I $D(ERROR) D SETERROR(.TMPARR,"Error updating order#: "_ORIFN)
 Q
 ;
UPDATE112(OIEN,ID,VAL,TMPARR) ;Add/Update new SA mult file #100.0112
 N ERROR,FDA,IENS
 I ID'>0 S ERROR="Error SA indicator .01 is null " D SETERROR(.TMPARR,"Error updating order#: "_OIEN) Q
 I VAL="" Q  ;skip adding null val SAs
 S IENS="?+"_ID_","_OIEN_",",FDA(100.0112,IENS,.01)=ID,FDA(100.0112,IENS,1)=VAL   ;update existing .01 (ID) or if not there it will add the new ID
 D UPDATE^DIE("","FDA","","ERROR")
 I $D(ERROR) D SETERROR(.TMPARR,"Error updating order#: "_OIEN)
 Q
 ;
SETHL7(ORMSG,START,ORIEN) ;Send to OP pharm New or Old HL7 ZSC structure
 ; AGP  met with Pharmacy they were okay with the HL7 changes, however a project has not been stood up may change when Pharmacy start works on it
 N CDE,CNT,CNT1,EIDX,NODE,OLDSTR,NEWHL7,NEW112,PARRAY,PLACE,SEQ,SEQMAP,SPECAUTH,VALUE
 D SETARRAY^PXSPECAUTH(.SPECAUTH,0) M SEQMAP=SPECAUTH("specialAuthorityTypes")
 S NEWHL7=+$$GET^XPAR("ALL","OR UPDATE PSO ENV INDICATOR"),OLDSTR=""
 I 'NEWHL7 F PLACE=1:1:5 S PARRAY(PLACE)=""  ;build OLD fixed SA array seq
 S NEW112=$P($G(^OR(100,ORIEN,112,0)),U,4)
 ;  When New SA Mult structure use it instead of old node 5 data
 I NEW112 D
 .S SEQ=0,CNT=START,CNT1=0
 .F  S SEQ=$O(SEQMAP(SEQ)) Q:SEQ'>0  D
 ..S EIDX=+$O(^OR(100,ORIEN,112,"B",SEQMAP(SEQ,"id"),"")) I 'EIDX,NEWHL7 Q
 ..S VALUE=$P($G(^OR(100,ORIEN,112,EIDX,0)),U,2) I VALUE="",NEWHL7 Q
 ..I NEWHL7  S CNT=CNT+1,CNT1=CNT1+1,ORMSG(CNT)="ZSC|"_CNT1_"|"_SEQMAP(SEQ,"code")_"|"_VALUE_"|" Q
 ..D SETOLD(.OLDSTR,.SEQMAP,.PARRAY,SEQMAP(SEQ,"code"),VALUE)
 ;  When no New SA Mult structure use old node 5 SA data
 I 'NEW112 D
 .S NODE=$G(^OR(100,ORIEN,5)) I NODE="" Q
 .;  Loop thru New mult SA structure to send old/new OP HL7 SA values
 .S SEQ=0,CNT=START,CNT1=0
 .F  S SEQ=$O(SEQMAP(SEQ)) Q:SEQ'>0  D
 ..S CDE=$G(SEQMAP(SEQ,"code")) S PLACE=$$CODETOOLD(CDE) I PLACE=0 Q
 ..S VALUE=$P(NODE,U,PLACE) I VALUE="",NEWHL7 Q
 ..I NEWHL7  S CNT=CNT+1,CNT1=CNT1+1,ORMSG(CNT)="ZSC|"_CNT1_"|"_SEQMAP(SEQ,"code")_"|"_VALUE_"|" Q
 ..D SETOLD(.OLDSTR,.SEQMAP,.PARRAY,SEQMAP(SEQ,"code"),VALUE)
 ;  use OLDSTR if populated, i.e. OP param not set to use the new ZSC HL7 format
 I OLDSTR]"" D
 .S PLACE=0 F  S PLACE=$O(PARRAY(PLACE)) Q:PLACE'>0  D
 ..I PARRAY(PLACE)="" S $P(OLDSTR,"|",PLACE)=""
 .S CNT=START+1,ORMSG(CNT)="ZSC|"_OLDSTR
 Q
 ;
SETOLD(OLDSTR,SEQMAP,PARRAY,CDE,VALUE) ;
 N PLACE
 S PLACE=$$CODETOOLD(CDE) Q:PLACE=0
 S $P(OLDSTR,"|",PLACE)=VALUE,PARRAY(PLACE)=1
 Q
 ;
FINDSABYCODE(ARR,CODE) ;Find IDX for SA CODE in an ORSA type array
 N RESULT,IDX
 S (RESULT,IDX)=0
 F  S IDX=$O(ARR(IDX)) Q:'IDX  D  Q:RESULT
 .I $G(ARR(IDX,"code"))=CODE S RESULT=IDX
 Q RESULT
 ;
FINDTMPIDX(ARR,CODE,OCNT) ;Find IDX for SA CODE in an TMPARR type array
 N RESULT,IDX
 S (RESULT,IDX)=0
 F  S IDX=$O(ARR("orders",OCNT,"specialAuthority",IDX)) Q:'IDX  D  Q:RESULT
 .I $G(ARR("orders",OCNT,"specialAuthority",IDX,"code"))=CODE S RESULT=IDX
 Q RESULT
 ;
SAFORORDER(TMPARR,HASIND,SEQMAP,OCNT,ORIFN,ORSA) ;Merge an orders base JSON SA seqmap type array with SA tmparr per Codes (index to index)
 N DEF,EIDX,MATCH,NODE,OLDVALUES,SA,SAIDX,SAORX,SATMPX,SEQ,X,CODE,Y
 ;  IF new mult SA structure has SA data use it and Quit
 I $P($G(^OR(100,ORIFN,112,0)),U,4) D  Q
 .S SEQ=0
 .F  S SEQ=$O(SEQMAP(SEQ)) Q:'SEQ  D
 ..S EIDX=+$O(^OR(100,ORIFN,112,"B",SEQMAP(SEQ,"id"),""))
 ..S SAORX=$$FINDSABYCODE(.ORSA,$G(SEQMAP(SEQ,"code"))),SATMPX=$$FINDTMPIDX(.TMPARR,$G(SEQMAP(SEQ,"code")),OCNT)  ;build Code xref arrays
 ..S:SATMPX=0 SATMPX=SAORX
 ..I SAORX=SATMPX M TMPARR("orders",OCNT,"specialAuthority",SAORX)=ORSA(SAORX)
 ..I SAORX'=SATMPX M TMPARR("orders",OCNT,"specialAuthority",SATMPX)=ORSA(SAORX)    ;when no TMPARR SA pre-exists use ORSA from PX init call
 ..S HASIND=1                                                                       ;SA ind info found
 ..I $G(TMPARR("orders",OCNT,"specialAuthority",SATMPX,"visible"))="false" Q        ;if flase, SKIP changing Default setting, when not visible in the first place
 ..I EIDX D      ;update default in Tmp with the value found in the SA multiple
 ...S DEF=$$GETVALUE^PXSPECAUTH($P($G(^OR(100,ORIFN,112,EIDX,0)),U,2))
 ...S TMPARR("orders",OCNT,"specialAuthority",SATMPX,"default")=DEF
 ;  Else Fall thru here, Old SA fixed field structure node 5, if no node 5 then is a New order
 S NODE=$G(^OR(100,ORIFN,5))
 I $L(NODE)>1 D  Q    ;node 5 exists use it and Quit
 .F X=1:1:8 D
 ..S Y=$P(NODE,U,X)
 ..S CODE=$$OLDCODE(X)
 ..S MATCH=0
 ..S SEQ=0 F  S SEQ=$O(SEQMAP(SEQ)) Q:'SEQ!(MATCH=1)  D
 ...I SEQMAP(SEQ,"code")'=CODE Q
 ...S MATCH=1
 ...S SAORX=$$FINDSABYCODE(.ORSA,$G(SEQMAP(SEQ,"code"))),SATMPX=$$FINDTMPIDX(.TMPARR,$G(SEQMAP(SEQ,"code")),OCNT)  ;build Code xref arrays
 ...S:SATMPX=0 SATMPX=SAORX
 ...I SAORX=SATMPX M TMPARR("orders",OCNT,"specialAuthority",SAORX)=ORSA(SAORX)
 ...I SAORX'=SATMPX M TMPARR("orders",OCNT,"specialAuthority",SATMPX)=ORSA(SAORX)   ;Merge ORSA to TMPARR for SA structure
 ...S HASIND=1                                                                      ;SA ind info found
 ...I $G(TMPARR("orders",OCNT,"specialAuthority",SATMPX,"visible"))="false" Q       ;if flase, SKIP changng Default setting, when not visible in the first place
 ...S DEF=$$GETVALUE^PXSPECAUTH(Y)
 ...S TMPARR("orders",OCNT,"specialAuthority",SATMPX,"default")=DEF
 ;  Fall thru to New order logic for SA
 S SEQ=0
 F  S SEQ=$O(SEQMAP(SEQ)) Q:'SEQ  D
 .S SAORX=$$FINDSABYCODE(.ORSA,$G(SEQMAP(SEQ,"code"))),SATMPX=$$FINDTMPIDX(.TMPARR,$G(SEQMAP(SEQ,"code")),OCNT)  ;build Code xref arrays
 .S:SATMPX=0 SATMPX=SAORX
 .I SAORX=SATMPX M TMPARR("orders",OCNT,"specialAuthority",SAORX)=ORSA(SAORX)
 .I SAORX'=SATMPX M TMPARR("orders",OCNT,"specialAuthority",SATMPX)=ORSA(SAORX)     ;when no TMPARR SA pre-exists use ORSA from PX init call
 .I $G(TMPARR("orders",OCNT,"specialAuthority",SATMPX,"visible"))="false" Q         ;if flase, SKIP changing Default setting, when not visible in the first place
 Q
 ;Verify change to logic -RPC Called when signing OP Orders
SAFORORDERS(RESULTS,IJSON) ;
 N SAFROMORDER,CNT,CODE,EIDX,ERROR,DFN,HASIND,IDX,INPUTS,LOADSTRUCT
 N OCNT,OR3,ORDA,ORDERS,ORIFN,ORGIFN,ORPSO,ORSA,SA,SEQMAP,TMPARR
 D DECODE^XLFJSON("IJSON","INPUTS","ERROR")
 K ^TMP("ORSPECAUTH INDFORORDER",$J) S RESULTS=$NA(^TMP("ORSPECAUTH INDFORORDER",$J))
 S LOADSTRUCT=$S($G(INPUTS("loadStructure"))="true":1,1:0)
 S DFN=+$G(INPUTS("patientId")) I DFN=0 D SETERROR(.TMPARR,"Patient Id not found.") G SAFORORDERSX
 S TMPARR("patientId")=DFN
 M ORDERS=INPUTS("orders") K INPUTS("orders")
 I '+$G(INPUTS("dateTime")) S INPUTS("dateTime")=$$NOW^XLFDT()
 S SAFROMORDER=+$$GET^XPAR("ALL","OR LOAD SA FROM EXISTING ORDER") ; Location not used for order signing, per Revenue Ops
 K INPUTS("locationId")
 S INPUTS("returnSequenceMap")="true"
 D GETSADEF^PXSPECAUTH(.ORSA,.INPUTS)                                               ;get patients PX version SAs
 M SEQMAP=ORSA("sequenceMap"),SA=ORSA("specialAuthority")
 S ORPSO=+$$FIND1^DIC(9.4,,"MX","PSO")
 ; Loop thru all orders to sign
 S IDX="",OCNT=0 F  S IDX=$O(ORDERS(IDX)) Q:IDX=""  D
 .S ORIFN=+ORDERS(IDX,"orderId"),ORDA=+$P(ORDERS(IDX,"orderId"),";",2)
 .I '$$CHECKORDER(ORIFN,ORDA,ORPSO) Q                                          ;quit if invalidated PSO order
 .S OCNT=OCNT+1
 .I 'SAFROMORDER D  Q                                                                   ;merge PX SA values to TMPARR and quit, Bill Aware rules only
 ..S TMPARR("orders",OCNT,"orderId")=ORIFN_";"_ORDA
 ..M TMPARR("orders",OCNT,"specialAuthority")=ORSA("specialAuthority")
 .; New 33Con signing order SA rules. check for current order SAs
 .S TMPARR("orders",OCNT,"orderId")=ORIFN_";"_ORDA
 .S HASIND=0
 .D SAFORORDER(.TMPARR,.HASIND,.SEQMAP,OCNT,ORIFN,.SA)                              ;check if this order has SAs to merge into TMPARR
 .I HASIND=1 Q   ;Quit, If order did have IND
 .; If no IND, check previous replaced order for IND
 .S OR3=$G(^OR(100,ORIFN,3))
 .S ORGIFN=$P(OR3,U,5)  ;replaced order #
 .I ORGIFN>0 D SAFORORDER(.TMPARR,.HASIND,.SEQMAP,OCNT,ORGIFN,.SA)                  ;check if this prev order has SAs to merge into TMPARR
SAFORORDERSX ;
 I $G(TMPARR("success"))="" S TMPARR("success")="true"
 D ENCODE^XLFJSON("TMPARR","RESULTS","ERROR")
 Q
 ;
SETERROR(RESULTS,ERROR) ;
 S RESULTS("success")="false"
 S RESULTS("error")=ERROR
 Q
 ;
UPDATEORDERSA(RESULTS,IJSON) ;update an Orders SA values new mult
 N CNT,DFN,ERROR,FAIL,FLD,IIDX,INDICATOR,IENS,INPUTS,ORIFN,OIDX,TMPARR,VALUE,FDA
 D DECODE^XLFJSON("IJSON","INPUTS","ERROR")
 K ^TMP("ORSPECAUTH UPDATEINDICATOR",$J) S RESULTS=$NA(^TMP("ORSPECAUTH UPDATEINDICATOR",$J))
 S DFN=+$G(INPUTS("patientId")) I DFN=0 D SETERROR(.TMPARR,"Patient Id not found.") G UPDATEORDERSAX
 S FLD=50
 S OIDX=0,FAIL=0 F  S OIDX=$O(INPUTS("orders",OIDX)) Q:OIDX'>0!(FAIL=1)  D
 .K FDA
 .S ORIFN=+$G(INPUTS("orders",OIDX,"orderId")) Q:ORIFN=""
 .S IIDX=0,CNT=0 F  S IIDX=$O(INPUTS("orders",OIDX,"specialAuthority",IIDX)) Q:IIDX'>0  D
 ..S INDICATOR=+$G(INPUTS("orders",OIDX,"specialAuthority",IIDX,"id")) Q:INDICATOR=0
 ..S VALUE=$G(INPUTS("orders",OIDX,"specialAuthority",IIDX,"value")) S VALUE=$$SETVALUE^PXSPECAUTH(VALUE)
 ..I VALUE="" Q   ;don't update if unanswered
 ..S CNT=CNT+1,FDA(100,ORIFN_",",.01)=ORIFN
 ..S IENS="?+"_CNT_","_ORIFN_",",FDA(100.0112,IENS,.01)=INDICATOR,FDA(100.0112,IENS,1)=VALUE
 ..F FLD=51:1:58 S FDA(100,ORIFN_",",FLD)="@"
 .I '$D(FDA) Q
 .D UPDATE^DIE("","FDA","","ERROR")
 .I $D(ERROR) D SETERROR(.TMPARR,"Error updating order#: "_ORIFN) S FAIL=1 Q
 I FAIL=0 S TMPARR("success")="true"
UPDATEORDERSAX ;
 D ENCODE^XLFJSON("TMPARR","RESULTS","ERROR")
 Q
 ;
OLDSC(J) ; -- Returns name of SC field by piece number
 I '$G(J) Q ""
 I J=1 Q "SERVICE CONNECTED CONDITION"
 I J=2 Q "MILITARY SEXUAL TRAUMA"
 I J=3 Q "AGENT ORANGE EXPOSURE"
 I J=4 Q "IONIZING RADIATION EXPOSURE"
 I J=5 Q "ENVIRONMENTAL CONTAMINANTS"
 I J=6 Q "HEAD OR NECK CANCER"
 I J=7 Q "COMBAT VETERAN"
 I J=8 Q "SHIPBOARD HAZARD AND DEFENSE"
 Q ""
 ;
OLDCODE(J) ; -- Returns code of SC field by piece number
 I '$G(J) Q ""
 I J=1 Q "SC"
 I J=2 Q "MST"
 I J=3 Q "AO"
 I J=4 Q "IR"
 I J=5 Q "EC"
 I J=6 Q "HNC"
 I J=7 Q "CV"
 I J=8 Q "SHAD"
 Q ""
 ;
CODETOOLD(J) ; -- Returns pso old fixed string piece number per CODE.
 I J="SC" Q 1
 I J="MST" Q 2
 I J="AO" Q 3
 I J="IR" Q 4
 I J="EC" Q 5
 I J="HNC" Q 6
 I J="CV" Q 7
 I J="SHAD" Q 8
 Q 0
 ;
ZSC(ORMSG) ;Find the index of the 1st ZSC seg & the number of pieces in the ZSC segment. (New mult ZSCs, including "ZSC", will have 5 pieces and old >5)
 ;return 2 piece string:  1 = arr index of 1st ZSC found
 ;                        2 = number of pieces found in that ZSC seg
 N II,SEG,CNT,Y,PCE S (Y,PCE)="",CNT=0
 ;I $G(ORMSG)'="" D  Q Y_U_PCE
 ;.S II=0 F  S II=$O(@ORMSG@(II)) Q:II'>0  D
 ;..S SEG=$E($G(@ORMSG@(II)),1,3) I SEG'="ZSC" Q
 ;..S CNT=CNT+1 I CNT=1 S Y=II,PCE=$L(@ORMSG@(II),"|")
 S II=0 F  S II=$O(ORMSG(II)) Q:II'>0  D
 .S SEG=$E($G(ORMSG(II)),1,3) I SEG'="ZSC" Q
 .S CNT=CNT+1 I CNT=1 S Y=II,PCE=$L(ORMSG(II),"|")
 Q Y_U_PCE
 ;
