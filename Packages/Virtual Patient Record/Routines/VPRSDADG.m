VPRSDADG ;SLC/MKB -- SDA DG PTF utilities ;04/25/22  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**30**;Apr 05, 2022;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^DGPM                         1865
 ; DGPTFAPI                      3157
 ; DGPTFUT                       6130
 ; DGPTPXRM                      4457
 ; DIC                           2051
 ; ICDEX                         5747
 ;
DXQ ; -- get PTF Dx via Admissions
 ; Query called from GET^DDE, returns DLIST(#)=ien
 ; Expects context variables DFN, DSTRT, DSTOP, DMAX
 ;
 N IDT,END,VPRN,ADM,PTF,VPTF,I
 S IDT=9999999.9999999-DSTOP-.0000001,END=9999999.9999999-DSTRT,VPRN=0
 F  S IDT=$O(^DGPM("ATID1",DFN,IDT)) Q:IDT<1!(IDT>END)  D  Q:VPRN'<DMAX
 . S ADM=0 F  S ADM=$O(^DGPM("ATID1",DFN,IDT,ADM)) Q:ADM<1  D  Q:VPRN'<DMAX
 .. S PTF=+$P($G(^DGPM(ADM,0)),U,16) Q:PTF<1  Q:'$$VNUM^VPRSDAV(ADM)
 .. ;Q:'$$GET1^DIQ(45,PTF,79,"I")  ;no DXLS
 .. D RPC^DGPTFAPI(.VPTF,PTF) Q:VPTF(0)<1
 .. S:$L($P(VPTF(1),U,3)) VPRN=VPRN+1,DLIST(VPRN)=PTF
 .. F I=1:1:24 I $L($P(VPTF(2),U,I)) S VPRN=VPRN+1,DLIST(VPRN)=PTF_"-"_I
 Q
 ;
DX1 ; -- get info for single PTF record [ID Action]
 ; Expects DIEN = #45 ien, returns VPRPOA & VPRPTF array
 N VST,VPTF,N,X,Y K VPRPTF
 S VPRPTF=$G(DIEN),DIEN=+$G(DIEN)
 S VST="" D  I VST<1 S DDEOUT=1 Q
 . N ADM S ADM=$$FIND1^DIC(405,,"Q",DIEN,"APTF") Q:ADM<1
 . S:'$G(DFN) DFN=+$P($G(^DGPM(ADM,0)),U,3)
 . S VST=+$$VNUM^VPRSDAV(ADM) I 'VST!'$D(^AUPNVSIT(VST,0)) S VST=""
 S VPRPTF("VISIT")=VST
 D RPC^DGPTFAPI(.VPTF,DIEN) I VPTF(0)<1 S DDEOUT=1 Q
 S N=+$P(VPRPTF,"-",2),VPRPOA=$P($G(VPTF(3)),U,N+1)
 S X=$S(N:$P(VPTF(2),U,N),1:$P($G(VPTF(1)),U,3))
 S Y=$$CODEBA^ICDEX(X,80) I Y<1 S DDEOUT=1 Q
 S VPRPTF("DX")=Y_U_X ;ien^code
 D PTF^DGPTPXRM(DIEN,.VPRPTF)
 Q
 ;
OPQ ; -- get PTF 601 procedure codes via Admissions
 ; Query called from GET^DDE, returns DLIST(#)=ien
 ; Expects context variables DFN, DSTRT, DSTOP, DMAX
 ;
 N IDT,END,VPRN,ADM,PTF,VPTF,DA,STR,P,X
 S IDT=9999999.9999999-DSTOP-.0000001,END=9999999.9999999-DSTRT,VPRN=0
 F  S IDT=$O(^DGPM("ATID1",DFN,IDT)) Q:IDT<1!(IDT>END)  D  Q:VPRN'<DMAX
 . S ADM=0 F  S ADM=$O(^DGPM("ATID1",DFN,IDT,ADM)) Q:ADM<1  D  Q:VPRN'<DMAX
 .. S PTF=+$P($G(^DGPM(ADM,0)),U,16) Q:PTF<1  Q:'$$VNUM^VPRSDAV(ADM)
 .. D PTFIEN^DGPTFUT(601,PTF,.VPTF)
 .. S DA=0 F  S DA=$O(VPTF(DA)) Q:DA<1  D
 ... S STR=$$STR601^DGPTFUT(PTF,DA)
 ... F P=1:1:25 S X=$P(STR,U,P) S:X VPRN=VPRN+1,DLIST(VPRN)=DA_","_PTF_"-"_P
 Q
 ;
OP1 ; -- get info for single PTF record [ID Action]
 ; Expects DIEN = #45 iens, returns VPRPTF & VPRVST
 N VST,VPTF,X,Y
 S VPRPTF=$G(DIEN),DIEN=$P($G(DIEN),"-") ;DA,PTF-#
 S VST="" D  I VST<1 S DDEOUT=1 Q
 . N ADM,PTF
 . S PTF=+$P(VPRPTF,",",2),ADM=$$FIND1^DIC(405,,"Q",PTF,"APTF") Q:'ADM
 . S:'$G(DFN) DFN=$P($G(^DGPM(ADM,0)),U,3)
 . S VST=+$$VNUM^VPRSDAV(ADM) I 'VST!'$D(^AUPNVSIT(VST,0)) S VST=""
 S VPRVST=VST
 Q
