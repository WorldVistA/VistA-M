FBPRICE1 ;AISC/DMK,WOIFO/SAB - GENERIC PRICER INTERFACE CON'T ;9/14/2009
 ;;3.5;FEE BASIS;**56,55,77,108,139**;JAN 30, 1995;Build 127
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 N FBCDCNT,FBCNT,FBI,FBLNCNT,FBRT,FBTL,FBVAL,XICDVDT,FBISYS
 S XICDVDT=FBCSVDT ; date for file 80 and 80.1 identifier logic
 S FBCNT=0 ; count of codes
 N EDATE,DP,DA S EDATE=XICDVDT,DP=0,DA=0 ; FB*3.5*139 JLG ICD-10 remediation
 S FBISYS=10 S:XICDVDT<$$IMPDATE^FBCSV1("10D") FBISYS=9 ; FB*3.5*139 JLG ICD-10 remediation
 ;
ICD ;ask Dx
 W !
 S FBQUIT=0
 F I=1:1:25 D  Q:((FBISYS=9)&(X=""))!(FBQUIT)!($D(DTOUT))!($D(DUOUT))
 . I FBISYS=9 D  Q:X=""!($D(DTOUT))!($D(DUOUT))
 . . S DIR(0)="PO^80:EIQMZ" ;3/28/13 S DIR(0)="PO^80:EQMZ"
 . . ;JAS - 04/09/13 - Patch 139 - Added next line for screening
 . . S DIR("S")="I $$CHKVERS^FBICD9(+Y,FBCSVDT)"
 . . F  D ^DIR Q:X=""!($D(DTOUT))!($D(DUOUT))  S FBVAL=+Y,FBRT=$$CHKICD9^FBCSV1(FBVAL,FBCSVDT) I FBRT]"" S FBDX(I)=FBVAL,FBCNT=FBCNT+1 Q
 . . K DIR
 . . Q:'$G(FBDX(I))
 . . D POA Q:$D(DTOUT)!$D(DUOUT)
 . I FBISYS=10 D
 . . S FBY=$$ICD10 S X=1
 . . I FBY=-3 S DTOUT=-1 Q  ; -3 means ^ entered by user
 . . I FBY>0 S FBDX(I)=FBY,FBCNT=FBCNT+1 D POA S X=1 Q
 . . S FBQUIT=-1 Q
 I $D(DTOUT)!($D(DUOUT)) G END^FBPRICE
 I (FBISYS=9)&('$G(FBDX(1))) W !,*7,"Must enter at least a primary diagnosis.",! G ICD
 K DIR,I
 ; 
ADMITDX ;ask admitting diagnosis for ICD-9
 I FBISYS=10 G ADMITDX0
 I FBISYS=9 D
 . ;JAS - 04/10/13 - Patch 139 - Altered DIR read for ICD versioning
 . W ! S DIR(0)="PO^80:EIQMZ",DIR("A")="Admitting Diagnosis"
 . S DIR("S")="I $$CHKVERS^FBICD9(+Y,FBCSVDT)"
 . ;END 139
 . D ^DIR K DIR
 . Q:$D(DIRUT)
 . S FBVAL=+Y
 . S FBRT=$$CHKICD9^FBCSV1(FBVAL,FBCSVDT)
 ;JAS - 09/18/13 - PATCH 139 - Modified code to force entry of required Admitting dx field.
 I $D(DIRUT) W !,"This is a required response." G ADMITDX
 I FBRT="" G ADMITDX
 S FBADMTDX=FBVAL
 S FBCNT=FBCNT+1
 ;
ADMITDX0 ; ask admitting diagnosis for ICD-10  ; FB*3.5*139 JLG ICD-10 remediation
 I FBISYS=10 D
 . W ! S FBRT=$$ASKICD10^FBASF("Admitting Diagnosis","","Y")
 . I FBRT'>0 W !,"This is a required response."
 G END^FBPRICE:$D(DIRUT)
 I (FBISYS=10)&(FBRT'>0) G ADMITDX0
 I (FBISYS=10) S FBADMTDX=FBRT S FBCNT=FBCNT+1
 ;
PROC ;ask procedure codes
 W !
 ;JAS - 04/10/13 - Patch 139 - Changed from DIR read to new utility to allow for proper code-set versioning and additional inactive code checks
 F I=1:1:25 D  Q:X=""!($D(DUOUT))!($D(DTOUT))
 . F  S Y=$$ENICD9^FBICDP(FBCSVDT,"Select ICD OPERATION/PROCEDURE") Q:X=""!($D(DUOUT))!($D(DTOUT))!(+Y'>0)  S FBVAL=+Y,FBPRC(I)=FBVAL,FBCNT=FBCNT+1 Q
 ;END 139
 I $D(DTOUT)!($D(DUOUT)) G END^FBPRICE
 K DIR,I
 ;
 W ! S DIR(0)="162.5,6.6",DIR("A")="Billed Charges"
 D ^DIR K DIR G END^FBPRICE:$D(DIRUT)
 S FBBILL=$FN(Y,"",2),FBBILL=$TR(FBBILL,".")
 S FBBILL=$E("000000000",$L(FBBILL)+1,9)_FBBILL
 ;
 S DIR(0)="162.5,6.6",DIR("A")="Amount Claimed"
 D ^DIR K DIR G END^FBPRICE:$D(DIRUT)
 S FBCLAIM=$FN(Y,"",2),FBCLAIM=$TR(FBCLAIM,".")
 S FBCLAIM=$E("000000000",$L(FBCLAIM)+1,9)_FBCLAIM
 ;
 S FBOBL="000000"
 ;
STRING ;set-up message text for pricer
 W ! D WAIT^DICD
 D ADDRESS^FBAAV01 Q:$G(VATERR)  K VAT
 S FBTL=(FBCNT-1)\13+2 ; total number of lines needed
 S FBFLAG=1 D NEWMSG^FBAAV01
 S FBRESUB=2 ; 2 identifies the message as generic pricer
 S FBLNCNT=0 ; init invoice line counter
 D NEWLN^FBAAV6
 S FBSTR=FBSTR_FBTL_FBLNAM_FBFI_FBMI_FBSEX_FBDOB_FBLOS
 S FBSTR=FBSTR_FBDISP_FBBILL_FBCLAIM_FBAUTH_FBPAYT_FBOBL_"Y"
 S FBSTR=FBSTR_FBVID_FBMED_$E(PAD,1,29)_FBTDT_FBSTABR_"  "
 D STORE^FBAAV01
 ;
 D NEWLN^FBAAV6
 S FBCDCNT=1 ; count of codes in the line (=1 for admit dx)
 S FBSTR=FBSTR_$$DX^FBAAV6(FBADMTDX,FBCSVDT,"")
 ; loop thru Dx
 F FBI=1:1:25 Q:'$G(FBDX(FBI))  D
 . S FBCDCNT=FBCDCNT+1
 . I FBCDCNT=14 D
 . . D STORE^FBAAV01
 . . D NEWLN^FBAAV6
 . . S FBCDCNT=1
 . S FBSTR=FBSTR_$$DX^FBAAV6(FBDX(FBI),FBCSVDT,FBPOA(FBI))
 ; loop thru proc
 F FBI=1:1:25 Q:'$G(FBPRC(FBI))  D
 . S FBCDCNT=FBCDCNT+1
 . I FBCDCNT=14 D
 . . D STORE^FBAAV01
 . . D NEWLN^FBAAV6
 . . S FBCDCNT=1
 . S FBSTR=FBSTR_$$PROC^FBAAV6(FBPRC(FBI),FBCSVDT)
 ; pad remainder of last line with spaces and save it
 S FBSTR=$$LJ^XLFSTR(FBSTR,131," ")
 D STORE^FBAAV01
 ;
 D XMIT^FBAAV01 K FBFLAG
 W !,"Case sent to pricer.",!
 Q
 ; 
POA ; ask POA
 N DIR,Y
 S DIR(0)="P^161.94:EQM" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)
 S FBPOA(I)=+Y
 Q
ICD10() ;FB*3.5*139 JLG ICD-10 remediation
 N FBY,FBQUIT
ASK10 ;FB*3.5*139 JLG ICD-10 remediation 
 S FBY=$$ASKICD10^FBASF("Select ICD DIAGNOSIS","","Y")
 Q:(FBY>0)!(FBY=-3) FBY
 I (I>1)&(FBY'>0) S FBQUIT=-1 Q ""
 I '$G(FBDX(1)) W !,*7,"Must enter at least a primary diagnosis.",! G ASK10
 G ASK10
