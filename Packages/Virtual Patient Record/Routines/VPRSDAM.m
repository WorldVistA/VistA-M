VPRSDAM ;SLC/MKB -- SDA Appointment utilities ;7/29/22  14:11
 ;;1.0;VIRTUAL PATIENT RECORD;**30**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DGS(41.1                     3796
 ; ^DPT                         10035
 ; DIQ                           2056
 ; SDAMA301, ^TMP($J)            4433
 ; SDOE                          2546
 ;
 ;
APPTS ; -- get Appointments
 ; Query called from GET^DDE, returns DLIST(#)=ien
 ; Expects context variables DFN, DSTRT, DSTOP, DMAX
 ;
 N VPRX,VPRNUM,VPRDT,VPRN
 S VPRX(1)=DSTRT_";"_DSTOP,VPRX(4)=DFN
 S VPRX("FLDS")="1;2;3;5;6;8;9;10;11;12;16;18;22",VPRX("SORT")="P"
 ; appointments
 S VPRX(3)="R;I;NS;NSR;NT" ;no cancelled appt's
 S VPRNUM=$$SDAPI^SDAMA301(.VPRX),(VPRDT,VPRN)=0
 F  S VPRDT=$O(^TMP($J,"SDAMA301",DFN,VPRDT)) Q:VPRDT<1  D  Q:VPRN'<DMAX
 . S VPRN=VPRN+1,DLIST(VPRN)=VPRDT_","_DFN ;^TMP($J,"SDAMA301",DFN,VPRDT)
 ;K ^TMP($J,"SDAMA301",DFN)
 Q
 ;
SCHADMS ; -- get Scheduled Admissions
 ; Query called from GET^DDE, returns DLIST(#)=ien
 ; Expects context variables DFN, DSTRT, DSTOP, DMAX
 ;
 N VPRA,VPRX,X,VPRN S VPRN=0
 S VPRA=0 F  S VPRA=$O(^DGS(41.1,"B",DFN,VPRA)) Q:VPRA<1  D  Q:VPRN'<DMAX
 . S VPRX=$G(^DGS(41.1,VPRA,0))
 . S X=$P(VPRX,U,2) Q:X<DSTRT!(X>DSTOP)  ;out of date range
 . Q:$P(VPRX,U,13)  ;Q:$P(VPRX,U,17)     ;cancelled or admitted
 . S VPRN=VPRN+1,DLIST(VPRN)=VPRA
 Q
 ;
APPT1(VPRID) ; -- get ^TMP node for single appt, returns VPRAPPT
 N DFN,VPRDT S VPRID=$G(VPRID)
 S DFN=$P(VPRID,",",2),VPRDT=$P(VPRID,",")
 I 'DFN!'VPRDT S DDEOUT=1 Q
 I '$D(^TMP($J,"SDAMA301",DFN)) D
 . N VPRX,VPRNUM
 . S VPRX(1)=VPRDT_";"_VPRDT,VPRX(4)=DFN
 . S VPRX("FLDS")="1;2;3;5;6;8;9;10;11;12;16;18;22",VPRX("SORT")="P"
 . S VPRNUM=$$SDAPI^SDAMA301(.VPRX)
 S VPRAPPT=$G(^TMP($J,"SDAMA301",DFN,VPRDT)),VPRAPPT("C")=$G(^(VPRDT,"C"))
 S:VPRAPPT="" VPRAPPT=VPRDT_U_$P($G(^DPT(DFN,"S",VPRDT,0)),U,1,2) ;DDEOUT=1
 Q
 ;
APPTPRV() ; -- return the default/primary provider for VPRAPPT
 N Y,I,SDOE,LOC,VPROV S Y=""
 S SDOE=$P($G(VPRAPPT),U,12) I SDOE D
 . D GETPRV^SDOE(SDOE,"VPROV") S I=0
 . F  S I=$O(VPROV(I)) Q:I<1  I $P($G(VPROV(I)),U,4)="P" S Y=+VPROV(I) Q
 . I 'Y S I=$O(VPROV(0)) S:I Y=+VPROV(I) ;first, if no Primary
 I 'SDOE,+$G(VPRAPPT)>DT D  ;future
 . S LOC=+$P($G(VPRAPPT),U,2),Y=$$GET1^DIQ(44,LOC,16,"I") Q:Y
 . ;S I=+$O(^SC("ADPR",LOC,0)) I I S Y=+$G(^SC(LOC,"PR",I,0))
 . D GETS^DIQ(44,LOC,"2600*","I","VPROV")
 . S I="" F  S I=$O(VPROV(44.1,I)) Q:I=""  I $G(VPROV(44.1,I,.02,"I"))=1 S Y=$G(VPROV(44.1,I,.01,"I"))
 Q Y
