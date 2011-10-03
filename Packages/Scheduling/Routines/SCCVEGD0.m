SCCVEGD0 ;ALB/JRP,TMP - DSPLY RSLTS 4 ENCNTR CNVRSN GLBL ESTMTR;18-JAN-96
 ;;5.3;Scheduling;**211**;Aug 13, 1993
MAILSUM(PTRLOG,RESULT) ;MAIL SUMMARY OF GLOBAL ESTIMATES
 ;INPUT  : PTRLOG - Pointer to entry in SCHEDULING CONVERSION LOG
 ;                  file (#404.98) that display is built for
 ;OUTPUT : RESULT - the # of users the bulletin was sent to [optional]
 ;NOTES  : Summary will be mailed to all users that scheduled and
 ;         re-started the estimation and to the current user.  If no
 ;         valid recipients are, it will be sent to the POSTMASTER.
 ;
 N SCLINES,LINES,NODE,TMP,TMP1,XMSUB,XMDUZ,XMY,XMZ,XMTEXT
 ;
 S RESULT=0
 ;
 Q:'$D(^SD(404.98,+$G(PTRLOG),0))
 ;
 ;Build message subject/stub
 S XMSUB="Scheduling Conversion Global Growth for "
 S TMP=+$P($G(^SD(404.98,PTRLOG,0)),U,3)
 S XMSUB=XMSUB_$E(TMP,4,5)_"/"_$E(TMP,6,7)_"/"_(1700+$E(TMP,1,3))
 S TMP=+$P($G(^SD(404.98,PTRLOG,0)),U,4)
 S XMSUB=XMSUB_" to "_$E(TMP,4,5)_"/"_$E(TMP,6,7)_"/"_(1700+$E(TMP,1,3))
 S XMDUZ="SCHEDULING CONVERSION GLOBAL ESTIMATOR"
 ;Build bulletin text
 S LINES=$$BUILD(PTRLOG,"SCLINES")
 S XMTEXT="SCLINES("
 I $G(DUZ) S XMY(+DUZ)="",RESULT=RESULT+1  ;Send to current user
 ;Find all users that scheduled or re-started the conversion
 S TMP=0
 F  S TMP=+$O(^SD(404.98,PTRLOG,"R",TMP)) Q:'TMP  S NODE=$G(^(TMP,0)) D
 .Q:"13"'[+$P(NODE,U,2)  ; schedule or re-start only
 .I $P(NODE,U,6),'$D(XMY(+$P(NODE,U,6))) S RESULT=RESULT+1,XMY(+$P(NODE,U,6))=""
 ;No users - send to POSTMASTER
 I '$O(XMY(0)) S XMY(.5)="",RESULT=1
 ;Send message
 D ^XMD
 Q
 ;
BUILD(PTRLOG,OUTARRAY) ;BUILD DISPLAY FOR GLOBAL ESTIMATES
 ;INPUT  : PTRLOG - Pointer to entry in SCHEDULING CONVERSION LOG
 ;                  file (#404.98) that display is built for
 ;         OUTARRAY - Array to build display into (full global reference)
 ;                      Defaults to ^TMP("SCCVEG",$J,"DISPLAY")
 ;OUTPUT : N - Number of lines in display
 ;         OUTARRAY will be returned as follows
 ;           OUTARRAY(x,0) = Line x of display
 ;                           (First line in display will be line # 1)
 ;NOTES  : Display is based on a screen width of 80 characters
 ;       : It is the responsibility of the calling application to
 ;         initialize OUTARRAY
 ;
 N CURRENT,INSERTED,LOGNODE,TMP,INFO,DATE,SCCV2,Z
 ;
 Q:'$D(^SD(404.98,+$G(PTRLOG,0))) 0
 ;
 S:$G(OUTARRAY)="" OUTARRAY="^TMP(""SCCVEG"","_$J_",""DISPLAY"")"
 S LOGNODE=$G(^SD(404.98,PTRLOG,0)),SCCV2=$G(^(2))
 ;Put totals into display
 S CURRENT=1
 S Z="Template #: "_PTRLOG
 S @OUTARRAY@(CURRENT,0)=Z
 S CURRENT=CURRENT+1
 S @OUTARRAY@(CURRENT,0)=$E("Total # new entries expected:"_$J("",39),1,39)_"Total # encounters to convert:"
 S CURRENT=CURRENT+1
 S @OUTARRAY@(CURRENT,0)=$E("  Encounters  : "_+$P(SCCV2,U,7)_$J("",39),1,39)_"  Add/Edits   : "_+$P(SCCV2,U)
 S CURRENT=CURRENT+1
 S @OUTARRAY@(CURRENT,0)=$E("  Visits      : "_+$P(SCCV2,U,8)_$J("",39),1,39)_"  Ancillaries : "_+$P(SCCV2,U,2)
 S CURRENT=CURRENT+1
 S @OUTARRAY@(CURRENT,0)=$E("  V PROVIDERs : "_+$P(SCCV2,U,9)_$J("",39),1,39)_"  Appointments: "_+$P(SCCV2,U,3)
 S CURRENT=CURRENT+1
 S @OUTARRAY@(CURRENT,0)=$E("  V POVs      : "_+$P(SCCV2,U,10)_$J("",39),1,39)_"  Credit Stops: "_+$P(SCCV2,U,4)
 S CURRENT=CURRENT+1
 S @OUTARRAY@(CURRENT,0)=$E("  V CPTs      : "_+$P(SCCV2,U,11)_$J("",39),1,39)_"  Dispositions: "_+$P(SCCV2,U,5)
 ;Put whitespace into display
 S CURRENT=CURRENT+1,@OUTARRAY@(CURRENT,0)=""
 ;Put global estimations chart into display
 S INSERTED=$$DSPGLBL^SCCVEGD1(PTRLOG,OUTARRAY,CURRENT)
 S CURRENT=CURRENT+INSERTED
 ;Done - return number of lines contained in display
 Q CURRENT
