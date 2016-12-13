IBTRH8 ;ALB/JWS - HCSR Worklist - view 278 message in X12 format ;24-AUG-2015
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 Q
EN ; display message in X12 format
 ; IBTRIEN = ien of file 356.22
 ; MSGTYPE = 217 or 215
 ; RR = 0 for request / inquiry, 1 for response
 N X,MSGTYPE,RR,TD,TT,HL1,HL2,ADDR1,ADDR2,ADDR3,REQDATA,SITEIEN
 N NODE0,OMSG,DFN,IEN312,INSNODE0,INSNODE3,IEN3553,IEN36,GNUM,PREL
 N NODE2,NODE4,NODE5,NODE6,NODE7,NODE8,NODE9,NODE10,NODE17,NODE18,NODE19
 N REQCAT,CERT,INPAT,EVNT,HL1,HL2,PAYID,PAYER,PNODE0,IDTYPE,RELINFO
 N REQIEN,RMSH10,HLECH,HLFS,HLQ
 K ^TMP($J,"IBTRH8")
 S SITEIEN=$P($$SITE^VASITE(),U) I SITEIEN'>0 D ERROR Q
 S NODE0=$G(^IBT(356.22,IBTRIEN,0)) I NODE0="" D ERROR Q
 I $P(NODE0,U,12)="" D ERROR Q
 S MSGTYPE=+$P(NODE0,"^",20),RR=0
 I MSGTYPE=2 D  I +OMSG=0 D ERROR Q
 . S RR=1
 . S OMSG=$P(NODE0,U,13)
 . I OMSG D
 .. S REQIEN=IBTRIEN,IBTRIEN=OMSG
 .. S NODE0=$G(^IBT(356.22,OMSG,0))
 .. S MSGTYPE=+$P(NODE0,U,20),RR=0,RMSH10=$P(NODE0,"^",12)
 . Q
 S DFN=+$P(NODE0,U,2)
 I DFN'>0 D ERROR Q
 S IEN312=+$P(NODE0,U,3)
 I IEN312'>0 D ERROR Q
 S INSNODE0=$G(^DPT(DFN,.312,IEN312,0)) ; 0-node in file 2.312
 S INSNODE3=$G(^DPT(DFN,.312,IEN312,3)) ; 3-node in file 2.312
 S IEN3553=+$P(INSNODE0,U,18) ; file 355.3 ien
 S IEN36=+$P(INSNODE0,U)
 I IEN36'>0 D ERROR Q
 S GNUM=$S(IEN3553>0:$$GET1^DIQ(355.3,IEN3553_",",.04),1:"") ; group number
 S PREL=$P($G(^DPT(DFN,.312,IEN312,4)),U,3) ; pat. relationship to insured
 S NODE2=$G(^IBT(356.22,IBTRIEN,2))
 S NODE4=$G(^IBT(356.22,IBTRIEN,4))
 S NODE5=$G(^IBT(356.22,IBTRIEN,5))
 S NODE6=$G(^IBT(356.22,IBTRIEN,6))
 S NODE7=$G(^IBT(356.22,IBTRIEN,7))
 S NODE8=$G(^IBT(356.22,IBTRIEN,8))
 S NODE9=$G(^IBT(356.22,IBTRIEN,9))
 S NODE10=$G(^IBT(356.22,IBTRIEN,10))
 S NODE17=$G(^IBT(356.22,IBTRIEN,17))
 S NODE18=$G(^IBT(356.22,IBTRIEN,18))
 S NODE19=$G(^IBT(356.22,IBTRIEN,19))
 S HLECH="^~\&",HLFS="|",HLQ=""""
 S X="ST*278*0001*005010X"_$S(MSGTYPE=0:217,1:215) D SAVE(X)
 S REQCAT=$$GET1^DIQ(356.001,+$P(NODE2,U)_",",.01) ; request category
 S CERT=$$GET1^DIQ(356.002,+$P(NODE2,U,2)_",",.01) ; certification type code
 S INPAT=$S($P(NODE0,U,4)="I":1,1:0) ; 1 if inpatient, 0 if outpatient
 ; determine event reason code
 I 'MSGTYPE D
 . I REQCAT'="IN" S EVNT="13" Q  ; request category = "HS" (Health Services), "AR" (Admission), or "SC" (Specialty Care) -> event code = 13 (Request)
 . I CERT=3 S EVNT="01" Q  ; request category = "IN" (Individual) and certification type = 3 (Cancel) -> event code = 01 (Cancel)
 . S EVNT=36 ; request category = "IN" (Individual) and certification type '= 3 (other than Cancel) -> event code = 36 (Authority To Deduct)
 . Q
 I MSGTYPE=1 S EVNT=28 ; 28 for 215 message
 I RR=1 S EVNT=11 ; 11 for response messages
 S X=$P(NODE0,U,15),(TD,TT)=""
 I X'="" D H^%DTC I %H D YX^%DTC S TD=$S($E(X)=3:20,1:19)_$E(X,2,7),Y=$P(NODE0,U,15) D DD^%DT S TT=$TR($P(Y,"@",2),":","")
 S X="BHT*0007*"_EVNT_"*"_$S(RR=1:$G(RMSH10),1:$P(NODE0,U,12))_"*"_TD_"*"_TT_$S(EVNT=36:"*RU",1:"") D SAVE(X)
 S HL1=$G(HL1)+1
 S X="HL*"_HL1_"**20*1" D SAVE(X)
 I RR=1 D AAA^IBTRH8A("2000A")
 S PAYID=""
 S PAYER=+$$GET1^DIQ(36,IEN36_",",3.1,"I") ; file 365.12 ien
 I PAYER'>0 D ERROR Q
 S PNODE0=$G(^IBE(365.12,PAYER,0)),IDTYPE="PI"
 S PAYID=$P(PNODE0,U,2) ; VA national id
 ; if no VA national id, try to get CMS national id
 I PAYID="" S PAYID=$P(PNODE0,U,3),IDTYPE="XV"
 ; if still no id, bail out
 I PAYID="" D ERROR Q
 S RELINFO=$P(NODE2,U,16)  ;UM09 Release of Information Code
 ; get HPID, relies on patch IB*2.0*519
 ; S $P(TMP,HLECH,3)=$$HPD^IBCNHUT1(IEN36)
 ; 
 S X="NM1*X3*2*"_$$GET1^DIQ(36,IEN36_",",.01)_"*****"_IDTYPE_"*"_PAYID D SAVE(X)
 I RR=1 D PERR,AAA^IBTRH8A("2010A")
 ; HL - Requester Level Loop 2000B
 S HL2=HL1,HL1=HL1+1
 S X="HL*"_HL1_"*"_HL2_"*21*1" D SAVE(X)
 S REQDATA=$$PRVDATA^IBTRHLO2(SITEIEN,4)
 I $TR(REQDATA,U)="" D ERROR Q
 S X="NM1*FA*2*"_$P(REQDATA,U)_"*****XX*"_$P(REQDATA,U,7) D SAVE(X)
 I RR=1 D AAA^IBTRH8A("2010B")
 S ADDR1=$P(REQDATA,U,2,3),ADDR2=$P(REQDATA,U,4,6)
 S ADDR3=$P($$HLADDR^HLFNC(ADDR1,ADDR2),U,1,5)
 I 'RR S X="N3*"_$P(ADDR3,"^") S:$P(ADDR3,"^",2)'="" X=X_"*"_$P(ADDR3,"^",2) D SAVE(X)
 I 'RR S X="N4*"_$P(ADDR3,"^",3)_"*"_$P(ADDR3,"^",4)_"*"_$P(ADDR3,"^",5) D SAVE(X)
 I 'RR D PER
 D PRV
 S HL2=HL1,HL1=HL1+1
 S X="HL*"_HL1_"*"_HL2_"*22*1" D SAVE(X)
 D NM1
 I PREL'="18" D
 .S HL2=HL1,HL1=HL1+1
 .S X="HL*"_HL1_"*"_HL2_"*23*1" D SAVE(X)
 .D NM12010D
 .Q
 S HL2=HL1,HL1=HL1+1
 S X="HL*"_HL1_"*"_HL2_"*EV*"_$S($O(^IBT(356.22,IBTRIEN,16,0)):1,1:0) D SAVE(X)  ; if line level procedure code sub HL seg, otherwise 0
 D EVENT
 D DISPLAY^IBTRH8A
 I $D(REQIEN) S IBTRIEN=REQIEN
 Q
 ;
PER ; create PER segment in loop 2010B
 N CTD,COMMSTR,IEN200,NAME,NODE19,QUAL,TMP,VALUE,Z
 S IEN200=+$P(NODE0,U,11) I IEN200'>0 Q
 S NAME=$$GET1^DIQ(200,IEN200_",",.01) I NAME="" Q
 S NODE19=$G(^IBT(356.22,IBTRIEN,19))
 S COMMSTR="" F Z="20^2^19.01","21^3^19.02","22^4^19.03" D
 . S QUAL=$P(NODE19,U,$P(Z,U,2)) I QUAL="" Q
 . S QUAL=$$EXTERNAL^DILFD(356.22,$P(Z,U,3),,QUAL)
 . S VALUE=$G(^IBT(356.22,IBTRIEN,$P(Z,U))) I VALUE="" Q
 . I "^FX^HP^TE^WP^"[(U_QUAL_U) S VALUE=$$NOPUNCT^IBCEF(VALUE,1) ; strip punctuation if phone #
 . S $P(TMP,U)=QUAL,$P(TMP,U,2)=VALUE
 . S COMMSTR=$S(COMMSTR="":TMP,1:COMMSTR_U_TMP)
 . Q
 S X="PER*IC*"_NAME_"*"_$P(COMMSTR,U)_"*"_$P(COMMSTR,U,2)
 I $P(COMMSTR,U,3)'="" S X=X_"*"_$P(COMMSTR,U,3)_"*"_$P(COMMSTR,U,4)
 I $P(COMMSTR,U,5)'="" S X=X_"*"_$P(COMMSTR,U,5)_"*"_$P(COMMSTR,U,6)
 D SAVE(X)
 Q
 ;
PRV ; create PRV segment (X12: PRV, 2010B)
 N PRD,TXNM
 S TXNM=$P($$TAXORG^XUSTAX(SITEIEN),U) I TXNM="" Q
 S X="PRV*PE*PXC*"_TXNM D SAVE(X)
 Q
 ;
NM1 ; create NM1 segment (X12: NM1, 2010C)
 N ADDR1,ADDR2,GT1,SID1,SIDSTR,NAME
 S SID1=$P(INSNODE0,U,2) I SID1=""  Q
 S NAME=$P(INSNODE0,U,17) I NAME="" Q
 ;;S SID2=GNUM ; secondary subscriber id is a group number
 S NAME=$$HLNAME^HLFNC(NAME)
 S X="NM1*IL*1*"_$P(NAME,"^")_"*"_$P(NAME,"^",2)_"*"_$P(NAME,"^",3)_"**"_$P(NAME,"^",4)_"*MI*"_SID1 D SAVE(X)
 I GNUM'="" S X="REF*6P*"_GNUM D SAVE(X)
 I 'MSGTYPE,$P(INSNODE3,U,6)'="",$P(INSNODE3,U,8)'="" D
 . S ADDR1=$P(INSNODE3,U,6,7),ADDR2=$P(INSNODE3,U,8,10)
 . S ADDR3=$$HLADDR^HLFNC(ADDR1,ADDR2) ; subscriber address
 . S X="N3*"_$P(ADDR3,"^") S:$P(ADDR3,"^",2)'="" X=X_"*"_$P(ADDR3,"^",2) D SAVE(X)
 . S X="N4*"_$P(ADDR3,"^",3)_"*"_$P(ADDR3,"^",4)_"*"_$P(ADDR3,"^",5) D SAVE(X)
 . Q
 I RR D AAA^IBTRH8A("2010C")
 S X="DMG*D8*"_$$HLDATE^HLFNC($P(INSNODE3,U)) ; subscriber dob
 I 'MSGTYPE S X=X_"*"_$P(INSNODE3,U,12) ; subscriber sex
 D SAVE(X)
 I MSGTYPE Q
 I PREL'="18" S PREL=$S(PREL="01":"01",PREL=19:19,1:"G8") ; relationship to insured
 S X="INS*Y*18" D SAVE(X)
 Q
 ;
NM12010D ; create NM1 segment, loop 2010D
 N IDSTR,PID,TMP,VAFSTR
 I GNUM="" Q
 S VAFSTR="7,8,11,"
 S PID=$$EN^VAFHLPID(DFN,VAFSTR)
 S TMP=$P(PID,"|",12)
 I $P(TMP,U,2)="""""" S $P(TMP,U,2)="",$P(PID,"|",12)=TMP
 S X="NM1*QC*1*"_$P($P(PID,"|",6),"^")_"*"_$P($P(PID,"|",6),"^",2) S:$P($P(PID,"|",6),"^",3)'="" X=X_"*"_$P($P(PID,"|",6),"^",3) D SAVE(X)
 S X="REF*EJ*"_GNUM D SAVE(X)
 I 'MSGTYPE!RR D
 . S X="N3*"_$P(TMP,"^") S:$P(TMP,"^",2)'="" X=X_"*"_$P(TMP,"^",2) D SAVE(X)
 . S X="N4*"_$P(TMP,"^",3)_"*"_$P(TMP,"^",4)_"*"_$P(TMP,"^",5) D SAVE(X)
 . Q
 I RR D AAA^IBTRH8A("2010D")
 S X="DMG*D8*"_$P(PID,"|",8) S:'MSGTYPE X=X_"*"_$P(PID,"|",9) D SAVE(X)
 I MSGTYPE Q
 S X="INS*N*"_PREL D SAVE(X)
 Q
 ;
EVENT ; 2000E loop
 ; create G2R.PRB segment (G2R segment group)
 N PRB,Z,TOT
 I RR D AAA^IBTRH8A("2000E")
 I CERT="" Q  ; missing certification type code
 S X="UM*"_REQCAT_"*"_CERT_"*"_$$GET1^DIQ(365.013,+$P(NODE2,U,3)_",",.01)
 I $P(NODE2,U,4)'="" S X=X_"*"_$S($P(NODE2,U,4)="A":($P(NODE2,U,6)_$P(NODE2,U,7)),1:$$GET1^DIQ(353.1,+$P(NODE2,U,5)_",",.01))_":"_$P(NODE2,U,4)
 E  D  I MSGTYPE Q
 . I MSGTYPE D SAVE(X) Q
 . S X=X_"*"
 S X=X_"*"_$P(NODE2,U,8)_":"_$P(NODE2,U,9)_":"_$P(NODE2,U,10)_":"_$$GET1^DIQ(5,+$P(NODE2,U,11)_",",1)
 S Z=$$GET1^DIQ(779.004,+$P(NODE2,U,12)_",",.01) I Z'="",Z'="USA" S X=X_":"_Z
 S X=X_"*"_$P(NODE2,U,13)_"*"_$$GET1^DIQ(356.003,+$P(NODE2,U,14)_",",.01)_"*"_$$GET1^DIQ(356.004,+$P(NODE2,U,15)_",",.01)_"*"_$P(NODE2,U,16)_"*"_$$GET1^DIQ(356.005,+$P(NODE2,U,17)_",",.01) D SAVE(X)
 I RR D HCR
 D REF
 D DTP
 D HI
 ; for 217 request only
 I 'MSGTYPE D 
 . D HSD,CRC
 . I $TR(NODE18,U)'="" D CR1
 . D CR2,CR5^IBTRH8A,CR6^IBTRH8A,PWK,MSG
 D NM1^IBTRH8A
 ;
 I '$O(^IBT(356.22,IBTRIEN,16,0)) Q
 S HL2=HL1,HL1=HL1+1
 S X="HL*"_HL1_"*"_HL2_"*SS*0" D SAVE(X)
 D DETAIL^IBTRH8A
 S TOT=$G(^TMP($J,"IBTRH8"))+1
 S X="SE*"_TOT_"*0001" D SAVE(X)
 Q
 ;
REF ; REF segment
 I $P(NODE17,U)'="" S X="REF*BB*"_$P(NODE17,U) D SAVE(X) Q
 I $P(NODE17,U,2)'="" S X="REF*NT*"_$P(NODE17,U,2) D SAVE(X) Q
 Q
 ;
DTP ; create DTP segments
 N DATA,Z,Z1
 S Z=$P(NODE0,U,7) I Z'="" D
 . S Z1="AAH" I INPAT,REQCAT="AR" S Z1="435"
 . S DATA(Z1)=$S(Z["-":$$HLDATE^HLFNC($P($P(Z,"-"),"."))_"-"_$$HLDATE^HLFNC($P($P(Z,"-",2),".")),1:$$HLDATE^HLFNC($P(Z,"."))) ; admission / appointment date
 . Q
 S Z=$P(NODE2,U,18) I Z'="" S DATA("439")=$$HLDATE^HLFNC($P(Z,".")) ; accident date
 I 'MSGTYPE D
 . S Z=$P(NODE2,U,19) I Z'="" S DATA("484")=$$HLDATE^HLFNC($P(Z,".")) ; last menstrual period date
 . S Z=$P(NODE2,U,20) I Z'="" S DATA("ABC")=$$HLDATE^HLFNC(Z) ; estimated DOB
 . S Z=$P(NODE2,U,21) I Z'="" S DATA("431")=$$HLDATE^HLFNC(Z) ; illness date
 . Q
 ; the following date is for "Admission Review" request category only
 I INPAT,REQCAT="AR" S Z=$P(NODE2,U,22) S:Z'="" DATA("096")=$$HLDATE^HLFNC($P(Z,".")) ; discharge date
 S Z="" F  S Z=$O(DATA(Z)) Q:Z=""  D
 . S X="DTP*"_Z_"*D8*"_DATA(Z) D SAVE(X)
 . Q
 Q 
 ;
HI ; create HI segments
 N DG1,DIAG,NODE0,SEQ,Z
 S (SEQ,Z)=0 F  S Z=$O(^IBT(356.22,IBTRIEN,3,Z)) Q:Z'=+Z  D
 . S NODE0=$G(^IBT(356.22,IBTRIEN,3,Z,0)) I NODE0="" Q  ; 0-node of sub-file 356.223
 . S SEQ=SEQ+1 I SEQ>12 Q  ; only allow up to 12 DG1 segments
 . I MSGTYPE,SEQ>1 Q  ; only allow 1 DG1 segment in 215 message
 . S DIAG=$TR($$EXTERNAL^DILFD(356.223,.02,,$P(NODE0,U,2)),".") I DIAG="" Q  ; invalid diagnosis code
 . S DG1(SEQ)="*"_$$GET1^DIQ(356.006,+$P(NODE0,U)_",",.01)_":"_DIAG I 'MSGTYPE,$P(NODE0,U,3)'="" S DG1(SEQ)=DG1(SEQ)_":D8:"_$$HLDATE^HLFNC($P(NODE0,U,3))
 . ;S DG1="DG1"_HLFS_SEQ_HLFS_HLFS_$$ENCHL7^IBCNEHLQ(DIAG)_HLFS_HLFS_$S('MSGTYPE:$$HLDATE^HLFNC($P(NODE0,U,3)),1:"")_HLFS_"W"
 . Q
 I '$O(DG1("")) Q
 S X="HI"
 S Z=0 F  S Z=$O(DG1(Z)) Q:Z=""  S X=X_DG1(Z)
 D SAVE(X)
 Q
 ;
HSD ; create HSD segment
 N QUAL,VALUE,HSD,I
 S QUAL=$$GET1^DIQ(365.016,+$P(NODE4,U)_",",.01)
 S VALUE=$P(NODE4,U,2)
 I QUAL'="",VALUE'="" S HSD(1)=QUAL,HSD(2)=VALUE  ;ZHS.2=4.01, ZHS.3=4.02 
 S QUAL=$P(NODE4,U,3)
 S VALUE=$P(NODE4,U,4)
 I QUAL'="",VALUE'="" S HSD(3)=QUAL  ;ZHS.4=4.03
 I VALUE'="" S HSD(4)=VALUE  ;ZHS.5=4.04
 S QUAL=$$GET1^DIQ(365.015,+$P(NODE4,U,5)_",",.01)
 S VALUE=$P(NODE4,U,6)
 I QUAL'="",VALUE'="" S HSD(5)=QUAL,HSD(6)=VALUE ;ZHS.6=4.05, ZHS.7=4.06
 I +$P(NODE4,U,7) S HSD(7)=$$GET1^DIQ(365.025,+$P(NODE4,U,7)_",",.01) ;ZHS.8=4.07
 I +$P(NODE4,U,8) S HSD(8)=$$GET1^DIQ(356.007,+$P(NODE4,U,8)_",",.01) ;ZHS.9=4.08
 I '$D(HSD) Q
 S X="HSD" F I=1:1:8 S X=X_"*"_$G(HSD(I))
 D SAVE(X)
 Q
 ;
CRC ; create CRC and CL1 segments in loop 2000E
 N PC,Z
 I +$P(NODE4,U,10) D  ; at least one ambulance cert. condition exists
 . S X="CRC*07*"_$P(NODE4,U,9)
 . F PC=10:1:14 S Z=+$P(NODE4,U,PC) I Z S X=X_"*"_$$GET1^DIQ(356.008,Z_",",.01)
 . D SAVE(X)
 . Q
 I +$P(NODE5,U,2) D  ; at least one chiropractic cert. condition exists
 . S X="CRC*08*"_$P(NODE5,U)
 . F PC=2:1:6 S Z=+$P(NODE5,U,PC) I Z S X=X_"*"_$$GET1^DIQ(356.008,Z_",",.01)
 . D SAVE(X)
 . Q
 I +$P(NODE5,U,8) D  ; at least one DME cert. condition exists
 . S X="CRC*09*"_$P(NODE5,U,7)
 . F PC=8:1:12 S Z=+$P(NODE5,U,PC) I Z S X=X_"*"_$$GET1^DIQ(356.008,Z_",",.01)
 . D SAVE(X)
 . Q
 I +$P(NODE5,U,14) D  ; at least one oxygen cert. condition exists
 . S X="CRC*11*"_$P(NODE5,U,13)
 . F PC=14:1:18 S Z=+$P(NODE5,U,PC) I Z S X=X_"*"_$$GET1^DIQ(356.008,Z_",",.01)
 . D SAVE(X)
 . Q
 I +$P(NODE6,U,2) D  ; at least one functional limit cert. condition exists
 . S X="CRC*75*"_$P(NODE6,U)
 . F PC=2:1:6 S Z=+$P(NODE6,U,PC) I Z S X=X_"*"_$$GET1^DIQ(356.008,Z_",",.01)
 . D SAVE(X)
 . Q
 I +$P(NODE6,U,8) D  ; at least one activities cert. condition exists
 . S X="CRC*76*"_$P(NODE6,U,7)
 . F PC=8:1:12 S Z=+$P(NODE6,U,PC) I Z S X=X_"*"_$$GET1^DIQ(356.008,Z_",",.01)
 . D SAVE(X)
 . Q
 I +$P(NODE6,U,14) D  ; at least one mental status cert. condition exists
 . S X="CRC*77*"_$P(NODE6,U,13)
 . F PC=14:1:18 S Z=+$P(NODE6,U,PC) I Z S X=X_"*"_$$GET1^DIQ(356.008,Z_",",.01)
 . D SAVE(X)
 . Q
 I INPAT,$TR($P(NODE7,U,1,4),U)'="" D  ; inpatient, admission data exists
 . S X="CL1*"_$P(NODE7,U)
 . S Z=+$P(NODE7,U,2) I Z S $P(X,"*",3)=$$GET1^DIQ(356.009,Z_",",.01)
 . S Z=+$P(NODE7,U,3) I Z S $P(X,"*",4)=$$GET1^DIQ(356.01,Z_",",.01)
 . S Z=+$P(NODE7,U,4) I Z S $P(X,"*",5)=$$GET1^DIQ(356.011,Z_",",.01)
 . D SAVE(X)
 . Q
 Q
 ;
CR1 ; create CR1 segment
 N Z,Z1
 S X="CR1*"
 S $P(X,"*",5)=$P(NODE18,U,4)
 S $P(X,"*",10)=$P(NODE18,U,9)
 S $P(X,"*",11)=$P(NODE18,U,10)
 S Z=$P(NODE18,U,2) I Z'="" S $P(X,"*",2)=$P(NODE18,U),$P(X,"*",3)=Z
 S Z=$P(NODE18,U,6) I Z'="" S $P(X,"*",6)=$P(NODE18,U,5),$P(X,"*",7)=Z
 S $P(X,"*",4)=$P(NODE18,U,3)
 D SAVE(X)
 Q
 ;
CR2 ; create CR2 segment
 N TXNUM,TXCNT,Z
 S TXNUM=$P(NODE7,U,5) I TXNUM="" Q  ; missing treatment series number
 S TXCNT=$P(NODE7,U,6) I TXCNT="" Q  ; missing treatment count
 S TXNUM=+TXNUM,TXCNT=+TXCNT
 S X="CR2*"_TXNUM_"*"_TXCNT
 S Z=+$P(NODE7,U,7) I Z>0 S $P(X,"*",4)=$$GET1^DIQ(356.012,Z_",",.01)
 S Z=+$P(NODE7,U,8) I Z>0 S $P(X,"*",5)=$$GET1^DIQ(356.012,Z_",",.01)
 S $P(X,"*",9)=$P(NODE7,U,9)
 I $P(NODE7,U,10)'="" S $P(X,"*",10)=$P(NODE7,U,10)
 S $P(X,"*",13)=$P(NODE7,U,13)
 S $P(X,"*",11)=$P(NODE7,U,11)
 S $P(X,"*",12)=$P(NODE7,U,12)
 D SAVE(X)
 Q
 ;
PWK ; create the PWK segment loop 2000E
 N NODE0,SEQ,Z,Z1
 S SEQ=0,Z="" F  S Z=$O(^IBT(356.22,IBTRIEN,11,"B",Z)) Q:Z=""  D
 . S Z1=+$O(^IBT(356.22,IBTRIEN,11,"B",Z,"")) I 'Z1 Q
 . S NODE0=$G(^IBT(356.22,IBTRIEN,11,Z1,0)) I NODE0="" Q  ; 0-node of sub-file 356.2211
 . S SEQ=SEQ+1 I SEQ>10 Q
 . S X="PWK*"
 . S $P(X,"*",2)=$$GET1^DIQ(356.018,+$P(NODE0,U)_",",.01)
 . I $P(NODE0,U,3)'="" S $P(X,"*",7)=$P(NODE0,U,3),$P(X,"*",6)="AC"
 . S $P(X,"*",8)=$P(NODE0,U,4)
 . S $P(X,"*",3)=$P(NODE0,U,2)
 . D SAVE(X)
 . Q
 Q
 ;
MSG ; create the MSG segment loop 2000E
 N MSG,NTE
 S MSG=$$WP2STR^IBTRHLO2(356.22,12,IBTRIEN_",",264)
 I MSG="" Q
 S X="MSG*"_MSG
 D SAVE(X)
 Q
 ;
SAVE(X) ;
 N XCT
 S (^TMP($J,"IBTRH8"),XCT)=$G(^TMP($J,"IBTRH8"))+1
 S ^TMP($J,"IBTRH8",XCT)=X
 Q
 ;
ERROR ;
 D CLEAR^VALM1
 I $P(NODE0,"^",12)="" W !!,"Unable to display the 278 request. The request for this entry has not been sent.",!!
 I $P(NODE0,"^",12)'="" W !!,"INSUFFICIENT DATA TO DISPLAY X12 TRANSACTION.",!!
 D PAUSE^VALM1
 S VALMBCK="R"
 D RE^VALM4
 I $D(REQIEN) S IBTRIEN=REQIEN
 Q 
 ;
PERR ; PER segment for response loop 2010A
 N X
 S X="PER*IC"
 S $P(X,"*",3)=$P(NODE19,"^")
 S $P(X,"*",4)=$P(NODE19,"^",2)
 S $P(X,"*",5)=$$NOPUNCT^IBCEF($P($G(^IBT(356.22,IBTRIEN,20)),"^"),1)
 S $P(X,"*",6)=$P(NODE19,"^",3)
 S $P(X,"*",7)=$$NOPUNCT^IBCEF($P($G(^IBT(356.22,IBTRIEN,21)),"^"),1)
 S $P(X,"*",8)=$P(NODE19,"^",4)
 S $P(X,"*",9)=$$NOPUNCT^IBCEF($P($G(^IBT(356.22,IBTRIEN,22)),"^"),1)
 D SAVE(X)
 Q
 ;
HCR ; HCR segment for response loop 2000E
 N X,NODE103
 I '$D(^IBT(356.22,IBTRIEN,103)) Q
 S NODE103=$G(^IBT(356.22,IBTRIEN,103))
 S X="HCR*"
 S $P(X,"*",2)=$$GET1^DIQ(356.02,$P(NODE103,"^")_",",.01)
 S $P(X,"*",3)=$P(NODE103,"^",2)
 S $P(X,"*",4)=$$GET1^DIQ(356.021,$P(NODE103,"^",3)_",",.01)
 S $P(X,"*",5)=$P(NODE103,"^",4)
 D SAVE(X)
 Q
