PSOPTC0 ;AITC/PD - Patient Billing Comments;9/5/2017
 ;;7.0;OUTPATIENT PHARMACY;**482**;DEC 1997;Build 44
 ;
EN ; Menu Option Entry Point
 ;
 I '$D(^XUSEC("PSO EPHARMACY SITE MANAGER",DUZ)) W !,$C(7),"Requires Pharmacy Key (PSO EPHARMACY SITE MANAGER) !" Q
 ;
 N DIC,DTOUT,X,Y
 ;
 K PSOPTC
 ;
 ;Division selection
 I '$G(PSOSITE) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! G EXIT
 ;
 ;Patient selection
 W !!
 S DIC=2,DIC(0)="QEAM"
 D ^DIC
 G EXIT:((Y<0)!($D(DTOUT)))
 S PSOPTC("DFN")=+Y
 ;
 D EN^VALM("PSO PATIENT COMMENT")
 ;
 Q
 ;
HDR ; Header
 ;
 N DFN,H1,VA,VADM
 ;
 S DFN=$G(PSOPTC("DFN"))
 I 'DFN G EXIT
 D DEM^VADPT
 S H1=$$LJ^XLFSTR("Patient: "_$E($G(VADM(1)),1,30)_" ("_$G(VA("BID"))_")",48)
 S H1=H1_$$LJ^XLFSTR("Sex: "_$P($G(VADM(5)),U,1),8)
 S H1=H1_$$LJ^XLFSTR("DOB: "_$$FMTE^XLFDT($P($G(VADM(3)),U,1),"2Z")_" ("_$G(VADM(4))_")",22)
 ;
 S VALMHDR(1)=H1
 S VALMHDR(2)="#   STATUS  DATE/TIME                USER"
 Q
 ;
INIT ; 
 ;
 D CLEAN^VALM10
 D BUILD
 Q
 ;
