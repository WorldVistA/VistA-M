PSBVDLU3 ;BIRMINGHAM/TEJ-BCMA VDL UTILITIES 3 ; 27 Aug 2008  9:06 PM
 ;;3.0;BAR CODE MED ADMIN;**13,38,28,50**;Mar 2004;Build 78
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ;This routine file has been created to serve as a container
 ;for Extrinsic Variables/Functions
 ;
 ; Reference/IA
 ; EN^PSJBCMA/2828
 ; EN^PSJBCMA1/2829
 ; File 50/221
 ; File 52.6/436
 ; File 52.7/437
 ;
IVPTAB(PSBORTYP,PSBIVTYP,PSBINTSY,PSBCHMTY,PSBPUSH)  ;
 ;
 ; This function will return
 ; the value 1 (one) if the
 ; specified order input will cause
 ; the order to display on the "IVP/IVPB"
 ; tab of the VDL BCMA Virtual Due List (VDL)
 ; else return the value 0 (zero).
 ;
 ; Input Parameters:
 ;
 ;     PSBORTYP - Order type (e.g. "U","V")
 ;     PSBIVTYP - IV Type (e.g. "P","S","C")
 ;     PSBINTSY - Intermittent Syringe value
 ;     PSBCHMTY - Chemo type (e.g. "P","S")
 ;     PSBPUSH - IV PUSH Flag (e.g. 0 or 1, 1=IV PUSH)
 ;
 ; Output:
 ;     1 - order will display on the "IVP/IVPB" Tab of BCMA VDL
 ;     0 - order will NOT display on the "IVP/IVPB" Tab of BCMA VDL
 ;    -1 - error processed
 ;
 Q:'$D(PSBORTYP) "-1^Missing Parameter"
 I PSBORTYP="U"&(PSBPUSH) Q 1
 I '(PSBORTYP="V") Q 0
 I $G(PSBIVTYP)="P" Q 1
 I $G(PSBIVTYP)="S",$G(PSBINTSY)=1 Q 1
 I $G(PSBIVTYP)="C",$G(PSBCHMTY)="P" Q 1
 I $G(PSBIVTYP)="C",$G(PSBCHMTY)="S",$G(PSBINTSY)=1 Q 1
 Q 0
 ;
