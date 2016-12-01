IBRFIHL2 ;TDM/DAL - HL7 Process Incoming EHC_E12 Msgs (cont.) ;02-SEP-2015  ; 2/22/16 4:41pm
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This routine will process the individual segments of the
 ;  incoming EHC_E12 messages.
 ;
 ; * Each of these tags are called by IBRFIHL1.
 ; 
 Q  ; No direct calls
 ;
MSH(IBSEG) ; Process the MSH seg
 N SQ,MSH
 F SQ=7,10 S MSH(SQ)=$G(IBSEG(SQ))
 ;
 S DATA(368,.01)=MSH(10)                    ;Message Control ID
 S DATA(368,.03)=MSH(7)                     ;Message Date/Time
 ;
 S DATA(368,100.03)=$$FMDATE^HLFNC(MSH(7))
 Q
 ;
RFI(IBSEG) ; Process the RFI seg
 N SQ,RFI
 F SQ=1,2 S RFI(SQ)=$G(IBSEG(SQ+1))
 ;
 S DATA(368,.02)=RFI(1)                     ;Transaction Set Date/Time
 S DATA(368,12.01)=RFI(2)                   ;Response Due Date
 ;
 S DATA(368,100.02)=$$FMDATE^HLFNC(RFI(1))
 S DATA(368,112.01)=$$FMDATE^HLFNC(RFI(2))
 Q
 ;
