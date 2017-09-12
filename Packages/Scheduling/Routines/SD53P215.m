SD53P215 ;BP-OIFO/KEITH - PRE/POST INSTALL SD*5.3*215 ; 27 Apr 2000 12:49 PM
 ;;5.3;Scheduling;**215**;Aug 13 1993
 ;
ENV I DUZ(0)'="@" D
 .W !!,$C(7),"     To insure that data updates contained in this patch are",!,"     installed correctly, DUZ(0) must be equal the ""@"" symbol!",!
 .S XPDQUIT=2 Q
 Q
 ;
POST ;Post init actions
 D SEED,CODE Q
 ;
SEED ;Seed NPCD ENCOUNTER MONTH multiple (#404.9171) of the SCHEDULING
 ;PARAMETER file (#404.91) with revised database close-out dates 
 ;for FY2000
 ;
 ;Declare variables
 N XPDIDTOT,LINE,DATES,WLMONTH,DBCLOSE,WLCLOSE,TMP
 ;Print header
 D BMES^XPDUTL(">>> Storing revised database close-out dates for Fiscal Year 2000")
 S TMP=$$INSERT^SCDXUTL1("Workload","",7)
 S TMP=$$INSERT^SCDXUTL1("Database",TMP,27)
 S TMP=$$INSERT^SCDXUTL1("Workload",TMP,47)
 D BMES^XPDUTL(TMP)
 S TMP=$$INSERT^SCDXUTL1("Occurred In","",6)
 S TMP=$$INSERT^SCDXUTL1("Close-Out",TMP,27)
 S TMP=$$INSERT^SCDXUTL1("Close-Out",TMP,47)
 D MES^XPDUTL(TMP)
 S TMP=$$INSERT^SCDXUTL1("------------","",5)
 S TMP=$$INSERT^SCDXUTL1("------------",TMP,25)
 S TMP=$$INSERT^SCDXUTL1("------------",TMP,45)
 D MES^XPDUTL(TMP)
 ;Loop through list of dates
 S XPDIDTOT=6
 F LINE=2:1:7 S TMP=$T(FY00+LINE),DATES=$P(TMP,";",3) Q:(DATES="")  D
 .;Break out info
 .S WLMONTH=$P(DATES,"^",1)
 .S DBCLOSE=$P(DATES,"^",2)
 .S WLCLOSE=$P(DATES,"^",3)
 .;Print close-out info
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(WLMONTH,"1D"),"",7)
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(DBCLOSE,"1D"),TMP,25)
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(WLCLOSE,"1D"),TMP,45)
 .D MES^XPDUTL(TMP)
 .;Store close-out info
 .S TMP=$$AECLOSE^SCDXFU04(WLMONTH,DBCLOSE,WLCLOSE)
 .;Write error message if datebase or workload dates not updated
 .I TMP<0 D MES^XPDUTL("       >>> Could not update closeout dates for above month.")
 .;If KIDS install, show progress through status bar
 .D:($G(XPDNM)'="") UPDATE^XPDID(LINE-1)
 D BMES^XPDUTL("")
 Q
 ;
FY00 ;Revised Close-out dates for fiscal year 2000
 ;  Month ^ Database Close-Out ^ Workload Close-Out
 ;;2991000^3001013^2991112
 ;;2991100^3001013^2991210
 ;;2991200^3001013^3000107
 ;;3000100^3001013^3000211
 ;;3000200^3001013^3000310
 ;;3000300^3001013^3000407
 Q
 ;
CODE ;File new code to TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file
 ;(#409.76)
 ;
 N SDY
 S SDY=$$FILE()
 I SDY=-1 D  Q
 .D MES^XPDUTL(">>> Unable to file error code '999', contact Customer Service for assistance.")
 .Q
 I $P(SDY,U,3)'=1 D  Q
 .D MES^XPDUTL(">>> Error code '999' is already on file, no action taken.")
 .Q
 D MES^XPDUTL(">>> Error code '999 - Unknown reason' added to file #409.76.")
 Q
 ;
FILE() ;File code
 N DIC,DLAYGO,X,Y,SD
 S SD(.02)="NPCD",SD(11)="Reason unknown"
 S SD(21)="Rejected by NPCD without a valid reason, use the 'Retransmit Selected Error Code' [SCDX AMBCAR RETRANS ERROR] option to resend."
 S SD(41)="S RTN=$$MSG^SCENIA1(""Use the 'Retransmit Selected Error Code' [SCDX AMBCAR RETRANS ERROR] option to resend."")"
 S DIC="^SD(409.76,",DLAYGO=409.76,DIC(0)="L",X=999
 S DIC("DR")=".02///^S X=SD(.02);11///^S X=SD(11);21///^S X=SD(21);41///^S X=SD(41)"
 D ^DIC
 Q Y
 ;
FIND ;Mark encounters that have been rejected for transmission due to the
 ;midyear database closeout or have been transmitted but rejected by
 ;NPCD without a valid reason for retransmission
 ;
 N SDSTAT
 I DT>3001013 W !!,$C(7),"It is too late to run this utility!" Q
 I $G(DUZ)<1 W !!,$C(7),"DUZ must be defined to run this utility!" Q
 S SDSTAT=$O(^SD(409.63,"B","CHECKED OUT",0)) I 'SDSTAT W !!,"CHECKED OUT encounter status could not be identified!" K SDSTAT Q
 N ZTSAVE S ZTSAVE("SDSTAT")=""
 W ! D EN^XUTMDEVQ("START^SD53P215","Re-flag NPCDB activity",.ZTSAVE) Q
 ;
START ;Search for activity to re-flag for transmission
 ;
 N SDLINE,SDOUT,SDTIT,SDPAGE,X,Y,%,SDPNOW,SDDT,SDOE,SDOE0,SDSTX,SDTOT
 N SDCT,SDXP,SDTEXT,SDSCT,SDSTOT
 ;Initialize variables
 K ^TMP("SD215",$J)
 S SDLINE="",$P(SDLINE,"-",(IOM+1))="",SDOUT=0
 S SDTIT="<*>  RE-FLAG UNSENT/REJECTED FY2000 NPCDB ACTIVITY FOR TRANSMISSION  <*>"
 S SDPAGE=1 D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=Y
 ;Search encounters by date range
 S SDDT=2991000
 F  S SDDT=$O(^SCE("B",SDDT)) Q:'SDDT  S SDOE=0 F  S SDOE=$O(^SCE("B",SDDT,SDOE)) Q:'SDOE  D
 .S SDOE0=$G(^SCE(SDOE,0)) Q:'$L(SDOE0)
 .;If date/patient/location/status/transmission status, set array
 .I $P(SDOE0,U),$P(SDOE0,U,2),$P(SDOE0,U,4),$P(SDOE0,U,12)=SDSTAT,'$P(SDOE0,U,6) S SDSTX=$$STX^SCRPW8(SDOE,SDOE0) I "1^2^3^6"[+SDSTX D
 ..S ^TMP("SD215",$J,+SDSTX,"CT")=$G(^TMP("SD215",$J,+SDSTX,"CT"))+1
 ..S ^TMP("SD215",$J,+SDSTX,"TEXT")=SDSTX
 ..S ^TMP("SD215",$J,+SDSTX,SDOE)=SDOE0
 ..Q
 .Q
 ;Count records found
 S (SDSTX,SDTOT)=0 F  S SDSTX=$O(^TMP("SD215",$J,SDSTX)) Q:'SDSTX  S SDTOT=SDTOT+^TMP("SD215",$J,SDSTX,"CT")
 ;
 ;Re-flag encounters for transmission
 S (SDCT,SDSTX,SDOUT)=0
 F  S SDSTX=$O(^TMP("SD215",$J,SDSTX)) Q:'SDSTX!SDOUT  D
 .S SDOE=0 F  S SDOE=$O(^TMP("SD215",$J,SDSTX,SDOE)) Q:'SDOE!SDOUT  D
 ..S SDDT=+^TMP("SD215",$J,SDSTX,SDOE)
 ..S SDXP=$$CRTXMIT^SCDXFU01(SDOE,,SDDT)  ;Get the transmission record
 ..Q:SDXP'>0
 ..;Keep count by transmission status
 ..S ^TMP("SD215",$J,SDSTX,"SENT")=$G(^TMP("SD215",$J,SDSTX,"SENT"))+1
 ..S SDCT=SDCT+1 S:SDCT'<5000 SDOUT=1  ;Don't do more than 5000
 ..D STREEVNT^SCDXFU01(SDXP,0)  ;Log the event
 ..D XMITFLAG^SCDXFU01(SDXP,0)  ;Flag the record for transmission
 ..Q
 .Q
 ;
 ;Report the results
 N SD,SDI,SDX S SDI=0
 ;Set text array
 D LINE("")
 D LINE("                    Unsent/rejected FY2000 NPCD activity found")
 D LINE("                    ------------------------------------------")
 S SDSTX=0 F  S SDSTX=$O(^TMP("SD215",$J,SDSTX)) Q:'SDSTX  D
 .S SDTEXT=$P(^TMP("SD215",$J,SDSTX,"TEXT"),U,2)
 .S SDSCT=^TMP("SD215",$J,SDSTX,"CT"),SDX=""
 .S $E(SDX,20)=$J(SDTEXT,30)_": "_$J(SDSCT,6,0) D LINE(SDX)
 .Q
 S SDX="",$E(SDX,20)=$J("TOTAL",30)_": "_$J(SDTOT,6,0) D LINE(SDX)
 D LINE("")
 D LINE("                       Encounters flagged for transmission")
 D LINE("                       -----------------------------------")
 S (SDSTOT,SDSTX)=0 F  S SDSTX=$O(^TMP("SD215",$J,SDSTX)) Q:'SDSTX  D
 .S SDTEXT=$P(^TMP("SD215",$J,SDSTX,"TEXT"),U,2)
 .S SDSCT=+$G(^TMP("SD215",$J,SDSTX,"SENT")),SDSTOT=SDSTOT+SDSCT
 .S SDX="",$E(SDX,20)=$J(SDTEXT,30)_": "_$J(SDSCT,6,0) D LINE(SDX)
 .Q
 S SDX="",$E(SDX,20)=$J("TOTAL",30)_": "_$J(SDSTOT,6,0) D LINE(SDX)
 I SDTOT>5000 D
 .D LINE(""),LINE("")
 .D LINE("  More than 5000 encounters were found that require retransmission.  To avoid")
 .D LINE("  overloading HL7 and MailMan globals, this process is designed to send no")
 .D LINE("  more than 5000 encounters at a time.  To complete the transmission of all")
 .D LINE("  applicable activity, you are advised to re-run this utility on a subsequent")
 .D LINE("  date.")
 .Q
 ;
MAIL ;Send mail message
 N XMSUB,XMDUZ,XMDUN,XMTEXT,XMY,XMZ
 S XMSUB="Encounter retransmission utility"
 S (XMDUN,XMDUZ)="Patch SD*5.3*215"
 S XMTEXT="SD(",XMY(DUZ)=""
 D ^XMD
 ;
PRINT ;Print report
 D HDR
 N COL S COL=(IOM-80\2)
 S SDI=0 F  S SDI=$O(SD(SDI)) Q:'SDI  D
 .D:$Y>(IOSL-3) HDR
 .W !?(COL),SD(SDI)
 .Q
 ; 
EXIT K ^TMP("SD215",$J) Q
 ;
 ;
LINE(SDX) ;Create text array node
 S SDI=SDI+1,SD(SDI)=SDX
 Q
 ;
HDR ;Print report header
 W:SDPAGE>1 @IOF
 W SDLINE,!?(IOM-$L(SDTIT)\2),SDTIT,!,SDLINE,!,"Date printed:",SDPNOW
 W ?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1 Q
