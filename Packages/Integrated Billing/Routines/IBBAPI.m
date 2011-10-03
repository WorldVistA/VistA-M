IBBAPI ;OAK/ELZ - APIS FOR OTHER PACKAGES FOR PFSS ;6-MAY-2003
 ;;2.0;INTEGRATED BILLING;**256,228,267,260,286**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; -- See IBBDOC for API details
 ;
INSUR(DFN,IBDT,IBSTAT,IBR,IBFLDS) ; Return Patient Insurance Information
 ;
 Q $$INSUR^IBBFAPI($G(DFN),$G(IBDT),$G(IBSTAT),.IBR,$G(IBFLDS))
 ;
 ;
CIDC(DFN) ; Return if CIDC questions should be asked for DFN
 ;
 Q $$CIDC^IBBASCI($G(DFN))
 ;
SWSTAT() ;Return the PFSS Master switch status
 ;
 Q $$SWSTAT^IBBASWCH()
 ;
GETACCT(IBBDFN,IBBARFN,IBBEVENT,IBBAPLR,IBBPV1,IBBPV2,IBBPR1,IBBDG1,IBBZCL,IBBDIV,IBBRAIEN,IBBSURG) ;
 ;Send visit data to external medical billing system
 ;
 Q $$GET^IBBAACCT(IBBDFN,IBBARFN,IBBEVENT,$G(IBBAPLR),.IBBPV1,.IBBPV2,.IBBPR1,.IBBDG1,.IBBZCL,$G(IBBDIV),$G(IBBRAIEN),.IBBSURG)
 ;
GETCHGID() ;Obtain unique charge id for service being charged
 ;
 Q $$GETCHGID^IBBACHRG()
 ;
CHARGE(IBBDFN,IBBARFN,IBBCTYPE,IBBUCID,IBBFT1,IBBPR1,IBBDG1,IBBZCL,IBBRXE,IBBORIEN,IBBPROS) ;
 ;Send charge data to external medical billing system
 ;
 Q $$CHARGE^IBBACHRG(IBBDFN,IBBARFN,IBBCTYPE,IBBUCID,.IBBFT1,.IBBPR1,.IBBDG1,.IBBZCL,.IBBRXE,$G(IBBORIEN),.IBBPROS)
 ;
SETACCT(IBBDFN,HLMTIENS) ;Store external medical billing system's visit# in file #375 record
 ;
 Q $$SET^IBBAADTI(IBBDFN,HLMTIENS)
 ;
EXTNUM(IBBDFN,IBBARFN) ;Get external medical billing system's visit#
 ;
 Q $$EXTNUM^IBBAACCT(IBBDFN,IBBARFN)
 ;