CTD(IBSEG) ; Process the CTD seg
 N SQ,CTD,IEN,REP,CQUAL
 F SQ=1:1:3,5 S CTD(SQ)=$G(IBSEG(SQ+1))
 ;
 F REP=1:1:3 D
 .S CQUAL=$P($P(CTD(5),HLREP,REP),HLCMP)
 .S CQUAL(REP)=$S(CQUAL="PRN":"TE",CQUAL="NET":"EM",CQUAL="BPN":"FX",CQUAL="ORN":"UR",1:CQUAL)
 ;
 I CTD(1)="IC" D                               ;IC=Information Contact
 .S DATA(368,80.04)=$P(CTD(1),HLCMP)                    ;Contact Type
 .S DATA(368,1.03)=$P(CTD(2),HLCMP)                     ;Contact Name
 .S DATA(368,2.01)=CQUAL(1)                             ;Comm Qual 1
 .S DATA(368,3.01)=$P($P(CTD(5),HLREP),HLCMP,8)         ;Comm Number 1
 .S DATA(368,2.02)=CQUAL(2)                             ;Comm Qual 2
 .S DATA(368,4.01)=$P($P(CTD(5),HLREP,2),HLCMP,8)       ;Comm Number 2
 .S DATA(368,2.03)=CQUAL(3)                             ;Comm Qual 3
 .S DATA(368,5.01)=$P($P(CTD(5),HLREP,3),HLCMP,8)       ;Comm Number 3
 .S DATA(368,26.01)=$P($P(CTD(5),HLREP),HLCMP,7)        ;Comm Ext 1
 .S DATA(368,27.01)=$P($P(CTD(5),HLREP,2),HLCMP,7)      ;Comm Ext 2
 .S DATA(368,28.01)=$P($P(CTD(5),HLREP,3),HLCMP,7)      ;Comm Ext 2
 .;
 .S IEN=$$FIND1^DIC(365.021,,,CQUAL(1)) S:IEN>0 DATA(368,102.01)=IEN
 .S IEN=$$FIND1^DIC(365.021,,,CQUAL(2)) S:IEN>0 DATA(368,102.02)=IEN
 .S IEN=$$FIND1^DIC(365.021,,,CQUAL(3)) S:IEN>0 DATA(368,102.03)=IEN
 ;
 I CTD(1)="RE" D                                ;RE=Receiving Contact
 .S DATA(368,80.27)=$P(CTD(1),HLCMP)                    ;Contact Type
 .S DATA(368,15.01)=$P(CTD(2),HLCMP)                    ;Contact Name
 .S DATA(368,20.01)=$P($P(CTD(3),HLCMP),HLSCMP)         ;Addr Line 1
 .S DATA(368,20.02)=$P(CTD(3),HLCMP,2)                  ;Addr Line 2
 .S DATA(368,20.03)=$P(CTD(3),HLCMP,3)                  ;City
 .S DATA(368,20.04)=$P(CTD(3),HLCMP,4)                  ;State
 .S DATA(368,20.05)=$P(CTD(3),HLCMP,5)                  ;Postal/Zip
 .S DATA(368,20.06)=$P(CTD(3),HLCMP,6)                  ;Country
 .S DATA(368,20.07)=$P(CTD(3),HLCMP,8)                  ;Country Sub
 .S DATA(368,16.01)=CQUAL(1)                            ;Comm Qual 1
 .S DATA(368,17.01)=$P($P(CTD(5),HLREP),HLCMP,8)        ;Comm Number 1
 .S DATA(368,16.02)=CQUAL(2)                            ;Comm Qual 2
 .S DATA(368,18.01)=$P($P(CTD(5),HLREP,2),HLCMP,8)      ;Comm Number 2
 .S DATA(368,16.03)=CQUAL(3)                            ;Comm Qual 3
 .S DATA(368,19.01)=$P($P(CTD(5),HLREP,3),HLCMP,8)      ;Comm Number 3
 .S DATA(368,29.01)=$P($P(CTD(5),HLREP),HLCMP,7)        ;Comm Ext 1
 .S DATA(368,30.01)=$P($P(CTD(5),HLREP,2),HLCMP,7)      ;Comm Ext 2
 .S DATA(368,31.01)=$P($P(CTD(5),HLREP,3),HLCMP,7)      ;Comm Ext 3
 .;
 .S IEN=$$FIND1^DIC(365.021,,,CQUAL(1)) S:IEN>0 DATA(368,116.01)=IEN
 .S IEN=$$FIND1^DIC(365.021,,,CQUAL(2)) S:IEN>0 DATA(368,116.02)=IEN
 .S IEN=$$FIND1^DIC(365.021,,,CQUAL(3)) S:IEN>0 DATA(368,116.03)=IEN
 .S IEN=+$$FIND1^DIC(5,,"X",$P(CTD(3),HLCMP,4),"C") S:IEN>0 DATA(368,120.04)=IEN
 .S IEN=$$FIND1^DIC(5.11,,,$E($P(CTD(3),HLCMP,5),1,5),"B") S:IEN>0 DATA(368,120.05)=IEN
 .S IEN=$$FIND1^DIC(779.004,,"X",$P(CTD(3),HLCMP,6),"B") S:IEN>0 DATA(368,120.06)=IEN
 Q
 ;