SHOVDL(DFN,BDATE,OTDATE,PSBTAB) ;
 ;
 ; This function will find orders such as discontinued or expired infusing IV bags 
 ; or discontinued or expired "given" patches.  Recognizing these types of orders
 ; will allow these orders to be displayed on the VDL and permits the user to take 
 ; action on them.  This routine determines if such orders exist for patient,
 ; time, and "BCMA VDL tab."  This routine is an "extention" to the API EN^PSJBCMA.
 ;
 ; INPUT Parameters:
 ;    DFN           (req)   Patient Internal File Number.
 ;    BDATE         (opt)   Start searching for "order stop" after this date. 
 ;    OTDATE        (opt)   Include One-Time orders from this date.
 ;    PSBTAB        (opt)   "UDTAB" or "IVTAB" - expedites process if specific tab
 ;                            is given.
 ;
 ; OUTPUT Values
 ;    0               absolutely no orders to display on VDL
 ;    1               displayable orders have been located.
 ;
 ;
 D EN^PSJBCMA(DFN,$G(BDATE),$G(OTDATE))
 ; any active Patch orders to show on VDL?
 S PSBFLG=0
 I $G(^TMP("PSJ",$J,1,0))=-1 D
 .;  
 .; Check the indexice for given patches or infusing IVs
 .;
 .; Check APATCH
 .D:($G(PSBTAB)="UDTAB")!($G(PSBTAB)="")  Q:PSBFLG
 ..S PSBGNODE="^PSB(53.79,"_"""APATCH"""_","_DFN_")" Q:'$D(PSBGNODE)
 ..F  S PSBGNODE=$Q(@PSBGNODE) Q:PSBGNODE=""  Q:$QS(PSBGNODE,3)'=DFN  Q:PSBFLG  S PSBIEN=$QS(PSBGNODE,5),PSBFLG=$S($P(^PSB(53.79,PSBIEN,0),U,9)="G":1,1:0)
 .;
 .; Check AUID
 .;
 .D:(($G(PSBTAB)="IVTAB")!($G(PSBTAB)=""))&('PSBFLG)  Q:PSBFLG
 ..S PSBGNODE="^PSB(53.79,"_"""AUID"""_","_DFN_")" Q:'$D(PSBGNODE)
 ..F  S PSBGNODE=$Q(@PSBGNODE) Q:PSBGNODE=""  Q:$QS(PSBGNODE,3)'=DFN  Q:PSBFLG  S PSBIEN=$QS(PSBGNODE,6),PSBFLG=$S($P(^PSB(53.79,PSBIEN,0),U,9)="I":1,1:0)
 .;
 .;  NOTE: Infusing bags will not display if DCed more than 3 days ago!
 .;
 S:$G(^TMP("PSJ",$J,1,0))'=-1 PSBFLG=1
 ;
 Q PSBFLG
 ;
FNDACTV(RESULTS,PARAMS) ;   Utility to check and order for the latest " ? (parameter #3) " order activities per patient (parameter #1)
 ; #parameter= # "^"piece
 ;       #1 DFN - Patient's IEN          e.g. 1234      (required)
 ;       #2 Order Number_Order Type      e.g. "1V"     "" = all orders
 ;       #3 Search for Activity          e.g           "" = *unknown* activity
 ;       #4 Search "back"time(hours)     e.g. 12       "" = search back 3 admins
 ;          NOTE:  ="FREQ"  This Function will use order's frequency.
 ;          1. If the order is a PRN, On Call or One-Time
 ;           the look back a default of 72 hours.
 ;          2. if the order is a Continuous order key off
 ;             of the frequency as follows.
 ;           a.) if the frequency is <24 hours use the
 ;               default of 72 hours.
 ;           b.) if the frequency is >= 24 hour, look back
 ;               3.5 times the frequency
 ;    NOTE:  ["X#"    This Function will search back # of admins.
 ;
 ;  Example call: D FNDACTV^PSBVDLU3(.TEJ,"1234^1U^H^12")
 ;
 N PSBNOW,PSBDFN,PSBON,PSBCNT,PSBACT,PSBTMFRM,PSBX,PSBSET,PSBFRQ
 K RESULTS
 S PSBDFN=$P(PARAMS,U),PSBON=$P(PARAMS,U,2),PSBACT=$P(PARAMS,U,3),PSBTMFRM=$P(PARAMS,U,4)
 S RESULTS(0)=1
 I $G(PSBDFN)']"" S RESULTS(0)=1,RESULTS(1)="-1^ERROR - MISSING PARAMETER (DFN REQ.)" Q
 I $G(PSBTMFRM)="" S PSBX=3
 I $G(PSBTMFRM)["X" S PSBX=+($P(PSBTMFRM,"X",2)),PSBTMFRM=""
 I $G(PSBTMFRM)]"",$G(PSBTMFRM)'["FREQ" D NOW^%DTC S PSBNOW=% S PSBTMFRM=$$FMADD^XLFDT(PSBNOW,"",-1*PSBTMFRM),PSBSET=1 S RESULTS(1)="0^ None found after "_PSBTMFRM
 I $G(PSBX)="" S PSBX=9999999
 D:$G(PSBON)'=""
 .K ^TMP("PSJ",$J) D EN^PSJBCMA1(PSBDFN,PSBON)
 .;Maintain Time Frame and other order information
 .I $G(PSBTMFRM)["FREQ" D
 ..S PSBFRQ=+$P(^TMP("PSJ",$J,4),"^",11) I PSBFRQ=0 S PSBFRQ=1440
 ..I "P^OC^O^"[($P(^TMP("PSJ",$J,4),"^")_"^") S PSBTMFRM=72 Q
 ..I (PSBFRQ/60)<24 S PSBTMFRM=72 Q
 ..I (PSBFRQ/60)'<24 S PSBTMFRM=(PSBFRQ/60)*3.5
 .I '$G(PSBSET) D NOW^%DTC S PSBNOW=% S PSBTMFRM=$$FMADD^XLFDT(PSBNOW,"",-1*PSBTMFRM) S RESULTS(1)="0^ None found after "_PSBTMFRM
 .S I="",X=0 F  S I=$O(^PSB(53.79,"AORDX",PSBDFN,PSBON,I),-1)  Q:(I="")!(I<$S(PSBTMFRM]"":PSBTMFRM,1:-1))  D  Q:X
 ..S Z=0,J="",PSBCNT=0 F  S J=$O(^PSB(53.79,"AORDX",PSBDFN,PSBON,I,J),-1)  Q:(J="")  S Z=Z+1 Q:Z>PSBX  D  Q:X
 ...L +^PSB(53.79,J):DILOCKTM
 ...I  L -^PSB(53.79,J)
 ...E  Q
 ...I ($P(^PSB(53.79,J,0),U,9)=PSBACT) S X=1 D
 ....S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)=$$GET1^DIQ(53.79,J_",",.02)
 ....S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)=$P(^TMP("PSJ",$J,2),U,2)_"^"_($$GET1^DIQ(53.79,J_",",.11))
 ....S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)=$$GET1^DIQ(53.79,J_",",.06,"I")
 ....S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)=$$GET1^DIQ(53.79,J_",",.13,"I")
 D:$G(PSBON)=""
 .S Z="",X=0 F  S Z=$O(^PSB(53.79,"AORDX",PSBDFN,Z),-1)  Q:(Z="")  S PSBON=Z D  Q:X
 ..;Maintain Time Frame and other order information
 ..K ^TMP("PSJ",$J) D EN^PSJBCMA1(PSBDFN,PSBON)
 ..I $G(PSBTMFRM)["FREQ" D
 ...S PSBFRQ=+$P(^TMP("PSJ",$J,4),"^",11) I PSBFRQ=0 S PSBFRQ=1440
 ...I "P^OC^O^"[($P(^TMP("PSJ",$J,4),"^")_"^") S PSBTMFRM=72 Q
 ...I (PSBFRQ/60)<24 S PSBTMFRM=72 Q
 ...I (PSBFRQ/60)'<24 S PSBTMFRM=(PSBFRQ/60)*3.5
 ..I '$G(PSBSET) D NOW^%DTC S PSBNOW=% S PSBTMFRM=$$FMADD^XLFDT(PSBNOW,"",-1*PSBTMFRM) S RESULTS(1)="0^ None found after "_PSBTMFRM
 ..S I="" F  S I=$O(^PSB(53.79,"AORDX",PSBDFN,PSBON,I),-1)  Q:(I="")!(I<$S(PSBTMFRM]"":PSBTMFRM,1:-1))  D  Q:X
 ...S ZZ=0,J="",PSBCNT=0 F  S J=$O(^PSB(53.79,"AORDX",PSBDFN,PSBON,I,J),-1)  Q:(J="")  S ZZ=ZZ+1 Q:ZZ>PSBX  D  Q:X
 ....L +^PSB(53.79,J):DILOCKTM
 ....I  L -^PSB(53.79,J)
 ....E  Q
 ....I ($P(^PSB(53.79,J,0),U,9)=PSBACT) S X=1 D
 .....S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)=$$GET1^DIQ(53.79,J_",",.02)
 .....S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)=$P(^TMP("PSJ",$J,2),U,2)_"^"_($$GET1^DIQ(53.79,J_",",.11))
 .....S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)=$$GET1^DIQ(53.79,J_",",.06,"I")
 .....S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)=$$GET1^DIQ(53.79,J_",",.13,"I")
 I $G(PSBCNT)>0 S RESULTS(0)=PSBCNT
 K ^TMP("PSJ",$J)
 Q
 ;
