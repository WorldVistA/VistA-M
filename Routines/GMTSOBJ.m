GMTSOBJ ; SLC/KER - HS Object - Create/Test/Display   ; 01/06/2003
 ;;2.7;Health Summary;**58,63**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA  2320  $$DEL^%ZISH
 ;   DBIA  2320  $$FTG^%ZISH
 ;   DBIA  2320  $$PWD^%ZISH
 ;   DBIA  2320  CLOSE^%ZISH
 ;   DBIA  2320  OPEN^%ZISH
 ;   DBIA 10006  ^DIC (file #142.5 and #2)
 ;   DBIA 10013  ^DIK
 ;   DBIA  2054  $$CREF^DILF
 ;   DBIA  2054  $$OREF^DILF
 ;   DBIA 10026  ^DIR
 ;   DBIA 10103  $$NOW^XLFDT
 ;                      
 Q
MGR ; Create/Modify Health Summary Object (Manager)
 N GMTSMGR S GMTSMGR="" G OBJ
 ;             
DEVOBJ ; Create/Modify Health Summary Object (Developer)
 N GMTSDEV S GMTSDEV=5000
 ;             
OBJ ; Create/Modify Health Summary Object
 ;   Option:  GMTS OBJ ENTER/EDIT
 ;            Create/Modify Health Summary Object
 N BOLD,DA,DFN,DIC,DIE,DIR,DIROUT,DLAYGO,DR,DTOUT,DUOUT,GMP,GMTS
 N GMTSBLK,GMTSCHD,GMTSCON,GMTSDEC,GMTSDEF,GMTSDIF,GMTSDLD,GMTSDT
 N GMTSHDR,GMTSI,GMTSL,GMTSLBL,GMTSLEN,GMTSLIM,GMTSNEW,GMTSO,GMTSOBJ
 N GMTSOBN,GMTSPER,GMTSPRO,GMTSPX1,GMTSPX2,GMTSQ,GMTSR,GMTSRDT,GMTSRHD
 N GMTST,GMTSTD,GMTSTIM,GMTSTYP,GMTSUNIT,GMTSUNT,GMTSV,GMTSVER,GMTSX
 N IOINHI,IOINORM,NORM,OBJ,D,D0,D1,DI,DILN,X,Y
 S DIC("S")="I +Y<50000000!(+Y>59999999)" K:+($G(GMTSDEV))=5000 DIC("S")
 D OBJ^GMTSOBA
 Q
 ;             
CRE(NAME) ; Create/Modify Health Summary Object named 'NAME'
 ;
 ;   Input    NAME    Name of Object to Create or Edit
 ;   Output   Internal Entry Number of Object file if 
 ;            found or created
 ;
 N X,BOLD,DA,DFN,DIC,DIE,DIR,DIROUT,DLAYGO,DR,DTOUT,DUOUT,GMP,GMTS
 N GMTSBLK,GMTSCHD,GMTSCON,GMTSDEC,GMTSDEF,GMTSDIF,GMTSDLD,GMTSDT
 N GMTSHDR,GMTSI,GMTSL,GMTSLBL,GMTSLEN,GMTSLIM,GMTSNAM,GMTSNEW,GMTSO
 N GMTSOBJ,GMTSOBN,GMTSPER,GMTSPRO,GMTSPX1,GMTSPX2,GMTSQ,GMTSR,GMTSRDT
 N GMTSRHD,GMTST,GMTSTD,GMTSTIM,GMTSTYP,GMTSUNIT,GMTSUNT,GMTSV,GMTSVER
 N GMTSX,IOINHI,IOINORM,NORM,OBJ,D,D0,D1,DI,DILN,Y S GMTSNAM=$G(NAME)
 S:'$L(GMTSNAM) GMTSNAM=$$NAME^GMTSOBV("") Q:'$L(GMTSNAM) -1
 S DIC("S")="I +Y<50000000!(+Y>59999999)" K:+($G(GMTSDEV))=5000 DIC("S")
 D OBJ^GMTSOBA K DIC S DIC="^GMT(142.5,",DIC(0)="XM",X=GMTSNAM
 D ^DIC,CRD^GMTSOBV(+Y),^DIC S X=+Y S:X'>0 X=-1
 Q X
 ;             
TYPE(NAME) ; Edit Health Summary Type named NAME
 ;
 ;   Input    NAME    Name of Health Summary Type to Edit
 ;   Output   None
 D ET^GMTSOBA2($G(NAME))
 Q
 ;                    
INQ ; Inquire to Health Summary Object
 ;   Option:  GMTS OBJ INQ
 ;            Health Summary Object Inquiry
 N DIC,D,D0,D1,DI,DILN,GMTSP,GMTSPL,GMTSL,GMTSEXIT
 S U="^",DIC="^GMT(142.5,",DIC(0)="AEMQF",GMTSP=$G(IOST),GMTSPL=0,GMTSL=0,GMTSEXIT=0
 S DIC("A")=" Select Health Summary Object:  " D ^DIC K DIC("A")
 W:$L($G(IOF)) @IOF W:+($G(Y))>0 ! D:+($G(Y))>0 SO^GMTSOBS(+Y),CONT^GMTSOBS
 Q
 ;             
DEVDEL ; Delete Health Summary Object (Developer)
 N GMTSDEV S GMTSDEV=5000
 ;             
DEL ; Delete Health Summary Object
 ;   Option:  GMTS OBJ DELETE
 ;            Delete Health Summary Object
 N D,D0,D1,DI,DILN,DIC,DIR,DIK,DA,X,Y,GMTSP,GMTSPL,GMTSL,GMTSEXIT S U="^",(DIK,DIC)="^GMT(142.5,",DIC(0)="AEMQF"
 I $$UACT^GMTSU2(+($G(DUZ)))'>0 W !!," >> You are not authorized to delete a Health Summary Object." Q
 S DIC("A")=" Select Health Summary Object to Delete:  "
 S DIC("S")="I (+($P($G(^GMT(142.5,+Y,0)),""^"",17))=0!(+($P($G(^GMT(142.5,+Y,0)),""^"",17))=+($G(DUZ))))&(+($P($G(^GMT(142.5,+Y,0)),""^"",20))'>0)"
 S:'$D(GMTSDEV) DIC("S")="I +($$DEL^GMTSOBV(+Y))>0"
 K:$D(GMTSDEV) DIC("S") I +($G(Y))>50000000,+($G(Y))<59999999,'$D(GMTSDEV) W !,"     Can not delete a nationally exported object." Q
 D ^DIC I +($G(Y))>0 D
 . N GMTSDEL,GMTSO S GMTSDEL="" W ! D SO^GMTSOBS(+Y)
 . S DA=+Y,GMTSO=$P($G(^GMT(142.5,+Y,0)),"^",1)
 . S:$L(GMTSO) GMTSO=" """_GMTSO_""""
 . S DIR("B")="NO",DIR(0)="YAO",DIR("A")=" Delete Health Summary Object"_GMTSO_"?  "
 . S (DIR("?"),DIR("??"))="     Enter either 'Y' or 'N'."
 . W ! D ^DIR I +Y>0 D ^DIK
 . I '$D(^GMT(142.5,+DA,0)) W !,"     <deleted>",!
 Q
 ;             
TEST ; Test Health Summary Object
 ;   Option:  GMTS OBJ TEST
 ;            Test a Health Summary Object
 N BOLD,D,D0,D1,DI,DILN,DA,DFN,DIC,DIE,DIR,DIROUT,DLAYGO,DR,DTOUT
 N DUOUT,GMP,GMTS,GMTSBLK,GMTSCHD,GMTSCON,GMTSDEC,GMTSDEF,GMTSDIF
 N GMTSDLD,GMTSDT,GMTSHDR,GMTSI,GMTSL,GMTSLBL,GMTSLEN,GMTSLIM,GMTSNEW
 N GMTSO,GMTSOBJ,GMTSOBN,GMTSPER,GMTSPRO,GMTSPX1,GMTSPX2,GMTSQ,GMTSR
 N GMTSRDT,GMTSRHD,GMTST,GMTSTD,GMTSTIM,GMTSTYP,GMTSUNIT,GMTSUNT
 N GMTSV,GMTSVER,GMTSX,IOINHI,IOINORM,NORM,OBJ,X,Y
 D PAT^GMTSOBV I +($G(DFN))'>0 W !!,"    No Patient Selected" Q
 S GMTSL=$G(IOSL) N IOSL S IOSL=99999999
 S DIC="^GMT(142.5,",DIC("A")=" Select HEALTH SUMMARY OBJECT to test:  ",U="^"
 S DIC(0)="AEMQ" K DLAYGO D ^DIC S GMTSOBJ=+($G(Y))
 I +GMTSOBJ'>0 W !!,"    No Health Summary Object Selected" Q
 K ^TMP("GMTSOBJ",$J,DFN) D GET(DFN,GMTSOBJ),DEV^GMTSOBS
 Q
 ;             
EXP ; Export a Health Summary Object
 D EN^GMTSOBE
 Q
 ;             
INS ; Install Imported Health Summary Object
 D EN^GMTSOBI
 Q
 ;             
GET(DFN,OBJ) ; Get Health Summary Object
 ;
 ;   Input    DFN     IEN for Patient (#2)
 ;            OBJ     IEN for Health Summary Object (#142.5)
 ;
 ;   Output   Global array of Health Summary data
 ;
 ;                    ^TMP("GMTSOBJ",$J,DFN,#,0)
 ;
 K ^TMP("GMTSOBJ",$J,DFN) D ARY(DFN,OBJ,$NA(^TMP("GMTSOBJ",$J,DFN)))
 Q
 ;             
TIU(DFN,OBJ) ; Get Health Summary Object (TIU)
 ;
 ;   Input    DFN     IEN for Patient (#2)
 ;            OBJ     IEN for Health Summary Object (#142.5)
 ;
 ;   Output   Global array of Health Summary data
 ;
 ;                    ^TMP("TIUHSOBJ",$J,"FGBL",0)
 ;                    ^TMP("TIUHSOBJ",$J,"FGBL",#,0)
 ;
 N ERRMSG,HSTYPE
 S HSTYPE=$P($G(^GMT(142.5,OBJ,0)),U,3)
 I $G(HSTYPE)="" Q "No Health Summary Report Found"
 I $D(^GMT(142,HSTYPE,1))'>0 D  Q ERRMSG
 . S ERRMSG="There are no components in the Health Summary Type:  "_$P($G(^GMT(142,HSTYPE,0)),U)
 K ^TMP("TIUHSOBJ",$J) D ARY(DFN,OBJ,$NA(^TMP("TIUHSOBJ",$J,"FGBL")))
 Q:+($G(^TMP("TIUHSOBJ",$J,"FGBL",0)))>0 "~@"_$NA(^TMP("TIUHSOBJ",$J,"FGBL"))
 Q "No Health Summary Report Found"
 ;             
ARY(DFN,OBJ,ROOT) ; Build Array ROOT
 ;
 ;   Input    DFN     IEN for Patient (#2)
 ;            OBJ     IEN for Health Summary Object (#142.5)
 ;            ROOT    Closed root (global or local array)
 ;
 ;   Output   Array of Health Summary data in ROOT
 ;
 N GMTSBLK,GMTSFILE,GMTSHFN,GMTSNC,GMTSNCT,GMTSND,GMTSNDT,GMTSNN,GMTSIOM
 N GMTSPATH,GMTSPRE,GMTSRT,GMTSRTO,GMTSRTC,GMTSRNN,GMTSRNC,GMTS0,POP,X,Y
 Q:$G(^GMT(142.5,+($G(OBJ)),0))=""  S GMTSRT=$G(ROOT)
 Q:'$L(GMTSRT)  Q:$E(GMTSRT,1)'="^"&($E(GMTSRT,1)'?1U)
 S GMTSRTO=$$OREF^DILF(GMTSRT),GMTSRTC=$$CREF^DILF(GMTSRT)
 Q:'$L(GMTSRTO)  Q:'$L(GMTSRTC)  Q:'$L($TR(GMTSRTC,")",""))
 Q:$E(GMTSRTO,$L(GMTSRTO))'=","&($E(GMTSRTO,$L(GMTSRTO))'="(")
 Q:GMTSRTO'[$TR(GMTSRTC,")","")  S GMTS0=GMTSRTO_"0)"
 S GMTSPATH=$$PWD^%ZISH,GMTSFILE=$J_$TR($$NOW^XLFDT,".","")_".DAT"
 D OPEN^%ZISH("WRITEFILE",GMTSPATH,GMTSFILE,"W"),DIS(+($G(DFN)),+($G(OBJ)))
 D CLOSE^%ZISH("WRITEFILE") K ^TMP("GMTSOBJ",$J,"OGBL")
 S Y=$$FTG^%ZISH(GMTSPATH,GMTSFILE,$NA(^TMP("GMTSOBJ",$J,"OGBL",1)),4)
 S GMTSHFN(GMTSFILE)="",Y=$$DEL^%ZISH(GMTSPATH,$NA(GMTSHFN))
 S (GMTSBLK,GMTSNCT,GMTSPRE)=0 S GMTSNN="^TMP(""GMTSOBJ"","_$J_",""OGBL"")"
 S GMTSNC="^TMP(""GMTSOBJ"","_$J_",""OGBL"","
 F  S GMTSNN=$Q(@GMTSNN) Q:GMTSNN=""!(GMTSNN'[GMTSNC)  D
 . S GMTSND=@GMTSNN,GMTSNDT=$$TRIM^GMTSOBV(GMTSND)
 . I 'GMTSBLK S:GMTSNDT="" GMTSBLK=1 Q:GMTSBLK
 . Q:GMTSPRE&(GMTSNDT="")  S GMTSNCT=GMTSNCT+1
 . S @(GMTSRTO_GMTSNCT_",0)")=GMTSND
 . S @GMTS0=$G(@GMTS0)+1
 . S GMTSPRE=$S(GMTSNDT="":1,1:0)
 K ^TMP("GMTSOBJ",$J,"OGBL")
 Q
 ;             
SHOW(X) ; Show a Health Summary Object Definition
 ;
 ;   Input    X       IEN for Health Summary Object (#142.5)
 ;                          
 D SO^GMTSOBS(+($G(X)))
 Q
EXTRACT(X,ARY) ; Show a Health Summary Object Definition
 ;
 ;   Input    X       IEN for Health Summary Object (#142.5)
 ;   Output   ARY()   Array of fields and values
 ;                    (passed by reference)
 ;                           
 ;      ARY(IEN,<field #>,"I") = Internal Value
 ;      ARY(IEN,<field #>,"E") = External Value
 ;      ARY(IEN,<field #>,"NAME") = Field Name
 ;      ARY(IEN,<field #>,"PROMT") = Mixed Case of Field Name
 ;                
 D GET^GMTSOBS2(+($G(X)),.ARY)
 Q
DEF(X,ARY) ; Extract a Health Summary Object Definition
 ;
 ;   Input    X       IEN for Health Summary Object (#142.5)
 ;   Output   ARY()   Array of fields and values
 ;                    (passed by reference)
 ;                           
 ;      ARY("D",0) = # of lines in Definition
 ;      ARY("D",#) = Definition Text
 ;      ARY("E",0) = # of lines in Example
 ;      ARY("E",#) = Example Text
 ;                
 D DEF^GMTSOBS(+($G(X)),.ARY)
 Q
DIS(DFN,OBJ) ; Display Object
 ;
 ;   Input    DFN     IEN for Patient (#2)
 ;            OBJ     IEN for Health Summary Object (#142.5)
 ;
 ;   Output   Display of Health Summary data
 ;
 D DIS^GMTSOBS2(+($G(DFN)),$G(OBJ))
 Q
STMP ; Show TMP
 N GMTSNN,GMTSNC S GMTSNN="^TMP(""GMTSOBJ"","_$J_",""OGBL"")",GMTSNC="^TMP(""GMTSOBJ"","_$J_",""OGBL"","
 F  S GMTSNN=$Q(@GMTSNN) Q:GMTSNN=""!(GMTSNN'[GMTSNC)  W !,GMTSNN,"=",@GMTSNN
 Q