IVC(IBSEG,DFN,DFNSSN) ;  Process the IVC seg
 ; 
 ; also try to get the patient file pointer from the claim and the patient SSN from that patient
 ; will use those to compare against PID to verify that this is the correct patient
 ;
 N SQ,IVC,IEN,RQUAL
 F SQ=1:1:3,5,7,10,11,20,26,28 S IVC(SQ)=$G(IBSEG(SQ+1))
 ;
 S RQUAL(1.4)=$S($P(IVC(1),HLCMP,4)="GUID":"EJ",1:$P(IVC(1),HLCMP,4))
 S RQUAL(3.4)=$S($P(IVC(3),HLCMP,4)="URI":"D9",1:$P(IVC(3),HLCMP,4))
 ;
 S DATA(368,11.01)=$P(IVC(1),HLCMP)             ;Pt Crtl #
 S DATA(368,80.18)=RQUAL(1.4)                   ;Ref ID Qual
 S DATA(368,11.02)=$P(IVC(2),HLCMP)             ;Payer Claim #
 S DATA(368,80.14)=$P(IVC(2),HLCMP,4)           ;Cur Tran Trace #
 S DATA(368,11.04)=$P(IVC(3),HLCMP)             ;Clearinghouse Trace #
 S DATA(368,80.21)=RQUAL(3.4)                   ;Ref ID Qualifier
 S DATA(368,80.26)=$P(IVC(5),HLCMP)             ;Report Trans Code
 S DATA(368,14.05)=$P(IVC(7),HLCMP)             ;Claim Service Period
 S DATA(368,14.03)=$P($P(IVC(7),HLCMP),"-")     ;Start Date
 S DATA(368,114.03)=$$FMDATE^HLFNC(DATA(368,14.03))  ;Start Date FileMan format
 S DATA(368,14.04)=$P($P(IVC(7),HLCMP),"-",2)   ;End Date
 S DATA(368,114.04)=$$FMDATE^HLFNC(DATA(368,14.04))  ;End Date FileMan format
 I $P(IVC(10),HLCMP)'="" D
 .;S DATA(368,80.08)=$P(IVC(10),HLCMP,3)        ;Provider Entity ID
 .S DATA(368,80.09)=$P(IVC(10),HLCMP,2)         ;Prov Entity Type Qua
 .S DATA(368,7.01)=$P(IVC(10),HLCMP)            ;Provider Name
 I $P(IVC(10),HLCMP)="" D
 .S DATA(368,80.09)=$P(IVC(12),HLCMP,10)
 .S DATA(368,7.01)=$$FMNAME^HLFNC($P(IVC(12),HLCMP,2,5),HL("ECH"))
 S DATA(368,80.01)=$P(IVC(11),HLCMP,10)         ;Payer Entity ID
 S DATA(368,80.02)=$P(IVC(11),HLCMP,2)          ;Payer Entity Type Qua
 S DATA(368,1.01)=$P(IVC(11),HLCMP)             ;Payer Name
 S DATA(368,1.02)=$P(IVC(11),HLCMP,3)           ;Payer ID
 S DATA(368,80.03)=$P(IVC(11),HLCMP,7)          ;ID Code Qualifier
 S DATA(368,25.01)=$P(IVC(20),HLCMP)            ;Reference ID
 S DATA(368,80.19)=$P(IVC(20),HLCMP,5)          ;Reference ID Qual
 S DATA(368,8.01)=$P(IVC(26),HLCMP)             ;Provider ID
 S DATA(368,80.1)=$P(IVC(28),HLCMP)             ;Provider ID Qualifier
 ;
 ;S IEN=$$FIND1^DIC(36,,,$P(IVC(11),HLCMP)) S:IEN>0 DATA(368,101.01)=IEN
 ;
 S IEN=$$FIND1^DIC(399,,"X",$P($P($P(IVC(1),HLCMP),"-",2),HLSCMP)) S:IEN>0 DATA(368,111.01)=IEN ;get and file ptr to 399 BILL/CLAIMS
 ;
 ; If BILL found, get patient (FILE 2) ptr and SSN and insurance company
 I IEN D
 .S DFN=$$GET1^DIQ(399,IEN_",",.02,"I")  ; get patient
 .Q:'+DFN
 .N VADM
 .D DEM^VADPT
 .S DFNSSN=$$NOPUNCT^IBCEF($P(VADM(2),U,2))
 .I $P(IVC(11),HLCMP,3)]"" D
 ..N LOOP,INSURERS,INSCLAIM,INSIEN,IDFIELD,PAYERID
 ..; institutional or professional claim (1=IN2, 0=PRF)
 ..S INSCLAIM=$$INSPRF^IBCEF(IEN)
 ..;get correct field where ID is stored based on instituional or professional
 ..S IDFIELD=$S(INSCLAIM:3.04,1:3.02)
 ..; get all insurance companys in the claim
 ..F LOOP="I1","I2","I3" Q:'$G(^DGCR(399,IEN,LOOP))  D
 ...S INSIEN=+^DGCR(399,IEN,LOOP)
 ...S PAYERID=$$GET1^DIQ(36,INSIEN_",",IDFIELD,"I")
 ...Q:PAYERID=""
 ...S INSURERS(PAYERID)=INSIEN
 ...;Deal with a Medicare (WNR) kludge which sent out IDs not in file 36
 ...I $$MCRWNR^IBEFUNC(INSIEN),$S(".12M61.SMTX1."[$P(IVC(11),HLCMP,3):1,1:0) S INSURERS($P(IVC(11),HLCMP,3))=INSIEN
 ..I $D(INSURERS($P(IVC(11),HLCMP,3))) S DATA(368,101.01)=INSURERS($P(IVC(11),HLCMP,3))
 Q
 ;
 ;
PID(IBSEG,DFNPTR,DFNSSN) ;  Process the PID seg
 N IDLIST,SUBCNT,SUBC,SUBCID,SUBCDATA,MRN,PID,MATCH
 S IDLIST=$G(IBSEG(4)),(MRN,PID,DFN)=""
 F SUBCNT=1:1:$L(IDLIST,HLREP) D
 .S SUBC=$P(IDLIST,HLREP,SUBCNT)
 .S SUBCID=$P(SUBC,HLCMP,5)                     ;Identifier Type Code
 .S SUBCDATA=$P(SUBC,HLCMP,1)                   ;Data Value
 .I SUBCID="EA" S MRN=SUBCDATA,DATA(368,80.2)=SUBCID
 .I SUBCID="MI" S PID=SUBCDATA,DATA(368,80.13)=SUBCID
 ;
 S DATA(368,10.01)=PID                          ;Patient Primary ID
 S DATA(368,11.03)=MRN                          ;Medical Record #
 S DATA(368,9.01)=$$FMNAME^HLFNC($P($G(IBSEG(6)),HLCMP,1,5),HL("ECH")) ;Patient Name
 S DATA(368,80.11)=$S($P($G(IBSEG(6)),HLCMP,8)="A":"QC",1:$P($G(IBSEG(6)),HLCMP,8))  ;Entity ID
 S DATA(368,80.12)=$P($G(IBSEG(6)),HLCMP,7)     ;Entity Type Qualifier
 ;
 ;S:MRN'="" DFN=+$O(^DPT("SSN",MRN,""))
 ;S:DFN>0 DATA(368,109.01)=DFN
 ;if there is a Medical Record Number and it matches the SSN (which vista uses as an MRN), then we have the correct patient
 S MATCH=0
 I MRN]"",MRN=$G(DFNSSN) S DATA(368,109.01)=DFNPTR,MATCH=1
 ;
 ;if no match on MRN/SSN but Patient Name from incoming message matches the Patient Name from the Patient file (#2), then we have the correct patient.
 I 'MATCH D
 .N DFN,VADM
 .S DFN=$G(DFNPTR) D DEM^VADPT
 .I $G(VADM(1))=DATA(368,9.01) S DATA(368,109.01)=DFNPTR
 Q
 ;
PSL(IBSEG) ;  Process the PSL seg
 N SQ,PSL,FN,SID,SID1,RDTTM,IEN
 F SQ=1,6:1:8,10,16:1:18,20,22,26 S PSL(SQ)=$G(IBSEG(SQ+1))
 ;
 S SID=$O(PSL021(""),-1)+1
 S PSL021(SID,.01)=SID                                 ;Seq #
 S PSL021(SID,.1)=$P(PSL(1),HLCMP)                     ;Line item ctrl
 S PSL021(SID,1.01)=$P(PSL(1),HLCMP,4)                 ;Ref ID Qual
 S PSL021(SID,.02)=$P(PSL(6),HLCMP)                    ;Prod/Svc Qual
 S PSL021(SID,.03)=$P(PSL(7),HLCMP)                    ;Svc ID Code
 S PSL021(SID,.04)=$P($P(PSL(8),HLREP),HLCMP)          ;Proc Mod 1
 S PSL021(SID,.05)=$P($P(PSL(8),HLREP,2),HLCMP)        ;Proc Mod 2
 S PSL021(SID,.06)=$P($P(PSL(8),HLREP,3),HLCMP)        ;Proc Mod 3
 S PSL021(SID,.07)=$P($P(PSL(8),HLREP,4),HLCMP)        ;Proc Mod 4
 S PSL021(SID,.08)=$P($P(PSL(16),HLCMP),HLSCMP)     ;Line item chg amt
 S PSL021(SID,.09)=$P(PSL(22),HLCMP)                   ;Revenue Code
 S PSL021(SID,.11)=$P(PSL(26),HLCMP)                   ;Svc Line Dt
 ;
 S SID1=$O(PSL2199(SID,""),-1)+1
 S PSL2199(SID,SID1,.01)=SID1                            ;Seq ID
 S PSL2199(SID,SID1,.02)=$P(PSL(10),HLCMP)               ;Stat Eff Dt
 S PSL2199(SID,SID1,1.04)=$P($P(PSL(17),HLREP),HLCMP)  ;Cd List Qual 1
 S PSL2199(SID,SID1,10.04)=$P($P(PSL(17),HLREP,2),HLCMP) ;Cd List Qual 2
 S PSL2199(SID,SID1,11.04)=$P($P(PSL(17),HLREP,3),HLCMP) ;Cd List Qual 3
 S PSL2199(SID,SID1,1.02)=$P($P(PSL(18),HLREP),HLCMP)    ;Addtl Info 1
 I SID=1,SID1=1 S DATA(368,22.03)=$P($P(PSL(18),HLREP),HLCMP)  ;Save primiary LOINC for worklist
 S PSL2199(SID,SID1,10.02)=$P($P(PSL(18),HLREP,2),HLCMP) ;Addtl Info 2
 S PSL2199(SID,SID1,11.02)=$P($P(PSL(18),HLREP,3),HLCMP) ;Addtl Info 3
 S PSL2199(SID,SID1,1.01)=$P($P(PSL(20),HLREP),HLCMP)    ;Health Claim 1
 S PSL2199(SID,SID1,10.01)=$P($P(PSL(20),HLREP,2),HLCMP) ;Health Claim 2
 S PSL2199(SID,SID1,11.01)=$P($P(PSL(20),HLREP,3),HLCMP) ;Health Claim 3
 ;
 S SID=$O(PSL0121(""),-1)+1
 S PSL0121(SID,.01)=SID
 S IEN=$$FIND1^DIC(368.002,,,$P(PSL(6),HLCMP)) S:IEN>0 PSL0121(SID,.02)=IEN  ;Prod/Svc Qual
 ;
 N FILE,CODETYPE
 S CODETYPE=$P(PSL(6),HLCMP)
 S FILE=$S(CODETYPE="HC":81,CODETYPE="NU":399.2,CODETYPE="N4":50.67,1:"")
 I FILE D
 .N FILELOC
 .S FILELOC=$S(FILE=81:";ICPT(",FILE=399.2:";DGCR(399.2,",FILE=50.67:";PSNDF(50.67,",1:"")
 .Q:FILELOC=""
 .S IEN=$$FIND1^DIC(FILE,,"X",$P(PSL(7),HLCMP))
 .S:IEN>0 PSL0121(SID,.03)=IEN_FILELOC
 ;
 S IEN=$$FIND1^DIC(81.3,,,$P($P(PSL(8),HLREP),HLCMP)) S:IEN>0 PSL0121(SID,.04)=IEN  ;Proc Mod 1
 S IEN=$$FIND1^DIC(81.3,,,$P($P(PSL(8),HLREP,2),HLCMP)) S:IEN>0 PSL0121(SID,.05)=IEN  ;Proc Mod 2
 S IEN=$$FIND1^DIC(81.3,,,$P($P(PSL(8),HLREP,3),HLCMP)) S:IEN>0 PSL0121(SID,.06)=IEN  ;Proc Mod 3
 S IEN=$$FIND1^DIC(81.3,,,$P($P(PSL(8),HLREP,4),HLCMP)) S:IEN>0 PSL0121(SID,.07)=IEN  ;Proc Mod 4
 S IEN=$$FIND1^DIC(399.2,,,$P(PSL(22),HLCMP)) S:IEN>0 PSL0121(SID,.09)=IEN         ;Revenue Code
 S VAL=$P($P(PSL(16),HLCMP),HLSCMP)
 I VAL=+VAL,VAL'["." S PSL0121(SID,.08)=$FN(VAL/100,",",2)
 S PSL0121(SID,.11)=$$FMDATE^HLFNC($P(PSL(26),HLCMP)) ;Svc Line Dt [D]
 ;
 S SID1=$O(PSL12199(SID,""),-1)+1
 S PSL12199(SID,SID1,.01)=SID1  ;Seq ID
 S PSL12199(SID,SID1,.02)=$$FMDATE^HLFNC($P(PSL(10),HLCMP))  ;Stat Eff Dt
 S IEN=$$FIND1^DIC(368.001,,,$P($P(PSL(20),HLREP),HLCMP)) S:IEN>0 PSL12199(SID,SID1,1.01)=IEN  ;Health Claim 1
 S IEN=$$FIND1^DIC(368.001,,,$P($P(PSL(20),HLREP,2),HLCMP)) S:IEN>0 PSL12199(SID,SID1,10.01)=IEN  ;Health Claim 2
 S IEN=$$FIND1^DIC(368.001,,,$P($P(PSL(20),HLREP,3),HLCMP)) S:IEN>0 PSL12199(SID,SID1,11.01)=IEN  ;Health Claim 3
 ;
 ;*******************************************************************
 ;The following code has been commented out to avoid performing a
 ;lookup into the LAB LOINC file (#95.3) because an Integration
 ;Agreement could not be obtained.
 ;S VAL=$P($P(PSL(18),HLREP),HLCMP)
 ;S VAL=$S(VAL["-":$P(VAL,"-"),1:$E(VAL,1,$L(VAL)-1))
 ;S IEN=$$FIND1^DIC(95.3,,,VAL) S:IEN>0 PSL12199(SID,SID1,1.02)=IEN
 ;I SID=1,SID1=1,IEN>0 S DATA(368,122.03)=IEN
 ;S VAL=$P($P(PSL(18),HLREP,2),HLCMP)
 ;S VAL=$S(VAL["-":$P(VAL,"-"),1:$E(VAL,1,$L(VAL)-1))
 ;S IEN=$$FIND1^DIC(95.3,,,VAL) S:IEN>0 PSL12199(SID,SID1,10.02)=IEN ;Addtl Info 2
 ;S VAL=$P($P(PSL(18),HLREP,3),HLCMP)
 ;S VAL=$S(VAL["-":$P(VAL,"-"),1:$E(VAL,1,$L(VAL)-1))
 ;S IEN=$$FIND1^DIC(95.3,,,VAL) S:IEN>0 PSL12199(SID,SID1,11.02)=IEN ;Addtl Info 3
 ;*******************************************************************
 Q
 ;
PYE(IBSEG) ;  Process the PYE seg
 N SQ,PYE
 F SQ=2,4,5 S PYE(SQ)=$G(IBSEG(SQ+1))
 ;
 S DATA(368,80.05)=$P(PYE(2),HLCMP)                   ;Entity ID Code
 S:PYE(4)'="" DATA(368,6.01)=$P(PYE(4),HLCMP)         ;Organization Nm
 S DATA(368,6.02)=$P(PYE(4),HLCMP,3)                  ;Info Rec ID #
 S DATA(368,80.07)=$P(PYE(4),HLCMP,7)                 ;ID Code Qual
 S:PYE(5)'="" DATA(368,6.01)=$$FMNAME^HLFNC($P(PYE(5),HLCMP,1,3),HL("ECH"))     ;Payee Name
 Q
 ;
OBX(IBSEG) ;  Process the OBX seg 
 N SQ,OBX,FN,SID,OBXTYP,FLD1,FLD2,FLD3,CQUAL,VAL
 F SQ=1,3,14  S OBX(SQ)=$G(IBSEG(SQ+1))
 S OBXTYP=$P($P(OBX(3),HLREP),HLCMP,6)
 S CQUAL=$P($P(OBX(3),HLREP),HLCMP,3)
 S (FLD1,FLD2,FLD3)=""
 ;
 I OBXTYP="STC01" D
 .S SID=$O(OBX013(""),-1)+1
 .S FLD1=1.01,FLD2=1.02,FLD3=1.04
 .S OBX013(SID,.01)=SID
 .S OBX013(SID,.02)=$P(OBX(14),HLCMP)
 I (OBXTYP="STC10")!(OBXTYP="STC11") S SID=$O(OBX013(""),-1)
 ;
 I OBXTYP="STC10" S FLD1=10.01,FLD2=10.02,FLD3=10.04
 I OBXTYP="STC11" S FLD1=11.01,FLD2=11.02,FLD3=11.04
 ;
 S:FLD1'="" OBX013(SID,FLD1)=$P($P(OBX(3),HLREP),HLCMP,4)    ;Health Care Claim Status Cat
 S:FLD2'="" OBX013(SID,FLD2)=$P($P(OBX(3),HLREP),HLCMP)      ;Addtl Info Request Mod 2-Claim
 S:FLD3'="" OBX013(SID,FLD3)=$S(CQUAL="LN":"LOI",1:CQUAL)    ;Code List Qualifier Code
 ;
 I SID=1,FLD2=1.02 D
 .S DATA(368,22.03)=$P($P(OBX(3),HLREP),HLCMP)  ; Save primiary LOINC for worklist
 .;*******************************************************************
 .;The following code has been commented out to avoid performing a
 .;lookup into the LAB LOINC file (#95.3) because an Integration
 .;Agreement could not be obtained.
 .;S VAL=$P($P(OBX(3),HLREP),HLCMP) S VAL=$S(VAL["-":$P(VAL,"-"),1:$E(VAL,1,$L(VAL)-1))
 .;S IEN=$$FIND1^DIC(95.3,,,VAL) S:IEN>0 DATA(368,122.03)=IEN  ; Save primiary LOINC [D]for worklist
 ;*******************************************************************
 ;
 I OBXTYP="STC01" D
 .S SID=$O(OBX0113(""),-1)+1
 .S OBX0113(SID,.01)=SID
 .S OBX0113(SID,.02)=$$FMDATE^HLFNC($P(OBX(14),HLCMP))
 I (OBXTYP="STC10")!(OBXTYP="STC11") S SID=$O(OBX0113(""),-1)
 ;
 I FLD1'="" S IEN=$$FIND1^DIC(368.001,,,$P($P(OBX(3),HLREP),HLCMP,4)) S:IEN>0 OBX0113(SID,FLD1)=IEN
 ;*******************************************************************
 ;The following code has been commented out to avoid performing a
 ;lookup into the LAB LOINC file (#95.3) because an Integration
 ;Agreement could not be obtained.
 ;S VAL=$P($P(OBX(3),HLREP),HLCMP) S VAL=$S(VAL["-":$P(VAL,"-"),1:$E(VAL,1,$L(VAL)-1))
 ;I FLD2'="" S IEN=$$FIND1^DIC(95.3,,,VAL) S:IEN>0 OBX0113(SID,FLD2)=IEN
 ;*******************************************************************
 Q
