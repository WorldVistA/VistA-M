DGPFLFD ;ALB/KCL - PRF DISPLAY FLAG DETAIL LM SCREEN ; 3/13/03
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
 ;no direct entry
 QUIT
 ;
EN ;Main entry point for DGPF FLAG DETAIL list template.
 ;
 ;  Input:
 ;     DGPFIEN - IEN of record in PRF NATIONAL FLAG or PRF LOCAL
 ;               FLAG file [ex: "1;DGPF(26.15,"]
 ;
 ; Output: None
 ;
 ;quit if required input not defined
 Q:$G(DGPFIEN)']""
 ;
 ;display wait msg to user
 D WAIT^DICD
 ;
 ;invoke DGPF FLAG DETAIL list template
 D EN^VALM("DGPF FLAG DETAIL")
 Q
 ;
 ;
HDR ;Header Code
 ;
 N DGHDR
 N DGRESULT
 N DGPFLG
 K DGPFLG
 ;
 ;retrieve flag, place into DGHDR array
 S DGRESULT=$$GETFLAG^DGPFUT1(DGPFIEN,.DGPFLG)
 ;
 ;construct header array
 S VALMHDR(1)="Flag Name: "_$S(DGRESULT:$P($G(DGPFLG("FLAG")),U,2),1:"UNKNOWN")
 S DGHDR="Flag Status: "_$S(DGRESULT:$P($G(DGPFLG("STAT")),U,2),1:"UNKNOWN")
 S VALMHDR(1)=$$SETSTR^VALM1(DGHDR,VALMHDR(1),55,$L(DGHDR))
 ;
 Q
 ;
 ;
INIT ;Init variables and list array
 ;
 D BLD
 ;
 Q
 ;
 ;
BLD ;Build flag detail screen (list area)
 ;
 D CLEAN^VALM10
 K VALMHDR
 K ^TMP("DGPFDET",$J)
 ;
 ;init number of lines in list
 S VALMCNT=0
 ;
 ;build header
 D HDR
 ;
 ;build list area for flag detail
 D EN^DGPFLFD1("DGPFDET",DGPFIEN,.VALMCNT)
 ;
 Q
 ;
 ;
HELP ;Help Code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;
EXIT ;Exit Code
 ;
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP("DGPFDET",$J)
 Q
 ;
 ;
EXPND ;Expand Code
 Q
