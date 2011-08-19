PX157PST ;ALB/SCK - PX*1.0*157 POST INIT INSTALL
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**157**;Aug 12, 1996
 ;
EN ; Edit Education Topics VA-ADVANCE DIRECTIVES & VA-ADVANCED DIRECTIVES SCREENING
 ; -- modifying to "advance directives" terminology.
EN1 ;check VA-ADVANCED DIRECTIVES SCREENING
 S FIX1=0,FIX2=0,IEN1=0,U="^",WD1="VA-ADVANCED DIRECTIVES SCREENING",WD2="Advanced Directive Screening"
 S WD1N="VA-ADVANCE DIRECTIVES SCREENING",WD2N="Advance Directives Screening"
 S WD(1)="determine if the patient should receive Advanced Directive education. "
 S WDN(1)="determine if the patient should receive Advance Directives education."
 S WD(2)="Advanced Directive education.    "
 S WDN(2)="Advance Directives education."
 S IEN1=$O(^AUTTEDT("B",WD1,IEN1)) I IEN1="" G EN2
 S REDT=^AUTTEDT(IEN1,0)
 I $P(REDT,U)'=WD1!($P(REDT,U,4)'=WD2) G EN2
 ;I ^AUTTEDT(IEN1,11,2,0)'=WD(1) G EN2
 ;I ^AUTTEDT(IEN1,12,4,0)'=WD(2) G EN2
SET1 ;SET CORRECT WORDING
 S FIX1=1
 S DA=IEN1,DR=".01////^S X=WD1N",DIE="^AUTTEDT(" D ^DIE
 S DA=IEN1,DR=".04////^S X=WD2N",DIE="^AUTTEDT(" D ^DIE
 S ^AUTTEDT(IEN1,11,2,0)=WDN(1),^AUTTEDT(IEN1,12,4,0)=WDN(2)
EN2 ;check VA-ADVANCED DIRECTIVES
 S IEN2=0,WD1A="VA-ADVANCED DIRECTIVES",WD2A="Advanced Directives"
 S WD1AN="VA-ADVANCE DIRECTIVES",WD2AN="Advance Directives"
 S WDA(1)="The patient and family will identify the implications of advanced"
 S WDA(2)="1.  Explain what an advanced directive is."
 S WDA(3)="2.  Explain the difference between advanced directives and a living will."
 S WDA(4)="5.  Identify a social worker to contact for furthur information as appropriate."
 S WDAN(1)="The patient and family will identify the implications of advance"
 S WDAN(2)="1.  Explain what an advance directives is."
 S WDAN(3)="2.  Explain the difference between advance directives and a living will."
 S WDAN(4)="5.  Identify a social worker to contact for further information as appropriate."
 S IEN2=$O(^AUTTEDT("B",WD1A,IEN2)) I IEN2="" G EN3
 S REDT=^AUTTEDT(IEN2,0)
 I $P(REDT,U)'=WD1A!($P(REDT,U,4)'=WD2A) G EN3
 I ^AUTTEDT(IEN2,11,1,0)'=WDA(1) G EN3
 I ^AUTTEDT(IEN2,12,1,0)'=WDA(2) G EN3
 I ^AUTTEDT(IEN2,12,3,0)'=WDA(3) G EN3
 I ^AUTTEDT(IEN2,12,10,0)'=WDA(4) G EN3
SET2 ;SET CORRECT WORDING
 S FIX2=1
 S DA=IEN2,DR=".01////^S X=WD1AN",DIE="^AUTTEDT(" D ^DIE
 S DA=IEN2,DR=".04////^S X=WD2AN",DIE="^AUTTEDT(" D ^DIE
 S ^AUTTEDT(IEN2,11,1,0)=WDAN(1)
 S ^AUTTEDT(IEN2,12,1,0)=WDAN(2),^AUTTEDT(IEN2,12,3,0)=WDAN(3)
 S ^AUTTEDT(IEN2,12,10,0)=WDAN(4)
EN3 ;MAIL MSG
END ;EXIT PATH
 D MAIL
 K DA,DR,DIE,IEN,IEN1,IEN2,WD,WDN,WDA,WDAN,WD1,WD1N,WD2,WD2N,WD1A,WD1AN,WD2A,WD2AN,FIX1,FIX2,REDT
 Q
MAIL ;Send results of Educ Topic fix in a mail message to initiator
 N I,XMSUB,XMTEXT,XMDUZ,XMY,DIFROM
 S XMSUB="Patch PX*1.0*157 Educ topic modification completed"
 S XMDUZ="Patch PX*1.0*157 Educ topic modify job"
 S XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S XMTEXT="^TMP(""PXTXT"",$J,"
 K ^TMP("PXTXT",$J)
 ; set up header and count
 S I=3
 S ^TMP("PXTXT",$J,1)="The modification of Education Topics: VA-Advanced Directives and"
 S ^TMP("PXTXT",$J,2)="VA-Advanced Directives Screening, has completed"
 S ^TMP("PXTXT",$J,I)="",I=I+1
 S ^TMP("PXTXT",$J,I)=""
 I FIX1=0 D
 . S I=I+1,^TMP("PXTXT",$J,I)="                 *** ERROR ALERT ***"
 . S I=I+1,^TMP("PXTXT",$J,I)="Could NOT fix topic VA-Advanced Directives Screening, data did NOT "
 . S I=I+1,^TMP("PXTXT",$J,I)="match national data base"
 I FIX1>0 D
 . S I=I+1,^TMP("PXTXT",$J,I)="                 ***  CHANGED  ***"
 . S I=I+1,^TMP("PXTXT",$J,I)="Modified topic VA-Advanced Directives Screening for verbiage"
 . S I=I+1,^TMP("PXTXT",$J,I)="correction where used"
 S I=I+1,^TMP("PXTXT",$J,I)=""
 I FIX2=0 D
 . S I=I+1,^TMP("PXTXT",$J,I)="                 *** ERROR ALERT ***"
 . S I=I+1,^TMP("PXTXT",$J,I)="Could NOT fix topic VA-Advanced Directives, data did NOT"
 . S I=I+1,^TMP("PXTXT",$J,I)="match national data base"
 I FIX2>0 D
 . S I=I+1,^TMP("PXTXT",$J,I)="                 ***  CHANGED  ***"
 . S I=I+1,^TMP("PXTXT",$J,I)="Modified topic VA-Advanced Directives for verbiage correction"
 . S I=I+1,^TMP("PXTXT",$J,I)="where used"
 D ^XMD ;send results
 Q
