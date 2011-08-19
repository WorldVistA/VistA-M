IVMLDEM2 ;ALB/KCL - IVM DEMOGRAPHIC UPLOADABLE FIELDS ; 15-APR-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
EN ; - main entry point for IVM DEMOGRAPHIC UPLOADABLE
 N IVMENT
 D EN^VALM("IVM DEMOGRAPHIC UPLOADABLE")
 Q
 ;
 ;
HDR ; - header code for list manager display
 S IVMBLNK="",$P(IVMBLNK," ",45)=""
 ;
 ; - list manager header line 1
 S VALMHDR(1)="Patient: "_$E($E($P(^DPT(DFN,0),"^"),1,20)_" "_"("_$E($P(^DPT(DFN,0),"^",9),6,9)_")"_IVMBLNK,1,39)_" "_"Uploadable Demographic Fields"
 ;
 ; - list manager header line 2
 S VALMHDR(2)="  "
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
 S IVMWHERE="UP"
 ;
 K ^TMP("IVMUPLOAD",$J)
 S IVMBL="",$P(IVMBL," ",35)="",IVMCNTR=0
 D DEM^VADPT,ADD^VADPT S IVMSTATE="",IVMSTPTR=$P(VAPA(5),"^")
 F IVMDA=0:0 S IVMDA=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMDA)) Q:'IVMDA  D
 .;
 .; - grab node with IVM-supplied data
 .S IVMDEMO=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMDA,0)) I IVMDEMO="" Q
 .;
 .; - quit if data element is non-uploadable
 .S IVMTABLE=$G(^IVM(301.92,+$P(IVMDEMO,"^"),0))
 .Q:'$P(IVMTABLE,"^",3)
 .;
 .; - grab the IVM-supplied state
 .I $P(IVMTABLE,"^",2)["PID114" S IVMSTATE=$P(IVMDEMO,"^",2)
 .;
 .S IVMCNTR=IVMCNTR+1
 .;
 .; - extract DHCP value in displayable format
 .S IVMDHCP="" X:$D(^IVM(301.92,+$P(IVMDEMO,"^"),2)) ^(2) S IVMDHCP=Y
 .;
 .; - build index record to use for processing as
 .;    ^tmp("ivmupload",$j,"idx",ctr,ctr)=dfn^da(2)^da(1)^da^ivm data^pointer to file (#1)^dhcp field number^dhcp field name
 .;
 .S ^TMP("IVMUPLOAD",$J,"IDX",IVMCNTR,IVMCNTR)=DFN_"^"_IVMDA2_"^"_IVMDA1_"^"_IVMDA_"^"_$P(IVMDEMO,"^",2)_"^"_$P(IVMTABLE,"^",4)_"^"_$P(IVMTABLE,"^",5)_"^"_$P(IVMTABLE,"^")
 .;
 .; - build list manager display line
 .D WRITLINE($P(IVMTABLE,"^")_"^"_IVMDHCP_"^"_$P(IVMDEMO,"^",2),IVMCNTR)
 ;
 ;I '$O(@VALMAR@(0)) S @VALMAR@(1,0)=" ",@VALMAR@(2,0)="There is no uploadable demographic information to view.",IVMCNTR=2,^TMP("IVMUPLOAD",$J,"IDX",1,1)=1,^TMP("IVMUPLOAD",$J,"IDX",2,2)=2
 ;
 ;
 I '$O(@VALMAR@(0)) D
 .;
 .; - check for non-uploadable fields, if no fields do DELETE
 .I '$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,0) D DELETE^IVMLDEM5(IVMDA2,IVMDA1,IVMNAME)
 .;
 .; - if non-uploadable fields set array field from 'YES' to 'NO' for list manager display
 .I $$DEMO^IVMLDEM5(IVMDA2,IVMDA1,0) S $P(^TMP("IVMDUPL",$J,IVMNAME,IVMDA2,IVMDA1),"^",4)="NO"
 .;
 .; - display msg to user that no uploadable data to view
 .S @VALMAR@(1,0)=" "
 .S @VALMAR@(2,0)="There is no uploadable demographic information to view."
 .S IVMCNTR=2
 ;
 ; - list manager variable as number of lines in the list
 S VALMCNT=IVMCNTR
 ;
INITQ ; - clean up variables
 D KVA^VADPT ; kill all variables defined by VADPT routine
 K IVMBL,IVMBLNK,IVMCNTR,IVMDA,IVMDEMO,IVMDHCP,IVMFIELD,IVMSTATE,IVMSTPTR,IVMTABLE
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
 N IVMLN,IVMOUT1,IVMOUT2
 S IVMOUT1=$P(IVMLINE,"^",2)
 I $P(IVMTABLE,"^",7) S IVMOUT1=$$OUTTR^IVMUFNC(IVMOUT1,IVMTABLE,IVMSTPTR)
 S:IVMOUT1="" IVMOUT1="(* NONE ON FILE *)"
 S IVMOUT2=$$OUTTR^IVMUFNC($P(IVMLINE,"^",3),IVMTABLE,IVMSTATE)
 S IVMLN=$E($P(IVMLINE,"^",1)_IVMBL,1,30)_"  "_$E(IVMOUT1_IVMBL,1,20)_"  "_$E(IVMOUT2_IVMBL,1,20)
 D CNTRL^VALM10(IVMNUM,58,22,IOINHI,IOINORM) ; highlight IVM field value
 S @VALMAR@(IVMNUM,0)=$E(IVMNUM_"   ",1,3)_IVMLN
 Q
 ;
 ;
HELP ; - help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; - exit code
 K ^TMP("IVMUPLOAD",$J)
 Q
