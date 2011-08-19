IVMLDEM3 ;ALB/KCL - IVM DEMOGRAPHIC NON-UPLOADABLE FIELDS ; 15-APR-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;**5**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
EN ; - main entry point for IVM DEMOGRAPHIC NON-UPLOADABLE
 D EN^VALM("IVM DEMOGRAPHIC NON-UPLOADABLE")
 Q
 ;
 ;
HDR ; - header code for list manager display
 S IVMBLNK="",$P(IVMBLNK," ",45)=""
 ;
 ; - header line 1
 S VALMHDR(1)="Patient: "_$E($E($P(^DPT(DFN,0),"^"),1,20)_" "_"("_$E($P(^DPT(DFN,0),"^",9),6,9)_")"_IVMBLNK,1,35)_" "_"Non-uploadable Demographic Fields"
 ;
 ; - header line 2
 S VALMHDR(2)=" "
 Q
 ;
 ;
INIT ; - init variables and list array
 ;
 ;  Input:  IVMDA2  --  Pointer to case record in file #301.5
 ;          IVMDA1  --  Pointer to PID msg in sub-file #301.501
 ;             DFN  --  Pointer to patient in file #2
 ;
 ;
 ; - flag used for delete demographic field action (DF)
 S IVMWHERE="NON"
 S IVMSTAT2=""
 K ^TMP("IVMNONUP",$J)
 S IVMBL="",$P(IVMBL," ",58)="",IVMCNTR=0,IVM27=0
 D DEM^VADPT,ADD^VADPT S IVMSTATE=$P(VAPA(5),"^")
 F IVMDA=0:0 S IVMDA=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMDA)) Q:'IVMDA  D
 .;
 .; - grab node with IVM-supplied data
 .S IVMDEMO=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMDA,0)) I IVMDEMO="" Q
 .;
 .; - quit if data element is uploadable
 .S IVMTABLE=$G(^IVM(301.92,+$P(IVMDEMO,"^"),0))
 .Q:$P(IVMTABLE,"^",3)=1
 .;
 .; - if ivm state data then set IVMSTAT2 for decoding county code
 .I $P(IVMTABLE,"^")["STATE" S IVMSTAT2=$P(IVMDEMO,"^",2)
 .;
 .S IVMCNTR=IVMCNTR+1
 .;
 .; - primary eligibility code
 .S:$P(IVMDEMO,"^")=27 IVM27=IVM27+1
 .;
 .; - extract DHCP value in displayable format
 .S IVMDHCP="" X:$D(^IVM(301.92,$P(IVMDEMO,"^"),2)) ^(2) S IVMDHCP=Y
 .;
 .; - build index record to use for processing as
 .;   ctr is line # and ctr1 is entry #
 .;    ^tmp("ivmnonup",$j,"idx",ctr,ctr1)=dfn^da(2)^da(1)^da^ivm data^pointer to file (#1)^dhcp field number^dhcp field name
 .;
 .S IVMCNTR1=$S(IVM27<2:IVMCNTR,1:IVMCNTR-IVM27+1)
 .S ^TMP("IVMNONUP",$J,"IDX",IVMCNTR,IVMCNTR1)=DFN_"^"_IVMDA2_"^"_IVMDA1_"^"_IVMDA_"^"_$P(IVMDEMO,"^",2)_"^"_$P(IVMTABLE,"^",4)_"^"_$P(IVMTABLE,"^",5)_"^"_$P(IVMTABLE,"^")
 .;
 .; - build list manager display line
 .D WRITLINE($P(IVMTABLE,"^")_"^"_IVMDHCP_"^"_$P(IVMDEMO,"^",2),IVMCNTR)
 ;
 ;
 I '$O(@VALMAR@(0)) D
 .;
 .; - check for uploadable fields, if no fields do DELETE
 .I '$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,1) D DELETE^IVMLDEM5(IVMDA2,IVMDA1,IVMNAME)
 .;
 .; - if uploadable fields set array field from 'YES' to 'NO' for list manager display
 .I $$DEMO^IVMLDEM5(IVMDA2,IVMDA1,1) S $P(^TMP("IVMDUPL",$J,IVMNAME,IVMDA2,IVMDA1),"^",5)="NO"
 .;
 .; - display msg to user that no uploadable data to view
 .D KILL^VALM10(1)
 .D KILL^VALM10(2)
 .S @VALMAR@(1,0)=" "
 .S @VALMAR@(2,0)="There is no non-uploadable demographic information to view."
 .S IVMCNTR=2
 ;
 ; - list manager variable as number of lines in the list
 S VALMCNT=IVMCNTR
 ;
 ;
INITQ ; - clean up variables
 D KVA^VADPT ; kill all variables defined by VADPT routine
 K IVMBL,IVMBLNK,IVMCNTR,IVMCNTR1,IVMDA,IVMDEMO,IVMDHCP,IVMFIELD
 K IVMSTAT2,IVMSTATE,IVMTABLE,IVM27
 Q
 ;
 ;
WRITLINE(IVMLINE,IVMNUM) ; - write line out for list manager display
 ;
 ;  Input:  IVMLINE  --  as the line for display:
 ;                       dhcp field name^dhcp field value^ivm field value
 ;           IVMNUM  --  as the line number
 ; Output:  None
 ;
 N IVMLN,IVMOUT1,IVMOUT2,IVMNUM1
 S IVMOUT1=$P(IVMLINE,"^",2)
 I $P(IVMTABLE,"^",7) S IVMOUT1=$$OUTTR^IVMUFNC(IVMOUT1,IVMTABLE,IVMSTATE)
 S:IVMOUT1="" IVMOUT1="(* NONE ON FILE *)"
 S IVMOUT2=$$OUTTR^IVMUFNC($P(IVMLINE,"^",3),IVMTABLE,IVMSTAT2)
 S IVMLN=$E($P(IVMLINE,"^",1)_IVMBL,1,30)_"  "_$E(IVMOUT1_IVMBL,1,20)_"  "_$E(IVMOUT2_IVMBL,1,20)
 ;
 ; - highlight IVM field value
 D CNTRL^VALM10(IVMNUM,58,22,IOINHI,IOINORM)
 I $P(IVMDEMO,"^")=27,IVM27>1 S @VALMAR@(IVMNUM,0)=IVMBL_$E(IVMOUT2_IVMBL,1,20) Q
 S IVMNUM1=$S(IVM27>1:IVMNUM-IVM27+1,1:IVMNUM)
 S @VALMAR@(IVMNUM,0)=$E(IVMNUM1_"   ",1,3)_IVMLN
 Q
 ;
 ;
HELP ; - help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; - exit code
 K ^TMP("IVMNONUP",$J)
 Q
