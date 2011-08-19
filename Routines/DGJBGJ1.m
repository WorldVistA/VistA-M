DGJBGJ1 ;ALB/MAF - IRT BACKGROUND JOB (CONT.) - MAY 3 1993
 ;;1.0;Incomplete Records Tracking;;Jun 25, 2001
MSG N DGJCNT,DGJDV,DGJDT,DGJCA
 S (DGJCNT,DGJDV,DGJDT,DGJCA)=0
 F  S DGJDV=$O(^TMP("VAS",$J,DGJDV)) Q:DGJDV']""  F  S DGJDT=$O(^TMP("VAS",$J,DGJDV,DGJDT)) Q:DGJDT']""  F  S DGJCA=$O(^TMP("VAS",$J,DGJDV,DGJDT,DGJCA)) Q:DGJCA']""  S DGJCNT=DGJCNT+1 S DGJMSG(DGJCNT,0)=^TMP("VAS",$J,DGJDV,DGJDT,DGJCA,0)
 I '$D(DGJMSG(1)) G Q
 ;quit it no text in message
 S XMSUB="PATIENTS DISCHARGED LESS THAN 48 HOURS"
 S XMTEXT="DGJMSG("
 S DGJB=+$P($G(^DG(43,1,"NOT")),"^",14)
 S XMY("G."_$P($G(^XMB(3.8,DGJB,0)),"^",1))="" ; pass mailgroup
 ; makes sure it gets sent to someone
 I '$D(XMY) S XMY(.5)=""
 ; make postmaster the sender so it will show up as new to DUZ
 S XMDUZ=.5
 D ^XMD:$D(XMY)
Q K DGSM,DGB,DGTEXT,XMR,DGII,XMY,XMTEXT,XMDUZ,XMSUB Q
 ;
ERRMSG ; Send error message.
 Q:'$D(DGJERR)
 S Y=DGJRUN D DD^%DT S DGJRUN=Y
 K DGJMSG
 S DGJMSG(1)="The following error(s) were reported during the Incomplete Records menu run:"
 S DGJMSG(2)="IRT Update Std. Def. Background Job  [DGJ IRT UPDATE (Background)"
 S DGJMSG(3)="  or"
 S DGJMSG(4)="IRT Update Std. Deficiencies  [DGJ IRT UPDATE STD. DEFIC.]"
 S DGJMSG(5)=" "
 S DGJMSG(6)="Verify the following patient information.  Manually run the option:"
 S DGJMSG(7)="IRT UPDATE Std. Deficiencies [DGJ IRT UPDATE STD. DEFIC.]"
 S DGJMSG(8)="for the run time listed below."
 S DGJMSG(9)=" "
 S DGJMSG(10)="Run time: "_DGJRUN
 S DGJMSG(11)="Errors encountered during menu run:"
 S DGJMSG(12)="-----------------------------------------"
 S TXT=12,I=0
 F  S I=$O(DGJERR(I)) Q:I=""  D
 . S DFN=0 F  S DFN=$O(DGJERR(I,DFN)) Q:'DFN  D
 . . S DGJMT=0 F  S DGJMT=$O(DGJERR(I,DFN,DGJMT)) Q:'DGJMT  D
 . . . S Y=DGJMT D DD^%DT
 . . .S DGJMSG(TXT+1)=$P(^DPT(DFN,0),"^",1)_"("_$E($P(^DPT(DFN,0),"^",9),6,9)_") Mvmt: ("_Y_") has "_$P($T(@(I)),";",3)
 ;
 S XMSUB="IRT Update Std. Defic. Error List"
 S XMTEXT="DGJMSG("
 S DGJB=+$P($G(^DG(43,1,"NOT")),"^",14)
 I DGJB S XMY("G."_$P($G(^XMB(3.8,DGJB,0)),"^",1))="" ; pass mailgroup
 I '$D(XMY) S XMY(.5)=""
 I DUZ>0 S XMY(DUZ)=""
 ; make postmaster the sender so it will show up as new to DUZ
 S XMDUZ=.5
 D ^XMD:$D(XMY)
 K XMTEXT,XMSUB,DGJB,XMY,DGJMSG,XMDUZ,I,DFN,DGJMT,Y Q
 ;
ERRMSG1 ; Error listing
ERR1 ;ERR1;No Ward Location found."
