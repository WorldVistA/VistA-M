SCMCPR1 ;ALB/SCK - API FILE FOR STAFF ASSIGNMENTS ; 9/14/05 12:10pm
 ;;5.3;Scheduling;**41,45,264,297**;AUG 13, 1993
 ;;1.0
 Q
 ;
URSLKUP(SCDAT,SCUSR,SCVAL,SCREEN,SCINST,SCPC) ;
 ;   Does a lookup in the USR #8930.3 file based on the user class match passed in
 ;
 ;  Input 
 ;      SCUSR  User class to use for lookup
 ;      SCVAL  Partial User name to lookup on
 ;   
 ;   Returns an array of matches found, or an error array.        
 ;   Format for array:        
 ;        SCDATA(1)=[Data]
 ;        SCDATA(x)=IEN^New Users Name^Title
 ;
 ;   Format for Error:
 ;       SCDATA(1)=[Errors]
 ;       SCDATA(x)=" message "
 ;
 N SCI,N,SCRTN,SCTMP,SCTITLE,SCIEN,SCN,SCUERR
 ;
 I SCUSR']""&(SCINST=1) D  G USRQ
 . S N=0
 . D SETF("[Errors]")
 . D SETF("No User Class Defined")
 ;
 IF $L(SCVAL)<3&(SCINST=0) D  G USRQ
 . S N=0
 .D SETF("[Errors]")
 .D SETF("Insufficient characters to match")
 ;
 S N=0
 IF SCINST=1 D
 . D LIST^DIC(200,"",".01;8;28","","","",SCVAL,"","IF $$ISA^USRLM(Y,SCUSR,.SCUERR)","","")
 ;
 IF SCINST=0 D
 .D LIST^DIC(200,"",".01;8;28","","","",SCVAL,"",SCREEN,"","")
 ;
 S N=0
 D SETF("[Data]")
 S I="" F  S I=$O(^TMP("DILIST",$J,1,I)) Q:'I  D
 . S SCTMP=^TMP("DILIST",$J,2,I)_U
 . I $G(SCPC) I $O(^SD(403.46,+SCPC,2,0)) N PC S PC=0 D  Q:'PC  ;Put back for provider by role
 .. N CODE S CODE=$$GET^XUA4A72(+SCTMP) D  Q:PC
 ... I $D(^SD(403.46,+SCPC,2,+CODE)) S PC=1
 . S:SCINST SCTMP=SCTMP_$$CLNAME^USRLM(+SCUSR)
 . S SCTMP=SCTMP_U_U_U_U_^TMP("DILIST",$J,1,I)
 . S SCTMP=SCTMP_U_^TMP("DILIST",$J,"ID",I,8)
 . S SCTMP=SCTMP_U_^TMP("DILIST",$J,"ID",I,28)
 . D SETF(SCTMP)
 ;
 K ^TMP("DILIST",$J)
USRQ Q
 ;
SETF(X) ;
 S N=N+1
 S SCDAT(N)=X
 Q
 ;
 ;
TEST(CHK) ;
 N SC,SCCHECK
 K SCK
 IF CHK=1 D
 . S DIC="^USR(8930,",DIC("A")="Enter User Class: ",DIC(0)="AEMZ"
 . D ^DIC
 . W !,Y,!
 . R "Lookup: ",X:60
 . Q:'$G(Y)>0
 . D URSLKUP(.SCK,$P(Y,U),X,"",CHK)
 ;
 IF CHK=0 D
 . R "Name: ",X:60
 . D URSLKUP(.SCK,"",X,"",CHK)
 ;
 ;;;W ! ZW SCK
TESTQ Q
