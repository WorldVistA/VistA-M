SCCVDEL ;ALB/TMP - OLD SCHED VISITS FILE DELETE; [ 03/04/98  09:39 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
EN ; Main entry point - display scheduling files to delete
 N Z
 D DT^DICRW
 D FULL^VALM1
 W !!,*7,"                 *** WARNING ***"
 W !,"This action allows PERMANENT DELETION of old Scheduling files!"
 W !,"If you are at all uncertain about this option, DO NOT delete any files.",!!
 D PAUSE^SCCVU
 D EN^VALM("SCCV CONV DELETE FILE MENU")
 Q
 ;
INIT ; -- set up initial variables
 D FNL
 S U="^",VALMCNT=0,VALMBG=1
 D BLD
 Q
 ;
FNL ; Clean up
 K ^TMP("SCCV.DELETE",$J),^TMP("SCCV.DELETE.DX",$J)
 K SCCVFIL
 S VALMBCK="Q"
 Q
 ;
BLD ;Build parameter display
 N SCCVFIL,SCCVFNM,SCCVGBL,SCCVST,SCCVDDT,SCCVEDT
 S SCCVEDT=+$G(^SD(404.91,1,"CNV")) IF 'SCCVEDT S SCCVEDT=9999999 ; earliest date
 S VALMBG=1
 K ^TMP("SCCV.DELETE",$J),^TMP("SCCV.DELETE.DX",$J)
 S VALMCNT=0
 F SCCVFIL=40.1,40.15,409.5,409.43,409.44 D
 . S VALMCNT=VALMCNT+1,X=""
 . S SCCVFNM=$$FNAME(SCCVFIL)
 . S SCCVGBL=$$FGLB(SCCVFIL)
 . S SCCVDDT=$$FDELDT(SCCVFIL)
 . S SCCVST=2                                 ; nothing deleted
 . IF SCCVDDT<SCCVEDT S SCCVST=3              ; can't delete
 . IF $D(@SCCVGBL)=0 S SCCVST=0               ; data deleted
 . IF SCCVST,$D(^DIC(SCCVFIL,0))=0 S SCCVST=1 ; dd deleted
 . S X=$$SETFLD^VALM1(VALMCNT,X,"NUMBER")
 . S X=$$SETFLD^VALM1(SCCVFIL,X,"FNUMBER")
 . S X=$$SETFLD^VALM1(SCCVFNM,X,"FNAME")
 . S X=$$SETFLD^VALM1(SCCVGBL,X,"GLOBAL")
 . S X=$$SETFLD^VALM1($S('SCCVST:"Data and DD Deleted",SCCVST=1:"DD Deleted Only",SCCVST=2:"Nothing Deleted",1:"Deletion Not Allowed"),X,"STATUS")
 . ;
 . S ^TMP("SCCV.DELETE",$J,VALMCNT,0)=X
 . S ^TMP("SCCV.DELETE",$J,"IDX",VALMCNT,VALMCNT)=""
 . S ^TMP("SCCV.DELETE"_".DX",$J,VALMCNT)=SCCVFIL_U_SCCVST_U_"("_SCCVFNM_")"
 Q
 ;
DELDD ; Delete DDs and templates for files
 N VALMY,SCCV,SCCVFIL
 D FULL^VALM1
 W !
 ;
 IF '$$GAP() G DELDDQ
 ;
 IF '$$COMPL() G DELDDQ
 ;
 I '$O(^SD(404.98,0))!'$$COMPL^SCCVPAR(1) D  G:'SCOK DELDDQ
 . N DIR,Y
 . S DIR("B")="NO"
 . S DIR(0)="YA"
 . S DIR("A",1)="It appears that no conversion was completed at your site."
 . S DIR("A",2)="If you choose to continue, all data in the old Scheduling files could be lost."
 . S DIR("A")="Are you sure you want to do this?: "
 . D ^DIR K DIR
 . S SCOK=(Y=1)
 ;
 S DIR(0)="YA"
 S DIR("A",1)="This action will PERMANENTLY DELETE any selected files!"
 S DIR("A")="Are you absolutely sure you want to do this?: "
 S DIR("B")="NO"
 D ^DIR K DIR
 G:Y'=1 DELDDQ
 ;
 W !
 D EN^VALM2($G(XQORNOD(0)))
 S SCCV=0 F  S SCCV=$O(VALMY(SCCV)) Q:'SCCV  D
 . S SCCVFIL=$G(^TMP("SCCV.DELETE.DX",$J,SCCV))
 . IF $P(SCCVFIL,U,2)=3 D  Q
 . . W !!,"Deleting File # "_+SCCVFIL_" "_$P(SCCVFIL,U,3)," is not allowed."
 . . W !,"You did not convert back to '"_$$FMTE^XLFDT($$FDELDT(+SCCVFIL),"5Z")_"'."
 . . D PAUSE^SCCVU
 . . ;
 . IF $P(SCCVFIL,U,2)'=2 D  Q
 . . W !!,"DD and templates for File # "_+SCCVFIL_" "_$P(SCCVFIL,U,3)
 . . W !,"have already been deleted!"
 . . D PAUSE^SCCVU
 . D DELFIL(+SCCVFIL,$P(SCCVFIL,U,3))
 D BLD
DELDDQ S VALMBCK="R"
 Q
 ;
GAP() ; -- check to see if there gaps in conversion
 ; -- return: 1 - no gap | 0 - gaps exist
 N SCOK
 S SCOK=0
 I $$SEQGAP^SCCVPAR() D  G GAPQ
 . N DIR,Y,SCDT1
 . S SCDT1=$P($G(^SD(404.91,1,"CNV")),U)
 . S:SCDT1 SCDT1=$$FMTE^XLFDT(SCDT1,"5Z")
 . W !,"You have one or more gaps in conversion dates from your earliest"
 . W !,"date to convert ("_$S(SCDT1'="":SCDT1,1:"NOT ENTERED")_") to 09/30/1996."
 . W !,"You must finish converting before you can delete any of these files."
 . D PAUSE^SCCVU
 S SCOK=1
GAPQ Q SCOK
 ;
COMPL() ; -- check if conversion complete flag is set
 ; -- return: 1 - set | 0 - not set
 N SCOK
 S SCOK=0
 I '$P($G(^SD(404.91,1,"CNV")),U,4) D  G COMPLQ
 . W !,"No file deletes can be performed until a date has been"
 . W !,"recorded in the conversion site parameters indicating"
 . W !,"that the conversion is complete."
 . D PAUSE^SCCVU
 S SCOK=1
COMPLQ Q SCOK
 ;
DELFIL(FNO,FNM) ;Delete dd and templates for the specified file #FNO
 ; FNM = the file name in ()
 N DIR,Y,SCOK
 S SCOK=0
 ;
 S DIR(0)="YA"
 S DIR("B")="NO"
 S DIR("A",1)="I am about to PERMANENTLY DELETE file #"_FNO_" "_FNM_"!"
 S DIR("A")="Are you absolutely sure you want to do this? "
 D ^DIR
 K DIR
 S SCOK=Y
 ;
 IF SCOK=1 D
 . S DIR(0)="YA"
 . S DIR("B")="NO"
 . S DIR("A")="Does your site have a backup/archive of this file? "
 . D ^DIR
 . K DIR
 . S SCOK=Y
 . ;
 . ; -- log user and date/time info
 . IF SCOK=1 D
 . . S Y=$$LOG(FNO,$G(DUZ),"DD")
 . . S SCOK=+Y
 . . IF 'Y D
 . . . W !,"Cannot delete data dictionary and templates for file!"
 . . . W !,$P(Y,U,2)
 ;
 I SCOK=1 D  G DFQ
 . W !!,"Data Dictionary and Template Deletion of"
 . W !,"file # "_FNO_" "_FNM_" is in process...",!
 . S DIU=FNO
 . S DIU(0)="ET"
 . D EN^DIU2
 . W !!,"Data Dictionary and Templates for File # "_FNO_" "_FNM
 . W !,"have been deleted."
 . D MSG(FNO)
 ;
 W !,"Data Dictionary and Templates for File # "_FNO_" "_FNM
 W !,"have NOT been deleted."
 ;
DFQ D PAUSE^SCCVU
 Q
 ;
MSG(FNO) ; -- display protect message
 N SCGLB
 S SCGLB=$$FGLB(FNO)
 W !
 W !,"NOTE:  Only the data dictionary and templates have been"
 W !,"       deleted."
 W !
 W !,"       In order to delete the data, execute the following action:"
 W !,"                  Data Global Deletion"
 W !
 ;
 IF FNO=409.43!(FNO=409.44) G MSGQ
 ;
 W !,"       However, you must first determine if KILLing at the global"
 W !,"       root level is allowed for this global '",SCGLB,"' on your"
 W !,"       system."
 W !
 W !,"       Unfortunately, there is no programmer API to check this"
 W !,"       global characteristic using Kernel tools."
 W !
 W !,"       If you need help checking and setting this global parameter,"
 W !,"       please contact National VistA Support (NVS)."
 W !
MSGQ Q
 ;
LOG(FILE,USER,TYPE) ; -- log file deletion
 N SCFIN,SCRET,SCDEL,DIE,DA,Y,DR,X
 S SCRET="1^Log data successfully filed."
 ;
 IF $G(TYPE)="DD"!(TYPE="DATA") D
 . S SCDEL("TYPE")=TYPE
 ELSE  D
 . S SCRET="0^Not a valid deletion type"
 ;
 IF 'SCRET G LOGQ
 ;
 IF $G(FILE) D
 . IF FILE=409.5!(FILE=409.43)!(FILE=409.44)!(FILE=40.1)!(FILE=40.15) D
 . . S SCDEL("FILE")=FILE
 . ELSE  D
 . . S SCRET="0^Not a file that can be deleted."
 ELSE  D
 . S SCRET="0^No file specified."
 ;
 IF 'SCRET G LOGQ
 ;
 IF $G(USER) D
 . S SCDEL("USER")=USER
 ELSE  D
 . S SCRET="0^No user specified."
 ;
 IF 'SCRET G LOGQ
 ;
 S SCDEL("DATE/TIME")=$$NOW^XLFDT
 ;
 L +^SD(404.91,1):2
 IF '$T S SCRET="0^Unable to lock SCHEDULING PARAMETER file." G LOGQ
 S DIE="^SD(404.91,",DA=1,DR="[SCCV CONV FILE DELETION LOG]" D ^DIE
 L -^SD(404.91,1)
 IF '$G(SCFIN) S SCRET="0^Filing of deletion log data failed." G LOGQ
 ;
LOGQ Q SCRET
 ;
FNAME(FNO) ; -- get file name
 N F
 S F(40.1)="OPC"
 S F(40.15)="OPC ERRORS"
 S F(409.5)="SCHEDULING VISITS"
 S F(409.43)="OUTPATIENT DIAGNOSIS"
 S F(409.44)="OUTPATIENT PROVIDER"
 Q F(FNO)
 ;
FGLB(FNO) ; -- get data global for file
 N F
 S F(40.1)="^SDASF"
 S F(40.15)="^SDASE"
 S F(409.5)="^SDV"
 S F(409.43)="^SDD(409.43)"
 S F(409.44)="^SDD(409.44)"
 Q F(FNO)
 ;
FDELDT(FNO) ; -- get date the site must convert back to in order to delete
 ; file dd and data
 N F
 S F(40.1)=9999998
 S F(40.15)=9999998
 S F(409.5)=2871001
 S F(409.43)=2931001
 S F(409.44)=2931001
 Q F(FNO)
 ;
