VAFCHFS ;BIR/DLR-BUILD HFS FILE FOR CAPTURING REPORT DATA ;08/20/01
 ;;5.3;Registration;**414,477**;Aug 13, 1993
 ;;Routine uses the following supported IAs #2263, #2320, #2336, and #2992.
HFS(LINETAG) ;
 N VAFCDIR,VAFCFILE,POP
 D HFSOPEN("RPC") I POP D  Q
 .S ^TMP("VAFCHFS",$J,1)="ERROR: UNABLE TO ACCESS HFS DIRECTORY "_VAFCDIR_" FILE "_VAFCFILE
 .S ^TMP("VAFCHFS",$J,2)="PLEASE CHECK DIRECTORY WRITE PRIVILEGES."
 U IO
 D @LINETAG
 D HFSCLOSE("RPC")
 ;M RESULTS=^TMP($J)
 Q
 ;
HFSOPEN(HANDLE) ;
 S VAFCDIR=$$GET^XPAR("SYS","VAFC HFS SCRATCH")
 S VAFCFILE="VAFC"_DUZ_".DAT"
 S IOM=132,IOSL=99999,IOST="P-DUMMY",IOF=""""""
 D OPEN^%ZISH(HANDLE,VAFCDIR,VAFCFILE,"W") Q:POP
 Q
 ;
HFSCLOSE(HANDLE) ;
 N VAFCDIR,VAFCFILE,VAFCDEL
 D CLOSE^%ZISH(HANDLE)
 K ^TMP("VAFCHFS",$J)
 S VAFCDIR=$$GET^XPAR("SYS","VAFC HFS SCRATCH")
 S VAFCFILE="VAFC"_DUZ_".DAT",VAFCDEL(VAFCFILE)=""
 S X=$$FTG^%ZISH(VAFCDIR,VAFCFILE,$NAME(^TMP("VAFCHFS",$J,1)),3)
 S X=$$DEL^%ZISH(VAFCDIR,$NA(VAFCDEL))
 Q
 ;
HFSGET(RM,GOTO) ;
 ;RM=Right margin
 S:'$G(RM) RM=80
 N ZTQUEUED,VAFCHFS,VAFCSUB,VAFCIO
 S VAFCHFS="VAFC_"_$J_".DAT",VAFCSUB="VAFCDATA"
 D OPEN(.RM,.VAFCHFS,"W",.VAFCIO)
 D @GOTO
 D CLOSE(.VAFCRM,.VAFCHFS,.VAFCSUB,.VAFCIO)
 Q
 ;
OPEN(VAFCRM,VAFCHFS,VAFCMODE,VAFCIO) ; -- open WORKSTATION device
 ;   VAFCRM: right margin
 ;  VAFCHFS: host file name
 ; VAFCMODE: open file in 'R'ead or 'W'rite mode
 S ZTQUEUED="" K IOPAR
 S IOP="OR WORKSTATION;"_$G(VAFCRM,80)
 S %ZIS("HFSMODE")=VAFCMODE,%ZIS("HFSNAME")=VAFCHFS
 D ^%ZIS K IOP,%ZIS
 U IO S VAFCIO=IO
 Q
 ;
CLOSE(VAFCRM,VAFCHFS,VAFCSUB,VAFCIO) ; -- close WORKSTATION device
 ; VAFCSUB: unique subscript name for output 
 I IO=VAFCIO D ^%ZISC
 U IO
 D USEHFS
 U IO
 Q
USEHFS ; -- use host file to build global array
 N IO,VAFCK,SECTION
 S SECTION=0
 S VAFCK=$$FTG^%ZISH(,VAFCHFS,$NA(^TMP($J,1)),2) I 'VAFCK Q
 N VAFCRR S VAFCRR(VAFCHFS)=""
 S VAFCK=$$DEL^%ZISH("",$NA(VAFCRR))
 Q
EDIT ;edit the HFS directory
 D EDITPAR^XPAREDIT("VAFC HFS SCRATCH")
 Q
