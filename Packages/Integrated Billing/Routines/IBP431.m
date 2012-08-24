IBP431 ;ALB/PJH - POST INSTALL FOR IB*2.0*431 ; 4/25/11 5:24pm
 ;;2.0;INTEGRATED BILLING;**431**;21-MAR-94;Build 106
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
POST ;Called from IB*2*431 patch install 
 ;
 ;Move EOB file #361.1 fields to new location
 ;
 N OK,PROG
 S PROG="IBP431"
 K ^TMP(PROG,$J)
 D BMES^XPDUTL("Converting EXPLANATION OF BENEFIT FILE")
 S OK=$$MOVE(PROG)
 I OK D BMES^XPDUTL("Conversion COMPLETED")
 I 'OK D BMES^XPDUTL("Conversion ABORTED")
 K ^TMP(PROG,$J)
 Q
 ;
MAIL ;Send mail message
 N XMDUZ,XMTEXT,XMSUB,XMY,XMINSTR
 S XMDUZ=DUZ
 S XMTEXT="^TMP(""IBP431"","_$J_")"
 S XMSUB="IB*2.0*431 Post Install - Completed"
 S XMY(DUZ)=""
 S XMINSTR("FROM")="VistA routine IBP431"
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.XMINSTR)
 Q
 ;
MOVE(PROG) ;Move existing field to new global node
 ;
 ;Moves field CROSSED OVER NAME (361.1, #.08)
 ;from ^IBM(361.1,D0,0) piece 8
 ;to ^IBM(361.1,D0,51) piece 2
 ;
 N C,I,M,N,VALUE,X,X1,X2,%
 S C=0,M=0
 ;Lock ^XTMP
 L +^XTMP(PROG):5 E  Q 0
 ;Update mail message
 D NOW^%DTC S M=M+1,^TMP(PROG,$J,M)="Started "_$$FMTE^XLFDT(%)
 ;XTMP purge Date is today+90
 S X1=DT,X2=90 D C^%DTC
 ;Set up ^XTMP header
 S ^XTMP(PROG,0)=X_"^"_DT_"^IB*2.0*431 Post Install"
 ;Scan file moving non-null fields only into ^XTMP and new location
 ;and clear field in original location
 S N=0 F I=1:1 S N=$O(^IBM(361.1,N)) Q:'N  S VALUE=$P($G(^IBM(361.1,N,0)),U,8) I VALUE]"" S C=C+1,^XTMP(PROG,C)=VALUE_U_N,$P(^IBM(361.1,N,51),U,2)=VALUE,$P(^IBM(361.1,N,0),U,8)=""
 ;Completion time
 D NOW^%DTC
 S $P(^XTMP(PROG,0),U,4)=X
 S M=M+1,^TMP(PROG,$J,M)="Completed "_$$FMTE^XLFDT(%)
 S M=M+1,^TMP(PROG,$J,M)="Count of records in EOB file - "_(I-1)
 S M=M+1,^TMP(PROG,$J,M)="Count of fields moved - "_+C
 ;Send mail message to patch installer
 D MAIL
 ;Release ^XTMP
 L -^XTMP(PROG)
 Q 1
 ;
RESET ;Restore original fields
 Q
 N DIR,N,C,VALUE,Y
 S DIR("A")="Move data to original location"
 S DIR(0)="Y",DIR("B")="YES" D ^DIR Q:Y'=1
 S C=0
 F  S C=$O(^XTMP("IBP431",C)) Q:'C  D
 .;Get values saved in ^XTMP
 .S VALUE=$P(^XTMP("IBP431",C),U),N=$P(^XTMP("IBP431",C),U,2)
 .;Ignore if not present
 .Q:(VALUE="")!('N)
 .;Do not update if node is not defined
 .Q:$G(^IBM(361.1,N,0))=""
 .;Or if data already exists in field
 .Q:$P($G(^IBM(361.1,N,0)),U,8)]""
 .;Otherwise reset original value
 .S $P(^IBM(361.1,N,0),U,8)=VALUE
 .;And clear from 51 node
 .K ^IBM(361.1,N,51)
 Q