BUILD ; Build ListMan Screen
 ;
 ; PSODFN = Patient Record ID
 ; PSOPC  = PATIENT COMMENT sub-file (#55.17) Record ID
 ;
 N DIWL,DIWR,PSOCNT,PSOCOM,PSOCOMMENT,PSODATA,PSODATE,PSODATE1
 N PSODFN,PSOLINE,PSOPC,PSOSTATUS,PSOSTR,PSOUSER,PSOY
 ;
 S PSOLINE=0
 S PSOCNT=0
 S PSODFN=$G(PSOPTC("DFN"))
 I 'PSODFN G EXIT
 ;
 ; Loop through the PATIENT COMMENT sub-file (#55.17) in reverse
 ; chronological order. 
 S PSODATE=""
 F  S PSODATE=$O(^PS(55,PSODFN,"PC","B",PSODATE),-1) Q:PSODATE=""  D
 . S PSOPC=$O(^PS(55,PSODFN,"PC","B",PSODATE,""))
 . K PSODATA
 . D GETS^DIQ(55.17,PSOPC_","_PSODFN_",",".01;1;2;3","E","PSODATA")
 . S PSODATE1=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",.01,"E"))
 . S PSOUSER=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",1,"E"))
 . S PSOSTATUS=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",2,"E"))
 . S PSOCOMMENT=$G(PSODATA(55.17,PSOPC_","_PSODFN_",",3,"E"))
 . S PSOCNT=PSOCNT+1
 . S PSOSTR=PSOCNT_"   "_$E(PSOSTATUS)_"       "_PSODATE1_"    "_PSOUSER
 . S PSOLINE=PSOLINE+1
 . S @VALMAR@("IDX",PSOCNT,PSOPC)=""
 . D SET^VALM10(PSOLINE,PSOSTR,"")
 . ; Use ^DIWP to format comment into lines no greater than 78 characters
 . ; with logical breaks between words.
 . K ^UTILITY($J,"W")
 . S X=PSOCOMMENT,DIWL=1,DIWR=78
 . D ^DIWP
 . F PSOY=1:1 Q:('$D(^UTILITY($J,"W",1,PSOY,0)))  D
 . . S PSOCOM=$G(^UTILITY($J,"W",1,PSOY,0))
 . . S PSOLINE=PSOLINE+1
 . . D SET^VALM10(PSOLINE,"  "_PSOCOM,"")
 . K ^UTILITY($J,"W")
 ;
 S VALMCNT=PSOLINE
 ; 
 Q
 ;
ADD ; Add Patient Comment
 ;
 N PSO55,PSOCOM
 ;
 D FULL^VALM1
 S PSOCOM=$$COMMENT("Comment: ",150)
 ; Comment not confirmed or user entered ^ to Exit
 I $L(PSOCOM)=0!(PSOCOM["^") S VALMBCK="R" Q
 S PSO55=$G(PSOPTC("DFN"))
 ; Valid comment entered - Create new multiple record
 D ADDPC(PSOCOM,PSO55)
 D INIT
 S VALMBCK="R"
 ;
 Q
 ;
 ;Enter a comment
 ;PSOTR  -prompt string
 ;PSMLEN -maxlen
 ;returns:
 ; "^" - if user chose to quit 
 ; "" - nothing entered or input has been discarded
 ; otherwise - comment's text
COMMENT(PSOTR,PSMLEN) ;*/
 N DIR,DTOUT,DUOUT,PSQ
 I '$D(PSOTR) S PSOTR="Comment "
 I '$D(PSMLEN) S PSMLEN=150
 S DIR(0)="FA^1:150"
 S DIR("A")=PSOTR
 S DIR("?")="Enter a free text comment up to 150 characters long."
 S PSQ=0
 F  D  Q:+PSQ'=0
 . W ! D ^DIR
 . I $D(DUOUT)!($D(DTOUT)) S PSQ=-1 Q
 . I $L(Y)'>PSMLEN S PSQ=1 Q
 . W !!,"Enter a free text comment up to 150 characters long.",!
 . S DIR("B")=$E(Y,1,PSMLEN)
 Q:PSQ<0 "^"
 Q:$L(Y)=0 ""
 S PSQ=$$YESNO^PSOREJP3("Are you sure Y/N")
 I PSQ=-1 Q "^"
 I PSQ=0 Q ""
 Q Y
 ; 
 ;
ADDPC(PSOCOM,PSO55) ; Add new multiple record for Patient Comment
 ;
 N PSO200,PSOAR,PSOFILE,PSOIEN,PSONOW,PSOPC
 ;
 ; Create the Patient Comment multiple
 S PSOFILE=55.17
 D NOW^%DTC
 S PSONOW=%
 S PSOAR(1,PSOFILE,"+1,"_PSO55_",",.01)=PSONOW
 D UPDATE^DIE("","PSOAR(1)") K PSOAR
 ;
 ; Populate the data into the Patient Comment multiple
 S PSO200=DUZ
 S PSOPC=$O(^PS(55,PSO55,"PC","B",PSONOW,""))
 S PSOIEN=PSOPC_","_PSO55_","
 S PSOAR(PSOFILE,PSOIEN,1)=PSO200
 S PSOAR(PSOFILE,PSOIEN,2)="Y"
 S PSOAR(PSOFILE,PSOIEN,3)=PSOCOM
 D FILE^DIE(,"PSOAR") K PSOAR
 ;
 ; Add Patient Comment History
 D ADDPCH(PSO55,PSOPC,PSONOW,1)
 ;
 Q
 ;
ADDPCH(PSO55,PSOPC,PSONOW,PSOACT) ; Add new multiple record for Patient Comment History
 ;
 N PSO200,PSOAR,PSOFILE,PSOIEN,PSOPCH
 ;
 ; Create the Patient Comment History multiple
 S PSOFILE=55.174
 S PSO200=DUZ
 S PSOAR(1,PSOFILE,"+1,"_PSOPC_","_PSO55_",",.01)=PSONOW
 D UPDATE^DIE("","PSOAR(1)")
 K PSOAR
 ;
 ; Populate the data into the Patient Comment History multiple
 S PSOPCH=$O(^PS(55,PSO55,"PC",PSOPC,"PCH","B",PSONOW,""))
 S PSOIEN=PSOPCH_","_PSOPC_","_PSO55_","
 S PSOAR(PSOFILE,PSOIEN,1)=PSO200
 S PSOAR(PSOFILE,PSOIEN,2)=PSOACT
 D FILE^DIE(,"PSOAR") K PSOAR
 ;
 Q
 ;
ACT ; Activate / Inactivate Patient Comment
 ;
 ; ACT serves as a toggle for Activating and Inactivating comments.
 ; Upon selection of this action, the user will be prompted for 
 ; the line to Activate/Inactivate. The comment will be redisplayed 
 ; to the user. A confirmation prompt will appear. Upon confirmation,
 ; the value will be updated and the display refreshed.
 ; If the user confirmed to change the status of the comment, a history
 ; record will be filed.
 ; 
 N DIWL,DIWR,PSO55,PSOACT,PSOACT1,PSOAR,PSOCOM,PSODATA,PSOFILE
 N PSOLINE,PSOIEN,PSONOW,PSONOWH,PSOPC,PSOY,PSOYESNO
 ;
 ; Get record id (#55.17) for selected entry
 S PSOPC=$$SELECT(.PSOLINE)
 ;
 I PSOPC="^" S VALMBCK="R" Q
 ;
 S PSOFILE=55.17
 S PSO55=PSOPTC("DFN")
 K PSODATA
 S PSOIEN=PSOPC_","_PSO55_","
 D GETS^DIQ(55.17,PSOIEN,".01;2;3","I","PSODATA")
 S PSONOW=$G(PSODATA(55.17,PSOIEN,.01,"I"))
 S PSOACT="Activate"
 S PSOACT1=$G(PSODATA(55.17,PSOIEN,2,"I"))
 I PSOACT1="Y" S PSOACT="Inactivate"
 W !,PSOACT_" Comment # "_PSOLINE_":"
 I $L($G(PSODATA(55.17,PSOIEN,3,"I")))>78 D
 . K ^UTILITY($J,"W")
 . S X=PSODATA(55.17,PSOIEN,3,"I"),DIWL=1,DIWR=78
 . D ^DIWP
 . F PSOY=1:1 Q:('$D(^UTILITY($J,"W",1,PSOY,0)))  D
 . . S PSOCOM=$G(^UTILITY($J,"W",1,PSOY,0))
 . . W !,"  "_PSOCOM
 . K ^UTILITY($J,"W")
 E  W !,"  "_PSODATA(55.17,PSOIEN,3,"I")
 ;
 S PSOYESNO=$$YESNO^PSOREJP3("Are you sure Y/N")
 I PSOYESNO=-1 G ACTX
 ;
 I PSOYESNO=1 D
 . S PSOAR(PSOFILE,PSOIEN,2)="N"
 . I PSOACT1="N" S PSOAR(PSOFILE,PSOIEN,2)="Y"
 . D FILE^DIE(,"PSOAR") K PSOAR
 . ;
 . ; Add Patient Comment History
 . D NOW^%DTC
 . S PSONOWH=%
 . I PSOACT1="Y" D ADDPCH(PSO55,PSOPC,PSONOWH,3)
 . I PSOACT1="N" D ADDPCH(PSO55,PSOPC,PSONOWH,2)
 ;
ACTX ; 
 ;
 D INIT
 S VALMBCK="R"
 ;
 Q
 ;
HIST ; Patient Comment History
 ;
 ; HIST provides a historical view of any Patient Comment.
 ; The user will be prompted to select a Patient Comment. The
 ; comment will be redisplayed to the user. A listing of the
 ; comment's history will display in reverse chronological order. 
 ; The values in this listing will include ADD, ACTIVATE and
 ; INACTIVATE. The date/time and user for each historical
 ; update will display.
 ;
 N DIWL,DIWR,PSO55,PSOCOM,PSODATA,PSOIEN,PSOLINE
 N PSONOW,PSOPC,PSOPCH,PSOY
 ;
 S PSOPC=$$SELECT(.PSOLINE)
 ;
 I PSOPC="^" S VALMBCK="R" Q
 ;
 S PSO55=PSOPTC("DFN")
 ;
 W !
 S PSOIEN=PSOPC_","_PSO55_","
 K PSODATA
 D GETS^DIQ(55.17,PSOIEN,".01;2;3","I","PSODATA")
 I $L($G(PSODATA(55.17,PSOIEN,3,"I")))>78 D
 . K ^UTILITY($J,"W")
 . S X=PSODATA(55.17,PSOIEN,3,"I"),DIWL=1,DIWR=78
 . D ^DIWP
 . F PSOY=1:1 Q:('$D(^UTILITY($J,"W",1,PSOY,0)))  D
 . . S PSOCOM=$G(^UTILITY($J,"W",1,PSOY,0))
 . . W !," "_PSOCOM
 . K ^UTILITY($J,"W")
 E  W !," "_PSODATA(55.17,PSOIEN,3,"I")
 W !
 ;
 S PSONOW=""
 F  S PSONOW=$O(^PS(55,PSO55,"PC",PSOPC,"PCH","B",PSONOW),-1) Q:PSONOW=""  D
 . S PSOPCH=""
 . S PSOPCH=$O(^PS(55,PSO55,"PC",PSOPC,"PCH","B",PSONOW,PSOPCH))
 . S PSOIEN=PSOPCH_","_PSOPC_","_PSO55_","
 . K PSODATA
 . D GETS^DIQ(55.174,PSOIEN,".01;1;2","E","PSODATA")
 . W !,$G(PSODATA(55.174,PSOIEN,2,"E"))
 . W ?15,$G(PSODATA(55.174,PSOIEN,.01,"E"))
 . W ?45,$G(PSODATA(55.174,PSOIEN,1,"E"))
 ;
 D WAIT^VALM1
 ;
 D INIT
 S VALMBCK="R"
 ;
 Q
 ;
SELECT(PSOLINE) ; Select Line from List View
 ;
 N DIR,DIRUT,PSOMAX,Y
 ;
 D FULL^VALM1
 ;
 I '$D(^TMP("PSOPTC0",$J)) D  Q "^"
 . W !!,"No Patient Comments available for selection."
 . D WAIT^VALM1
 ;
 S PSOMAX=$O(^TMP("PSOPTC0",$J,"IDX",""),-1)
 ;
 I PSOMAX=1 S PSOLINE=1 Q $O(^TMP("PSOPTC0",$J,"IDX",PSOLINE,""))
 ;
 W !
 S DIR(0)="N^1:"_PSOMAX
 S DIR("A")="Line"
 I PSOMAX=1 S DIR("B")=PSOMAX
 D ^DIR
 ;
 I $D(DIRUT) Q "^"
 S PSOLINE=Y
 ;
 Q $O(^TMP("PSOPTC0",$J,"IDX",PSOLINE,""))
 ;
HELP ;
 ;
 Q
 ;
EXIT ;
 ;
 K ^TMP("PSOPTC0",$J),PSOPTC
 Q
