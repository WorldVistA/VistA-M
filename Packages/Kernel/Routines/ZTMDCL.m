ZTMDCL ;SFISC/RWF - Run Taskman with a DCL context. ;09/11/2006
 ;;8.0;KERNEL;**24,355**;Jul 10, 1995;Build 9
 ;This assumes that TM was started with a DCL context.
 N FILE,QUEUE,ENV,%SPAWN,%
 S FILE=$S(%ZTOS["OpenM":"ZTMS2WDCL.COM",%ZTOS["DSM":"ZTMSWDCL.COM",1:"")
 S QUEUE=$S($L(ZTNODE):ZTNODE,1:%ZTNODE)
 S ENV=%ZTPFLG("DCL")
 I %ZTOS["OpenM" D
 . S ENV=$S($L(ZTNODE):ZTNODE,1:$P(%ZTPAIR,":",2))
 . S QUEUE=$G(%ZTPFLG("Q",ENV))
 I ENV="" D ^%ZTER Q  ;Something is wrong
 ;Use the next line if you want/need log files
 ;S %SPAWN="SUBMIT/NOPRINT/KEEP/QUEUE=TM$"_QUEUE_" DHCP$TASKMAN:"_FILE_"/PARAM=("_ENV_","_ZTUCI_","_ZTDVOL_")"
 ;Use the next line if you don't need log files.
 S %SPAWN="SUBMIT/NOPRINT/NOLOG/QUEUE=TM$"_QUEUE_" DHCP$TASKMAN:"_FILE_"/PARAM=("_ENV_","_ZTUCI_","_ZTDVOL_")"
 I %ZTOS["VAX DSM" S %=$ZC(%SPAWN,%SPAWN) I 1
 I %ZTOS["OpenM" S %=$ZF(-1,%SPAWN) I 1
 Q
 ;
