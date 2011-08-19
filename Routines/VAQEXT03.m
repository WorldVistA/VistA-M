VAQEXT03 ;ALB/JFP - PDX, PROCESS EXTERNAL (MANUAL);01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Programmer entry point for manually rejecting PDX
 ;
 N VAQPR,VAQAUDT,VAQSENPT,VAQAUSIT,VAQDZN,VAQDZ
 N POP,DA,PARMNODE,FACDA,DOMDA
 ;
 D:$D(XRTL) T0^%ZOSV
 S VAQFLAG=1,POP=0
 W !,"Working ..."
 D PROCESS
 I POP K XRT0 QUIT
 W !!,"Manual process of entry queued "
 D EXIT
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV
 QUIT
 ;
PROCESS ; -- Finds an entry in the 'PDX TRANSACTION' file
 S X=VAQTRNO ; -- transaction to update (set in VAQEXT01)
 S DIC="^VAT(394.61,",DIC(0)="MZ"
 D ^DIC K DIC,X
 I Y<0 S POP=1 W !,"Error...Transaction record not found" QUIT
 S (VAQPR,DA)=+Y,VAQTRN=$P(Y,U,2)
 D LOAD,UPDATE Q:POP
 I $D(^TMP("CMNT",$J)) D CMNT
 S VAQTRN(VAQPR)="" ; -- Load an array of processed manual transactions
 ; -- Updates workload file
 S X=$$WORKDONE^VAQADS01($S(VAQST="REJ":"RJCT",VAQST="REL":"RLSE",VAQST="NFND":"UNKN",1:""),VAQPR,$G(DUZ))
 QUIT
 ;
LOAD ; -- Loads the data for update
 S %DT="ST",X="NOW" D ^%DT S VAQAUDT=Y ; -- date/time authori
 K %DT,X,Y
 S VAQSENPT=$$GETSEN^VAQUTL97(DFN) ; -- sensative patient
 S:VAQSENPT<0 VAQSENPT=""
 ;
 S PARMNODE=$G(^VAT(394.81,1,0))
 S FACDA=$P(PARMNODE,U,1),DOMDA=$P(PARMNODE,U,2)
 S VAQAUSIT=$P($G(^DIC(4,FACDA,0)),U,1) ; -- authori site
 S VAQAUADD=$P($G(^DIC(4.2,DOMDA,0)),U,1) ; -- authori addr
 ;
 S VAQDZN=$S($D(DUZ):$P(^VA(200,DUZ,0),U,1),1:"")
 S VAQDZ=$S($D(DUZ):DUZ,1:"") ; -- authorizer
 QUIT
 ;
UPDATE ; -- Sets DR string and non-constant variables for update
 S DR=".05///"_$S(VAQST="REJ":"VAQ-REJ",VAQST="REL":"VAQ-RSLT",VAQST="NFND":"VAQ-NTFND",1:"")
 I (DFN>0) S DR(1,394.61,.03)=".03////"_DFN ; -- local patient pointer
 S DR(1,394.61,.04)=".04///"_VAQSENPT
 ;S DR(1,394.61,.05)=".05///"_$S(VAQST="REJ":"VAQ-REJ",VAQST="REL":"VAQ-RSLT",VAQST="NFND":"VAQ-NTFND",1:"")
 S DR(1,394.61,50)="50///"_VAQAUDT
 S DR(1,394.61,51)="51///"_VAQDZN
 ;S DR(1,394.61,60)="60///"_VAQAUSIT
 ;S DR(1,394.61,61)="61///"_VAQAUADD
 ;
 S DIE="^VAT(394.61,"
 L +(@(DIE_DA_")")):60
 I ('$T) S POP=1 W !,"Could not edit entry... locked by other user)" QUIT
 D ^DIE
 L -(@(DIE_DA_")"))
 K DIE,DR
 QUIT
 ;
CMNT ; -- Loads comment for manual process reject or release (WORD PROCESSOR FIELD)
 S %X="^TMP(""CMNT"",$J,"
 S %Y="^VAT(394.61,"_DA_",""CMNT"","
 D %XY^%RCR
 K %X,%Y,^TMP("CMNT",$J)
 QUIT
 ;
EXIT ; -- Cleans up local variables
 K VAQPR,VAQAUDT,VAQSENPT,VAQAUSIT,VAQDZN,VAQDZ
 K POP,DA,PARMNODE,FACDA,DOMDA
 QUIT
 ;
END ; -- End of code
 QUIT
