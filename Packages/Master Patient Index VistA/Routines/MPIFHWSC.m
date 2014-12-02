MPIFHWSC ;OAK/ELZ - MPIF HEALTHEVET WEB SERVICES CLIENT TOOLS ;3 APR 2012
 ;;1.0;MASTER PATIENT INDEX VISTA;**56**;30 Apr 99;Build 2
 ;
ENV ; - environment check entry (first time with this patch only)
 ; this tag area can be removed with future patches
 ; future patches can call the $$CKSETUP^MPIFHWSC entry for environment
 ; check
 S X=$$CKSETUP("PSIMWSEXECUTE.WSDL")
 Q
 ;
POSTINT ; -- setup (first time with this patch only)
 ; this tag area can be removed with future patches
 ; future patches can call the DO SETUP^MPIFHWSC entry for post-init
 ; to setup a new HWSC 18.02 entry
 D SETUP("PSIMWSEXECUTE.WSDL","MPI_PSIM_EXECUTE")
 Q
 ;
CKSETUP(MPIWSDL) ; - used to check the environment
 ; returns the path to be used that was verified or 0 if it fails
 ;
 ; $$DEFDIR^%ZISH,$$LIST^%ZISH - #2320
 ; BMES^XPDUTL - #10141
 ;
 N MPISTAT,MPIPATH,MPIFILE
 S MPIPATH=$$DEFDIR^%ZISH()
 S MPIFILE(MPIWSDL)=""
 S MPISTAT=$$LIST^%ZISH(MPIPATH,"MPIFILE","MPISTAT")
 I 'MPISTAT!($D(MPISTAT)'=11),'$D(XPDENV) D  Q 0
 . D BMES^XPDUTL("**** Error cannot find file "_MPIPATH_MPIWSDL)
 I 'MPISTAT!($D(MPISTAT)'=11) D  Q 0
 . W !!,"**** WSDL file "_MPIWSDL_" not found in "_MPIPATH_"."
 . W !,"     You will need that prior to install."
 . S XPDQUIT=2
 Q MPIPATH
 ;
SETUP(MPIWSDL,MPISERV) ;  -- call to setup hwsc
 ;MPIWSDL - call with the wsdl file to setup, must be in the
 ;          kernel default directory
 ;
 ; $$GENPORT^XOBWLIB - #5421
 ;
 N MPISTAT,MPIPATH,MPIARR
 S MPIPATH=$$CKSETUP(MPIWSDL) I MPIPATH=0 Q
 S MPIFILE(MPIWSDL)=""
 S MPIARR("WSDL FILE")=MPIPATH_MPIWSDL
 S MPIARR("CACHE PACKAGE NAME")="MPIPSIM"
 S MPIARR("WEB SERVICE NAME")=MPISERV
 S MPIARR("AVAILABILITY RESOURCE")="?wsdl"
 S MPISTAT=$$GENPORT^XOBWLIB(.MPIARR)
 ;
 I 'MPISTAT D BMES^XPDUTL("**** Error creating Web Service (#18.02)"_MPISERV),MES^XPDUTL(MPISTAT) Q
 D BMES^XPDUTL(">>> "_MPISERV_" entry added to WEB SERVICE file #18.02")
 D BMES^XPDUTL("  - Be sure and set up the Web Server as in the post-install instructions!!")
 ;
 Q
 ;
POST(MPIXML,MPIXMLR) ; - post XML to the execute server
 ;
 ; $$GETPROXY^XOBWLIB - #5421
 ;
 N $ETRAP,$ESTACK,SVC
 ;
 ; set error trap
 S $ETRAP="DO ERROR^MPIFHWSC"
 ;
 ; make the call
 S SVC=$$GETPROXY^XOBWLIB("MPI_PSIM_EXECUTE","MPI_PSIM_EXECUTE")
 S MPIXMLR=SVC.execute(MPIXML)
 ;
 Q
 ;
ERROR ; - catch errors
 ; Set ecode to empty to return to calling function
 ;
 ; $$EOFAC^XOBWLIB, ZTER^XOBWLIB - #5421
 ; UNWIND^%ZTER - #1621
 ;
 N MPIERR
 S MPIERR=$$EOFAC^XOBWLIB()
 D ZTER^XOBWLIB(MPIERR)
 S $ECODE=""
 D UNWIND^%ZTER
 Q
 ;
