IVMCMFB ;ALB/RMM - SEND INCOME TEST TRANSMISSION BULLETIN ; 07/24/03
 ;;2.0;INCOME VERIFICATION MATCH;**71,82**;21-OCT-94
 ;
BULL(DFN,DGMTDT,IVMERR,SCTST) ;
 ; Send mail message notifying site of an income test that was completed
 ; containing data inconsistencies.
 ;
 ;  Input array required:
 ;    "IVMERR("  --  contains lists of inconsistencies from tests 
 ;                   which were uploaded (ORU~Z10 and ORF~Z10)
 ;
 N DIFROM,XMDUZ,XMTEXT,XMSTRIP,XMROU,XMY,XMZ,XMDF,IVMGRP,IVMPAT
 S XMDF=""
 S XMDUZ=""
 S XMTEXT="IVMTXT("
 S XMY(DUZ)=""
 S IVMGRP="MT INCONSISTENCIES"
 S XMY("G."_IVMGRP_"@"_^XMB("NETNAME"))=""
 S IVMPAT=$$PT^IVMUFNC4(DFN)
 S XMSUB="MT INCONSISTENCIES - "_$E($P(IVMPAT,"^"),1)_$P(IVMPAT,"^",3)_"/"_SCTST
 ;
 S IVMTXT(1)="An Income Test was edited/completed on "_$$FMTE^XLFDT($$NOW^XLFDT,"1D")
 S IVMTXT(2)="containing "_($O(IVMERR(""),-1)-1)_" data inconsistencie(s)."
 S IVMTXT(3)=" "
 S IVMTXT(4)="    NAME:        "_$P(IVMPAT,"^")
 S IVMTXT(5)="    ID:          "_$P(IVMPAT,"^",2)
 S IVMTXT(6)="    TEST DATE:   "_$$FMTE^XLFDT(DGMTDT)
 S IVMTXT(7)=" "
 S IVMTXT(8)="The inconsistencies are listed in the comment section of"
 S IVMTXT(9)="the income test for this veteran."
 ;
 D ^XMD
 K IVMTXT,XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
PROB(DGMTDT,IVMERR,BULLRQ) ;
 ;  IVMERR - Contains lists of inconsistencies from tests which were
 ;           uploaded (ORU~Z10 and ORF~Z10) or created during data
 ;            entry (Required)
 ;
 ;  BULLRQ - MT INCONSISTENCIES Bulletin Required? flag (Optional)
 ;
 ; If the test wasn't completed during data entry quit
 N MTCOMP,DGMTI,TYPE,SCTST
 S BULLRQ=+$G(BULLRQ)
 S TYPE=$S($D(IVMTYPE):IVMTYPE,$D(DGMTYPT):DGMTYPT,1:"")
 S:'$D(DGMTI) DGMTI=+$$LST^DGMTU(DFN,,TYPE)
 S MTCOMP=$P($G(^DGMT(408.31,+$G(DGMTI),0)),U,7)
 I BULLRQ,MTCOMP'>0 Q
 ;
 ; If errors were found during data entry, send bulletin 
 S SCTST=$P($G(^DGMT(408.31,+$G(DGMTI),2)),U,5)
 I BULLRQ,$D(IVMERR(2)) D BULL(DFN,DGMTDT,.IVMERR,SCTST)
 ;
 ; If inconsistent data was found update the comment field with the list
 ; of errors.
 D INCON(DGMTI,.IVMERR)
 Q
 ;
INCON(DGMTI,IVMERR,TFLG) ;
 ; Append the current comments (if any) with the list of inconsistencies
 ; found during data entry or upload of ORU/ORF Z10
 N CNT,INCNT,COMM,TTYPE,TAB,ERR,LNCNT,TFLG
 I $D(IVMERR(2)),BULLRQ D
 .S TTYPE=^DG(408.33,+$P($G(^DGMT(408.31,DGMTI,0)),U,19),0)
 .S IVMERR(1)=":A "_TTYPE_" was edited on "_$$FMTE^XLFDT($$NOW^XLFDT,"1P")_" with data inconsistencies."
 I $D(IVMERR(2)),'BULLRQ D
 .S IVMERR(1)=":Received/Uploaded Test on "_$$FMTE^XLFDT($$NOW^XLFDT,"1P")_" with data inconsistencies."
 ;
 ; Check for exisiting non-inconsistency messages
 S TFLG=2
 D CHECK(DGMTI,.TFLG)
 ;
 ; If nothing to add to the  COMMENT field, delete all existing msgs
 I '$D(IVMERR(1)) D INCONR(DGMTI) Q
 ;
 ; Overwrite the comments for inconsistencies found during Z10 upload
 S TAB=": "
 F LNCNT=TFLG:1 Q:'$D(IVMERR(LNCNT))  S IVMERR(LNCNT)=TAB_IVMERR(LNCNT)
 D WP^DIE(408.31,DGMTI_",",50,,"IVMERR",.ERR)
 Q
 ;
CHECK(DGMTI,TFLG) ;
 ; Check for exisiting non-inconsistency messages, and keep all 
 ; non-inconsistency (user entered) messages.
 ;
 ; Quit if no comments were entered
 Q:'$D(^DGMT(408.31,DGMTI,"C",1,0))
 ;
 ; Quit if all current comments are for inconsistencies
 S INCNT=0
 F CNT=1:1 Q:'$D(^DGMT(408.31,DGMTI,"C",CNT,0))  D
 .Q:$E(^DGMT(408.31,DGMTI,"C",CNT,0),1)=":"
 .Q:^DGMT(408.31,DGMTI,"C",CNT,0)']""
 .S INCNT=INCNT+1,COMM(INCNT)=^DGMT(408.31,DGMTI,"C",CNT,0)
 Q:INCNT'>0
 ;
 ; Re-Build Comment array with user comments
 S TFLG=INCNT+2
 F CNT=1:1 Q:'$D(IVMERR(CNT))  S INCNT=INCNT+1,COMM(INCNT)=IVMERR(CNT)
 M IVMERR=COMM
 Q
 ;
INCONR(DGMTI) ;
 ; When no inconsistent data and no user comments were found, 
 ; remove everything from the COMMENT Word Procesing field.
 ;
 ; Quit if no comments exist
 Q:'$D(^DGMT(408.31,DGMTI,"C",1,0))
 ;
 ; Delete all, when no comments and no inconsistencies
 D WP^DIE(408.31,DGMTI_",",50,,"@",.ERR)
 ;
 Q
