SCDXHLDR ;ALB/JLU;Ambulatory care event handler;4/30/96
 ;;5.3;Scheduling;**44,99,126,66,132,245**;5/1/96
 ;This routine is the Ambulatory care event handler.  It will hang on 
 ;the Scheduling event driver and monitor the types of events.  When a
 ;check out, edit to a check out or deletion of a check out occurs this
 ;routine will update the Transmitted outpatient encounter file.
 ;
EN ;Main entry point
 ;
 I $D(SDSTPAMB) G ENQ ;this will stop the logging of events.
 I '$D(SDAMEVT) G ENQ
 I SDAMEVT'>4!(SDAMEVT>9) G ENQ ;check out, add/edit and add/edit change
 N SDOE,SDPROC,SDBEFORE,SDAFTER,EVTDT,CLINIC,XMIT
 S SDPROC=0
 F  S SDPROC=$O(^TMP("SDEVT",$J,SDHDL,SDPROC)) Q:'SDPROC  I SDPROC'=4 DO
 .S SDOE=0
 .F  S SDOE=$O(^TMP("SDEVT",$J,SDHDL,SDPROC,"SDOE",SDOE)) Q:'SDOE  DO
 ..K XMIT
 ..D NOW^%DTC S EVTDT=%
 ..S SDAFTER=$G(^TMP("SDEVT",$J,SDHDL,SDPROC,"SDOE",SDOE,0,"AFTER"))
 ..S SDBEFORE=$G(^("BEFORE")) ;naked reference from previous line
 ..;
 ..;Screen out test patients
 ..S DFN=$S((SDAFTER'=""):$P(SDAFTER,U,2),(SDBEFORE'=""):$P(SDBEFORE,U,2),1:0)
 ..I DFN Q:$$TESTPAT^VADPT(DFN)
 ..;
 ..; screen out non counts
 ..I SDAFTER]"" S CLINIC=$P(SDAFTER,U,4) Q:$$NONCNT($P(SDAFTER,U,4))
 ..I SDBEFORE]"" S CLINIC=$P(SDBEFORE,U,4) Q:$$NONCNT($P(SDBEFORE,U,4))
 ..;
 ..; handling of delete encounters and check outs
 ..I SDAFTER]"",SDBEFORE]"",SDAFTER'=SDBEFORE,'$$COMPL(SDAFTER) D LOAD("DELETE",SDOE,EVTDT,SDBEFORE) Q  ;DELETION OF A CHECK OUT
 ..I SDBEFORE]"",SDAFTER']"",SDPROC=2,'+$P(SDBEFORE,U,6) D LOAD("DELETE",SDOE,EVTDT,SDBEFORE) Q  ;delete of a stand alone add/edit
 ..I SDBEFORE]"",SDAFTER']"",SDPROC=2,+$P(SDBEFORE,U,6) Q  ;delete of add/edit from an appt. IT HAS ALREADY BEEN MARKED
 ..;;;I SDBEFORE]"",SDAFTER']"",SDPROC=2,+$P(SDBEFORE,U,6) D LOAD("EDIT",SDOE,EVTDT,SDBEFORE) Q  ;THIS IS FROM ABOVE. KEPT FOR REFERENCE
 ..;
 ..;screen out not checked out encounters
 ..I '$S(SDAFTER]"":$$COMPL(SDAFTER),SDBEFORE]"":$$COMPL(SDBEFORE),1:0) Q
 ..;
 ..;any loads or edits
 ..I SDBEFORE]"",SDAFTER]"" D LOAD("EDIT",SDOE,EVTDT) ;edit of C/O
 ..I SDBEFORE']"",SDAFTER]"" D LOAD("ADD",SDOE,EVTDT) ;new encounter at C/O
 ..Q
 .Q
 ;
ENQ ;
 Q
 ;
NONCNT(IEN) ;this function determines if the clinic is non count or not
 ;INPUT IEN the poitner to the hospital location.
 ;OUTPUT 1 if a non count
 ;       0 if not a non count
 I '$D(IEN) S ANS=0 G NONCNTQ
 I 'IEN S ANS=0 G NONCNTQ
 S ANS=$S($P(^SC(IEN,0),U,17)="Y":1,1:0)
NONCNTQ Q ANS
 ;
COMPL(NODE) ;this function call returns whether or not the check out
 ;process is complete or not.  1 for complete  0 for not
 ;
 Q $S(+$P(NODE,U,7):1,1:0)
 ;
