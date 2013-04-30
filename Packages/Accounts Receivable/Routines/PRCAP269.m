PRCAP269 ;ALB/PJH - PRCA*4.5*269 POST INSTALL ; 3/9/11 12:50pm
 ;;4.5;Accounts Receivable;**269**;Mar 20, 1995;Build 113
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
POST ;Called from PRCA*4.5*269 patch install
 ;
 ;Move ERA file #344.4 and EFT file #344.31 fields to new locations
 ;
 N M,OK,PROG,X,X1,X2
 S PROG="PRCAP269"
 ;Clear workfile
 K ^TMP(PROG,$J)
 ;
 ;Lock ^XTMP
 L +^XTMP(PROG):5 E  D BMES^XPDUTL("Conversion ABORTED") Q
 ;XTMP purge Date is today+90
 S X1=DT,X2=90 D C^%DTC
 ;Set up ^XTMP header
 S ^XTMP(PROG,0)=X_"^"_DT_"^PRCA*4.5*269 Post Install"
 ;
 D BMES^XPDUTL("Deleting Obsolete Cross References")
 D DELIX^DDMOD(344.31,.02,1) ;PAYER NAME - "C"
 D DELIX^DDMOD(344.31,.04,1) ;TRACE # - "D"
 D DELIX^DDMOD(344.4,.02,1) ;TRACE # - "D"
 D DELIX^DDMOD(344.42,.01,1) ;REFERENCE NUMBER - "B"
 ;
 D BMES^XPDUTL("Converting EDI THIRD PARTY EFT DETAIL FILE")
 D MOVEEFT
 ;
 D BMES^XPDUTL("Converting ELECTRONIC REMITTANCE ADVICE file")
 D MOVEERA,MOVEERA1,MOVEERA2
 ;
 ;Send mail message to patch installer
 D MAIL
 ;
 ;Send mail message to CBO release coordinators
 D MAILCBO
 ;
 ;Clear workfile
 K ^TMP(PROG,$J)
 ;
 D BMES^XPDUTL("Conversion COMPLETED")
 ;Release ^XTMP
 L -^XTMP(PROG)
 Q
 ;
MAIL ;Installer mail message
 N XMDUZ,XMTEXT,XMSUB,XMY,XMINSTR
 S XMDUZ=DUZ
 S XMTEXT="^TMP(""PRCAP269"","_$J_")"
 S XMSUB="PRCA*4.5*269 Post Install - Completed"
 S XMY(DUZ)=""
 S XMINSTR("FROM")="VistA routine PRCAP269"
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.XMINSTR)
 Q
 ;
MAILCBO ;CBO notification mail message
 N %,INSTNAME,M,MSG,SITE,STATION,X,XMDUZ,XMTEXT,XMSUB,XMY,XMINSTR
 S M=0
 D NOW^%DTC
 ;IA - 10112 supported reference
 S SITE=$$SITE^VASITE,STATION=$P(SITE,U,3),INSTNAME=$P(SITE,U,2)
 S M=M+1,MSG(M)="Institution Name: "_INSTNAME
 S M=M+1,MSG(M)="Station Number  : "_STATION
 S M=M+1,MSG(M)=""
 S M=M+1,MSG(M)="Completed Install "_$$FMTE^XLFDT(%)
 S XMDUZ=DUZ
 S XMTEXT="MSG"
 S XMSUB="ePayments - Station "_STATION
 S XMY(DUZ)=""
 S:$$PROD^XUPROD(1) XMY("VHACBOEPAY5010@domain.ext")=""
 S XMINSTR("FROM")="VistA routine PRCAP269"
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.XMINSTR)
 ;
 I $D(^TMP("XMERR",$J)) D
 .D MES^XPDUTL("MailMan reported a problem trying to send the installation notification message.")
 .D MES^XPDUTL("  ")
 .N GLO,GLB
 .S GLB="^TMP(""XMERR"","_$J,GLO=GLB_")"
 .F  S GLO=$Q(@GLO) Q:GLO'[GLB  D MES^XPDUTL("   "_GLO_" = "_$G(@GLO))
 .D MES^XPDUTL("  ")
 Q
 ;