DSPPDAT(VAFC) ;
 ; Output
 ;   VAFC - array passed back with the display formatted PDAT call
 N CNT,X,TXT
 S CNT=0,X=0 F  S X=$O(^TMP("VAFCHFS",$J,X)) Q:'X  S TXT=^TMP("VAFCHFS",$J,X) D  I $S<3000 S VAFC(CNT)="*** QUERY TERMINATED DUE TO VOLUME OF DATA FOR SELECTED DATE RANGE ***" Q  ;**477
 . I $E(TXT,1,20)="Treating Facilities:" S VAFC(CNT)="" S CNT=CNT+1
 . I $E(TXT,1,12)="Subscribers:" S VAFC(CNT)="" S CNT=CNT+1
 . I $E(TXT,1,12)="ICN History:" S VAFC(CNT)="" S CNT=CNT+1
 . I $E(TXT,1,13)="CMOR History:" S VAFC(CNT)="" S CNT=CNT+1
 . I $E(TXT,1,28)="CMOR Change Request History:" S VAFC(CNT)="" S CNT=CNT+1
 . I TXT'="" I $E(TXT,1,12)'="Enter RETURN" S VAFC(CNT)=^TMP("VAFCHFS",$J,X),CNT=CNT+1
 K ^TMP("VAFCHFS",$J)
 Q
CREATE ;create entry in File #8989.51 for remote HFS functionality
 N VAFC,VAFC1,ARRAY,Y,VAFCY
 S VAFC=$$FIND1^DIC(8989.51,"","X","VAFC HFS SCRATCH","B","","ERR")
 I VAFC>0 D
 . K DIC,DA,DO,X,DIE,DR S DIC=8989.51,DIC(0)="X",X="VAFC HFS SCRATCH" D ^DIC
 . S VAFCY=+Y L +^XTV(8989.51,VAFCY):5
 . S DIE=DIC,DA=+Y S DR=".02///Scratch HFS Directory;.03///0;.05///Directory name;1.1///F;1.2///1:250;1.3///Enter in an OS level directory with read/write/edit/delete privileges.;30///1",DR(2,8989.513)=".01///1;.02///4.2" D ^DIE  D
 .. L -^XTV(8989.51,VAFCY)
 .. K DIC,DA,DO,X,DIE,DR
 . S VAFC1=$$FIND1^DIC(8989.51,"","X","VAFC HFS SCRATCH","B","","ERR")
 . S ARRAY(1,1)="This fields should contain the directory specifications for the Kernel"
 . S ARRAY(1,2)="OPEN^%ZISH call.  The directory should be wide open with"
 . S ARRAY(1,3)="read/write/edit/delete privileges."
 . S ARRAY(1,4)="Example:"
 . S ARRAY(1,5)="A2$dir aij$:[000000]tcp$spool.dir /own/prot"
 . S ARRAY(1,6)="      Directory AIJ$:[000000]"
 . S ARRAY(1,7)="      TCP$SPOOL.DIR;1      [SYSTEM] (RWED,RWED,RWED,RWED)"
 . D WP^DIE(8989.51,VAFC1_",",20,"","ARRAY(1)")
 I VAFC<1 D
 . K FDA
 . S FDA(1,8989.51,"+1,",.01)="VAFC HFS SCRATCH"
 . S FDA(1,8989.51,"+1,",.02)="Scratch HFS Directory"
 . S FDA(1,8989.51,"+1,",.03)=0
 . S FDA(1,8989.51,"+1,",.05)="Directory name"
 . S FDA(1,8989.51,"+1,",1.1)="F"
 . S FDA(1,8989.51,"+1,",1.2)="1:250"
 . S FDA(1,8989.51,"+1,",1.3)="Enter in an OS level directory with read/write/edit/delete privileges."
 . S FDA(1,8989.513,"+2,+1,",.01)=1
 . S FDA(1,8989.513,"+2,+1,",.02)="4.2"
 . D UPDATE^DIE("","FDA(1)","FDAIEN") K FDA
 . S VAFC1=$$FIND1^DIC(8989.51,"","X","VAFC HFS SCRATCH","B","","ERR")
 . S ARRAY(1,1)="This fields should contain the directory specifications for the Kernel"
 . S ARRAY(1,2)="OPEN^%ZISH call.  The directory should be wide open with"
 . S ARRAY(1,3)="read/write/edit/delete privileges."
 . S ARRAY(1,4)="Example:"
 . S ARRAY(1,5)="A2$dir aij$:[000000]tcp$spool.dir /own/prot"
 . S ARRAY(1,6)="      Directory AIJ$:[000000]"
 . S ARRAY(1,7)="      TCP$SPOOL.DIR;1      [SYSTEM] (RWED,RWED,RWED,RWED)"
 . D WP^DIE(8989.51,VAFC1_",",20,"","ARRAY(1)")
 D EDIT
 Q
