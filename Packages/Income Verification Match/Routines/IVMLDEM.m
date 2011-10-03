IVMLDEM ;ALB/KCL - IVM DEMOGRAPHIC UPLOAD PATIENT DISPLAY ; 11-APR-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
EN ; - main entry point
 N IVMENT
 D BUILD
 I IVMCTR=0 G EXIT ; if no patients with demographic info - quit
 D EN^VALM("IVM DEMOGRAPHIC")
 Q
 ;
 ;
BUILD ; - build an array of IVM patients with demographic data for uploading
 K ^TMP("IVMDUPL",$J)
 W !,"Building patient list for display..."
 S IVMCTR=0
 ;
 ; - get patients with demographic fields from ASEG x-ref
 S IVMI=0 F  S IVMI=$O(^IVM(301.5,"ASEG","PID",IVMI)) Q:'IVMI  D
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,"ASEG","PID",IVMI,IVMJ)) Q:'IVMJ  D
 ..S IVMCTR=IVMCTR+1 W:'(IVMCTR#15) "."
 ..;
 ..; - grab node from file #301.5
 ..S IVM0NODE=$G(^IVM(301.5,IVMI,0)) I IVM0NODE']"" Q
 ..;
 ..; - get DFN and grab node from file #2
 ..S DFN=+IVM0NODE,IVM0DPT=$G(^DPT(+DFN,0)) I IVM0DPT']"" Q
 ..;
 ..; - patient name and ssn
 ..S IVMNAME=$P(IVM0DPT,"^"),IVMSSN=$P(IVM0DPT,"^",9),IVMSSN=$E(IVMSSN,1,3)_"-"_$E(IVMSSN,4,5)_"-"_$E(IVMSSN,6,9)
 ..;
 ..; - check for uploadable and non-uploadable fields
 ..S IVMUP=$S($$DEMO^IVMLDEM5(IVMI,IVMJ,1)=1:"YES",1:"NO")
 ..S IVMINFO=$S($$DEMO^IVMLDEM5(IVMI,IVMJ,0)=1:"YES",1:"NO")
 ..;
 ..; - build line for list manager display
 ..D BUILDLN
 ;
 I IVMCTR=0 W !!,"There is no IVM demographic information to be uploaded at this time.",!,*7
 ;
BUILDQ ; - clean up variables
 K DFN,IVM0NODE,IVM0DPT,IVMCHK,IVMI,IVMINFO,IVMJ,IVMNAME,IVMSSN,IVMUP
 Q
 ;
 ;
BUILDLN ; - build storage array with data for List Manager (called from BLD)
 ;
 S ^TMP("IVMDUPL",$J,IVMNAME,IVMI,IVMJ)=DFN_"^"_IVMNAME_"^"_IVMSSN_"^"_IVMUP_"^"_IVMINFO
 ;
 ; ^tmp("ivmdupl",$j,pat name, ivm ien, ivm sub ien)=dfn^patient name^patient ssn^demo uploadable^demo info only
 Q
 ;
 ;
HDR ; -  header code for list manager display
 S VALMHDR(1)="Patient Demographic Information" ; header line 1
 S VALMHDR(2)="                                                   Uploadable     Non-uploadable" ; header line 2
 Q
 ;
 ;
INIT ; - init variables and list array
 K ^TMP("IVMLST",$J)
 S IVMBL="",$P(IVMBL," ",30)="",IVMCTR=0
 S IVMNAME="" F  S IVMNAME=$O(^TMP("IVMDUPL",$J,IVMNAME)) Q:IVMNAME']""  S IVMI="" D
 .F  S IVMI=$O(^TMP("IVMDUPL",$J,IVMNAME,IVMI)) Q:'IVMI  S IVMJ="" D
 ..F  S IVMJ=$O(^TMP("IVMDUPL",$J,IVMNAME,IVMI,IVMJ)) Q:'IVMJ  D
 ...;
 ...; - IVMLN as the line for the list manager display
 ...S IVMLN=$G(^TMP("IVMDUPL",$J,IVMNAME,IVMI,IVMJ)) I IVMLN']"" Q
 ...;
 ...; - increment counter and write line
 ...S IVMCTR=IVMCTR+1 D WRLN(IVMLN,IVMCTR)
 ...;
 ...; - build index record to use for processing as
 ...; ^tmp("ivmlst",$j,"idx",ctr,ctr)=dfn^pat name^ien (#301.5) file^ien (#301.501) sub file
 ...S ^TMP("IVMLST",$J,"IDX",IVMCTR,IVMCTR)=$P(IVMLN,"^",1)_"^"_IVMNAME_"^"_IVMI_"^"_IVMJ
 ;
 ; - list manager variable as number of lines in the list
 S VALMCNT=IVMCTR
 ;
INITQ ; - clean up variables
 K DFN,IVMBL,IVMCTR,IVMI,IVMJ,IVMLINE,IVMLN,IVMNAME,IVMNUM
 Q
 ;
 ;
WRLN(IVMLINE,IVMNUM) ; - write line out for list manager display
 ;
 ;  Input:  IVMLINE  --  as line for display
 ;                       dfn^pat name^pat ssn^uploadable (yes/no)^non-uploadable (yes/no)
 ;           IVMNUM  --  as the line number
 ; Output:  None
 ;
 N IVMLN
 S IVMLN=$E($P(IVMLINE,"^",2)_IVMBL,1,30)_"  "_$E($P(IVMLINE,"^",3)_IVMBL,1,15)_"  "_$E($P(IVMLINE,"^",4)_IVMBL,1,13)_"  "_$P(IVMLINE,"^",5)
 I $P(IVMLINE,"^",4)["YES" D CNTRL^VALM10(IVMNUM,55,3,IOINHI,IOINORM) ; highlight
 S @VALMAR@(IVMNUM,0)=$E(IVMNUM_"     ",1,5)_IVMLN
 Q
 ;
 ;
HELP ; - help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;
EXIT ; - exit code
 K ^TMP("IVMLST",$J),^TMP("IVMDUPL",$J)
 Q
