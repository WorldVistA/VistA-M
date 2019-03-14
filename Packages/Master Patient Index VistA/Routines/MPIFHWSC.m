MPIFHWSC ;OAK/ELZ - MPIF HEALTHEVET WEB SERVICES CLIENT TOOLS ;3 APR 2012
 ;;1.0;MASTER PATIENT INDEX VISTA;**56,61,63**;30 Apr 99;Build 2
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
 ; future patches can call the DO SETUP^MPIFHWSC entry for post-init to setup a new HWSC 18.02 entry
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
 .D BMES^XPDUTL("**** Error cannot find file "_MPIPATH_MPIWSDL)
 I 'MPISTAT!($D(MPISTAT)'=11) D  Q 0
 .W !!,"**** WSDL file "_MPIWSDL_" not found in "_MPIPATH_"."
 .W !,"     You will need that prior to install."
 .S XPDQUIT=2
 Q MPIPATH
 ;
SETUP(MPIWSDL,MPISERV) ;  -- call to setup hwsc
 ;MPIWSDL - call with the wsdl file to setup, must be in the kernel default directory
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
 ; $$GETPROXY^XOBWLIB - #5421
 N $ETRAP,$ESTACK,SVC
 ; set error trap
 S $ETRAP="DO ERROR^MPIFHWSC"
 ; test mode (outgoing)?
 I $D(^XTMP("MPIFXML EDIT")) D TEST("OUTGOING",.MPIXML)
 ; make the call
 ;**63 STORY 317469 HTTPS OR HTTP
 N IEN,HTTPS S IEN=$O(^MPIF(984.8,"B","TWO","")),HTTPS=$P($G(^MPIF(984.8,IEN,0)),"^",4)
 I HTTPS=0!(HTTPS="") S SVC=$$GETPROXY^XOBWLIB("MPI_PSIM_EXECUTE","MPI_PSIM_EXECUTE")
 I HTTPS=1 S SVC=$$GETPROXY^XOBWLIB("MPI_PSIM_NEW EXECUTE","MPI_PSIM_NEW EXECUTE")
 S MPIXMLR=SVC.execute(MPIXML)
 ; in case debugging needed, save both out and return
 I $D(^XTMP("MPIFHWSC")) D
 .N MPIFSAVE
 .S MPIFSAVE=$O(^XTMP("MPIFHWSC",":"),-1)+1
 .S ^XTMP("MPIFHWSC",MPIFSAVE,0)=$$NOW^XLFDT
 .S ^XTMP("MPIFHWSC",MPIFSAVE,"OUT")=MPIXML
 .S ^XTMP("MPIFHWSC",MPIFSAVE,"RETURN")=MPIXMLR
 ; test mode (return)?
 I $D(^XTMP("MPIFXML EDIT")) D TEST("RETURN",.MPIXMLR)
 Q
 ;
ERROR ; - catch errors
 ; Set ecode to empty to return to calling function
 ;
 ; $$EOFAC^XOBWLIB, ZTER^XOBWLIB - #5421
 ; UNWIND^%ZTER - #1621
 N MPIERR
 S MPIERR=$$EOFAC^XOBWLIB()
 D ZTER^XOBWLIB(MPIERR)
 S $ECODE=""
 D UNWIND^%ZTER
 Q
 ;
TEST(TYPE,MPIXML) ; - call to possibly edit the xml string
 ; used for testing purposes only.
 ; production NOT allowed
 I $$PROD^XUPROD Q
 I $E($G(IOST),1,2)'="C-" Q
 ;
 N X,S,L,T,C,%,%Y
 W !!,"Do you want to edit the "_TYPE_" XML"
 S %=2 D YN^DICN I %'=1 Q
 K ^TMP("MPIFXMLT",$J)
 S L=0,T=""
 F X=1:1 S C=$E(MPIXML,X) Q:C=""  D
 . I C="<",T'="" S L=L+1,^TMP("MPIFXMLT",$J,L,0)=T,T=C Q
 . S T=T_C
 S DIC="^TMP(""MPIFXMLT"",$J,"
 D EN^DIWE
 S MPIXML=""
 S X=0 F  S X=$O(^TMP("MPIFXMLT",$J,X)) Q:'X  S MPIXML=MPIXML_^TMP("MPIFXMLT",$J,X,0)
 Q