SCANFAIL(RESULTS,PSBPARAM) ;  TEJ 05/12/2006  BCMA-Managing Scanning Failures (MSF)
 ;       Document Unable to Scan Event
 ;               Parameters:
 ;               Input (via GUI):
 ;
 ;        Per Wristband  (0)      -       Pat IEN ^ ^ Reason Unable to Scan ^ User's Comment ^ "W" ^ 1 (keyed entry) or 2 (scanner)
 ;        Per Medication (0)      -       Pat IEN ^ Order Number ^ Reason Unable to Scan ^ User's Comment ^ "M" ^ 1 (keyed entry) or 2 (scanner)
 ;                       (1)      -       tag^ unique identifier
 ;               Output:
 ;                 Entry into database ^PSB(53.77)
 ;                 Electronic Mail - Message Data per Unable to Scan Event
 ;  PSB1 - Patient IEN
 ;  PSB2 - Ward Location/Room
 ;  PSB3 - Reason
 ;  PSB4 - Type of Scan Issue
 ;  PSB5 - Event date/item
 ;  PSB6 - User's Comment
 ;  PSB7 - User identification
 ;  PSB8 - Order Number
 ;                 RESULTS(0)=1
 ;                 RESULTS(1)= 1 (Success) or -1 (Nonsuccess)
 ;
 K RESULTS,PSBSFUID,PSBMEDOI,PSBMEDNM
 S RESULTS(0)=1,RESULTS(1)="-1^Unable to Scan documentation NOT successful!"
 N PSBDAT,PSBDAT1,PSBXON,PSBSCHAD
 S PSBDAT=PSBPARAM(0) I $D(PSBPARAM(1)) S PSBDAT1=PSBPARAM(1)
 S PSBXON=$P(PSBDAT,"^",2)
 S PSB8=$G(PSBXON)
 S (PSB1,PSBDFN)=$P(PSBDAT,"^")
 ;
 ; Changed the ward+room delimiter from / to $.
 S PSB2=" *UNIDENTIFIABLE PATIENT* " I +$G(PSB1)>0 S PSB2=$$GET1^DIQ(2,PSB1_",",.1)_"$"_$$GET1^DIQ(2,PSB1_",",.101)
 S PSB3=$P(PSBDAT,"^",3) I PSB3="Manual Medication Entry" S PSBMMEN=1
 S PSB4=$S($P(PSBDAT,"^",5)="W":"Wristband",$P(PSBDAT,"^",5)="M":"Medication",1:" *UNDEFINED* ")
 I PSB4="Medication"&($D(PSBDAT1)) D
 .; Determine DD/ADD/SOL
 .S PSBMEDOI=$P(PSBDAT1,"^",2)
 .S PSBFILE=$P(PSBDAT1,"^"),PSBFILE=$S(PSBFILE="DD":50,PSBFILE="ADD":52.6,PSBFILE="SOL":52.7,1:PSBFILE)
 .I PSBFILE'="ID" S PSBMEDNM=$$GET1^DIQ(PSBFILE,PSBMEDOI_",",.01)
 .K PSBSFUID I PSBFILE="ID",(PSBMEDOI]"") S PSBSFUID=PSBMEDOI
 D NOW^%DTC S (Y,PSB5A)=% D DD^%DT S PSB5=Y
 S PSB6=$P(PSBDAT,"^",4)
 S PSB7=". *UNDEFINED* " I $G(DUZ)>0 S PSB7=$$GET1^DIQ(200,DUZ_",",.01),PSB7A="`"_DUZ
 ; Send message.
 I $G(PSBMMEN)'=1,$P(PSBDAT,U,6)'=1,$P(PSBDAT,U,6)'=2 D MSFMSG^PSBMLU(PSB1,PSB2,PSB3,PSB4,PSB5,PSB6,PSB7,PSB8,.RESULTS)
 I RESULTS(0)=-1 S RESULTS(0)=1,RESULTS(1)="-1^Unable to Scan MAILGROUP NOT SETUP!" Q
 ;File data
 D CLEAN^DILF
 N PSBNEW1
 S PSBNEW1="+1"
 D
 .I $G(PSBMMEN)=1 S PSBSCTYP="MMME" Q
 .I $P(PSBDAT,U,6)=2 S PSBSCTYP=$S($P(PSBPARAM(0),"^",5)="W":"WSCN",$P(PSBPARAM(0),"^",5)="M":"MSCN") Q
 .I $P(PSBDAT,U,6)=1 S PSBSCTYP=$S($P(PSBPARAM(0),"^",5)="W":"WKEY",$P(PSBPARAM(0),"^",5)="M":"MKEY") Q
 .I $P(PSBDAT,U,6)=0 S PSBSCTYP=$S($P(PSBPARAM(0),"^",5)="W":"WUAS",$P(PSBPARAM(0),"^",5)="M":"MUAS")
 ;