LOAD(ACTION,IEN,EVTDT,NODE) ;
 ;ACTION is what type of action caused this event
 ;IEN is the pointer to the outpatient encounter file
 ;EVTDT is the date this action occured
 ;NODE is the zero node of the outpatient encounter file
 ;
 N EVNT,PAR
 ;
 I ACTION'="DELETE" DO
 .I $D(^SCE(IEN,0)) S PAR=$P(^SCE(IEN,0),U,6)
 .E  S PAR=$P(NODE,U,6)
 .S IEN=$S(+PAR:PAR,1:IEN)
 .S EVNT=$S(ACTION="ADD":1,1:2)
 .S XMIT=$$FINDXMIT^SCDXFU01(IEN)
 .I 'XMIT S XMIT=$$CRTXMIT^SCDXFU01(IEN,"",EVTDT)
 .I +XMIT>0 D STREEVNT^SCDXFU01(XMIT,EVNT,EVTDT),XMITFLAG^SCDXFU01(XMIT,0)
 .Q
 ;
 I ACTION="DELETE" DO
 .N DELENT,TRANENT,DELENCT,PAR,NTNEED
 .S PAR=$P(NODE,U,6)
 .S IEN=$S(+PAR:PAR,1:IEN)
 .;
 .;Encounter never transmitted to or accepted by NPCD
 .I (('$$XMITED^SCDXFU03(IEN))&('$$ACCEPTED^SCDXFU03(IEN))) S NTNEED=""
 .;Another parent encounter has same Visit ID (i.e. duplicate encounter)
 .I ($$VIDCNT^SCDXFU03($P(NODE,"^",20),IEN)) S NTNEED=""
 .;
 .S DELENT=$$CRTDEL^SCDXFU02($P(NODE,U,1),$P(NODE,U,2),EVTDT,NODE)
 .I DELENT<0 S DELENT=$$DELXMIT^SCDXFU03(IEN,1) Q
 .;
 .S XMIT=$$CRTXMIT^SCDXFU01(IEN,DELENT,EVTDT)
 .I XMIT<0 S DELENT=$$DELXMIT^SCDXFU03(IEN,1) Q
 .;
 .;Delete entry in transmission file (409.73) - not needed
 .I $D(NTNEED) S DELENT=$$DELXMIT^SCDXFU03(DELENT,2) Q
 .;
 .D XMITFLAG^SCDXFU01(XMIT,0)
 .Q
 Q
 ;
VALIDATE(XMIT,CLINIC) ;this entry point performs the validation at check out.
 ;
 ;INPUT - XMIT this is the IEN of an entry in the transmit file 409.73
 S XMIT=+$G(XMIT)
 S CLINIC=+$G(CLINIC)
 I XMIT<1!(CLINIC<1) G VALQ
 N VAL
 S VAL=$$VALWL^SCMSVUT2(+$G(CLINIC))
 I VAL<1 G VALQ
 I 'SDMODE,'$D(ZTQUEUED),'$D(VALQUIET) W !!,"Performing Ambulatory Care Validation Checks.",!
 S ERR=$$VALIDATE^SCMSVUT2(XMIT)
 I SDMODE!($D(ZTQUEUED))!($D(VALQUIET)) G VALQ
 I ERR<1 DO  G VALQ
 .W !,"No validation errors found!"
 .Q
 S DIR(0)="Y"
 S DIR("B")="YES"
 S DIR("A")="Do you wish to correct the validation errors"
 D ^DIR
 K DIR
 I Y<1 G VALQ
 ;
 D ENP^SCENI0(XMIT)
 ;
VALQ Q
 ;
FINAL(VISIT,PXKVST) ;
 ;INPUT  VISIT - the IEN of the visit at hand.
 ;
 Q:$D(SDIEMM)
 Q:'$D(VISIT)
 Q:VISIT=""
 Q:$D(VALSTP)
 Q:$D(^TMP("PXKSAVE",$J))
 N ENC,CLN,XMT,SDMODE
 S ENC=0
 F  S ENC=$O(^SCE("AVSIT",VISIT,ENC)) Q:ENC=""  I $P(^SCE(ENC,0),U,6)="" Q
 I ENC="" Q
 Q:'$D(^SCE(ENC,0))
 Q:'$$COMPL(^SCE(ENC,0))
 S CLN=$P(^SCE(ENC,0),U,4)
 S XMT=+$O(^SD(409.73,"AENC",ENC,0))
 I 'XMT Q
 S SDMODE=0
 D TERM
 D VALIDATE(XMT,CLN)
 Q
 ;
TERM ;this is to reset the io variables for lsitman to function properly
 ;when coming from PCE.
 N X
 S X="IORVON;IORVOFF;IOIL;IOSTBM;IOSC;IORC;IOEDEOP;IOINHI;IOINORM;IOUON;IOUOFF;IOBON;IOBOFF;IOSGR0"
 ;;;S X="IORVON;IORVOFF;IOSC;IORC;IOEDEOP;IOINHI;IOINORM;IOUON;IOUOFF;IOBON;IOBOFF;IOSGR0"
 D ENDR^%ZISS
 Q
 ;
OK() ;
 I SDAMEVT=6,SDBEFORE="",SDAFTER]"" Q 0
 Q 1
 ;
