IVMLINS ;ALB/KCL,PHH - IVM INSURANCE UPLOAD ; 14-JAN-94
 ;;2.0;INCOME VERIFICATION MATCH;**14,94**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
EN ; - main entry point for IVM INSURANCE UPLOAD
 D BLD
 ;
 ; - if no patients in ASEG x-ref goto EXIT
 I IVMCTR=0 G EXIT
 ;
 S IVMINSUP=1
 ;
 ; - call list manager
 D EN^VALM("IVM INSURANCE UPLOAD")
 ;
 K IVMINSUP
 Q
 ;
 ;
BLD ; - build an array of patients with uploadable insurance data
 K ^TMP("IVMIUPL",$J)
 W !,"Building patient list for display..."
 ;
 ; - change (HLFS) if HL7 segment sep ever changes!
 S IVMCTR=0,HLFS="^"
 ;
 ; - get records from ASEG x-ref
 S IVMI=0 F  S IVMI=$O(^IVM(301.5,"ASEG","IN1",IVMI)) Q:'IVMI  D
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,"ASEG","IN1",IVMI,IVMJ)) Q:'IVMJ  D
 ..;
 ..S IVMCTR=IVMCTR+1 W:'(IVMCTR#15) "."
 ..;
 ..; - get node from IVM Patient (#301.5) file
 ..S IVM0NOD=$G(^IVM(301.5,IVMI,0)) I IVM0NOD']"" Q
 ..S DFN=+IVM0NOD
 ..;
 ..; - get HL7 segment string from (#301.511) sub-file
 ..S IVMSEG=$G(^IVM(301.5,IVMI,"IN",IVMJ,"ST")) I IVMSEG']"" Q
 ..S:$D(^IVM(301.5,IVMI,"IN",IVMJ,"ST1")) IVMSEG=IVMSEG_$G(^IVM(301.5,IVMI,"IN",IVMJ,"ST1"))
 ..;
 ..; - check for zeroth node Patient (#2) file
 ..I $G(^DPT(+DFN,0))']"" Q
 ..;
 ..; - get patient name and ssn
 ..S IVMNAME=$P($$PT^IVMUFNC4(DFN),"^"),IVMSSN=$P($$PT^IVMUFNC4(DFN),"^",2)
 ..;
 ..; - check for date of death from IVM
 ..S IVMDOD=$S($P($P($G(^IVM(301.5,IVMI,"IN",IVMJ,0)),"^",7),"/",2)]"":$P($P($G(^IVM(301.5,IVMI,"IN",IVMJ,0)),"^",7),"/",2),1:"")
 ..;
 ..; - check if patient has active insurance
 ..S IVMINS=$$INSUR^IBBAPI(DFN,DT),IVMINS=$S(IVMINS=1:"YES",1:"NO")
 ..;
 ..; - build line for list manager display
 ..D BLDLINE
 ;
 I IVMCTR=0 W !!,"There is no IVM insurance data to be uploaded at this time.",!,*7
 ;
BLDQ ; - clean up variables
 K DFN,IVM0NOD,IVMDOD,IVMINS,IVMNAME,IVMREC,IVMSEG,IVMSSN
 Q
 ;
 ;
BLDLINE ; - build storage array with data for list manager (called from BLD)
 S ^TMP("IVMIUPL",$J,IVMNAME,IVMI,IVMJ)=DFN_"^"_IVMSSN_"^"_IVMINS_"^"_$P(IVMSEG,HLFS,4)_"^"_$P(IVMSEG,HLFS,36)_"^"_IVMDOD
 ;
 ; ^tmp("ivmiupl",$j,pat name, ivm ien, ivm sub ien)=dfn^ssn^active insurance^ins company^subscriber id^ivm date of death
 Q
 ;
 ;
HDR ; - header code for list manager display
 S VALMHDR(1)="HEC has identified insurance for the following patients:"
 S VALMHDR(2)="   (*) - Indicates Death Reported  Act"
 Q
 ;
 ;
INIT ; - init variables and list array
 K ^TMP("IVMLST",$J)
 ;
 ; - set up blank line for padding display fields and init counter
 S IVMBL="",$P(IVMBL," ",40)="",IVMCTR=0
 ;
 S IVMNAME="" F  S IVMNAME=$O(^TMP("IVMIUPL",$J,IVMNAME)) Q:IVMNAME']""  S IVMI1="" D
 .F  S IVMI1=$O(^TMP("IVMIUPL",$J,IVMNAME,IVMI1)) Q:'IVMI1  S IVMJ1="" D
 ..F  S IVMJ1=$O(^TMP("IVMIUPL",$J,IVMNAME,IVMI1,IVMJ1)) Q:'IVMJ1  D
 ...;
 ...; - node from the data storage array
 ...S IVMLN=$G(^TMP("IVMIUPL",$J,IVMNAME,IVMI1,IVMJ1))
 ...;
 ...S IVMSTAR=$S($P(IVMLN,"^",6)]"":"*",$P($G(^DPT(+$P(IVMLN,"^"),.35)),"^")]"":"*",1:" ")
 ...;
 ...; - line for display
 ...S DFN=$P(IVMLN,"^"),IVMLN=$E(IVMNAME,1,25)_"^"_$P(IVMLN,"^",2,99)
 ...;
 ...; - increment counter and write line
 ...S IVMCTR=IVMCTR+1 D WRLN(IVMLN,IVMCTR)
 ...;
 ...; - create index array for look up
 ...S ^TMP("IVMLST",$J,"IDX",IVMCTR,IVMCTR)=IVMNAME_"^"_$P(IVMLN,"^",2)_"^"_IVMI1_"^"_IVMJ1
 ...; ^tmp("ivmlst",$j,"idx",counter,counter)=pat name^pat ssn^ien (#301.5) file^ien (#301.501) sub file
 ;
 ; - VALMCNT as the number of lines in the list
 S VALMCNT=IVMCTR
 ;
INTQ ; - clean up variables
 K DFN,IVMBL,IVMCTR,IVMI,IVMI1,IVMJ,IVMJ1,IVMLN,IVMNAME,IVMSSN,IVMSTAR,LINE,NUMBER
 Q
 ;
 ;
WRLN(LINE,NUMBER) ; - write line out for list manager display
 ;
 ;  Input:    LINE  --  as pat name^pat ssn^active ins^ins carrier^subscriber id
 ;          NUMBER  --  as line number
 ;
 ; Output:  None
 ;
 N IVMLN
 S IVMLN=$E(IVMSTAR_$P(LINE,"^",1)_IVMBL,1,16)_"  "_$E($P(LINE,"^",2)_IVMBL,1,11)_"  "_$E($P(LINE,"^",3)_IVMBL,1,3)_"  "_$E($P(LINE,"^",4)_IVMBL,1,24)_"  "_$P(LINE,"^",5)
 S @VALMAR@(NUMBER,0)=$E(NUMBER_"     ",1,4)_IVMLN
 Q
 ;
 ;
HELP ; - help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;
EXIT ; - exit code
 K ^TMP("IVMLST",$J),^TMP("IVMIUPL",$J)
 Q
