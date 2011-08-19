SDCO ;ALB/RMO - Check Out List Manager Driver; 11 FEB 1993 10:00 am
 ;;5.3;Scheduling;**27,132,149,193**;08/13/93
 ;
EN(SDOE,SDCOHDL,SDCOXQB) ; -- main entry point for SDCO CHECK OUT list manager
 ; Input  -- SDOE, SDCOHDL and SDCOXQB  [Optional]
 N SDCOACT,SDEVTF,SDAPTYP
 IF $P($G(^SCE(+SDOE,0)),"^",6) G ENQ ;exit if child
 D EN^VALM("SDCO CHECK OUT")
ENQ ;
 Q
 ;
HDR ; -- header code
 K VALMHDR
 N DFN,SDCL,SDOE0,X,VA,SDELIG,SDATA
 S SDOE0=$G(^SCE(+SDOE,0)),SDCL=+$P(SDOE0,"^",4)
 S DFN=+$P(SDOE0,"^",2) D PID^VADPT
 I $G(SDT)'="" S SDATA=$G(^DPT(DFN,"S",SDT,0))
 S SDELIG=$$ELSTAT^SDUTL2(DFN)
 I $$MHCLIN^SDUTL2(SDCL),'($$COLLAT^SDUTL2(SDELIG)!$P($G(SDATA),U,11)) D
 .S SDGAF=$$NEWGAF^SDUTL2(DFN),SDGAFST=$P(SDGAF,"^")
 .I SDGAFST D
 ..S SDGAFDT=$$FMTE^XLFDT($P(SDGAF,"^",3),"5M"),SDGAFS=$P(SDGAF,"^",2),SDGAFP=$P(SDGAF,"^",4)
 ..S VALMHDR(3)="GAF Date: "_SDGAFDT_"     GAF Score: "_SDGAFS_"     New GAF Required"
 S VALMHDR(1)=$E("Patient: "_$P($G(^DPT(DFN,0)),"^"),1,30)_" ("_VA("BID")_")"
 S:SDCL VALMHDR(1)=$$SETSTR^VALM1($E("Clinic: "_$P($G(^SC(SDCL,0)),"^"),1,20),VALMHDR(1),60,80)
 S VALMHDR(2)=$$SETSTR^VALM1($E($$ORG^SDCOU(+$P(SDOE0,"^",8)),1,20)_" Date/Time: "_$$LOWER^VALM1($$FTIME^VALM1(+SDOE0)),"",1,51)
 S VALMHDR(2)=$$SETSTR^VALM1("Checked Out: "_$S($$COMDT^SDCOU(SDOE):"YES",1:"NO"),VALMHDR(2),60,80)
 Q
 ;
INIT ; -- init variables and list array -- SDOE required
 D BLD
 Q
 ;
BLD ; -- build check out screen
 D CLEAN^VALM10
 K ^TMP("SDCOIDX")
 D HDR
 D EN^SDCO0("SDCO",SDOE,1,.VALMCNT)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10,CLEAR^VALM1
 K ^TMP("SDCOIDX"),SDCOXQB
 Q
 ;
EXPND ; -- expand code
 Q
 ;
