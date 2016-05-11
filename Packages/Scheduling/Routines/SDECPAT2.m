SDECPAT2 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;place holder routine for future implementations
 ;
 ;---------
 ; MCR:     Input -  P = DFN
 ;                   D = Date
 ;          Output - 1 = Yes, patient is/was MCare eligible on date D.
 ;                   0 = No, or unable.
 ;
 ;      Examples: I $$MCR^SDECPAT(DFN,2930701)
 ;                S AGMCR=$$MCR^SDECPAT(DFN,DT)
 ;
MCR(P,D) ;EP - Is patient P medicare eligible on date D.  1 = yes, 0 = no.
 ; I = IEN in ^AUPNMCR multiple.
 Q 0
 ;
 ;----------
 ; MCD:     Input -  P = DFN
 ;                   D = Date
 ;          Output - 1 = Yes, patient is/was MCaid eligible on date D.
 ;                   0 = No, or unable.
 ;
 ;      Examples: I $$MCD^SDECPAT(DFN,2930701)
 ;                S AGMCD=$$MCD^SDECPAT(DFN,DT)
 ;
MCD(P,D) ;EP - Is patient P medicaid eligible on date D.
 ; I = IEN.
 ; J = Node 11 IEN in ^AUPNMCD.
 Q 0
 ;
 ;----------
 ; MCDPN:   Input -  P = DFN
 ;                   D = Date
 ;                   F = Form for output of plan (Insurer) name.
 ; If F = "E", return external form, else pointer to INSURER file.
 ;          Output - Literal = Cleartext name of insurer.
 ;                   Number = Pointer to INSURER file.
 ;
 ;      Examples: I $$MCDPN^SDECPAT(DFN,2930701)
 ;                S AGMCDPN=$$MCDPN^SDECPAT(DFN,DT,"E")
 ;
MCDPN(P,D,F) ;EP - return medicaid plan name for patient P on date D in form F.
 ; I = IEN
 ; J = Node 11 IEN
 Q 0
 ;
 ;
 ;----------
 ; PI:      Input -  P = DFN
 ;                   D = Date
 ;          Output - 1 = Yes, patient is/was PI eligible on date D.
 ;                   0 = No, or unable.
 ;
 ;      Examples: I $$PI^SDECPAT(DFN,2930701)
 ;                S AGPI=$$PI^SDECPAT(DFN,DT)
 ;
PI(P,D) ;EP - Is patient P private insurance eligible on date D. 1= yes, 0=no.
 ; I = IEN
 ; Y = 1:yes, 0:no
 ; X = Pointer to INSURER file.
 Q 0
 ;
 ;----------
 ; PIN:     Input -  P = DFN
 ;                   D = Date
 ;                   F = Form for output of plan (Insurer) name.
 ; If F = "E", return external form, else pointer to INSURER file.
 ;          Output - Literal = Cleartext name of insurer.
 ;                   Number = Pointer to INSURER file.
 ;
 ;      Examples: I $$PIN^SDECPAT(DFN,2930701)
 ;                S AGPIN=$$PIN^SDECPAT(DFN,DT,"E")
 ;
PIN(P,D,F) ;EP - return private insurer name for patient P on date D in form F
 ; I = IEN
 Q 0
 ;
 ;Begin New Code;IHS/SET/GTH AUPN*99.1*8 10/04/2002
RRE(P,D) ;EP - Does pt have Railroad insurance on date?  1 = yes, 0 = no.
 ; I = IEN in ^AUPNRRE multiple.
 Q 0
 ;
 ;End New Code;IHS/SET/GTH AUPN*99.1*8 10/04/2002