FILESF ; File event.
 D VAL^PSBML(53.77,"+1,",.01,PSB7A)
 D VAL^PSBML(53.77,"+1,",.02,"`"_PSBDFN)
 D VAL^PSBML(53.77,"+1,",.03,PSB2)
 D VAL^PSBML(53.77,"+1,",.04,PSB5A)
 D VAL^PSBML(53.77,"+1,",.05,PSBSCTYP)
 D VAL^PSBML(53.77,"+1,",.06,PSB3)
 D VAL^PSBML(53.77,"+1,",.07,$S($G(XMZ)]"":"`"_XMZ,1:""))
 D VAL^PSBML(53.77,"+1,",.08,PSBXON)
 D VAL^PSBML(53.77,"+1,",.09,PSB6)
 D:$G(PSBFILE)=50
 .D VAL^PSBML(53.771,"+2,+1,",.01,"`"_PSBMEDOI)
 .D VAL^PSBML(53.771,"+2,+1,",1,PSBMEDNM)
 D:$G(PSBFILE)=52.6
 .D VAL^PSBML(53.7711,"+2,+1,",.01,"`"_PSBMEDOI)
 .D VAL^PSBML(53.7711,"+2,+1,",1,PSBMEDNM)
 D:$G(PSBFILE)=52.7
 .D VAL^PSBML(53.7712,"+2,+1,",.01,"`"_PSBMEDOI)
 .D VAL^PSBML(53.7712,"+2,+1,",1,PSBMEDNM)
 I $G(PSBFILE)="ID" D VAL^PSBML(53.77,"+1,",14,PSBOIT),VAL^PSBML(53.77,"+1,",15,PSBOITX)
 I $D(PSBSFUID) D VAL^PSBML(53.77,"+1,",13,PSBSFUID)
 I $G(PSBFILE)="ID" D VAL^PSBML(53.77,"+1,",13,$S(PSBMEDOI']"":"WS",1:PSBMEDOI))
 D UPDATE^DIE("","PSBFDA","PSBNEW1","PSBMSG")
 I $D(PSBMSG("DIERR")) S RESULTS(0)=2,RESULTS(1)="-1^MSF Filing ERROR! "_PSBMSG("DIERR","1","TEXT",1) Q
 S RESULTS(0)=1,RESULTS(1)="1^Unable to Scan documentation successful!"
 Q
 ;
CLEANMSF ;
 ;  Clean-up
 K PSBNEW1,PSB1,PSB2,PSB3,PSB4,PSB5,PSB6,PSB7,PSB8,XMZ
 Q
 ;
SCANCNT(PSBTYP) ;
 ;  Routine to count total scans (NO MAIL)
 ;  Input: PSBTYP - "WSCN"/"MSCN"/"MMME"/"MKEY"/"WKEY"  
 D CLEAN^DILF
 N PSBNEW1
 S PSBNEW1="+1"
 D VAL^PSBML(53.77,"+1,",.01,"`"_".5")
 D VAL^PSBML(53.77,"+1,",.05,PSBTYP)
 D UPDATE^DIE("","PSBFDA","PSBNEW1","PSBMSG")
 I $D(PSBNEW1(1)) S DIK="^PSB(53.77,",DA=PSBNEW1(1) D ^DIK
 I $D(PSBMSG("DIERR")) S RESULTS(0)=2,RESULTS(1)="-1^MSF Filing ERROR! "_PSBMSG("DIERR","1","TEXT",1) Q
 S RESULTS(0)=1,RESULTS(1)="1^Unable to Scan documentation successful!"
 Q
 ;