MOVEEFT ;Move existing EFT (File #344.31) field to new global node
 ;
 ;Moves field ACH TRACE # (.15)
 ;from ^RCY(344.31,D0,0) piece 15
 ;to ^RCY(344.31,D0,1) piece 1
 ;
 ;Moves field MANUAL TR DOCUMENT (.16)
 ;from ^RCY(344.31,D0,0) piece 16
 ;to ^RCY(344.31,D0,1) piece 2
 ;
 N %,C,I,N,VALUE,X
 S C=0,M=0
 ;Update mail message
 D NOW^%DTC
 S M=M+1,^TMP(PROG,$J,M)="Started EFT file at "_$$FMTE^XLFDT(%)
 ;Scan file moving non-null fields only into ^XTMP and new location
 ;and clear field in original location
 S N=0 F I=1:1 S N=$O(^RCY(344.31,N)) Q:'N  S VALUE=$P($G(^RCY(344.31,N,0)),U,15,16) I $P(VALUE,U)'="",$P(VALUE,U,2)'="" S C=C+1,^XTMP(PROG,"EFT",C)=VALUE_U_N,^RCY(344.31,N,1)=VALUE,$P(^RCY(344.31,N,0),U,15)="",$P(^RCY(344.31,N,0),U,16)=""
 ;Completion time
 D NOW^%DTC
 S M=M+1,^TMP(PROG,$J,M)="Completed EFT file at "_$$FMTE^XLFDT(%)
 S M=M+1,^TMP(PROG,$J,M)="Count of records in EFT file - "_(I-1)
 S M=M+1,^TMP(PROG,$J,M)="Count of fields moved        - "_+C
 Q
 ;
 ;
MOVEERA ;Move existing ERA (File #344.4) field to new global node
 ;
 ;Moves field CHECK# (.13)
 ;from ^RCY(344.4,D0,0) piece 13
 ;to ^RCY(344.4,D0,5) piece 2
 ;
 ;
 N %,C,I,N,VALUE,X
 S C=0
 ;Update mail message
 D NOW^%DTC
 S M=M+1,^TMP(PROG,$J,M)="Started ERA file at "_$$FMTE^XLFDT(%)
 ;Scan file moving non-null fields only into ^XTMP and new location
 ;and clear field in original location
 S N=0 F I=1:1 S N=$O(^RCY(344.4,N)) Q:'N  S VALUE=$P($G(^RCY(344.4,N,0)),U,13) I VALUE]"" S C=C+1,^XTMP(PROG,"ERA",C)=VALUE_U_N,$P(^RCY(344.4,N,5),U,2)=VALUE,$P(^RCY(344.4,N,0),U,13)=""
 ;Completion time
 D NOW^%DTC
 S M=M+1,^TMP(PROG,$J,M)="Completed ERA file at "_$$FMTE^XLFDT(%)
 S M=M+1,^TMP(PROG,$J,M)="Count of records in ERA file - "_(I-1)
 S M=M+1,^TMP(PROG,$J,M)="Count of fields moved        - "_+C
 Q
 ;
MOVEERA1 ;Move existing ERA (File #344.41) field to new global node
 ;
 ;Moves field REN PROV COMMENT (#.23)
 ;from ^RCY(344.4,D0,1,D1,3) piece 5
 ;to ^RCY(344.4,D0,1,D1,4) piece 1
 ;
 ;
 N %,C,I,N,N1,VALUE,X
 S C=0
 ;Update mail message
 D NOW^%DTC
 S M=M+1,^TMP(PROG,$J,M)="Started ERA,1 file at "_$$FMTE^XLFDT(%)
 ;Scan file moving non-null fields only into ^XTMP and new location
 ;and clear field in original location
 S N=0,I=0
 F  S N=$O(^RCY(344.4,N)) Q:'N  S N1=0 D
 .F  S N1=$O(^RCY(344.4,N,1,N1)) Q:'N1  D
 ..S I=I+1,VALUE=$P($G(^RCY(344.4,N,1,N1,3)),U,5) I VALUE]"" S C=C+1,^XTMP(PROG,"ERA1",C)=VALUE_U_N_U_N1,^RCY(344.4,N,1,N1,4)=VALUE,$P(^RCY(344.4,N,1,N1,3),U,5)=""
 ;Completion time
 D NOW^%DTC
 S M=M+1,^TMP(PROG,$J,M)="Completed ERA,1 file at "_$$FMTE^XLFDT(%)
 S M=M+1,^TMP(PROG,$J,M)="Count of records in ERA,1 file - "_+I
 S M=M+1,^TMP(PROG,$J,M)="Count of fields moved          - "_+C
 Q
 ;
MOVEERA2 ;Move existing ERA (File #344.42) field to new global node
 ;
 ;Moves field ADJUSTMENT TEXT (#.04)
 ;from ^RCY(344.4,D0,2,D1,0) piece 4
 ;to ^RCY(344.4,D0,2,D1,1) piece 1
 ;
 ;
 N %,C,I,N,N1,VALUE,X
 S C=0
 ;Update mail message
 D NOW^%DTC
 S M=M+1,^TMP(PROG,$J,M)="Started ERA,2 file at "_$$FMTE^XLFDT(%)
 ;Scan file moving non-null fields only into ^XTMP and new location
 ;and clear field in original location
 S N=0,I=0
 F  S N=$O(^RCY(344.4,N)) Q:'N  S N1=0 D
 .F  S N1=$O(^RCY(344.4,N,2,N1)) Q:'N1  D
 ..S I=I+1,VALUE=$P($G(^RCY(344.4,N,2,N1,0)),U,4) I VALUE]"" S C=C+1,^XTMP(PROG,"ERA2",C)=VALUE_U_N_U_N1,^RCY(344.4,N,2,N1,1)=VALUE,$P(^RCY(344.4,N,2,N1,0),U,4)=""
 ;Completion time
 D NOW^%DTC
 ;Also update XTMP as complete
 S $P(^XTMP(PROG,0),U,4)=X
 S M=M+1,^TMP(PROG,$J,M)="Completed ERA,2 file at "_$$FMTE^XLFDT(%)
 S M=M+1,^TMP(PROG,$J,M)="Count of records in ERA,2 file - "_+I
 S M=M+1,^TMP(PROG,$J,M)="Count of fields moved          - "_+C
 Q
